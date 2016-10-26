package com.brightengold.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import com.brightengold.common.vo.RequestParam;
import com.brightengold.model.Category;

public interface CategoryDao {
	
	//@Query("select c.id,c.enName from Category c where c.parent = null")
	List<Category> findParentByAjax();
	//@Query("select c from Category c where c.enName = :enName")
	Category loadCateByName(@Param("enName") String enName);
	//@Query("select count(id) from Category c where c.parent is :category")
	long checkHasChildren(@Param("categoryId") Integer categoryId);
	//@Query("select c from Category c where c.column.id = :colId or c.column.parentColumn.id = :colId")
	List<Category> findCate(@Param("colId") Integer colId);
	//@Query("select c from Category c where c.parent = null order by c.createDate asc")
	List<Category> findAllParentCateList();
	//@Query("select c.id,c.enName from Category c where c.parent.id = :parentCateId")
	List<Object[]> findChildrenByParentCateId(@Param("parentCateId") int parentCateId);
	
	long findAllCount();
	
	List<Category> findList(RequestParam param);
	
	Category findOneById(Integer categoryId);
	
	void save(Category temp);
	
	void delete(Integer categoryId);
	
	long countByEname(String enName);
	
	Category findOneByEnName(String enName);
	
	List<Category> findAll();
}
