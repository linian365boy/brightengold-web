package com.brightengold.dao;

import java.util.List;

import com.brightengold.common.vo.RequestParam;
import com.brightengold.model.Log;

public interface LogDao {

	void save(Log log);

	long findAllCount(RequestParam param);

	List<Log> findList(RequestParam param);

}
