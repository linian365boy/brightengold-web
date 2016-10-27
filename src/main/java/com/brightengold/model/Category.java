package com.brightengold.model;

import java.io.Serializable;
import java.util.Date;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Category implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	/**
	 * 产品类型中文名称
	 */
	private String name;
	/**
	 * 产品类型名称
	 */
	private String enName;
	/**
	 * 产品父类型
	 */
	private Integer parentId;
	/**
	 * 产品创建日期
	 */
	@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
	private Date createDate;
	/**
	 * 产品创建人
	 */
	private Integer createUserId;
	/**
	 * 分类所在的栏目下
	 */
	private Integer columnId;
	//备注
	private String remark;
	
	//临时变量
	private transient long productsSize;
	//父类分类名称
	private String parentName;
	//分类所在的栏目名称
	private String columnName;
	
	//使用mybatis resuleMap的setter getter方式注入属性，必须要有一个空参数的构造方法
	public Category(){}
	
	public Category(int id, String name, String enName) {
		this.id = id;
		this.name = name;
		this.enName = enName;
	}
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getEnName() {
		return enName;
	}
	public void setEnName(String enName) {
		this.enName = enName;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public long getProductsSize() {
		return productsSize;
	}
	public void setProductsSize(long productsSize) {
		this.productsSize = productsSize;
	}
	public Integer getParentId() {
		return parentId;
	}
	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}
	public Integer getCreateUserId() {
		return createUserId;
	}
	public void setCreateUserId(Integer createUserId) {
		this.createUserId = createUserId;
	}
	public Integer getColumnId() {
		return columnId;
	}
	public void setColumnId(Integer columnId) {
		this.columnId = columnId;
	}
	public String getParentName() {
		return parentName;
	}
	public void setParentName(String parentName) {
		this.parentName = parentName;
	}
	public String getColumnName() {
		return columnName;
	}
	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
	}
}
