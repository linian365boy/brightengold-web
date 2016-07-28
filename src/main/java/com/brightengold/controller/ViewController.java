package com.brightengold.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.brightengold.model.Product;
import com.brightengold.service.ProductService;
import com.brightengold.util.Constant;

import cn.rainier.nian.utils.PageRainier;

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
	@Autowired
	private ProductService productService;
	
	@RequestMapping(value="/products/search")
	public String searchProducts(HttpServletRequest request, ModelMap map){
		String keyword = request.getParameter("keyword");
		String pageNoStr = request.getParameter("pageNo");
		int pageNo = 1;
		if(StringUtils.isNoneBlank(pageNoStr)){
			pageNo = Integer.parseInt(pageNoStr);
		}
		if(StringUtils.isNotBlank(keyword)){
			PageRainier<Product> page = productService.findAllReleaseProductByLikeKeyword(keyword,pageNo,Constant.PAGE_INDEX_SIZE);
			map.put("page", page);
		}
		//生成公共部分内容
		
		return "html/search/list";
	}
}
