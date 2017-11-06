<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@include file="/views/commons/include.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户详情</title>
</head>
<body>
	<div class="col-xs-12">
         <!--  <p class="lead">Amount Due 2/22/2014</p> -->
          <div class="table-responsive">
            <table class="table">
              <tbody><tr>
                <th style="width:20%">用户名</th>
                <td>${model.username }</td>
              </tr>
              <tr>
                <th>姓名</th>
                <td>${model.realName }</td>
              </tr>
              <tr>
                <th>账户是否可用</th>
                <td>
                	<c:choose>
						<c:when test="${model.enabled }">
							 可用
						</c:when>
						<c:otherwise>
							 禁用
						</c:otherwise>
					</c:choose>
				</td>
              </tr>
              <tr>
                <th>账户最近关闭日期</th>
                <td><fmt:formatDate value="${model.lastCloseDate }" type="both"/></td>
              </tr>
              <tr>
                <th>账户创建时间</th>
                <td><fmt:formatDate value="${model.createDate }" type="both"/></td>
              </tr>
            </tbody>
            </table>
          </div>
        </div>
</body>
</html>