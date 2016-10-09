package com.brightengold.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.brightengold.dao.InfoDao;
import com.brightengold.model.Info;

import cn.rainier.nian.utils.PageRainier;

@Component("infoService")
public class InfoService {
	@Autowired
	private InfoDao infoDao;
	
	public PageRainier<Info> findAll(Integer pageNo, Integer pageSize) {
		long count = infoDao.findAllCount();
		//Page<Info> tempPage = infoDao.findAll(new PageRequest(pageNo-1,pageSize,new Sort(Direction.DESC,"priority")));
		PageRainier<Info> page = new PageRainier<Info>(count,pageNo,pageSize);
		page.setResult(infoDao.findList((pageNo-1)*pageSize,pageSize));
		return page;
	}
	
	public Info loadOne(Integer id) {
		return infoDao.findOne(id);
	}

	public void delete(Integer id) {
		infoDao.delete(id);
	}
	public void save(Info info){
		infoDao.save(info);
	}

	public Info loadOneByCode(String code) {
		return infoDao.loadByCode(code);
	}

	public void deleteInfo(Info info) {
		infoDao.delete(info);
	}

	public List<Info> findList() {
		return infoDao.findAll();
	}
}
