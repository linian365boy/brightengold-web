package com.brightengold.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.brightengold.common.vo.RequestParam;
import com.brightengold.model.Feedback;

@Mapper
public interface FeedbackDao {

	Feedback findOne(Integer id);

	void delete(Integer id);

	void save(Feedback feedback);

	long findAllCount(RequestParam param);

	List<Feedback> findList(RequestParam param);

}
