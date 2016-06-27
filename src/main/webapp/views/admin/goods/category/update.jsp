<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="../../../commons/include.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品分类编辑</title>
<script type="text/javascript" src="${ctx }resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.metadata.js"></script>
<link href="${ctx }resources/css/bootstrap.min.css" rel="stylesheet"/>
<link rel="stylesheet" type="text/css" href="${ctx }resources/css/style.css" />
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
						url:'${ctx}admin/goods/category/existCategory.html',
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
					required:"商品名称不能为空"
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
			}
	});
});
function formSubmit(){
	var categoryId = "${model.id}";
	$("#form").attr("action","${ctx}admin/goods/category/"+categoryId+"/update.html");
	$("#form").submit();
}

function changeCol(obj){
	var colId = $(obj).val();
	$.post("${ctx }admin/sys/col/getChildren/"+colId+".html",{
		id:colId
	},function(json){
		$(obj).next().remove();
		var html = "";
		if(json.length>0){
			html+='<select class="col-xs-5 selectpicker" name="secondCol" >';
			html+="<option value='0'>==请选择==</option>";
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
	<form id="form" class="form-horizontal" action="#" method="post" target="_parent">
			<div class="form-group">
			    <label for="parentCs" class="col-sm-3 control-label">所属栏目</label>
			    	<div class="row col-xs-8" style="overflow:hidden;">
			    		<c:if test="${fn:length(parentCol)>0 }">
			    			<select class="col-xs-5 selectpicker" name="parentCol" onchange="changeCol(this);">
				    			<c:forEach items="${parentCol }" var="col">
				    				<option value="${col[0] }" 
				    				<c:choose>
				    					<c:when test="${empty model.column.parentColumn }">
				    						<c:if test="${col[0] eq model.column.id }">
					            				selected="selected"
					            			</c:if>
				    					</c:when>
				    					<c:otherwise>
				    						<c:if test="${col[0] eq model.column.parentColumn.id }">
					            				selected="selected"
					            			</c:if>
				    					</c:otherwise>
				    				</c:choose>
			            			>${col[1] }</option>
				    			</c:forEach>
				      		</select>
				      		<c:if test="${!(empty model.column.parentColumn) }">
				      			<select class="col-xs-5 selectpicker" name="secondCol" >
				      				<option value='0'>==请选择==</option>
				      				<c:forEach items="${model.column.parentColumn.childColumn }" var="column">
				      					<option value="${column.id }" 
				      					<c:if test="${column.id eq model.column.id }">
					            				selected="selected"
					            			</c:if>
				      					>${column.name }</option>
				      				</c:forEach>
				      			</select>
				      		</c:if>
			    		</c:if>
			    	</div>
			  </div>
            <div class="form-group">
			    <label for="pName" class="col-sm-3 control-label">父级栏目</label>
				     <div class="row col-sm-8" style="overflow:hidden;">
				      <select class="col-xs-5 selectpicker" name="parents" id="parents">
				      	<c:forEach items="${parents }" var="parent">
			            	<option value="${parent[0] }"
			            			<c:if test="${parent[0] eq model.parent.id }">
			            				selected="selected"
			            			</c:if>
			            		>
			            			${parent[1] }
			            		</option>
			            </c:forEach>
				      </select>
				    </div> 
			  </div>
			  <div class="form-group">
			    <label for="name" class="col-sm-3 control-label">中文名称<span class="asterisk">*</span></label>
			    <div class="row col-sm-8">
			      <input type="text" class="form-control" id="name" value="${model.name }" name="name" placeholder="名称">
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="enName" class="col-sm-3 control-label">英文名称<span class="asterisk">*</span></label>
			    <div class="row col-sm-8">
			      <input type="text" class="form-control" id="enName" value="${model.enName }" name="enName" placeholder="名称">
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="remark" class="col-sm-3 control-label">备注</label>
			    <div class="row col-sm-8">
			      <input type="text" class="form-control" id="remark" value="${model.remark }" name="remark" placeholder="备注">
			    </div>
			  </div>
            <input type="hidden" name="id" value="${model.id }"/>
            <div class="form-group">
			  <div class="col-sm-offset-4 col-sm-8">
			  	<button type="submit" class="btn btn-primary">保存</button>
			      <button class="btn btn-default" type="reset">重置</button>
			    </div>
			  </div>
          </form>
</body>
</html>