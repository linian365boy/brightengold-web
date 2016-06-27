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
			    <div class="col-sm-4">
			      <select  name="parents" id="parents" class="form-control">
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