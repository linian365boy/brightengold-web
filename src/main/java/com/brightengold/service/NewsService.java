package com.brightengold.service;

import java.util.Date;
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

import com.brightengold.dao.NewsDao;
import com.brightengold.model.News;

@Component("newsService")
public class NewsService {
	@Autowired
	private NewsDao newsDao;
	
	public PageRainier<News> findAll(Integer pageNo, Integer pageSize) {
		Page<News> tempPage = newsDao.findAll(new PageRequest(pageNo-1,pageSize,new Sort(Direction.DESC,"id","priority")));
		PageRainier<News> page = new PageRainier<News>(tempPage.getTotalElements(),pageNo,pageSize);
		page.setResult(tempPage.getContent());
		return page;
	}
	
	public News saveNews(News news) {
		try {
			return newsDao.save(news);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	public News loadNews(Integer id){
		return newsDao.findOne(id);
	}

	public boolean delNews(News news) {
		try{
			newsDao.delete(news);
			return true;
		}catch(Exception e){
			e.printStackTrace();
		}
		return false;
	}

	public void updateClicks(News news) {
		try{
			newsDao.updateClicks(news.getId(),news.getClicks()+1);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	/**
	 * @param id
	 * @param depth 
	 * @return
	 */
	
	public long count() {
		return newsDao.count();
	}

	public void insertOfBatch(List<News> tempNewsList) {
		newsDao.save(tempNewsList);
	}
	
	public Specification<News> countByColIdSpec(final Integer colId, final int depth){
		return new Specification<News>(){
			@Override
			public Predicate toPredicate(Root<News> root,
					CriteriaQuery<?> query, CriteriaBuilder cb) {
				Predicate predicate = cb.and(cb.isNotNull(root.<Date>get("publishDate")),
						cb.equal(root.get("column").<Integer>get("id"), colId));
				if(1==depth){
					//一级栏目
					return cb.or(predicate,cb.like(root.<String>get("depth"),String.valueOf(colId)+"-%"));
				}else if(2==depth){
					//二级栏目
					return cb.or(predicate,cb.like(root.<String>get("depth"), "%-"+String.valueOf(colId)+"-%"));
				}else if(3==depth){
					//三级栏目
					return predicate;
				}
				return null;
			}
		};
	}
	
	/**
	 * 根据栏目id，查询该栏目下所有的文章，包括子栏目下的文章
	 * @param colId
	 * @param depth
	 * @return
	 */
	public long countByColId(Integer colId, int depth) {
		return newsDao.count(countByColIdSpec(colId,depth));
	}

	public PageRainier<News> findAllByColId(int pageNo, Integer pageSize,
			Integer colId, int depth) {
		Page<News> tempPage = newsDao.findAll(countByColIdSpec(colId,depth), 
				new PageRequest(pageNo-1,pageSize,new Sort(Direction.DESC,"id","priority")));
		PageRainier<News> page = new PageRainier<News>(tempPage.getTotalElements(),pageNo,pageSize);
		page.setResult(tempPage.getContent());
		return page;
	}
}
