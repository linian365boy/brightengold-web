<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@include file="../../../commons/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户详情</title>
</head>
<body>
		<form id="form" action="..." method="post">
			<div id="label"><label for="username">用户名：</label>
            	<input type="text"   disabled="disabled" id="inputyc" value="${model.username }"/>
            </div>
            <div id="label"><label for="realName">姓名：</label>
	            <input type="text" disabled="disabled" id="inputyc" value="${model.realName }"/>
            </div>
			<div id="label"> <label for="role">账户是否可用：</label>
				<c:choose>
					<c:when test="${model.enabled }">
						 <input type="text" disabled="disabled" id="inputyc" value="可用"/>
					</c:when>
					<c:otherwise>
						 <input type="text" disabled="disabled" id="inputyc" value="禁用"/>
					</c:otherwise>
				</c:choose>
			</div>
			<div id="label"> <label for="role">账户最近关闭日期：</label>
				<input type="text" id="inputyc" disabled="disabled"
				value="<fmt:formatDate value='${model.lastCloseDate}' type='date'/>"/>
			</div>
		</form>
</body>
</html>