package com.brightengold.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import cn.rainier.nian.utils.PageRainier;

import com.brightengold.model.Advertisement;
import com.brightengold.model.Category;
import com.brightengold.model.Column;
import com.brightengold.model.Company;
import com.brightengold.model.Feedback;
import com.brightengold.model.Info;
import com.brightengold.model.News;
import com.brightengold.model.Product;
import com.brightengold.model.WebConfig;
import com.brightengold.service.AdvertisementService;
import com.brightengold.service.CategoryService;
import com.brightengold.service.ColumnService;
import com.brightengold.service.CompanyService;
import com.brightengold.service.FeedbackService;
import com.brightengold.service.InfoService;
import com.brightengold.service.NewsService;
import com.brightengold.service.ProductService;
import com.brightengold.service.SystemConfig;
import com.brightengold.service.WebConfigService;
import com.brightengold.util.Constant;

/**
 * @ClassName: ViewController  
 * @Description: 提供给view层的接口，供view层查询信息，不设置权限控制 
 * @date: 2016年7月25日 下午6:35:49 
 * 
 * @author tanfan 
 * @version  
 * @since JDK 1.7
 */
@Controller
@RequestMapping("/views")
public class ViewController {
	private static final Logger logger = LoggerFactory.getLogger(ViewController.class);
	@Autowired
	private ProductService productService;
	@Autowired
	private ColumnService columnService;
	@Autowired
	private AdvertisementService advertisementService;
	@Resource
	private SystemConfig systemConfig;
	@Autowired
	private CompanyService companyService;
	@Resource
	private NewsService newsService;
	@Resource
	private CategoryService categoryService;
	@Resource
	private InfoService infoService;
	@Resource
	private WebConfigService configService;
	@Autowired
	private FeedbackService feedbackService;
	
	@RequestMapping(value="/products/search")
	public String searchProducts(HttpServletRequest request, ModelMap map){
		String keyword = request.getParameter("keyword");
		String pageNoStr = request.getParameter("pageNo");
		int pageNo = 1;
		if(StringUtils.isNoneBlank(pageNoStr)){
			pageNo = Integer.parseInt(pageNoStr);
		}
		//生成公共部分内容
		gennerateCommon(map);
		PageRainier<Product> page = productService.findAllReleaseProductByLikeKeyword(keyword,pageNo,Constant.PAGE_INDEX_SIZE);
		map.put("page", page);
		map.put("keyword", keyword);
		map.put("pageNo", pageNo);
		return "html/search/list";
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
				if(catProductsSize!=0){
					long parentCateProductSize = catProductsSize;
					logger.info("cate products size |{}",catProductsSize);
					if(!CollectionUtils.isEmpty(cate.getChildren())){
						for(Category childCate : cate.getChildren()){
							catProductsSize = productService.countByCateId(childCate.getId());
							logger.info("childCate products size |{}",catProductsSize);
							if(catProductsSize!=0){
								childCate.setProductsSize(catProductsSize);
								parentCateProductSize+=catProductsSize;
							}
						}
					}
					cate.setProductsSize(parentCateProductSize);
				}
			}
		}
		map.put("categorys", categorysList);
 		//企业信息
		Company company = companyService.loadCompany();
		map.put("company", company);
		//info信息
		List<Info> infos = infoService.getList();
		map.put("infos", infos);
		//网站关键字
		WebConfig webConfig = configService.loadSystemConfig();
		map.put("webConfig", webConfig);
	}
	
	/**
	 * addFeedback:客户留言反馈 
	 * @author tanfan 
	 * @return 
	 * @since JDK 1.7
	 */
	@RequestMapping(value="/feedback/add",method=RequestMethod.POST)
	public void addFeedback(Feedback feedback){
		try{
			feedbackService.addFeedback(feedback);
			logger.info("客户留言信息|{}",feedback);
		}catch(Exception e){
			logger.error("客户留言出现错误！！！",e);
		}
	}
}
