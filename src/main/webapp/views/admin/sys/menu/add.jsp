<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="/views/commons/include.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>资源添加</title>
<link href="${ctx }resources/js/skins/blue.css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.metadata.js"></script>
<link href="${ctx }resources/css/bootstrap.min.css" rel="stylesheet"/>
<link rel="stylesheet" type="text/css" href="${ctx }resources/css/style.css" />
	<script type="text/javascript">
	$(document).ready(function(){
		$("#form").validate({
			rules:{
				"name":{
					required:true
				},
				"mark":{
					required:true
				},
				"url":{
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
				"mark":{
					required:"别名不能为空"
				},
				"url":{
					required:"跳转路径不能为空"
				},
				"priority":{
					number:"排序号为数字！"
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
	<form id="form" action="${ctx }admin/sys/menu/add.html" class="form-horizontal" method="post" target="_parent">
             <div class="form-group">
		    	<label for="name" class="col-sm-3 control-label">名称<span class="asterisk">*</span></label>
				<div class="row col-sm-8">
				     <input type="text" class="form-control" id="name" name="name" placeholder="菜单名称">
				</div>
			</div>
			 <div class="form-group">
		    	<label for="mark" class="col-sm-3 control-label">别名<span class="asterisk">*</span></label>
				<div class="row col-sm-8">
				     <input type="text" class="form-control" id="mark" name="mark" placeholder="菜单别名">
				</div>
			</div>
			<div class="form-group">
		    <label for="parentM" class="col-sm-3 control-label">父级菜单</label>
		    	<div class="row col-xs-8" style="overflow:hidden;">
		    		<select class="col-xs-7 selectpicker" name="parentM" id="parentM">
		    		<c:forEach items="${parentMenu }" var="menu">
		    			<option value="${menu[0] }">${menu[1] }</option>
		    		</c:forEach>
			      	</select>
		    	</div>
		  </div>
		  <div class="form-group">
		    	<label for="url" class="col-sm-3 control-label">跳转路径<span class="asterisk">*</span></label>
				<div class="row col-sm-8">
				     <input type="text" class="form-control" id="url" name="url" placeholder="跳转路径">
				</div>
			</div>
			<div class="form-group">
		    	<label for="priority" class="col-sm-3 control-label">排序号</label>
				<div class="row col-sm-8">
				     <input type="text" class="form-control" id="priority" name="priority" placeholder="排序号">
				</div>
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