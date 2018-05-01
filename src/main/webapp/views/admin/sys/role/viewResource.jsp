<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="/views/commons/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查看权限</title>
</head>
<body>
		<div class="col-xs-12">
         <!--  <p class="lead">Amount Due 2/22/2014</p> -->
          <div class="table-responsive">
            <table class="table">
              <tbody><tr>
                <th style="width:20%">角色名</th>
                <td>${roleDesc }</td>
              </tr>
              <tr>
                <th>权限</th>
                <td>
                <ul class="select2-selection__rendered">
                <c:forEach items="${resources }" var="res" >
					 <li class="select2-selection__choice" title="${res.descn }">${res.descn }</li>
                </c:forEach>
                </ul>
                </td>
              </tr>
            </tbody>
            </table>
          </div>
        </div>
</body>
</html>