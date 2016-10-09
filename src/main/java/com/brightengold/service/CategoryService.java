package com.brightengold.service;

import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;

import cn.rainier.nian.utils.PageRainier;

import com.brightengold.dao.CategoryDao;
import com.brightengold.model.Category;

@Component("categoryService")
public class CategoryService {
	@Autowired
	private CategoryDao categoryDao;

	public PageRainier<Category> findAll(Integer pageNo, Integer pageSize) {
		Page<Category> tempPage = categoryDao.findAll(new PageRequest(pageNo-1,pageSize,new Sort(Direction.DESC,"id")));
		PageRainier<Category> page = new PageRainier<Category>(tempPage.getTotalElements(),pageNo,pageSize);
		page.setResult(tempPage.getContent());
		return page;
	}

	public List<Object[]> findParentByAjax() {
		return this.categoryDao.findParentByAjax();
	}
	
	public List<Object[]> findChildrenByParentCateId(int parentCateId){
		return categoryDao.findChildrenByParentCateId(parentCateId);
	}

	public Category loadCategoryById(Integer categoryId) {
		return categoryDao.findOne(categoryId);
	}

	public Category saveCategory(Category temp) {
		return categoryDao.save(temp);
	}

	public Category loadCategoryByName(String enName) {
		return categoryDao.loadCateByName(enName);
	}

	public void delCategory(Integer categoryId) {
		categoryDao.delete(categoryId);
	}

	public boolean checkHasChildren(Category temp) {
		return categoryDao.checkHasChildren(temp)>0?true:false;
	}
	/**
	 * 根据英文名称查询分类是否存在
	 * @param code
	 * @return
	 */
	public long countByCateEname(String enName) {
		return categoryDao.count(countSpec(enName));
	}

	private Specification<Category> countSpec(final String enName) {
		return new Specification<Category>(){
			@Override
			public Predicate toPredicate(Root<Category> root,
					CriteriaQuery<?> query, CriteriaBuilder cb) {
				return cb.equal(root.<String>get("enName"), enName);
			}
		};
	}

	public Category loadCategoryByEname(String code) {
		return categoryDao.findOne(countSpec(code));
	}

	public List<Category> findCateByColId(Integer id) {
		return categoryDao.findCate(id);
	}

	public List<Category> findList() {
		return categoryDao.findAll();
	}
	
	public List<Category> findAllParentCateList() {
		return categoryDao.findAllParentCateList();
	}

}
