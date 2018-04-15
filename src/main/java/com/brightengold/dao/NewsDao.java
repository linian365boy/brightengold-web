package com.brightengold.dao;

import com.brightengold.common.vo.RequestParam;
import com.brightengold.model.News;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface NewsDao {

	public void updateClicks(@Param("newsId") Integer newsId, @Param("clicks") Integer clicks);

	public void save(News news);

	public News findOne(Integer id);

	public void delete(Integer newsId);

	public void save(List<News> tempNewsList);

	public long findAllCount(RequestParam param);

	public List<News> findList(RequestParam param);

	public List<News> findIndexNews(int indexNewsSize);

	public long findAllCountByColId(@Param("colId") Integer colId,@Param("depth") int depth);

	public long countByColId(@Param("colId") Integer colId,@Param("depth") int depth);

	public void updateNews(News news);

}
