package com.brightengold.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Component;

import cn.rainier.nian.utils.PageRainier;

import com.brightengold.dao.ColumnDao;
import com.brightengold.model.Column;

@Component("columnService")
public class ColumnService {
	@Autowired
	private ColumnDao columnDao;
	public Column getById(Integer id){
		return columnDao.findOne(id);
	}
	
	public Column save(Column column){
		return columnDao.save(column);
	}
	
	public PageRainier<Column> findAll(Integer pageNo, Integer pageSize){
		Page<Column> tempPage = columnDao.findAll(new PageRequest(pageNo-1,pageSize,new Sort(Direction.DESC,"priority","id")));
		PageRainier<Column> page = new PageRainier<Column>(tempPage.getTotalElements(),pageNo,pageSize);
		page.setResult(tempPage.getContent());
		return page;
	}

	public void delete(Integer id) {
		columnDao.delete(id);
	}

	public List<Object[]> findParentByAjax() {
		return this.columnDao.findParentByAjax();
	}
}
