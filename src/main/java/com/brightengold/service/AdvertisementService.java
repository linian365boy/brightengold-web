package com.brightengold.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Component;

import cn.rainier.nian.utils.PageRainier;

import com.brightengold.dao.AdvertisementDao;
import com.brightengold.model.Advertisement;

@Component("advertisementService")
public class AdvertisementService {
	@Autowired
	private AdvertisementDao advertisementDao;
	
	public Advertisement saveAdvertisement(Advertisement temp) {
		return advertisementDao.save(temp);
	}
	
	public Advertisement loadAdvertisement(Integer id) {
		return advertisementDao.loadAdvertisement(id);
	}
	
	public void delAdvertisement(Integer id) {
		advertisementDao.delete(id);
	}

	public PageRainier<Advertisement> findAll(Integer pageNo, Integer pageSize) {
		Page<Advertisement> tempPage = advertisementDao.findAll(new PageRequest(pageNo-1,pageSize,new Sort(Direction.DESC,"id")));
		PageRainier<Advertisement> page = new PageRainier<Advertisement>(tempPage.getTotalElements(),pageNo,pageSize);
		page.setResult(tempPage.getContent());
		return page;
	}

	public void updateStatus(Integer id, Integer status) {
		advertisementDao.updateStatus(id,status);
	}
	
}
