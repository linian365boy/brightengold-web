package com.brightengold.dao;

import java.util.List;
import com.brightengold.common.vo.RequestParam;
import com.brightengold.model.Feedback;

public interface FeedbackDao {

	Feedback findOne(Integer id);

	void delete(Integer id);

	void save(Feedback feedback);

	long findAllCount();

	List<Feedback> findList(RequestParam param);

}
