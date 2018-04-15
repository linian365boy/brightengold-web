package com.brightengold.dao;

import com.brightengold.common.vo.RequestParam;
import com.brightengold.model.Log;

import java.util.List;

public interface LogDao {
    void save(Log log);

    long findAllCount(RequestParam param);

    List<Log> findList(RequestParam param);
}
