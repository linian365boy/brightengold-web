package com.brightengold.initConfig;

import org.apache.commons.lang3.time.DateFormatUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;

import javax.servlet.ServletContext;

/**
 * @author niange
 * @ClassName: AppListener
 * @desp:
 * @date: 2018/1/27 下午7:21
 * @since JDK 1.7
 */
@Component
public class AppListener implements ApplicationListener<ContextRefreshedEvent> {

    private static final Logger logger = LoggerFactory.getLogger(AppListener.class);

    @Autowired
    private ServletContext servletContext;

    @Override
    public void onApplicationEvent(ContextRefreshedEvent event) {
        logger.info("enter application event.");
        ApplicationContext context = event.getApplicationContext();
        if(context.getParent() == null){
            logger.info("set style and js version.");
            servletContext.setAttribute("style_v",
                    DateFormatUtils.format(System.currentTimeMillis(), "yyyyMMddHHmmss"));
        }else{
            logger.info("context parent not null.");
        }
    }

}