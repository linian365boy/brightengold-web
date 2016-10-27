package com.brightengold.controller;

import javax.servlet.http.HttpServletRequest;

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

import com.brightengold.common.vo.RequestParam;
import com.brightengold.model.Feedback;
import com.brightengold.service.FeedbackService;
import com.brightengold.service.LogUtil;
import com.brightengold.service.MsgUtil;
import com.brightengold.util.LogType;
import com.brightengold.vo.ReturnData;

import cn.rainier.nian.utils.PageRainier;

@Controller
@RequestMapping("/admin/feedback")
@Scope("prototype")
public class FeedbackController {
	@Autowired
	private FeedbackService feedbackService;
	private PageRainier<Feedback> feedbacks;
	private Integer pageSize = 10;
	private static Logger logger = LoggerFactory.getLogger(FeedbackController.class);
	
	@RequestMapping({"/feedbacks/list"})
	public String list(ModelMap map,HttpServletRequest request){
		map.put("ajaxListUrl", "admin/feedback/feedbacks/getJsonList.html");
		return "admin/feedback/list";
	}
	
	@ResponseBody
	@RequestMapping({"/feedbacks/getJsonList"})
	public ReturnData<Feedback> getJsonList(RequestParam param){
		feedbacks = feedbackService.findAll(param);
		ReturnData<Feedback> datas = new ReturnData<Feedback>(feedbacks.getTotalRowNum(), feedbacks.getResult());
		return datas;
	}
	
	@RequestMapping(value="/{id}",method=RequestMethod.GET)
	public String detail(@PathVariable Integer id,Model model){
		if(id!=null){
			model.addAttribute("model",feedbackService.loadOne(id));
		}
		return "admin_unless/feedback/detail";
	}
	
	@RequestMapping(value="/{id}/del",method=RequestMethod.GET)
	public String delete(@PathVariable Integer id,Feedback feedback){
		if (id != null) {
			try{
				feedbackService.delete(id);
				logger.warn("删除id|{}的评论",id);
				MsgUtil.setMsgDelete("success");
				LogUtil.getInstance().log(LogType.DEL, "联系方式为"+feedback.getTelePhone());
			}catch(Exception e){
				logger.error("删除评论报错!",e);
			}
		}
		return "redirect:/admin/feedback/feedbacks/1.html";
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public PageRainier<Feedback> getFeedbacks() {
		return feedbacks;
	}

	public void setFeedbacks(PageRainier<Feedback> feedbacks) {
		this.feedbacks = feedbacks;
	}
	
}
