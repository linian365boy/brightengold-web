package com.brightengold.service;

import java.util.Date;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import com.brightengold.model.WebConfig;
import com.brightengold.util.ConstantVariable;
import com.brightengold.util.Tools;
import com.google.gson.GsonBuilder;

@Service
public class WebConfigService {
	
	private static final Logger logger = LoggerFactory.getLogger(WebConfigService.class);
	
	public boolean saveOrUpdateSystem(String path, WebConfig system){
		system.setUpdateTime(new Date());
		String jsonStr = new GsonBuilder().setDateFormat(ConstantVariable.DFTSTR).create().toJson(system);
		logger.info("saveOrUpdateSystem param => {}, webConfig => {}, translate to jsonStr => {}",path, system, jsonStr);
		boolean flag = false;
		if(Tools.saveOrUpdateWebConfig(path,jsonStr)){
			flag = true;
			logger.info("设置网站配置成功！");
		}else{
			logger.error("设置网站配置失败");
		}
		logger.info("saveOrUpdateSystem return data => {}", flag);
		return flag;
	}

	public WebConfig loadSystemConfig(String path) {
		String jsonStr = Tools.getJsonStrFromPath(path);
		logger.info("从文件|{}解析的json串为|{}",path,jsonStr);
		return new GsonBuilder().setDateFormat(ConstantVariable.DFTSTR).create().fromJson(jsonStr, WebConfig.class);
	}
	
	/*public static void main(String[] args) {
		WebConfigService service = new WebConfigService();
		WebConfig config = service.loadSystemConfig();
		System.out.println(config);
	}*/
	
}
