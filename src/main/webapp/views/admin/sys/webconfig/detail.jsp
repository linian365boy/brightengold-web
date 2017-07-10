<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="/views/commons/include.jsp" %>
     <script type="text/javascript">
	$(document).ready(function(){
		$(form).ajaxForm({
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
	});
	</script>
     
	<!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        	网站设置
        <small>更轻松管理您的网站设置</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="${ctx}/admin/index"><i class="fa fa-dashboard"></i> 主页</a></li>
        <li><a href="#">系统管理</a></li>
        <li class="active">网站设置</li>
      </ol>
    </section>
    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-header with-border text-center">
              <h3 class="box-title pull-left">网站设置信息</h3>
              <label class="error hide"></label>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
	<form id="form" action="${ctx}/admin/sys/webconfig/update" method="post" class="form-horizontal">
			<div class="form-group">
			    <label for="keyword" class="col-sm-2 control-label">网站关键字</label>
			    <div class="col-sm-8">
			      <input type="text" class="form-control" id="keyword" value="${model.keyword }" name="keyword" placeholder="网站关键字">
			    </div>
		   </div>
		   <div class="form-group">
			    <label for="description" class="col-sm-2 control-label">网站描述信息</label>
			    <div class="col-sm-8">
			      <input type="text" class="form-control" id="description" value="${model.description }" name="description" placeholder="网站描述信息">
			    </div>
		   </div>
		   <!-- <div class="form-group">
		   		<label for="content" class="col-sm-1 control-label">网站底部</label>
			    <div class="col-sm-9">
			      <textarea id="content" rows="16" name="content" class="form-control ckeditor"></textarea>
			    </div>
		   </div> -->
            <div class="form-group">
		    <div class="col-sm-offset-4 col-sm-8">
		      <button type="submit" class="btn btn-primary">保存</button>
		    </div>
		  </div>
          </form>
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
