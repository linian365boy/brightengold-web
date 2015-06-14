<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="/views/commons/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品分类新增</title>
<link href="${ctx }resources/js/skins/blue.css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.metadata.js"></script>
<link href="${ctx }resources/css/bootstrap.min.css" rel="stylesheet"/>
<link href="${ctx }resources/css/style.css" rel="stylesheet"/>
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
					required:true
				},
				"code":{
					required:true,
					remote:{
						type:'POST',
						url:'${ctx}admin/sys/col/existCol.html'
					}
				},
				"priority":{
					number:true
				}
			},
			messages:{
				"name":{
					required:"栏目名称不能为空"
				},
				"code":{
					required:"栏目代码不能为空",
					remote:"该栏目代码已存在，请更换！"
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
	<form class="form-horizontal" id="form" method="post" action="${ctx }admin/sys/col/add.html" target="_parent">
  <div class="form-group">
    <label for="parentColumn" class="col-sm-2 control-label">父级栏目</label>
     <div class="col-sm-8">
      <select class="form-control" name="parentColumn.id" id="parentColumn">
      </select>
    </div> 
  </div>
  <div class="form-group">
    <label for="name" class="col-sm-2 control-label">名称<span class="asterisk">*</span></label>
    <div class="col-sm-8">
      <input type="text" class="form-control" id="name" name="name" placeholder="名称">
    </div>
  </div>
  <div class="form-group">
    <label for="code" class="col-sm-2 control-label">代码<span class="asterisk">*</span></label>
    <div class="col-sm-8">
      <input type="text" class="form-control" id="code" name="code" placeholder="栏目代码">
    </div>
  </div>
  <div class="form-group">
    <label for="priority" class="col-sm-2 control-label">排序号</label>
    <div class="col-sm-8">
      <input type="text" class="form-control" id="priority" name="priority" placeholder="排序号，越大排名越前">
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