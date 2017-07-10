package com.brightengold.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

public class MyValidCodeProcessingFilter extends AbstractAuthenticationProcessingFilter {
	
	private String usernameParam = "username";
	private String passwordParam = "password";
	private String validCodeParam = "validateCode";
	
	public MyValidCodeProcessingFilter() {
		super(new AntPathRequestMatcher("/admin/login", "POST"));
	}
	
	protected MyValidCodeProcessingFilter(String defaultFilterProcessesUrl) {
		super(defaultFilterProcessesUrl);
	}

	@Override
	public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response)
			throws AuthenticationException, IOException, ServletException {
		String username = request.getParameter(usernameParam);
        String password = request.getParameter(passwordParam);
        String validCode = request.getParameter(validCodeParam);
        valid(request, validCode);
        MyUsernamePasswordAuthenticationCode token = new MyUsernamePasswordAuthenticationCode(username, password, validCode);
        return this.getAuthenticationManager().authenticate(token);
	}

	private void valid(HttpServletRequest request, String validCode) {
		if (StringUtils.isBlank(validCode)) {
            throw new ValidCodeErrorException("验证码为空!");
        }
        if (!ValidateCodeHandle.matchCode(request, validCode)) {
            throw new ValidCodeErrorException("验证码错误!");
        }
	}
	
	

}
