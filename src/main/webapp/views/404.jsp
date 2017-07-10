<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="commons/include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Rockechogroup welcome you</title>
<link rel="stylesheet" type="text/css"
	href="${ctx}/resources/css/style.css" />

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
						<img src="${ctx}/resources/images/error.png" style="padding-top:10px"/><strong style="color:red;position: absolute; top:24%;padding-left:10px;">Page Not Found！</strong>
					</h2><br />
					<font> Make sure that the address of the web browser is correctly spelled and formatted correctly.
Click the link to arrive at this page, please contact the administrator to inform them that the link is not in the correct format.
Or do the following.
					</font>
					<br />
					<br /> <a href="javascript:history.back(-1)">back</a> <br />
					<br /> <a href="${ctx}/admin/login">go to login</a><br />
			</div>
			</div>
		</div>
	</div>
</body>
</html>

