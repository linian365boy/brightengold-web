package com.brightengold.util;

public class Constant {
	/**
	 * 一般用于表示状态为锁定
	 */
	public static final int C_ZERO = 0;
	/**
	 * 一般用于表示状态为正常
	 */
	public static final int C_ONE = 1;
	
	public static final String HTMLPRE = "/views/html";
	/**
	 * 栏目路径前缀
	 */
	public static final String COLUMNPATHPRE = HTMLPRE+"/col";
	/**
	 * 生成的产品相关页面路径
	 */
	public static final String PRODUCTPRE = HTMLPRE+"/product";
	/**
	 * 生成的产品页面路径，页面展示需要ssi嵌入
	 */
	public static final String PRODUCTPATH = PRODUCTPRE + "/detail";
	/**
	 * 生成的新闻相关页面路径前缀
	 */
	public static final String NEWSPRE = HTMLPRE + "/news";
	/**
	 * 生成的新闻页面路径，页面展示需要ssi嵌入
	 */
	public static final String NEWSPATH = NEWSPRE + "/detail";
	/**
	 * 生成的分类产品列表页面路径，页面展示需要ssi嵌入
	 */
	public static final String CATEGORYPRODUCTPATH = HTMLPRE + "/col";
	
	/**
	 * 生成的分类产品详情页面路径
	 */
	public static final String CATEGORYDETAILPRODUCTPATH = HTMLPRE + "/product";
	
	public static final int PAGE_INDEX_SIZE = 16;
	
}
