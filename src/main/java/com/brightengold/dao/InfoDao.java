package com.brightengold.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.brightengold.common.vo.RequestParam;
import com.brightengold.model.Info;

public interface InfoDao {
	//@Query("select info from Info info where info.code = :codec")
	Info loadByCode(@Param("codec") String code);

	Info findOne(Integer id);

	void delete(Integer id);

	void save(Info info);

	List<Info> findAll();

	void delete(Info info);

	List<Info> findList(RequestParam param);

	long findAllCount();
}
