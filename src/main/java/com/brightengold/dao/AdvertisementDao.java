package com.brightengold.dao;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import cn.rainier.nian.dao.base.AbstractDao;

import com.brightengold.model.Advertisement;

public interface AdvertisementDao extends AbstractDao<Advertisement, Integer> {

	@Query("select a from Advertisement a where a.id = :id")
	Advertisement loadAdvertisement(@Param("id") Integer id);
	
	@Modifying
	@Query("update Advertisement set status = :status where id = :id")
	void updateStatus(@Param("id") Integer id,@Param("status") Integer status);

}
