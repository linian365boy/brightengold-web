package com.brightengold.dao;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import cn.rainier.nian.dao.base.AbstractDao;

import com.brightengold.model.Column;

public interface ColumnDao extends AbstractDao<Column, Integer> {
	
	@Query("select c.id,c.name from Column c where c.parentColumn = null")
	List<Object[]> findParentByAjax();
	@Query("select c from Column c where c.code = :code")
	Column loadColumnByCode(@Param("code") String code);
	
}
