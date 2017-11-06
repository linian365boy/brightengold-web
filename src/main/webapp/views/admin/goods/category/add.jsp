<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="/views/commons/include.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品分类新增</title>
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
		$.getJSON("${ctx}/admin/goods/category/getParentByAjax/1",function(returnJson){
			var json = $(returnJson);
			var str = "";
			for(var i=0;i<json.length;i++){
				str+="<option value="+json.get(i).id+">"+json.get(i).enName+"</option>";
			}
			$("#parentCs").append(str);
		});
		
		$("#form").validate({
			rules:{
				"name":{
					required:true
				},
				"enName":{
					required:true,
					remote:{
						type:'POST',
						url:'${ctx}/admin/goods/category/existCategory',
						data:{
							enName:function(){
								return $("#enName").val();
							}
						}
					}
				}
			},
			messages:{
				"name":{
					required:"商品分类不能为空"
				},
				"enName":{
					required:"商品分类不能为空",
					remote:"该商品分类已存在，请更换！"
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
	
	function changeCol(obj){
		var colId = $(obj).val();
		$.post("${ctx }/admin/sys/col/getChildren/"+colId+"",{
			id:colId
		},function(json){
			$(obj).next().remove();
			var html = "";
			if(json.length>0){
				html+='<select class="col-xs-5 selectpicker" name="secondCol" >';
				html+="<option value='0'>==请选择==</option>";
				$.each(json,function(i,n){
					html+="<option value='"+n.id+"'>"+n.name+"</option>";
				});
				html+="</select>";
			}
			$(obj).after(html);
		},"json");
	};
	</script>
</head>
<body>
	<form id="form" class="form-horizontal content" action="${ctx }/admin/goods/category/add" 
		method="post" target="_parent">
			<div class="form-group">
			    <label for="parentCs" class="col-sm-2 control-label">所属栏目</label>
			    	<div class="col-xs-8" style="overflow:hidden;">
			    		<c:if test="${fn:length(parentCol)>0 }">
			    			<select class="col-xs-5 selectpicker" name="parentCol" onchange="changeCol(this);">
				    			<c:forEach items="${parentCol }" var="col">
				    				<option value="${col.id }">${col.name }</option>
				    			</c:forEach>
				      		</select>
			    		</c:if>
			    	</div>
			  </div>
             <div class="form-group">
			    <label for="parentCs" class="col-sm-2 control-label">父级分类</label>
				     <div class="col-sm-8" style="overflow:hidden;">
				      <select class="col-xs-5 selectpicker" name="parentC" id="parentCs">
				      </select>
				    </div> 
			  </div>
			  <div class="form-group">
			    <label for="name" class="col-sm-2 control-label">中文名称<code>*</code></label>
			    <div class="col-sm-8">
			      <input type="text" class="form-control" id="name" name="name" placeholder="名称">
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="enName" class="col-sm-2 control-label">英文名称<code>*</code></label>
			    <div class="col-sm-8">
			      <input type="text" class="form-control" id="enName" name="enName" placeholder="名称">
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="remark" class="col-sm-2 control-label">备注</label>
			    <div class="col-sm-8">
			      <input type="text" class="form-control" id="remark" name="remark" placeholder="备注">
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