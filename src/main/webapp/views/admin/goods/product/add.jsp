<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="../../../commons/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品新增</title>
<%@include file="/views/admin/commons/jsCss.jsp" %>
 <%@include file="/views/admin/commons/listJsCss.jsp" %>
<link href="${ctx }resources/js/skins/blue.css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }resources/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.metadata.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){
		$("#form").validate({
			rules:{
				"enName":{
					required:true
				},
				"photo":{
					required:true
				},
				"category":{
					required:true
				}
			},
			messages:{
				"enName":{
					required:"标题不能为空！"
				},
				"photo":{
					required:"优先值为数字！"
				},
				"category":{
					required:"内容不能为空！"
				}
			}
		});
	});
	
		$.getJSON("${ctx}admin/goods/category/getParentByAjax/0",function(returnJson){
			var json = $(returnJson);
			var str = "";
			for(var i=0;i<json.length;i++){
				str+="<option value="+json.get(i)[0]+">"+json.get(i)[1]+"</option>";
			}
			$("#parentCs").append(str);
		});
	</script>
</head>
<body>
<jsp:include page="/views/admin/commons/header.jsp"/>
	<jsp:include page="/views/admin/commons/left.jsp">
		<jsp:param value="6" name="menuId"/>
	</jsp:include>
	<section id="main" class="column">
		<article class="module width_full">
		<header>
		<h3 class="tabs_involved">新增商品</h3>
		</header>
		<div class="tab_container">
		<div id="tab1" class="tab_content">
	<form id="form" action="${ctx }goods/product/add" method="post" enctype="multipart/form-data">
            <div id="label"><label for="enName">商品名称：</label></div>
            <input id="enName" name="enName" type="text"/>
             <br />
             <div id="label"><label for="introduce">商品介绍：</label></div>
            <textarea rows="3" cols="100" name="introduce"></textarea>
             <br />
            <div id="label"><label for="photo">商品图片： </label></div>
            <input type="file" name="photo"/>
             <br />
            <div id="label"><label for="category">商品分类：</label></div>
            
            <select name="parentC" id="parentCs"  
            	style="width: 158px; margin-left: 0px;margin-bottom: 5px;">
            </select>
            
             <br />
            <div id="label"><label for="hot">是否热门：</label></div>
            <input name="hot" type="checkbox"/>
            <span>（勾选表示热门，否则非热门商品）</span>
             <br />
            <div class="aui_buttons" style="width:388px;">
              <button class="aui_state_highlight" type="submit">提交</button>
              <button type="reset">重置</button>
            </div>
          </form>
          </div>
          </div>
          </article>
       </section>
</body>
</html>