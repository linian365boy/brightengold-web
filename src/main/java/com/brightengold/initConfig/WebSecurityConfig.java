package com.brightengold.initConfig;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.context.AbstractSecurityWebApplicationInitializer;
import com.brightengold.security.FrontAuthenticationFailureHandler;
import com.brightengold.security.FrontAuthenticationSuccessHandler;
import com.brightengold.security.MyAuthenticationEntryPoint;
import com.brightengold.security.MyAuthenticationProvider;
import com.brightengold.security.MyValidCodeProcessingFilter;
import cn.rainier.nian.service.UserService;

@SuppressWarnings("deprecation")
@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends AbstractSecurityWebApplicationInitializer {
	@Autowired
	private UserService userService;
	@Bean
    public PasswordEncoder passwordEncoder() {
        return new Md5PasswordEncoder();
    }
	
	@Configuration
    @Order(1)
	public class FrontendWebSecurityConfigureAdapter extends WebSecurityConfigurerAdapter {
		@Autowired
		private MyValidCodeProcessingFilter MyValidCodeProcessingFilter;
		@Override
		protected void configure(HttpSecurity http) throws Exception {
			http.csrf().disable().authorizeRequests()
				.antMatchers("/admin/login","/admin/accessDenied","/admin/invalidate","/admin/logout").permitAll()
				.antMatchers("/admin/**").authenticated()
				.and()
				.addFilterBefore(MyValidCodeProcessingFilter, UsernamePasswordAuthenticationFilter.class)
				.formLogin()
				.loginPage("/admin/login")
				.defaultSuccessUrl("/admin/index")
				.permitAll()
				.and()
				.logout()
				.logoutUrl("/admin/logout")
				.logoutSuccessUrl("/admin/login");
			http.headers().frameOptions().disable();
		}
		
		@Override
		public void configure(WebSecurity web) throws Exception {
			web.ignoring().antMatchers("/resources/**");
		}
		
	}
	
	@Bean
    public MyAuthenticationProvider frontAuthenticationProvider() {
        MyAuthenticationProvider myAuthenticationProvider = new MyAuthenticationProvider();
        myAuthenticationProvider.setUserDetailsService(userService);
        myAuthenticationProvider.setPasswordEncoder(passwordEncoder());
        return myAuthenticationProvider;
    }
	
	@Bean
    public AuthenticationManager authenticationManager() {
        List<AuthenticationProvider> list = new ArrayList<>();
        list.add(frontAuthenticationProvider());
        AuthenticationManager authenticationManager = new ProviderManager(list);
        return authenticationManager;
    }
	
	@Bean
    public MyValidCodeProcessingFilter myValidCodeProcessingFilter(AuthenticationManager authenticationManager) {
        MyValidCodeProcessingFilter filter = new MyValidCodeProcessingFilter();
        filter.setAuthenticationManager(authenticationManager);
        filter.setAuthenticationSuccessHandler(frontAuthenticationSuccessHandler());
        filter.setAuthenticationFailureHandler(frontAuthenticationFailureHandler());
        return filter;
    }
	
	@Bean
    public FrontAuthenticationFailureHandler frontAuthenticationFailureHandler() {
        return new FrontAuthenticationFailureHandler("/admin/login");
    }

    @Bean
    public FrontAuthenticationSuccessHandler frontAuthenticationSuccessHandler() {
        return new FrontAuthenticationSuccessHandler("/admin/index");
    }
	
    @Bean
    public MyAuthenticationEntryPoint myAuthenticationEntryPoint() {
        return new MyAuthenticationEntryPoint("/admin/login");
    }
    
}
