<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="../../../commons/include.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改用户信息</title>
<script type="text/javascript" src="${ctx }resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.metadata.js"></script>
<link href="${ctx }resources/css/bootstrap.min.css" rel="stylesheet"/>
<link rel="stylesheet" type="text/css" href="${ctx }resources/css/style.css" />
<style type="text/css">
	.selectpicker {
		background-color: #fff;
	    background-image: none;
	    border: 1px solid #ccc;
	    border-radius: 4px;
	    box-shadow: 0 1px 1px rgba(0, 0, 0, 0.075) inset;
	    color: #555;
	    display: block;
	    font-size: 14px;
	    height: 34px;
	    line-height: 1.42857;
	    padding: 6px 12px;
	    transition: border-color 0.15s ease-in-out 0s, box-shadow 0.15s ease-in-out 0s;
	    vertical-align: middle;
	}
</style>
<script type="text/javascript">
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
							},
							u:function(){
								return "${model.username}";
							}
						}
					}
				}
			},
			messages:{
				"username":{
					required:"用户名不能为空",
					remote:"用户名已存在"
				}
			},
			highlight: function(element) {
			      jQuery(element).closest('.form-group').removeClass('has-success').addClass('has-error');
			},
			success: function(element) {
			      jQuery(element).closest('.form-group').removeClass('has-error');
			}
	});

function formSubmit(){
	var username = $("#username").val();
	$("#form").attr("action","${ctx}admin/sys/user/"+username+"/update.html");
	$("#form").submit();
}
</script>
</head>
<body>
	<form id="form" class="form-horizontal" action="#" method="post" target="_parent">
	<div class="form-group">
	    	<label for="username" class="col-sm-3 control-label">用户名<span class="asterisk">*</span></label>
			<div class="row col-sm-8">
			     <input type="text" class="form-control" id="username" value="${model.username }" name="username"/>
			</div>
		</div>
		
		<div class="form-group">
	    	<label for="realName" class="col-sm-3 control-label">姓名</label>
			<div class="row col-sm-8">
			     <input type="text" class="form-control" value="${model.realName }" id="realName" name="realName"/>
			</div>
		</div>
		<c:forEach items="${model.roles }" var="myRole">
           	<c:if test="${myRole.name ne 'ROLE_DEFAULT' }">
           		<c:set var="mr" value="${myRole.name }" scope="page"/>
           	</c:if>
        </c:forEach>
		<div class="form-group">
		    <label for="roles" class="col-sm-3 control-label">角色分配</label>
		    	<div class="row col-xs-8" style="overflow:hidden;">
		    		<select name="role" id="roles" class="col-xs-7 selectpicker" style="width: 158px;margin-left: 0px;margin-bottom: 5px;">
		            	<c:forEach items="${rolesAjax }" var="r">
		            		<option value="${r[0] }"
		            			<c:if test="${r[0] eq mr }">
		            				selected="selected"
		            			</c:if>
		            		>
		            			${r[1] }
		            		</option>
		            	</c:forEach>
		            </select>
		    	</div>
		  </div>
		  
		  <div class="form-group">
		  	<label class="col-sm-3 control-label">状态</label>
		  	<label class="control-label checkbox-inline">
		  	<input type="checkbox" name="enabled" <c:choose>
			 		<c:when test="${model.enabled }">
			 			checked="checked"
			 		</c:when>
			 	</c:choose>/>（勾选表示启用此账号，否则禁用）
		  	</label>
		  </div>
            <input type="hidden" name="id" value="${model.id }"/>
            <div class="form-group">
			  <div class="col-sm-offset-4 col-sm-8">
			  	<button type="submit" class="btn btn-primary">保存</button>
			      <button class="btn btn-default" type="reset">重置</button>
			    </div>
			  </div>
          </form>
</body>
</html>