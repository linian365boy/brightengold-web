package com.brightengold.controller;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.rainier.nian.utils.PageRainier;

import com.brightengold.model.Log;
import com.brightengold.service.LogService;

@Controller
@RequestMapping("/admin/sys/log")
@Scope("prototype")
public class LogController {
	@Autowired
	private LogService logService;
	private PageRainier<Log> logs;
	private Integer pageSize = 10;
	
	@RequestMapping({"/logs/{pageNo}"})
	public String list(@PathVariable Integer pageNo,Model model,HttpServletRequest request){
		if(pageNo==null){
			pageNo = 1;
		}
		logs = logService.findAll(pageNo, pageSize);
		model.addAttribute("page",logs);//map
		return "admin/sys/log/list";
	}
	
	public PageRainier<Log> getLogs() {
		return logs;
	}

	public void setLogs(PageRainier<Log> logs) {
		this.logs = logs;
	}
}
