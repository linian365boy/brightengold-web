package com.brightengold.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.brightengold.model.Feedback;

public interface FeedbackDao {

	Feedback findOne(Integer id);

	void delete(Integer id);

	void save(Feedback feedback);

	long findAllCount();

	List<Feedback> findList(@Param("start") Integer start,@Param("pageSize") Integer pageSize);

}
