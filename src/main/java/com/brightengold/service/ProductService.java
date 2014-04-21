package com.brightengold.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Component;

import cn.rainier.nian.utils.PageRainier;

import com.brightengold.dao.ProductDao;
import com.brightengold.model.Product;

@Component("productService")
public class ProductService {
	@Autowired
	private ProductDao productDao;

	public PageRainier<Product> findAll(Integer pageNo, Integer pageSize) {
		Page<Product> tempPage = productDao.findAll(new PageRequest(pageNo-1,pageSize,new Sort(Direction.DESC,"id")));
		PageRainier<Product> page = new PageRainier<Product>(tempPage.getTotalElements(),pageNo,pageSize);
		page.setResult(tempPage.getContent());
		return page;
	}

	public Product loadProductById(Integer productId) {
		return productDao.findOne(productId);
	}

	public Product saveProduct(Product product) {
		return productDao.save(product);
	}

	public void delProduct(Integer productId) {
		productDao.delete(productId);
	}
	
	public void delProduct(Product product) {
		productDao.delete(product);
	}

}
