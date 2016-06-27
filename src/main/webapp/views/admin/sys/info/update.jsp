<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="/views/commons/include.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品分类编辑</title>
<script type="text/javascript" src="${ctx }resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.metadata.js"></script>
<script type="text/javascript" src="${ctx }resources/js/ckEditor/ckeditor.js"></script>
<script type="text/javascript" src="${ctx }resources/js/ckEditor/lang/zh-cn.js"></script>
<link href="${ctx }resources/css/bootstrap.min.css" rel="stylesheet"/>
<link href="${ctx }resources/css/style.css" rel="stylesheet"/>
<script type="text/javascript">
$(document).ready(function(){
	$("#form").validate({
		rules:{
			"name":{
				required:true
			},
			"code":{
				required:true
			},
			"priority":{
				number:true
			}
		},
		messages:{
			"name":{
				required:"名称不能为空"
			},
			"code":{
				required:"代码不能为空"
			},
			"priority":{
				number:"请输入数字！"
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
		<h3 class="tabs_involved">新增信息</h3>
		</header>
		<div class="tab_container">
		<div id="tab1" class="tab_content">
	<form class="form-horizontal" id="form" method="post" target="_parent" 
		action="${ctx }admin/sys/info/${model.id }/update.html">
  <div class="form-group">
    <label for="name" class="col-sm-1 control-label">名称<span class="asterisk">*</span></label>
    <div class="col-sm-8">
      <input type="text" class="form-control" id="name" value="${model.name }" name="name" placeholder="名称">
    </div>
  </div>
  <div class="form-group">
    <label for="code" class="col-sm-1 control-label">代码<span class="asterisk">*</span></label>
    <div class="col-sm-8">
      <input type="text" class="form-control" id="code" value="${model.code }" name="code" placeholder="代码">
    </div>
  </div>
  <div class="form-group">
    <label for="priority" class="col-sm-1 control-label">排序号</label>
    <div class="col-sm-8">
      <input type="text" class="form-control" id="priority" value="${model.priority }" name="priority" placeholder="排序号，越大排名越前">
    </div>
  </div>
  <div class="form-group">
			    <label for="content" class="col-sm-1 control-label">产品详情<span class="asterisk">*</span></label>
			    <div class="col-sm-9">
			      <textarea id="content" rows="16" name="content" class="form-control ckeditor">${model.content }</textarea>
			    </div>
		   </div>
  <div class="form-group">
    <div class="col-sm-offset-4 col-sm-8">
      <button type="submit" class="btn btn-primary">保存</button>
      <button class="btn btn-default" type="reset">重置</button>
    </div>
  </div>
  <input type="hidden" name="id" value="${model.id }"/>
</form>
</div>
          </div>
          </article>
       </section>
</body>
</html>