package com.brightengold.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
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

import cn.rainier.nian.utils.PageRainier;

import com.brightengold.model.Column;
import com.brightengold.service.ColumnService;
import com.brightengold.service.MsgUtil;
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
		column.setParentColumn(columnService.getById(column.getParentColumn().getId()));
		column.setUrl("/col/"+column.getCode());
		Column temp = columnService.save(column);
		if(temp!=null){
			MsgUtil.setMsgAdd("success");
			logger.info("新增栏目:{}成功！",
					ToStringBuilder.reflectionToString(column, ToStringStyle.SHORT_PREFIX_STYLE));
		}else{
			MsgUtil.setMsgAdd("error");
			logger.error("新增栏目:{}失败！",
					ToStringBuilder.reflectionToString(column, ToStringStyle.SHORT_PREFIX_STYLE));
		}
		return "redirect:/admin/sys/col/cols/1.html";
	}
	
	@RequestMapping(value={"/add"},method=RequestMethod.GET)
	public String addUI(Model model){
		return "admin_unless/sys/col/add";
	}
	
	@RequestMapping(value={"/{id}/update"},method=RequestMethod.POST)
	public String update(@PathVariable Integer id,Model model,Column column){
		Column temp = columnService.getById(id);
		column.setParentColumn(columnService.getById(column.getParentColumn().getId()));
		column.setCreateDate(temp.getCreateDate());
		column = columnService.save(column);
		return "redirect:/admin/sys/col/cols/1.html";
	}
	
	@RequestMapping(value={"/{id}/update"},method=RequestMethod.GET)
	public String updateUI(@PathVariable Integer id, ModelMap model){
		Column temp = columnService.getById(id);
		model.put("model", temp);
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
	
	@RequestMapping(value="/existCol",method=RequestMethod.POST)
	@ResponseBody
	public String existUser(String code,String ycode){
		if(code!=null){
			//如果没有修改code
			if(code.equals(ycode)){
				return Boolean.toString(true);	//true表示可用
			}else{
				Long count = columnService.countColumnByCode(code);
				if(count>0){
					return Boolean.toString(false);
				}else{
					return Boolean.toString(true);	//true表示可用，用户名不存在
				}
			}
		}
		return Boolean.toString(false);
	}
	
}
