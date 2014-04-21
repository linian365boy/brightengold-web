package com.brightengold.dao;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import cn.rainier.nian.dao.base.AbstractDao;
import cn.rainier.nian.model.User;

import com.brightengold.model.Category;

public interface CategoryDao extends AbstractDao<Category, Integer>{
	
	@Query("select c.id,c.enName from Category c where c.parent = null")
	List<Object[]> findParentByAjax();
	@Query("select c from Category c where c.enName = :enName")
	Category loadCateByName(@Param("enName") String enName);
	@Query("select count(id) from Category c where c.parent is :category")
	long checkHasChildren(@Param("category") Category category);
	
}
