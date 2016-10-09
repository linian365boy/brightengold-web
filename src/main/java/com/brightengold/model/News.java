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

@Entity
@Table
public class News implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	/**
	 * 新闻标题
	 */
	private String title;
	/**
	 * 新闻摘要
	 */
	private String introduce;
	/**
	 * 新闻内容
	 */
	private String content;
	/**
	 * 新闻优先值
	 */
	private Integer priority;
	/**
	 * 新闻url,静态页面发布以后才有
	 */
	private String url;
	/**
	 * 新闻创建日期
	 */
	private Date createDate;
	/**
	 * 新闻发布日期
	 */
	private Date publishDate;
	/**
	 * 点击率
	 */
	private Integer clicks;
	/**
	 * 关键字
	 */
	private String keyWords;
	/**
	 * 新闻发布所在的栏目下
	 */
	private com.brightengold.model.Column column;
	/**
	 * 新闻类型，
	 * 0文章类型，内容含文字或图片或视频　　
	 * 1（产品）图片类型，内容不含文字，只能上传图片
	 * 默认为0　文章类型
	 */
	private boolean type;
	/**
	 * 文章深度
	 * 存储格式:1-2 表示该文章在一级id为1的栏目下，同时也在二级id为2的栏目下
	 */
	private String depth;
	
	@Id
	@GeneratedValue
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	@Column(length=300)
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	@Lob
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Integer getPriority() {
		return priority;
	}
	public void setPriority(Integer priority) {
		this.priority = priority;
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
	@Temporal(TemporalType.DATE)
	public Date getPublishDate() {
		return publishDate;
	}
	public void setPublishDate(Date publishDate) {
		this.publishDate = publishDate;
	}
	public Integer getClicks() {
		return clicks;
	}
	public void setClicks(Integer clicks) {
		this.clicks = clicks;
	}
	public String getKeyWords() {
		return keyWords;
	}
	public void setKeyWords(String keyWords) {
		this.keyWords = keyWords;
	}
	@Column(length=500)
	public String getIntroduce() {
		return introduce;
	}
	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}
	@ManyToOne(fetch=FetchType.LAZY,cascade=CascadeType.PERSIST)
	@JoinColumn(name="columnId")
	public com.brightengold.model.Column getColumn() {
		return column;
	}
	public void setColumn(com.brightengold.model.Column column) {
		this.column = column;
	}
	public boolean getType() {
		return type;
	}
	public void setType(boolean type) {
		this.type = type;
	}
	public String getDepth() {
		return depth;
	}
	public void setDepth(String depth) {
		this.depth = depth;
	}
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
	}
}
