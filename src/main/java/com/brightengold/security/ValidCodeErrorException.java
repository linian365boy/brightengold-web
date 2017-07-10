package com.brightengold.security;

import org.springframework.security.core.AuthenticationException;

/**
 * @ClassName: ValidCodeErrorException  
 * @Description: 自定义验证码异常 
 * @date: 2017年7月10日 下午3:14:37 
 * 
 * @author tanfan 
 * @version  
 * @since JDK 1.7
 */
public class ValidCodeErrorException extends AuthenticationException {
	/** 
	 * serialVersionUID:序列化
	 * @since JDK 1.7 
	 */ 
	private static final long serialVersionUID = 1756550444777052442L;

	public ValidCodeErrorException(String msg) {
		super(msg);
	}
	
	public ValidCodeErrorException(String msg, Throwable t) {
        super(msg, t);
	}

}
