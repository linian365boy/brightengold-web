package com.brightengold.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import cn.rainier.nian.model.User;

import com.brightengold.service.MsgUtil;
import com.brightengold.util.HTMLGenerator;

@Controller
@RequestMapping("/admin/sys/html")
@Scope("prototype")
public class GennerateController {
	
	private Logger logger = LoggerFactory.getLogger(GennerateController.class);
	
	@RequestMapping(value={"/",""},method=RequestMethod.GET)
	public String gennerateHtml(){
		return "admin/sys/html/generate";
	}
	
	@RequestMapping(value="/index",method=RequestMethod.GET)
	public String gennerateIndex(HttpServletRequest request){
		User loginUser = ((User)SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
		String url=basePath+"/sys/html/gennerateHtml";
		HTMLGenerator htmlGenerator = new HTMLGenerator(basePath);
		if(htmlGenerator.createHtmlPage(url,request.getSession().getServletContext().getRealPath("/"),loginUser.getUsername(),null)){
			MsgUtil.setMsg("succss", "恭喜您，生成首页成功！");
		}else{
			MsgUtil.setMsg("error", "对不起，生成首页失败！");
		}
		return InternalResourceViewResolver.REDIRECT_URL_PREFIX+"/admin/sys/html/";
	}
	
	@RequestMapping(value="/gennerateHtml",method=RequestMethod.GET)
	public String gennerate(){
		return "index";
	}
	
	@RequestMapping(value="/aboutUs",method=RequestMethod.GET)
	public String gennerateAboutUs(HttpServletRequest request){
		User loginUser = ((User)SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
		String url=basePath+"/sys/html/gennerateHtml";
		HTMLGenerator htmlGenerator = new HTMLGenerator(basePath);
		if(htmlGenerator.createHtmlPage(url,request.getSession().getServletContext().getRealPath("/"),loginUser.getUsername(),null)){
			MsgUtil.setMsg("succss", "恭喜您，生成首页成功！");
		}else{
			MsgUtil.setMsg("error", "对不起，生成首页失败！");
		}
		return InternalResourceViewResolver.REDIRECT_URL_PREFIX+"/admin/sys/html/";
	}
	
	@RequestMapping(value="/contactUs",method=RequestMethod.GET)
	public String gennerateContactUs(HttpServletRequest request){
		User loginUser = ((User)SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
		String url=basePath+"/sys/html/gennerateHtml";
		HTMLGenerator htmlGenerator = new HTMLGenerator(basePath);
		if(htmlGenerator.createHtmlPage(url,request.getSession().getServletContext().getRealPath("/"),loginUser.getUsername(),null)){
			MsgUtil.setMsg("succss", "恭喜您，生成首页成功！");
		}else{
			MsgUtil.setMsg("error", "对不起，生成首页失败！");
		}
		return InternalResourceViewResolver.REDIRECT_URL_PREFIX+"/admin/sys/html/";
	}
	
	@RequestMapping(value="/News",method=RequestMethod.GET)
	public String gennerateNews(HttpServletRequest request){
		User loginUser = ((User)SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
		String url=basePath+"/sys/html/gennerateHtml";
		HTMLGenerator htmlGenerator = new HTMLGenerator(basePath);
		if(htmlGenerator.createHtmlPage(url,request.getSession().getServletContext().getRealPath("/"),loginUser.getUsername(),null)){
			MsgUtil.setMsg("succss", "恭喜您，生成首页成功！");
		}else{
			MsgUtil.setMsg("error", "对不起，生成首页失败！");
		}
		return InternalResourceViewResolver.REDIRECT_URL_PREFIX+"/admin/sys/html/";
	}
	
	@RequestMapping(value="/Feedback",method=RequestMethod.GET)
	public String gennerateFeedback(HttpServletRequest request){
		User loginUser = ((User)SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
		String url=basePath+"/sys/html/gennerateHtml";
		HTMLGenerator htmlGenerator = new HTMLGenerator(basePath);
		if(htmlGenerator.createHtmlPage(url,request.getSession().getServletContext().getRealPath("/"),loginUser.getUsername(),null)){
			MsgUtil.setMsg("succss", "恭喜您，生成首页成功！");
		}else{
			MsgUtil.setMsg("error", "对不起，生成首页失败！");
		}
		return InternalResourceViewResolver.REDIRECT_URL_PREFIX+"/admin/sys/html/";
	}
	
	@RequestMapping(value="/products",method=RequestMethod.GET)
	public String gennerateProducts(HttpServletRequest request){
		User loginUser = ((User)SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
		String url=basePath+"/sys/html/gennerateHtml";
		HTMLGenerator htmlGenerator = new HTMLGenerator(basePath);
		if(htmlGenerator.createHtmlPage(url,request.getSession().getServletContext().getRealPath("/"),loginUser.getUsername(),null)){
			MsgUtil.setMsg("succss", "恭喜您，生成首页成功！");
		}else{
			MsgUtil.setMsg("error", "对不起，生成首页失败！");
		}
		return InternalResourceViewResolver.REDIRECT_URL_PREFIX+"/admin/sys/html/";
	}
	
}
