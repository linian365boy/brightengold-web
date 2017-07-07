package com.brightengold.initConfig;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.access.intercept.FilterSecurityInterceptor;
import cn.rainier.nian.security.MyFilterSecurityInterceptor;
import cn.rainier.nian.service.UserService;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {
	
	@Autowired
	private UserService userService;
	
	@Autowired  
	private MyFilterSecurityInterceptor mySecurityFilter; 
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.addFilterBefore(mySecurityFilter, FilterSecurityInterceptor.class)
			.authorizeRequests()
			.antMatchers("/admin/login","/admin/accessDenied","/admin/invalidate","/admin/logout").permitAll()
			.antMatchers("/admin/**").authenticated()
			.and()
			.formLogin()
			.loginPage("/admin/login")
			.defaultSuccessUrl("/admin/index")
			.permitAll()
			.and()
			.logout()
			.logoutUrl("/admin/logout")
			.logoutSuccessUrl("/admin/login");
	}
	
	@Override
	public void configure(WebSecurity web) throws Exception {
		web.ignoring().antMatchers("/resources/**");
	}
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(userService).passwordEncoder(new Md5PasswordEncoder());
	}
	
}
