package com.brightengold.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.brightengold.dao.NewsDao;
import com.brightengold.model.News;

import cn.rainier.nian.utils.PageRainier;

@Component("newsService")
public class NewsService {
	@Autowired
	private NewsDao newsDao;
	private static Logger logger = LoggerFactory.getLogger(NewsService.class);
	
	public PageRainier<News> findAll(Integer pageNo, Integer pageSize) {
		//Page<News> tempPage = newsDao.findAll(new PageRequest(pageNo-1,pageSize,new Sort(Direction.DESC,"id","priority")));
		long count = newsDao.findAllCount();
		PageRainier<News> page = new PageRainier<News>(count,pageNo,pageSize);
		page.setResult(newsDao.findList((pageNo-1)*pageSize,pageSize));
		return page;
	}
	
	public boolean saveNews(News news) {
		boolean flag = false;
		try {
			newsDao.save(news);
			flag = true;
		} catch (Exception e) {
			logger.error("添加新闻报错",e);
		}
		return flag;
	}
	public News loadNews(Integer id){
		return newsDao.findOne(id);
	}

	public boolean delNews(Integer newsId) {
		try{
			newsDao.delete(newsId);
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

	public void insertOfBatch(List<News> tempNewsList) {
		newsDao.save(tempNewsList);
	}
	
	/*public Specification<News> countByColIdSpec(final Integer colId, final int depth){
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
	}*/
	
	/**
	 * 根据栏目id，查询该栏目下所有的文章，包括子栏目下的文章
	 * @param colId
	 * @param depth
	 * @return
	 */
	public long countByColId(Integer colId, int depth) {
		return newsDao.countByColId(colId,depth);
	}

	public PageRainier<News> findAllByColId(int pageNo, Integer pageSize,
			Integer colId, int depth) {
		//Page<News> tempPage = newsDao.findAll(countByColIdSpec(colId,depth), 
		//		new PageRequest(pageNo-1,pageSize,new Sort(Direction.DESC,"id","priority")));
		long count = newsDao.findAllCountByColId(colId,depth);
		PageRainier<News> page = new PageRainier<News>(count,pageNo,pageSize);
		page.setResult(newsDao.findList((pageNo-1)*pageSize, pageSize));
		return page;
	}

	public List<News> findIndexPic(int indexNewsSize) {
		//Page<News> tempPage = newsDao.findAll(findIndexNewsSpec(), 
		//		new PageRequest(0,indexNewsSize,new Sort(Direction.DESC,"priority","createDate")));
		return newsDao.findIndexNews(indexNewsSize);
	}

	/*private Specification<News> findIndexNewsSpec() {
		return new Specification<News>(){
			@Override
			public Predicate toPredicate(Root<News> root,
					CriteriaQuery<?> query, CriteriaBuilder cb) {
				return cb.and(cb.isNotNull(root.<Date>get("publishDate")));
			}
		};
	}*/
	
}
