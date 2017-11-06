<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../../commons/include.jsp" %>
<!DOCTYPE html >
<html>
<head>
<!-- jQuery 2.2.3 -->
<script src="/resources/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- jQuery form plugin -->
<script src="/resources/plugins/jQueryForm/jquery.form.min.js"></script>
<script type="text/javascript" src="/resources/plugins/jQueryValidate/jquery.validate.js"></script>
<script type="text/javascript" src="/resources/plugins/jQueryValidate/jquery.metadata.js"></script>
<script type="text/javascript" src="/resources/plugins/jQueryValidate/additional-methods.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="/resources/dist/css/AdminLTE.min.css">
<link rel="stylesheet" type="text/css" href="/resources/dist/css/customUse.css" />
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
			},
			submitHandler: function(form){
				$(form).ajaxSubmit({
					dataType:'json',
					success:function(json) {
			    		if(json.code==200){
			    			$("button[name='refresh']",top.document).click();
			    			top.art.dialog.list['bianji'].close();
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
	<form class="form-horizontal content" id="form" method="post" 
	enctype="multipart/form-data" action="${ctx }/admin/ad/${model.id }/update" target="_parent">
  <div class="form-group">
    <label for="name" class="col-sm-2 control-label">名称<code>*</code></label>
    <div class="col-sm-8">
      <input type="text" class="form-control" id="name" value="${model.name }" name="name" placeholder="名称">
    </div>
  </div>
  <div class="form-group">
    <label for="photo" class="col-sm-2 control-label">图片<code>*</code></label>
    <div class="col-sm-8">
    	<img alt="" src="${applicationScope.staticAccessPath }/${model.picUrl}" width="107px" height="50px"/>
      <input type="file" id="photo" name="photo" placeholder="图片">
    </div>
  </div>
  <div class="form-group">
    <label for="width" class="col-sm-2 control-label">宽度<code>*</code></label>
    <div class="col-sm-8">
      <input type="text" class="form-control" value="${model.width }" id="width" name="width" placeholder="宽度（单位：像素）">
    </div>
  </div>
  <div class="form-group">
    <label for="height" class="col-sm-2 control-label">高度<code>*</code></label>
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