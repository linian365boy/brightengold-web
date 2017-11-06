<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/views/commons/include.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="${ctx}/resources/css/bootstrap.min.css" rel="stylesheet"/>
<link rel="stylesheet" type="text/css"
	href="${ctx}/resources/css/style.css" />
	<style type="text/css">
		#form{
			width: 350px;
		}
	</style>
	
</head>
<body>
		<form id="form" class="form-horizontal" action="${ctx}/admin/sys/user/modifyPass" 
			method="post" target="_parent">
			<div class="form-group">
		    	<label for="oldPassword" class="col-sm-2 control-label">原密码<span class="asterisk">*</span></label>
				<div class="row col-sm-8">
				     <input type="password" class="form-control" id="oldPassword" name="oldPassword" autocomplete="off" 
				     placeholder="原密码">
				</div>
			</div>
			<div class="form-group">
		    	<label for="newPassword1" class="col-sm-2 control-label">新密码<span class="asterisk">*</span></label>
				<div class="row col-sm-8">
				     <input type="password" class="form-control" id="newPassword1" name="newPassword1" autocomplete="off" 
				     placeholder="新密码">
				</div>
			</div>
			<div class="form-group">
		    	<label for="newPassword2" class="col-sm-2 control-label">新密码<span class="asterisk">*</span></label>
				<div class="row col-sm-8">
				     <input type="password" class="form-control" id="newPassword2" name="newPassword2" autocomplete="off" 
				     placeholder="再次确认下新密码">
				</div>
			</div>
			<span id="new2Text"></span>
          </form>

</body>
</html>
