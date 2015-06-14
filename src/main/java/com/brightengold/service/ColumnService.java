package com.brightengold.service;

import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
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
	
	public PageRainier<Column> findAll(Integer pageNo, Integer pageSize, String keyword){
		Page<Column> tempPage = columnDao.findAll(columnSpec(keyword),
				new PageRequest(pageNo-1,pageSize,new Sort(Direction.DESC,"priority","id")));
		PageRainier<Column> page = new PageRainier<Column>(tempPage.getTotalElements(),pageNo,pageSize);
		page.setResult(tempPage.getContent());
		return page;
	}

	private Specification<Column> columnSpec(final String keyword) {
		if(StringUtils.isNotBlank(keyword)){
			return new Specification<Column>(){
				@Override
				public Predicate toPredicate(Root<Column> root,
						CriteriaQuery<?> query, CriteriaBuilder cb) {
					return cb.or(cb.like(root.<String>get("name"), '%'+keyword+'%'),
							cb.like(root.<String>get("code"), '%'+keyword+'%'));
				}
			};
		}else{
			return null;
		}
	}

	public void delete(Integer id) {
		columnDao.delete(id);
	}

	public List<Object[]> findParentByAjax() {
		return this.columnDao.findParentByAjax();
	}

	public Long countColumnByCode(String code) {
		return columnDao.count(countSpec(code));
	}

	private Specification<Column> countSpec(final String code) {
		return new Specification<Column>(){
			@Override
			public Predicate toPredicate(Root<Column> root,
					CriteriaQuery<?> query, CriteriaBuilder cb) {
				return cb.equal(root.<String>get("code"), code);
			}
		};
	}

	public Column loadColumnByCode(String code) {
		return columnDao.loadColumnByCode(code);
	}
}
