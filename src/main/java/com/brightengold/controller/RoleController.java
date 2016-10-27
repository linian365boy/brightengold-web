package com.brightengold.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import com.brightengold.common.vo.RequestParam;
import com.brightengold.service.LogUtil;
import com.brightengold.service.MsgUtil;
import com.brightengold.util.LogType;
import com.brightengold.vo.ReturnData;

import cn.rainier.nian.helper.ResourceDetailsMonitor;
import cn.rainier.nian.model.Menu;
import cn.rainier.nian.model.Resource;
import cn.rainier.nian.model.Role;
import cn.rainier.nian.service.RoleService;
import cn.rainier.nian.service.impl.MenuServiceImpl;
import cn.rainier.nian.service.impl.ResourceServiceImpl;
import cn.rainier.nian.service.impl.RoleServiceImpl;
import cn.rainier.nian.utils.PageRainier;
import cn.rainier.nian.utils.UUIDGenerator;

@Controller
@RequestMapping("/admin/sys/role")
@Scope("prototype")
public class RoleController {
	@Autowired
	private RoleService roleService;
	private PageRainier<Role> roles;
	@Autowired
	private ResourceServiceImpl resourceService;
	@Autowired
	private ResourceDetailsMonitor resourceDetailsMonitor;
	@Autowired
	private MenuServiceImpl menuService;
	private static Logger logger = LoggerFactory.getLogger(RoleController.class);
	
	/**
	 * @FunName: getRolesByAjax
	 * @Description:  通过ajax请求获得角色标识与描述
	 * @return
	 * @Author: tanfan
	 */
	@RequestMapping(value="/getRolesByAjax",method=RequestMethod.GET)
	@ResponseBody
	public List<Role> getRolesByAjax(){
		List<Role> rolesByAjax = roleService.findAllByAjax();
		return rolesByAjax;
	}
	
	@RequestMapping({"/roles/list"})
	public String list(ModelMap map,HttpServletRequest request){
		map.put("ajaxListUrl","admin/sys/role/roles/getJsonList.html");
		return "admin/sys/role/list";
	}
	
	@ResponseBody
	@RequestMapping({"/roles/getJsonList"})
	public ReturnData<Role> getJsonList(RequestParam param){
		roles = roleService.findAll(param);
		ReturnData<Role> datas = new ReturnData<Role>(roles.getTotalRowNum(), roles.getResult());
		return datas;
	}
	
	@RequestMapping(value="/add",method=RequestMethod.GET)
	public String add(Model model) {
		return "admin_unless/sys/role/add";
	}
	
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public String add(Role role, HttpServletRequest request) {
		try {
			String marking = UUIDGenerator.getUUID().toUpperCase();
			role.setName("ROLE_"+marking);
			role.setCreateDate(new Date());
			roleService.saveRole(role);
			MsgUtil.setMsgAdd("success");
			LogUtil.getInstance().log(LogType.ADD,"角色："+role.getDescribes());
			logger.info("添加角色{}成功！",role);
		} catch (Exception e) {
			MsgUtil.setMsgAdd("error");
			logger.error("添加角色发生错误：{}",e);
		}
		return InternalResourceViewResolver.REDIRECT_URL_PREFIX+"/admin/sys/role/roles/1.html";
	}
	
	@RequestMapping(value="/{roleName}/update",method=RequestMethod.GET)
	public String update(@PathVariable String roleName,Model model) {
		if (roleName != null) {
			model.addAttribute("model",roleService.loadRoleByName(roleName));
		}
		return "admin_unless/sys/role/update";
	}
	
	@RequestMapping(value="/{roleName}/update",method=RequestMethod.POST)
	public String update(@PathVariable String roleName,Role role) {
		if(roleName!=null){
			Role temp = roleService.loadRoleByName(role.getName());
			String ryName = temp.getDescribes();
			temp.setDescribes(role.getDescribes());
			roleService.saveRole(temp);
			logger.info("修改角色信息|{}",temp);
			MsgUtil.setMsgUpdate("success");
			LogUtil.getInstance().log(LogType.EDIT,"角色由\""+ryName+"\"修改为：\""+temp.getDescribes()+"\"");
		}
		return "redirect:/admin/sys/role/roles/1.html";
	}
	
	@RequestMapping(value="/{roleName}/del",method=RequestMethod.GET)
	public String del(@PathVariable String roleName){
		if(roleName!=null){
			Role role = roleService.loadRoleByName(roleName);
			/*for(User u : role.getUsers()){
				u.getRoles().remove(role);
			}*/
			roleService.delRole(roleName);
			MsgUtil.setMsgDelete("success");
			LogUtil.getInstance().log(LogType.DEL,"角色名为："+role.getDescribes());
			logger.warn("删除角色为{}",role.getDescribes());
		}
		return "redirect:/admin/sys/role/roles/1.html";
	}
	
	@RequestMapping(value="/qxfp",method=RequestMethod.GET)
	public String qxfp(){
		return "admin/sys/role/qxfp";
	}
	
	@RequestMapping(value="/{roleName}/distribute",method=RequestMethod.POST)
	public String distribute(@PathVariable String roleName,HttpServletRequest request,HttpSession session){
		try {
			if(roleName!=null){
				//此处strIds既包括menuId也包括resourceId
				String strIds = request.getParameter("str");
				String[] strIdArr = null;
				Role model = roleService.loadRoleByName(roleName);
				if(strIds!=null&&strIds.trim()!=""){
					strIdArr = strIds.split(",");
					List<Resource> ress = new ArrayList<Resource>();
					List<Menu> menus = new ArrayList<Menu>();
					List<Resource> resources = null;
					Resource res = null;
					Menu menu = null;
					for(String str : strIdArr){
						if(str.startsWith("r_")){
							res = resourceService.loadResourceByResource(Integer.parseInt(str.substring(2)));
							ress.add(res);
						}else{
							menu = menuService.loadMenuById(Integer.parseInt(str));
							//resources = resourceService.findResourceByParentId(menu.getId());
							//if(menu.getParentMenu()!=null&&resources!=null&&resources.size()==0){
							//	ress.addAll(resourceService.findAllResourceByParentId(menu.getId()));
							//}
							menus.add(menu);
						}
					}
					//model.setResources(ress);
					//model.setMenus(menus);
				}else{
					if(strIds!=null){
						//model.setResources(null);
						//model.setMenus(null);
					}
				}
				roleService.saveRole(model);
				MsgUtil.setMsg("success", "成功分配【"+model.getDescribes()+"】权限！");
				LogUtil.getInstance().log(LogType.DISTRIBUTE, "重新分配了"+model.getDescribes()+"的权限");
				//logger.warn("角色{}重新分配了权限{}",model.getDesc(),
				//		ToStringBuilder.reflectionToString(model.getResources(), 
				//				ToStringStyle.SHORT_PREFIX_STYLE));
				try {
					resourceDetailsMonitor.afterPropertiesSet();
					session.removeAttribute("menuXml");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}else{
				MsgUtil.setMsg("error", "分配权限失败！");
				logger.error("角色{}分配权限失败！",roleName);
			}
		} catch (NumberFormatException e) {
			MsgUtil.setMsg("error", "分配权限失败！");
			logger.error("角色{}分配权限失败，发生错误：{}！",roleName,e);
		}
		return "redirect:/admin/sys/role/roles/1.html";
	}

	public void setRoleService(RoleServiceImpl roleService) {
		this.roleService = roleService;
	}

	public PageRainier<Role> getRoles() {
		return roles;
	}

	public void setRoles(PageRainier<Role> roles) {
		this.roles = roles;
	}
}
