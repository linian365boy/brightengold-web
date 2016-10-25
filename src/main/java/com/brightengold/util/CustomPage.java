package com.brightengold.util;

import java.io.Serializable;

/**
 * @ClassName: CustomPage  
 * @Description: 自定义分页组件 
 * @date: 2016年10月24日 下午6:46:31 
 * 
 * @author tanfan 
 * @version  
 * @since JDK 1.7
 */
public class CustomPage implements Serializable {
	/** 
	 * serialVersionUID:序列化
	 * @since JDK 1.7 
	 */ 
	private static final long serialVersionUID = -4903809804362068940L;
	private int draw;
	private int start;
	private int length;
	public int getDraw() {
		return draw;
	}
	
	public void setDraw(int draw) {
		this.draw = draw;
	}
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getLength() {
		return length;
	}
	public void setLength(int length) {
		this.length = length;
	}
	
}
