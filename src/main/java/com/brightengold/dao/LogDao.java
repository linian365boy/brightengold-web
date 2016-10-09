package com.brightengold.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.brightengold.model.Log;

public interface LogDao {

	void save(Log log);

	long findAllCount();

	List<Log> findList(@Param("start") Integer start,@Param("pageSize") Integer pageSize);

}
