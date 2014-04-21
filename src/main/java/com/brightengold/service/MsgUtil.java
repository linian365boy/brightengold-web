package com.brightengold.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

public class MsgUtil {
	
	private static Map<String,String> tipMap = new HashMap<String,String>();
	
	static{
		tipMap.put("success_add", "添加信息成功！");
		tipMap.put("success_update", "修改信息成功！");
		tipMap.put("success_delete", "删除信息成功！");
		tipMap.put("error_add", "添加信息失败！");
		tipMap.put("error_update", "修改信息失败！");
		tipMap.put("error_delete", "删除信息失败！");
		tipMap.put("block", "系统信息错误！");
	}

	public static void setMsg(String type,String msg){
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder
			      .getRequestAttributes()).getRequest();
		request.getSession().setAttribute(type, msg);
	}
	
	public static void setMsgAdd(String type){
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder
			      .getRequestAttributes()).getRequest();
		request.getSession().setAttribute(type, tipMap.get(type+"_add"));
	}
	
	public static void setMsgUpdate(String type){
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder
			      .getRequestAttributes()).getRequest();
		request.getSession().setAttribute(type, tipMap.get(type+"_update"));
	}
	
	public static void setMsgDelete(String type){
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder
			      .getRequestAttributes()).getRequest();
		request.getSession().setAttribute(type, tipMap.get(type+"_delete"));
	}
	
	public static void setMsgBlock(){
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder
			      .getRequestAttributes()).getRequest();
		request.getSession().setAttribute("block", tipMap.get("block"));
	}
	
}
