package com.brightengold.controller;

import java.io.File;
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

import com.brightengold.model.Advertisement;
import com.brightengold.model.Category;
import com.brightengold.model.Column;
import com.brightengold.model.Company;
import com.brightengold.model.Info;
import com.brightengold.model.News;
import com.brightengold.model.Product;
import com.brightengold.model.WebConfig;
import com.brightengold.service.AdvertisementService;
import com.brightengold.service.CategoryService;
import com.brightengold.service.ColumnService;
import com.brightengold.service.CompanyService;
import com.brightengold.service.InfoService;
import com.brightengold.service.MsgUtil;
import com.brightengold.service.NewsService;
import com.brightengold.service.ProductService;
import com.brightengold.service.SystemConfig;
import com.brightengold.service.WebConfigService;
import com.brightengold.util.Constant;
import com.brightengold.util.FreemarkerUtil;
import com.brightengold.util.HtmlStringUtil;
import com.google.common.collect.Maps;

import cn.rainier.nian.utils.PageRainier;

@Controller
@RequestMapping("/admin/sys/html")
@Scope("prototype")
public class GennerateController {
	private static final Logger logger = LoggerFactory.getLogger(GennerateController.class);
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
	@Resource
	private WebConfigService configService;
	
	private Integer pageSize = 16;
	private Integer pageNo = 1;
	
	@RequestMapping(value={"/generate"},method=RequestMethod.GET)
	public String toGennerateHtml(ModelMap map){
		return "admin/sys/html/generate";
	}
	
	@RequestMapping(value={"/doGenerate"},method=RequestMethod.GET)
	public String doGenerateHtml(int style,ModelMap map){
		map.put("style", style);
		return "admin/sys/html/generate";
	}
	
	@ResponseBody
	@RequestMapping(value={"/generateAll"},method=RequestMethod.POST)
	public String generateAll(ModelMap map, HttpServletRequest request){
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+
				request.getServerPort()+request.getContextPath();
		String path = request.getSession().getServletContext().getRealPath("/");
		String style_v = (String) request.getSession().getAttribute("style_v");
		String templateName = "columnTemplate.ftl";
		Column parentCol = null;
		gennerateCommon(map);
		map.put("ctx", basePath);
		map.put("style_v", style_v);
		//1　生成首页
		List<Product> products = productService.findIndexPic(systemConfig.getIndexProductSize());
		map.put("hotProducts", products);
		if(!FreemarkerUtil.fprint("index.ftl", map, path+File.separator, "index.htm")){
			logger.error("生成index页面失败。");
		}else{
			logger.info("生成index产品页面成功");
		}
		//2　获取所有的正常的可发布的栏目code
		List<Column> columnList = columnService.findList();
		for(Column col : columnList){
			//当前栏目
			parentCol = col.getParentColumn()==null?col:col.getParentColumn();
			map.put("parentCol", parentCol);
			map.put("column", col);
			if(1==col.getType() || 2==col.getType()){
				publishAllNews(request, col, map);
				templateName = "productTemplate.ftl";
			}else{
				templateName = "columnTemplate.ftl";
				//查找是否有相同code的Info，一起生成，填充column的内容页面
				Info info = infoService.loadOneByCode(col.getCode());
				if(info!=null){
					map.put("info", info);
				}
			}
			if(!FreemarkerUtil.fprint(templateName, map, 
					path+Constant.COLUMNPATHPRE, col.getCode()+".htm")){
				logger.error("生成{}产品页面失败",col.getEnName());
			}else{
				logger.info("生成{}产品页面成功",col.getEnName());
				//避免覆盖，删除map中已存在的值
				map.remove("info");
			}
		}
		//3　获取所有分类的英文名称
		List<Category> cateList = categoryService.findList();
		for(Category cate : cateList){
			map.put("category", cate);
			map.put("column", cate.getColumn());
			publishAllProducts(request,cate,map);
			if(!FreemarkerUtil.fprint("categoryTemplate.ftl", map, 
					path+Constant.CATEGORYPRODUCTPATH, cate.getEnName().replaceAll("\\s*", "")+".htm")){
				logger.error("生成{}分类页面失败",cate.getEnName());
			}else{
				logger.info("生成{}分类页面成功",cate.getEnName());
			}
		}
		return "200";
	}
	
	@ResponseBody
	@RequestMapping(value={"/{code}/generate",""},method=RequestMethod.POST)
	public String gennerateHtml(@PathVariable String code,ModelMap map, HttpServletRequest request){
		//检查code是否存在
		long count = 0;
		if("index".equals(code) || "home".equals(code)){
			count = 1;
		}else{
			count = columnService.countColumnByCode(code);
		}
		String style_v = (String) request.getSession().getAttribute("style_v");
		String path = request.getSession().getServletContext().getRealPath("/");
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+
				request.getServerPort()+request.getContextPath();
		map.put("ctx", basePath);
		map.put("style_v", style_v);
		//按栏目代码查询
		if(count>0){
			Column col = null;
			String templateName = "columnTemplate.ftl";
			Column parentCol = null;
			gennerateCommon(map);
			try{
				if("index".equals(code) || "home".equals(code)){
					//生成首页的热销产品
					//首页产品
					List<Product> products = productService.findIndexPic(systemConfig.getIndexProductSize());
					map.put("hotProducts", products);
					if(!FreemarkerUtil.fprint("index.ftl", map, path+File.separator, "index.htm")){
						logger.error("生成{}页面失败！",code);
						return "500";
					}else{
						logger.info("生成{}页面成功！",code);
					}
				}else{
					//当前栏目
					col = columnService.loadColumnByCode(code);
					parentCol = col.getParentColumn()==null?col:col.getParentColumn();
					map.put("parentCol", parentCol);
					map.put("column", col);
					if(1==col.getType() || 2==col.getType()){
						publishAllNews(request,col,map);
						templateName = "productTemplate.ftl";
					}else{
						//查找是否有相同code的Info，一起生成，填充column的内容页面
						Info info = infoService.loadOneByCode(code);
						if(info!=null){
							map.put("info", info);
						}
					}
					if(!FreemarkerUtil.fprint(templateName, map, 
							path+Constant.COLUMNPATHPRE, code+".htm")){
						logger.error("生成{}页面失败！",code);
						return "500";
					}else{
						logger.info("生成{}页面成功！",code);
					}
				}
			}catch(Exception e){
				logger.error("生成{}页面失败！",code,e);
				return "500";
			}
			return "200";
		}else{
			//按分类英文名称查询是否有记录
			Category cate = categoryService.loadCategoryByEname(code);
			if(cate!=null){
				gennerateCommon(map);
				map.put("category", cate);
				map.put("column", cate.getColumn());
				publishAllProducts(request,cate,map);
				if(!FreemarkerUtil.fprint("categoryTemplate.ftl", map, 
						path+Constant.CATEGORYPRODUCTPATH, 
						cate.getEnName().replaceAll("\\s*", "")+".htm")){
					logger.error("生成{}页面失败！",code);
					return "500";
				}else{
					logger.info("生成{}页面成功",code);
				}
				return "200";
			}
			return "501";
		}
	}
	
	private void publishAllProducts(HttpServletRequest request, Category cate,
			ModelMap modelMap) {
		 Map<String,Object> map = Maps.newHashMap(modelMap);
		 long count = productService.countByCateId((cate.getId()));
		 logger.info("分类Name|{}下共有{}个产品是已发布并且状态正常的.",cate.getName(),count);
		 int totalPageNum = Math.max(1, (int) Math.ceil(1.0 * count/this.pageSize));
		 PageRainier<Product> page = null;
		 String path = request.getSession().getServletContext().getRealPath("/");
		 String parentPath = "";
		 for(int i=0;i<totalPageNum;i++){
			 //得到该栏目下所有的产品
			 page = productService.findAllByCateId((i+1), pageSize, cate.getId()); 
			 logger.info("第{}页下共有{}个产品是已发布并且状态正常的.",(i+1),page.getResult().size());
			 map.put("productPage", page);
			 parentPath = path + Constant.CATEPRE ;
			 //列表的页面生成
			 FreemarkerUtil.fprint("categoryProductList.ftl", map, parentPath+File.separator+cate.getId(),(i+1)+".htm");
			 map.clear();
		 }
	}

	
	private void publishAllNews(HttpServletRequest request, Column col, ModelMap modelMap){
		 Map<String,Object> map = new HashMap<String,Object>();
		 if(1==col.getType()){
			 //1　产品展示的页面
			 long count = productService.countByColId(col.getId());
			 logger.info("栏目Name|{}下共有{}个产品是已发布并且状态正常的.",col.getEnName(),count);
			 int totalPageNum = Math.max(1, (int) Math.ceil(1.0 * count/this.pageSize));
			 PageRainier<Product> page = null;
			 String path = request.getSession().getServletContext().getRealPath("/");
			 String parentPath = null;
			 for(int i=0;i<totalPageNum;i++){
				 map.putAll(modelMap);
				 //page = productService.findAllByColId((i+1), pageSize, col.getId()); //得到该栏目下所有的产品
				 page = productService.findPageByColId((i+1), pageSize, col.getId()); //分页得到该栏目下所有的产品
				 logger.info("第{}页共有{}个产品发布！",(i+1),page.getResult().size());
				 map.put("productPage", page);
				 parentPath = path + Constant.PRODUCTPRE + File.separator +col.getCode();
				 //列表的页面生成
				 if(!FreemarkerUtil.fprint("productList.ftl", map, parentPath,(i+1)+".htm")){
					 logger.error("生成产品列表页面|{}失败",(i+1));
				 }else{
					 logger.info("生成产品列表页面|{}成功",(i+1));
				 }
				 //生成产品详情的公共部分
				 for(Product product : page.getResult()){
					 map.put("product", product);
					 if(!FreemarkerUtil.fprint("product.ftl", map, path + Constant.PRODUCTPATH , product.getId()+".htm")){
						 logger.error("生成产品详情页面|{}失败",product.getEnName());
					 }else{
						 logger.info("生成产品详情页面|{}成功",product.getEnName());
					 }
				 }
				 map.clear();
			 }
		 }else if(2==col.getType()){
		 	//按文章标题填充
			//查询最大页数
			 int totalPageNum = Math.max(1, (int) Math.ceil(1.0 * 
					 newsService.countByColId(col.getId(),col.getDepth())/this.pageSize));
			 PageRainier<News> page = null;
			 String path = request.getSession().getServletContext().getRealPath("/");
			 String parentPath = "";
			 for(int i=0;i<totalPageNum;i++){
				 map.putAll(modelMap);
				 page = newsService.findAllByColId((i+1), pageSize, col.getId(),col.getDepth()); //得到所有的新闻
				 map.put("newsPage", page);
				 parentPath = path + Constant.NEWSPRE + File.separator +col.getCode();
				 //列表的页面生成
				 if(!FreemarkerUtil.fprint("newsList.ftl", map, parentPath,(i+1)+".htm")){
					 logger.info("生成新闻列表页面|{}失败",(i+1));
				 }else{
					 logger.info("生成新闻列表页面|{}成功",(i+1));
				 }
				//生成产品详情的公共部分
				 for(News news : page.getResult()){
					 map.put("news", news);
					 if(!FreemarkerUtil.fprint("news.ftl", map, path + Constant.NEWSPATH , news.getId()+".htm")){
						 logger.error("生成新闻详情|{}失败",news.getTitle());
					 }else{
						 logger.info("生成新闻详情|{}页面成功",news.getTitle());
					 }
				 }
				 map.clear();
			 }
		 }
	}
	
	protected void gennerateCommon(ModelMap map){
		//首页广告
		List<Advertisement> ads= advertisementService.getIndexAds(systemConfig.getIndexAdsSize());
		map.put("indexAds", ads);
		//横条菜单，最深显示到二级菜单
		List<Column> crossCol = columnService.findColumnsByDepth();
		map.put("crossCol", crossCol);
		//首页侧边栏目，最深显示到三级菜单
		//List<Column> verticalCol= columnService.findColumnsByDepth(systemConfig.getVerticalMaxDepth());
		//map.put("verticalCol", verticalCol);
		//首页新闻
		List<News> news = newsService.findIndexPic(systemConfig.getIndexNewsSize());
		map.put("indexNews", news);
		//查询所有第一级分类
		List<Category> categorysList = categoryService.findAllParentCateList();
		if(!CollectionUtils.isEmpty(categorysList)){
			for(Category cate : categorysList){
				long catProductsSize = productService.countByCateId(cate.getId());
				cate.setProductsSize(catProductsSize);
				if(catProductsSize!=0){
					if(!CollectionUtils.isEmpty(cate.getChildren())){
						for(Category childCate : cate.getChildren()){
							catProductsSize = productService.countByCateId(childCate.getId());
							logger.info("childCate products size |{}",catProductsSize);
							childCate.setProductsSize(catProductsSize);
						}
					}
				}
			}
		}
		map.put("categorys", categorysList);
 		//企业信息
		Company company = companyService.loadCompany();
		//对公司描述信息introduce（含html代码）进行截取
		company.setIntroduce(
				HtmlStringUtil.subStringHTML(company.getIntroduce(), systemConfig.getCompanyLength(), 
						"<a href='"+company.getWebsite()+"' class='button  product_type_simple' title='more infomation' target='_blank'>&nbsp;more"));
		map.put("company", company);
		//info信息
		List<Info> infos = infoService.getList();
		map.put("infos", infos);
		//网站关键字
		WebConfig webConfig = configService.loadSystemConfig();
		map.put("webConfig", webConfig);
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
			logger.error("生成页面发生错误",e);
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