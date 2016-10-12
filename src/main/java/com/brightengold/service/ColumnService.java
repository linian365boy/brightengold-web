package com.brightengold.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.brightengold.dao.ColumnDao;
import com.brightengold.model.Column;

import cn.rainier.nian.utils.PageRainier;

@Service("columnService")
public class ColumnService {
	@Autowired
	private ColumnDao columnDao;
	private static Logger logger = LoggerFactory.getLogger(ColumnService.class);
	
	public Column getById(Integer id){
		return columnDao.findOne(id);
	}
	
	public boolean save(Column column){
		boolean flag = false;
		try{
			columnDao.save(column);
			flag = true;
		}catch(Exception e){
			logger.error("新增栏目报错",e);
		}
		return flag;
	}
	
	public PageRainier<Column> findAll(Integer pageNo, Integer pageSize, String keyword){
		long count = columnDao.findAllCount(keyword);
		PageRainier<Column> page = new PageRainier<Column>(count);
		page.setResult(columnDao.findList(keyword,(pageNo-1)*pageSize,pageSize));
		return page;
	}

	public void delete(Integer id) {
		columnDao.delete(id);
	}

	public List<Column> findParentByAjax() {
		return this.columnDao.findParentByAjax();
	}

	/**
	 * 根据栏目代码查询是否存在该栏目
	 * @param code　栏目代码
	 * @return
	 */
	public Long countColumnByCode(String code) {
		return columnDao.countColumnByCode(code);
	}

	public Column loadColumnByCode(String code) {
		return columnDao.loadColumnByCode(code);
	}

	public List<Column> findChildrenByParentId(Integer pId) {
		return this.columnDao.findChildrenByParentId(pId);
	}

	public List<Column> findColumnsByDepth() {
		List<Column> colList = columnDao.findParentByAjax();
		return colList;
	}

	public void updateColumnPublishContent(Integer id, Column column) {
		columnDao.updateColumnPublishContent(id,column.getType(),column.isHasNeedForm());
	}

	public List<Column> findList() {
		return columnDao.findAll();
	}

}
