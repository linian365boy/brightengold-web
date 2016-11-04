package com.brightengold.controller;

import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.brightengold.common.vo.RequestParam;
import com.brightengold.model.Category;
import com.brightengold.model.Column;
import com.brightengold.service.CategoryService;
import com.brightengold.service.ColumnService;
import com.brightengold.util.Constant;
import com.brightengold.vo.MessageVo;
import com.brightengold.vo.ResultVo;
import com.brightengold.vo.ReturnData;
import cn.rainier.nian.utils.PageRainier;

@Controller
@RequestMapping("/admin/sys/col")
@Scope("prototype")
public class ColumnController {
	@Autowired
	private ColumnService columnService;
	@Autowired
	private CategoryService categoryService;
	private PageRainier<Column> columns;
	private static Logger logger = LoggerFactory.getLogger(ColumnController.class);
	
	@RequestMapping(value={"/cols/list"})
	public String list(HttpServletRequest request,ModelMap map){
		map.put("ajaxListUrl", "admin/sys/col/cols/getJsonList.html");
		return "admin/sys/col/list";
	}
	
	@ResponseBody
	@RequestMapping(value={"/cols/getJsonList"})
	public ReturnData<Column> getJsonList(RequestParam param){
		columns = columnService.findAll(param);
		ReturnData<Column> datas = new ReturnData<Column>(columns.getTotalRowNum(), columns.getResult());
		return datas;
	}
	
	@ResponseBody
	@RequestMapping(value={"/getChildren/{pId}"},method = RequestMethod.POST)
	public List<Column> getChildrenbyParentId(@PathVariable Integer pId){
		List<Column> childByAjax = columnService.findChildrenByParentId(pId);
		return childByAjax;
	}
	
	@RequestMapping(value="/getParentByAjax/{flag}",method=RequestMethod.GET)
	@ResponseBody
	public List<Column> getParentByAjax(@PathVariable Integer flag){
		List<Column> parentsByAjax = columnService.findParentByAjax();
		if(flag!=0){
			parentsByAjax.add(0, new Column(0,"根节点",null));
		}
		return parentsByAjax;
	}
	
	//目前最大只到三级
	@ResponseBody
	@RequestMapping(value={"/add"},method=RequestMethod.POST)
	public MessageVo add(Column column,
			Integer firstColumnId,Integer secondColumnId){
		MessageVo vo = new MessageVo(Constant.SUCCESS_CODE);
		if(firstColumnId==0){
			firstColumnId = null;
		}
		if(null==column.getPriority()){
			column.setPriority(0);
		}
		column.setCreateDate(new Date());
		if(secondColumnId!=null){
			column.setParentId(secondColumnId);
			column.setDepth(3);
		}else{
			if(firstColumnId!=null){
				column.setParentId(firstColumnId);
				column.setDepth(2);
			}else{
				column.setDepth(1);
			}
		}
		column.setUrl("views/html/col/"+column.getCode()+".htm");
		if(columnService.save(column)){
			logger.info("新增栏目:{}成功！",column);
			vo.setMessage("新增栏目【"+column.getEnName()+"】成功！");
		}else{
			logger.error("新增栏目:{}失败！",column);
			vo.setCode(Constant.ERROR_CODE);
			vo.setMessage("新增栏目【"+column.getEnName()+"】失败！");
		}
		return vo;
	}
	
	@RequestMapping(value={"/add"},method=RequestMethod.GET)
	public String addUI(){
		return "admin_unless/sys/col/add";
	}
	
	@ResponseBody
	@RequestMapping(value={"/{id}/update"},method=RequestMethod.POST)
	public MessageVo update(@PathVariable Integer id,Column column){
		Column temp = null;
		MessageVo vo = null;
		try {
			temp = columnService.getById(id);
			if(column.getParentId()!=0){
				column.setParentId(column.getParentId());
			}else{
				column.setParentId(null);
			}
			column.setCreateDate(temp.getCreateDate());
			if(!(column.getCode().equals(temp.getCode()))){
				column.setUrl("views/html/col/"+column.getCode()+".htm");
			}else{
				column.setUrl(temp.getUrl());
			}
			columnService.updateColumn(column);
			logger.info("修改栏目成功，原栏目信息：{}，修改后栏目信息：{}！",temp, column);
			vo = new MessageVo(Constant.SUCCESS_CODE,"修改栏目"+column.getEnName()+"成功");
		} catch (Exception e) {
			logger.error("修改栏目失败，原栏目信息：{}，修改后栏目信息：{}！",temp,column);
			vo = new MessageVo(Constant.ERROR_CODE,"修改栏目"+column.getEnName()+"失败");
		}
		return vo;
	}
	
	@RequestMapping(value={"/{id}/update"},method=RequestMethod.GET)
	public String updateUI(@PathVariable Integer id, ModelMap model){
		Column temp = columnService.getById(id);
		model.put("model", temp);
		return "admin_unless/sys/col/update";
	}
	
	@RequestMapping(value={"/{id}/delete"})
	@ResponseBody
	public ResultVo<String> delete(@PathVariable Integer id){
		Column temp = columnService.getById(id);
		ResultVo<String> vo = new ResultVo<String>();
		if(!(CollectionUtils.isEmpty(temp.getChildColumn()))){
			//还有子节点，不能删除
			vo.setCode(Constant.ERROR_CODE);
			vo.setMessage("删除失败，该节点包含有"+temp.getChildColumn().size()+"个子节点，请先删除该节点下的子节点！");
			logger.error("删除栏目信息：{}失败，该节点包含有{}个子节点",temp,temp.getChildColumn().size());
		}else{
			//判断是否有产品分类
			List<Category> cates = categoryService.findCateByColId(temp.getId());
			if(!(CollectionUtils.isEmpty(cates))){
				vo.setCode(Constant.ERROR_CODE);
				vo.setMessage("删除失败，该栏目包含有未删除的"+cates.size()+"个产品分类！");
				logger.error("删除失败，该栏目包含有未删除的"+cates.size()+"个产品分类！");
				return vo;
			}
			columnService.delete(id);
			vo.setCode(Constant.SUCCESS_CODE);
			vo.setMessage("删除成功！");
			logger.warn("删除栏目信息：{}成功",temp);
		}
		return vo;
	}
	
	@RequestMapping(value="/existCol",method=RequestMethod.POST)
	@ResponseBody
	public boolean existCol(String code,String ycode){
		if(code!=null){
			//如果没有修改code
			if(code.equals(ycode)){
				return true;	//true表示可用
			}else{
				Long count = columnService.countColumnByCode(code);
				if(count>0){
					return false;
				}else{
					return true;	//true表示可用，用户名不存在
				}
			}
		}
		return false;
	}
	
	@RequestMapping(value={"/{id}/setPublishContent"},method = RequestMethod.GET)
	public String setPublishContent(@PathVariable Integer id,ModelMap map){
		Column column = columnService.getById(id);
		map.put("column", column);
		return "admin_unless/sys/col/setContent";
	}
	
	@ResponseBody
	@RequestMapping(value={"/{id}/setPublishContent"},method = RequestMethod.POST)
	public MessageVo doPublishContent(@PathVariable Integer id,Column column){
		MessageVo vo = null;
		try{
			columnService.updateColumnPublishContent(id,column);
			logger.info("修改栏目的发布方式|{}",column);
			vo = new MessageVo(Constant.SUCCESS_CODE,"设置发布模式成功！");
		}catch(Exception e){
			logger.error("设置发布模式发生错误！",e);
			vo = new MessageVo(Constant.ERROR_CODE,"设置发布模式失败！");
		}
		return vo;
	}
}
