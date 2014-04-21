package com.brightengold.controller;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/accessDenied")
@Scope("prototype")
public class AccessDenyController {
	
	@RequestMapping(value="", method = RequestMethod.GET)
	public String accessDenied(){
		return "admin/403";
	}
	
}
