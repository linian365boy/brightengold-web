package com.brightengold.service;

import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import com.brightengold.util.LogType;

public class LogUtil {
	
	private LogService logService;
	
	private static class LogUtilHolder {
		public static LogUtil instance = new LogUtil();
	}
	
	public static synchronized LogUtil getInstance(){
		return LogUtilHolder.instance;
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
