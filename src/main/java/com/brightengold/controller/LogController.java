package com.brightengold.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.brightengold.model.Log;
import com.brightengold.service.LogService;

import cn.rainier.nian.utils.PageRainier;

@Controller
@RequestMapping("/admin/sys/log")
@Scope("prototype")
public class LogController {
	@Autowired
	private LogService logService;
	private PageRainier<Log> logs;
	private Integer pageSize = 10;
	
	@RequestMapping({"/logs/{pageNo}"})
	public String list(HttpServletRequest request,@PathVariable Integer pageNo,ModelMap map){
		logs = logService.findAll(pageNo, pageSize);
		map.put("page",logs);//map
		return "admin/sys/log/list";
	}
	
	public PageRainier<Log> getLogs() {
		return logs;
	}

	public void setLogs(PageRainier<Log> logs) {
		this.logs = logs;
	}
}
