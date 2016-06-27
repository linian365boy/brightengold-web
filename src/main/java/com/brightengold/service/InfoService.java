package com.brightengold.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Component;

import cn.rainier.nian.utils.PageRainier;

import com.brightengold.dao.InfoDao;
import com.brightengold.model.Info;

@Component("infoService")
public class InfoService {
	@Autowired
	private InfoDao infoDao;
	
	public PageRainier<Info> findAll(Integer pageNo, Integer pageSize) {
		Page<Info> tempPage = infoDao.findAll(new PageRequest(pageNo-1,pageSize,new Sort(Direction.DESC,"priority")));
		PageRainier<Info> page = new PageRainier<Info>(tempPage.getTotalElements(),pageNo,pageSize);
		page.setResult(tempPage.getContent());
		return page;
	}
	
	public Info loadOne(Integer id) {
		return infoDao.findOne(id);
	}

	public void delete(Integer id) {
		infoDao.delete(id);
	}
	public Info save(Info info){
		return infoDao.save(info);
	}

	public List<Info> getList() {
		return infoDao.findAll();
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
