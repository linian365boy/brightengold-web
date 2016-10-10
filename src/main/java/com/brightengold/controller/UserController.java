package com.brightengold.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import cn.rainier.nian.model.Role;
import cn.rainier.nian.model.User;
import cn.rainier.nian.service.impl.RoleServiceImpl;
import cn.rainier.nian.service.impl.UserServiceImpl;
import cn.rainier.nian.utils.PageRainier;

import com.brightengold.service.LogUtil;
import com.brightengold.service.MsgUtil;
import com.brightengold.util.LogType;

@Controller
@RequestMapping("/admin/sys/user")
@Scope("prototype")
public class UserController {
	@Autowired
	private UserServiceImpl userService;
	@Autowired
	private RoleServiceImpl roleService;
	private PageRainier<User> users;
	private Integer pageSize = 10;
	private static Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@RequestMapping({"/users/{pageNo}"})
	public String list(@PathVariable Integer pageNo,Model model,HttpServletRequest request){
		if(pageNo==null){
			pageNo = 1;
		}
		User u = ((User)SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		//排除当前用户
		users = userService.findAllUser(pageNo, pageSize, u.getId());
		//排除自己
		model.addAttribute("page",users);//map
		return "admin/sys/user/list";
	}
	
	@RequestMapping(value="/add",method=RequestMethod.GET)
	public String add(Model model) {
		return "admin_unless/sys/user/add";
	}
	
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public String add(User user, HttpServletRequest request) {
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
			logger.info("添加了用户{}",ToStringBuilder.reflectionToString(user, ToStringStyle.SHORT_PREFIX_STYLE, true));
		} catch (Exception e) {
			MsgUtil.setMsgAdd("error");
			e.printStackTrace();
		}
		return InternalResourceViewResolver.REDIRECT_URL_PREFIX+"/admin/sys/user/users/1.html";
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
	
	@RequestMapping(value="/{username}/update",method=RequestMethod.POST)
	public String update(HttpServletRequest request,@PathVariable String username,User user) {
		Set<Role> roles = null;
		StringBuilder content = new StringBuilder();
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
			userService.saveUser(user);
			MsgUtil.setMsgUpdate("success");
			LogUtil.getInstance().log(LogType.EDIT,content.toString());
			logger.info("用户从：{}，修改为：{}",
					ToStringBuilder.reflectionToString(temp, ToStringStyle.SHORT_PREFIX_STYLE, true),
					ToStringBuilder.reflectionToString(user, ToStringStyle.SHORT_PREFIX_STYLE, true)
					);
		}
		return "redirect:/admin/sys/user/users/1.html";
	}
	
	@RequestMapping(value="/existUser",method=RequestMethod.POST)
	public String existUser(HttpServletRequest request,HttpServletResponse response){
		PrintWriter out = null;
		try {
			String username = request.getParameter("username");
			String name = request.getParameter("u");		//name为空表示添加，否则为编辑
			if(username!=null){
				response.setContentType("text/html;charset=UTF-8");
				out = response.getWriter();
				//如果没有修改username
				if(username.equals(name)){
					out.print(true);	//true表示可用
				}else{
					User u = userService.loadUserByName(username);
					if(u!=null){
						out.print(false);
					}else{
						out.print(true);	//true表示可用，用户名不存在
					}
				}
				out.flush();
			}
		} catch (IOException e) {
			logger.error("existUser方法报错",e);
		}finally{
			if(out!=null){
				out.close();
			}
		}
		return null;
	}
	
	@RequestMapping(value="/{username}/reset",method=RequestMethod.GET)
	public String reset(@PathVariable String username,User user,HttpServletResponse response){
		PrintWriter out = null;
		String actionMsg = "";
		try {
			response.setContentType("text/html");
			out = response.getWriter();
			if(user.getUsername()!=null){
				userService.resetPassword(user.getUsername());
				actionMsg = "重置密码成功！";
				LogUtil.getInstance().log(LogType.RESETPASSWORD, user.getUsername()+"的密码重置了");//日志记录
				logger.warn("用户：{}，密码重置了",user.getUsername());
				out.write(actionMsg);
				out.flush();
			}else{
				actionMsg = "用户不存在！重置密码失败！";
				logger.error("用户：{}，密码重置失败",user.getUsername());
				out.write(actionMsg);
				out.flush();
			}
		} catch (IOException e) {
			logger.error("用户名|{},密码重置方法报错",username,e);
		}finally{
			if(out!=null){
				out.close();
			}
		}
		return null;
	}
	
	@RequestMapping(value="/{username}/unsubscribe",method=RequestMethod.GET)
	public String unsubscribe(@PathVariable String username,User user){
		if (user.getUsername() != null) {
			user = userService.loadUserByName(user.getUsername());
			userService.unsubscribe(user);
			MsgUtil.setMsg("success", "注销用户成功！");
			//日志记录
			LogUtil.getInstance().log(LogType.NSUBSCTIBE, user.getUsername()+"被注销了");
			logger.warn("用户：{}，注销成功",user.getUsername());
		}
		return "redirect:/admin/sys/user/users/1.html";
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
			logger.error("修改密码出错："+e);
		}
		return actionMsg;
	}

	public PageRainier<User> getUsers() {
		return users;
	}

	public void setUsers(PageRainier<User> users) {
		this.users = users;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public UserServiceImpl getUserService() {
		return userService;
	}

	public void setUserService(UserServiceImpl userService) {
		this.userService = userService;
	}

	public RoleServiceImpl getRoleService() {
		return roleService;
	}

	public void setRoleService(RoleServiceImpl roleService) {
		this.roleService = roleService;
	}

}
