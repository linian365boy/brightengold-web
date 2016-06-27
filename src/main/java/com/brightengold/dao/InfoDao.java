package com.brightengold.dao;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import cn.rainier.nian.dao.base.AbstractDao;

import com.brightengold.model.Info;

public interface InfoDao extends AbstractDao<Info, Integer>{
	@Query("select info from Info info where info.code = :codec")
	Info loadByCode(@Param("codec") String code);
}
