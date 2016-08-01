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
<script type="text/javascript" src="${ctx }resources/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx }resources/js/ckEditor/ckeditor.js"></script>
<script type="text/javascript" src="${ctx }resources/js/ckEditor/lang/zh-cn.js"></script>
<link href="${ctx }resources/css/bootstrap.min.css" rel="stylesheet"/>
<link href="${ctx }resources/css/style.css" rel="stylesheet"/>
<title>公司信息</title>
<script type="text/javascript">
	$(document).ready(function(){
		$("#form").validate({
			rules:{
				"name":{
					required:true
				},
				"address":{
					required:true
				},
				"email":{
					required:true,
					email:true
				},
				"telPhone":{
					required:true
				}
			},
			messages:{
				"name":{
					required:"公司名称不能为空！"
				},
				"address":{
					required:"公司地址不能为空！"
				},
				"email":{
					required:"公司邮箱不能为空！",
					email:"邮箱格式不正确！"
				},
				"telPhone":{
					required:"联系方式不能为空！"
				}
			},
			highlight: function(element) {
			      jQuery(element).closest('.form-group').removeClass('has-success').addClass('has-error');
			},
			success: function(element) {
			      jQuery(element).closest('.form-group').removeClass('has-error');
			}
		});
	});
</script>
</head>
<body>
	<section id="main" class="column">
	<jsp:include page="/views/admin/commons/message.jsp"/>
		<article class="module width_full">
		<header>
		<h3 class="tabs_involved">公司详情</h3>
		</header>
		<div class="tab_container">
		<div id="tab1" class="tab_content">
	<form id="form" action="${ctx }admin/sys/company/update.html" method="post" 
	enctype="multipart/form-data" class="form-horizontal">
		<div class="form-group">
			    <label for="name" class="col-sm-2 control-label">公司名称<span class="asterisk">*</span></label>
			    <div class="col-sm-8">
			      <input type="text" class="form-control" id="name" value="${model.name }" name="name" placeholder="公司名称">
			    </div>
		   </div>
		   <div class="form-group">
			    <label for="logoPic" class="col-sm-2 control-label">公司logo<span class="asterisk">*</span></label>
			    <div class="col-sm-8">
			      <img src="${ctx }resources/${model.logo }" 
            	title="公司logo" alt="公司logo" width="390px" height="130px" 
            	name="logoPic" />
            	<input type="file" name="photos" title="点击更换公司logo" accept="image/*"/>
			    </div>
		   </div>
		   <div class="form-group">
			    <label for="slogan" class="col-sm-2 control-label">公司口号</label>
			    <div class="col-sm-8">
			      <input type="text" class="form-control" id="slogan" value="${model.slogan }" name="slogan" placeholder="公司口号">
			    </div>
		   </div>
		   <div class="form-group">
			    <label for="createDate" class="col-sm-2 control-label">公司创建日期</label>
			    <div class="col-sm-8">
			      <input id="createDate" class="form-control" name="createDate" 
			      class="Wdate" onfocus="WdatePicker({maxDate:'%y-%M-%d'})" value='<fmt:formatDate value="${model.createDate }" pattern="yyyy-MM-dd"/>'/>
			    </div>
		   </div>
		   <div class="form-group">
			    <label for="address" class="col-sm-2 control-label">公司地址<span class="asterisk">*</span></label>
			    <div class="col-sm-8">
			      <input id="address" class="form-control" name="address" value="${model.address }"/>
			    </div>
		   </div>
		   <div class="form-group">
			    <label for="email" class="col-sm-2 control-label">公司邮箱<span class="asterisk">*</span></label>
			    <div class="col-sm-8">
			      <input id="email" class="form-control" name="email" value="${model.email }"/>
			    </div>
		   </div>
		   <div class="form-group">
			    <label for="telPhone" class="col-sm-2 control-label">联系方式<span class="asterisk">*</span></label>
			    <div class="col-sm-8">
			      <input id="telPhone" class="form-control" name="telPhone" value="${model.telPhone }"/>
			    </div>
		   </div>
		   <div class="form-group">
			    <label for="website" class="col-sm-2 control-label">公司网址</label>
			    <div class="col-sm-8">
			      <input id="website" class="form-control" name="website" value="${model.website }"/>
			    </div>
		   </div>
		   <div class="form-group">
			    <label for="contactUser" class="col-sm-2 control-label">公司联系人</label>
			    <div class="col-sm-8">
			      <input id="website" class="form-control" name="contactUser" value="${model.contactUser }"/>
			    </div>
		   </div>
		   <div class="form-group">
			    <label for="contactUserFacebook" class="col-sm-2 control-label">联系人facebook</label>
			    <div class="col-sm-8">
			      <input id="contactUserFacebook" class="form-control" name="contactUserFacebook" value="${model.contactUserFacebook }"/>
			    </div>
		   </div>
		   <div class="form-group">
			    <label for="contactUserTwitter" class="col-sm-2 control-label">联系人Twitter</label>
			    <div class="col-sm-8">
			      <input id="contactUserTwitter" class="form-control" name="contactUserTwitter" value="${model.contactUserTwitter }"/>
			    </div>
		   </div>
		   <div class="form-group">
			    <label for="contactUsergooglePlus" class="col-sm-2 control-label">联系人Google+</label>
			    <div class="col-sm-8">
			      <input id="contactUsergooglePlus" class="form-control" name="contactUsergooglePlus" value="${model.contactUsergooglePlus }"/>
			    </div>
		   </div>
		   <div class="form-group">
			    <label for="introduce" class="col-sm-2 control-label">公司介绍</label>
			    <div class="col-sm-8">
			      <textarea rows="3" id="introduce" name="introduce" class="form-control ckeditor">${model.introduce }</textarea>
			    </div>
		   </div>
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