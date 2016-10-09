package com.brightengold.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import cn.rainier.nian.model.Menu;

@Entity
@Table
public class Log implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 6469655628699816755L;
	private Integer id;
	/**
	 * 操作内容
	 */
	private String content;
	/**
	 * 操作类型
	 */
	private String type;
	/**
	 * 操作人
	 */
	private String operator;
	/**
	 * 操作人姓名
	 */
	private String operatorRealName;
	/**
	 * 操作模块
	 */
	private Menu menu;
	/**
	 * 操作T时间
	 */
	private Date createTime;
	/**
	 * 备用字段
	 */
	private String temp1;
	private String temp2;
	
	@Id
	@GeneratedValue
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	@Column(length=500)
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	@Column(length=10)
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	@ManyToOne(cascade={CascadeType.MERGE})
	@JoinColumn(name="menu")
	public Menu getMenu() {
		return menu;
	}
	public void setMenu(Menu menu) {
		this.menu = menu;
	}
	@Temporal(TemporalType.TIMESTAMP)
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public String getTemp1() {
		return temp1;
	}
	public void setTemp1(String temp1) {
		this.temp1 = temp1;
	}
	public String getTemp2() {
		return temp2;
	}
	public void setTemp2(String temp2) {
		this.temp2 = temp2;
	}
	public String getOperatorRealName() {
		return operatorRealName;
	}
	public void setOperatorRealName(String operatorRealName) {
		this.operatorRealName = operatorRealName;
	}
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
	}
}
