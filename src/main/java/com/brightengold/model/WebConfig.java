package com.brightengold.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;

@Table
@Entity
public class WebConfig implements Serializable {
	/** 
	 * @since JDK 1.7 
	 */ 
	private static final long serialVersionUID = 3408093442472626994L;
	private Integer id;
	//网站的关键字
	private String kws;
	//网站bottom
	private String bottom;
	//修改时间
	private Date updateTime;
	
	@Id
	@GeneratedValue
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	@Column(length=100)
	public String getKws() {
		return kws;
	}
	public void setKws(String kws) {
		this.kws = kws;
	}
	@Lob
	public String getBottom() {
		return bottom;
	}
	public void setBottom(String bottom) {
		this.bottom = bottom;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
}
