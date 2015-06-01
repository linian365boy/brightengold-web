package com.brightengold.controller;

import java.util.Date;

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
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import cn.rainier.nian.utils.PageRainier;

import com.brightengold.model.Column;
import com.brightengold.service.ColumnService;

@Controller
@RequestMapping("/admin")
@Scope("prototype")
public class ColumnController {
	@Autowired
	private ColumnService columnService;
	private PageRainier<Column> columns;
	private Integer pageSize = 10;
	private Logger logger = LoggerFactory.getLogger(ColumnController.class);
	
	@RequestMapping(value={"/column/list/{pageNo}"})
	public String list(@PathVariable Integer pageNo,Model model,HttpServletRequest request){
		columns = columnService.findAll(pageNo, pageSize);
		model.addAttribute("page",columns);//map
		return "admin/column/list";
	}
	
	
	@RequestMapping(value={"/column/add"},method=RequestMethod.POST)
	public String add(Model model,Column column){
		column.setCreateDate(new Date());
		Column temp = columnService.save(column);
		if(temp!=null){
			
		}else{
			
		}
		return InternalResourceViewResolver.REDIRECT_URL_PREFIX+"admin/column/list/1.html";
	}
	
	@RequestMapping(value={"/column/add"},method=RequestMethod.GET)
	public String addUI(Model model){
		return "admin/column/add";
	}
	
	@RequestMapping(value={"/column/{id}/update"},method=RequestMethod.POST)
	public String update(@PathVariable Integer id,Model model,Column column){
		Column temp = columnService.getById(id);
		column.setCreateDate(temp.getCreateDate());
		column = columnService.save(column);
		return InternalResourceViewResolver.REDIRECT_URL_PREFIX+"admin/column/list/1.html";
	}
	
	@RequestMapping(value={"/column/{id}/update"},method=RequestMethod.GET)
	public String updateUI(Model model){
		return "admin/column/update";
	}
	
	@RequestMapping(value={"/column/{id}/delete"},method=RequestMethod.POST)
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
