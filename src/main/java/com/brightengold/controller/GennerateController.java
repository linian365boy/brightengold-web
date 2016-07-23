package com.brightengold.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.rainier.nian.utils.FileUtil;
import cn.rainier.nian.utils.PageRainier;

import com.brightengold.model.Advertisement;
import com.brightengold.model.Category;
import com.brightengold.model.Column;
import com.brightengold.model.Company;
import com.brightengold.model.Info;
import com.brightengold.model.News;
import com.brightengold.model.Product;
import com.brightengold.service.AdvertisementService;
import com.brightengold.service.CategoryService;
import com.brightengold.service.ColumnService;
import com.brightengold.service.CompanyService;
import com.brightengold.service.InfoService;
import com.brightengold.service.MsgUtil;
import com.brightengold.service.NewsService;
import com.brightengold.service.ProductService;
import com.brightengold.service.SystemConfig;
import com.brightengold.util.FreemarkerUtil;

@Controller
@RequestMapping("/admin/sys/html")
@Scope("prototype")
public class GennerateController {
	private Logger logger = LoggerFactory.getLogger(GennerateController.class);
	@Autowired
	private ColumnService columnService;
	@Autowired
	private AdvertisementService advertisementService;
	@Autowired
	private CompanyService companyService;
	@Resource
	private SystemConfig systemConfig;
	@Resource
	private NewsService newsService;
	@Resource
	private ProductService productService;
	@Resource
	private CategoryService categoryService;
	@Resource
	private InfoService infoService;
	
	private Integer pageSize = 16;
	private Integer pageNo = 1;
	
	@RequestMapping(value={"/generate"},method=RequestMethod.GET)
	public String toGennerateHtml(ModelMap map){
		//return "admin/sys/html/preGenerate";
		map.put("style", 0);
		return "admin/sys/html/generate";
	}
	
	@RequestMapping(value={"/doGenerate"},method=RequestMethod.GET)
	public String doGenerateHtml(int style,ModelMap map){
		map.put("style", style);
		return "admin/sys/html/generate";
	}
	
	@ResponseBody
	@RequestMapping(value={"/generateAll"},method=RequestMethod.POST)
	public String generateAll(int style,ModelMap map,HttpServletRequest request){
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+
				request.getServerPort()+request.getContextPath();
		String path = request.getSession().getServletContext().getRealPath("/");
		String style_v = (String) request.getSession().getAttribute("style_v");
		String templateName = "columnTemplate.ftl";
		Column parentCol = null;
		gennerateCommon(map);
		map.put("ctx", basePath);
		map.put("style_v", style_v);
		//１　生成首页
		FreemarkerUtil.fprint("index.ftl", map, path+File.separator, "index.htm");
		//２　获取所有的栏目code
		List<Column> columnList = columnService.findList();
		for(Column col : columnList){
			//当前栏目
			parentCol = col.getParentColumn()==null?col:col.getParentColumn();
			map.put("parentCol", parentCol);
			map.put("column", col);
			publishAllProductsByStyle(request,col,map);
			FreemarkerUtil.fprint(templateName, map, 
					path+File.separator+"views"+File.separator+"html"+
							File.separator+"col"+File.separator, col.getCode()+".htm");
		}
		//３　获取所有分类的英文名称
		List<Category> cateList = categoryService.findList();
		for(Category cate : cateList){
			gennerateCommon(map);
			map.put("ctx", basePath);
			map.put("style_v", style_v);
			map.put("category", cate);
			FreemarkerUtil.fprint("categoryTemplate.ftl", map, 
					path+File.separator+"views"+File.separator+"html"+
							File.separator+"col"+File.separator, cate.getEnName().replaceAll("\\s*", "")+".htm");
		}
		//４　获取所有info　page code
		List<Info> infoList = infoService.findList();
		for(Info info : infoList){
			gennerateCommon(map);
			map.put("ctx", basePath);
			map.put("style_v", style_v);
			map.put("model", info);
			FreemarkerUtil.fprint("info.ftl", map, path+File.separator+"views"+
					File.separator+"html"+File.separator+"info"+
					File.separator,info.getCode()+".htm");
		}
		return "200";
	}
	
	@ResponseBody
	@RequestMapping(value={"/{code}/generate",""},method=RequestMethod.POST)
	public String gennerateHtml(@PathVariable String code,int style,ModelMap map,
			HttpServletRequest request){
		//检查code是否存在
		long count = 0;
		if("index".equals(code) || "home".equals(code)){
			count = 1;
		}else{
			count = columnService.countColumnByCode(code);
		}
		if(style==0){
			//风格0生成
			//按栏目代码查询
			if(count>0){
				String basePath = request.getScheme()+"://"+request.getServerName()+":"+
						request.getServerPort()+request.getContextPath();
				String path = request.getSession().getServletContext().getRealPath("/");
				String style_v = (String) request.getSession().getAttribute("style_v");
				Column col = null;
				String templateName = "columnTemplate.ftl";
				Column parentCol = null;
				gennerateCommon(map);
				map.put("ctx", basePath);
				map.put("style_v", style_v);
				try{
					if("index".equals(code) || "home".equals(code)){
						//生成首页的热销产品
						//首页产品
						List<Product> products = productService.findIndexPic(systemConfig.getIndexProductSize());
						map.put("hotProducts", products);
						if(!FreemarkerUtil.fprint("index.ftl", map, path+File.separator, "index.htm")){
							logger.error("生成"+code+"页面失败！");
							return "500";
						}
					}else{
						//当前栏目
						col = columnService.loadColumnByCode(code);
						parentCol = col.getParentColumn()==null?col:col.getParentColumn();
						map.put("parentCol", parentCol);
						map.put("column", col);
						publishAllNews(request,col,map);
						//PageRainier<News> page = newsService.findAllByColId(1, pageSize, col.getId(),col.getDepth()); //得到所有的新闻
						//map.put("newsPage", page);
						if(col.getType()){
							templateName = "productTemplate.ftl";
						}
						//查找是否有相同code的Info，一起生成，填充column的内容页面
						Info info = infoService.loadOneByCode(code);
						if(info!=null){
							map.put("info", info);
						}
						if(!FreemarkerUtil.fprint(templateName, map, 
								path+File.separator+"views"+File.separator+"html"+
										File.separator+"col"+File.separator, code+".htm")){
							logger.error("生成"+code+"页面失败！");
							return "500";
						}
					}
				}catch(Exception e){
					logger.error("生成"+code+"页面失败！",e);
					return "500";
				}
				return "200";
			}else{
				//按分类英文名称查询是否有记录
				Category cate = categoryService.loadCategoryByEname(code);
				String basePath = request.getScheme()+"://"+request.getServerName()+":"+
						request.getServerPort()+request.getContextPath();
				String style_v = (String) request.getSession().getAttribute("style_v");
				String path = request.getSession().getServletContext().getRealPath("/");
				if(cate!=null){
					//productService.findAllByCateId(pageNo, pageSize, cate.getId());
					//Column col = null;
					//Column parentCol = null;
					map.put("style_v", style_v);
					gennerateCommon(map);
					map.put("ctx", basePath);
					//map.put("parentCol", parentCol);
					map.put("category", cate);
					map.put("column", cate.getColumn());
					publishAllProducts(request,cate,map);
					if(!FreemarkerUtil.fprint("categoryTemplate.ftl", map, 
							path+File.separator+"views"+File.separator+"html"+
									File.separator+"col"+File.separator, code.replaceAll("\\s*", "")+".htm")){
						logger.error("生成"+code+"页面失败！");
						return "500";
					}
					return "200";
				}else{
					Info info = infoService.loadOneByCode(code);
					if(info!=null){
						gennerateCommon(map);
						map.put("ctx", basePath);
						map.put("style_v", style_v);
						map.put("model", info);
						if(!FreemarkerUtil.fprint("info.ftl", map, path+File.separator+"views"+
								File.separator+"html"+File.separator+"info"+
								File.separator,info.getCode()+".htm")){
							logger.error("生成"+code+"页面失败！");
							return "500";
						}
						return "200";
					}
					return "501";
				}
			}
		}else{
			//按风格2生成页面
			if(count>0){
				String basePath = request.getScheme()+"://"+request.getServerName()+":"+
						request.getServerPort()+request.getContextPath();
				String path = request.getSession().getServletContext().getRealPath("/");
				String style_v = (String) request.getSession().getAttribute("style_v");
				String templateName = "columnTemplate.ftl";
				Column col = null;
				Column parentCol = null;
				gennerateCommon(map);
				map.put("ctx", basePath);
				map.put("style_v", style_v);
				if("index".equals(code) || "home".equals(code)){
					FreemarkerUtil.fprint("index.ftl", map, path+File.separator, "index.htm");
				}else{
					//当前栏目
					col = columnService.loadColumnByCode(code);
					parentCol = col.getParentColumn()==null?col:col.getParentColumn();
					map.put("parentCol", parentCol);
					map.put("column", col);
					publishAllProductsByStyle(request,col,map);
					FreemarkerUtil.fprint(templateName, map, 
							path+File.separator+"views"+File.separator+"html"+
									File.separator+"col"+File.separator, code+".htm");
				}
			}else{
				//按分类英文名称查询是否有记录
				Category cate = categoryService.loadCategoryByEname(code);
				String basePath = request.getScheme()+"://"+request.getServerName()+":"+
						request.getServerPort()+request.getContextPath();
				String path = request.getSession().getServletContext().getRealPath("/");
				String style_v = (String) request.getSession().getAttribute("style_v");
				if(cate!=null){
					gennerateCommon(map);
					map.put("ctx", basePath);
					map.put("style_v", style_v);
					map.put("category", cate);
					FreemarkerUtil.fprint("categoryTemplate.ftl", map, 
							path+File.separator+"views"+File.separator+"html"+
									File.separator+"col"+File.separator, code.replaceAll("\\s*", "")+".htm");
					return "200";
				}
				return "501";
			}
			return "200";
		}
	}
	
	private void publishAllProductsByStyle(HttpServletRequest request,
			Column col, ModelMap map) {
		List<Category> cates = categoryService.findCateByColId(col.getId());
		//String fPath = null;
		for(Category cate : cates){
			 List<Product> productList = productService.findAllListByCateId(cate.getId());;
			 //得到该栏目下所有的产品
			 //批量修改product;
			 List<Product> tempProductList = new ArrayList<Product>();
			 String path = request.getSession().getServletContext().getRealPath("/");
			 String parentPath = path + File.separator+"views"+File.separator+"html"+
				 		File.separator+"product"+File.separator+
			 			cate.getId()+File.separator;
			 for(Product product : productList){
				 if(product.isPublish()){
					 //fPath = path +File.separator+"views"+File.separator+"html"+File.separator+"product"+
					//		 	File.separator+cate.getId()+File.separator+product.getPageNum()+
					//		 		File.separator+product.getUrl();
					 FileUtil.delFile(parentPath+product.getUrl());
				 }
				 product.setPublish(true);
				 map.put("model", product);
				 map.put("parentCol", ((Column)map.get("column")).getParentColumn());
				 map.put("relateProducts", productList);
				 FreemarkerUtil.fprint("product.ftl", map, parentPath,product.getUrl());
				 tempProductList.add(product);
			 }
			 if(tempProductList.size()>0){
				 productService.insertOfBatch(tempProductList);
			 }
			 //pMap.put(cate, productList);
		}
		map.put("cates", cates);
	}
	
	private void publishAllProducts(HttpServletRequest request, Category cate,
			ModelMap map) {
		 int totalPageNum = Math.max(1, (int) Math.ceil(1.0 * 
				 productService.countByCateId((cate.getId())/this.pageSize)));
		 PageRainier<Product> page = null;
		 String path = request.getSession().getServletContext().getRealPath("/");
		 String parentPath = "";
		 List<Product> productList = null;
		 String fPath = null;
		 List<Product> tempProductList = new ArrayList<Product>();
		 for(int i=0;i<totalPageNum;i++){
			 //得到该栏目下所有的产品
			 page = productService.findAllByCateId((i+1), pageSize, cate.getId()); 
			 map.put("productPage", page);
			 parentPath = path + File.separator+"views"+File.separator+"html"+
				 		File.separator+"product"+File.separator+
				 			cate.getId()+File.separator;
			 //列表的页面生成
			 FreemarkerUtil.fprint("categoryProductList.ftl", map, parentPath,(i+1)+".htm");
			 //map.clear();
			 productList = page.getResult();
			 for(Product product:productList){
				 if(product.isPublish()){
					 //fPath = path +File.separator+"views"+File.separator+"html"+File.separator+"product"+
					//		 	File.separator+cate.getId()+File.separator+product.getPageNum()+
					//		 		File.separator+product.getUrl();
					 fPath = parentPath+(i+1)+File.separator+product.getUrl();
					 FileUtil.delFile(fPath);
				 }
				 product.setPublish(true);
				 map.put("model", product);
				 map.put("parentCol", ((Column)map.get("column")).getParentColumn());
				 //查找相关连产品，根据keyWords
				 List<Product> products = 
						 productService.findRelatedProducts(product.getId(),product.getKeyWords(),8);
				 if(!CollectionUtils.isEmpty(products)){
					 map.put("relatedProducts", products);
				 }
				 parentPath = parentPath+(i+1)+File.separator;
				 product.setPageNum(i+1);
				 FreemarkerUtil.fprint("product.ftl", map, parentPath,product.getUrl());
				 parentPath = path + File.separator+"views"+File.separator+"html"+
						 		File.separator+"product"+File.separator+cate.getId()+File.separator;
				 tempProductList.add(product);
			}
		 }
		 //批量修改product;
		 productService.insertOfBatch(tempProductList);
	}

	//发布某栏目下所有的新闻
	private void publishAllNews(HttpServletRequest request, Column col, ModelMap modelMap){
		 Map<String,Object> map = new HashMap<String,Object>();
		 //false　文章标题列表的页面
		 //true　产品展示的页面
		 if(col.getType()){
			 int totalPageNum = Math.max(1, (int) Math.ceil(1.0 * 
					 productService.countByColId(col.getId())/this.pageSize));
			 PageRainier<Product> page = null;
			 String path = request.getSession().getServletContext().getRealPath("/");
			 String parentPath = "";
			 List<Product> productList = null;
			 String fPath = null;
			 List<Product> tempProductList = new ArrayList<Product>();
			 for(int i=0;i<totalPageNum;i++){
				 //page = productService.findAllByColId((i+1), pageSize, col.getId()); //得到该栏目下所有的产品
				 page = productService.findPageByColId((i+1), pageSize, col.getId()); //分页得到该栏目下所有的产品
				 map.put("productPage", page);
				 parentPath = path + File.separator+"views"+File.separator+"html"+
					 		File.separator+"product"+File.separator+
					 			col.getCode()+File.separator;
				 //列表的页面生成
				 map.put("ctx", modelMap.get("ctx"));
				 map.put("column", col);
				 if(!FreemarkerUtil.fprint("productList.ftl", map, parentPath,(i+1)+".htm")){
					 logger.error("生成产品列表页面失败");
				 }
				 map.clear();
				 productList = page.getResult();
				 map.put("ctx", modelMap.get("ctx"));
				 map.put("style_v", modelMap.get("style_v"));
				 map.put("crossCol", modelMap.get("crossCol"));
				 map.put("indexAds", modelMap.get("indexAds"));
				 map.put("company", modelMap.get("company"));
				 map.put("parentCol", modelMap.get("parentCol"));
				 map.put("column", col);
				 map.put("categorys", modelMap.get("categorys"));
				 map.put("indexNews", modelMap.get("indexNews"));
				 for(Product product:productList){
					 if(product.isPublish()){
						 fPath = path +File.separator+"views"+File.separator+"html"+File.separator+"product"+
								 	File.separator+col.getCode()+File.separator+product.getPageNum()+
								 		File.separator+product.getUrl();
						 FileUtil.delFile(fPath);
					 }
					 product.setPublish(true);
					 map.put("model", product);
					 map.put("category", product.getCategory());
					 parentPath = parentPath+(i+1)+File.separator;
					 product.setPageNum(i+1);
					 //product只要生成一个静态页面
					 //TODO
					 //查找相关连产品，根据keyWords
					 List<Product> products = 
							 productService.findRelatedProducts(product.getId(),product.getKeyWords(),8);
					 if(!CollectionUtils.isEmpty(products)){
						 map.put("relatedProducts", products);
					 }
					 if(!FreemarkerUtil.fprint("product.ftl", map, parentPath,product.getUrl())){
						 logger.error("生成产品页面失败");
					 }
					 parentPath = path + File.separator+"views"+File.separator+"html"+
							 		File.separator+"product"+File.separator+col.getCode()+File.separator;
					 tempProductList.add(product);
				}
			 }
			 //批量修改product;
			 productService.insertOfBatch(tempProductList);
		 }else{
			 //查询最大页数
			 int totalPageNum = Math.max(1, (int) Math.ceil(1.0 * 
					 newsService.countByColId(col.getId(),col.getDepth())/this.pageSize));
			 PageRainier<News> page = null;
			 String path = request.getSession().getServletContext().getRealPath("/");
			 String parentPath = "";
			 List<News> newsList = null;
			 String fPath = null;
			 List<News> tempNewsList = new ArrayList<News>();
			 for(int i=0;i<totalPageNum;i++){
				 //if(1==col.getType()){
					 //文章标题列表
					 page = newsService.findAllByColId((i+1), pageSize, col.getId(),col.getDepth()); //得到所有的新闻
					 map.put("newsPage", page);
				 //}else{
					 //文章内容列表
					 //JPA 不够灵活
				 //	 page = newsService.findAllByColId((i+1), pageSize, col.getId(),col.getDepth()); //得到所有的新闻
				 //	 map.put("newsPage", page);
				 // }
				 parentPath = path + File.separator+"views"+File.separator+"html"+
						 		File.separator+"news"+File.separator+
						 			col.getCode()+File.separator;
				 //列表的页面生成
				 map.put("ctx", request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath());
				 map.put("column", col);
				 FreemarkerUtil.fprint("list.ftl", map, parentPath,(i+1)+".htm");
				 map.clear();
				 newsList = page.getResult();
				 for(News news:newsList){
					 map.put("ctx", request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath());
					 if(news.getPublishDate()!=null){
						 fPath = path +File.separator+"views"+File.separator+"html"+File.separator+"news"+
								 	File.separator+col.getCode()+File.separator+news.getPageNum()+
								 		File.separator+news.getUrl();
						 FileUtil.delFile(fPath);
					 }
					 news.setPublishDate(news.getPublishDate());
					 map.put("model", news);
					 parentPath = parentPath+(i+1)+File.separator;
					 news.setPageNum(i+1);
					//news只要生成一个静态页面
					 //TODO
					 FreemarkerUtil.fprint("detail.ftl", map, parentPath,news.getUrl());
					 parentPath = path + File.separator+"views"+File.separator+"html"+
							 		File.separator+"news"+File.separator+col.getCode()+File.separator;
					 tempNewsList.add(news);
				}
			 }
			//批量修改news;
			 newsService.insertOfBatch(tempNewsList);
		 }
	}
	
	protected void gennerateCommon(ModelMap map){
		//首页广告
		List<Advertisement> ads= advertisementService.getIndexAds(systemConfig.getIndexAdsSize());
		map.put("indexAds", ads);
		//横条菜单，最深显示到二级菜单
		List<Column> crossCol = columnService.findColumnsByDepth(systemConfig.getCrossMaxDepth());
		map.put("crossCol", crossCol);
		//首页侧边栏目，最深显示到三级菜单
		//List<Column> verticalCol= columnService.findColumnsByDepth(systemConfig.getVerticalMaxDepth());
		//map.put("verticalCol", verticalCol);
		//首页新闻
		List<News> news = newsService.findIndexPic(systemConfig.getIndexNewsSize());
		map.put("indexNews", news);
		List<Category> categorysList = categoryService.findList();
		map.put("categorys", categorysList);
 		//企业信息
		Company company = companyService.loadCompany();
		map.put("company", company);
		//info信息
		List<Info> infos = infoService.getList();
		map.put("infos", infos);
	}
	
	@RequestMapping(value="/index",method=RequestMethod.GET)
	public String gennerateIndex(HttpServletRequest request){
		try{
			String basePath = request.getScheme()+"://"+request.getServerName()+":"+
					request.getServerPort()+request.getContextPath();
			String path = request.getSession().getServletContext().getRealPath("/");
			Map<String,Object> root = new HashMap<String,Object>();
			root.put("ctx", basePath);
			FreemarkerUtil.fprint("index.ftl", root, path+File.separator, "index.htm");
			MsgUtil.setMsg("success", "恭喜您，生成首页成功！");
			logger.info("生成首页成功！");
		}catch(Exception e){
			MsgUtil.setMsg("error", "对不起，生成首页失败！");
			logger.error("生成页面发生错误：{}",new Object[]{e});
		}
		return "redirect:/admin/sys/html/generate.html";
	}
	
	@RequestMapping(value="/gennerateHtml",method=RequestMethod.GET)
	public String gennerate(){
		return "index";
	}
	
	public Integer getPageSize() {
		return pageSize;
	}

	public Integer getPageNo() {
		return pageNo;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public void setPageNo(Integer pageNo) {
		this.pageNo = pageNo;
	}
}
