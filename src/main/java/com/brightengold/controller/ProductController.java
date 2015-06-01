package com.brightengold.controller;

import java.io.File;
import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import cn.rainier.nian.model.User;
import cn.rainier.nian.utils.PageRainier;

import com.brightengold.model.Product;
import com.brightengold.service.CategoryService;
import com.brightengold.service.LogUtil;
import com.brightengold.service.MsgUtil;
import com.brightengold.service.ProductService;
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
	private PageRainier<Product> products;
	private Integer pageSize = 10;
	private Logger logger = LoggerFactory.getLogger(ProductController.class);
	
	@RequestMapping(value={"/products/{pageNo}"})
	public String list(@PathVariable Integer pageNo,Model model,HttpServletRequest request){
		if(pageNo==null){
			pageNo = 1;
		}
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
	
	@RequestMapping(value="/{productId}/update",method=RequestMethod.POST)
	public String update(HttpServletRequest request,MultipartFile photo, @PathVariable Integer productId,Product product) {
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
				productService.saveProduct(product);
				MsgUtil.setMsgUpdate("success");
				LogUtil.getInstance().log(LogType.EDIT,content.toString());
			}
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "redirect:/admin/goods/product/products/1";
	}
	
	@RequestMapping(value="/add",method=RequestMethod.GET)
	public String add(Model model) {
		return "admin/goods/product/add";
	}
	
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public String add(MultipartFile photo,Product product,BindingResult result, HttpServletRequest request) {
		if(result.hasErrors()){
			return "admin/goods/product/add";
		}
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
		} catch (Exception e) {
			e.printStackTrace();
		}
		return InternalResourceViewResolver.REDIRECT_URL_PREFIX+"/admin/goods/product/products/1";
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
		return "redirect:/admin/goods/product/products/1";
	}
	
	@RequestMapping(value="/{productId}/publish",method=RequestMethod.GET)
	public String publish(@PathVariable Integer productId){
		if(productId!=null){
			Product temp = productService.loadProductById(productId);
			if(!checkPub(temp)){
				temp.setPublish(true);
				productService.saveProduct(temp);
				MsgUtil.setMsg("success", "产品发布成功！");
			}else{
				MsgUtil.setMsg("error", "产品已发布！");
			}
		}
		return "redirect:/admin/goods/product/products/1";
	}

	private boolean checkPub(Product product) {
		if(product.isPublish()){
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
