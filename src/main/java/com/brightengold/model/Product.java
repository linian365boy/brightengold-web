package com.brightengold.model;

import java.io.Serializable;
import java.util.Date;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class Product implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	/**
	 * 产品名称
	 */
	private String enName;
	/**
	 * 产品种类
	 */
	private Integer categoryId;
	/**
	 * 图片url
	 */
	private String picUrl;
	/**
	 * 产品简介
	 */
	private String introduce;
	/**
	 * 产品详情描述
	 */
	private String description;
	/**
	 * 是否热门
	 */
	private boolean hot;
	/**
	 * 产品跳转url，静态页面使用
	 */
	private String url;
	/**
	 * 是否发布
	 * true 发布  false 未发布
	 */
	private boolean publish;
	/**
	 * 产品创建日期
	 */
	private Date createDate;
	/**
	 * 产品创建人
	 */
	private Integer createUserId;
	/**
	 * 锁定或正常两种状态
	 * true正常  false锁定
	 */
	private boolean status;
	/**
	 * 产品关键字，相关产品显示需要，分号隔开不同的关键字
	 */
	private String keyWords;
	/**
	 * 排序值（越大排名越前，默认为0）
	 */
	private Integer priority;
	
	//临时变量
	private String categoryEnName;
	
	public Product(){}
	
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
	public String getPicUrl() {
		return picUrl;
	}
	public void setPicUrl(String picUrl) {
		this.picUrl = picUrl;
	}
	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public boolean isHot() {
		return hot;
	}
	public void setHot(boolean hot) {
		this.hot = hot;
	}
	public boolean isPublish() {
		return publish;
	}
	public void setPublish(boolean publish) {
		this.publish = publish;
	}
	public String getIntroduce() {
		return introduce;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public boolean isStatus() {
		return status;
	}
	public void setStatus(boolean status) {
		this.status = status;
	}
	public String getKeyWords() {
		return keyWords;
	}
	public void setKeyWords(String keyWords) {
		this.keyWords = keyWords;
	}
	
	public Integer getPriority() {
		return priority;
	}
	public void setPriority(Integer priority) {
		this.priority = priority;
	}
	public Integer getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(Integer categoryId) {
		this.categoryId = categoryId;
	}
	public Integer getCreateUserId() {
		return createUserId;
	}
	public void setCreateUserId(Integer createUserId) {
		this.createUserId = createUserId;
	}
	public String getCategoryEnName() {
		return categoryEnName;
	}
	public void setCategoryEnName(String categoryEnName) {
		this.categoryEnName = categoryEnName;
	}
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
	}
}
