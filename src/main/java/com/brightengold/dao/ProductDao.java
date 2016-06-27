package com.brightengold.dao;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import cn.rainier.nian.dao.base.AbstractDao;

import com.brightengold.model.Product;

public interface ProductDao extends AbstractDao<Product, Integer>{
	@Query("select count(*) from Product pr join pr.category ca join ca.column co where co.id = :id or co.parentColumn.id = :id")
	long countByColId(@Param("id") Integer id);
	@Query("select pr from Product pr join pr.category ca join ca.column co where co.id = :id or co.parentColumn.id = :id order by pr.createDate desc")
	List<Product> findListByColId(@Param("id") Integer id);
	@Query("select count(*) from Product pr where pr.category.id = :cateId")
	long countByCateId(@Param("cateId") int cateId);
	@Query("select pr from Product pr where pr.category.id = :cateId")
	List<Product> findListByCateId(@Param("cateId") int cateId);
	@Query("select pr from Product pr where pr.category.id = :cateId and pr.status is true and pr.publish is true order by hot,createDate")
	List<Product> findAllListByCateId(@Param("cateId") int catId);
	@Modifying
	@Query("update Product set status = :status where id = :id")
	void updateStatus(@Param("id") Integer id,@Param("status") boolean status);
}
