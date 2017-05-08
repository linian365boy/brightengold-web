package com.brightengold;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.web.bind.annotation.RestController;

@RestController
@EnableAutoConfiguration
@ComponentScan("com.brightengold")
public class MainBootStrap {
	public static void main(String[] args) {
		SpringApplication.run(MainBootStrap.class, args);
	}
}
