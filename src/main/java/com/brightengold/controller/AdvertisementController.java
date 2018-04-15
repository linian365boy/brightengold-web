package com.brightengold.controller;

import cn.rainier.nian.utils.FileUtil;
import cn.rainier.nian.utils.PageRainier;
import com.brightengold.common.vo.RequestParam;
import com.brightengold.model.Advertisement;
import com.brightengold.service.AdvertisementService;
import com.brightengold.service.LogUtil;
import com.brightengold.service.SystemConfig;
import com.brightengold.util.Constant;
import com.brightengold.util.LogType;
import com.brightengold.util.Tools;
import com.brightengold.vo.MessageVo;
import com.brightengold.vo.ResultVo;
import com.brightengold.vo.ReturnData;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.Date;



@Controller
@RequestMapping("/admin/ad")
@Scope("prototype")
public class AdvertisementController {
	@Autowired
	private AdvertisementService service;
	@Resource
	private SystemConfig systemConfig;
	private final static Logger logger = LoggerFactory.getLogger(AdvertisementController.class);

	@RequestMapping(value={"/ads/list"})
	public String list(HttpServletRequest request,ModelMap map){
		map.put("ajaxListUrl", "admin/ad/ads/getJsonList.html");
		return "admin/ad/list";
	}

	@ResponseBody
	@RequestMapping(value={"/ads/getJsonList"})
	public ReturnData<Advertisement> getJsonList(RequestParam param){
		PageRainier<Advertisement> page = service.findAll(param);
		ReturnData<Advertisement> datas = new ReturnData<Advertisement>(page.getTotalRowNum(), page.getResult());
		return datas;
	}

	@ResponseBody
	@RequestMapping(value={"/save"},method=RequestMethod.POST)
	public MessageVo saveAd(MultipartFile photo,Advertisement ad,HttpServletRequest request){
		MessageVo vo = null;
		try{
			if(!photo.isEmpty()){
				//String realPath = request.getSession().getServletContext().getRealPath("/resources/upload/ads");
				String realPath = systemConfig.getPicPath()+File.separator+"upload"+File.separator+"ads";
				String newFileName = realPath+File.separator+Tools.getRndFilename()+Tools.getExtname(photo.getOriginalFilename());
				FileUtils.copyInputStreamToFile(photo.getInputStream(), new File(newFileName));
				String url = newFileName.substring(realPath.lastIndexOf("upload"));
				ad.setPicUrl(url.replace("\\", "/"));
			}else{
				logger.error("{}上传图片不能为空！",ad.getName());
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
			LogUtil.getInstance().log(LogType.ADD, "新增滚动图片"+ad.getName()+"成功!");
			logger.info("新增滚动图片成功，新增信息为：{}",ad);
			vo = new MessageVo(Constant.SUCCESS_CODE,"新增滚动图片"+ad.getName()+"成功!");
		}catch(Exception e){
			LogUtil.getInstance().log(LogType.ADD, "新增滚动图片"+ad.getName()+"失败!");
			logger.error("新增滚动图片发生错误",e);
			vo = new MessageVo(Constant.ERROR_CODE,"新增滚动图片"+ad.getName()+"失败!");
		}
		return vo;
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

	@ResponseBody
	@RequestMapping(value={"/{id}/update"},method=RequestMethod.POST)
	public MessageVo update(@PathVariable Integer id, HttpServletRequest request,
							Advertisement ad,MultipartFile photo){
		Advertisement temp = null;
		StringBuilder content = new StringBuilder();
		MessageVo vo = null;
		try{
			temp = service.loadAdvertisement(id);
			ad.setCreateDate(temp.getCreateDate());
			if(photo!=null && !photo.isEmpty()){
				//String realPath = request.getSession().getServletContext().getRealPath("/resources/upload/ads");
				String realPath = systemConfig.getPicPath()+File.separator+"upload"+File.separator+"ads";
				String newFileName = realPath+File.separator+Tools.getRndFilename()+Tools.getExtname(photo.getOriginalFilename());
				FileUtil.delFile(systemConfig.getPicPath()+File.separator+temp.getPicUrl());
				FileUtils.copyInputStreamToFile(photo.getInputStream(), new File(newFileName));
				String url = newFileName.substring(realPath.lastIndexOf("upload"));
				ad.setPicUrl(url.replace("\\", "/"));
			}else{
				ad.setPicUrl(temp.getPicUrl());
			}
			content.append("图片名称："+ad.getName());
			if(service.updateAdvertisement(ad)){
				LogUtil.getInstance().log(LogType.EDIT,content.toString());
				logger.info("修改滚动图片信息成功，原图片信息：{}，修改后信息：{}",temp,ad);
				vo = new MessageVo(Constant.SUCCESS_CODE,"修改滚动图片信息【"+ad.getName()+"】成功");
			}else{
				vo = new MessageVo(Constant.ERROR_CODE,"修改滚动图片【"+ad+"】发生失败！");
			}
		}catch(Exception e){
			logger.error("修改滚动图片信息发生错误",e);
			vo = new MessageVo(Constant.ERROR_CODE,"修改滚动图片【"+ad+"】发生失败！");
		}
		return vo;
	}

	@ResponseBody
	@RequestMapping(value={"/{id}/updateStatus"})
	public ResultVo<String> updateStatus(@PathVariable Integer id,Integer status){
		ResultVo<String> vo = new ResultVo<String>();
		try{
			service.updateStatus(id,status);
			vo.setCode(Constant.SUCCESS_CODE);
			vo.setMessage("修改状态成功！");
			logger.info("从{}修改为{}状态",(status==1)?"锁定":"正常",(status==1)?"正常":"锁定");
		}catch(Exception e){
			vo.setCode(Constant.ERROR_CODE);
			vo.setMessage("修改状态失败！");
			logger.error("修改状态失败！",e);
		}
		return vo;
	}

	@RequestMapping(value={"/{id}/delete"})
	@ResponseBody
	public ResultVo<String> delete(@PathVariable Integer id){
		ResultVo<String> vo = new ResultVo<String>();
		Advertisement ad = service.loadAdvertisement(id);
		try{
			service.delAdvertisement(id);
			vo.setCode(Constant.SUCCESS_CODE);
			vo.setMessage("删除信息成功！");
			LogUtil.getInstance().log(LogType.DEL, "图片名称："+ad.getName());
			logger.warn("删除图片信息成功，图片信息{}",ad);
		}catch(Exception e){
			vo.setCode(Constant.ERROR_CODE);
			vo.setMessage("删除信息失败！");
			logger.error("删除图片信息发生错误",e);
		}
		return vo;
	}

}
