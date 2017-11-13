<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="/views/commons/include.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>栏目编辑</title>
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
	$.getJSON("${ctx}/admin/sys/col/getParentByAjax/1",function(returnJson){
		var json = $(returnJson);
		var str = "";
		var checkId = "${model.parentId }";
		for(var i=0;i<json.length;i++){
			str+="<option value='"+json.get(i).id+"'";
			if(checkId==json.get(i).id){
				str+=" selected "
			}
			str+=">"+json.get(i).name+"</option>";
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
					url:'${ctx}/admin/sys/col/existCol',
					data:{
						ycode:function(){
							return "${model.code}";
						}
					}
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
	<form class="form-horizontal content" id="form" method="post" target="_parent" 
		action="${ctx}/admin/sys/col/${model.id}/update">
  <div class="form-group">
    <label for="parentColumn" class="col-sm-2 control-label">父级栏目</label>
    <div class="col-xs-8">
	      <select class="col-xs-5 selectpicker" name="parentId" id="parentColumn">
	      </select>
    </div>
  </div>
  <div class="form-group">
    <label for="name" class="col-sm-2 control-label">中文名称<code>*</code></label>
    <div class="col-sm-8">
      <input type="text" class="form-control" id="name" value="${model.name }" name="name" placeholder="名称">
    </div>
  </div>
  <div class="form-group">
    <label for="enName" class="col-sm-2 control-label">英文名称<code>*</code></label>
    <div class="col-sm-8">
      <input type="text" class="form-control" id="enName" value="${model.enName }" name="enName" placeholder="名称">
    </div>
  </div>
  <div class="form-group">
    <label for="code" class="col-sm-2 control-label">代码<code>*</code></label>
    <div class="col-sm-8">
      <input type="text" class="form-control" id="code" value="${model.code }" name="code" placeholder="栏目代码">
    </div>
  </div>
  <div class="form-group">
    <label for="priority" class="col-sm-2 control-label">排序号</label>
    <div class="col-sm-8">
      <input type="text" class="form-control" id="priority" value="${model.priority }" name="priority" placeholder="排序号，越大排名越前">
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
  <input type="hidden" name="id" value="${model.id }"/>
</form>
</body>
</html>