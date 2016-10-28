package com.brightengold.controller;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.brightengold.common.vo.RequestParam;
import com.brightengold.service.LogUtil;
import com.brightengold.util.Constant;
import com.brightengold.util.LogType;
import com.brightengold.vo.MessageVo;
import com.brightengold.vo.ReturnData;

import cn.rainier.nian.model.Role;
import cn.rainier.nian.model.User;
import cn.rainier.nian.service.RoleService;
import cn.rainier.nian.service.UserService;
import cn.rainier.nian.service.impl.RoleServiceImpl;
import cn.rainier.nian.service.impl.UserServiceImpl;
import cn.rainier.nian.utils.PageRainier;

@Controller
@RequestMapping("/admin/sys/user")
@Scope("prototype")
public class UserController {
	@Autowired
	private UserService userService;
	@Autowired
	private RoleService roleService;
	private PageRainier<User> users;
	private static Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@RequestMapping({"/users/list"})
	public String list(ModelMap map,HttpServletRequest request){
		map.put("ajaxListUrl","admin/sys/user/users/getJsonList.html");
		return "admin/sys/user/list";
	}
	
	@ResponseBody
	@RequestMapping({"/users/getJsonList"})
	public ReturnData<User> getJsonList(RequestParam param){
		User u = ((User)SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		//排除当前用户
		users = userService.findAllUser(param, u.getId());
		ReturnData<User> datas = new ReturnData<User>(users.getTotalRowNum(), users.getResult());
		return datas;
	}
	
	@RequestMapping(value="/add",method=RequestMethod.GET)
	public String add(Model model) {
		return "admin_unless/sys/user/add";
	}
	
	@ResponseBody
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public MessageVo add(User user, HttpServletRequest request) {
		MessageVo vo = null;
		try {
			user.setAccountNonLocked(true);
			//日志记录
			Role role = roleService.loadRoleByName(request.getParameter("role"));
			Role defaultR = roleService.findDefault();
			Set<Role> roles = new HashSet<Role>();
			roles.add(role);		//设置用户选择的权限
			roles.add(defaultR);	//设置默认权限
			user.setRoles(roles);
			userService.saveUser(user);
			LogUtil.getInstance().log(LogType.ADD,"用户名："+user.getUsername()+" 姓名："+user.getRealName());
			logger.info("添加了用户{}",user);
			vo = new MessageVo(Constant.SUCCESS_CODE,"添加用户【"+user.getUsername()+"】成功！");
		} catch (Exception e) {
			vo = new MessageVo(Constant.ERROR_CODE,"添加用户【"+user.getUsername()+"】失败！");
		}
		return vo;
	}
	
	@RequestMapping(value="/{username}",method=RequestMethod.GET)
	public String detail(@PathVariable String username,Model model){
		if(username!=null&&username!=""){
			model.addAttribute("model",userService.loadUserByName(username));
		}
		return "admin_unless/sys/user/detail";
	}
	
	@RequestMapping(value="/{username}/update",method=RequestMethod.GET)
	public String update(@PathVariable String username,Model model) {
		if (username != null) {
			model.addAttribute("model",userService.loadUserByName(username));
			model.addAttribute("rolesAjax", roleService.findAllByAjax());
		}
		return "admin_unless/sys/user/update";
	}
	
	@ResponseBody
	@RequestMapping(value="/{username}/update",method=RequestMethod.POST)
	public MessageVo update(HttpServletRequest request,@PathVariable String username,User user) {
		Set<Role> roles = null;
		StringBuilder content = new StringBuilder();
		MessageVo vo = null;
		if(user.getId()!=null){
			User temp = userService.loadUserById(user.getId());
			if(!temp.getUsername().equals(user.getUsername())){
				content.append("用户名由\""+temp.getUsername()+"\""+"修改为\""+user.getUsername()+"\";");
			}else{
				content.append("用户名："+temp.getUsername());
			}
			if(!temp.getRealName().equals(user.getRealName())){
				content.append("姓名由\""+temp.getRealName()+"\"修改为\""+user.getRealName()+"\"");
			}else{
				content.append("姓名："+temp.getRealName());
			}
			
			roles = new HashSet<Role>();
			String role = request.getParameter("role");
			String enabled = request.getParameter("enabled");
			user.setPassword(temp.getPassword());
			user.setAccountNonLocked(temp.isAccountNonLocked());
			user.setLastCloseDate(temp.getLastCloseDate());
			if(enabled!=null){
				user.setEnabled(true);
			}else{
				user.setEnabled(false);
				user.setLastCloseDate(new Date());
			}
			roles.add(roleService.findDefault());
			roles.add(roleService.loadRoleByName(role));
			user.setRoles(roles);
			if(userService.updateUser(user)){
				LogUtil.getInstance().log(LogType.EDIT,content.toString());
				logger.info("用户从：{}，修改为：{}",temp,user);
				vo = new MessageVo(Constant.SUCCESS_CODE,"用户【"+user.getUsername()+"】修改成功！");
			}else{
				logger.warn("用户{}修改信息失败",temp);
				vo = new MessageVo(Constant.ERROR_CODE,"用户【"+user.getUsername()+"】修改失败！");
			}
		}
		return vo;
	}
	
	@ResponseBody
	@RequestMapping(value="/existUser",method=RequestMethod.POST)
	public boolean existUser(String username,String u){
		//name为空表示添加，否则为编辑
		boolean result = false;
		try {
			if(username!=null){
				//如果没有修改username
				if(username.equals(u)){
					result = true;	//true表示可用
				}else{
					User user = userService.loadUserByName(username);
					if(user==null){
						result = true;	//true表示可用，用户名不存在
					}
				}
			}
		} catch (Exception e) {
			logger.error("existUser方法报错",e);
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/{username}/reset",method=RequestMethod.GET)
	public String reset(@PathVariable String username,User user,HttpServletResponse response){
		String actionMsg = "";
		try {
			if(user.getUsername()!=null){
				userService.resetPassword(user.getUsername());
				actionMsg = "重置密码成功！";
				LogUtil.getInstance().log(LogType.RESETPASSWORD, user.getUsername()+"的密码重置了");//日志记录
				logger.warn("用户：{}，密码重置了",user.getUsername());
			}else{
				actionMsg = "用户不存在！重置密码失败！";
				logger.error("用户：{}，密码重置失败",user.getUsername());
			}
		} catch (Exception e) {
			logger.error("用户名|{},密码重置方法报错",username,e);
		}
		return actionMsg;
	}
	
	@ResponseBody
	@RequestMapping(value="/{username}/unsubscribe",method=RequestMethod.GET)
	public MessageVo unsubscribe(@PathVariable String username){
		MessageVo vo = null;
		if(userService.unsubscribe(username)){
			//日志记录
			LogUtil.getInstance().log(LogType.NSUBSCTIBE, username+"被注销了");
			logger.warn("用户：{}，注销成功",username);
			vo = new MessageVo(Constant.SUCCESS_CODE,"用户【"+username+"】注销成功");
		}else{
			vo = new MessageVo(Constant.ERROR_CODE,"用户【"+username+"】注销失败");
		}
		return vo;
	}
	
	@ResponseBody
	@RequestMapping(value="/modifyPass",method=RequestMethod.POST)
	public String modifyPass(String oldPassword,
			String newPassword1,
			String newPassword2){
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User u = (User) authentication.getPrincipal();
		String password = null;
		String actionMsg = "恭喜您，密码修改成功！";
		try {
			if (new Md5PasswordEncoder().encodePassword(oldPassword, null).equals(u.getPassword())) {
				if (newPassword1 != null && newPassword1.trim().length() > 0
						&& newPassword2 != null && newPassword2.trim().length() > 0
						&& newPassword1.equals(newPassword2)) {
					if(newPassword1.trim().length()>=6&&newPassword1.trim().length()<=12){
						if(Pattern.matches("^[0-9a-zA-Z]{6,12}$", newPassword1)){
							password = new Md5PasswordEncoder().encodePassword(newPassword1,null);
							userService.changePassword(oldPassword, password, authentication);
							logger.warn("用户|{}，成功修改密码",u.getUsername());
						}else{
							actionMsg = "密码修改失败，密码为数字或字母组成！";//字母需数字、字母
						}
					}else{
						actionMsg = "密码修改失败，新密码长度在6-12位！";//长度不一致
					}
				}else{
					actionMsg = "密码修改失败，密码输入不能为空或两次新密码输入不一致！";
				}
			}else{
				actionMsg = "密码修改失败，原密码输入错误！";
			}
		} catch (Exception e) {
			actionMsg = "密码修改失败！";
			logger.error("修改密码出错：",e);
		}
		return actionMsg;
	}

	public PageRainier<User> getUsers() {
		return users;
	}

	public void setUsers(PageRainier<User> users) {
		this.users = users;
	}

	public void setUserService(UserServiceImpl userService) {
		this.userService = userService;
	}

	public void setRoleService(RoleServiceImpl roleService) {
		this.roleService = roleService;
	}

}
