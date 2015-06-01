package com.brightengold.controller;

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

import cn.rainier.nian.utils.PageRainier;

import com.brightengold.model.Feedback;
import com.brightengold.service.FeedbackService;
import com.brightengold.service.LogUtil;
import com.brightengold.service.MsgUtil;
import com.brightengold.util.LogType;

@Controller
@RequestMapping("/admin/feedback")
@Scope("prototype")
public class FeedbackController {
	@Autowired
	private FeedbackService feedbackService;
	private PageRainier<Feedback> feedbacks;
	private Integer pageSize = 10;
	private Logger logger = LoggerFactory.getLogger(FeedbackController.class);
	
	@RequestMapping({"/feedbacks/{pageNo}"})
	public String list(@PathVariable Integer pageNo,Model model,HttpServletRequest request){
		if(pageNo==null){
			pageNo = 1;
		}
		feedbacks = feedbackService.findAll(pageNo, pageSize);
		model.addAttribute("page",feedbacks);//map
		return "admin/feedback/list";
	}
	
	@RequestMapping(value="/{id}",method=RequestMethod.GET)
	public String detail(@PathVariable Integer id,Model model){
		if(id!=null){
			model.addAttribute("model",feedbackService.loadOne(id));
		}
		return "admin/feedback/detail";
	}
	
	@RequestMapping(value="/{id}/del",method=RequestMethod.GET)
	public String delete(@PathVariable Integer id,Feedback feedback){
		if (id != null) {
			feedbackService.delete(id);
			MsgUtil.setMsgDelete("success");
			LogUtil.getInstance().log(LogType.DEL, "联系方式为"+feedback.getTelePhone());
		}
		return "redirect:/admin/feedback/feedbacks/1";
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
