package com.brightengold.controller;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import cn.rainier.nian.model.User;
import cn.rainier.nian.utils.PageRainier;

import com.brightengold.model.Advertisement;
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
import com.brightengold.service.MsgUtil;
import com.brightengold.service.ProductService;
import com.brightengold.service.SystemConfig;
import com.brightengold.util.Constant;
import com.brightengold.util.FreemarkerUtil;
import com.brightengold.util.LogType;
import com.brightengold.util.Tools;

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
	
	private PageRainier<Product> products;
	private Integer pageSize = 10;
	private static Logger logger = LoggerFactory.getLogger(ProductController.class);
	
	@RequestMapping(value={"/products/{pageNo}"})
	public String list(@PathVariable Integer pageNo,Model model,HttpServletRequest request){
		products = productService.findAll(pageNo, pageSize);
		model.addAttribute("page",products);//map
		return "admin/goods/product/list";
	}
	
	@RequestMapping(value="/{productId}/update",method=RequestMethod.GET)
	public String update(@PathVariable Integer productId,Model model) {
		if (productId != null) {
			model.addAttribute("model",productService.loadProductById(productId));
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
		if (productId != null) {
			Product product = productService.loadProductById(productId);
			//首页广告
			List<Advertisement> ads= advertisementService.getIndexAds(systemConfig.getIndexAdsSize());
			//横条菜单，最深显示到二级菜单
			List<Column> crossCol = columnService.findColumnsByDepth(systemConfig.getCrossMaxDepth());
			//首页侧边栏目，最深显示到三级菜单
			List<Column> verticalCol= columnService.findColumnsByDepth(systemConfig.getVerticalMaxDepth());
			//info信息
			List<Info> infos = infoService.getList();
			//企业信息
			Company company = companyService.loadCompany();
			model.put("infos", infos);
			model.put("company", company);
			model.put("verticalCol", verticalCol);
			model.put("crossCol", crossCol);
			model.put("indexAds", ads);
			model.put("model", product);
			return "admin_unless/goods/product/detail";
		}
		return "redirect:/admin/goods/product/products/1.html";
	}
	
	@RequestMapping(value="/{productId}/update",method=RequestMethod.POST)
	public String update(HttpServletRequest request,MultipartFile photo, 
			@PathVariable Integer productId,Product product) {
		StringBuilder content = new StringBuilder();
		try {
			if(productId!=null){
				Product tempProduct = productService.loadProductById(productId);
				String categoryId = request.getParameter("parents");
				if(!photo.isEmpty()){
					String realPath = request.getSession().getServletContext().getRealPath("/resources/upload/products");
					String newFileName = realPath+"/"+Tools.getRndFilename()+Tools.getExtname(photo.getOriginalFilename());
					FileUtils.copyInputStreamToFile(photo.getInputStream(), new File(newFileName));
					String url = newFileName.substring(realPath.lastIndexOf("upload"));
					product.setPicUrl(url.replace("\\", "/"));
				}else{
					product.setPicUrl(tempProduct.getPicUrl());
				}
				content.append("产品名称："+product.getEnName());
				product.setCategory(categoryService.loadCategoryById(Integer.parseInt(categoryId)));
				product.setCreateDate(tempProduct.getCreateDate());
				product.setCreateUser(tempProduct.getCreateUser());
				System.out.println(tempProduct.getUrl()+"-=-=");
				product.setUrl(tempProduct.getUrl());
				product.setStatus(tempProduct.isStatus());
				productService.saveProduct(product);
				MsgUtil.setMsgUpdate("success");
				LogUtil.getInstance().log(LogType.EDIT,content.toString());
				//删除页面
				System.out.println(product.getUrl()+"-=-=");
				String path = request.getSession().getServletContext().getRealPath("/");
				Tools.delFile(path + File.separator+"views"+File.separator+"html"+
				 		File.separator+"product"+File.separator+
			 			product.getCategory().getId()+File.separator+product.getUrl());
			}
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "redirect:/admin/goods/product/products/1.html";
	}
	
	@RequestMapping(value="/add",method=RequestMethod.GET)
	public String add(Model model) {
		return "admin/goods/product/add";
	}
	
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public String add(MultipartFile photo,Product product,HttpServletRequest request) {
		User u = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		StringBuilder sb = new StringBuilder();
		try {
			String categoryId = request.getParameter("parentC");
			product.setCategory(categoryService.loadCategoryById(Integer.parseInt(categoryId)));
			String realPath = request.getSession().getServletContext().getRealPath("/resources/upload/products");
			String newFileName = realPath+"/"+Tools.getRndFilename()+Tools.getExtname(photo.getOriginalFilename());
			FileUtils.copyInputStreamToFile(photo.getInputStream(), new File(newFileName));
			String url = newFileName.substring(realPath.lastIndexOf("upload"));
			product.setPicUrl(url.replace("\\", "/"));
			product.setPublish(false);
			product.setCreateDate(new Date());
			product.setCreateUser(u);
			productService.saveProduct(product);
			MsgUtil.setMsgAdd("success");
			sb.append("名称："+product.getEnName());
			LogUtil.getInstance().log(LogType.ADD, sb.toString());
			logger.info("新增产品{}成功！",ToStringBuilder.reflectionToString(product, ToStringStyle.SHORT_PREFIX_STYLE));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/admin/goods/product/products/1.html";
	}
	
	@RequestMapping(value="/{productId}/del",method=RequestMethod.GET)
	public String del(@PathVariable Integer productId,Product product){
		if(productId!=null){
			StringBuilder sb = new StringBuilder();
			product = productService.loadProductById(productId);
			productService.delProduct(product);
			sb.append("名称："+product.getEnName());
			MsgUtil.setMsgDelete("success");
			LogUtil.getInstance().log(LogType.DEL, sb.toString());
		}
		return "redirect:/admin/goods/product/products/1.html";
	}
	
	@RequestMapping(value="/{productId}/publish",method=RequestMethod.GET)
	public String publish(@PathVariable Integer productId){
		if(productId!=null){
			Product temp = productService.loadProductById(productId);
			if(!checkPub(temp)){
				if(StringUtils.isNotBlank(temp.getUrl())){
					temp.setUrl(temp.getUrl());
				}else{
					temp.setUrl(Tools.getRndFilename()+".htm");
				}
				temp.setPublish(true);
				productService.saveProduct(temp);
				MsgUtil.setMsg("success", "产品发布成功！");
			}else{
				MsgUtil.setMsg("error", "产品已发布！");
			}
		}
		return "redirect:/admin/goods/product/products/1.html";
	}
	
	@RequestMapping(value="/{productId}/release",method=RequestMethod.GET)
	public String releaseProduct(HttpServletRequest request, @PathVariable Integer productId, ModelMap map){
		if(productId!=null){
			Product temp = productService.loadProductById(productId);
			if(!checkPub(temp)){
				String realPath = request.getSession().getServletContext().getRealPath("/");
				String parentPath = Constant.PRODUCTPATH;
				if(StringUtils.isNotBlank(temp.getUrl())){
					temp.setUrl(temp.getUrl());
				}else{
					temp.setUrl(parentPath+Tools.getRndFilename()+".htm");
				}
				temp.setPublish(true);
				//生产类似shtml文件（server side include方式嵌入页面），避免全部生成整套文件，需要组装太多数据
				map.put("product", temp);
				//生成唯一的产品页面路径，不需要根据页码生成页码
				if(FreemarkerUtil.fprint("productDetail.ftl", map, realPath+parentPath, temp.getUrl())){
					productService.saveProduct(temp);
					MsgUtil.setMsg("success", "产品发布成功！");
				}else{
					MsgUtil.setMsg("error", "产品发布失败！");
				}
			}else{
				MsgUtil.setMsg("error", "产品已发布！");
			}
		}
		return "redirect:/admin/goods/product/products/1.html";
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

	private boolean checkPub(Product product) {
		if(product.isPublish() && 
				product.getUrl()!=null){
			return true;
		}else{
			return false;
		}
	}

	public PageRainier<Product> getProducts() {
		return products;
	}

	public void setProducts(PageRainier<Product> products) {
		this.products = products;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}
}
