package com.brightengold.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.brightengold.model.WebConfig;
import com.brightengold.service.LogUtil;
import com.brightengold.service.MsgUtil;
import com.brightengold.service.WebConfigService;
import com.brightengold.util.LogType;

/**
 * @ClassName: SystemController  
 * @Description: 网站系统设置一些配置，如关键字，底部内容等 
 * @date: 2016年7月22日 下午2:32:41 
 * 
 * @author tanfan 
 * @version  
 * @since JDK 1.7
 */
@Controller
@RequestMapping("/admin/sys/webconfig")
public class WebConfigController {
	@Autowired
	private WebConfigService webConfigService;
	private static final Logger logger = LoggerFactory.getLogger(WebConfigController.class);
	
	@RequestMapping(value={"/detail","/",""},method=RequestMethod.GET)
	public String detail(Model model) {
		model.addAttribute("model",webConfigService.loadSystemConfig());
		return "admin/sys/webconfig/detail";
	}
	
	@RequestMapping(value={"/update"},method=RequestMethod.POST)
	public String update(WebConfig config, HttpServletRequest request){
		WebConfig webConfig = webConfigService.loadSystemConfig();
		try{
			boolean flag = webConfigService.saveOrUpdateSystem(config);
			if(flag){
				StringBuilder content = new StringBuilder();
				if(!webConfig.getKeyword().equals(config.getKeyword())){
					content.append("网站关键字由\""+webConfig.getKeyword()+"\"修改为\""+config.getKeyword()+"\"");
				}
				MsgUtil.setMsgUpdate("success");
				LogUtil.getInstance().log(LogType.EDIT, content.toString());
			}else{
				logger.error("修改网站关键字出错");
			}
		}catch(Exception e){
			logger.error("修改网站关键字报错",e);
		}
		return "redirect:/admin/sys/webconfig/detail.html";
	}
}
