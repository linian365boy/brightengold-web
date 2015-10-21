package com.brightengold.vo;

import java.io.Serializable;

public class ResultVo<T> implements Serializable {
	private static final long serialVersionUID = -6578704371684617065L;
	/**
	 * 200  正常，成功
	 * 500  错误，不成功
	 */
	private int code;
	private String message;
	private T obj;
	
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
	public T getObj() {
		return obj;
	}
	public void setObj(T obj) {
		this.obj = obj;
	}
}
