package com.brightengold.initConfig;

import java.util.Properties;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.task.TaskExecutor;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.security.core.userdetails.UserCache;
import org.springframework.security.core.userdetails.cache.NullUserCache;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;
import org.springframework.web.servlet.view.tiles3.TilesViewResolver;

import com.google.code.kaptcha.impl.DefaultKaptcha;
import com.google.code.kaptcha.util.Config;

@Configuration
public class InitConfiguration {
	
	@Bean
	public DefaultKaptcha druidDataSource(@Value("${kaptcha.border.yesOrNo}") String kaptchaBorder,
			@Value("${kaptcha.border.color}") String kaptchaBorderColor,
			@Value("${kaptcha.textproducer.font.color}") String kaptchaFontColor,
			@Value("${kaptcha.image.width}") String kaptchaImgWidth,
			@Value("${kaptcha.image.height}") String kaptchaImgHeight,
			@Value("${kaptcha.textproducer.font.size}") String kaptchaFontSize,
			@Value("${kaptcha.textproducer.char.length}") String kaptchaCharLength) {
		DefaultKaptcha kaptcha = new DefaultKaptcha();
		Properties properties = new Properties();
		properties.setProperty("kaptcha.border", kaptchaBorder);
		properties.setProperty("kaptcha.border.color", kaptchaBorderColor);
		properties.setProperty("kaptcha.textproducer.font.color", kaptchaFontColor);
		properties.setProperty("kaptcha.image.width", kaptchaImgWidth);
		properties.setProperty("kaptcha.image.height", kaptchaImgHeight);
		properties.setProperty("kaptcha.textproducer.font.size", kaptchaFontSize);
		properties.setProperty("kaptcha.textproducer.char.length", kaptchaCharLength);
		Config config = new Config(properties);
		kaptcha.setConfig(config);
		return kaptcha;
	}
	
	@Bean
	public JavaMailSender initMailSender(@Value("${email.host}") String host,
			@Value("${email.protocol}") String protocol,
			@Value("${email.port}") Integer port,
			@Value("${email.username}") String username,
			@Value("${email.password}") String password,
			@Value("${email.encoding}") String encoding,
			@Value("${email.mailSmtpAuth}") String smtpAuth,
			@Value("${email.prop}") String prop,
			@Value("${email.mailSmtpTimeout}") String smtpTimeout,
			@Value("${email.mailDebug}") String mailDebug){
		JavaMailSenderImpl sender = new JavaMailSenderImpl();
		sender.setHost(host);
		sender.setProtocol(protocol);
		sender.setPort(port);
		sender.setUsername(username);
		sender.setPassword(password);
		sender.setDefaultEncoding(encoding);
		Properties properties = new Properties();
		properties.setProperty("mail.smtp.auth", smtpAuth);
		properties.setProperty("prop", prop);
		properties.setProperty("mail.smtp.timeout", smtpTimeout);
		properties.setProperty("mail.debug", mailDebug);
		sender.setJavaMailProperties(properties);
		return sender;
	}
	
	@Bean
	public TaskExecutor initTaskExecutor(@Value("${task.executor.corePoolSize}") int  corePoolSize,
			@Value("${task.executor.maxPoolSize}") int maxPoolSize,
			@Value("${task.executor.queueCapacity}") int queueCapacity){
		ThreadPoolTaskExecutor taskExecutor = new ThreadPoolTaskExecutor();
		taskExecutor.setCorePoolSize(corePoolSize);
		taskExecutor.setMaxPoolSize(maxPoolSize);
		taskExecutor.setQueueCapacity(queueCapacity);
		return taskExecutor;
	}
	
	/**
	 * tilesConfigurer:集成tiles
	 * @author tanfan 
	 * @return 
	 * @since JDK 1.7
	 */
	@Bean
	public TilesConfigurer tilesConfigurer(){
		final TilesConfigurer configurer = new TilesConfigurer();
		configurer.setDefinitions(new String[]{"/WEB-INF/tiles.xml"});
		configurer.setCheckRefresh(true);
		return configurer;
	}
	
	/**
	 * tielsViewResolver:集成tiles
	 * @author tanfan 
	 * @return 
	 * @since JDK 1.7
	 */
	@Bean
	public TilesViewResolver tielsViewResolver(){
		final TilesViewResolver resolver = new TilesViewResolver();
		resolver.setViewClass(TilesView.class);
		resolver.setContentType("text/html;charset=UTF-8");
		return resolver;
	}
	
	@Bean
	public UserCache userCache(){
		return new NullUserCache();
	}
	
}
