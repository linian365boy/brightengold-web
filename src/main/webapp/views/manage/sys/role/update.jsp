<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../../commons/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>华夏银行CPP即时查询系统</title>
<link href="${ctx}resources/js/skins/blue.css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx}resources/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="${ctx}resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx}resources/js/jquery.metadata.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx}resources/css/style.css" />
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
		<form id="form" action="#" method="post" target="_parent">
           <fieldset >
             <div id="label"><label for="desc">角色： </label></div>
            <input name="desc" id="desc" type="text"
                        tabindex="3" value="${model.desc }"/>
            <br />
            </fieldset>
            <input type="hidden" name="name" value="${model.name }"/>
          	<div class="aui_buttons">
            	 <button class=" aui_state_highlight" type="submit" onclick="formSubmit();">提交</button>
              	 <button type="reset">重置</button>
            </div>
          </form>
</body>
</html>
