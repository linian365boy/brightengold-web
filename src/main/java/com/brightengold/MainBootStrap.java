package com.brightengold;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.support.SpringBootServletInitializer;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

@Configuration
@ComponentScan(basePackages={"com.brightengold","cn.rainier.nian"})
@MapperScan(basePackages={"com.brightengold.dao","cn.rainier.nian.dao"})
@EnableAutoConfiguration
public class MainBootStrap extends SpringBootServletInitializer {

    private static Logger logger = LoggerFactory.getLogger(MainBootStrap.class);

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(MainBootStrap.class);
	}
	
	public static void main(String[] args) {
        ApplicationContext ctx = SpringApplication.run(MainBootStrap.class, args);
        String[] activeProfiles = ctx.getEnvironment().getActiveProfiles();
        for (String profile : activeProfiles) {
            logger.warn("Spring Boot use {} profile" , profile);
        }
    }
}
