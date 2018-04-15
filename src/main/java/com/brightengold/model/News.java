package com.brightengold.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import java.io.Serializable;
import java.util.Date;

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
	@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
	private Date createDate;
	/**
	 * 新闻发布日期
	 */
	@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
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
	private Integer columnId;
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


	//临时变量
	private String columnName;

	public News(){}

	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
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
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
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
	public String getIntroduce() {
		return introduce;
	}
	public void setIntroduce(String introduce) {
		this.introduce = introduce;
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
	public Integer getColumnId() {
		return columnId;
	}
	public void setColumnId(Integer columnId) {
		this.columnId = columnId;
	}
	public String getColumnName() {
		return columnName;
	}
	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
	}
}
