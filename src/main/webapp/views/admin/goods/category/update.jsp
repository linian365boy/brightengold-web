<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="/views/commons/include.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品分类编辑</title>
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
				"enName":{
					required:true,
					remote:{
						type:'POST',
						url:'${ctx}/admin/goods/category/existCategory',
						data:{
							en:function(){
								return "${model.enName}";
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
function formSubmit(){
	var categoryId = "${model.id}";
	$("#form").attr("action","${ctx}/admin/goods/category/"+categoryId+"/update");
	$("#form").submit();
}

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
}

</script>
</head>
<body>
	 <form id="form" class="form-horizontal content" action="#" method="post" target="_parent">
		<div class="box-body">
			 <div class="form-group">
			    <label for="parentCs" class="col-sm-2 control-label">所属栏目</label>
		    	<div class="col-sm-8" style="overflow:hidden;">
		    		<c:if test="${fn:length(parentCol)>0 }">
		    			<select class="col-xs-5 selectpicker" name="parentCol" onchange="changeCol(this);">
			    			<c:forEach items="${parentCol }" var="col">
			    				<option value="${col.id }" 
			    				<c:choose>
			    					<c:when test="${empty column.parentId }">
			    						<c:if test="${col.id eq column.id }">
				            				selected="selected"
				            			</c:if>
			    					</c:when>
			    					<c:otherwise>
			    						<c:if test="${col.id eq column.parentId }">
				            				selected="selected"
				            			</c:if>
			    					</c:otherwise>
			    				</c:choose>
		            			>${col.name }</option>
			    			</c:forEach>
			      		</select>
			      		<c:if test="${!(empty column.parentId) }">
			      			<select class="col-xs-5 selectpicker" name="secondCol" >
			      				<option value='0'>==请选择==</option>
			      				<c:forEach items="${parentColumn.childColumn }" var="ccolumn">
			      					<option value="${ccolumn.id }" 
			      					<c:if test="${ccolumn.id eq column.id }">
				            				selected="selected"
				            			</c:if>
			      					>${ccolumn.name }</option>
			      				</c:forEach>
			      			</select>
			      		</c:if>
		    		</c:if>
		    	</div>
			  </div>
            <div class="form-group">
			    <label for="pName" class="col-sm-2 control-label">父级分类</label>
			     <div class="col-sm-8" style="overflow:hidden;">
			      <select class="col-xs-5 selectpicker" name="parents" id="parents">
			      	<c:forEach items="${parents }" var="parent">
		            	<option value="${parent.id }"
		            			<c:if test="${parent.id eq model.parentId }">
		            				selected="selected"
		            			</c:if>
		            		>
		            			${parent.enName }
		            		</option>
		            </c:forEach>
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
			    <label for="remark" class="col-sm-2 control-label">备注</label>
			    <div class="col-sm-8">
			      <input type="text" class="form-control" id="remark" value="${model.remark }" name="remark" placeholder="备注">
			    </div>
			  </div>
            <input type="hidden" name="id" value="${model.id }"/>
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
			  </div>
          </form> 
</body>
</html>