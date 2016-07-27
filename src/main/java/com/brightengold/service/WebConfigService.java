package com.brightengold.service;

import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.brightengold.model.WebConfig;
import com.brightengold.util.Tools;
import com.google.gson.Gson;

@Service
public class WebConfigService {
	@Autowired
	private static final Logger logger = LoggerFactory.getLogger(WebConfigService.class);
	
	public boolean saveOrUpdateSystem(WebConfig system){
		system.setUpdateTime(new Date());
		String jsonStr = new Gson().toJson(system);
		logger.info("保存到classpath的json串为|{}",jsonStr);
		boolean flag = false;
		if(Tools.saveOrUpdateWebConfig("webConfig.json",jsonStr)){
			flag = true;
			logger.info("设置网站配置成功！");
		}else{
			logger.error("设置网站配置失败");
		}
		return flag;
	}

	public WebConfig loadSystemConfig() {
		//return webConfig.findOne(1);
		String jsonStr = Tools.getJsonStrFromPath("webConfig.json");
		logger.info("从文件解析的json串为|{}",jsonStr);
		return new Gson().fromJson(jsonStr, WebConfig.class);
	}
	
	public static void main(String[] args) {
		WebConfigService service = new WebConfigService();
		WebConfig webConfig = new WebConfig();
		webConfig.setBottom("test");
		webConfig.setKeyword("test2");
		webConfig.setUpdateTime(new Date());
		boolean flag = service.saveOrUpdateSystem(webConfig);
		System.out.println(flag);
		
	}
	
}
