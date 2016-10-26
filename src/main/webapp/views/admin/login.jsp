<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../commons/include.jsp" %>
<!DOCTYPE HTML> 
<html> 
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
<meta http-equiv="description" content="brigtengold login"> 
<meta http-equiv="author" content="brigtengold"> 
<title>rockechogroup login</title>
<link rel="icon" href="${ctx }resources/dist/img/favicon.ico" type="image/x-icon">
<link rel="shortcut icon" href="${ctx }resources/dist/img/favicon.ico" type="image/x-icon" />
<link href="${ctx }resources/dist/css/login.css?${style_v}" rel="stylesheet" type="text/css"/>
</head>
<body>
  <form action="j_spring_security_check" id="login" method="post">
  	<h1>Log In</h1>
	  <div style="margin-top: 15px;color:red;" id="messageDiv">${sessionScope.SPRING_SECURITY_LAST_EXCEPTION.message }</div>
  	<fieldset id="inputs">
  		<input id="username" name="j_username" type="text" placeholder="Username" 
  		value="${sessionScope['SPRING_SECURITY_LAST_USERNAME']}" autofocus required/>
  		<input id="password" name="j_password" type="password" placeholder="Password" required/>
  	</fieldset>
  	<fieldset id="actions">
  		<input id="submit" type="submit" value="Log in"/>
  	</fieldset>
  	<div id="login_footer">
      Copyright &copy; <%=Calendar.getInstance().get(Calendar.YEAR) %> linian365boy#sina.com。把#换成@
    </div>
  </form>
</body>
</html>