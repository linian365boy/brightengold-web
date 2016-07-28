<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="../../../commons/include.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品编辑</title>
<script type="text/javascript" src="${ctx }resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${ctx }resources/js/ckEditor/ckeditor.js"></script>
<script type="text/javascript" src="${ctx }resources/js/ckEditor/lang/zh-cn.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.metadata.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.equalHeight.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx }resources/css/style.css" />
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
	$("#form").validate({
		rules:{
			"enName":{
				required:true
			},
			"category":{
				required:true
			},
			"description":{
				required:true
			}
		},
		messages:{
			"enName":{
				required:"标题不能为空！"
			},
			"category":{
				required:"分类不能为空！"
			},
			"description":{
				required:"详情不能为空！"
			}
		}
	});
});
	function changeCol(obj){
		var cateId = $(obj).val();
		var currentCateId = "${model.category.id}";
		$.post("${ctx }admin/goods/category/getChildrenCate/"+cateId+".html",{
			parentCateId:cateId
		},function(json){
			$(obj).next().remove();
			var html = "";
			if(json && json.length>0){
				html+='<select class="col-xs-5 selectpicker" name="childrenC" >';
				html+="<option value='0'>==请选择==</option>";
				$.each(json,function(i,n){
					html+="<option value='"+n[0]+"' >"+n[1]+"</option>";
				});
				html+="</select>";
			}
			$(obj).after(html);
		},"json");
	};
</script>
</head>
<body>
	<section id="main" class="column">
		<article class="module width_full">
		<header>
		<h3 class="tabs_involved">编辑商品</h3>
		</header>
		<div class="tab_container">
		<div id="tab1" class="tab_content">
	<form id="form" class="form-horizontal"
	 action="${ctx }admin/goods/product/${model.id }/update.html" method="post" enctype="multipart/form-data">
	 <div class="form-group">
			    <label for="enName" class="col-sm-1 control-label">商品名称<span class="asterisk">*</span></label>
			    <div class="col-sm-8">
			      <input type="text" class="form-control" value="${model.enName }" id="enName" name="enName" placeholder="商品名称">
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="introduce" class="col-sm-1 control-label">商品简介</label>
			    <div class="col-sm-8">
			      <textarea class="form-control" rows="3" name="introduce" id="introduce">${model.introduce }</textarea>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="photo" class="col-sm-1 control-label">商品图片<span class="asterisk">*</span></label>
			    <div class="col-sm-8">
			    <img alt="${model.enName }" width="100px" height="100px" title="${model.enName }" src="${ctx }resources/${model.picUrl}" >
			      <input type="file" name="photo" id="photo"/>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="parents" class="col-sm-1 control-label">商品分类<span class="asterisk">*</span></label>
			    <div class="col-sm-8">
			    <c:set value="${model.category.parent }" var="parentCate" scope="page"/>
	            <c:choose>
	             	<c:when test="${empty parentCate }">
	             	<!-- 一级分类 -->
				      <select name="parents" id="parents" class="col-xs-5 selectpicker" onchange="changeCol(this);">
					      <c:forEach items="${parents }" var="parent">
		            			<option value="${parent[0] }"
		            				<c:if test="${parent[0] eq model.category.id }">
			            				selected="selected"
			            			</c:if>
			            			>
		            			${parent[1] }
		            			</option>
		            		</c:forEach>
	            		</select>
	            		<select class="col-xs-5 selectpicker" name="childrenC">
	           				<option value='0'>==请选择==</option>
	           				<c:forEach items="${model.category.children }" var="childrenC">
		      					<option value="${childrenC.id }" >${childrenC.enName }</option>
		      				</c:forEach>
	           			</select>
	             	</c:when>
	            	<c:otherwise>
	            	<!-- 二级分类 -->
	            		<select name="parents" id="parents" class="col-xs-5 selectpicker" onchange="changeCol(this);">
					      <c:forEach items="${parents }" var="parent">
		            			<option value="${parent[0] }"
		            				<c:if test="${parent[0] eq parentCate.id }">
			            				selected="selected"
			            			</c:if>
			            			>
		            			${parent[1] }
		            			</option>
		            		</c:forEach>
	            		</select>
	            		<select class="col-xs-5 selectpicker" name="childrenC">
	           				<option value='0'>==请选择==</option>
	           				<c:forEach items="${model.category.parent.children }" var="childrenCate">
		      					<option value="${childrenCate.id }" 
		      					<c:if test="${childrenCate.id eq model.category.id }">
		      						selected="selected"
		      					</c:if>
		      					>${childrenCate.enName }</option>
		      				</c:forEach>
	           			</select>
	            	</c:otherwise>
	            </c:choose>
			    </div>
			  </div>
			  <div class="form-group">
			  	<div class="col-sm-offset-1 col-sm-8">
				  <div class="checkbox">
				  	<label>
				      <input type="checkbox" name="hot" <c:choose>
			 		<c:when test="${model.hot }">
			 			checked="checked"
			 		</c:when>
			 	</c:choose>/> 是否热门（勾选表示热门，否则非热门商品）
				    </label>
				  </div>
				  </div>
			  </div>
			  <div class="form-group">
			    <label for="keyWords" class="col-sm-1 control-label">关键字</label>
			    <div class="col-sm-8">
			      <input type="text" class="form-control" id="keyWords" value="${model.keyWords }" name="keyWords" placeholder="商品关键字(以英文分号隔开不同的关键字)">
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="description" class="col-sm-1 control-label">产品详情<span class="asterisk">*</span></label>
			    <div class="col-sm-9">
			      <textarea id="description" rows="16" name="description" class="form-control ckeditor">${model.description }</textarea>
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
          </div>
          </div>
          </article>
          </section>
</body>
</html>