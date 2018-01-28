package com.brightengold;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.support.SpringBootServletInitializer;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

@Configuration
@ComponentScan(basePackages={"com.brightengold","cn.rainier.nian"})
@MapperScan(basePackages={"com.brightengold.dao","cn.rainier.nian.dao"})
@EnableAutoConfiguration
public class MainBootStrap extends SpringBootServletInitializer {

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(MainBootStrap.class);
	}
	
	public static void main(String[] args) {
        SpringApplication.run(MainBootStrap.class, args);
    }
}
