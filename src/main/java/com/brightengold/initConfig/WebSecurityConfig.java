package com.brightengold.initConfig;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.authorizeRequests()
			.antMatchers("/","/admin/login","/admin/accessDenied.html","/admin/invalidate.html").permitAll()
			.anyRequest().authenticated()
			.and()
			.formLogin()
			.loginPage("/admin/login")
			.permitAll()
			.and()
			.logout()
			.permitAll();
	}
	
	public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception{
		auth.inMemoryAuthentication()
			.withUser("user")
			.password("password")
			.roles("USER");
	}
}
