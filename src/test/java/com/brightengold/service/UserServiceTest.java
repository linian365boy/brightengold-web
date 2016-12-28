package com.brightengold.service;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import cn.rainier.nian.model.User;
import cn.rainier.nian.service.UserService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:applicationContext.xml")
public class UserServiceTest extends AbstractJUnit4SpringContextTests {
	
	@Autowired
	private UserService userService;
	
	@Test
	public void testListUser(){
		List<User> users = userService.findUserByRole("ROLE_NULL");
		//返回的users为空的list
		assertNotNull(users);
	}
}
