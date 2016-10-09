<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../../commons/include.jsp" %>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客户留言</title>
<script type="text/javascript">
	var detail = function(id){
		var myDialog = art.dialog({
			id:'detail',
			title:'留言详情',
			width:600,
			resize: false
		});
		jQuery.ajax({
			url:'${ctx}admin/feedback/'+id+'.html',
			type:'GET',
			success:function(data){
				myDialog.content(data);
			},
			error:function(data){
				myDialog.content("连接失败");
				myDialog.time(2.5);
			}
		});
	}
	
		var del = function(obj){
			var feedbackId = $(obj).attr("name");
			art.dialog.confirm('确定删除此留言?',function(){
				var url = '${ctx}admin/feedback/'+feedbackId+'/del.html';
				window.location.href=url;
			});
		};
		
</script>
</head>
<body>
	<section id="main" class="column">
	<jsp:include page="/views/admin/commons/message.jsp"/>
		<article class="module width_full">
		<header>
		<h3 class="tabs_involved">留言列表</h3>
		</header>

		<div class="tab_container">
			<div id="tab1" class="tab_content">
			<table class="tablesorter" cellspacing="0"> 
			<thead> 
				<tr> 
    				<th >序号</th>
					<th >姓名</th>
					<th >邮箱</th>
					<th >反馈时间</th>
					<th >操作</th>
				</tr> 
			</thead> 
			<tbody id="dataContent"> 
				<c:forEach items="${page.result }" var="feedback" varStatus="status">
				<tr>
					<td>${(page.currentPageIndex-1)*page.pageSize+status.index+1 }</td>
					<td>${feedback.name }</td>
					<td>${feedback.email }</td>
					<td><fmt:formatDate value="${feedback.createTime }" type="both"/></td>
					<td>
						<input type="image" name="details" onclick="detail(${feedback.id });"
						src="${ctx }resources/images/icn_alert_info.png" title="详情"/>
						<input type="image" name="${feedback.id }" onclick="del(this);" 
						src="${ctx }resources/images/icn_trash.png" title="删除"/>&nbsp;&nbsp;
					</td>
				</tr>
				</c:forEach>
				</tbody> 
			<tfoot>
				<tr>
                <td colspan="12">
                	<div class="pagination">
                		<c:import url="/views/admin/commons/page.jsp">
                			<c:param name="url" value="admin/feedback/"/>
                		</c:import>
                	</div>
              </tr>
			</tfoot>
			</table>
			</div><!-- end of #tab1 -->
		</div><!-- end of .tab_container -->
		</article><!-- end of content manager article -->
	</section>
</body>
</html>