package com.brightengold.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class SystemConfig {
	@Value("${index.ads.size}")
	private int indexAdsSize = 5;
	@Value("${cross.max.depth}")
	private int crossMaxDepth = 2;
	@Value("${vertical.max.depth}")
	private int verticalMaxDepth = 3;
	@Value("${index.product.size}")
	private int indexProductSize = 12;
	@Value("${index.news.size}")
	private int indexNewsSize = 8;
	//邮件发件人
	@Value("${email.from}")
	private String from;
	//邮件收件人
	@Value("${email.to}")
	private String to;
	//前端页面展示的公司介绍长度
	@Value("${company.length}")
	private int companyLength = 500;
	//存放html页面的路径地址
	@Value("${html.path}")
	private String htmlPath;
	//存放图片的路径地址
	@Value("${pic.path}")
	private String picPath;
	//存放公司信息配置的路径
	@Value("${companyConfig.path}")
	private String companyConfigPath;
	//存放网站配置信息的路径
	@Value("${webConfig.path}")
	private String webConfigPath;
	//静态资源访问url地址
	@Value("${static.accessPath}")
	private String staticAceessUrl;
	
	/**
	 * 首页滚动图片最大数量
	 * @return
	 */
	public int getIndexAdsSize() {
		return indexAdsSize;
	}
	/**
	 * 横条菜单最大显示深度
	 * @return
	 */
	public int getCrossMaxDepth() {
		return crossMaxDepth;
	}
	/**
	 * 竖条菜单最大显示深度
	 * @return
	 */
	public int getVerticalMaxDepth() {
		return verticalMaxDepth;
	}
	/**
	 * 首页展示的产品数量
	 * @return
	 */
	public int getIndexProductSize() {
		return indexProductSize;
	}
	/**
	 * 首页新闻数
	 * @return
	 */
	public int getIndexNewsSize() {
		return indexNewsSize;
	}
	public String getFrom() {
		return from;
	}
	public String getTo() {
		return to;
	}
	public int getCompanyLength() {
		return companyLength;
	}
	public String getHtmlPath() {
		return htmlPath;
	}
	public String getPicPath() {
		return picPath;
	}
	public String getCompanyConfigPath() {
		return companyConfigPath;
	}
	public void setCompanyConfigPath(String companyConfigPath) {
		this.companyConfigPath = companyConfigPath;
	}
	public String getWebConfigPath() {
		return webConfigPath;
	}
	public String getStaticAceessUrl() {
		return staticAceessUrl;
	}
}

	