package com.brightengold.filter;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;



public class LoginFilter implements Filter {
	private String styleVersion="";
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		//样式版本号
	    String path=filterConfig.getServletContext().getRealPath("/");
	    Date packageDate=null;
	    try {
	    	File file=new File(path+File.separator+"WEB-INF"+File.separator+"classes"+File.separator+"applicationContext.xml");
	    	packageDate=new Date((file).lastModified());
		} catch (Exception e) {
			packageDate=new Date();
		}
	    this.styleVersion=(new SimpleDateFormat("yyyyMMddHHmm")).format(packageDate);
	}

	@Override
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		request.getSession().setAttribute("style_v", styleVersion);
		chain.doFilter(servletRequest, servletResponse);
	}

	@Override
	public void destroy() {

	}

}
