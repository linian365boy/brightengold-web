<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="../../../commons/include.jsp" %>
<!DOCTYPE >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <%@include file="/views/admin/commons/listJsCss.jsp" %>
<%@include file="/views/admin/commons/jsCss.jsp" %>
<title>公司信息</title>
<link href="${ctx }resources/js/skins/blue.css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }resources/js/jquery-1.11.1.min.js"></script>
</head>
<body>
	<jsp:include page="/views/admin/commons/header.jsp"/>
	<jsp:include page="/views/admin/commons/left.jsp">
		<jsp:param value="5" name="menuId"/>
		<jsp:param value="公司管理" name="menuName"/>
	</jsp:include>
	<section id="main" class="column">
	<jsp:include page="/views/admin/commons/message.jsp"/>
		<article class="module width_full">
		<header>
		<h3 class="tabs_involved">公司详情</h3>
		</header>
		<div class="tab_container">
		<div id="tab1" class="tab_content">
	<form id="form" action="${ctx }sys/company/update" method="post" enctype="multipart/form-data">
            <div id="label"><label for="name" style="padding-left: 10px;">公司名称：</label>
	            <input id="name" name="name" value="${model.name }" style="width:450px;" type="text"
	                        tabindex="1"/>
             </div>
             <br/>
            <div id="label"><label for="logo" style="padding-left: 10px;">公司logo：</label>
            <img src="${ctx }resources/${model.logo }" 
            	title="公司logo" alt="公司logo" width="390px" height="130px" 
            	name="logoPic" />
            <input type="file" name="photos" title="点击更换公司logo"/>
            </div>
            <br/>
            <div id="label"><label for="logo" style="padding-left: 10px;">热线图片：</label>
            <img src="${ctx }resources/${model.phonePic }" 
            	title="热线图片" alt="热线图片" width="307px" height="130px" 
            	name="phoneUrl" />
            <input type="file" name="photos" title="点击更换热线图片"/>
            </div>
            <br/>
            <div id="label"><label for="slogan" style="padding-left: 10px;">公司口号：</label>
            	<textarea rows="4" cols="" style="width:450px;" id="slogan" name="slogan">${model.slogan }</textarea>
            </div>
            <br/>
			<div id="label"><label for="introduce" style="padding-left: 10px;">公司介绍：</label>
            	<textarea rows="4" cols="" style="width:450px;" id="introduce" name="introduce">${model.introduce }</textarea>
			</div>
			<br/>
            <div id="label"><label for="introduce" style="padding-left: 10px;">公司创建日期：</label>
            <input id="introduce" name="introduce" value="${model.createDate }"/>
            </div>
            <br/>
            <div id="label"><label for="address" style="padding-left: 10px;">公司地址：</label>
            <input id="introduce" name="address" value="${model.address }"/>
            </div>
            <br/>
            <div id="label"><label for="email" style="padding-left: 10px;">公司邮箱：</label>
            <input id="introduce" name="email" value="${model.email }"/>
            </div>
            <br/>
            <div id="label"><label for="telPhone" style="padding-left: 10px;">联系方式：</label>
            <input id="introduce" name="telPhone" value="${model.telPhone }"/>
            </div>
            <br/>
            <div id="label"><label for="website" style="padding-left: 10px;">公司网址：</label>
            <input id="introduce" name="website" value="${model.website }"/>
            </div>
            <br/>
            <input type="hidden" name="id" value="${model.id }"/>
            <button name="submit" class="btn btn-primary" type="submit">确定</button>
          </form>
          </div>
          </div>
          </article>
          </section>
</body>
</html>