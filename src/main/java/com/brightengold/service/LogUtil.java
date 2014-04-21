package com.brightengold.service;

import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import com.brightengold.util.LogType;

public class LogUtil {
	private LogService logService;
	private static LogUtil instance = null;
	private LogUtil(){
		WebApplicationContext app = ContextLoader.getCurrentWebApplicationContext();
		logService = (LogService)app.getBean("logService");
	}
	public static synchronized LogUtil getInstance(){
		if(instance==null){
			instance = new LogUtil();
		}
		return instance;
	}
	
	public void log(LogType type,String content){
		logService.log(type, content);
	}
	
	public LogService getLogService() {
		return logService;
	}
	public void setLogService(LogService logService) {
		this.logService = logService;
	}
}
