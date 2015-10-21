<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="../../../commons/include.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户添加</title>
<script type="text/javascript" src="${ctx }resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.metadata.js"></script>
<link href="${ctx }resources/css/bootstrap.min.css" rel="stylesheet"/>
<link rel="stylesheet" type="text/css"
	href="${ctx }resources/css/style.css" />
	<script type="text/javascript">
	$(document).ready(function(){
		$.getJSON("${ctx}admin/sys/role/getRolesByAjax.html",function(returnJson){
			var json = $(returnJson);
			var str = "";
			for(var i=0;i<json.length;i++){
				str+="<option value="+json.get(i)[0]+">"+json.get(i)[1]+"</option>";
			}
			$("#roles").append(str);
		});
		
		$("#form").validate({
			rules:{
				"username":{
					required:true,
					remote:{
						type:'POST',
						url:'${ctx}admin/sys/user/existUser.html',
						data:{
							username:function(){
								return $("#username").val();
							}
						}
					}
				},
				"password":{
					required:true
				}
			},
			messages:{
				"username":{
					required:"用户名不能为空",
					remote:"用户名已存在"
				},
				"password":{
					required:"密码不能为空",
				}
			},
			highlight: function(element) {
			      jQuery(element).closest('.form-group').removeClass('has-success').addClass('has-error');
			},
			success: function(element) {
			      jQuery(element).closest('.form-group').removeClass('has-error');
			}
		});
	});
	</script>
</head>
<body>
	<form id="form" class="form-horizontal" action="${ctx }sys/user/add.html" 
		method="post" target="_parent">
		<div class="form-group">
	    	<label for="username" class="col-sm-3 control-label">用户名<span class="asterisk">*</span></label>
			<div class="row col-sm-8">
			     <input type="text" class="form-control" id="username" name="username" autocomplete="off" 
			     placeholder="用户名">
			</div>
		</div>
		
		<div class="form-group">
	    	<label for="password" class="col-sm-3 control-label">密码<span class="asterisk">*</span></label>
			<div class="row col-sm-8">
			     <input type="password" class="form-control" id="password" name="password" autocomplete="off" 
			     placeholder="密码">
			</div>
		</div>
		
		<div class="form-group">
	    	<label for="realName" class="col-sm-3 control-label">姓名</label>
			<div class="row col-sm-8">
			     <input type="password" class="form-control" id="realName" name="realName" autocomplete="off" 
			     placeholder="姓名">
			</div>
		</div>
		<div class="form-group">
		    <label for="roles" class="col-sm-3 control-label">角色分配</label>
		    	<div class="row col-xs-8" style="overflow:hidden;">
		    		<select class="col-xs-7 selectpicker" name="role" id="roles">
			      	</select>
		    	</div>
		  </div>
		  <div class="form-group">
		  	<label class="col-sm-3 control-label">状态</label>
		  	<label class="control-label checkbox-inline">
		  	<input type="checkbox" name="enabled"/>（勾选表示启用此账号，否则禁用）
		  	</label>
		  </div>
		  <div class="form-group">
			  <div class="col-sm-offset-4 col-sm-8">
			  	<button type="submit" class="btn btn-primary">保存</button>
			      <button class="btn btn-default" type="reset">重置</button>
			    </div>
			  </div>
          </form>
</body>
</html>