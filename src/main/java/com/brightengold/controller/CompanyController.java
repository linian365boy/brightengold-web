package com.brightengold.controller;

import cn.rainier.nian.utils.FileUtil;
import com.brightengold.model.Company;
import com.brightengold.service.CompanyService;
import com.brightengold.service.LogUtil;
import com.brightengold.service.SystemConfig;
import com.brightengold.util.Constant;
import com.brightengold.util.LogType;
import com.brightengold.util.Tools;
import com.brightengold.vo.MessageVo;
import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
@RequestMapping("/admin/sys/company")
@Scope("prototype")
public class CompanyController {
	@Autowired
	private CompanyService companyService;
	@Autowired
	private SystemConfig systemConfig;
	private final static Logger logger = LoggerFactory.getLogger(CompanyController.class);

	@InitBinder
	protected void initBinder(HttpServletRequest request, ServletRequestDataBinder binder) {
		binder.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd"), true));
	}

	@RequestMapping(value={"/detail"},method=RequestMethod.POST)
	public String detail(ModelMap map) {
		map.put("model",companyService.loadCompany(systemConfig.getCompanyConfigPath()));
		return "admin/sys/company/detail";
	}

	@ResponseBody
	@RequestMapping(value={"/update"},method=RequestMethod.POST)
	public MessageVo update(MultipartFile photos,Company company){
		Company temp = companyService.loadCompany(systemConfig.getCompanyConfigPath());
		MessageVo vo = null;
		try{
			if(photos!=null && !photos.isEmpty()){
				//String realPath = request.getSession().getServletContext().getRealPath("/resources/upload/company");
				String realPath = systemConfig.getPicPath()+File.separator+"upload"+File.separator+"company";
				String newFileName = realPath+File.separator+Tools.getRndFilename()+Tools.getExtname(photos.getOriginalFilename());
				//把前一张图片删除
				FileUtil.delFile(systemConfig.getPicPath()+File.separator+temp.getLogo());
				FileUtils.copyInputStreamToFile(photos.getInputStream(), new File(newFileName));
				String url = newFileName.substring(realPath.lastIndexOf("upload"));
				company.setLogo(url.replace("\\", "/"));
			}else{
				company.setLogo(temp.getLogo());
			}
			boolean flag = companyService.save(systemConfig.getCompanyConfigPath(),company);
			logger.info("修改公司前信息|{}，修改公司后信息|{}",temp,company);
			if(flag){
				StringBuilder content = new StringBuilder();
				if(!temp.getName().equals(company.getName())){
					content.append("公司名称由\""+temp.getName()+"\"修改为\""+company.getName()+"\"");
				}
				if(!temp.getLogo().equals(company.getLogo())){
					content.append("公司logo由\""+temp.getLogo()+"\"修改为\""+company.getLogo()+"\"");
				}
				if(!temp.getEmail().equals(company.getEmail())){
					content.append("公司邮箱由\""+temp.getEmail()+"\"修改为\""+company.getEmail()+"\"");
				}
				if(!temp.getTelPhone().equals(company.getTelPhone())){
					content.append("公司联系方式由\""+temp.getTelPhone()+"\"修改为\""+company.getTelPhone()+"\"");
				}
				LogUtil.getInstance().log(LogType.EDIT, content.toString());
				vo = new MessageVo(Constant.SUCCESS_CODE,"修改公司信息成功！");
			}else{
				logger.error("修改公司信息报错");
				vo = new MessageVo(Constant.ERROR_CODE,"修改公司信息失败！");
			}
		}catch(Exception e){
			logger.error("修改公司信息报错",e);
			vo = new MessageVo(Constant.ERROR_CODE,"修改公司信息失败！");
		}
		return vo;
	}

}
