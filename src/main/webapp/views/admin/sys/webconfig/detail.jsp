<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="/views/commons/include.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }resources/js/skins/blue.css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.metadata.js"></script>
<script type="text/javascript" src="${ctx }resources/js/ckEditor/ckeditor.js"></script>
<script type="text/javascript" src="${ctx }resources/js/ckEditor/lang/zh-cn.js"></script>
<link href="${ctx }resources/css/bootstrap.min.css" rel="stylesheet"/>
<link href="${ctx }resources/css/style.css" rel="stylesheet"/>
<title>网站信息</title>
</head>
<body>
	<section id="main" class="column">
	<jsp:include page="/views/admin/commons/message.jsp"/>
		<article class="module width_full">
		<header>
		<h3 class="tabs_involved">网站设置</h3>
		</header>
		<div class="tab_container">
		<div id="tab1" class="tab_content">
	<form id="form" action="${ctx }admin/sys/webconfig/update.html" method="post" 
	enctype="multipart/form-data" class="form-horizontal">
			<div class="form-group">
			    <label for="name" class="col-sm-2 control-label">网站关键字</label>
			    <div class="col-sm-8">
			      <input type="text" class="form-control" id="kws" value="${model.kws }" name="kws" placeholder="网站关键字">
			    </div>
		   </div>
		   <div class="form-group">
		   		<label for="content" class="col-sm-1 control-label">网站底部</label>
			    <div class="col-sm-9">
			      <textarea id="content" rows="16" name="content" class="form-control ckeditor"></textarea>
			    </div>
		   </div>
            <input type="hidden" name="id" value="${model.id }"/>
            <div class="form-group">
		    <div class="col-sm-offset-4 col-sm-8">
		      <button type="submit" class="btn btn-primary">保存</button>
		    </div>
		  </div>
          </form>
          </div>
          </div>
          </article>
          </section>
</body>
</html>