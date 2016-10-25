package com.brightengold.vo;

import java.io.Serializable;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.apache.commons.lang3.builder.ToStringBuilder;

/**
 * @ClassName: RequestParam  
 * @Description: 封装列表查询的参数 
 * @date: 2016年10月25日 下午5:10:54 
 * 
 * @author tanfan 
 * @version  
 * @since JDK 1.7
 */
public class RequestParam implements Serializable {
	/** 
	 * serialVersionUID:序列化 
	 * @since JDK 1.7 
	 */ 
	private static final long serialVersionUID = 7534737197181357144L;
	/**
	 * 查询关键字
	 */
	private String search;
	/**
	 * 排序（顺序，倒序）
	 */
	private String order;
	/**
	 * 偏移量
	 */
	private int offset;
	/**
	 * 每页展示条数
	 */
	private int limit;
	
	public String getSearch() {
		return search;
	}
	public void setSearch(String search) {
		this.search = search;
	}
	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}
	public int getOffset() {
		return offset;
	}
	public void setOffset(int offset) {
		this.offset = offset;
	}
	public int getLimit() {
		if(limit==0){
			limit=10;
		}
		return limit;
	}
	public void setLimit(int limit) {
		this.limit = limit;
	}
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this,ToStringStyle.SHORT_PREFIX_STYLE);
	}
}
