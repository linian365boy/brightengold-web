package com.brightengold.service;

import java.util.Date;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Path;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import cn.rainier.nian.model.Menu;
import cn.rainier.nian.model.User;
import cn.rainier.nian.utils.DateConverter;
import cn.rainier.nian.utils.PageRainier;

import com.brightengold.dao.LogDao;
import com.brightengold.model.Log;
import com.brightengold.util.LogType;

@Component("logService")
public class LogService {
	@Autowired
	private LogDao logDao;

	public Log saveLog(Log log){
		return logDao.save(log);
	}

	private static Specification<Log> findLogSpeci(final String field,final String condition){
		return new Specification<Log>() {
			public Predicate toPredicate(Root<Log> root, CriteriaQuery<?> query,
					CriteriaBuilder cb) {
				Path<String> path = null;
				if("type".equals(field)){
					path = root.get("type");
				}else if("operator".equals(field)){
					path = root.get("operatorName");
				}else if("menu".equals(field)){
					path = root.get("menu").get("name");
				}else if("content".equals(field)){
					path = root.get("content");
				}else{
					return null;
				}
				return cb.like(path, '%'+condition+'%');
			}
		};
	}


	/**
	 *@see 根据用户选中的条件查找日志
	 */
	public PageRainier<Log> findLog(String field,String condition,String condition2,Integer pageNo,Integer pageSize){
		PageRainier<Log> page = null;
		Page<Log> tempPage = null;
		if("logDate".equals(field)){
			final Date startDate = (Date)DateConverter.convert(Date.class, condition);
			final Date endDate = (Date)DateConverter.convert(Date.class, condition2);
			tempPage = logDao.findAll(new Specification<Log> (){
				public Predicate toPredicate(Root<Log> root,
						CriteriaQuery<?> query, CriteriaBuilder cb) {
					return cb.between(root.<Date>get("logDate"),startDate,endDate);
				}
			}, new PageRequest(pageNo-1,pageSize,Direction.DESC,"logDate"));
		}else{
			Specification<Log> speci= findLogSpeci(field,condition);
			tempPage = logDao.findAll(speci,
					new PageRequest(pageNo-1,pageSize,new Sort(Direction.DESC,"logDate")));
		}
		if(tempPage!=null){
			page = new PageRainier<Log>(tempPage.getTotalElements(),pageNo,pageSize);
			page.setResult(tempPage.getContent());
		}
		return page;
	}

	public PageRainier<Log> findAll(Integer pageNo, Integer pageSize) {
		Page<Log> tempPage = logDao.findAll(new PageRequest(pageNo-1,pageSize,new Sort(Direction.DESC,"id")));
		PageRainier<Log> page = new PageRainier<Log>(tempPage.getTotalElements(),pageNo,pageSize);
		page.setResult(tempPage.getContent());
		return page;
	}


	public void log(LogType type, String content) {
		Log log = new Log();
		User u = ((User)SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		log.setType(type.getName());
		log.setContent(content);
		log.setCreateTime(new Date());
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder
			      .getRequestAttributes()).getRequest();
		log.setMenu((Menu)request.getSession().getAttribute("menu"));
		log.setOperator(u.getUsername());
		log.setOperatorRealName(u.getRealName());
		logDao.save(log);
	}

	public void log(LogType type, 
			Map<String, Object> logMap) {
		Log log = new Log();
		User u = ((User)SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		log.setCreateTime(new Date());
		//log.setMenu(module);
		log.setOperatorRealName(u.getRealName());
		log.setOperator(u.getUsername());
		log.setType(type.getName());
		Set<String> keys = logMap.keySet();
		StringBuilder sb = new StringBuilder();
		for(Iterator<String> it = keys.iterator();it.hasNext();){
			String key = it.next();
			Object obj = logMap.get(key);
			sb.append(key+"="+obj.toString()+" ");
		}
		log.setContent(sb.toString());
	}
}
