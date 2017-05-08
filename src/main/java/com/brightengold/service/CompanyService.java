package com.brightengold.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import com.brightengold.model.Company;
import com.brightengold.util.ConstantVariable;
import com.brightengold.util.Tools;
import com.google.gson.GsonBuilder;

@Service("companyService")
public class CompanyService {
	
	private static final Logger logger = LoggerFactory.getLogger(CompanyService.class);

	public Company loadCompany(String path) {
		String jsonStr = Tools.getJsonStrFromPath(path);
		logger.info("从文件|{}解析的json串为|{}",path,jsonStr);
		return new GsonBuilder().setDateFormat(ConstantVariable.DFSTR).create().fromJson(jsonStr, Company.class);
	}

	public boolean save(String path, Company company) {
		String jsonStr = new GsonBuilder().setDateFormat(ConstantVariable.DFTSTR).create().toJson(company);
		logger.info("保存到classpath的json串为|{}",jsonStr);
		boolean flag = false;
		if(Tools.saveOrUpdateWebConfig(path,jsonStr)){
			flag = true;
			logger.info("设置网公司信息成功！");
		}else{
			logger.error("设置公司信息失败");
		}
		return flag;
	}
	
}
