package com.brightengold.service;

import cn.rainier.nian.utils.PageRainier;
import com.brightengold.common.vo.RequestParam;
import com.brightengold.dao.AdvertisementDao;
import com.brightengold.model.Advertisement;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

@Component("advertisementService")
public class AdvertisementService {
	@Autowired
	private AdvertisementDao advertisementDao;
	private static final Logger logger = LoggerFactory.getLogger(AdvertisementService.class);

	public void saveAdvertisement(Advertisement temp) {
		advertisementDao.save(temp);
	}

	public Advertisement loadAdvertisement(Integer id) {
		return advertisementDao.loadAdvertisement(id);
	}

	public void delAdvertisement(Integer id) {
		advertisementDao.delete(id);
	}

	public PageRainier<Advertisement> findAll(RequestParam param) {
		long count = advertisementDao.findAllCount(param);
		PageRainier<Advertisement> page = new PageRainier<Advertisement>(count);
		page.setResult(advertisementDao.findList(param));
		return page;
	}

	public void updateStatus(Integer id, Integer status) {
		if(status==0){
			status = 1;
		}else{
			status = 0;
		}
		advertisementDao.updateStatus(id,status);
	}

	public List<Advertisement> getIndexAds(int indexAdsSize) {
		//状态为正常的广告图片，按priority降序排序
		//Page<Advertisement> tempPage =
		//		advertisementDao.findAll(indexAdsSpec(),
		//				new PageRequest(0,indexAdsSize,new Sort(Direction.DESC,"priority","id")));
		return advertisementDao.findIndexAds(indexAdsSize);
	}

	public boolean updateAdvertisement(Advertisement ad) {
		boolean flag = false;
		try{
			advertisementDao.updateAdvertisement(ad);
			flag = true;
		}catch(Exception e){
			logger.error("修改广告信息失败",e);
		}
		return flag;
	}
	
}
