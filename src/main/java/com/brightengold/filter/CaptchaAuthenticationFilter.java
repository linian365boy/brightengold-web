package com.brightengold.filter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import cn.rainier.nian.exception.CaptchaException;
import cn.rainier.nian.utils.Constant;

/**
 * @ClassName: CaptchaAuthenticationFilter
 * @Description: 使用验证码的验证过滤器
 * @date: 2016年11月18日 下午2:32:48
 * 
 * @author tanfan
 * @version
 * @since JDK 1.7
 */
public class CaptchaAuthenticationFilter extends UsernamePasswordAuthenticationFilter {
	
	private static Logger logger = LoggerFactory.getLogger(CaptchaAuthenticationFilter.class);
	
	public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response)
			throws AuthenticationException {
		String genCode = this.obtainGeneratedCaptcha(request);
		String inputCode = this.obtainCaptcha(request);
		if (StringUtils.isBlank(genCode)){
			logger.error("登录验证码生成失败！！！");
			throw new CaptchaException(this.messages.getMessage("LoginAuthentication.captchaInvalid"));
		}
		if (!genCode.equalsIgnoreCase(inputCode)) {
			logger.warn("登录验证码与输入验证码不匹配！！！");
			throw new CaptchaException(this.messages.getMessage("LoginAuthentication.captchaNotEquals"));
		}
		return super.attemptAuthentication(request, response);
	}

	protected String obtainCaptcha(HttpServletRequest request) {
		return request.getParameter(Constant.FORM_CAPTCHA_NAME);
	}

	protected String obtainGeneratedCaptcha(HttpServletRequest request) {
		return (String) request.getSession().getAttribute(Constant.LOGIN_VERIFY_CODE_KEY);
	}
}
