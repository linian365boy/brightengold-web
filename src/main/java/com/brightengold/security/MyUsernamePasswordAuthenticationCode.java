package com.brightengold.security;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;

/**
 * @ClassName: MyUsernamePasswordAuthenticationCode  
 * @Description: 自定义验证码 
 * @date: 2017年7月10日 下午3:07:16 
 * 
 * @author tanfan 
 * @version  
 * @since JDK 1.7
 */
public class MyUsernamePasswordAuthenticationCode extends UsernamePasswordAuthenticationToken {
	/** 
	 * serialVersionUID:序列化
	 * @since JDK 1.7 
	 */ 
	private static final long serialVersionUID = 2946593796956451747L;
	/**
	 * 验证码
	 */
	private String validCode;
	
	public MyUsernamePasswordAuthenticationCode(String principal, String credentials, String validCode) {
		super(principal, credentials);
		this.validCode = validCode;
	}

	public String getValidCode() {
		return validCode;
	}

	public void setValidCode(String validCode) {
		this.validCode = validCode;
	}
	
}
