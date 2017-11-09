package com.brightengold.controller;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.brightengold.common.vo.RequestParam;
import com.brightengold.model.Advertisement;
import com.brightengold.model.Category;
import com.brightengold.model.Column;
import com.brightengold.model.Company;
import com.brightengold.model.Info;
import com.brightengold.model.Product;
import com.brightengold.service.AdvertisementService;
import com.brightengold.service.CategoryService;
import com.brightengold.service.ColumnService;
import com.brightengold.service.CompanyService;
import com.brightengold.service.InfoService;
import com.brightengold.service.LogUtil;
import com.brightengold.service.ProductService;
import com.brightengold.service.SystemConfig;
import com.brightengold.util.Constant;
import com.brightengold.util.FreemarkerUtil;
import com.brightengold.util.LogType;
import com.brightengold.util.Tools;
import com.brightengold.vo.MessageVo;
import com.brightengold.vo.ReturnData;

import cn.rainier.nian.model.User;
import cn.rainier.nian.utils.FileUtil;
import cn.rainier.nian.utils.PageRainier;

@Controller
@RequestMapping("/admin/goods/product")
@Scope("prototype")
public class ProductController {
	@Autowired
	private ProductService productService;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private CompanyService companyService;
	@Autowired
	private AdvertisementService advertisementService;
	@Resource
	private InfoService infoService;
	@Resource
	private SystemConfig systemConfig;
	@Autowired
	private ColumnService columnService;
	@Autowired
	private LogUtil logUtil;
	private final static Logger logger = LoggerFactory.getLogger(ProductController.class);
	
	@RequestMapping(value={"/products/list"})
	public String list(HttpServletRequest request,ModelMap map){
		map.put("ajaxListUrl", "admin/goods/product/products/getJsonList");
		return "admin/goods/product/list";
	}
	
	@ResponseBody
	@RequestMapping("/products/getJsonList")
	public ReturnData<Product> getJsonList(RequestParam param){
		PageRainier<Product> products = productService.findAll(param);
		ReturnData<Product> datas = new ReturnData<Product>(products.getTotalRowNum(), products.getResult());
		return datas;
	}
	
	@RequestMapping(value="/{productId}/update",method=RequestMethod.GET)
	public String update(@PathVariable Integer productId,Model model) {
	    logger.info("update product param => {}", productId);
		if (productId != null) {
			Product product = productService.loadProductById(productId);
			model.addAttribute("model",product);
			if(product.getCategoryId() != null){
				Category category = categoryService.loadCategoryById(product.getCategoryId());
				model.addAttribute("category",category);
				if(category != null && category.getParentId() != null){
					model.addAttribute("parentCategory",categoryService.loadCategoryById(category.getParentId()));
				}
			}
			model.addAttribute("parents", categoryService.findParentByAjax());
		}
		return "admin/goods/product/update";
	}
	
	/**
	 * detail:预览产品页面，需要组装数据
	 * @author tanfan 
	 * @param productId
	 * @param model
	 * @return 
	 * @since JDK 1.7
	 */
	@RequestMapping(value="/{productId}",method=RequestMethod.GET)
	public String detail(@PathVariable Integer productId,ModelMap model) {
        logger.info("detail product param => {}", productId);
		if (productId != null) {
			Product product = productService.loadProductById(productId);
			//首页广告
			List<Advertisement> ads= advertisementService.getIndexAds(systemConfig.getIndexAdsSize());
			//横条菜单，最深显示到二级菜单
			List<Column> crossCol = columnService.findColumnsByDepth();
			//首页侧边栏目，最深显示到三级菜单
			List<Column> verticalCol= columnService.findColumnsByDepth();
			//info信息
			List<Info> infos = infoService.findList();
			//企业信息
			Company company = companyService.loadCompany(systemConfig.getCompanyConfigPath());
			model.put("infos", infos);
			model.put("company", company);
			model.put("verticalCol", verticalCol);
			model.put("crossCol", crossCol);
			model.put("indexAds", ads);
			model.put("model", product);
		}
		return "admin_unless/goods/product/detail";
	}
	
	@ResponseBody
	@RequestMapping(value="/{productId}/update",method=RequestMethod.POST)
	public MessageVo update(HttpServletRequest request,MultipartFile photo, 
			@PathVariable Integer productId,Product product) {
        logger.info("update product param => {}, request param => {}", product, request.getParameterMap());
		StringBuilder content = new StringBuilder();
		MessageVo vo = null;
		try {
			if(productId!=null){
				Product tempProduct = productService.loadProductById(productId);
				if(photo!=null && !photo.isEmpty()){
					//String realPath = request.getSession().getServletContext().getRealPath("/resources/upload/products");
					String realPath = systemConfig.getPicPath()+File.separator+"upload"+File.separator+"products";
					String newFileName = realPath+File.separator+Tools.getRndFilename()+Tools.getExtname(photo.getOriginalFilename());
					//把前一张图片删除
					FileUtil.delFile(systemConfig.getPicPath()+File.separator+tempProduct.getPicUrl());
					FileUtils.copyInputStreamToFile(photo.getInputStream(), new File(newFileName));
					String url = newFileName.substring(realPath.lastIndexOf("upload"));
					product.setPicUrl(url.replace("\\", "/"));
				}else{
					product.setPicUrl(tempProduct.getPicUrl());
				}
				content.append("产品名称："+product.getEnName());
				String categoryId = request.getParameter("parents");
				String childCateId = request.getParameter("childrenC");
				if(StringUtils.isNoneBlank(childCateId) && Integer.parseInt(childCateId) >0 ){
					product.setCategoryId(Integer.parseInt(childCateId));
				}else{
					product.setCategoryId(Integer.parseInt(categoryId));
				}
				if(product.getPriority()==null){
					product.setPriority(0);
				}
				product.setPublish(false);
				product.setCreateDate(tempProduct.getCreateDate());
				product.setCreateUserId(tempProduct.getCreateUserId());
				if(StringUtils.isBlank(tempProduct.getUrl())){
					product.setUrl(Tools.getRndFilename()+".htm");
				}
				product.setStatus(tempProduct.isStatus());
				productService.updateProduct(product);
				logger.info("update product to => {}", product);
				logUtil.log(LogType.EDIT,content.toString());
				//删除页面
				//String path = request.getSession().getServletContext().getRealPath("/");
				String path = systemConfig.getHtmlPath();
				Tools.delFile(path + Constant.PRODUCTPRE + File.separator+productId+".htm");
				Tools.delFile(path + Constant.PRODUCTPATH + File.separator+product.getUrl());
				vo = new MessageVo(Constant.SUCCESS_CODE,"修改产品【"+product.getEnName()+"】信息成功！");
			}
		} catch (NumberFormatException e) {
			logger.error("update product error.",e);
			vo = new MessageVo(Constant.ERROR_CODE,"修改产品信息失败！");
		} catch (IOException e) {
			logger.error("update product error.",e);
			vo = new MessageVo(Constant.ERROR_CODE,"修改产品信息失败！");
		}
		logger.info("update product return data => {}", vo);
		return vo;
	}
	
	@RequestMapping(value="/add",method=RequestMethod.GET)
	public String add(Model model) {
		return "admin/goods/product/add";
	}
	
	@ResponseBody
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public MessageVo add(MultipartFile photo,Product product,HttpServletRequest request) {
	    logger.info("add product param => {}, request param => {}", product, request.getParameterMap());
		User u = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		StringBuilder sb = new StringBuilder();
		MessageVo vo = null;
		try {
			String categoryId = request.getParameter("parentC");
			String childCateId = request.getParameter("childrenC");
			if(StringUtils.isNoneBlank(childCateId) && Integer.parseInt(childCateId) >0 ){
				product.setCategoryId(Integer.parseInt(childCateId));
			}else{
				product.setCategoryId(Integer.parseInt(categoryId));
			}
			String realPath = systemConfig.getPicPath()+File.separator+"upload"+File.separator+"products";
			String newFileName = realPath+File.separator+Tools.getRndFilename()+Tools.getExtname(photo.getOriginalFilename());
			FileUtils.copyInputStreamToFile(photo.getInputStream(), new File(newFileName));
			String url = newFileName.substring(realPath.lastIndexOf("upload"));
			product.setPicUrl(url.replace("\\", "/"));
			product.setPublish(false);
			product.setCreateDate(new Date());
			product.setCreateUserId(u.getId());
			product.setUrl(Tools.getRndFilename()+".htm");
			if(product.getPriority()==null){
				product.setPriority(0);
			}
			productService.saveProduct(product);
			sb.append("名称："+product.getEnName());
			logUtil.log(LogType.ADD, sb.toString());
			logger.info("add product => {} succeed.",product);
			vo = new MessageVo(Constant.SUCCESS_CODE,"新增产品【"+product.getEnName()+"】成功！");
		} catch (Exception e) {
			logger.error("add product => {} error",e);
			vo = new MessageVo(Constant.ERROR_CODE,"新增产品【"+product.getEnName()+"】失败！");
		}
		logger.info("add product return data => {}", vo);
		return vo;
	}
	
	@ResponseBody
	@RequestMapping(value="/{productId}/del",method=RequestMethod.POST)
	public MessageVo del(@PathVariable Integer productId,Product product){
	    logger.info("delete product param => {}", product);
		MessageVo vo = null;
		if(productId!=null){
			StringBuilder sb = new StringBuilder();
			product = productService.loadProductById(productId);
			if(productService.delProduct(productId)){
				logger.warn("删除了产品|{}",product);
				sb.append("名称："+product.getEnName());
				logUtil.log(LogType.DEL, sb.toString());
				vo = new MessageVo(Constant.SUCCESS_CODE,"删除产品【"+product.getEnName()+"】成功！");
			}else{
				vo = new MessageVo(Constant.ERROR_CODE,"删除产品【"+product.getEnName()+"】失败！");
			}
		}
        logger.info("delete product return data => {}", vo);
		return vo;
	}
	
	@Deprecated
	@RequestMapping(value="/{productId}/publish",method=RequestMethod.GET)
	public String publish(@PathVariable Integer productId){
		if(productId!=null){
			Product temp = productService.loadProductById(productId);
			if(StringUtils.isBlank(temp.getUrl())){
				temp.setUrl(Tools.getRndFilename()+".htm");
			}
			temp.setPublish(true);
			productService.saveProduct(temp);
		}
		return "redirect:/admin/goods/product/products/1.html";
	}
	
	@ResponseBody
	@RequestMapping(value="/{productId}/release",method=RequestMethod.POST)
	public MessageVo releaseProduct(HttpServletRequest request, @PathVariable Integer productId, ModelMap map){
        logger.info("release product param => {}, request param => {}", productId, request.getParameterMap());
		MessageVo vo = null;
		Product temp = productService.loadProductById(productId);
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+
				request.getServerPort()+request.getContextPath();
		String realPath = systemConfig.getHtmlPath();
		if(StringUtils.isBlank(temp.getUrl())){
			temp.setUrl(Tools.getRndFilename()+".htm");
		}
		temp.setPublish(true);
		//生产类似shtml文件（server side include方式嵌入页面），避免全部生成整套文件，需要组装太多数据
		map.put("product", temp);
		//查找相关连产品，根据keyWords
		List<Product> products = 
			productService.findRelatedProducts(temp.getId(),temp.getKeyWords(),8);
		if(!CollectionUtils.isEmpty(products)){
			map.put("relatedProducts", products);
		}
		if(temp.isPublish()){
			Tools.delFile(realPath + Constant.PRODUCTPATH +File.separator + temp.getUrl());
		}
		map.put("ctx", basePath);
		//生成唯一的产品页面路径，不需要根据页码生成页面
		if(FreemarkerUtil.fprint("productDetail.ftl", map, realPath + Constant.PRODUCTPATH, temp.getUrl())){
			productService.updateProduct(temp);
			vo = new MessageVo(Constant.SUCCESS_CODE,"生产产品【"+temp.getEnName()+"】页面成功！");
		}else{
			vo = new MessageVo(Constant.ERROR_CODE,"生产产品【"+temp.getEnName()+"】页面失败！");
		}
		logger.info("release product return data => {}", vo);
		return vo;
	}
	
	
	@ResponseBody
	@RequestMapping(value="/{id}/changeStatus",method = RequestMethod.POST)
	public String changeStatus(@PathVariable("id") Integer id,boolean status){
		if(productService.updateStatus(id,status)){
			return "1";
		}else{
			return "-1";
		}
	}

	@RequestMapping(value="/{productId}/checkPub",method=RequestMethod.GET)
	@ResponseBody
	private String checkPub(@PathVariable Integer productId) {
		if(productId!=null){
			Product product = productService.loadProductById(productId);
			if(product!=null && product.isPublish() && 
					StringUtils.isNotBlank(product.getUrl())){
				return "1";
			}else{
				return "-1";
			}
		}else{
			return "0";
		}
	}
}
