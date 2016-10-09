<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="../../../commons/include.jsp" %>
<!DOCTYPE >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>公司信息</title>
<script type="text/javascript">
	function genneratePage(){
		var code = $("#code").val();
		if(code!=''){
			$.ajax({
				   type: "POST",
				   url: "${ctx }admin/sys/html/"+code+"/generate.html",
				   beforeSend: function(){
					   art.dialog({
						   id:'beforeTips',
						   content:'<img src="${ctx }resources/js/skins/icons/loading.gif"/>正在生成中...',
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
				   url: "${ctx }admin/sys/html/generateAll.html",
				   beforeSend: function(){
					   art.dialog({
						   id:'gennerateAllPageTips',
						   content:'<img src="${ctx }resources/js/skins/icons/loading.gif"/>正在生成中...',
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

</head>
<body>
	<section id="main" class="column">
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
	</section>
</body>
</html>