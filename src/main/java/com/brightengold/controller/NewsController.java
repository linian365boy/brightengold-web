package com.brightengold.controller;

import java.io.File;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.httpclient.util.DateUtil;
import org.apache.commons.lang3.StringUtils;
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
import com.brightengold.model.Column;
import com.brightengold.model.News;
import com.brightengold.service.ColumnService;
import com.brightengold.service.LogUtil;
import com.brightengold.service.NewsService;
import com.brightengold.service.SystemConfig;
import com.brightengold.util.Constant;
import com.brightengold.util.ConstantVariable;
import com.brightengold.util.FreemarkerUtil;
import com.brightengold.util.LogType;
import com.brightengold.util.Tools;
import com.brightengold.vo.MessageVo;
import com.brightengold.vo.ReturnData;

import cn.rainier.nian.utils.FileUtil;
import cn.rainier.nian.utils.PageRainier;

@Controller
@RequestMapping("/admin/news")
@Scope("prototype")
public class NewsController {
	@Autowired
	private NewsService newsService;
	@Autowired
	private ColumnService columnService;
	@Autowired
	private SystemConfig systemConfig;
	@Autowired
	private LogUtil logUtil;
	private static final Logger logger = LoggerFactory.getLogger(NewsController.class);
	
	@RequestMapping({"/news/list"})
	public String list(HttpServletRequest request,ModelMap map){
		map.put("ajaxListUrl", "admin/news/news/getJsonList");
		return "admin/news/list";
	}
	
	@ResponseBody
	@RequestMapping({"/news/getJsonList"})
	public ReturnData<News> getJsonList(RequestParam param){
		PageRainier<News> news = newsService.findAll(param);
		ReturnData<News> datas = new ReturnData<News>(news.getTotalRowNum(), news.getResult());
		return datas;
	}
	
	@RequestMapping(value="/add",method=RequestMethod.GET)
	public String add(ModelMap map){
		//获取一级栏目
		List<Column> parentCol = columnService.findParentByAjax();
		map.put("parentCol", parentCol);
		return "admin/news/add";
	}
	
	@ResponseBody
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public MessageVo add(News news, Integer firstColId, Integer secondColId, Integer thirdColId){
        logger.info("add news firstColId => {}, secondColId => {}, thirdColId => {}", firstColId, secondColId, thirdColId);
		MessageVo vo = null;
		if(news.getPriority()==null){
			news.setPriority(0);
		}
		news.setClicks(0);
		news.setCreateDate(new Date());
		news.setUrl(Tools.getRndFilename()+".htm");
		if(thirdColId != null && thirdColId !=0 ){
			news.setColumnId(thirdColId);
			news.setDepth(firstColId+"-"+secondColId+"-"+thirdColId);
		}else if(secondColId !=null && secondColId !=0 ){
			news.setColumnId(secondColId);
			news.setDepth(firstColId+"-"+secondColId);
		}else{
			news.setColumnId(firstColId);
			news.setDepth(String.valueOf(firstColId));
		}
		if(newsService.saveNews(news)){
			logUtil.log(LogType.ADD,"标题："+news.getTitle());
			logger.info("add news => {} succeed.",news);
			vo = new MessageVo(Constant.SUCCESS_CODE,"添加新闻"+news.getTitle()+"成功");
		}else{
			vo = new MessageVo(Constant.ERROR_CODE,"添加新闻"+news.getTitle()+"失败");
		}
		logger.info("add news return data => {}", vo);
		return vo;
	}
	
	@RequestMapping(value="/{newsId}/update",method=RequestMethod.GET)
	public String update(@PathVariable Integer newsId,ModelMap map){
		if(newsId!=null){
			News news = newsService.loadNews(newsId);
			Column temp = columnService.getById(news.getColumnId());
			if(temp.getParentId()==null){
				map.addAttribute("childs",columnService.findChildrenByParentId(temp.getId()));
			}else{
				map.addAttribute("childs",columnService.findChildrenByParentId(temp.getParentId()));
			}
			map.put("news", news);
			map.put("column", temp);
		}
		List<Column> parentCol = columnService.findParentByAjax();
		map.put("parentCol", parentCol);
		return "admin/news/update";
	}
	
	@ResponseBody
	@RequestMapping(value="/{newsId}/update",method=RequestMethod.POST)
	public MessageVo update(HttpServletRequest request,
			@PathVariable Integer newsId,News news, Integer firstColId, Integer secondColId){
        logger.info("update news firstColId => {}, secondColId => {}, news => {}", firstColId, secondColId, news);
		MessageVo vo = null;
		if(newsId!=null){
			StringBuilder content = new StringBuilder();
			News temp = newsService.loadNews(newsId);
			news.setCreateDate(temp.getCreateDate());
			news.setClicks(temp.getClicks());
			news.setUrl(temp.getUrl());
			if(secondColId !=null && secondColId !=0 ){
				news.setColumnId(secondColId);
				news.setDepth(firstColId+"-"+secondColId);
			}else{
				news.setColumnId(firstColId);
				news.setDepth(String.valueOf(firstColId));
			}
			if(newsService.updateNews(news)){
				logger.info("update from news => {}, to => {}", temp, news);
				if(!temp.getTitle().equals(news.getTitle())){
					content.append("标题由\""+temp.getTitle()+"\"修改为\""+news.getTitle()+"\"");
				}
				if(!temp.getPriority().equals(news.getPriority())){
					content.append("优先值由\""+temp.getPriority()+"\"修改为\""+news.getPriority()+"\"");
				}
				if("".equals(content.toString().trim())){
					content.append("修改了标题为"+news.getTitle()+"新闻");
				}
				logUtil.log(LogType.EDIT, content.toString());
				//删除页面
				String path = request.getSession().getServletContext().getRealPath("/");
				Tools.delFile(path + Constant.NEWSPATH + File.separator+news.getUrl());
				Tools.delFile(path + Constant.NEWSPRE + File.separator+news.getId()+".htm");
				vo = new MessageVo(Constant.SUCCESS_CODE,"修改新闻【"+news.getTitle()+"】成功");
			}else{
				vo = new MessageVo(Constant.ERROR_CODE,"修改新闻【"+news.getTitle()+"】失败");
			}
		}
        logger.info("update news return data => {}", vo);
		return vo;
	}
	
	@RequestMapping(value="/{newsId}",method=RequestMethod.GET)
	public String view(@PathVariable Integer newsId,Model model){
		if(newsId!=null){
			News tempNews = newsService.loadNews(newsId);
			//点击率
			newsService.updateClicks(tempNews);
			if(tempNews!=null){
				model.addAttribute("news", tempNews);
			}
		}
		return "admin_unless/news/details";
	}
	
	@ResponseBody
	@RequestMapping(value="/{newsId}/del",method=RequestMethod.GET)
	public MessageVo del(@PathVariable Integer newsId,HttpServletRequest request,News news){
	    logger.info("delete news param => {}", news);
		MessageVo vo = null;
		if(newsId!=null){
			news = newsService.loadNews(newsId);
			String htmlUrl = news.getUrl();
			if(newsService.delNews(newsId)){
				if(htmlUrl!=null){
					String path = request.getSession().getServletContext().getRealPath("/"+htmlUrl);
					Tools.delFile(path);
				}
				logger.warn("删除了新闻|{}",news);
				vo = new MessageVo(Constant.SUCCESS_CODE,"删除新闻【"+news.getTitle()+"】成功！");
			}else{
				vo = new MessageVo(Constant.ERROR_CODE,"删除新闻【"+news.getTitle()+"】失败！");
			}
			logUtil.log(LogType.DEL, "标题："+news.getTitle());
		}
        logger.info("delete news return data => {}", vo);
		return vo;
	}
	
	@RequestMapping(value="/{newsId}/checkPub",method=RequestMethod.GET)
	@ResponseBody
	public String checkPub(@PathVariable Integer newsId){
		if(newsId!=null){
			News tempNews = newsService.loadNews(newsId);
			if(tempNews!=null){
				if(tempNews.getPublishDate()!=null){
					return "1";
				}else{
					return "-1";
				}
			}else{
				return "0";
			}
		}else{
			return "0";
		}
	}
	
	@RequestMapping(value="/{newsId}/release",method=RequestMethod.GET)
	@ResponseBody
	public MessageVo releaseNews(@PathVariable Integer newsId,HttpServletRequest request, ModelMap map){
	    logger.info("release news newsId => {}", newsId);
		MessageVo vo = new MessageVo();
		String fPath = null;
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+
				request.getServerPort()+request.getContextPath();
		String realPath = systemConfig.getHtmlPath();
		News tempNews = newsService.loadNews(newsId);
		tempNews.setPublishDate(new Date());
		if(StringUtils.isBlank(tempNews.getUrl())){
			tempNews.setUrl(Tools.getRndFilename()+".htm");
		}
		logUtil.log(LogType.PUBLISH, "标题："+tempNews.getTitle());
		if(tempNews.getPublishDate()!=null){
			 fPath = realPath +Constant.NEWSPATH+File.separator+tempNews.getUrl();
			 FileUtil.delFile(fPath);
		}
		map.put("ctx", basePath);
		map.put("model", tempNews);
		//生成唯一的新闻页面路径，不需要根据页码生成页面
		if(FreemarkerUtil.fprint("newsDetail.ftl", map, realPath+Constant.NEWSPATH, tempNews.getUrl())){
			if(newsService.saveNews(tempNews)){
				vo.setCode(Constant.SUCCESS_CODE);
				vo.setData(DateUtil.formatDate(new Date(), ConstantVariable.DFSTR));
				logger.info("release news => {} succeed.",tempNews);
			}else{
				vo.setCode(Constant.ERROR_CODE);
				vo.setMessage("发布新闻失败！");
				logger.error("release news => {} fail.",tempNews);
			}
		}else{
			vo.setCode(Constant.ERROR_CODE);
			vo.setMessage("发布新闻失败！");
			logger.error("release news => {} freemarker fail.",tempNews);
		}
        logger.info("release news return data => {}", vo);
		return vo;
	}
}
