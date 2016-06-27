package com.brightengold.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;

/**
 * 前台菜单栏目表
 * @author li.n1
 *
 */
@Entity
@Table(name="information")
public class Info implements Serializable {
	/**
	 * 序列化
	 */
	private static final long serialVersionUID = 4264597876362136030L;
	private Integer id;
	/**
	 * 名称
	 */
	private String name;
	/**
	 * 代码
	 */
	private String code;
	/**
	 * 内容
	 */
	private String content;
	/**
	 * 跳转url
	 */
	private String url;
	/**
	 * 优先值
	 */
	private int priority;
	@Id
	@GeneratedValue
	public Integer getId() {
		return id;
	}
	public String getName() {
		return name;
	}
	public String getCode() {
		return code;
	}
	@Lob
	public String getContent() {
		return content;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public void setContent(String content) {
		this.content = content;
	}
	@Column(length=100)
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public int getPriority() {
		return priority;
	}
	public void setPriority(int priority) {
		this.priority = priority;
	}
}
