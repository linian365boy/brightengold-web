<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="../../../commons/include.jsp" %>
<script type="text/javascript">
	function genneratePage(){
		var code = $("#code").val();
		if(code!=''){
			$.ajax({
				   type: "POST",
				   url: "${ctx}/admin/sys/html/"+code+"/generate",
				   beforeSend: function(){
					   art.dialog({
						   id:'beforeTips',
						   content:'<img src="${ctx}/resources/js/skins/icons/loading.gif"/>正在生成中...',
						   lock:true
					   });
				   },
				   success: function(text){
					   art.dialog.list['beforeTips'].close();
					   if("200"==text){
							art.dialog({
								id:'tips',
								title:'页面生成成功',
								content:'页面生成成功',
								icon:'face-smile'
							});
						}else if("501"==text){
							art.dialog({
								id:'tips',
								title:'提示',
								content:'页面代码不存在',
								icon:'face-sad'
							});
						}else{
							art.dialog({
								id:'tips',
								title:'页面生成失败',
								content:'页面生成失败',
								icon:'face-sad'
							});
						}
				   }
			});
		}else{
			art.dialog.alert("栏目代码不能为空！");
		}
	}
	
	function gennerateAllPage(){
			$.ajax({
				   type: "POST",
				   url: "${ctx}/admin/sys/html/generateAll",
				   beforeSend: function(){
					   art.dialog({
						   id:'gennerateAllPageTips',
						   content:'<img src="${ctx}/resources/js/skins/icons/loading.gif"/>正在生成中...',
						   lock:true
					   });
				   },
				   success: function(text){
					   art.dialog.list['gennerateAllPageTips'].close();
					   if("200"==text){
							art.dialog({
								id:'tips',
								title:'页面生成成功',
								content:'页面生成成功',
								icon:'face-smile'
							});
						}else if("501"==text){
							art.dialog({
								id:'tips',
								title:'提示',
								content:'页面代码不存在',
								icon:'face-sad'
							});
						}else{
							art.dialog({
								id:'tips',
								title:'页面生成失败',
								content:'页面生成失败',
								icon:'face-sad'
							});
						}
				   }
			});
	}
</script>
<!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        	静态页面生成管理
        <small>更轻松管理您的网站</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="${ctx}/admin/index"><i class="fa fa-dashboard"></i> 主页</a></li>
        <li><a href="#">页面生成管理</a></li>
        <li class="active">静态页面生成</li>
      </ol>
    </section>
    
    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-header with-border text-center">
              <h3 class="box-title pull-left">在这，你可以动态生成您网站的访问页面</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
            	<div class="pad margin no-print">
			      <div class="callout callout-info" style="margin-bottom: 0!important;">
			        <h4>注意：</h4>
			  		<p class="text-left">1．生成首页请使用"index"或"home"代码</p>
			  		<p class="text-left">2．生成商品分类页请使用分类英文名称</p>
			  		<p class="text-left">3．栏目代码与分类英文名称相同时，优先生成栏目页面，不生成分类页面</p>
			  		<p class="text-left">4．栏目代码与信息代码大小写一致时，才能准确生成信息页面</p>
			      </div>
			    </div>
			    <div class="pad margin no-print">
              	<form class="form-inline">
					  <div class="form-group">
					  	<div class="col-xs-7">
					    <input type="text" class="form-control" placeholder="栏目代码" id="code" name="code">
					    </div>
					  </div>
					  <button type="button" onclick="genneratePage();" class="btn btn-danger">生成页面</button>
					  <button type="button" onclick="gennerateAllPage();" class="btn btn-danger pull-right">一键生成所有页面</button>
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
    
	<%-- <section id="main" class="column">
	<jsp:include page="/views/admin/commons/message.jsp"/>
		<article class="module width_full">
		<header>
		<h3 class="tabs_involved">生成管理</h3>
		</header>
		<div class="tab_container">
		<div id="tab1" class="tab_content mb180">
			<form class="form-inline">
			  <div class="form-group">
			  	<div class="col-xs-7">
			    <input type="text" class="form-control" placeholder="栏目代码" id="code" name="code">
			    </div>
			  </div>
			  <button type="button" onclick="genneratePage();" class="btn btn-danger">生成页面</button>
			</form>
			<div class="form-group mt20">
			  	<div class="text-info col-xs-7">
			  		<p class="text-left">注意：</p>
			  		<p class="text-left">1．生成首页请使用"index"或"home"代码</p>
			  		<p class="text-left">2．生成商品分类页请使用分类英文名称</p>
			  		<p class="text-left">3．栏目代码与分类英文名称相同时，优先生成栏目页面，不生成分类页面</p>
			  		<p class="text-left">4．栏目代码与信息代码大小写一致时，才能准确生成信息页面</p>
			  		<p class="text-left"><button type="button" onclick="gennerateAllPage();" class="btn btn-danger">一键生成所有页面</button></p>
				</div>
			</div>
		</div>
		</div>
		</article>
	</section> --%>
