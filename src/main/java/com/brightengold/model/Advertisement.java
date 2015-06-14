package com.brightengold.model;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table
public class Advertisement implements Serializable {
	private static final long serialVersionUID = -5638792445671644739L;
	private Integer id;
	/**
	 * 广告名称
	 */
	private String name;
	/**
	 * 图片路径
	 */
	private String picUrl;
	/**
	 * 广告宽度
	 */
	private int width;
	/**
	 * 广告高度
	 */
	private int height;
	/**
	 * 广告跳转url
	 */
	private String url;
	/**
	 * 广告排名
	 * 越大排名越前
	 */
	private Integer priority;
	/**
	 * 创建日期
	 */
	private Date createDate;
	/**
	 * 状态
	 * 1正常  0锁定
	 * 默认为1 正常
	 */
	private int status;
	@Id
	@GeneratedValue
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	@Column(length=50)
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getWidth() {
		return width;
	}
	public void setWidth(int width) {
		this.width = width;
	}
	public int getHeight() {
		return height;
	}
	public void setHeight(int height) {
		this.height = height;
	}
	@Column(length=100)
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public Integer getPriority() {
		return priority;
	}
	public void setPriority(Integer priority) {
		this.priority = priority;
	}
	
	@Temporal(TemporalType.TIMESTAMP)
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getPicUrl() {
		return picUrl;
	}
	public void setPicUrl(String picUrl) {
		this.picUrl = picUrl;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
}
