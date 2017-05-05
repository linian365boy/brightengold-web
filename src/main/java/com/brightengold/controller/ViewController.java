package com.brightengold.controller;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.brightengold.common.vo.RequestParam;
import com.brightengold.model.Advertisement;
import com.brightengold.model.Category;
import com.brightengold.model.Column;
import com.brightengold.model.Company;
import com.brightengold.model.Feedback;
import com.brightengold.model.Info;
import com.brightengold.model.News;
import com.brightengold.model.Product;
import com.brightengold.model.WebConfig;
import com.brightengold.service.AdvertisementService;
import com.brightengold.service.CategoryService;
import com.brightengold.service.ColumnService;
import com.brightengold.service.CompanyService;
import com.brightengold.service.FeedbackService;
import com.brightengold.service.InfoService;
import com.brightengold.service.MailService;
import com.brightengold.service.NewsService;
import com.brightengold.service.ProductService;
import com.brightengold.service.SystemConfig;
import com.brightengold.service.WebConfigService;
import com.brightengold.util.Constant;
import com.brightengold.util.Tools;
import com.brightengold.vo.MessageVo;
import com.google.code.kaptcha.Producer;
import com.google.common.collect.Maps;

import cn.rainier.nian.utils.PageRainier;

/**
 * @ClassName: ViewController  
 * @Description: 提供给view层的接口，供view层查询信息，不设置权限控制 
 * @date: 2016年7月25日 下午6:35:49 
 * 
 * @author tanfan 
 * @version  
 * @since JDK 1.7
 */
@Controller
@RequestMapping("/views")
public class ViewController {
	private static final Logger logger = LoggerFactory.getLogger(ViewController.class);
	@Autowired
	private ProductService productService;
	@Autowired
	private ColumnService columnService;
	@Autowired
	private AdvertisementService advertisementService;
	@Resource
	private SystemConfig systemConfig;
	@Autowired
	private CompanyService companyService;
	@Resource
	private NewsService newsService;
	@Resource
	private CategoryService categoryService;
	@Resource
	private InfoService infoService;
	@Resource
	private WebConfigService configService;
	@Autowired
	private FeedbackService feedbackService;
	@Autowired
    private Producer captchaProducer = null;
	@Autowired
	private MailService mailService;
	
	@RequestMapping(value="/products/search")
	public String searchProducts(ModelMap map, RequestParam param){
		//生成公共部分内容
		gennerateCommon(map);
		PageRainier<Product> page = productService.findAllReleaseProductByLikeKeyword(param);
		map.put("page", page);
		map.put("keyword", param.getSearch());
		map.put("pageNo", (param.getOffset()%param.getLimit()==0)?param.getOffset()/param.getLimit():
			1+(param.getOffset()/param.getLimit()));
		return "html/search/list";
	}
	
	protected void gennerateCommon(ModelMap map){
		//首页广告
		List<Advertisement> ads= advertisementService.getIndexAds(systemConfig.getIndexAdsSize());
		map.put("indexAds", ads);
		//横条菜单，最深显示到二级菜单
		List<Column> crossCol = columnService.findColumnsByDepth();
		map.put("crossCol", crossCol);
		//首页侧边栏目，最深显示到三级菜单
		//List<Column> verticalCol= columnService.findColumnsByDepth(systemConfig.getVerticalMaxDepth());
		//map.put("verticalCol", verticalCol);
		//首页新闻
		List<News> news = newsService.findIndexPic(systemConfig.getIndexNewsSize());
		map.put("indexNews", news);
		//查询所有第一级分类
		List<Category> categorysList = categoryService.findAllParentCateList();
		if(!CollectionUtils.isEmpty(categorysList)){
			for(Category cate : categorysList){
				long catProductsSize = productService.countByCateId(cate.getId());
				if(catProductsSize!=0){
					long parentCateProductSize = catProductsSize;
					logger.info("cate products size |{}",catProductsSize);
					/*if(!CollectionUtils.isEmpty(cate.getChildren())){
						for(Category childCate : cate.getChildren()){
							catProductsSize = productService.countByCateId(childCate.getId());
							logger.info("childCate products size |{}",catProductsSize);
							if(catProductsSize!=0){
								childCate.setProductsSize(catProductsSize);
								parentCateProductSize+=catProductsSize;
							}
						}
					}*/
					cate.setProductsSize(parentCateProductSize);
				}
			}
		}
		map.put("categorys", categorysList);
 		//企业信息
		Company company = companyService.loadCompany(systemConfig.getCompanyConfigPath());
		map.put("company", company);
		//info信息
		List<Info> infos = infoService.findList();
		map.put("infos", infos);
		//网站关键字
		WebConfig webConfig = configService.loadSystemConfig(systemConfig.getWebConfigPath());
		map.put("webConfig", webConfig);
	}
	
	/**
	 * addFeedback:客户留言反馈 
	 * @author tanfan 
	 * @return 
	 * @since JDK 1.7
	 */
	@RequestMapping("/feedback/add")
	@ResponseBody
	public MessageVo addFeedback(Feedback feedback, String kaptcha, HttpServletRequest request){
		String code = (String)request.getSession().getAttribute(Constant.VERIFY_CODE_KEY);
		logger.info("addFeedback session verfiy code |{}, user input code |{}",code, kaptcha);
		MessageVo vo = new MessageVo();
		Map<String,String> messageMap = Maps.newHashMap();
		try{
			if(kaptcha.equals(code)){
				//全名为空
				if(StringUtils.isBlank(feedback.getName())){
					messageMap.put("name", "Please fill the Full Name.");
				}
				//邮箱为空
				if(StringUtils.isBlank(feedback.getEmail())){
					messageMap.put("email", "Please fill the Email Address.");
				}else{
					//邮箱格式
					if(!Tools.checkEmail(feedback.getEmail())){
						messageMap.put("email", "Email address seems invalid.");
					}
				}
				//留言内容为空
				if(StringUtils.isBlank(feedback.getContent())){
					messageMap.put("content", "Please fill the Message.");
				}
				if(MapUtils.isNotEmpty(messageMap)){
					vo.setCode(Constant.CODE_202);
					vo.setMessage("Please fill the required field or confirm the fields and submit it again.");
					vo.setData(messageMap);
					return vo;
				}
				feedbackService.addFeedback(feedback);
				StringBuffer sb = new StringBuffer();
				sb.append("客户留言内容见下：<br/>");
				sb.append(String.format("Full Name：%s<br/>",feedback.getName()));
				sb.append(String.format("Email Address：%s<br/>",feedback.getEmail()));
				sb.append(String.format("Message：%s<br/>",feedback.getContent()));
				//异步sendEmail
				mailService.sendHtmlEmails(
						String.format("inquiry----%s",feedback.getName()), 
								sb.toString());
				logger.info("客户留言信息|{}",feedback);
				vo.setCode(Constant.SUCCESS_CODE);
				vo.setMessage("succeed send email.");
			}else{
				logger.error("验证码输入错误！");
				vo.setCode(Constant.CODE_201);
				vo.setMessage("kaptcha error.");
			}
		}catch(Exception e){
			logger.error("客户留言出现错误！",e);
			vo.setCode(Constant.ERROR_CODE);
			vo.setMessage("server error.");
		}
		return vo;
	}
	
	@RequestMapping("/getVerifyCode")
	public void verifyCode(HttpServletRequest request,HttpServletResponse response){
		HttpSession session = request.getSession();  
	    response.setDateHeader("Expires", 0);
        // Set standard HTTP/1.1 no-cache headers.  
        response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");  
        // Set IE extended HTTP/1.1 no-cache headers (use addHeader).  
        response.addHeader("Cache-Control", "post-check=0, pre-check=0");  
        // Set standard HTTP/1.0 no-cache header.  
        response.setHeader("Pragma", "no-cache");
        // return a jpeg  
        response.setContentType("image/jpeg");  
        // create the text for the image
        String capText = captchaProducer.createText();  
        // store the text in the session  
        session.setAttribute(Constant.VERIFY_CODE_KEY, capText);
        logger.debug("verify code|{}",capText);
        // create the image with the text  
        BufferedImage bi = null;
        ServletOutputStream out = null;
        try { 
        	bi = captchaProducer.createImage(capText);
        	out = response.getOutputStream();  
            // write the data out
            ImageIO.write(bi, "jpg", out);  
            out.flush();  
        } catch (IOException e) {
        	logger.error("write verify code error",e);
		} finally {  
            try {
				out.close();
			} catch (IOException e) {
				logger.error("out close error",e);
			}  
        }
	}
	
	@RequestMapping("/getLoginVerifyCode")
	public void getLoginVerifyCode(HttpServletRequest request,HttpServletResponse response){
		HttpSession session = request.getSession();  
	    response.setDateHeader("Expires", 0);
        // Set standard HTTP/1.1 no-cache headers.  
        response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");  
        // Set IE extended HTTP/1.1 no-cache headers (use addHeader).  
        response.addHeader("Cache-Control", "post-check=0, pre-check=0");  
        // Set standard HTTP/1.0 no-cache header.  
        response.setHeader("Pragma", "no-cache");
        // return a jpeg  
        response.setContentType("image/jpeg");  
        // create the text for the image
        String capText = captchaProducer.createText();  
        // store the text in the session  
        session.setAttribute(cn.rainier.nian.utils.Constant.LOGIN_VERIFY_CODE_KEY, capText);
        logger.debug("verify code|{}",capText);
        // create the image with the text  
        BufferedImage bi = null;
        ServletOutputStream out = null;
        try { 
        	bi = captchaProducer.createImage(capText);
        	out = response.getOutputStream();  
            // write the data out
            ImageIO.write(bi, "jpg", out);  
            out.flush();  
        } catch (IOException e) {
        	logger.error("write verify code error",e);
		} finally {
            try {
				out.close();
			} catch (IOException e) {
				logger.error("out close error",e);
			}  
        }
	}
	
}
