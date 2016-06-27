<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/views/commons/include.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="${ctx }resources/css/bootstrap.min.css" rel="stylesheet"/>
<link rel="stylesheet" type="text/css"
	href="${ctx }resources/css/style.css" />
</head>
<body>
		<form id="form" class="form-horizontal" action="${ctx }admin/sys/user/modifyPass.html" 
			method="post" target="_parent">
			<div class="form-group">
		    	<label for="oldPassword" class="col-sm-3 control-label">原密码<span class="asterisk">*</span></label>
				<div class="row col-sm-8">
				     <input type="password" class="form-control" id="oldPassword" name="oldPassword" autocomplete="off" 
				     placeholder="原密码">
				</div>
			</div>
			<div class="form-group">
		    	<label for="oldPassword" class="col-sm-3 control-label">新密码<span class="asterisk">*</span></label>
				<div class="row col-sm-8">
				     <input type="password" class="form-control" id="oldPassword" name="oldPassword" autocomplete="off" 
				     placeholder="原密码">
				</div>
			</div>
			<div class="form-group">
		    	<label for="oldPassword" class="col-sm-3 control-label">确认密码<span class="asterisk">*</span></label>
				<div class="row col-sm-8">
				     <input type="password" class="form-control" id="oldPassword" name="oldPassword" autocomplete="off" 
				     placeholder="原密码">
				</div>
			</div>
			<span id="new2Text"></span>
          </form>

</body>
</html>
