<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/views/commons/include.jsp" %>
<script type="text/javascript" src="/resources/plugins/datetimepicker/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugins/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugins/ckeditor/lang/zh-cn.js"></script>
<script type="text/javascript" src="/resources/plugins/jQueryValidate/jquery.validate.js"></script>
<script type="text/javascript" src="/resources/plugins/jQueryValidate/jquery.metadata.js"></script>
<link rel="stylesheet" href="/resources/plugins/datetimepicker/bootstrap-datetimepicker.min.css"/>
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
			},
			submitHandler: function(form){
				CKEDITOR.instances.introduce.updateElement();
				$(form).ajaxSubmit({
					dataType:'json',
					success:function(json) {
			    		if(json.code==200){
			    			art.dialog.tips(json.message, 2);
			    			$("ul.treeview-menu.menu-open li.active a").click();
			    		}else{
			    			$(".box-header .error").removeClass("hide").html(json.message);
			    		}
			        }
				});
			}
		});
	    CKEDITOR.replace('introduce');
	});
	$('#createDate').datetimepicker({format: 'yyyy-mm-dd'});
</script>

	<!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        	公司管理
        <small>更轻松管理您的产品</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="${ctx}/admin/index"><i class="fa fa-dashboard"></i> 主页</a></li>
        <li><a href="#">系统管理</a></li>
        <li class="active">公司管理</li>
      </ol>
    </section>
    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-header with-border text-center">
              <h3 class="box-title pull-left">公司信息设置</h3>
              <label class="error hide"></label>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
		<div id="tab1" class="tab_content">
			<form id="form" action="${ctx}/admin/sys/company/update" method="post" 
			enctype="multipart/form-data" class="form-horizontal">
				<div class="form-group">
					    <label for="name" class="col-sm-2 control-label">公司名称<code>*</code></label>
					    <div class="col-sm-8">
					      <input type="text" class="form-control" id="name" value="${model.name }" name="name" placeholder="公司名称">
					    </div>
				   </div>
				   <div class="form-group">
					    <label for="photos" class="col-sm-2 control-label">公司logo<code>*</code></label>
					    <div class="col-sm-8">
					      <img src="${applicationScope.staticAccessPath }/${model.logo }" 
		            	title="公司logo" alt="公司logo" width="390px" height="130px" 
		            	name="logoPic" />
		            	<input type="file" id="photos" name="photos" title="点击更换公司logo" accept="image/*"/>
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
					      <input id="createDate" readonly class="form-control" name="createDate" 
					      value='<fmt:formatDate value="${model.createDate }" pattern="yyyy-MM-dd"/>'/>
					    </div>
				   </div>
				   <div class="form-group">
					    <label for="address" class="col-sm-2 control-label">公司地址<code>*</code></label>
					    <div class="col-sm-8">
					      <input id="address" class="form-control" name="address" value="${model.address }"/>
					    </div>
				   </div>
				   <div class="form-group">
					    <label for="email" class="col-sm-2 control-label">公司邮箱<code>*</code></label>
					    <div class="col-sm-8">
					      <input id="email" class="form-control" name="email" value="${model.email }"/>
					    </div>
				   </div>
				   <div class="form-group">
					    <label for="telPhone" class="col-sm-2 control-label">联系方式<code>*</code></label>
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
					    <label for="contactUserinstagram" class="col-sm-2 control-label">联系人Instagram</label>
					    <div class="col-sm-8">
					      <input id="contactUserinstagram" class="form-control" name="contactUserinstagram" value="${model.contactUserinstagram }"/>
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
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
      </div>
      <!-- /.row -->
    </section>
    <!-- /.content -->