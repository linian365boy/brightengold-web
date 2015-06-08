package com.brightengold.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import cn.rainier.nian.utils.PageRainier;

import com.brightengold.model.Column;
import com.brightengold.service.ColumnService;
import com.google.gson.Gson;

@Controller
@RequestMapping("/admin/sys/col")
@Scope("prototype")
public class ColumnController {
	@Autowired
	private ColumnService columnService;
	private PageRainier<Column> columns;
	private Integer pageSize = 10;
	private Logger logger = LoggerFactory.getLogger(ColumnController.class);
	
	@RequestMapping(value={"/cols/{pageNo}"})
	public String list(@PathVariable Integer pageNo,Model model,HttpServletRequest request){
		columns = columnService.findAll(pageNo, pageSize);
		model.addAttribute("page",columns);//map
		return "admin/sys/col/list";
	}
	
	@RequestMapping(value="/getParentByAjax/{flag}",method=RequestMethod.GET)
	@ResponseBody
	public String getParentByAjax(@PathVariable Integer flag){
		Gson gson = new Gson();
		List<Object[]> parentsByAjax = columnService.findParentByAjax();
		if(flag!=0){
			parentsByAjax.add(0, new Object[]{0,"根节点"});
		}
		return gson.toJson(parentsByAjax);
	}
	
	
	@RequestMapping(value={"/add"},method=RequestMethod.POST)
	public String add(Model model,Column column){
		column.setCreateDate(new Date());
		Column temp = columnService.save(column);
		if(temp!=null){
			
		}else{
			
		}
		return InternalResourceViewResolver.REDIRECT_URL_PREFIX+"admin/sys/col/cols/1.html";
	}
	
	@RequestMapping(value={"/add"},method=RequestMethod.GET)
	public String addUI(Model model){
		return "admin_unless/sys/col/add";
	}
	
	@RequestMapping(value={"/{id}/update"},method=RequestMethod.POST)
	public String update(@PathVariable Integer id,Model model,Column column){
		Column temp = columnService.getById(id);
		column.setCreateDate(temp.getCreateDate());
		column = columnService.save(column);
		return InternalResourceViewResolver.REDIRECT_URL_PREFIX+"admin/sys/col/cols/1.html";
	}
	
	@RequestMapping(value={"/{id}/update"},method=RequestMethod.GET)
	public String updateUI(Model model){
		return "admin_unless/sys/col/update";
	}
	
	@RequestMapping(value={"/{id}/delete"},method=RequestMethod.POST)
	@ResponseBody
	public String delete(@PathVariable Integer id,Model model){
		Column temp = columnService.getById(id);
		if(temp.getChildColumn()!=null && temp.getChildColumn().size()>0){
			//还有子节点，不能删除
		}else{
			columnService.delete(id);
		}
		return null;
	}
	
}
