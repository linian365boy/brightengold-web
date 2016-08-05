package com.brightengold.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Component;
import cn.rainier.nian.utils.PageRainier;
import com.brightengold.dao.FeedbackDao;
import com.brightengold.model.Feedback;

@Component("feedbackService")
public class FeedbackService {
	@Autowired
	private FeedbackDao feedbackDao;

	public PageRainier<Feedback> findAll(Integer pageNo, Integer pageSize) {
		Page<Feedback> tempPage = feedbackDao.findAll(new PageRequest(pageNo-1,pageSize,new Sort(Direction.DESC,"id")));
		PageRainier<Feedback> page = new PageRainier<Feedback>(tempPage.getTotalElements(),pageNo,pageSize);
		page.setResult(tempPage.getContent());
		return page;
	}

	public Feedback loadOne(Integer id) {
		return feedbackDao.findOne(id);
	}

	public void delete(Integer id) {
		feedbackDao.delete(id);
	}

	public void addFeedback(Feedback feedback) {
		feedbackDao.save(feedback);
	}
	
}
