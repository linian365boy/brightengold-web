package com.brightengold.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import com.brightengold.common.vo.RequestParam;
import com.brightengold.model.Product;

public interface ProductDao {
	//@Query("select count(*) from Product pr join pr.category ca join ca.column co where (co.id = :id or co.parentColumn.id = :id) and pr.status is true and pr.publish is true")
	long countByColId(@Param("id") Integer id);
	//@Query("select pr from Product pr join pr.category ca join ca.column co where co.id = :id or co.parentColumn.id = :id order by pr.priority desc,pr.hot desc,pr.id desc")
	//List<Product> findListByColId(@Param("id") Integer id);
	//@Query("select count(pr.id) from Product pr where (pr.category.id = :cateId or pr.category.parent.id = :cateId) and pr.status is true and pr.publish is true")
	long countByCateId(@Param("cateId") int cateId);
	//@Query("select pr from Product pr where pr.category.id = :cateId and pr.status is true and pr.publish is true order by pr.priority desc,pr.hot desc,pr.id desc")
	List<Product> findAllListByCateId(@Param("cateId") Integer catId);
	//@Modifying
	//@Query("update Product set status = :status where id = :id")
	void updateStatus(@Param("id") Integer id,@Param("status") boolean status);
	
	Product findOne(Integer productId);
	
	void save(Product product);
	
	void delete(Integer productId);
	
	List<Product> findIndexPic(int pageSize);
	
	void save(List<Product> productList);
	
	List<Product> findList(RequestParam param);
	
	List<Product> findAllReleaseProductByLikeKeyWordList(RequestParam param);
	
	long countAllReleaseProductByLikeKeyword(RequestParam param);
	
	List<Product> findListByColId(@Param("colId") Integer colId,@Param("start") int start,@Param("pageSize") Integer pageSize);
	
	long findAllCount(RequestParam param);
	
	List<Product> findAllListByCateId(@Param("cateId") Integer cateId,@Param("start") int start,@Param("pageSize") Integer pageSize);
	
	void updateProduct(Product product);
	
}
