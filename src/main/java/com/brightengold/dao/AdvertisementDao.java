package com.brightengold.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.brightengold.common.vo.RequestParam;
import com.brightengold.model.Advertisement;

public interface AdvertisementDao {

	Advertisement loadAdvertisement(@Param("id") Integer id);

	void updateStatus(@Param("id") Integer id,@Param("status") Integer status);

	List<Advertisement> findIndexAds(@Param("indexAdsSize") int indexAdsSize);
	
	void save(Advertisement temp);
	
	void delete(Integer id);
	
	long findAllCount(RequestParam param);
	
	List<Advertisement> findList(RequestParam param);
	
	void updateAdvertisement(Advertisement ad);
}
