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

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

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
	 * 栏目中文名称
	 */
	private String name;
	/**
	 * 栏目英文名称
	 */
	private String enName;
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
	 * 栏目下的产品分类
	 */
	private Set<Category> categorys;
	/**
	 * 栏目代码，唯一
	 */
	private String code;
	//方便显示到第几深度
	//存储类似：1，表示本栏目是深度为1，一级栏目,2表示为二级栏目,3表示为三级栏目
	//冗余字段
	private int depth = 1;
	
	//发布时用到的一些设置
	/**
	 * 状态
	 * 1未发布　２发布
	 * 默认为1 未发布
	 */
	private int status;
	/**
	 * 栏目页面发布的类型，
	 * 区别即显示标题还是内容的页面
	 * 0　info填充信息的页面
	 * 1　产品列表展示的页面
	 * 2  文章标题列表的页面
	 */
	private int type;
	
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
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public String getEnName() {
		return enName;
	}
	public void setEnName(String enName) {
		this.enName = enName;
	}
	@OneToMany(cascade={CascadeType.MERGE},mappedBy="column",fetch=FetchType.LAZY)
	public Set<Category> getCategorys() {
		return categorys;
	}
	public void setCategorys(Set<Category> categorys) {
		this.categorys = categorys;
	}
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
	}
}
