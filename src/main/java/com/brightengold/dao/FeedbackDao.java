package com.brightengold.dao;

import com.brightengold.common.vo.RequestParam;
import com.brightengold.model.Feedback;

import java.util.List;

public interface FeedbackDao  {
    Feedback findOne(Integer id);

    void delete(Integer id);

    void save(Feedback feedback);

    long findAllCount(RequestParam param);

    List<Feedback> findList(RequestParam param);
}
