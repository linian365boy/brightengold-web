package com.brightengold.util;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.JoinPoint;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.ModelMap;

/**
 * @ClassName: EnterMenuAspect  
 * @Description: 获取用户进入的栏目菜单 
 * @date: 2016年10月24日 下午4:05:31 
 * 
 * @author tanfan 
 * @version  
 * @since JDK 1.7
 */
public class EnterMenuAspect {
	private static final Logger logger = LoggerFactory.getLogger(EnterMenuAspect.class);
	
	public void doAfter(JoinPoint jp){
		HttpServletRequest request = null;
		ModelMap map = null;
		for(int i=0;i<jp.getArgs().length;i++){
			if(jp.getArgs()[i]!=null){
				logger.info("第{}个参数为：{}",(i+1),jp.getArgs()[i]);
				if(jp.getArgs()[i] instanceof HttpServletRequest){
					request = (HttpServletRequest)jp.getArgs()[i];
				}else if(jp.getArgs()[i] instanceof ModelMap){
					map = (ModelMap)jp.getArgs()[i];
				}
			}
		}
		if(request!=null && map!=null){
			logger.info("enter set menu.");
			map.put("pmenuText", request.getParameter("ptext"));
			map.put("menuText", request.getParameter("text"));
		}else{
			logger.warn("not enter set menu.");
		}
	}
}
