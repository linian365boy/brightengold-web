package com.brightengold.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.brightengold.common.vo.RequestParam;
import com.brightengold.model.Log;
import com.brightengold.service.LogService;
import com.brightengold.vo.ReturnData;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import cn.rainier.nian.utils.PageRainier;

@Controller
@RequestMapping("/admin/sys/log")
@Scope("prototype")
public class LogController {
	@Autowired
	private LogService logService;
	private PageRainier<Log> logs;
	@RequestMapping({"/logs/list"})
	public String list(HttpServletRequest request,ModelMap map){
		map.put("ajaxListUrl", "admin/sys/log/logs/getJsonList.html");
		return "admin/sys/log/list";
	}
	
	@ResponseBody
	@RequestMapping({"/logs/getJsonList"})
	public String getJsonList(RequestParam param){
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		logs = logService.findAll(param);
		ReturnData<Log> datas = new ReturnData<Log>(logs.getTotalRowNum(), logs.getResult());
		return gson.toJson(datas);
	}
	
	public PageRainier<Log> getLogs() {
		return logs;
	}

	public void setLogs(PageRainier<Log> logs) {
		this.logs = logs;
	}
}
