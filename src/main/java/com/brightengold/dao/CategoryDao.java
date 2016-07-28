package com.brightengold.dao;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import cn.rainier.nian.dao.base.AbstractDao;

import com.brightengold.model.Category;

public interface CategoryDao extends AbstractDao<Category, Integer>{
	
	@Query("select c.id,c.enName from Category c where c.parent = null")
	List<Object[]> findParentByAjax();
	@Query("select c from Category c where c.enName = :enName")
	Category loadCateByName(@Param("enName") String enName);
	@Query("select count(id) from Category c where c.parent is :category")
	long checkHasChildren(@Param("category") Category category);
	@Query("select c from Category c where c.column.id = :colId or c.column.parentColumn.id = :colId")
	List<Category> findCate(@Param("colId") Integer colId);
	@Query("select c from Category c where c.parent = null")
	List<Category> findAllParentCateList();
	@Query("select c.id,c.enName from Category c where c.parent.id = :parentCateId")
	List<Object[]> findChildrenByParentCateId(@Param("parentCateId") int parentCateId);
}
