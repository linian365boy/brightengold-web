<%@page import="cn.rainier.nian.service.impl.MenuServiceImpl"%>
<%@page import="cn.rainier.nian.model.Menu"%>
<%@page import="org.springframework.web.context.ContextLoader"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../../commons/include.jsp" %>
     <html>
    <head>
    <meta charset="utf-8"/>
	<title>header</title>
	<script type="text/javascript" src="${ctx }resources/js/jquery.equalHeight.js"></script>
	<script type="text/javascript">
    $(function(){
        $('.column').equalHeight();
    });
</script>
    </head>
    <body>
<section id="secondary_bar">
		<div class="user">
			<p><sec:authentication property="principal.realName"/>(<sec:authentication property="principal.username"/>)</p>
			<!-- <a class="logout_user" href="#" title="Logout">Logout</a> -->
		</div>
		<div class="breadcrumbs_container">
			<article class="breadcrumbs">
			<a href="${ctx }admin">首页</a> 
			<div class="breadcrumb_divider"></div> 
			<a class="current">${param.menuName }</a>
			</article>
		</div>
	</section><!-- end of secondary bar -->
	
	<aside id="sidebar" class="column" style="height: 602px;">
		<!-- <form class="quick_search">
			<input type="text" value="Quick Search" onfocus="if(!this._haschanged){this.value=''};this._haschanged=true;">
		</form> 
		<hr/>-->
		<h3>商品管理</h3>
		<ul class="toggle">
			<li class="icn_categories"><a href="${ctx }admin/goods/category/categorys/1">分类管理</a></li>
			<li class="icn_edit_article"><a href="${ctx }admin/goods/product/products/1">商品管理</a></li>
		</ul>
		<h3>新闻管理</h3>
		<ul class="toggle">
			<li class="icn_add_user"><a href="${ctx }admin/news/news/1">新闻管理</a></li>
		</ul>
		<h3>反馈管理</h3>
		<ul class="toggle">
			<li class="icn_folder"><a href="${ctx }admin/feedback/feedbacks/1">反馈管理</a></li>
		</ul>
		<h3>系统管理</h3>
		<ul class="toggle">
			<li class="icn_settings"><a href="${ctx }admin/sys/user/users/1">用户管理</a></li>
			<li class="icn_security"><a href="${ctx }admin/sys/role/roles/1">角色管理</a></li>
			<li class="icn_jump_back"><a href="${ctx }admin/sys/log/logs/1">日志管理</a></li>
			<li class="icn_jump_back"><a href="${ctx }admin/sys/company/">公司管理</a></li>
			<li class="icn_settings"><a href="${ctx }admin/sys/html/">生成管理</a></li>
		</ul>
		<footer>
			<hr />
			<p><strong>Copyright &copy; 2013 linian365boy@foxmail.com</strong></p>
		</footer>
	</aside><!-- end of sidebar -->
	<%
		if(request.getParameter("menuId")!=null){
			WebApplicationContext app = ContextLoader.getCurrentWebApplicationContext();
			MenuServiceImpl menuService = (MenuServiceImpl)app.getBean("menuService");
			Menu menu = menuService.loadMenuById(Long.parseLong(request.getParameter("menuId")));
			session.setAttribute("menu", menu);
		}
	%>
	</body>
	</html>