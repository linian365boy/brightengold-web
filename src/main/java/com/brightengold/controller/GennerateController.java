package com.brightengold.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import cn.rainier.nian.model.User;
import com.brightengold.service.ColumnService;
import com.brightengold.service.MsgUtil;
import com.brightengold.util.FreemarkerUtil;
import com.brightengold.util.HTMLGenerator;

@Controller
@RequestMapping("/admin/sys/html")
@Scope("prototype")
public class GennerateController {
	
	private Logger logger = LoggerFactory.getLogger(GennerateController.class);
	@Autowired
	private ColumnService columnService;
	
	@RequestMapping(value={"/generate"},method=RequestMethod.GET)
	public String toGennerateHtml(){
		return "admin/sys/html/generate";
	}
	
	@RequestMapping(value={"/{code}/generate",""})
	public String gennerateHtml(@PathVariable String code){
		columnService.loadColumnByCode(code);
		return null;
	}
	
	@RequestMapping(value="/index",method=RequestMethod.GET)
	public String gennerateIndex(HttpServletRequest request){
		try{
			String basePath = request.getScheme()+"://"+request.getServerName()+":"+
					request.getServerPort()+request.getContextPath();
			String path = request.getSession().getServletContext().getRealPath("/");
			Map<String,Object> root = new HashMap<String,Object>();
			root.put("ctx", basePath);
			FreemarkerUtil.fprint("index.ftl", root, path+File.separator, "index.htm");
			MsgUtil.setMsg("success", "恭喜您，生成首页成功！");
			logger.info("生成首页成功！");
		}catch(Exception e){
			MsgUtil.setMsg("error", "对不起，生成首页失败！");
			logger.error("生成页面发生错误：{}",new Object[]{e});
		}
		return "redirect:/admin/sys/html/generate.html";
	}
	
	@RequestMapping(value="/gennerateHtml",method=RequestMethod.GET)
	public String gennerate(){
		return "index";
	}
	
	@RequestMapping(value="/aboutUs",method=RequestMethod.GET)
	public String gennerateAboutUs(HttpServletRequest request){
		/*try{
			
		}catch(Exception e){
			MsgUtil.setMsg("error", "对不起，生成关于我们页面失败！");
			logger.error("生成关于我们页面发生错误：{}",new Object[]{e});
		}*/
		User loginUser = ((User)SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
		String url=basePath+"/sys/html/gennerateHtml";
		HTMLGenerator htmlGenerator = new HTMLGenerator(basePath);
		if(htmlGenerator.createHtmlPage(url,request.getSession().getServletContext().getRealPath("/"),loginUser.getUsername(),null)){
			MsgUtil.setMsg("succss", "恭喜您，生成首页成功！");
		}else{
			MsgUtil.setMsg("error", "对不起，生成首页失败！");
		}
		return "redirect:/admin/sys/html/generate.html";
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
