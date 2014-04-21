<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="../../../commons/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品分类新增</title>
<link href="${ctx }resources/js/skins/blue.css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }resources/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.metadata.js"></script>
<link rel="stylesheet" type="text/css"
	href="${ctx }resources/css/style.css" />
	<script type="text/javascript">
	$(document).ready(function(){
		$.getJSON("${ctx}admin/goods/category/getParentByAjax/1",function(returnJson){
			var json = $(returnJson);
			var str = "";
			for(var i=0;i<json.length;i++){
				str+="<option value="+json.get(i)[0]+">"+json.get(i)[1]+"</option>";
			}
			$("#parentCs").append(str);
		});
		
		$("#form").validate({
			rules:{
				"enName":{
					required:true,
					remote:{
						type:'POST',
						url:'${ctx}admin/goods/category/existCategory',
						data:{
							enName:function(){
								return $("#enName").val();
							}
						}
					}
				}
			},
			messages:{
				"enName":{
					required:"商品分类不能为空",
					remote:"该商品分类已存在，请更换！"
				}
			}
		});
	});
	</script>
</head>
<body>
	<form id="form" action="${ctx }admin/goods/category/add" method="post" target="_parent">
            <div id="label"><label for="pName">一级分类：</label></div>
            <select name="parentC" id="parentCs" style="width: 158px; margin-left: 0px;margin-bottom: 5px;">
            </select>
             <br />
            <div id="label"><label for="enName">名称： </label></div>
            <input style="width: 149px;" id="enName" name="enName"/>
             <br />
            <br/>
            <div class="aui_buttons" style="width:388px;">
              <button class="aui_state_highlight" type="submit">提交</button>
              <button type="reset">重置</button>
            </div>
          </form>
</body>
</html>