package com.brightengold.dao;

import com.brightengold.common.vo.RequestParam;
import com.brightengold.model.Info;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface InfoDao {
	Info loadByCode(@Param("codec") String code);

	Info findOne(Integer id);

	void delete(Integer id);

	void save(Info info);

	List<Info> findAll();

	void delete(Info info);

	List<Info> findList(RequestParam param);

	long findAllCount(RequestParam param);

	void updateInfo(Info info);
}
