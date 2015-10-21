package com.brightengold.controller;

import java.io.File;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import com.brightengold.model.Company;
import com.brightengold.service.CompanyService;
import com.brightengold.service.LogUtil;
import com.brightengold.service.MsgUtil;
import com.brightengold.util.LogType;
import com.brightengold.util.Tools;

@Controller
@RequestMapping("/admin/sys/company")
@Scope("prototype")
public class CompanyController {
	@Autowired
	private CompanyService companyService;
	
	@RequestMapping(value={"/detail","/",""},method=RequestMethod.GET)
	public String detail(Model model) {
		model.addAttribute("model",companyService.loadCompany());
		return "admin/sys/company/detail";
	}
	
	@RequestMapping(value={"/update"},method=RequestMethod.POST)
	public String update(@RequestParam  MultipartFile[] photos,Company company, HttpServletRequest request){
		Company temp = companyService.loadCompany();
		try{
			int i = 0;
			for(MultipartFile photo : photos){
				i++;
				if(i==1){
					if(!photo.isEmpty()){
						String realPath = request.getSession().getServletContext().getRealPath("/resources/upload/company");
						String newFileName = realPath+"/"+Tools.getRndFilename()+Tools.getExtname(photo.getOriginalFilename());
						FileUtils.copyInputStreamToFile(photo.getInputStream(), new File(newFileName));
						String url = newFileName.substring(realPath.lastIndexOf("upload"));
						company.setLogo(url.replace("\\", "/"));
					}else{
						company.setLogo(temp.getLogo());
					}
				}else{
					if(!photo.isEmpty()){
						String realPath = request.getSession().getServletContext().getRealPath("/resources/upload/company");
						String newFileName = realPath+"/"+Tools.getRndFilename()+Tools.getExtname(photo.getOriginalFilename());
						FileUtils.copyInputStreamToFile(photo.getInputStream(), new File(newFileName));
						String url = newFileName.substring(realPath.lastIndexOf("upload"));
						company.setPhonePic(url.replace("\\", "/"));
					}else{
						company.setPhonePic(temp.getPhonePic());
					}
				}
			}
			company.setCreateDate(temp.getCreateDate());
			company = companyService.save(company);
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
			MsgUtil.setMsgUpdate("success");
			LogUtil.getInstance().log(LogType.EDIT, content.toString());
		}catch(Exception e){
			e.printStackTrace();
		}
		return "redirect:/admin/sys/company/detail";
	}
	
}
