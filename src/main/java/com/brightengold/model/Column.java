package com.brightengold.model;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;

/**
 * 前台菜单栏目表
 * @author li.n1
 *
 */
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
	private Integer parentId;
	/**
	 * 优先值（排序用），越大排名越前，默认为0
	 */
	private Integer priority;
	/**
	 * 创建日期
	 */
	private Date createDate;
	/**
	 /**
	 * 栏目代码，唯一
	 */
	private String code;
	//方便显示到第几深度
	//存储类似：1，表示本栏目是深度为1，一级栏目,2表示为二级栏目,3表示为三级栏目
	//冗余字段
	private int depth = 1;

	/**
	 * 栏目页面发布的类型，
	 * 区别即显示标题还是内容的页面
	 * 0　info填充信息的页面
	 * 1　产品列表展示的页面
	 * 2  文章标题列表的页面
	 */
	private int type;

	/**
	 * false: 默认不需要表单嵌入
	 * true: 栏目发布的页面嵌入表单
	 */
	private boolean hasNeedForm = false;

	//临时变量
	private String parentName;
	//子栏目
	private transient Set<Column> childColumn;

	//使用mybatis resuleMap的setter getter方式注入属性，必须要有一个空参数的构造方法
	public Column(){}

	public Column(int id, String name, String enName) {
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
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
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
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
	public boolean isHasNeedForm() {
		return hasNeedForm;
	}
	public void setHasNeedForm(boolean hasNeedForm) {
		this.hasNeedForm = hasNeedForm;
	}
	public Integer getParentId() {
		return parentId;
	}
	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}
	public String getParentName() {
		return parentName;
	}
	public void setParentName(String parentName) {
		this.parentName = parentName;
	}
	public Set<Column> getChildColumn() {
		return childColumn;
	}
	public void setChildColumn(Set<Column> childColumn) {
		this.childColumn = childColumn;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
	}
}
