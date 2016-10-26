package com.brightengold.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.brightengold.common.vo.RequestParam;
import com.brightengold.dao.InfoDao;
import com.brightengold.model.Info;

import cn.rainier.nian.utils.PageRainier;

@Component("infoService")
public class InfoService {
	@Autowired
	private InfoDao infoDao;
	
	public PageRainier<Info> findAll(RequestParam param) {
		long count = infoDao.findAllCount();
		//Page<Info> tempPage = infoDao.findAll(new PageRequest(pageNo-1,pageSize,new Sort(Direction.DESC,"priority")));
		PageRainier<Info> page = new PageRainier<Info>(count);
		page.setResult(infoDao.findList(param));
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
