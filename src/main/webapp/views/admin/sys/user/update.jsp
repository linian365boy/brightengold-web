<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="../../../commons/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改用户信息</title>
<link href="${ctx }resources/js/skins/blue.css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.metadata.js"></script>
<link rel="stylesheet" type="text/css"
	href="${ctx }resources/css/style.css" />
<script type="text/javascript">
	$("#form").validate({
			rules:{
				"username":{
					required:true,
					remote:{
						type:'POST',
						url:'${ctx}admin/sys/user/existUser',
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
			}
	});

function formSubmit(){
	var username = $("#username").val();
	$("#form").attr("action","${ctx}admin/sys/user/"+username+"/update");
	$("#form").submit();
}
</script>
</head>
<body>
	<form id="form" action="#" method="post" target="_parent">
            <div id="label"><label for="username">员工号：</label></div>
            <input id="username" name="username" value="${model.username }" type="text"
                        tabindex="1"/>
             <br />

            <div id="label"><label for="realName">姓名：</label></div>
            <input name="realName" value="${model.realName }" class="{required:true,messages:{required:'姓名不能为空'}}"
            type="text" tabindex="4" />
             <br />
            <div id="label"><label for="role">角色分配：</label></div>
            <c:forEach items="${model.roles }" var="myRole">
            	<c:if test="${myRole.name ne 'ROLE_DEFAULT' }">
            		<c:set var="mr" value="${myRole.name }" scope="page"/>
            	</c:if>
            </c:forEach>

            <select name="role" id="roles" style="width: 158px;margin-left: 0px;margin-bottom: 5px;">
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
            <br/>
			<div id="label"><label for="status">状态：</label></div>
            	<input type="checkbox" name="enabled"
           		<c:choose>
			 		<c:when test="${model.enabled }">
			 			checked="checked"
			 		</c:when>
			 	</c:choose>
			 />
            <span>（勾选表示启用此账号，否则禁用）</span>
            <br/>
            <input type="hidden" name="id" value="${model.id }"/>
            <div class="aui_buttons" style="width:388px;">
              <button class="aui_state_highlight" type="button" onclick="formSubmit();">提交</button>
              <button type="reset">重置</button>
            </div>
          </form>
</body>
</html>