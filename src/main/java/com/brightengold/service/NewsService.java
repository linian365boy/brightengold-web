package com.brightengold.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Component;

import cn.rainier.nian.utils.PageRainier;

import com.brightengold.dao.NewsDao;
import com.brightengold.model.Category;
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
}
