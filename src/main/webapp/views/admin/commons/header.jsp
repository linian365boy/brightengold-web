<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/views/commons/include.jsp" %>
	<link href="${ctx }resources/js/skins/blue.css" rel="stylesheet"/>
	<script type="text/javascript" src="${ctx }resources/js/artDialog.js"></script>
	<script type="text/javascript" src="${ctx }resources/js/plugins/iframeTools.js"></script>
    <html>
    <head>
    <meta charset="utf-8"/>
	<title>header</title>
	<link rel="icon" href="${ctx }/resources/images/favicon.ico" type="image/x-icon">
	<link rel="shortcut icon" href="${ctx }/resources/images/favicon.ico" type="image/x-icon" />
    </head>
    <body>
	<header id="header">
		<hgroup>
			<h1 class="site_title"><a href="${ctx }admin">Brightengold</a></h1>
			<h2 class="section_title">Brightengold Management System</h2>
			<div class="btn_view_site"><a><sec:authentication property="principal.realName"/>(<sec:authentication property="principal.username"/>)&nbsp;</a></div>
			<a href="javascript:void(0);" onclick="modifyPass();" style="color:white;">修改密码</a>
			&nbsp;&nbsp;&nbsp;
			<a href="${ctx }admin/logout" style="color:white;">退出</a>
		</hgroup>
	</header> <!-- end of header bar -->
	<script type="text/javascript">
		function modifyPass(){
			art.dialog.load('${ctx}views/admin/sys/user/modifyPass.jsp',{
				title: '修改密码',
				id: 'modify',
				resize: false,
				ok:function(){
					var url = $("form").attr("action");
					$.ajax({
						type:'POST',
						url:url,
						data:$('#form').serialize(),
						success:function(res){
							var dialog = art.dialog({
										id:'xgmm',
										title:'提示消息'
									});
							dialog.content("<span style='color:red;'>"+res+"</span>").time(2);
						},
						error:function(res){
							art.dialog({
								title:'提示消息',
								content:'连接服务器失败!',
								time:3
							});
						}
					});
				},
				cancel:true
			},false);
		}
	</script>
	</body>
	</html>