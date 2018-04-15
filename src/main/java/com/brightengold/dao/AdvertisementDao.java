package com.brightengold.dao;

import com.brightengold.common.vo.RequestParam;
import com.brightengold.model.Advertisement;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AdvertisementDao {

	Advertisement loadAdvertisement(@Param("id") Integer id);

	void updateStatus(@Param("id") Integer id,@Param("status") Integer status);

	List<Advertisement> findIndexAds(@Param("findIndexAds") int indexAdsSize);

	void save(Advertisement temp);

	void delete(Integer id);

	long findAllCount(RequestParam param);

	List<Advertisement> findList(RequestParam param);

	void updateAdvertisement(Advertisement ad);

}
