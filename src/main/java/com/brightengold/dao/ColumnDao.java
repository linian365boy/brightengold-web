package com.brightengold.dao;

import com.brightengold.common.vo.RequestParam;
import com.brightengold.model.Column;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ColumnDao {

	List<Column> findParentByAjax();

	Column loadColumnByCode(@Param("code") String code);

	List<Column> findChildrenByParentId(@Param("pId") Integer pId);

	void updateColumnPublishContent(@Param("id") Integer id,@Param("type")  int type,@Param("hasNeedForm") boolean hasNeedForm);

	Column findOne(Integer id);

	void save(Column column);

	void delete(Integer id);

	Long countColumnByCode(String code);

	List<Column> findAll();

	long findAllCount(RequestParam param);

	List<Column> findList(RequestParam param);

	void updateColumn(Column column);
}
