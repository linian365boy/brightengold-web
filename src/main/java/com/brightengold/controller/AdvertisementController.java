package com.brightengold.controller;

import java.io.File;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
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
import org.springframework.web.multipart.MultipartFile;

import cn.rainier.nian.utils.PageRainier;

import com.brightengold.model.Advertisement;
import com.brightengold.service.AdvertisementService;
import com.brightengold.service.LogUtil;
import com.brightengold.service.MsgUtil;
import com.brightengold.util.Constant;
import com.brightengold.util.LogType;
import com.brightengold.util.Tools;
import com.brightengold.vo.ResultVo;
import com.google.gson.Gson;

@Controller
@RequestMapping("/admin/ad")
@Scope("prototype")
public class AdvertisementController {
	@Autowired
	private AdvertisementService service;
	private PageRainier<Advertisement> page;
	private Integer pageSize = 10;
	private static Logger logger = LoggerFactory.getLogger(AdvertisementController.class);
	
	@RequestMapping(value={"/ads/{pageNo}"})
	public String list(@PathVariable Integer pageNo,Model model){
		page = service.findAll(pageNo, pageSize);
		model.addAttribute("page",page);//map
		return "admin/ad/list";
	}
	
	@RequestMapping(value={"/save"},method=RequestMethod.POST)
	public String saveAd(MultipartFile photo,Advertisement ad,HttpServletRequest request){
		try{
			if(!photo.isEmpty()){
				String realPath = request.getSession().getServletContext().getRealPath("/resources/upload/ads");
				String newFileName = realPath+"/"+Tools.getRndFilename()+Tools.getExtname(photo.getOriginalFilename());
				FileUtils.copyInputStreamToFile(photo.getInputStream(), new File(newFileName));
				String url = newFileName.substring(realPath.lastIndexOf("upload"));
				ad.setPicUrl(url.replace("\\", "/"));
			}else{
				logger.error(ad.getName()+"上传图片不能为空！");
			}
			if(StringUtils.isBlank(ad.getUrl())){
				ad.setUrl("javascript:void();");
			}
			if(null==ad.getPriority()){
				ad.setPriority(0);
			}
			ad.setStatus(Constant.C_ONE);
			ad.setCreateDate(new Date());
			service.saveAdvertisement(ad);
			MsgUtil.setMsgAdd("success");
			LogUtil.getInstance().log(LogType.ADD, "新增滚动图片"+ad.getName()+"成功!");
			logger.info("新增滚动图片成功，新增信息为：{}",
					ToStringBuilder.reflectionToString(ad, ToStringStyle.SHORT_PREFIX_STYLE));
		}catch(Exception e){
			MsgUtil.setMsgAdd("error");
			LogUtil.getInstance().log(LogType.ADD, "新增滚动图片"+ad.getName()+"失败!");
			logger.error("新增滚动图片发生错误：{}",e);
		}
		return "redirect:/admin/ad/ads/1.html";
	}
	
	@RequestMapping(value={"/save"},method=RequestMethod.GET)
	public String saveAdUI(){
		return "admin_unless/ad/add";
	}
	
	@RequestMapping(value={"/{id}/update"},method=RequestMethod.GET)
	public String updateUI(@PathVariable Integer id, ModelMap model){
		Advertisement ad = service.loadAdvertisement(id);
		model.put("model", ad);
		return "admin_unless/ad/update";
	}
	
	@RequestMapping(value={"/{id}/update"},method=RequestMethod.POST)
	public String update(@PathVariable Integer id, HttpServletRequest request, ModelMap model,
			Advertisement ad,MultipartFile photo){
		Advertisement temp = null;
		StringBuilder content = new StringBuilder();
		try{
			temp = service.loadAdvertisement(id);
			ad.setCreateDate(temp.getCreateDate());
			if(!photo.isEmpty()){
				String realPath = request.getSession().getServletContext().getRealPath("/resources/upload/products");
				String newFileName = realPath+"/"+Tools.getRndFilename()+Tools.getExtname(photo.getOriginalFilename());
				FileUtils.copyInputStreamToFile(photo.getInputStream(), new File(newFileName));
				String url = newFileName.substring(realPath.lastIndexOf("upload"));
				ad.setPicUrl(url.replace("\\", "/"));
			}else{
				ad.setPicUrl(temp.getPicUrl());
			}
			content.append("图片名称："+ad.getName());
			service.saveAdvertisement(ad);
			MsgUtil.setMsgUpdate("success");
			LogUtil.getInstance().log(LogType.EDIT,content.toString());
			logger.info("修改滚动图片信息成功，原图片信息：{}，修改后信息：{}",
					ToStringBuilder.reflectionToString(temp, ToStringStyle.SHORT_PREFIX_STYLE),
					ToStringBuilder.reflectionToString(ad, ToStringStyle.SHORT_PREFIX_STYLE));
		}catch(Exception e){
			MsgUtil.setMsgUpdate("error");
			logger.error("修改滚动图片信息发生错误：",e);
		}
		return "redirect:/admin/ad/ads/1.html";
	}
	
	@RequestMapping(value={"/{id}/updateStatus"})
	public String updateStatus(@PathVariable Integer id,Integer status){
		Gson gson = new Gson();
		ResultVo<String> vo = new ResultVo<String>();
		try{
			service.updateStatus(id,status);
			vo.setCode(200);
			vo.setMessage("修改状态成功！");
			logger.info("从{}修改为{}状态",(status==1)?"锁定":"正常",(status==1)?"正常":"锁定");
		}catch(Exception e){
			vo.setCode(500);
			vo.setMessage("修改状态失败！");
			logger.error("修改状态失败！{}",e);
		}
		return gson.toJson(vo);
	}
	
	@RequestMapping(value={"/{id}/delete"})
	@ResponseBody
	public String delete(@PathVariable Integer id){
		Gson gson = new Gson();
		ResultVo<String> vo = new ResultVo<String>();
		Advertisement ad = service.loadAdvertisement(id);
		try{
			service.delAdvertisement(id);
			vo.setCode(200);
			vo.setMessage("删除信息成功！");
			LogUtil.getInstance().log(LogType.DEL, "图片名称："+ad.getName());
			logger.warn("删除图片信息成功，图片信息{}",
					ToStringBuilder.reflectionToString(ad, ToStringStyle.SHORT_PREFIX_STYLE));
		}catch(Exception e){
			vo.setCode(500);
			vo.setMessage("删除信息失败！");
			logger.error("删除图片信息发生错误{}",e);
		}
		return gson.toJson(vo);
	}
	
}
