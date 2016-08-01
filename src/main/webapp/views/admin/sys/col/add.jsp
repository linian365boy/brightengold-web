<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="/views/commons/include.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>栏目新增</title>
<script type="text/javascript" src="${ctx }resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.metadata.js"></script>
<link href="${ctx }resources/css/bootstrap.min.css" rel="stylesheet"/>
<link href="${ctx }resources/css/style.css" rel="stylesheet"/>
<style type="text/css">
	.selectpicker {
		background-color: #fff;
	    background-image: none;
	    border: 1px solid #ccc;
	    border-radius: 4px;
	    box-shadow: 0 1px 1px rgba(0, 0, 0, 0.075) inset;
	    color: #555;
	    display: block;
	    font-size: 14px;
	    height: 34px;
	    line-height: 1.42857;
	    padding: 6px 12px;
	    transition: border-color 0.15s ease-in-out 0s, box-shadow 0.15s ease-in-out 0s;
	    vertical-align: middle;
	}
</style>
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
				"enName":{
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
				"enName":{
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
	function changeCol(obj){
		var colId = $(obj).val();
		$.post("${ctx }admin/sys/col/getChildren/"+colId+".html",{
			id:colId
		},function(json){
			$(obj).next().remove();
			var html = "";
			if(json.length>0){
				html+='<select class="col-xs-6 selectpicker" name="secondColumnId" >';
				html+='<option value="">=请选择=</option>';
				$.each(json,function(i,n){
					html+="<option value='"+n[0]+"'>"+n[1]+"</option>";
				});
				html+="</select>";
			}
			$(obj).after(html);
		},"json");
	}
	</script>
</head>
<body>
	<form class="form-horizontal" id="form" method="post" action="${ctx }admin/sys/col/add.html" target="_parent">
  <div class="form-group">
    <label for="parentColumn" class="col-sm-3 control-label">父级栏目</label>
    <div class="row col-sm-8">
	     <div class="col-sm-10">
	      <select class="col-xs-6 selectpicker" name="firstColumnId" id="parentColumn" onchange="changeCol(this);">
	      </select>
	    </div> 
    </div>
  </div>
  <div class="form-group">
    <label for="name" class="col-sm-3 control-label">中文名称<span class="asterisk">*</span></label>
    <div class="col-sm-8">
      <input type="text" class="form-control" id="name" name="name" placeholder="名称">
    </div>
  </div>
  <div class="form-group">
    <label for="enName" class="col-sm-3 control-label">英文名称<span class="asterisk">*</span></label>
    <div class="col-sm-8">
      <input type="text" class="form-control" id="enName" name="enName" placeholder="名称">
    </div>
  </div>
  <div class="form-group">
    <label for="code" class="col-sm-3 control-label">代码<span class="asterisk">*</span></label>
    <div class="col-sm-8">
      <input type="text" class="form-control" id="code" name="code" placeholder="栏目代码">
    </div>
  </div>
  <div class="form-group">
    <label for="priority" class="col-sm-3 control-label">排序号</label>
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