<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="/views/commons/include.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>资源添加</title>
<!-- jQuery 2.2.3 -->
<script src="/resources/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- jQuery form plugin -->
<script src="/resources/plugins/jQueryForm/jquery.form.min.js"></script>
<script type="text/javascript" src="/resources/plugins/jQueryValidate/jquery.validate.js"></script>
<script type="text/javascript" src="/resources/plugins/jQueryValidate/jquery.metadata.js"></script>
<!-- Bootstrap 3.3.6 -->
<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="/resources/dist/css/AdminLTE.min.css">
<link rel="stylesheet" type="text/css" href="/resources/dist/css/customUse.css" />
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
			},
			submitHandler: function(form){
				$(form).ajaxSubmit({
					dataType:'json',
					success:function(json) {
				    		if(json.code==200){
				    			$("button[name='refresh']",top.document).click();
				    			top.art.dialog.list['tianjia'].close();
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
	<form id="form" action="${ctx}/admin/sys/menu/add" class="form-horizontal content" method="post" target="_parent">
             <div class="form-group">
		    	<label for="name" class="col-sm-2 control-label">名称<code>*</code></label>
				<div class="row col-sm-8">
				     <input type="text" class="form-control" id="name" name="name" placeholder="菜单名称">
				</div>
			</div>
			 <div class="form-group">
		    	<label for="mark" class="col-sm-2 control-label">别名<code>*</code></label>
				<div class="row col-sm-8">
				     <input type="text" class="form-control" id="mark" name="mark" placeholder="菜单别名">
				</div>
			</div>
			<div class="form-group">
		    <label for="parentId" class="col-sm-2 control-label">父级菜单</label>
		    	<div class="row col-xs-8" style="overflow:hidden;">
		    		<select class="col-xs-5 selectpicker" name="parentId" id="parentId">
		    			<option value="0">==根节点==</option>
		    			<c:forEach items="${parentMenu }" var="menu">
		    				<option value="${menu.id }">${menu.name }</option>
		    			</c:forEach>
			      	</select>
		    	</div>
		  </div>
		  <div class="form-group">
		    	<label for="url" class="col-sm-2 control-label">跳转路径<code>*</code></label>
				<div class="row col-sm-8">
				     <input type="text" class="form-control" id="url" name="url" placeholder="跳转路径">
				</div>
			</div>
			<div class="form-group">
		    	<label for="priority" class="col-sm-2 control-label">排序号</label>
				<div class="row col-sm-8">
				     <input type="text" class="form-control" id="priority" name="priority" placeholder="排序号">
				</div>
			</div>
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