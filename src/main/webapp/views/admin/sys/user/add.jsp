<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="../../../commons/include.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户添加</title>
<link href="${ctx }resources/js/skins/blue.css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.metadata.js"></script>
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
			}
		});
	});
	</script>
</head>
<body>
	<form id="form" action="${ctx }sys/user/add.html" method="post" target="_parent">
            <div id="label"><label for="username">用户名：</label></div>
            <input id="username" name="username"  type="text"  autocomplete="off"
                        tabindex="1"/>
             <br />

            <div id="label"><label for="password">密码： </label></div>
            <input style="width: 149px;" name="password" autocomplete="off" class="{required:true,messages:{required:'密码不能为空'}}" type="password"
                        tabindex="3" />
             <br />
            <div id="label"><label for="realName">姓名：</label></div>
            <input name="realName" class="{required:true,messages:{required:'姓名不能为空'}}"
            type="text" tabindex="4" />
             <br />
            <div id="label"><label for="role">角色分配：</label></div>
            <select name="role" id="roles" style="width: 158px; margin-left: 0px;margin-bottom: 5px;">
              <%--<option value="0">=====角色分配=====</option>--%>
             </select>
             <br />
			<div id="label"><label for="status">状态：</label></div>
            	<input type="checkbox" name="enabled"/>
            <span>（勾选表示启用此账号，否则禁用）</span>
            <br/>
            <div class="aui_buttons" style="width:388px;">
              <button class="aui_state_highlight" type="submit">提交</button>
              <button type="reset">重置</button>
            </div>
          </form>
</body>
</html>