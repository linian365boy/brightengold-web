package com.brightengold.controller;

import java.util.Date;
import java.util.List;

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

import cn.rainier.nian.utils.PageRainier;

import com.brightengold.model.Column;
import com.brightengold.service.ColumnService;
import com.brightengold.service.MsgUtil;
import com.brightengold.vo.ResultVo;
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
	public String list(@PathVariable Integer pageNo,Model model,String keyword){
		columns = columnService.findAll(pageNo, pageSize,keyword);
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
		if(null==column.getPriority()){
			column.setPriority(0);
		}
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
		Column temp = null;
		try {
			temp = columnService.getById(id);
			if(column.getParentColumn().getId()!=0){
				column.setParentColumn(columnService.getById(column.getParentColumn().getId()));
			}else{
				column.setParentColumn(null);
			}
			column.setCreateDate(temp.getCreateDate());
			if(!(temp.getCode().equals(column.getCode()))){
				column.setUrl("/col/"+column.getCode());
			}
			column = columnService.save(column);
			MsgUtil.setMsgUpdate("success");
			logger.info("修改栏目成功，原栏目信息：{}，修改后栏目信息：{}！",
					ToStringBuilder.reflectionToString(temp, ToStringStyle.SHORT_PREFIX_STYLE),
					ToStringBuilder.reflectionToString(column, ToStringStyle.SHORT_PREFIX_STYLE));
		} catch (Exception e) {
			MsgUtil.setMsgUpdate("success");
			logger.info("修改栏目失败，原栏目信息：{}，修改后栏目信息：{}！！",
					ToStringBuilder.reflectionToString(temp, ToStringStyle.SHORT_PREFIX_STYLE),
					ToStringBuilder.reflectionToString(column, ToStringStyle.SHORT_PREFIX_STYLE));
		}
		return "redirect:/admin/sys/col/cols/1.html";
	}
	
	@RequestMapping(value={"/{id}/update"},method=RequestMethod.GET)
	public String updateUI(@PathVariable Integer id, ModelMap model){
		Column temp = columnService.getById(id);
		model.put("model", temp);
		return "admin_unless/sys/col/update";
	}
	
	@RequestMapping(value={"/{id}/delete"})
	@ResponseBody
	public String delete(@PathVariable Integer id,Model model){
		Column temp = columnService.getById(id);
		Gson gson = new Gson();
		ResultVo vo = new ResultVo();
		if(temp.getChildColumn()!=null && temp.getChildColumn().size()>0){
			//还有子节点，不能删除
			//MsgUtil.setMsg("error","删除失败，该节点包含有"+temp.getChildColumn().size()+"个子节点，请先删除该节点下的子节点！");
			vo.setCode(500);
			vo.setMessage("删除失败，该节点包含有"+temp.getChildColumn().size()+"个子节点，请先删除该节点下的子节点！");
			logger.error("删除栏目信息：{}失败，该节点包含有{}个子节点",temp,temp.getChildColumn().size());
		}else{
			columnService.delete(id);
			vo.setCode(200);
			vo.setMessage("删除成功！");
			logger.warn("删除栏目信息：{}成功",temp);
		}
		return gson.toJson(vo);
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
