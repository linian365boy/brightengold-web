<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="../../commons/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>留言详情</title>
</head>
<body>
	<form id="form" action="..." method="post">
			<div id="label"><label for="name">姓名：</label>
            	<input type="text"  disabled="disabled" id="inputyc" value="${model.name }"/>
            </div>
			<div id="label"> <label for="email">邮箱：</label>
				<input type="text" disabled="disabled" id="inputyc" value="${model.email }"/>
			</div>
			<div id="label"> <label for="content">内容：</label>
				<textarea disabled="disabled" id="inputyc" rows="10" cols="40">${model.content }</textarea>
			</div>
			<div id="label"> <label for="createTime">反馈时间：</label>
				<input type="text" disabled="disabled" id="inputyc" value="<fmt:formatDate value="${model.createTime }" type="both"/>"/>
			</div>
		</form>
</body>
</html>