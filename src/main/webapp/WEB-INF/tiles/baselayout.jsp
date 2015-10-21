<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@include file="/views/commons/include.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></meta>
<title><tiles:insertAttribute name="title" /></title>
<link rel="shortcut icon" href="/resources/images/favicon.ico" type="image/ico"></link>
<%@include file="/views/admin/commons/listJsCss.jsp" %>
</head>
<body>
		<div id="newhead" class="header">
			<tiles:insertAttribute name="head" />
		</div>
		<div id="newcontent" class="wrap clearfix mt10">
			<div id="newleft" class="main_menu fl jsMainMenu">
				<tiles:insertAttribute name="left" />
			</div>
			<div id="newmain" class="main_bd fr">
				<tiles:insertAttribute name="main" />
			</div>
		</div>
		<div id="newfooter" class="wrap footer">
			<tiles:insertAttribute name="footer" />
		</div>
		<%@include file="/views/admin/commons/jsCss.jsp" %>
</body>
</html>