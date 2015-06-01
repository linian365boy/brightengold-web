<%@page import="java.util.Locale"%>
<%@page import="java.util.TimeZone"%>
<%@page import="java.util.Calendar"%>
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
	<c:choose>
		<c:when test="${!empty session.menuXml }">
			<script type="text/javascript">
			var da = loadXML("${session.menuXml}");
			var pMenu = $(da).find("item[url='javascript:void(0);']");
			var str = "";
			if((pMenu!=null)&&(pMenu.length!=0)){
				for(var i=0;i<pMenu.length;i++){
					var pmenu = $(pMenu[i]);
					var name = pmenu.attr("text");
					var url = pmenu.attr("url");
					str+= "<h3><a href='"+url+"' id='nav_"+(i+1)+"' title="+name+">"+name+"</a></h3>";
					var sMenu = pmenu.find("item");
					var length = sMenu.length;
					if((sMenu!=null)&&(length!=0)){
						str+="<ul class='toggle'>";
						for(var j=0;j<length;j++){
							var smenu = $(sMenu[j]);
							var smenuName = smenu.attr("text");
							var smenuUrl = smenu.attr("url");
							var id = smenu.attr("id");
							str+="<li class='icn_categories'><a title="+smenuName+" href='${ctx}"+smenuUrl+"'>"+smenuName+"</a></li>";
						}
						str+="</ul>";
					};
				};
			};

			function loadXML(xmlString){
			    var xmlDoc;
			    if (window.ActiveXObject)
			    {
			        xmlDoc = new ActiveXObject('Microsoft.XMLDOM');
			        if(!xmlDoc) xmldoc = new ActiveXObject("MSXML2.DOMDocument.3.0");
			        xmlDoc.async = false;
			        xmlDoc.loadXML(xmlString);
			    }else if (document.implementation && document.implementation.createDocument){
			        var domParser = new DOMParser();
			        xmlDoc = domParser.parseFromString(xmlString, 'text/xml');
			    }else{
			        return null;
			    }
			    return xmlDoc;
			}
		</script>
		</c:when>		
		<c:otherwise>
			<script type="text/javascript">
				$(document).ready(function(){
					var t = new Date().getTime();
					$.get("${ctx}admin/sys/menu/findMenuByRole.html?t="+t,function(xml){
						var da = $(xml);
						var pMenu = da.find("item[url='javascript:void(0);']");
						var str = "";
						if((pMenu!=null)&&(pMenu.length!=0)){
							for(var i=0;i<pMenu.length;i++){
								var pmenu = $(pMenu[i]);
								var name = pmenu.attr("text");
								var url = pmenu.attr("url");
								str+= "<h3><a href='"+url+"' id='nav_"+(i+1)+"' title="+name+">"+name+"</a></h3>";
								var sMenu = pmenu.find("item");
								var length = sMenu.length;
								if((sMenu!=null)&&(length!=0)){
								str+= "<ul class='toggle'>";
									for(var j=0;j<length;j++){
										var smenu = $(sMenu[j]);
										var smenuName = smenu.attr("text");
										var smenuUrl = smenu.attr("url");
										var id = smenu.attr("id");
										str+="<li class='icn_categories'><a title="+smenuName+" href='${ctx}"+smenuUrl+"'>"+smenuName+"</a></li>";
									}
									str+="</ul>";
								};
							};
						};
						$("#footer").before(str);
					});
				});
				</script>
		</c:otherwise>
	</c:choose>
    </head>
    <body>
<section id="secondary_bar">
		<div class="user">
			<p><sec:authentication property="principal.realName"/>(<sec:authentication property="principal.username"/>)</p>
			<!-- <a class="logout_user" href="#" title="Logout">Logout</a> -->
		</div>
		<div class="breadcrumbs_container">
			<article class="breadcrumbs">
			<a href="${ctx }admin/index.html">首页</a> 
			<c:if test="${!empty param.menuName}">
				<div class="breadcrumb_divider"></div>
				<a href="#" class="${!empty param.menuSubName?'current':'' }">${param.menuName }</a>
			</c:if>
			<c:if test="${!empty param.menuSubName }">
				<div class="breadcrumb_divider"></div>
				<a class="current">${param.menuSubName }</a>
			</c:if>
			</article>
		</div>
	</section><!-- end of secondary bar -->
	
	<aside id="sidebar" class="column" style="height: 602px;">
		<footer id="footer">
			<hr />
			<%
				Calendar now = Calendar.getInstance(TimeZone.getDefault(),Locale.getDefault());
			%>
			<p><strong>Copyright &copy; <%=now.get(Calendar.YEAR) %> linian365boy@foxmail.com</strong></p>
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
	<script type="text/javascript">
  	if(typeof(str)!='undefined'){
  		$("#footer").before(str);
  	}
  </script>
	</body>
	</html>