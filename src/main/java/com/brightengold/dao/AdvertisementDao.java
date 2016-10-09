package com.brightengold.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.brightengold.model.Advertisement;

public interface AdvertisementDao {
	//@Query("select a from Advertisement a where a.id = :id")
	Advertisement loadAdvertisement(@Param("id") Integer id);
	//@Modifying
	//@Query("update Advertisement set status = :status where id = :id")
	void updateStatus(@Param("id") Integer id,@Param("status") Integer status);
	//@Query("select a from Advertisement a where a.status = 1 order by a.priority desc limit :size")
	List<Advertisement> findIndexAds(@Param("size") int indexAdsSize);
	
	void save(Advertisement temp);
	
	void delete(Integer id);
	
	long findAllCount();
	
	List<Advertisement> findList(@Param("start") Integer start,@Param("pageSize") Integer pageSize);
}
