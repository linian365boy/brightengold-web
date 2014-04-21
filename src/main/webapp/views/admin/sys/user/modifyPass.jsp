<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/views/commons/include.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>华夏银行CPP即时查询系统</title>
<link rel="stylesheet" type="text/css"
	href="${ctx }resources/css/style.css" />
<!--[if IE]>
<link rel="stylesheet" type="text/css" href="css/ie-sucks.css" />
<![endif]-->
</head>
<body>
		<br/>
		<form id="form" action="${ctx }system/modifyPass.action" method="post" target="_parent">
            <fieldset >
            <div id="labelmm"><label for="oldPassword">原密码：</label></div>
            <input name="oldPassword" id="oldPassword" type="password"
                        tabindex="1" />
            <span id="oldText"></span> <br />
            <div id="labelmm"><label for="newPassword">新密码： </label></div>
            <input name="newPassword1" id="newPassword1" type="password"
                        tabindex="2" />
            <span id="new1Text"></span> <br />
           <div id="labelmm"><label for="newPassword2">确认密码： </label></div>
            <input name="newPassword2" id="newPassword2" type="password"
                        tabindex="3"/>
            <span id="new2Text"></span> <br />
            </fieldset>
          </form>

</body>
</html>
