package com.brightengold.model;

import java.io.Serializable;
import java.util.Date;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

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
	private Integer menuId;
	/**
	 * 操作T时间
	 */
	private Date createTime;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
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
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public String getOperatorRealName() {
		return operatorRealName;
	}
	public void setOperatorRealName(String operatorRealName) {
		this.operatorRealName = operatorRealName;
	}
	public Integer getMenuId() {
		return menuId;
	}
	public void setMenuId(Integer menuId) {
		this.menuId = menuId;
	}
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
	}
}
