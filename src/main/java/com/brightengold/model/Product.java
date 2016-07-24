package com.brightengold.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import cn.rainier.nian.model.User;

@Entity
@Table
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
	private Category category;
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
	private User createUser;
	/**
	 * 发布后的页码
	 */
	private int pageNum;
	/**
	 * 锁定或正常两种状态
	 * true正常  false锁定
	 */
	private boolean status;
	/**
	 * 产品关键字，相关产品显示需要，分号隔开不同的关键字
	 */
	private String keyWords;
	
	@Id
	@GeneratedValue
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	@Column(length=30)
	public String getEnName() {
		return enName;
	}
	public void setEnName(String enName) {
		this.enName = enName;
	}
	@ManyToOne(fetch=FetchType.LAZY,cascade=CascadeType.PERSIST)
	@JoinColumn(name="categoryId")
	public Category getCategory() {
		return category;
	}
	public void setCategory(Category category) {
		this.category = category;
	}
	@Column(length=100)
	public String getPicUrl() {
		return picUrl;
	}
	public void setPicUrl(String picUrl) {
		this.picUrl = picUrl;
	}
	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}
	@Column(length=100)
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	@Temporal(TemporalType.DATE)
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	@ManyToOne(cascade={CascadeType.MERGE})
	@JoinColumn(name="createUserId")
	public User getCreateUser() {
		return createUser;
	}
	public void setCreateUser(User createUser) {
		this.createUser = createUser;
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
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	@Lob
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
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
	}
}
