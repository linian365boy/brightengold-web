package com.brightengold.controller;

import cn.rainier.nian.helper.ResourceDetailsMonitor;
import cn.rainier.nian.model.Menu;
import cn.rainier.nian.model.Resource;
import cn.rainier.nian.model.Role;
import cn.rainier.nian.service.MenuService;
import cn.rainier.nian.service.ResourceService;
import cn.rainier.nian.service.RoleService;
import cn.rainier.nian.service.impl.RoleServiceImpl;
import cn.rainier.nian.utils.PageRainier;
import cn.rainier.nian.utils.UUIDGenerator;
import com.brightengold.common.vo.RequestParam;
import com.brightengold.service.LogUtil;
import com.brightengold.util.Constant;
import com.brightengold.util.LogType;
import com.brightengold.vo.MessageVo;
import com.brightengold.vo.ReturnData;
import org.apache.commons.lang.builder.ToStringStyle;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/admin/sys/role")
@Scope("prototype")
public class RoleController {

	@Autowired
	private RoleService roleService;
	@Autowired
	private ResourceService resourceService;
	@Autowired
	private ResourceDetailsMonitor resourceDetailsMonitor;
	@Autowired
	private MenuService menuService;
	private final static Logger logger = LoggerFactory.getLogger(RoleController.class);

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
	public String list(ModelMap map, HttpServletRequest request){
		map.put("ajaxListUrl","admin/sys/role/roles/getJsonList.html");
		return "admin/sys/role/list";
	}

	@ResponseBody
	@RequestMapping({"/roles/getJsonList"})
	public ReturnData<Role> getJsonList(RequestParam param){
		PageRainier<Role> roles = roleService.findAll(param);
		ReturnData<Role> datas = new ReturnData<Role>(roles.getTotalRowNum(), roles.getResult());
		return datas;
	}

	@RequestMapping(value="/add",method=RequestMethod.GET)
	public String add(Model model) {
		return "admin_unless/sys/role/add";
	}

	@ResponseBody
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public MessageVo add(Role role) {
		MessageVo vo = null;
		String marking = UUIDGenerator.getUUID().toUpperCase();
		role.setName("ROLE_"+marking);
		role.setCreateDate(new Date());
		if(roleService.saveRole(role)){
			LogUtil.getInstance().log(LogType.ADD,"角色："+role.getDescribes());
			logger.info("添加角色{}成功！",role);
			vo = new MessageVo(Constant.SUCCESS_CODE,"添加角色"+role.getDescribes()+"成功！");
		}else{
			logger.error("添加角色{}发生错误!",role);
			vo = new MessageVo(Constant.ERROR_CODE,"添加角色"+role.getDescribes()+"失败！");
		}
		return vo;
	}

	@RequestMapping(value="/{roleName}/update",method=RequestMethod.GET)
	public String update(@PathVariable String roleName,Model model) {
		if (roleName != null) {
			model.addAttribute("model",roleService.loadRoleByName(roleName));
		}
		return "admin_unless/sys/role/update";
	}

	@ResponseBody
	@RequestMapping(value="/{roleName}/update",method=RequestMethod.POST)
	public MessageVo update(@PathVariable String roleName,Role role) {
		MessageVo vo = null;
		if(roleName!=null){
			Role temp = roleService.loadRoleByName(role.getName());
			role.setCreateDate(temp.getCreateDate());
			role.setDefaultOrNo(temp.isDefaultOrNo());
			if(roleService.updateRole(role)){
				logger.info("修改角色信息|{}",role);
				LogUtil.getInstance().log(LogType.EDIT,"角色由\""+temp.getDescribes()+"\"修改为：\""+role.getDescribes()+"\"");
				vo = new MessageVo(Constant.SUCCESS_CODE,"角色【"+temp.getDescribes()+"】修改成功！");
			}else{
				vo = new MessageVo(Constant.ERROR_CODE,"角色【"+temp.getDescribes()+"】修改失败！");
			}
		}
		return vo;
	}

	@ResponseBody
	@RequestMapping(value="/{roleName}/del",method=RequestMethod.POST)
	public MessageVo del(@PathVariable String roleName){
		MessageVo vo = null;
		if(roleName!=null){
			Role role = roleService.loadRoleByName(roleName);
			if(roleService.delRole(roleName)){
				LogUtil.getInstance().log(LogType.DEL,"角色名为："+role.getDescribes());
				logger.warn("删除角色为{}",role.getDescribes());
				vo = new MessageVo(Constant.SUCCESS_CODE,"删除角色【"+role.getDescribes()+"】成功！");
			}else{
				vo = new MessageVo(Constant.ERROR_CODE,"删除角色【"+role.getDescribes()+"】失败！");
			}
		}
		return vo;
	}

	@RequestMapping(value="/{roleName}/qxfp",method=RequestMethod.GET)
	public String qxfp(@PathVariable String roleName,ModelMap map){
		Role role = roleService.loadRoleByName(roleName);
		map.put("role", role);
		StringBuilder sb = new StringBuilder();
		if(!CollectionUtils.isEmpty(role.getResources())){
			for(Resource res : role.getResources()){
				if(StringUtils.isNotBlank(sb.toString())){
					sb.append(",");
				}
				sb.append("r_"+res.getId());
			}
		}
		List<Menu> menus =  menuService.findMenuByRole(roleName);
		if(!CollectionUtils.isEmpty(menus)){
			for(Menu menu : menus){
				if(StringUtils.isNotBlank(sb.toString())){
					sb.append(",");
				}
				sb.append(menu.getId());
			}
		}
		map.put("menuOrResource", sb.toString());
		return "admin/sys/role/qxfp";
	}

	@RequestMapping(value="/{roleName}/viewResource",method=RequestMethod.GET)
	public String viewResource(@PathVariable("roleName") String roleId,ModelMap map){
		List<Resource> resources = roleService.findResourceById(roleId);
		map.put("resources", resources);
		map.put("roleDesc", roleService.findRoleDesc(roleId));
		return "admin_unless/sys/role/viewResource";
	}

	@ResponseBody
	@RequestMapping(value="/{roleName}/distribute",method=RequestMethod.POST)
	public MessageVo distribute(@PathVariable String roleName,HttpServletRequest request){
		MessageVo vo = null;
		Role model = null;
		try {
			//此处strIds既包括menuId也包括resourceId
			String strIds = request.getParameter("str");
			String[] strIdArr = null;
			model = roleService.loadRoleByName(roleName);
			boolean result = false;
			if(StringUtils.isNotBlank(strIds)){
				strIdArr = strIds.split(",");
				List<Resource> ress = new ArrayList<Resource>();
				List<Menu> menus = new ArrayList<Menu>();
				List<Resource> resources = null;
				Resource res = null;
				Menu menu = null;
				for(String str : strIdArr){
					if(str.startsWith("r_")){
						//resource资源
						res = resourceService.loadResourceByResource(Integer.parseInt(str.substring(2)));
						ress.add(res);
					}else{
						//menu菜单
						menu = menuService.loadMenuById(Integer.parseInt(str));
						resources = resourceService.findResourceByParentId(menu.getId());
						if(menu.getParentId()!=null && resources!=null && resources.size()==0){
							ress.addAll(resourceService.findAllResourceByParentId(menu.getId()));
						}
						menus.add(menu);
					}
				}
				if(!CollectionUtils.isEmpty(ress)){
					if(resourceService.updateRoleResources(roleName,ress)){
						result = true;
					}
				}else{
					result = true;
				}

				if(result && !CollectionUtils.isEmpty(menus)){
					if(menuService.updateRoleMenu(roleName,menus)){
						result = true;
					}else{
						result = false;
					}
				}
				if(result){
					LogUtil.getInstance().log(LogType.DISTRIBUTE, "重新分配了"+model.getDescribes()+"的权限");
					logger.warn("角色{}重新分配了权限{}，result|{}",model.getDescribes(),ress,result, ToStringStyle.SHORT_PREFIX_STYLE);
					//重新查询DB，更新权限
					resourceDetailsMonitor.afterPropertiesSet();
					request.getSession().removeAttribute("menuJson");
					vo = new MessageVo(Constant.SUCCESS_CODE,"角色【"+model.getDescribes()+"】分配权限成功！");
				}else{
					vo = new MessageVo(Constant.ERROR_CODE,"角色【"+(model==null?roleName:model.getDescribes())+"】分配权限失败！");
				}
			}
		} catch (Exception e) {
			logger.error("角色{}分配权限失败，发生错误：{}！",roleName,e);
			vo = new MessageVo(Constant.ERROR_CODE,"角色【"+(model==null?roleName:model.getDescribes())+"】分配权限失败！");
		}
		return vo;
	}

	public void setRoleService(RoleServiceImpl roleService) {
		this.roleService = roleService;
	}
	
}
