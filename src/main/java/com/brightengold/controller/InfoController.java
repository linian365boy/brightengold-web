package com.brightengold.controller;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.brightengold.model.Info;
import com.brightengold.service.InfoService;
import com.brightengold.service.LogUtil;
import com.brightengold.service.MsgUtil;
import com.brightengold.util.LogType;

import cn.rainier.nian.utils.FileUtil;
import cn.rainier.nian.utils.PageRainier;

@Controller
@RequestMapping("/admin/sys/info")
@Scope("prototype")
public class InfoController {
	@Autowired
	private InfoService infoService;
	private PageRainier<Info> page;
	private Integer pageSize = 10;
	private static Logger logger = LoggerFactory.getLogger(InfoController.class);
	
	@RequestMapping({"/{pageNo}"})
	public String list(HttpServletRequest request,@PathVariable Integer pageNo,ModelMap map){
		page = infoService.findAll(pageNo, pageSize);
		map.put("page",page);//map
		return "admin/sys/info/list";
	}
	
	@RequestMapping(value="/add",method=RequestMethod.GET)
	public String add(Model model) {
		return "admin/sys/info/add";
	}
	
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public String add(Info info) {
		StringBuilder sb = new StringBuilder();
		try {
			info.setUrl("views/html/info/"+info.getCode()+".htm");
			infoService.save(info);
			sb.append("信息名称："+info.getName());
			MsgUtil.setMsgAdd("success");
			LogUtil.getInstance().log(LogType.ADD, sb.toString());
			logger.info("新增信息{}成功！",info);
		} catch (Exception e) {
			logger.error("新增信息失败",e);
		}
		return "redirect:/admin/sys/info/1.html";
	}
	
	@RequestMapping(value="/{infoId}/update",method=RequestMethod.GET)
	public String update(@PathVariable Integer infoId,Model model) {
		if (infoId != null) {
			model.addAttribute("model",infoService.loadOne(infoId));
		}
		return "admin/sys/info/update";
	}
	
	@RequestMapping(value="/{infoId}/update",method=RequestMethod.POST)
	public String update(HttpServletRequest request, 
			@PathVariable Integer infoId,Info info) {
		StringBuilder content = new StringBuilder();
		try {
			if(infoId!=null){
				Info tinfo = infoService.loadOne(infoId);
				content.append("信息名称："+tinfo.getName());
				if(!(info.getCode().equals(tinfo.getCode()))){
					info.setUrl("views/html/info/"+info.getCode()+".htm");
				}else{
					info.setUrl(tinfo.getUrl());
				}
				infoService.save(info);
				logger.info("修改信息内容|{}",info);
				MsgUtil.setMsgUpdate("success");
				LogUtil.getInstance().log(LogType.EDIT,content.toString());
			}
		} catch (Exception e) {
			logger.error("修改信息失败！",e);
		}
		return "redirect:/admin/sys/info/1.html";
	}
	
	@RequestMapping(value="/{infoId}/del",method=RequestMethod.GET)
	public String del(@PathVariable Integer infoId,HttpServletRequest request){
		if(infoId!=null){
			StringBuilder sb = new StringBuilder();
			Info info = infoService.loadOne(infoId);
			infoService.deleteInfo(info);
			logger.warn("删除信息内容|{}",info);
			String path = request.getSession().getServletContext().getRealPath("/");
			FileUtil.delFile(path +File.separator+info.getUrl());
			sb.append("名称："+info.getName());
			MsgUtil.setMsgDelete("success");
			LogUtil.getInstance().log(LogType.DEL, sb.toString());
		}
		return "redirect:/admin/sys/info/1.html";
	}
	
	public Integer getPageSize() {
		return pageSize;
	}
	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}
	public PageRainier<Info> getPage() {
		return page;
	}
	public void setPage(PageRainier<Info> page) {
		this.page = page;
	}
}
