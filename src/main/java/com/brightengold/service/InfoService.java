package com.brightengold.service;

import cn.rainier.nian.utils.PageRainier;
import com.brightengold.common.vo.RequestParam;
import com.brightengold.dao.InfoDao;
import com.brightengold.model.Info;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

@Component("infoService")
public class InfoService {
	@Autowired
	private InfoDao infoDao;
	private static final Logger logger = LoggerFactory.getLogger(InfoService.class);

	public PageRainier<Info> findAll(RequestParam param) {
		long count = infoDao.findAllCount(param);
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
	public boolean save(Info info){
		boolean flag = false;
		try{
			infoDao.save(info);
			flag = true;
		}catch(Exception e){
			logger.info("新增信息失败，报错",e);
		}
		return flag;
	}

	public Info loadOneByCode(String code) {
		return infoDao.loadByCode(code);
	}

	public boolean deleteInfo(Info info) {
		boolean flag = false;
		try{
			infoDao.delete(info);
			flag = true;
		}catch(Exception e){
			logger.error("删除信息失败",e);
		}
		return flag;
	}

	public List<Info> findList() {
		return infoDao.findAll();
	}

	public boolean updateInfo(Info info) {
		boolean flag = false;
		try{
			infoDao.updateInfo(info);
			flag = true;
		}catch(Exception e){
			logger.info("新增信息失败，报错",e);
		}
		return flag;
	}
}
