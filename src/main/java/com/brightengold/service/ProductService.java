package com.brightengold.service;

import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;

import cn.rainier.nian.utils.PageRainier;

import com.brightengold.dao.ProductDao;
import com.brightengold.model.Product;

@Component("productService")
public class ProductService {
	@Autowired
	private ProductDao productDao;
	private static final Logger logger = LoggerFactory.getLogger(ProductService.class);

	public PageRainier<Product> findAll(Integer pageNo, Integer pageSize) {
		Page<Product> tempPage = productDao.findAll(
				new PageRequest(pageNo-1,pageSize,new Sort(Direction.DESC,"id")));
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
	
	public List<Product> findIndexPic(int pageSize){
		Page<Product> tempPage = productDao.findAll(findIndexPicSpec(), 
				new PageRequest(0,pageSize,new Sort(Direction.DESC,"id","hot")));
		return tempPage.getContent();
	}

	private Specification<Product> findIndexPicSpec() {
		return new Specification<Product>(){
			@Override
			public Predicate toPredicate(Root<Product> root,
					CriteriaQuery<?> query, CriteriaBuilder cb) {
				return cb.and(cb.equal(root.<Boolean>get("publish"),true));
			}
		};
	}

	public long countByColId(Integer id) {
		return productDao.countByColId(id);
	}

	public PageRainier<Product> findAllByColId(int pageNo, Integer pageSize,
			Integer id) {
		PageRainier<Product> page = new PageRainier<Product>(countByColId(id),pageNo,pageSize);
		List<Product> products = productDao.findListByColId(id);
		page.setResult(products);
		return page;
	}

	public void insertOfBatch(List<Product> productList) {
		productDao.save(productList);
	}

	public long countByCateId(int cateId) {
		return productDao.countByCateId(cateId);
	}

	public PageRainier<Product> findAllByCateId(int pageNo, Integer pageSize,
			Integer cateId) {
		PageRainier<Product> page = new PageRainier<Product>(countByCateId(cateId),pageNo,pageSize);
		List<Product> products = productDao.findListByCateId(cateId);
		page.setResult(products);
		return page;
	}

	public List<Product> findAllListByCateId(Integer catId) {
		return productDao.findAllListByCateId(catId);
	}

	public boolean updateStatus(Integer id, boolean status) {
		if(status){
			status = false;
		}else{
			status = true;
		}
		boolean flag = true;
		try{
			productDao.updateStatus(id,status);
		}catch(Exception e){
			logger.error("修改产品的状态失败！",e);
			flag = false;
		}
		return flag;
	}

}
