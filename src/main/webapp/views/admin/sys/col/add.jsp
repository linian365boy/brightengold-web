<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="/views/commons/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品分类新增</title>
<link href="${ctx }resources/js/skins/blue.css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }resources/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.metadata.js"></script>
<link href="${ctx }resources/css/bootstrap.min.css" rel="stylesheet"/>
	<script type="text/javascript">
	$(document).ready(function(){
		$.getJSON("${ctx}admin/sys/col/getParentByAjax/1.html",function(returnJson){
			var json = $(returnJson);
			var str = "";
			for(var i=0;i<json.length;i++){
				str+="<option value="+json.get(i)[0]+">"+json.get(i)[1]+"</option>";
			}
			$("#parentColumn").append(str);
		});
		
		$("#form").validate({
			rules:{
				"name":{
					required:true,
					remote:{
						type:'POST',
						url:'${ctx}admin/sys/col/existCol.html',
						data:{
							enName:function(){
								return $("#name").val();
							}
						}
					}
				}
			},
			messages:{
				"enName":{
					required:"商品分类不能为空",
					remote:"该商品分类已存在，请更换！"
				}
			}
		});
	});
	</script>
</head>
<body>
	<form class="form-horizontal">
	<!--
  <div class="form-group">
    <label for="parentColumn" class="col-sm-2 control-label">父级栏目</label>
     <div class="col-sm-3">
      <select class="form-control" class="col-sm-3" name="parentColumn.id" id="parentColumn">
      </select>
    </div> 
  </div>-->
  <div class="form-group">
    <label for="name" class="col-sm-2 control-label">名称</label>
    <div class="col-sm-3">
      <input type="text" class="form-control" id="name" name="name" placeholder="名称">
    </div>
  </div>
  <div class="form-group">
    <label for="code" class="col-sm-2 control-label">代码</label>
    <div class="col-sm-3">
      <input type="text" class="form-control" id="code" name="code" placeholder="栏目代码">
    </div>
  </div>
  <div class="form-group">
    <label for="priority" class="col-sm-2 control-label">排序号</label>
    <div class="col-sm-5">
      <input type="text" class="form-control" id="priority" name="priority" placeholder="排序号">
    </div>
  </div>
  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-5">
      <button type="submit" class="btn btn-default">Sign in</button>
    </div>
  </div>
</form>
</body>
</html>