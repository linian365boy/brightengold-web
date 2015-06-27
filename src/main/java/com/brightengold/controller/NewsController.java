package com.brightengold.controller;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
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

import cn.rainier.nian.model.User;
import cn.rainier.nian.utils.PageRainier;

import com.brightengold.model.JsonEntity;
import com.brightengold.model.News;
import com.brightengold.service.LogUtil;
import com.brightengold.service.MsgUtil;
import com.brightengold.service.NewsService;
import com.brightengold.util.HTMLGenerator;
import com.brightengold.util.LogType;
import com.brightengold.util.Tools;

@Controller
@RequestMapping("/admin/news")
@Scope("prototype")
public class NewsController {
	private Logger logger = LoggerFactory.getLogger(NewsController.class);
	
	@Autowired
	private NewsService newsService;
	private PageRainier<News> news;
	private Integer pageSize = 10;
	
	@RequestMapping({"/news/{pageNo}"})
	public String list(@PathVariable Integer pageNo,Model model,HttpServletRequest request){
		news = newsService.findAll(pageNo, pageSize);
		model.addAttribute("page",news);//map
		return "admin/news/list";
	}
	
	@RequestMapping(value="/add",method=RequestMethod.GET)
	public String add(){
		return "admin/news/add";
	}
	
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public String add(News news){
		if(news.getPriority()==null){
			news.setPriority(0);
		}
		news.setClicks(0);
		news.setCreateDate(new Date());
		news.setUrl("views/html/news/"+Tools.getRndFilename()+".html");
		newsService.saveNews(news);
		MsgUtil.setMsgAdd("success");
		LogUtil.getInstance().log(LogType.ADD,"标题："+news.getTitle());
		logger.info("添加了新闻：{}",ToStringBuilder.reflectionToString(news, ToStringStyle.SHORT_PREFIX_STYLE));
		return "redirect:/admin/news/news/1.html";
	}
	
	@RequestMapping(value="/{newsId}/update",method=RequestMethod.GET)
	public String update(@PathVariable Integer newsId,Model model){
		if(newsId!=null){
			model.addAttribute("news", newsService.loadNews(newsId));
		}
		return "admin/news/update";
	}
	
	@RequestMapping(value="/{newsId}/update",method=RequestMethod.POST)
	public String update(@PathVariable Integer newsId,News news){
		if(newsId!=null){
			StringBuilder content = new StringBuilder();
			News temp = newsService.loadNews(newsId);
			news.setCreateDate(temp.getCreateDate());
			news.setClicks(temp.getClicks());
			news.setUrl(temp.getUrl());
			newsService.saveNews(news);
			if(!temp.getTitle().equals(news.getTitle())){
				content.append("标题由\""+temp.getTitle()+"\"修改为\""+news.getTitle()+"\"");
			}
			if(!temp.getPriority().equals(news.getPriority())){
				content.append("优先值由\""+temp.getPriority()+"\"修改为\""+news.getPriority()+"\"");
			}
			if("".equals(content.toString().trim())){
				content.append("修改了标题为"+news.getTitle()+"新闻");
			}
			MsgUtil.setMsgUpdate("success");
			LogUtil.getInstance().log(LogType.EDIT, content.toString());
		}
		return "redirect:/admin/news/news/1";
	}
	
	@RequestMapping(value="/{newsId}",method=RequestMethod.GET)
	public String view(@PathVariable Integer newsId,Model model){
		if(newsId!=null){
			News tempNews = newsService.loadNews(newsId);
			//点击率
			newsService.updateClicks(tempNews);
			if(tempNews!=null){
				model.addAttribute("news", tempNews);
				return "admin_unless/news/details";
			}
		}
		return "redirect:/admin/news/news/1";
	}
	
	@RequestMapping(value="/{newsId}/del",method=RequestMethod.GET)
	public String del(@PathVariable Integer newsId,HttpServletRequest request,News news){
		if(newsId!=null){
			news = newsService.loadNews(newsId);
			String htmlUrl = news.getUrl();
			if(newsService.delNews(news)){
				if(htmlUrl!=null){
					String path = request.getSession().getServletContext().getRealPath("/"+htmlUrl);
					Tools.delFile(path);
				}
				MsgUtil.setMsgDelete("success");
			}
			LogUtil.getInstance().log(LogType.DEL, "标题："+news.getTitle());
		}
		return "redirect:/admin/news/news/1";
	}
	
	@RequestMapping(value="/{newsId}/checkPub",method=RequestMethod.GET)
	@ResponseBody
	public int checkPub(@PathVariable Integer newsId){
		if(newsId!=null){
			News tempNews = newsService.loadNews(newsId);
			if(tempNews!=null){
				if(tempNews.getPublishDate()!=null){
					return 1;
				}else{
					return -1;
				}
			}else{
				return 0;
			}
		}else{
			return 0;
		}
	}
	
	@RequestMapping(value="/{newsId}/publish",method=RequestMethod.GET)
	@ResponseBody
	public JsonEntity publishNews(@PathVariable Integer newsId,HttpServletRequest request){
			News tempNews = newsService.loadNews(newsId);
			User loginUser = ((User)SecurityContextHolder.getContext().getAuthentication().getPrincipal());
			String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();				
			String url=basePath+"/admin/news/"+tempNews.getId();
			HTMLGenerator htmlGenerator = new HTMLGenerator(basePath);
			JsonEntity entity = new JsonEntity();
			if(htmlGenerator.createHtmlPage(url,request.getSession().getServletContext().getRealPath(tempNews.getUrl()),loginUser.getUsername(),null)){
				tempNews.setPublishDate(new Date());
				LogUtil.getInstance().log(LogType.PUBLISH, "标题："+tempNews.getTitle());
				if(newsService.saveNews(tempNews)!=null){
					entity.setKey("1");
					entity.setValue(Tools.formatDate(tempNews.getPublishDate(), false));
				}else{
					entity.setKey("-1");
				}
			}else{
				tempNews.setPublishDate(null);
				entity.setKey("-1");
			}
			newsService.saveNews(tempNews);
			return entity;
	}
	
	public PageRainier<News> getNews() {
		return news;
	}
	public void setNews(PageRainier<News> news) {
		this.news = news;
	}
	public Integer getPageSize() {
		return pageSize;
	}
	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}
	
}
