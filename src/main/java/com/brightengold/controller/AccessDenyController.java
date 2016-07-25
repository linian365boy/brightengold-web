package com.brightengold.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/admin")
@Scope("prototype")
public class AccessDenyController {
	private Logger logger  = LoggerFactory.getLogger(AccessDenyController.class);
	@RequestMapping(value="/accessDenied", method = RequestMethod.GET)
	public String accessDenied(){
		logger.warn("You enter accessDenied Page!");
		return "403";
	}
	
}
