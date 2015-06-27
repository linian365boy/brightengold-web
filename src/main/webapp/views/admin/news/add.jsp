<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/views/commons/include.jsp" %>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }resources/js/skins/blue.css" rel="stylesheet"/>
 <script type="text/javascript" src="${ctx }resources/js/jquery-1.11.1.min.js"></script>
 <script type="text/javascript" src="${ctx }resources/js/ckEditor/ckeditor.js"></script>
 <script type="text/javascript" src="${ctx }resources/js/ckEditor/lang/zh-cn.js"></script>
 <script type="text/javascript" src="${ctx }resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.metadata.js"></script>
<link href="${ctx }resources/css/bootstrap.min.css" rel="stylesheet"/>
<link href="${ctx }resources/css/style.css" rel="stylesheet"/>
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
	<section id="main" class="column">
		<article class="module width_full">
		<header>
		<h3 class="tabs_involved">添加新闻</h3>
		</header>
		<div class="tab_container">
		<div id="tab1" class="tab_content">
		<form action="${ctx }admin/news/add.html" class="form-horizontal" id="form" method="post">
			<div class="form-group">
			    <label for="title" class="col-sm-2 control-label">标题<span class="asterisk">*</span></label>
			    <div class="col-sm-8">
			      <input type="text" class="form-control" id="title" name="title" placeholder="标题">
			    </div>
		   </div>
		   <div class="form-group">
		   		<div class="form-group">
					<label for="introduce" class="col-sm-2 control-label">摘要</label>
					<div class="col-sm-8">
						<textarea rows="3" class="form-control" id="introduce" placeholder="摘要" name="introduce"></textarea>
					</div>
				</div>
			</div>
			<div class="form-group">
			    <label for="keyWords" class="col-sm-2 control-label">关键字</label>
			    <div class="col-sm-8">
			      <input type="text" class="form-control" id="keyWords" name="keyWords" placeholder="关键字（多个以英文;隔开）">
			    </div>
		   </div>
		   
		   <div class="form-group">
			    <label for="priority" class="col-sm-2 control-label">优先值</label>
			    <div class="col-sm-8">
			      <input type="text" class="form-control" id="priority" name="priority" placeholder="优先值（越大排名越前）">
			    </div>
		   </div>
		   
		   <div class="form-group">
			    <label for="content" class="col-sm-2 control-label">内容<span class="asterisk">*</span></label>
			    <div class="col-sm-9">
			      <textarea id="content" name="content" class="ckeditor"></textarea>
			    </div>
		   </div>
		   
		   <div class="form-group">
		    <div class="col-sm-offset-4 col-sm-8">
		      <button type="submit" class="btn btn-primary">保存</button>
		      <button class="btn btn-default" type="reset">重置</button>
		    </div>
		  </div>
          </form>
          </div>
          </div>
          </article>
         </section>
</body>
</html>