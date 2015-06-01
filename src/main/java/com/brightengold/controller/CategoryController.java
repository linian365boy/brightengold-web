package com.brightengold.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import cn.rainier.nian.model.User;
import cn.rainier.nian.utils.PageRainier;

import com.brightengold.model.Category;
import com.brightengold.service.CategoryService;
import com.brightengold.service.LogUtil;
import com.brightengold.service.MsgUtil;
import com.brightengold.util.LogType;

@Controller
@RequestMapping("/admin/goods/category")
@Scope("prototype")
public class CategoryController {
	@Autowired
	private CategoryService categoryService;
	private PageRainier<Category> categorys;
	private Integer pageSize = 10;
	private Logger logger = LoggerFactory.getLogger(CategoryController.class);
	
	@RequestMapping(value={"/categorys/{pageNo}"})
	public String list(@PathVariable Integer pageNo,Model model,HttpServletRequest request){
		if(pageNo==null){
			pageNo = 1;
		}
		categorys = categoryService.findAll(pageNo, pageSize);
		model.addAttribute("page",categorys);//map
		return "admin/goods/category/list";
	}
	
	@RequestMapping(value="/add",method=RequestMethod.GET)
	public String add(Model model) {
		return "admin/goods/category/add";
	}
	
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public String add(Category category, HttpServletRequest request) {
		User u = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		try {
			if(Integer.parseInt(request.getParameter("parentC"))==0){
				category.setParent(null);
			}else{
				category.setParent(categoryService.loadCategoryById(Integer.parseInt(request.getParameter("parentC"))));
			}
			category.setCreateDate(new Date());
			category.setCreateUser(u);
			categoryService.saveCategory(category);
			MsgUtil.setMsgAdd("success");
			LogUtil.getInstance().log(LogType.ADD,"名称："+category.getEnName());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return InternalResourceViewResolver.REDIRECT_URL_PREFIX+"/admin/goods/category/categorys/1.html";
	}
	
	@RequestMapping(value="/getParentByAjax/{flag}",method=RequestMethod.GET)
	@ResponseBody
	public List<Object[]> getParentByAjax(@PathVariable Integer flag){
		List<Object[]> parentsByAjax = categoryService.findParentByAjax();
		if(flag!=0){
			parentsByAjax.add(0, new Object[]{0,"根节点"});
		}
		return parentsByAjax;
	}
	
	@RequestMapping(value="/{categoryId}/update",method=RequestMethod.GET)
	public String update(@PathVariable Integer categoryId,Model model) {
		if (categoryId != null) {
			model.addAttribute("model",categoryService.loadCategoryById(categoryId));
			model.addAttribute("parents", this.getParentByAjax(1));
		}
		return "admin/goods/category/update";
	}
	
	@RequestMapping(value="/{categoryId}/update",method=RequestMethod.POST)
	public String update(HttpServletRequest request,@PathVariable Integer categoryId,Category category) {
		StringBuilder content = new StringBuilder();
		if(categoryId!=null){
			Category temp = categoryService.loadCategoryById(categoryId);
			String parentIds = (String)request.getParameter("parents");
			if(parentIds!=null){
				category.setParent(categoryService.loadCategoryById(Integer.parseInt(parentIds)));
			}
			if(!temp.getEnName().equals(category.getEnName())){
				content.append("名称由\""+temp.getEnName()+"\"修改为\""+category.getEnName()+"\"");
			}else{
				content.append("名称："+temp.getEnName());
			}
			if(temp.getParent()!=null&&!temp.getParent().equals(category.getParent())){
				content.append("一级分类由\""+temp.getParent().getEnName()+"\"修改为\""+category.getParent().getEnName()+"\"");
			}else if(temp.getParent()==null&&parentIds!=null){
				content.append("一级分类由\"无\"修改为\""+category.getParent().getEnName()+"\"");
			}else{
				if(temp.getParent()!=null){
					content.append("一级分类："+temp.getParent().getEnName());
				}
			}
			category.setCreateDate(temp.getCreateDate());
			category.setCreateUser(temp.getCreateUser());
			categoryService.saveCategory(category);
			MsgUtil.setMsgUpdate("success");
			LogUtil.getInstance().log(LogType.EDIT,content.toString());
		}
		return "redirect:/admin/goods/category/categorys/1";
	}
	
	@RequestMapping(value="/existCategory",method=RequestMethod.POST)
	public String existUser(HttpServletRequest request,HttpServletResponse response){
		PrintWriter out = null;
		try {
			String enName = request.getParameter("enName");
			String name = request.getParameter("en");		//name为空表示添加，否则为编辑
			if(enName!=null){
				response.setContentType("text/html;charset=UTF-8");
				out = response.getWriter();
				//如果没有修改username
				if(enName.equals(name)){
					out.print(true);	//true表示可用
				}else{
					Category ca = categoryService.loadCategoryByName(enName);
					if(ca!=null){
						out.print(false);
					}else{
						out.print(true);	//true表示可用，用户名不存在
					}
				}
				out.flush();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			if(out!=null){
				out.close();
			}
		}
		return null;
	}
	
	@RequestMapping(value="/{categoryId}/del",method=RequestMethod.GET)
	public String del(@PathVariable Integer categoryId){
		if(categoryId!=null){
			Category temp = categoryService.loadCategoryById(categoryId);
			if(categoryService.checkHasChildren(temp)){
				MsgUtil.setMsg("error", "请先删除该分类下的子分类");
			}else{
				categoryService.delCategory(categoryId);
				MsgUtil.setMsg("success", "删除分类成功！");
				//日志记录
				LogUtil.getInstance().log(LogType.DEL, temp.getEnName()+"删除了");
			}
		}
		return "redirect:/admin/goods/category/categorys/1";
	}

	public PageRainier<Category> getCategorys() {
		return categorys;
	}

	public void setCategorys(PageRainier<Category> categorys) {
		this.categorys = categorys;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}
}
