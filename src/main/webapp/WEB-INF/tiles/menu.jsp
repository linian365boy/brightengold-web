<%@page import="java.util.Locale"%>
<%@page import="java.util.TimeZone"%>
<%@page import="java.util.Calendar"%>
<%@page import="cn.rainier.nian.service.impl.MenuServiceImpl"%>
<%@page import="cn.rainier.nian.model.Menu"%>
<%@page import="org.springframework.web.context.ContextLoader"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@include file="/views/commons/include.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <html>
    <head>
    <meta charset="utf-8"/>
	<title>menu</title>
	<script type="text/javascript">
	    $(function(){
	       $('.column').equalHeight();
	    });
		$(document).ready(function(){
			var t = new Date().getTime();
			$.getJSON("${ctx}admin/sys/menu/findMenuByRole.html?t="+t,function(json){
				var pMenu = json.tree.item;
				var str = "";
				if((pMenu!=null)&&(pMenu.length!=0)){
					for(var i=0;i<pMenu.length;i++){
						str+= "<h3><a href='"+pMenu[i].url+"' id='nav_"+(i+1)+"' title="+pMenu[i].text+">"+pMenu[i].text+"</a></h3>";
						var sMenu = pMenu[i].item;
						console.info("sMenu.length==>"+sMenu.length);
						if((sMenu!=null)&&(sMenu.length!=0)){
							str+= "<ul class='toggle'>";
							for(var j=0;j<sMenu.length;j++){
								str+="<li class='icn_categories'><a title="+sMenu[j].text+" href='${ctx}"+sMenu[j].url+"'>"+sMenu[j].text+"</a></li>";
							}
							str+="</ul>";
						};
					};
				};
				$("#sidebar").html(str);
				showHide();
			});
		});
	</script>
    </head>
    <body>
	<aside id="sidebar" class="column">
	</aside><!-- end of sidebar -->
	<script type="text/javascript">
  	if(typeof(str)!='undefined'){
  		$("#sidebar").html(str);
  	}
  </script>
	</body>
	</html>