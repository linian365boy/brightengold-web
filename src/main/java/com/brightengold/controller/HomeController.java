package com.brightengold.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

/**
 * Handles requests for the application home page.
 */
@Controller
@Scope("prototype")
@SessionAttributes("loginUser")
@RequestMapping("/admin")
public class HomeController {
	
	private Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value={"/index"}, method = RequestMethod.GET)
	public String home(Model model) {
		logger.debug("enter Index page!!");
		return "admin/index";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(Model model) {
		return "admin/login";
	}
	
}
