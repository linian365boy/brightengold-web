<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="../../../commons/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品编辑</title>
<%@include file="/views/admin/commons/jsCss.jsp" %>
 <%@include file="/views/admin/commons/listJsCss.jsp" %>
<link href="${ctx }resources/js/skins/blue.css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }resources/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.metadata.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#form").validate({
		rules:{
			"enName":{
				required:true
			},
			"photo":{
				required:true
			},
			"category":{
				required:true
			}
		},
		messages:{
			"enName":{
				required:"标题不能为空！"
			},
			"photo":{
				required:"优先值为数字！"
			},
			"category":{
				required:"内容不能为空！"
			}
		}
	});
});
</script>
</head>
<body>
<jsp:include page="/views/admin/commons/header.jsp"/>
	<jsp:include page="/views/admin/commons/left.jsp">
		<jsp:param value="6" name="menuId"/>
		<jsp:param value="商品管理" name="menuName"/>
		<jsp:param value="编辑商品" name="menuSubName"/>
	</jsp:include>
	<section id="main" class="column">
		<article class="module width_full">
		<header>
		<h3 class="tabs_involved">编辑商品</h3>
		</header>
		<div class="tab_container">
		<div id="tab1" class="tab_content">
	<form id="form" action="${ctx }goods/product/${model.id }/update" method="post" enctype="multipart/form-data">
            <div id="label"><label for="enName">商品名称：</label></div>
            <input id="enName" value="${model.enName }" name="enName" type="text"/>
             <br />
             <div id="label"><label for="introduce">商品介绍：</label></div>
            <textarea rows="3" cols="100" name="introduce">${model.introduce }</textarea>
             <br />
            <div id="label"><label for="photo">商品图片： </label></div>
            <img alt="${model.enName }" title="${model.enName }" src="${ctx }resources/${model.picUrl}" >
            <input type="file" name="photo" title="点击更换商品图片"/>
             <br />
            <div id="label"><label for="parents">商品分类：</label></div>
            <select name="parents" id="parents" style="width: 158px;margin-left: 0px;margin-bottom: 5px;">
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
            <div id="label"><label for="hot">是否热门：</label></div>
            <input name="hot" id="hot" type="checkbox"
            	<c:choose>
			 		<c:when test="${model.hot }">
			 			checked="checked"
			 		</c:when>
			 	</c:choose>
            />
            <span>（勾选表示热门，否则非热门商品）</span>
             <br />
             <input type="hidden" name="id" value="${model.id }"/>
            <div class="aui_buttons" style="width:388px;">
              <button class="aui_state_highlight" type="submit">提交</button>
              <button type="reset">重置</button>
            </div>
          </form>
          </div>
          </div>
          </article>
          </section>
</body>
</html>