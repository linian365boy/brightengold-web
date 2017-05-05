package com.brightengold.vo;

import java.io.Serializable;
import java.util.List;

/**
 * @ClassName: ReturnData  
 * @Description: 分页列表返回数据 
 * @date: 2016年10月24日 下午7:08:40 
 * 
 * @author tanfan 
 * @version  
 * @since JDK 1.7
 */
public class ReturnData<T> implements Serializable {
	/** 
	 * serialVersionUID:序列化
	 * @since JDK 1.7 
	 */ 
	private static final long serialVersionUID = 5452016958372450765L;
	
	private long total;
	private List<T> rows;
	
	public ReturnData(){}
	
	public ReturnData(long total, List<T> rows) {
		this.total = total;
		this.rows = rows;
	}
	
	public long getTotal() {
		return total;
	}
	public void setTotal(long total) {
		this.total = total;
	}
	public List<T> getRows() {
		return rows;
	}
	public void setRows(List<T> rows) {
		this.rows = rows;
	}
}