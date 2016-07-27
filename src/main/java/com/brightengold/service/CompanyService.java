package com.brightengold.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import com.brightengold.model.Company;
import com.brightengold.util.Tools;
import com.google.gson.Gson;

@Component("companyService")
public class CompanyService {
	
	private static final Logger logger = LoggerFactory.getLogger(CompanyService.class);

	public Company loadCompany() {
		String jsonStr = Tools.getJsonStrFromPath("companyConfig.json");
		logger.info("从文件解析的json串为|{}",jsonStr);
		return new Gson().fromJson(jsonStr, Company.class);
	}

	public boolean save(Company company) {
		String jsonStr = new Gson().toJson(company);
		logger.info("保存到classpath的json串为|{}",jsonStr);
		boolean flag = false;
		if(Tools.saveOrUpdateWebConfig("companyConfig.json",jsonStr)){
			flag = true;
			logger.info("设置网公司信息成功！");
		}else{
			logger.error("设置公司信息失败");
		}
		return flag;
	}
	
}
