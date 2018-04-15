package com.brightengold.service;

import cn.rainier.nian.utils.PageRainier;
import com.brightengold.common.vo.RequestParam;
import com.brightengold.dao.FeedbackDao;
import com.brightengold.model.Feedback;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;

@Component("feedbackService")
public class FeedbackService {

	@Autowired
	private FeedbackDao feedbackDao;

	public PageRainier<Feedback> findAll(RequestParam param) {
		long count = feedbackDao.findAllCount(param);
		PageRainier<Feedback> page = new PageRainier<Feedback>(count);
		page.setResult(feedbackDao.findList(param));
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
