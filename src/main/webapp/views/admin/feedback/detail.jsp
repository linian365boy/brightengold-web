<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="../../commons/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>反馈留言详情</title>
</head>
<body>
	<%-- <form id="form" action="..." method="post">
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
		</form> --%>
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