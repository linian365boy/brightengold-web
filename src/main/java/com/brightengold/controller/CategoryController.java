package com.brightengold.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
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

import com.brightengold.model.Category;
import com.brightengold.model.Column;
import com.brightengold.service.CategoryService;
import com.brightengold.service.ColumnService;
import com.brightengold.service.LogUtil;
import com.brightengold.service.MsgUtil;
import com.brightengold.service.ProductService;
import com.brightengold.util.LogType;
import com.brightengold.vo.RequestParam;
import com.brightengold.vo.ReturnData;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import cn.rainier.nian.model.User;
import cn.rainier.nian.utils.PageRainier;

@Controller
@RequestMapping("/admin/goods/category")
@Scope("prototype")
public class CategoryController {
	@Autowired
	private CategoryService categoryService;
	private PageRainier<Category> categorys;
	@Autowired
	private ColumnService columnService;
	@Autowired
	private ProductService productService;
	private Integer pageSize = 10;
	private static Logger logger = LoggerFactory.getLogger(CategoryController.class);
	
	/**
	 * list:如果需要定位用户进入到哪个栏目菜单，需要传入HttpServletRequest、ModelMap两个参数，顺序不定
	 * @author tanfan 
	 * @param request
	 * @param map
	 * @param pageNo
	 * @return 
	 * @since JDK 1.7
	 */
	@RequestMapping("/categorys/list")
	public String list(HttpServletRequest request, ModelMap map){
		map.put("ajaxListUrl", "admin/goods/category/categorys/getJsonList.html");
		return "admin/goods/category/list";
	}
	
	@ResponseBody
	@RequestMapping("/categorys/getJsonList")
	public String getJsonList(RequestParam param){
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		categorys = categoryService.findAll(param);
		ReturnData<Category> datas = new ReturnData<Category>(categorys.getTotalRowNum(), categorys.getResult());
		return gson.toJson(datas);
	}
	
	@RequestMapping(value="/add",method=RequestMethod.GET)
	public String add(ModelMap map) {
		//获取一级栏目
		List<Column> parentCol = columnService.findParentByAjax();
		map.put("parentCol", parentCol);
		return "admin_unless/goods/category/add";
	}
	
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public String add(Category category, HttpServletRequest request) {
		User u = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		try {
			String secondColStr = request.getParameter("secondCol");
			if(StringUtils.isNotBlank(secondColStr) 
					&& !("0".equals(secondColStr))){
				//有二级栏目
				category.setColumnId(Integer.parseInt(secondColStr));
			}else{
				//只选择一级栏目
				category.setColumnId(Integer.parseInt(request.getParameter("parentCol")));
			}
			if(Integer.parseInt(request.getParameter("parentC"))==0){
				category.setParentId(null);
			}else{
				category.setParentId(Integer.parseInt(request.getParameter("parentC")));
			}
			category.setCreateDate(new Date());
			category.setCreateUserId(u.getId());
			categoryService.saveCategory(category);
			MsgUtil.setMsgAdd("success");
			LogUtil.getInstance().log(LogType.ADD,"名称："+category.getEnName());
			logger.info("添加产品分类{}成功！",
					ToStringBuilder.reflectionToString(category, ToStringStyle.SHORT_PREFIX_STYLE));
		} catch (Exception e) {
			MsgUtil.setMsgAdd("error");
			logger.error("添加产品分类失败！",e);
		}
		return "redirect:/admin/goods/category/categorys/1.html";
	}
	
	@RequestMapping(value="/getParentByAjax/{flag}",method=RequestMethod.GET)
	@ResponseBody
	public String getParentByAjax(@PathVariable Integer flag){
		Gson gson = new Gson();
		List<Category> parentsByAjax = categoryService.findParentByAjax();
		if(flag!=0){
			parentsByAjax.add(0, new Category(0,"根节点",null));
		}
		return gson.toJson(parentsByAjax);
	}
	
	@RequestMapping(value="/{categoryId}/update",method=RequestMethod.GET)
	public String update(@PathVariable Integer categoryId,Model model) {
		if (categoryId != null) {
			Category category = categoryService.loadCategoryById(categoryId);
			model.addAttribute("model",category);
			List<Category> parentsByAjax = categoryService.findParentByAjax();
			parentsByAjax.add(0, new Category(0,"根节点",null));
			//获取一级栏目
			List<Column> parentCol = columnService.findParentByAjax();
			model.addAttribute("parentCol", parentCol);
			model.addAttribute("parents", parentsByAjax);
		}
		return "admin_unless/goods/category/update";
	}
	
	@RequestMapping(value="/{categoryId}/update",method=RequestMethod.POST)
	public String update(HttpServletRequest request,@PathVariable Integer categoryId,Category category) {
		StringBuilder content = new StringBuilder();
		try {
			if(categoryId!=null){
				Category temp = categoryService.loadCategoryById(categoryId);
				String parentIds = (String)request.getParameter("parents");
				String secondColStr = request.getParameter("secondCol");
				if(StringUtils.isNotBlank(secondColStr) 
						&& !("0".equals(secondColStr))){
					//有二级栏目
					category.setColumnId(Integer.parseInt(secondColStr));
				}else{
					//只选择一级栏目
					category.setColumnId(Integer.parseInt(request.getParameter("parentCol")));
				}
				if(parentIds!=null){
					category.setParentId(Integer.parseInt(parentIds));
				}
				if(!temp.getEnName().equals(category.getEnName())){
					content.append("名称由\""+temp.getEnName()+"\"修改为\""+category.getEnName()+"\"");
				}else{
					content.append("名称："+temp.getEnName());
				}
				/*if(temp.getParentId()!=null&&!temp.getParentId().equals(category.getParentId())){
					content.append("一级分类由\""+temp.getParentId().getEnName()+"\"修改为\""+category.getParentId().getEnName()+"\"");
				}else if(temp.getParent()==null&&parentIds!=null){
					//content.append("一级分类由\"无\"修改为\""+category.getParent().getEnName()+"\"");
				}else{
					if(temp.getParent()!=null){
						content.append("一级分类："+temp.getParent().getEnName());
					}
				}*/
				category.setCreateDate(temp.getCreateDate());
				category.setCreateUserId(temp.getCreateUserId());
				categoryService.saveCategory(category);
				MsgUtil.setMsgUpdate("success");
				LogUtil.getInstance().log(LogType.EDIT,content.toString());
				logger.info("修改商品分类{}成功！",
						ToStringBuilder.reflectionToString(category, ToStringStyle.SHORT_PREFIX_STYLE));
			}
		}catch(Exception e){
			logger.error("修改商品分类失败！",e);
		}
		return "redirect:/admin/goods/category/categorys/1.html";
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
			logger.error("查询是否存在相同分类发生错误",e);
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
			if(categoryService.checkHasChildren(categoryId)){
				MsgUtil.setMsg("error", "请先删除该分类下的子分类");
			}else{
				//判断分类下是否有产品
				long count = productService.countByCateId(categoryId);
				if(count>0){
					MsgUtil.setMsg("error", "请先删除该分类下的"+count+"个产品！");
				}else{
					logger.info("删除分类|{}",ToStringBuilder.reflectionToString(temp, ToStringStyle.SHORT_PREFIX_STYLE));
					categoryService.delCategory(categoryId);
					MsgUtil.setMsg("success", "删除分类成功！");
					//日志记录
					LogUtil.getInstance().log(LogType.DEL, temp.getEnName()+"删除了");
				}
			}
		}
		return "redirect:/admin/goods/category/categorys/1.html";
	}

	@RequestMapping(value="/getChildrenCate/{parentCateId}",method=RequestMethod.POST)
	@ResponseBody
	public String getChildrenCate(@PathVariable Integer parentCateId){
		Gson gson = new Gson();
		List<Object[]> childrenCateArr = categoryService.findChildrenByParentCateId(parentCateId);
		if(!CollectionUtils.isEmpty(childrenCateArr)){
			return gson.toJson(childrenCateArr);
		}
		return gson.toJson(null);
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
