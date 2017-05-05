package com.brightengold.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
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

import com.brightengold.common.vo.RequestParam;
import com.brightengold.model.Category;
import com.brightengold.model.Column;
import com.brightengold.service.CategoryService;
import com.brightengold.service.ColumnService;
import com.brightengold.service.LogUtil;
import com.brightengold.service.ProductService;
import com.brightengold.util.Constant;
import com.brightengold.util.LogType;
import com.brightengold.vo.MessageVo;
import com.brightengold.vo.ReturnData;

import cn.rainier.nian.model.User;
import cn.rainier.nian.utils.PageRainier;

@Controller
@RequestMapping("/admin/goods/category")
@Scope("prototype")
public class CategoryController {
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private ColumnService columnService;
	@Autowired
	private ProductService productService;
	private final static Logger logger = LoggerFactory.getLogger(CategoryController.class);
	
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
	public ReturnData<Category> getJsonList(RequestParam param){
		PageRainier<Category> categorys = categoryService.findAll(param);
		ReturnData<Category> datas = new ReturnData<Category>(categorys.getTotalRowNum(), categorys.getResult());
		return datas;
	}
	
	@RequestMapping(value="/add",method=RequestMethod.GET)
	public String add(ModelMap map) {
		//获取一级栏目
		List<Column> parentCol = columnService.findParentByAjax();
		map.put("parentCol", parentCol);
		return "admin_unless/goods/category/add";
	}
	
	@ResponseBody
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public MessageVo add(Category category, HttpServletRequest request) {
		User u = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		MessageVo vo = null;
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
			LogUtil.getInstance().log(LogType.ADD,"名称："+category.getEnName());
			logger.info("添加产品分类{}成功！",category);
			vo = new MessageVo(Constant.SUCCESS_CODE, "添加产品分类【"+category.getEnName()+"】成功！");
		} catch (Exception e) {
			logger.error("添加产品分类失败！",e);
			vo = new MessageVo(Constant.ERROR_CODE, "添加产品分类【"+category.getEnName()+"】失败！");
		}
		return vo;
	}
	
	@RequestMapping(value="/getParentByAjax/{flag}",method=RequestMethod.GET)
	@ResponseBody
	public List<Category> getParentByAjax(@PathVariable Integer flag){
		List<Category> parentsByAjax = categoryService.findParentByAjax();
		if(flag!=0){
			parentsByAjax.add(0, new Category(0,"根节点","root note"));
		}
		return parentsByAjax;
	}
	
	@RequestMapping(value="/{categoryId}/update",method=RequestMethod.GET)
	public String update(@PathVariable Integer categoryId,Model model) {
		if (categoryId != null) {
			Category category = categoryService.loadCategoryById(categoryId);
			model.addAttribute("model",category);
			Column column = columnService.getById(category.getColumnId());
			model.addAttribute("column", column);
			if(column.getParentId()!=null){
				model.addAttribute("parentColumn", columnService.getById(column.getParentId()));
			}
			List<Category> parentsByAjax = categoryService.findParentByAjax();
			parentsByAjax.add(0, new Category(0,"根节点","root note"));
			//获取一级栏目
			List<Column> parentCol = columnService.findParentByAjax();
			model.addAttribute("parentCol", parentCol);
			model.addAttribute("parents", parentsByAjax);
		}
		return "admin_unless/goods/category/update";
	}
	
	@ResponseBody
	@RequestMapping(value="/{categoryId}/update",method=RequestMethod.POST)
	public MessageVo update(HttpServletRequest request,@PathVariable Integer categoryId,Category category) {
		StringBuilder content = new StringBuilder();
		MessageVo vo = null;
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
				if(temp.getParentId()!=null&&!temp.getParentId().equals(category.getParentId())){
					content.append("一级分类由\""+temp.getParentName()+"\"修改为\""+category.getParentName()+"\"");
				}else if(temp.getParentId()==null&&parentIds!=null){
					content.append("一级分类由\"无\"修改为\""+category.getParentName()+"\"");
				}else{
					if(temp.getParentId()!=null){
						content.append("一级分类："+temp.getParentName());
					}
				}
				category.setCreateUserId(temp.getCreateUserId());
				categoryService.updateCategory(category);
				LogUtil.getInstance().log(LogType.EDIT,content.toString());
				logger.info("修改商品分类{}成功！",category);
				vo = new MessageVo(Constant.SUCCESS_CODE,"修改商品分类【"+category.getEnName()+"】成功！");
			}
		}catch(Exception e){
			logger.error("修改商品分类失败！",e);
			vo = new MessageVo(Constant.ERROR_CODE,"修改商品分类【"+category.getEnName()+"】失败！");
		}
		return vo;
	}
	
	@ResponseBody
	@RequestMapping(value="/existCategory",method=RequestMethod.POST)
	public boolean existCategory(String enName, String en){
		//en为空表示添加，否则为编辑
		boolean result = false;
		try {
			if(enName!=null){
				//如果没有修改name
				if(enName.equals(en)){
					result = true;	//true表示可用
				}else{
					Category ca = categoryService.loadCategoryByName(enName);
					if(ca==null){
						result = true;	//true表示可用，分类不存在
					}
				}
			}
		} catch (Exception e) {
			logger.error("查询是否存在相同分类发生错误",e);
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/{categoryId}/del",method=RequestMethod.POST)
	public MessageVo del(@PathVariable Integer categoryId){
		MessageVo vo = null;
		if(categoryId!=null){
			Category temp = categoryService.loadCategoryById(categoryId);
			if(categoryService.checkHasChildren(categoryId)){
				vo = new MessageVo(Constant.ERROR_CODE,"请先删除该分类下的子分类");
			}else{
				//判断分类下是否有产品
				long count = productService.countByCateId(categoryId);
				if(count>0){
					vo = new MessageVo(Constant.ERROR_CODE,"请先删除该分类下的"+count+"个产品！");
				}else{
					logger.info("删除分类|{}",temp);
					categoryService.delCategory(categoryId);
					//日志记录
					LogUtil.getInstance().log(LogType.DEL, temp.getEnName()+"删除了");
					vo = new MessageVo(Constant.SUCCESS_CODE,"删除分类【"+temp.getEnName()+"】成功！");
				}
			}
		}
		return vo;
	}

	@RequestMapping(value="/getChildrenCate/{parentCateId}",method=RequestMethod.POST)
	@ResponseBody
	public List<Object[]> getChildrenCate(@PathVariable Integer parentCateId){
		List<Object[]> childrenCateArr = categoryService.findChildrenByParentCateId(parentCateId);
		return childrenCateArr;
	}
}
