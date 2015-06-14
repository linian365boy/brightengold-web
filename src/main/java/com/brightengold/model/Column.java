package com.brightengold.model;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * 前台菜单栏目表
 * @author li.n1
 *
 */
@Entity
@Table(name="columns")
public class Column implements Serializable{
	/**
	 * 序列化
	 */
	private static final long serialVersionUID = 2393928737707029978L;
	private Integer id;
	/**
	 * 栏目名称
	 */
	private String name;
	/**
	 * 栏目跳转url
	 */
	private String url;
	/**
	 * 父栏目
	 */
	private Column parentColumn;
	/**
	 * 优先值（排序用），越大排名越前，默认为0
	 */
	private Integer priority;
	/**
	 * 创建日期
	 */
	private Date createDate;
	/**
	 * 子栏目
	 */
	private Set<Column> childColumn;
	/**
	 * 栏目代码，唯一
	 */
	private String code;
	
	@Id
	@GeneratedValue
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	@javax.persistence.Column(length=20)
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	@javax.persistence.Column(length=100)
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	@ManyToOne(fetch=FetchType.LAZY,cascade=CascadeType.PERSIST)
	@JoinColumn(name="pid")
	public Column getParentColumn() {
		return parentColumn;
	}
	public void setParentColumn(Column parentColumn) {
		this.parentColumn = parentColumn;
	}
	public Integer getPriority() {
		return priority;
	}
	public void setPriority(Integer priority) {
		this.priority = priority;
	}
	@Temporal(TemporalType.DATE)
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	@OneToMany(cascade={CascadeType.MERGE},mappedBy="parentColumn",fetch=FetchType.LAZY)
	public Set<Column> getChildColumn() {
		return childColumn;
	}
	public void setChildColumn(Set<Column> childColumn) {
		this.childColumn = childColumn;
	}
	@javax.persistence.Column(length=10)
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
}
