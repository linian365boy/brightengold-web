<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../../commons/include.jsp" %>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <%@include file="/views/admin/commons/listJsCss.jsp" %>
<%@include file="/views/admin/commons/jsCss.jsp" %>
 <script type="text/javascript" src="${ctx }resources/js/jquery-1.8.3.js"></script>
 <script type="text/javascript" src="${ctx }resources/js/ckEditor/ckeditor.js"></script>
 <script type="text/javascript" src="${ctx }resources/js/ckEditor/lang/zh-cn.js"></script>
 <script type="text/javascript" src="${ctx }resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.metadata.js"></script>
<style type="text/css">
	label.error{
	background:url(/resources/images/x.png) no-repeat 0px 0px;
	padding-left:18px;
	color: red;
	width:150px;
} 
</style>
<title>添加新闻</title>
<script type="text/javascript">
	$(document).ready(function(){
		$("#form").validate({
			rules:{
				"title":{
					required:true
				},
				"priority":{
					number:true
				},
				"content":{
					required:true
				}
			},
			messages:{
				"title":{
					required:"标题不能为空！"
				},
				"priority":{
					number:"优先值为数字！"
				},
				"content":{
					required:"内容不能为空！"
				}
			}
		});
	});
</script>
</head>
<body>
<jsp:include page="/views/admin/commons/header.jsp"/>
	<jsp:include page="/views/admin/commons/left.jsp">
		<jsp:param value="10" name="menuId"/>
		<jsp:param value="新闻管理" name="menuName"/>
		<jsp:param value="添加新闻" name="menuSubName"/>
	</jsp:include>
	<section id="main" class="column">
		<article class="module width_full">
		<header>
		<h3 class="tabs_involved">添加新闻</h3>
		</header>
		<div class="tab_container">
		<div id="tab1" class="tab_content">
		<form action="${ctx }news/add" class="form-horizontal" id="form" method="post">
            <label for="title" style="padding-left: 10px;">标题：</label>
            <input id="title" name="title" class="span3"  type="text"  placeholder="标题"/>
             <br />
             <fieldset>
					<label>摘要</label>
					<textarea rows="3" name="introduce"></textarea>
			</fieldset>
             <label for="keyWords" style="padding-left: 10px;">关键字（多个以英文;隔开）：</label>
            <input id="keyWords" class="span3" name="keyWords"  type="text"
                        tabindex="1" placeholder="关键字"/>
             <br />
            <div id="label"><label for="priority" style="padding-left: 10px;">优先值（越大排名越前）：</label>
            <input id="priority" name="priority" placeholder="优先值" type="text" tabindex="1" /></div>
             <br />
            <div id="label"><label for="content" style="padding-left: 10px;">内容：</label>
            <textarea id="content" name="content" class="ckeditor"></textarea></div>
            <br/>
            <input type="submit" id="button" value="提交" class="btn btn-primary"/>
          </form>
          </div>
          </div>
          </article>
         </section>
</body>
</html>