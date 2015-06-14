<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../../commons/include.jsp" %>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <script type="text/javascript" src="${ctx }resources/js/jquery-1.11.1.min.js"></script>
 <script type="text/javascript" src="${ctx }resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.metadata.js"></script>
 <script type="text/javascript" src="${ctx }resources/js/additional-methods.min.js"></script>
<link href="${ctx }resources/css/bootstrap.min.css" rel="stylesheet"/>
<link href="${ctx }resources/css/style.css" rel="stylesheet"/>
<title>添加滚动图片</title>
<script type="text/javascript">
	$(document).ready(function(){
		$("#form").validate({
			rules:{
				"name":{
					required:true
				},
				"priority":{
					number:true
				},
				"width":{
					required:true,
					number:true
				},
				"height":{
					required:true,
					number:true
				},
				"photo":{
					 accept: "image/*"
				}
			},
			messages:{
				"name":{
					required:"图片名称不能为空！"
				},
				"priority":{
					number:"排序号为数字！"
				},
				"width":{
					required:"宽度不能为空！",
					number:"宽度为数字！"
				},
				"height":{
					required:"高度不能为空！",
					number:"高度为数字！"
				},
				"photo":{
					accept: "请上传图片！"
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
	<form class="form-horizontal" id="form" method="post" 
	enctype="multipart/form-data" action="${ctx }admin/ad/${model.id }/update.html" target="_parent">
  <div class="form-group">
    <label for="name" class="col-sm-2 control-label">名称<span class="asterisk">*</span></label>
    <div class="col-sm-8">
      <input type="text" class="form-control" id="name" value="${model.name }" name="name" placeholder="名称">
    </div>
  </div>
  <div class="form-group">
    <label for="photo" class="col-sm-2 control-label">图片<span class="asterisk">*</span></label>
    <div class="col-sm-8">
    	<img alt="" src="${ctx }resources/${model.picUrl}" width="107px" height="50px"/>
      <input type="file" id="photo" name="photo" placeholder="图片">
    </div>
  </div>
  <div class="form-group">
    <label for="width" class="col-sm-2 control-label">宽度<span class="asterisk">*</span></label>
    <div class="col-sm-8">
      <input type="text" class="form-control" value="${model.width }" id="width" name="width" placeholder="宽度（单位：像素）">
    </div>
  </div>
  <div class="form-group">
    <label for="height" class="col-sm-2 control-label">高度<span class="asterisk">*</span></label>
    <div class="col-sm-8">
      <input type="text" class="form-control" value="${model.height }" id="height" name="height" placeholder="高度（单位：像素）">
    </div>
  </div>
  <div class="form-group">
    <label for="url" class="col-sm-2 control-label">跳转链接</label>
    <div class="col-sm-8">
      <input type="text" class="form-control" id="url" value="${model.url }" name="url" placeholder="点击图片跳转链接">
    </div>
  </div>
  <div class="form-group">
    <label for="priority" class="col-sm-2 control-label">排序号</label>
    <div class="col-sm-8">
      <input type="text" class="form-control" id="priority" value="${model.priority }" name="priority" placeholder="排序号，越大排名越前">
    </div>
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