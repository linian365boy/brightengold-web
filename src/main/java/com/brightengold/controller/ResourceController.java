package com.brightengold.controller;

import cn.rainier.nian.service.ResourceService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * @author niange
 * @ClassName: ResourceController
 * @desp: 最小颗粒化的资源，权限控制
 * @date: 2017/11/14 下午9:39
 * @since JDK 1.7
 */

@Controller
@RequestMapping("/admin/sys/res")
@Scope("prototype")
public class ResourceController {
    private final static Logger logger = LoggerFactory.getLogger(MenuController.class);
    @Autowired
    private ResourceService resourceService;

    @RequestMapping({"/",""})
    public String list(HttpServletRequest request, ModelMap map){
        map.put("ajaxListUrl","admin/sys/menu/menus/getJsonList");
        return "admin/sys/res/list";
    }



}
