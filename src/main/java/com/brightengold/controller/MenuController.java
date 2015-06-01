package com.brightengold.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import cn.rainier.nian.model.Menu;
import cn.rainier.nian.model.Resource;
import cn.rainier.nian.model.User;
import cn.rainier.nian.service.impl.MenuServiceImpl;
import cn.rainier.nian.service.impl.ResourceServiceImpl;

@Controller
@RequestMapping("/admin/sys/menu")
@SessionAttributes("menuXml")
@Scope("prototype")
public class MenuController {
	@Autowired
	private MenuServiceImpl menuService;
	@Autowired
	private ResourceServiceImpl resourceService;
	private Logger logger = LoggerFactory.getLogger(MenuController.class);
	
	public String generateXmlString(HttpServletRequest request,Model model) {
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
			//根据客户要求更改
			//output = generateInitTreeStringByClient(roleName,Boolean.parseBoolean(flag));
		}
		return output;
	}
	
	@RequestMapping(value="/findMenuByRole",method=RequestMethod.GET)
	public void findMenuByRole(HttpServletRequest request,HttpServletResponse response,Model model){
		PrintWriter out = null;
		String str = generateXmlString(request,model);
		try{
			response.setCharacterEncoding("utf8");
			response.setContentType("text/xml;charset=UTF-8");
			out = response.getWriter();
			out.print(str);
			out.flush();
		}catch(IOException e){
			e.printStackTrace();
		}finally{
			if(out!=null){
				out.close();
			}
		}
	}
	
	/**
	 * @FunName: generateInitTreeString
	 * @Description:  获取第一级，第二级菜单
	 * @param flag
	 * @return
	 * @Author: 李年
	 * @CreateDate: 2013-5-9
	 */
	public String generateInitTreeString(Model model,String name,boolean flag){
		Iterator<Menu> it = null;
		List<Menu> children = null;
		String menuXml = null;
		User user = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		StringBuilder xmlStr = new StringBuilder();
		List<Menu> menus = menuService.findParentMenuByRole(user.getRoles(),flag);
		List<Resource> resourceNames = null;	//角色能访问的资源
		List<Resource> resources = null;		//二级菜单下能访问的可显示的资源
		if(name!=null){
			resourceNames = resourceService.findResourceByRole(name);
		}
		String displayName;
		boolean flags = false;
		xmlStr.append("<?xml version='1.0' encoding='UTF-8'?>");
		xmlStr.append("<tree id='0'>");
		for(Menu menu : menus){
			if(flag){
				displayName = menu.getMark();
			}else{
				displayName = menu.getName();
			}
			xmlStr.append("<item child='1' text='"+displayName+"' id='"+menu.getId()+"' url='"+menu.getUrl()+"'>");
			if(menu.getChildren().size()>0&&menu.getChildren()!=null){
				children = menu.getChildren();
				it = children.iterator();
				Menu subMenu = null;
				while(it.hasNext()){
					subMenu = it.next();
					if(flag){
						displayName = subMenu.getMark();
					}else{
						displayName = subMenu.getName();
					}
					resources = resourceService.findResourceByParentId(subMenu.getId());
					if(resources.size()==0&&flag){
						for(Iterator<Resource> itRes = resourceNames.iterator();itRes.hasNext();){
							if(itRes.next().getMenu().getId() == subMenu.getId()){
								flags = true;
								xmlStr.append("<item checked='1' child='0' text='"+displayName+"' id='"+subMenu.getId()+"' url='"+subMenu.getUrl()+"'/>");
								break;
							}
							flags = false;
						}
						if(!flags){
							xmlStr.append("<item child='0' text='"+displayName+"' id='"+subMenu.getId()+"' url='"+subMenu.getUrl()+"'/>");
						}
					}else{
						xmlStr.append("<item child='1' text='"+displayName+"' id='"+subMenu.getId()+"' url='"+subMenu.getUrl()+"'/>");
					}
				}
			}
			xmlStr.append("</item>");
		}
		xmlStr.append("</tree>");
		menuXml = xmlStr.toString();
		if(!flag){
			model.addAttribute("menuXml", menuXml);
		}
		return menuXml;
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
	public String generateTreeNodeXmlString(Long menuId,String name){
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
				Long id = it.next().getId();
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
	}
}
