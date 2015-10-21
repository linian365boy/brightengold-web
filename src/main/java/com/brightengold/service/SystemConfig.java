package com.brightengold.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component("systemConfig")
public class SystemConfig {
	
	@Value("#{configProperties['index.ads.size']}")
	private int indexAdsSize = 5;
	@Value("#{configProperties['cross.max.depth']}")
	private int crossMaxDepth = 2;
	@Value("#{configProperties['vertical.max.depth']}")
	private int verticalMaxDepth = 3;
	@Value("#{configProperties['index.product.size']}")
	private int indexProductSize;
	
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
	
}

	