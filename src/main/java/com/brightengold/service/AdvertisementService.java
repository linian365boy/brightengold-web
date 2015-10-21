package com.brightengold.service;

import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
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
		Page<Advertisement> tempPage = advertisementDao.findAll(new PageRequest(pageNo-1,pageSize,
				new Sort(Direction.DESC,"priority","id")));
		PageRainier<Advertisement> page = new PageRainier<Advertisement>(tempPage.getTotalElements(),pageNo,pageSize);
		page.setResult(tempPage.getContent());
		return page;
	}

	public void updateStatus(Integer id, Integer status) {
		advertisementDao.updateStatus(id,status);
	}

	public List<Advertisement> getIndexAds(int indexAdsSize) {
		//状态为正常的广告图片，按priority降序排序
		Page<Advertisement> tempPage = 
				advertisementDao.findAll(indexAdsSpec(), 
						new PageRequest(0,indexAdsSize,new Sort(Direction.DESC,"priority","id")));
		return tempPage.getContent();
	}

	private Specification<Advertisement> indexAdsSpec() {
		return new Specification<Advertisement>(){
			@Override
			public Predicate toPredicate(Root<Advertisement> root,
					CriteriaQuery<?> query, CriteriaBuilder cb) {
				return cb.equal(root.get("status"), 1);
			}
		};
	}
	
}
