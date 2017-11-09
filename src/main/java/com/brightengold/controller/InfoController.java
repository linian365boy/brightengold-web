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
import org.springframework.web.bind.annotation.ResponseBody;

import com.brightengold.common.vo.RequestParam;
import com.brightengold.model.Info;
import com.brightengold.service.InfoService;
import com.brightengold.service.LogUtil;
import com.brightengold.util.Constant;
import com.brightengold.util.LogType;
import com.brightengold.vo.MessageVo;
import com.brightengold.vo.ReturnData;

import cn.rainier.nian.utils.FileUtil;
import cn.rainier.nian.utils.PageRainier;

@Controller
@RequestMapping("/admin/sys/info")
@Scope("prototype")
public class InfoController {
	@Autowired
	private InfoService infoService;
    @Autowired
    private LogUtil logUtil;
	private final static Logger logger = LoggerFactory.getLogger(InfoController.class);
	
	@RequestMapping({"/list"})
	public String list(HttpServletRequest request,ModelMap map){
		map.put("ajaxListUrl","admin/sys/info/getJsonList");
		return "admin/sys/info/list";
	}
	
	@ResponseBody
	@RequestMapping({"/getJsonList"})
	public ReturnData<Info> getJsonList(RequestParam param){
		PageRainier<Info> page = infoService.findAll(param);
		ReturnData<Info> datas = new ReturnData<Info>(page.getTotalRowNum(), page.getResult());
		return datas;
	}
	
	@RequestMapping(value="/add",method=RequestMethod.GET)
	public String add(Model model) {
		return "admin/sys/info/add";
	}
	
	@ResponseBody
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public MessageVo add(Info info) {
	    logger.info("add info param => {}", info);
		StringBuilder sb = new StringBuilder();
		MessageVo vo = null;
		try {
			info.setUrl("views/info/" +info.getCode()+".htm");
			infoService.save(info);
			sb.append("信息名称："+info.getName());
			logUtil.log(LogType.ADD, sb.toString());
			logger.info("add info => {} succeed",info);
			vo = new MessageVo(Constant.SUCCESS_CODE,"新增信息【"+info.getName()+"】成功！");
		} catch (Exception e) {
			logger.error("add info error.",e);
			vo = new MessageVo(Constant.ERROR_CODE,"新增信息【"+info.getName()+"】失败！");
		}
        logger.info("add info return data => {}", vo);
		return vo;
	}
	
	@RequestMapping(value="/{infoId}/update",method=RequestMethod.GET)
	public String update(@PathVariable Integer infoId,Model model) {
		if (infoId != null) {
			model.addAttribute("model",infoService.loadOne(infoId));
		}
		return "admin/sys/info/update";
	}
	
	@ResponseBody
	@RequestMapping(value="/{infoId}/update",method=RequestMethod.POST)
	public MessageVo update(HttpServletRequest request, 
			@PathVariable Integer infoId,Info info) {
	    logger.info("update info param => {}, request param => {}", info, request.getParameterMap());
		StringBuilder content = new StringBuilder();
		MessageVo vo = null;
		try {
			Info tinfo = infoService.loadOne(infoId);
			content.append("信息名称："+tinfo.getName());
			if(!(info.getCode().equals(tinfo.getCode()))){
				info.setUrl("views/info/" +info.getCode()+".htm");
			}else{
				info.setUrl(tinfo.getUrl());
			}
			if(infoService.updateInfo(info)){
				logger.info("update info => {} succeed.",info);
				logUtil.log(LogType.EDIT,content.toString());
				vo = new MessageVo(Constant.SUCCESS_CODE,"修改信息【"+info.getName()+"】成功！");
			}else{
				vo = new MessageVo(Constant.ERROR_CODE,"修改信息【"+info.getName()+"】失败！");
			}
		} catch (Exception e) {
			logger.error("update info error.",e);
			vo = new MessageVo(Constant.ERROR_CODE,"修改信息【"+info.getName()+"】失败！");
		}
		logger.info("update info return data => {}", vo);
		return vo;
	}
	
	@ResponseBody
	@RequestMapping(value="/{infoId}/delete",method=RequestMethod.POST)
	public MessageVo del(@PathVariable Integer infoId,HttpServletRequest request){
		MessageVo vo = null;
		StringBuilder sb = new StringBuilder();
		Info info = infoService.loadOne(infoId);
		if(infoService.deleteInfo(info)){
			logger.warn("delete info => {}",info);
			String path = request.getSession().getServletContext().getRealPath("/");
			FileUtil.delFile(path +File.separator+info.getUrl());
			sb.append("名称："+info.getName());
			logUtil.log(LogType.DEL, sb.toString());
			vo = new MessageVo(Constant.SUCCESS_CODE, "删除信息【"+info.getName()+"】成功！");
		}else{
			vo = new MessageVo(Constant.ERROR_CODE,"删除信息【"+info.getName()+"】失败！");
		}
		return vo;
	}
}
