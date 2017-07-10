package com.brightengold.security;

import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ValidateCodeHandle {
	
	private static Logger logger = LoggerFactory.getLogger(ValidateCodeHandle.class);
	
	public static boolean matchCode(HttpServletRequest request, String inputCode) {
		String code = (String)request.getSession().getAttribute(cn.rainier.nian.utils.Constant.LOGIN_VERIFY_CODE_KEY);
		logger.info("validate code is {} and user input code is {}", code, inputCode);
		return inputCode.equalsIgnoreCase(code);
	}
	
	
	
}
