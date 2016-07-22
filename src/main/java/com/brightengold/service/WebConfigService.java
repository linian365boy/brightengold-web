package com.brightengold.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.brightengold.dao.WebConfigDto;
import com.brightengold.model.WebConfig;

@Service
public class WebConfigService {
	@Autowired
	private WebConfigDto webConfig;
	
	public WebConfig saveOrUpdateSystem(WebConfig system){
		return webConfig.save(system);
	}

	public WebConfig loadSystemConfig() {
		return webConfig.findOne(1);
	}
	
}
