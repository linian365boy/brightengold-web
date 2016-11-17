package com.brightengold.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import com.brightengold.service.SystemConfig;

public class InitListener implements ServletContextListener {
	private  static ApplicationContext applicationContext = null;
	
	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		//移除全局变量--点击量
		sce.getServletContext().removeAttribute("staticAccessPath");
	}

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		//初始化 ApplicationContext  对象
		applicationContext = WebApplicationContextUtils.getRequiredWebApplicationContext(sce.getServletContext());
		SystemConfig systemConfig = (SystemConfig)applicationContext.getBean("systemConfig");
		//设置点击量
		sce.getServletContext().setAttribute("staticAccessPath",systemConfig.getStaticAceessUrl());
	}
	
}
