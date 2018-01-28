<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <div class="pull-right hidden-xs">
      <b>欢迎您使用本系统！</b>
    </div>
    <jsp:useBean id="now" class="java.util.Date" scope="page"/>
    <strong>Copyright © 2014-<fmt:formatDate value="${now}" pattern="yyyy" /> linian365boy@foxmail.com.</strong> All rights
    reserved.