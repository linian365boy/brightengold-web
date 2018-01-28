package com.brightengold.controller;

import cn.rainier.nian.model.Role;
import cn.rainier.nian.model.User;
import cn.rainier.nian.service.RoleService;
import cn.rainier.nian.service.UserService;
import cn.rainier.nian.utils.PageRainier;
import com.brightengold.common.vo.RequestParam;
import com.brightengold.service.LogUtil;
import com.brightengold.util.Constant;
import com.brightengold.util.LogType;
import com.brightengold.vo.MessageVo;
import com.brightengold.vo.ReturnData;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
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

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.regex.Pattern;

@Controller
@RequestMapping("/admin/sys/user")
@Scope("prototype")
public class UserController {
	@Autowired
	private UserService userService;
	@Autowired
	private RoleService roleService;
	@Autowired
	private LogUtil logUtil;
	private final static Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@RequestMapping({"/users/list"})
	public String list(ModelMap map,HttpServletRequest request){
		map.put("ajaxListUrl","admin/sys/user/users/getJsonList");
		return "admin/sys/user/list";
	}
	
	@ResponseBody
	@RequestMapping({"/users/getJsonList"})
	public ReturnData<User> getJsonList(RequestParam param){
		User u = ((User)SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		//排除当前用户
		PageRainier<User> users = userService.findAllUser(param, u.getId());
		for(User user : users.getResult()){
			user.setRoles(roleService.findNoDefaultRoleByUser(user.getId()));
		}
		ReturnData<User> datas = new ReturnData<User>(users.getTotalRowNum(), users.getResult());
		return datas;
	}
	
	@RequestMapping(value="/add",method=RequestMethod.GET)
	public String add(Model model) {
		return "admin_unless/sys/user/add";
	}
	
	@ResponseBody
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public MessageVo add(User user, String role) {
		logger.info("add user param  => {}, role => {}", user, role);
		MessageVo vo = null;
		user.setAccountNonLocked(true);
		//日志记录
		Role tempRole = roleService.loadRoleByName(role);
		Role defaultR = roleService.findDefault();
		//设置用户选择的权限；设置默认权限
		List<Role> roles = Arrays.asList(tempRole,defaultR);
		user.setRoles(roles);
		user.setCreateDate(new Date());
		if(userService.saveUser(user)){
			logUtil.log(LogType.ADD,"用户名："+user.getUsername()+" 姓名："+user.getRealName());
			logger.info("添加了用户{}",user);
			vo = new MessageVo(Constant.SUCCESS_CODE,"添加用户【"+user.getUsername()+"】成功！");
		}else{
			vo = new MessageVo(Constant.ERROR_CODE,"添加用户【"+user.getUsername()+"】失败！");
		}
		logger.info("add user return data => {}", vo);
		return vo;
	}
	
	@RequestMapping(value="/{userId}",method=RequestMethod.GET)
	public String detail(@PathVariable Integer userId,Model model){
		model.addAttribute("model",userService.loadUserById(userId));
		return "admin_unless/sys/user/detail";
	}
	
	@RequestMapping(value="/{userId}/update",method=RequestMethod.GET)
	public String update(@PathVariable Integer userId,ModelMap map) {
		User user = userService.loadUserById(userId);
		map.put("model",user);
		map.put("roles",roleService.findNoDefaultRoleByUser(userId));
		map.put("rolesAjax", roleService.findAllByAjax());
		return "admin_unless/sys/user/update";
	}
	
	@ResponseBody
	@RequestMapping(value="/{userId}/update",method=RequestMethod.POST)
	public MessageVo update(String role,@PathVariable Integer userId,User user) {
		logger.info("update user param => {}, role => {}", user, role);
		List<Role> roles = null;
		StringBuilder content = new StringBuilder();
		MessageVo vo = null;
		User temp = userService.loadUserById(user.getId());
		List<Role> userRoles = roleService.findNoDefaultRoleByUser(userId);
		//判断角色是否修改标志,true  修改 ；false 未修改
		boolean roleIsUpdateFlag = true;
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
		
		roles = new ArrayList<Role>();
		user.setPassword(temp.getPassword());
		user.setAccountNonLocked(temp.isAccountNonLocked());
		user.setLastCloseDate(temp.getLastCloseDate());
		if(!user.isEnabled()){
			user.setLastCloseDate(new Date());
		}
		
		//判断是否修改角色
		if(StringUtils.isBlank(role) && CollectionUtils.isEmpty(userRoles)){
			//没有修改角色
			roleIsUpdateFlag = false;
		}else{
			for(Role r : userRoles){
				if(role.equals(r.getName())){
					//没有修改角色
					roleIsUpdateFlag = false;
					break;
				}
			}
		}
		if(userService.updateUser(user)){
			if(roleIsUpdateFlag){
				roles.add(roleService.findDefault());
				roles.add(new Role(role));
				if(roleService.updateUserRole(user.getId(),roles)){
					logUtil.log(LogType.EDIT,content.toString());
					logger.info("user update from => {} to => {}",temp, user);
					vo = new MessageVo(Constant.SUCCESS_CODE,"用户【"+user.getUsername()+"】修改成功！");
				}else{
					logUtil.log(LogType.EDIT,content.toString());
					logger.info("user update from => {} to => {}",temp, user);
					vo = new MessageVo(Constant.ERROR_CODE,"用户【"+user.getUsername()+"】修改失败！");
				}
			}else{
				logUtil.log(LogType.EDIT,content.toString());
				logger.info("user update from => {} to => {}",temp, user);
				vo = new MessageVo(Constant.SUCCESS_CODE,"用户【"+user.getUsername()+"】修改成功！");
			}
		}else{
			logger.warn("user => {} update fail.",temp);
			vo = new MessageVo(Constant.ERROR_CODE,"用户【"+user.getUsername()+"】修改失败！");
		}
		logger.info("update user return data => {}", vo);
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
	public MessageVo reset(@PathVariable String username){
		logger.info("reset passowrd param => {}", username);
		MessageVo vo = null;
		try {
			userService.resetPassword(username);
			vo = new MessageVo(Constant.SUCCESS_CODE,"用户名【"+username+"】重置密码成功！");
			logUtil.log(LogType.RESETPASSWORD, username+"的密码重置了");//日志记录
		} catch (Exception e) {
			vo = new MessageVo(Constant.ERROR_CODE,"用户【"+username+"】重置密码失败！");
			logger.error("username => {}, reset password error.",username,e);
		}
		logger.info("reset passowrd return data => {}", vo);
		return vo;
	}
	
	@ResponseBody
	@RequestMapping(value="/{username}/unsubscribe",method=RequestMethod.GET)
	public MessageVo unsubscribe(@PathVariable String username){
		logger.info("unsubscribe param => {}", username);
		MessageVo vo = null;
		if(userService.unsubscribe(username)){
			//日志记录
			logUtil.log(LogType.NSUBSCTIBE, username+"被注销了");
			logger.warn("用户：{}，注销成功",username);
			vo = new MessageVo(Constant.SUCCESS_CODE,"用户【"+username+"】注销成功");
		}else{
			vo = new MessageVo(Constant.ERROR_CODE,"用户【"+username+"】注销失败");
		}
		logger.info("unsubscribe return data => {}", vo);
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
							logger.warn("username => {}, succeed update password.",u.getUsername());
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
			logger.error("username => {}, update password error.",u.getUsername(), e);
		}
		logger.info("username => {}, update password return data => {}", u.getUsername(), actionMsg);
		return actionMsg;
	}

}
