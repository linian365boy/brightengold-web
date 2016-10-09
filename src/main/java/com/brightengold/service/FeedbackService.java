package com.brightengold.service;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.brightengold.dao.FeedbackDao;
import com.brightengold.model.Feedback;

import cn.rainier.nian.utils.PageRainier;

@Service("feedbackService")
public class FeedbackService {
	@Autowired
	private FeedbackDao feedbackDao;

	public PageRainier<Feedback> findAll(Integer pageNo, Integer pageSize) {
		//Page<Feedback> tempPage = feedbackDao.findAll(new PageRequest(pageNo-1,pageSize,new Sort(Direction.DESC,"id")));
		long count = feedbackDao.findAllCount();
		PageRainier<Feedback> page = new PageRainier<Feedback>(count,pageNo,pageSize);
		page.setResult(feedbackDao.findList((pageNo-1)*pageSize,pageSize));
		return page;
	}

	public Feedback loadOne(Integer id) {
		return feedbackDao.findOne(id);
	}

	public void delete(Integer id) {
		feedbackDao.delete(id);
	}

	public void addFeedback(Feedback feedback) {
		feedback.setCreateTime(new Date());
		feedbackDao.save(feedback);
	}
	
}
