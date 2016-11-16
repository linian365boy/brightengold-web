package com.brightengold.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.brightengold.model.WebConfig;
import com.brightengold.service.LogUtil;
import com.brightengold.service.SystemConfig;
import com.brightengold.service.WebConfigService;
import com.brightengold.util.Constant;
import com.brightengold.util.LogType;
import com.brightengold.vo.MessageVo;

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
	@Autowired
	private SystemConfig systemConfig;
	private static final Logger logger = LoggerFactory.getLogger(WebConfigController.class);
	
	@RequestMapping(value={"/detail","/",""},method=RequestMethod.POST)
	public String detail(Model model) {
		model.addAttribute("model",webConfigService.loadSystemConfig(systemConfig.getWebConfigPath()));
		return "admin/sys/webconfig/detail";
	}
	
	@ResponseBody
	@RequestMapping(value={"/update"},method=RequestMethod.POST)
	public MessageVo update(WebConfig config, HttpServletRequest request){
		WebConfig webConfig = webConfigService.loadSystemConfig(systemConfig.getWebConfigPath());
		MessageVo vo = null;
		try{
			boolean flag = webConfigService.saveOrUpdateSystem(systemConfig.getWebConfigPath(),config);
			if(flag){
				StringBuilder content = new StringBuilder();
				if(!webConfig.getKeyword().equals(config.getKeyword())){
					content.append("网站关键字由\""+webConfig.getKeyword()+"\"修改为\""+config.getKeyword()+"\"");
				}
				logger.info("修改web配置信息成功|{}",config);
				LogUtil.getInstance().log(LogType.EDIT, content.toString());
				vo = new MessageVo(Constant.SUCCESS_CODE,"修改网站设置成功！");
			}else{
				logger.error("修改网站关键字出错");
				vo = new MessageVo(Constant.ERROR_CODE,"修改网站设置失败！");
			}
		}catch(Exception e){
			logger.error("修改网站关键字报错",e);
			vo = new MessageVo(Constant.ERROR_CODE,"修改网站设置失败！");
		}
		return vo;
	}
}
