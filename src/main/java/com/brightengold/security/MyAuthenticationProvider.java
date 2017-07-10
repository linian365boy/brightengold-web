package com.brightengold.security;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetails;

public class MyAuthenticationProvider extends DaoAuthenticationProvider {
	
	@Override
	public boolean supports(Class<?> authentication) {
		return MyUsernamePasswordAuthenticationCode.class.isAssignableFrom(authentication);
	}
	
	@SuppressWarnings("deprecation")
	@Override
	protected void additionalAuthenticationChecks(UserDetails userDetails,
			UsernamePasswordAuthenticationToken authentication) throws AuthenticationException {
        if (authentication.getCredentials() == null) {
            throw new BadCredentialsException("用户名或密码错误!");
        }
        String presentedPassword = authentication.getCredentials().toString();
        if (!this.getPasswordEncoder().isPasswordValid(userDetails.getPassword(), presentedPassword, null)){
            throw new BadCredentialsException("用户名或密码错误!");
        }
	}
}
