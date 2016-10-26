<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@include file="/views/commons/include.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title><tiles:insertAttribute name="title"/></title>
	<tiles:insertAttribute name="headJsCss"/>
</head>
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<header class="main-header">
			<tiles:insertAttribute name="head" />
		</header>
		<!-- Left side column. contains the logo and sidebar -->
		<aside class="main-sidebar">
			<tiles:insertAttribute name="left" />
		</aside>
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<tiles:insertAttribute name="main" />
		</div>
		<footer class="main-footer">
			<tiles:insertAttribute name="footer" />
		</footer>
		<!-- control-sidebar -->
		<aside class="control-sidebar control-sidebar-dark">
			<tiles:insertAttribute name="sidebar"/>
		</aside>
		<!-- Control Sidebar -->
		<div class="control-sidebar-bg"></div>
	</div>
	<tiles:insertAttribute name="footerJsCss"/>
</body>
</html>