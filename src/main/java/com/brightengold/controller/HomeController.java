package com.brightengold.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Handles requests for the application home page.
 */
@Controller
@Scope("prototype")
@RequestMapping("/admin")
public class HomeController {
	private final static Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value={"/index"}, method = RequestMethod.GET)
	public String home(ModelMap map) {
		logger.info(".....................enter index page........................");
		return "admin/index";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(Model model) {
		logger.info(".....................enter login page........................");
		return "admin/login";
	}
	
	/*@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String loginSuccss(Model model) {
		return "admin/login";
	}*/
	
	/**
	 * invalidate:session失效时调用
	 * @author tanfan 
	 * @return 
	 * @since JDK 1.7
	 */
	@ResponseBody
	@RequestMapping("/invalidate")
	public String invalidate(HttpServletRequest reqeust,HttpServletResponse response){
		String ajaxHeader = reqeust.getHeader("X-Requested-With");
        boolean isAjax = "XMLHttpRequest".equals(ajaxHeader);
        if(isAjax){
            return "invalidSession";
        } else {
            try{
               response.sendRedirect("/admin/login.html");
            }catch (IOException e) {
               logger.error("重定向url报错|{}",e);
            }
        }
        return "";
	}
	
	@RequestMapping(value="/accessDenied", method = RequestMethod.GET)
	public String accessDenied(){
		logger.warn("You enter accessDenied Page!");
		return "403";
	}
	
}
