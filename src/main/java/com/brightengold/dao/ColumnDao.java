package com.brightengold.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.brightengold.model.Column;

public interface ColumnDao {
	
	//@Query("select c.id,c.name from Column c where c.parentColumn = null order by c.priority desc,c.id desc")
	List<Column> findParentByAjax();
	//@Query("select c from Column c where c.code = :code")
	Column loadColumnByCode(@Param("code") String code);
	//@Query("select c.id,c.name from Column c where c.parentColumn.id = :pId order by c.priority desc,c.id desc")
	List<Column> findChildrenByParentId(@Param("pId") Integer pId);
	//@Modifying
	//@Query("update Column c set c.type = :type,c.hasNeedForm = :hasNeedForm where c.id = :id or c.parentColumn.id = :id")
	void updateColumnPublishContent(@Param("id") Integer id,@Param("type")  int type,@Param("hasNeedForm") boolean hasNeedForm);
	
	Column findOne(Integer id);
	
	void save(Column column);
	
	void delete(Integer id);
	
	Long countColumnByCode(String code);
	
	List<Column> findAll();
	
	long findAllCount(String keyword);
	
	List<Column> findList(@Param("keyword") String keyword, @Param("start") Integer start,@Param("pageSize") Integer pageSize);
}
