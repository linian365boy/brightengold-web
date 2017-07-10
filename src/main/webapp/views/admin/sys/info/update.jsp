<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/views/commons/include.jsp"%>
<title>信息编辑</title>
<script type="text/javascript"
	src="${ctx}/resources/plugins/ckeditor/ckeditor.js"></script>
<script type="text/javascript"
	src="${ctx}/resources/plugins/ckeditor/lang/zh-cn.js"></script>
<script type="text/javascript"
	src="/resources/plugins/jQueryValidate/jquery.validate.js"></script>
<script type="text/javascript"
	src="/resources/plugins/jQueryValidate/jquery.metadata.js"></script>
<link rel="stylesheet" type="text/css"
	href="/resources/dist/css/customUse.css" />
<script type="text/javascript">
$(document).ready(function(){
				$("#form").validate({
							rules : {
								"name" : {
									required : true
								},
								"code" : {
									required : true
								},
								"priority" : {
									number : true
								}
							},
							messages : {
								"name" : {
									required : "名称不能为空"
								},
								"code" : {
									required : "代码不能为空"
								},
								"priority" : {
									number : "请输入数字！"
								}
							},
							highlight : function(element) {
								jQuery(element).closest('.form-group')
										.removeClass('has-success').addClass(
												'has-error');
							},
							success : function(element) {
								jQuery(element).closest('.form-group')
										.removeClass('has-error');
							},
							submitHandler: function(form){
								CKEDITOR.instances.content.updateElement();
								$(form).ajaxSubmit({
									dataType:'json',
									success:function(json) {
							    		if(json.code==200){
							    			$("ul.treeview-menu.menu-open li.active a").click();
							    		}else{
							    			$(".box-header .error").removeClass("hide").html(json.message);
							    		}
							        }
								});
							}
							
			});
			CKEDITOR.replace('content');	
	});
</script>

<section class="content-header">
	<h1>
		信息管理 <small>更轻松管理您的信息页面</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="${ctx}/admin/index"><i
				class="fa fa-dashboard"></i> 主页</a></li>
		<li><a href="#">系统管理</a></li>
		<li class="active">信息管理</li>
	</ol>
</section>

<section class="content">
	<div class="row">
		<div class="col-md-12">
			<div class="box box-info">
				<div class="box-header with-border">
					<h3 class="box-title">编辑信息</h3>
					<label class="error hide"></label>
				</div>
				<!-- /.box-header -->
				<!-- form start -->
				<form class="form-horizontal content" id="form" method="post"
					target="_parent"
					action="${ctx}/admin/sys/info/${model.id }/update">
					<div class="box-body">
						<div class="form-group">
							<label for="name" class="col-sm-2 control-label">名称<code>*</code></label>
							<div class="col-sm-8">
								<input type="text" class="form-control" id="name"
									value="${model.name }" name="name" placeholder="名称">
							</div>
						</div>
						<div class="form-group">
							<label for="code" class="col-sm-2 control-label">代码<code>*</code></label>
							<div class="col-sm-8">
								<input type="text" class="form-control" id="code"
									value="${model.code }" name="code" placeholder="代码">
							</div>
						</div>
						<div class="form-group">
							<label for="priority" class="col-sm-2 control-label">排序号</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" id="priority"
									value="${model.priority }" name="priority"
									placeholder="排序号，越大排名越前">
							</div>
						</div>
						<div class="form-group">
							<label for="content" class="col-sm-2 control-label">信息内容<code>*</code></label>
							<div class="col-sm-8">
								<textarea id="content" rows="16" name="content"
									class="form-control ckeditor">${model.content }</textarea>
							</div>
						</div>
					</div>
					<div class="box-footer">
						<button class="btn btn-default" type="reset">重置</button>
						<button class="btn btn-info pull-right" type="submit">保存</button>
					</div>
					<input type="hidden" name="id" value="${model.id }" />
				</form>
			</div>
		</div>
	</div>
</section>
