package com.brightengold.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.LoginUrlAuthenticationEntryPoint;

/**
 * @ClassName: MyAuthenticationEntryPoint  
 * @Description: 自定义验证码的切入点 
 * @date: 2017年7月10日 下午3:03:43 
 * 
 * @author tanfan 
 * @version  
 * @since JDK 1.7
 */
public class MyAuthenticationEntryPoint extends LoginUrlAuthenticationEntryPoint {

	public MyAuthenticationEntryPoint(String loginFormUrl) {
		super(loginFormUrl);
	}
	
	@Override
	public void commence(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException authException) throws IOException, ServletException {
		super.commence(request, response, authException);
	}
	
}
