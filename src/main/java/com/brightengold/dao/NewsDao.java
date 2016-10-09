package com.brightengold.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.brightengold.model.News;

public interface NewsDao {
	//@Modifying
	//@Query("update News set clicks = ?2 where id = ?1")
	public void updateClicks(@Param("newsId") Integer newsId,@Param("clicks") Integer clicks);

	public void save(News news);

	public News findOne(Integer id);

	public void delete(Integer newsId);

	public void save(List<News> tempNewsList);

	public long findAllCount();

	public List<News> findList(@Param("start") Integer start,@Param("pageSize") Integer pageSize);

	public List<News> findIndexNews(int indexNewsSize);

	public long findAllCountByColId(@Param("colId") Integer colId,@Param("depth") int depth);

	public long countByColId(@Param("colId") Integer colId,@Param("depth") int depth);

}
