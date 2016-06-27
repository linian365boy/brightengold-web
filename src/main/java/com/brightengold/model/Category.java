package com.brightengold.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
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

import cn.rainier.nian.model.User;

@Entity
@Table
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
	private Category parent;
	/**
	 * 产品创建日期
	 */
	private Date createDate;
	/**
	 * 产品创建人
	 */
	private User createUser;
	/**
	 * 分类所在的栏目下
	 */
	private com.brightengold.model.Column column;
	private List<Category> children;
	private List<Product> products;
	//备注
	private String remark;
	
	@Id
	@GeneratedValue
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	@Column(length=25)
	public String getEnName() {
		return enName;
	}
	public void setEnName(String enName) {
		this.enName = enName;
	}
	
	@ManyToOne(fetch=FetchType.LAZY,cascade=CascadeType.PERSIST)
	@JoinColumn(name="pid")
	public Category getParent() {
		return parent;
	}
	public void setParent(Category parent) {
		this.parent = parent;
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
	@OneToMany(cascade={CascadeType.MERGE},mappedBy="parent",fetch=FetchType.LAZY)
	public List<Category> getChildren() {
		return children;
	}
	public void setChildren(List<Category> children) {
		this.children = children;
	}
	@OneToMany(cascade={CascadeType.MERGE},mappedBy="category",fetch=FetchType.LAZY)
	public List<Product> getProducts() {
		return products;
	}
	public void setProducts(List<Product> products) {
		this.products = products;
	}
	@ManyToOne(fetch=FetchType.LAZY,cascade=CascadeType.PERSIST)
	@JoinColumn(name="columnId")
	public com.brightengold.model.Column getColumn() {
		return column;
	}
	public void setColumn(com.brightengold.model.Column column) {
		this.column = column;
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
}
