<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="commons/include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Sunshinecig welcome you</title>
<link rel="stylesheet" type="text/css"
	href="${ctx}resources/css/style.css" />

<!--[if IE]>
<link rel="stylesheet" type="text/css" href="css/ie-sucks.css" />
<![endif]-->
</head>
<body >
	<div id="container">
		<div id="header" >
			<div class="logo"></div>
		</div>
		<div class="nav">
			<div class="navinner">
			</div>
		</div>
		<br />
		<div style="position: absolute; top:28%; left:17%;">

				<div style="position: absolute; top:30%; left:100%;border:0px;width:500px;padding:40px;border-left:1px dashed #375a90;">
				<div align="left">
					<h2>
						<img src="${ctx}resources/images/error.png" style="padding-top:10px"/><strong style="color:red;position: absolute; top:25%;padding-left:10px;">服务器发生错误！</strong>
					</h2><br />
					<font> 当前服务器出现了内部错误，请与管理员联系，检查系统日志。
							或者做以下操作。
					</font>
					<br />
					<br /> <a href="javascript:history.back(-1)">返回上次操作页面</a> <br />
					<br /> <a href="${ctx}admin/login">返回登录页面</a><br />

			</div>
			</div>
		</div>
	</div>
</body>
</html>



