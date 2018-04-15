package com.brightengold.controller;

import cn.rainier.nian.utils.PageRainier;
import com.brightengold.common.vo.RequestParam;
import com.brightengold.model.Log;
import com.brightengold.service.LogService;
import com.brightengold.vo.ReturnData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/admin/sys/log")
@Scope("prototype")
public class LogController {
	@Autowired
	private LogService logService;
	@RequestMapping({"/logs/list"})
	public String list(HttpServletRequest request,ModelMap map){
		map.put("ajaxListUrl", "admin/sys/log/logs/getJsonList.html");
		return "admin/sys/log/list";
	}

	@ResponseBody
	@RequestMapping({"/logs/getJsonList"})
	public ReturnData<Log> getJsonList(RequestParam param){
		PageRainier<Log> logs = logService.findAll(param);
		ReturnData<Log> datas = new ReturnData<Log>(logs.getTotalRowNum(), logs.getResult());
		return datas;
	}
}
