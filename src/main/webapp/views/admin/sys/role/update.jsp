<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../../commons/include.jsp" %>
 <!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" ></meta>
<title>修改角色</title>
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
	$(function(){
		$("#form").validate({
			rules:{
				"describes":{
					required:true
				},
				"priority":{
					number:true
				}
			},
			messages:{
				"describes":{
					required:"角色不能为空"
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
		<form id="form" class="form-horizontal content" 
			action="${ctx}/admin/sys/role/${model.name }/update" method="post" target="_parent">
			<div class="form-group">
		    	<label for="describes" class="col-sm-2 control-label">角色<code>*</code></label>
				<div class="col-sm-8">
				     <input type="text" class="form-control" value="${model.describes }" id="describes" name="describes" placeholder="角色"></input>
				</div>
			</div>
			<div class="form-group">
		    	<label for="priority" class="col-sm-2 control-label">排序号<code>*</code></label>
				<div class="col-sm-8">
				     <input type="text" class="form-control" id="priority" name="priority" value="${model.priority }" placeholder="排序号越大，排名越前"></input>
				</div>
			</div>
            <input type="hidden" name="name" value="${model.name }"></input>
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
