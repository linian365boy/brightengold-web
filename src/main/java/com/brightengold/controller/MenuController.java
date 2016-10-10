package com.brightengold.controller;

import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import com.brightengold.service.LogUtil;
import com.brightengold.service.MsgUtil;
import com.brightengold.util.LogType;

import cn.rainier.nian.model.Menu;
import cn.rainier.nian.model.Resource;
import cn.rainier.nian.model.User;
import cn.rainier.nian.service.MenuService;
import cn.rainier.nian.service.ResourceService;
import cn.rainier.nian.utils.PageRainier;

@Controller
@RequestMapping("/admin/sys/menu")
@SessionAttributes("menuXml")
@Scope("prototype")
public class MenuController {
	@Autowired
	private MenuService menuService;
	@Autowired
	private ResourceService resourceService;
	private PageRainier<Menu> menus;
	private Integer pageSize = 10;
	private static Logger logger = LoggerFactory.getLogger(MenuController.class);
	
	@RequestMapping({"/menus/{pageNo}"})
	public String list(@PathVariable Integer pageNo, Model model){
		menus = menuService.findAll(pageNo, pageSize);
		model.addAttribute("page",menus);//map
		return "admin/sys/menu/list";
	}
	
	@RequestMapping(value="/add",method=RequestMethod.GET)
	public String addUI(ModelMap map){
		List<Menu> parentMenu = menuService.findParentByAjax();
		map.put("parentMenu", parentMenu);
		return "admin_unless/sys/menu/add";
	}
	
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public String add(Menu menu){
		try{
			if(menuService.saveMenu(menu)){
				MsgUtil.setMsgAdd("success");
				LogUtil.getInstance().log(LogType.ADD,"名称："+menu.getName());
				logger.info("添加菜单{}成功！",
						ToStringBuilder.reflectionToString(menu, ToStringStyle.SHORT_PREFIX_STYLE));
			}else{
				MsgUtil.setMsgAdd("error");
				LogUtil.getInstance().log(LogType.ADD,"名称："+menu.getName());
			}
		}catch(Exception e){
			MsgUtil.setMsgAdd("error");
			logger.error("新增菜单报错！",e);
		}
		return InternalResourceViewResolver.REDIRECT_URL_PREFIX+"/admin/sys/menu/menus/1.html";
	}
	
	private String generateJsonString(HttpServletRequest request,ModelMap model) {
		String output = "";
		String roleName = request.getParameter("name");
		String id = request.getParameter("id");
		String flag = request.getParameter("flag");
		if(id!=null&&!"0".equals(id)&&roleName!=null&&roleName.trim()!=""){
			output = generateTreeNodeXmlString(Long.parseLong(id),roleName);
		}else{
			if("true".equals(flag)){
				flag = "true";
			}else{
				flag = "false";
			}
			output = generateInitTreeString(model,roleName,Boolean.parseBoolean(flag));
		}
		return output;
	}
	
	private String generateTreeNodeXmlString(long parseLong, String roleName) {
		return null;
	}

	@ResponseBody
	@RequestMapping(value="/findMenuByRole",method=RequestMethod.GET)
	public String findMenuByRole(HttpServletRequest request,ModelMap model){
		String responseStr = this.generateJsonString(request,model);
		return responseStr;
	}
	
	/**
	 * @FunName: generateInitTreeString
	 * @Description:  获取第一级，第二级菜单
	 * @param flag
	 * @return
	 * @Author: 李年
	 * @CreateDate: 2013-5-9
	 */
	private String generateInitTreeString(ModelMap model,String name,boolean flag){
		Iterator<Menu> it = null;
		List<Menu> children = null;
		User user = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		StringBuilder jsonStr = new StringBuilder();
		List<Menu> menus = menuService.findParentMenuByRole(user.getRoles(),flag);
		List<Resource> resourceNames = null;	//角色能访问的资源
		List<Resource> resources = null;		//二级菜单下能访问的可显示的资源
		if(name!=null){
			resourceNames = resourceService.findResourceByRole(name);
		}
		String displayName;
		boolean flags = false;
		jsonStr.append("{\"tree\":{\"id\": \"0\",\"item\":[");
		int menusIndex = 0;
		for(Menu menu : menus){
			if(flag){
				displayName = menu.getMark();
			}else{
				displayName = menu.getName();
			}
			if(menusIndex>0){
				jsonStr.append(",");
			}
			jsonStr.append("{\"child\":\"1\",\"text\": \""+displayName+"\",\"id\": \""+menu.getId()+"\",\"url\": \""+menu.getUrl()+"\",\"item\":[");
			menusIndex++;
			if(menu.getChildren().size()>0&&menu.getChildren()!=null){
				children = menu.getChildren();
				it = children.iterator();
				Menu subMenu = null;
				int itIndex = 0;
				while(it.hasNext()){
					subMenu = it.next();
					if(flag){
						displayName = subMenu.getMark();
					}else{
						displayName = subMenu.getName();
					}
					resources = resourceService.findResourceByParentId(subMenu.getId());
					if(resources.size()==0&&flag){
						if(itIndex>0){
							jsonStr.append(",");
						}
						for(Iterator<Resource> itRes = resourceNames.iterator();itRes.hasNext();){
							if(itRes.next().getMenuId() == subMenu.getId()){
								flags = true;
								jsonStr.append("{\"checked\":\"1\",\"child\":\"0\",\"text\":\""+displayName+"\",\"id\":\""+subMenu.getId()+"\",\"url\":\""+subMenu.getUrl()+"\"}");
								itIndex++;
								break;
							}
							flags = false;
						}
						if(!flags){
							jsonStr.append("{\"child\":\"0\",\"text\":\""+displayName+"\",\"id\":'"+subMenu.getId()+"',\"url\":\""+subMenu.getUrl()+"\"}");
							itIndex++;
						}
					}else{
						if(itIndex>0){
							jsonStr.append(",");
						}
						jsonStr.append("{\"child\":\"1\",\"text\":\""+displayName+"\",\"id\":\""+subMenu.getId()+"\",\"url\":\""+subMenu.getUrl()+"\"}");
						itIndex++;
					}
				}
			}
			jsonStr.append("]}");
		}
		jsonStr.append("]}}");
		logger.info("能够访问的菜单json字符串menuJson=>{}",jsonStr.toString());
		return jsonStr.toString();
	}
	
	/**
	 * @FunName: generateTreeNodeXmlString
	 * @Description:  获取第三级资源
	 * @param menuId
	 * @param name
	 * @return
	 * @Author: 李年
	 * @CreateDate: 2013-5-9
	 */
	/*public String generateTreeNodeXmlString(Long menuId,String name){
		StringBuilder sb = new StringBuilder();
		List<Resource> resources = resourceService.findResourceByParentId(menuId);
		List<Resource> resourceNames = resourceService.findResourceByRole(name);
		sb.append("<?xml version='1.0' encoding='UTF-8'?>");
		sb.append("<tree id='"+menuId+"'>");
		Resource res = null;
		boolean flag = false;
		for(Iterator<Resource>  resIt = resources.iterator();resIt.hasNext();){
			res = resIt.next();
			for(Iterator<Resource> it=resourceNames.iterator();it.hasNext();){
				Integer id = it.next().getId();
				if(res.getId()==id){
					flag = true;
					sb.append("<item id='r_"+res.getId()+"' text='"+res.getDescn()+"' checked='1'/>");
					//it.remove();
					break;
				}
				flag = false;
			}
			if(!flag)
			sb.append("<item id='r_"+res.getId()+"' text='"+res.getDescn()+"'/>");
		}
		sb.append("</tree>");
		return sb.toString();
	}*/

	public PageRainier<Menu> getMenus() {
		return menus;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setMenus(PageRainier<Menu> menus) {
		this.menus = menus;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}
}
	/*
		{
		  "tree": {
		    "id": "0",
		    "item": [
		      {
		        "child": "1",
		        "text": "系统管理",
		        "id": "16",
		        "url": "javascript:void(0);",
		        "item": [
		          {
		            "child": "1",
		            "text": "用户管理",
		            "id": "17",
		            "url": "admin/sys/user/users/1.html"
		          },
		          {
		            "child": "1",
		            "text": "角色管理",
		            "id": "18",
		            "url": "admin/sys/role/roles/1.html"
		          }
		        ]
		      },
		      {
		        "child": "1",
		        "text": "滚动图片管理",
		        "id": "23",
		        "url": "javascript:void(0);",
		        "item": {
		          "child": "1",
		          "text": "首页滚动图片",
		          "id": "24",
		          "url": "admin/ad/ads/1.html"
		        }
		      }
		    ]
		  }
		}
		*/
