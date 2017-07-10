<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="/views/commons/include.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户添加</title>
<!-- jQuery 2.2.3 -->
<script src="/resources/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- jQuery form plugin -->
<script src="/resources/plugins/jQueryForm/jquery.form.min.js"></script>
<script type="text/javascript" src="/resources/plugins/jQueryValidate/jquery.validate.js"></script>
<script type="text/javascript" src="/resources/plugins/jQueryValidate/jquery.metadata.js"></script>
<!-- Bootstrap 3.3.6 -->
<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="/resources/dist/css/AdminLTE.min.css">
<link rel="stylesheet" type="text/css" href="/resources/dist/css/customUse.css" />
	<script type="text/javascript">
	$(document).ready(function(){
		$.getJSON("${ctx}/admin/sys/role/getRolesByAjax",function(returnJson){
			var json = $(returnJson);
			var str = "";
			for(var i=0;i<json.length;i++){
				str+="<option value="+json.get(i).name+">"+json.get(i).describes+"</option>";
			}
			$("#roles").append(str);
		});
		
		$("#form").validate({
			rules:{
				"username":{
					required:true,
					remote:{
						type:'POST',
						url:'${ctx}/admin/sys/user/existUser',
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
			},
			submitHandler: function(form){
				$(form).ajaxSubmit({
					dataType:'json',
					success:function(json) {
				    		if(json.code==200){
				    			$("button[name='refresh']",top.document).click();
				    			top.art.dialog.list['tianjia'].close();
				    		}else{
				    			$("span.help-block").html(json.message);
				    			$(".has-error").removeClass("hide");
				    		}
			        }
				});
			}
		});
	});
	</script>
</head>
<body>
	<form id="form" class="form-horizontal content" action="${ctx}/admin/sys/user/add" 
		method="post" target="_parent">
		<div class="form-group">
	    	<label for="username" class="col-sm-2 control-label">用户名<code>*</code></label>
			<div class="col-sm-8">
			     <input type="text" class="form-control" id="username" name="username" placeholder="用户名">
			</div>
		</div>
		
		<div class="form-group">
	    	<label for="password" class="col-sm-2 control-label">密码<code>*</code></label>
			<div class="col-sm-8">
			     <input type="password" class="form-control" id="password" name="password" placeholder="密码">
			</div>
		</div>
		
		<div class="form-group">
	    	<label for="realName" class="col-sm-2 control-label">姓名</label>
			<div class="col-sm-8">
			     <input type="text" class="form-control" id="realName" name="realName" placeholder="姓名">
			</div>
		</div>
		<div class="form-group">
		    <label for="roles" class="col-sm-2 control-label">角色分配</label>
		    	<div class="col-xs-8" style="overflow:hidden;">
		    		<select class="col-xs-5 selectpicker" name="role" id="roles">
			      	</select>
		    	</div>
		  </div>
		  <div class="form-group">
		  	<div class="col-sm-offset-2 col-sm-10">
                        <div class="checkbox">
                          <label>
                            <input type="checkbox" name="enabled"> （勾选表示启用此账号，否则禁用）
                          </label>
                        </div>
                      </div>
		  </div>
		  <div class="form-group has-error hide">
			  	  <label class="col-sm-3 control-label">&nbsp;</label>
                  <span class="help-block"></span>
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