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
</head>
<body>
	<form class="form-horizontal" id="form" method="post" action="${ctx }admin/sys/col/${column.id }/setPublishContent.html" target="_parent">
		 <div class="form-group">
		    <label for="name" class="col-sm-2 control-label">中文名称</label>
		    <div class="col-sm-8">
		      <input type="text" class="form-control" value="${column.name }" disabled id="name">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="enName" class="col-sm-2 control-label">英文名称</label>
		    <div class="col-sm-8">
		      <input type="text" class="form-control" value="${column.enName }" disabled id="enName">
		    </div>
		  </div>
		   <div class="form-group">
		    <div class="col-sm-offset-2 col-sm-10">
		      <div class="checkbox">
		        <label>
		          <input type="checkbox" name="type" 
		          <c:if test="${column.type }">
		          	checked="checked"
		          </c:if>
		          >页面使用产品填充（默认使用标题填充）
		        </label>
		      </div>
		    </div>
		  </div>
	  <div class="form-group">
	    <div class="col-sm-offset-4 col-sm-8">
	      <button type="submit" class="btn btn-primary">保存</button>
	    </div>
	  </div>
	</form>
</body>
</html>