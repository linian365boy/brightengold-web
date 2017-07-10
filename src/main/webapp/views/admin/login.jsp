<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../commons/include.jsp" %>
<!DOCTYPE HTML> 
<html> 
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
<meta http-equiv="description" content="brigtengold login"> 
<meta http-equiv="author" content="brigtengold"> 
<title>login page</title>
<link rel="icon" href="${ctx }/resources/dist/img/favicon_48X66.ico"
	type="image/x-icon">
<link rel="shortcut icon" href="${ctx }/resources/dist/img/favicon_16X22.ico"
	type="image/x-icon" />
<link href="${ctx }/resources/dist/css/login.css?${style_v}" rel="stylesheet" type="text/css"/>
<!-- jQuery 2.2.3 -->
<script src="/resources/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script type="text/javascript">
$(function(){
	 if (window != top)
	 	top.location.href = location.href;
});
function changeCode(){
	jQuery('#kaptchaImage').hide().attr('src', '${ctx}/views/getLoginVerifyCode?' + Math.floor(Math.random()*100)).fadeIn();  
	event.cancelBubble=true;
}
</script>
</head>
<body>
  <form action="${ctx }/admin/login" id="login" method="post">
  	<h1>Log In</h1>
	  <div style="margin-top: 15px;color:red;" id="messageDiv">${sessionScope.SPRING_SECURITY_LAST_EXCEPTION.message }</div>
  	<fieldset id="inputs">
  		<input class="login" id="username" name="username" type="text" placeholder="Username" 
  		value="${sessionScope['SPRING_SECURITY_LAST_USERNAME']}" autofocus required/>
  		<input class="login" id="password" name="password" type="password" placeholder="Password" required/>
  		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	  	<%-- <input id="captcha" name="captcha" type="text" placeholder="Captcha" required/>
		<img src="${ctx}/views/getLoginVerifyCode" id="kaptchaImage" style="margin-bottom: -15px"/>  
		<a href="javascript:void(0);" id="kaptchaHref" onclick="changeCode();">Refresh the code</a> --%>
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