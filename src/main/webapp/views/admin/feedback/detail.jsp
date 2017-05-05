<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="/views/commons/include.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>反馈留言详情</title>
</head>
<body>
		<div class="col-xs-12">
         <!--  <p class="lead">Amount Due 2/22/2014</p> -->
          <div class="table-responsive">
            <table class="table">
              <tbody><tr>
                <th style="width:20%">姓名</th>
                <td>${model.name }</td>
              </tr>
              <tr>
                <th>邮箱</th>
                <td>${model.email }</td>
              </tr>
              <tr>
                <th>内容</th>
                <td><textarea class="form-control" disabled="disabled" rows="5">${model.content }</textarea></td>
              </tr>
              <tr>
                <th>反馈时间</th>
                <td><fmt:formatDate value="${model.createTime }" type="both"/></td>
              </tr>
            </tbody></table>
          </div>
        </div>
</body>
</html>