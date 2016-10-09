package com.brightengold.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.brightengold.dao.AdvertisementDao;
import com.brightengold.model.Advertisement;

import cn.rainier.nian.utils.PageRainier;

@Service("advertisementService")
public class AdvertisementService {
	@Autowired
	private AdvertisementDao advertisementDao;
	
	public void saveAdvertisement(Advertisement temp) {
		advertisementDao.save(temp);
	}
	
	public Advertisement loadAdvertisement(Integer id) {
		return advertisementDao.loadAdvertisement(id);
	}
	
	public void delAdvertisement(Integer id) {
		advertisementDao.delete(id);
	}

	public PageRainier<Advertisement> findAll(Integer pageNo, Integer pageSize) {
		//Page<Advertisement> tempPage = advertisementDao.findAll(new PageRequest(pageNo-1,pageSize,
		//		new Sort(Direction.DESC,"priority","id")));
		long count = advertisementDao.findAllCount();
		PageRainier<Advertisement> page = new PageRainier<Advertisement>(count);
		page.setResult(advertisementDao.findList((pageNo-1)*pageSize,pageSize));
		return page;
	}

	public void updateStatus(Integer id, Integer status) {
		advertisementDao.updateStatus(id,status);
	}

	public List<Advertisement> getIndexAds(int indexAdsSize) {
		//状态为正常的广告图片，按priority降序排序
		//Page<Advertisement> tempPage = 
		//		advertisementDao.findAll(indexAdsSpec(), 
		//				new PageRequest(0,indexAdsSize,new Sort(Direction.DESC,"priority","id")));
		return advertisementDao.findIndexAds(indexAdsSize);
	}

	/*private Specification<Advertisement> indexAdsSpec() {
		return new Specification<Advertisement>(){
			@Override
			public Predicate toPredicate(Root<Advertisement> root,
					CriteriaQuery<?> query, CriteriaBuilder cb) {
				return cb.equal(root.get("status"), 1);
			}
		};
	}*/
	
}
