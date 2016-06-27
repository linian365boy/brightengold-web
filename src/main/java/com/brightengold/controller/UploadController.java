package com.brightengold.controller;

import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.brightengold.util.ImageUtil;
import com.brightengold.util.Tools;
import com.brightengold.vo.ResultVo;
import com.google.gson.Gson;

/**
 * 专门处理图片上传
 * @author linian
 */
@RequestMapping("/admin/img")
@Controller
@Scope("prototype")
public class UploadController {
	private static Logger logger = LoggerFactory.getLogger(UploadController.class);
	private static final int minWidth = 50,maxWidth = 500;
	
	@ResponseBody
	@RequestMapping(value="/upload",method=RequestMethod.POST)
	public String upload(MultipartHttpServletRequest request){
		Gson gson = new Gson();
		ResultVo<String> vo = new ResultVo<String>();
		String url = "";
		MultipartFile file = request.getFile("file");
		try{
			if(!file.isEmpty()){
				String error = ImageUtil.validateDescImage(
								file.getInputStream(),
								1 * 1024 * 1024,		//5MB
								minWidth, maxWidth);
				if (StringUtils.isNotBlank(error)) {
					vo.setCode(202);
					if("3".equals(error)){
						vo.setMessage("文件大小已超过最大值1MB！");
					}else{
						vo.setMessage("图片分辨率不符合50-500px * 10-1000px的规格");
					}
					return gson.toJson(vo);
				}
				String realPath = request.getSession().getServletContext().getRealPath("/resources/upload/newsproducts");
				String newFileName = realPath+"/"+Tools.getRndFilename()+Tools.getExtname(file.getOriginalFilename());
				FileUtils.copyInputStreamToFile(file.getInputStream(), new File(newFileName));
				url = newFileName.substring(realPath.lastIndexOf("upload")).replace("\\", "/");
				vo.setCode(200);
				vo.setMessage("上传图片成功！");
				vo.setObj(url);
			}else{
				vo.setCode(201);
				vo.setMessage("上传图片为空！");
				vo.setObj(url);
			}
		}catch(IOException e){
			logger.error("上传图片发生错误！",e);
			vo.setCode(500);
			vo.setMessage("上传图片失败！");
		}
		return gson.toJson(vo);
	}
	
}
