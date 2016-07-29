package com.brightengold.vo;

import java.io.Serializable;

public class MessageVo implements Serializable {
	/** 
	 * serialVersionUID:序列化
	 * @since JDK 1.7 
	 */ 
	private static final long serialVersionUID = 8889060235097707064L;
	
	/**
	 * 返回码
	 * 200 正常
	 * 500 错误
	 */
	private int code;
	/**
	 * 提示
	 * 200 正常提示
	 * 500 错误提示
	 */
	private String message;
	/**
	 * 返回数据
	 * 有时需要返回给前台数据
	 */
	private Object data;
	
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public Object getData() {
		return data;
	}
	public void setData(Object data) {
		this.data = data;
	}
}
