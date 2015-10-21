<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../../commons/include.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" ></meta>
<title>华夏银行CPP即时查询系统</title>
<script type="text/javascript" src="${ctx}resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${ctx}resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx}resources/js/jquery.metadata.js"></script>
<link href="${ctx }resources/css/bootstrap.min.css" rel="stylesheet"></link>
<link rel="stylesheet" type="text/css" href="${ctx}resources/css/style.css" ></link>
<!--[if IE]>
<link rel="stylesheet" type="text/css" href="css/ie-sucks.css" />
<![endif]-->
<script type="text/javascript">
	$(function(){
		$("#form").validate({
			rules:{
				"desc":{
					required:true
				}
			},
			messages:{
				"desc":{
					required:"角色不能为空"
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
	
	function formSubmit(){
		var role = "${model.name }";
		$("#form").attr("action","${ctx}admin/sys/role/"+role+"/update");
		$("#form").submit();
	}
</script>
</head>
<body>
		<form id="form" class="form-horizontal" action="#" method="post" target="_parent">
			<div class="form-group">
		    	<label for="desc" class="col-sm-3 control-label">角色<span class="asterisk">*</span></label>
				<div class="row col-sm-8">
				     <input type="text" class="form-control" value="${model.desc }" id="desc" name="desc" placeholder="角色"></input>
				</div>
			</div>
            <input type="hidden" name="name" value="${model.name }"></input>
          	<div class="form-group">
			  <div class="col-sm-offset-4 col-sm-8">
			  	<button type="submit" class="btn btn-primary">保存</button>
			      <button class="btn btn-default" type="reset">重置</button>
			    </div>
			  </div>
          </form>
</body>
</html>
