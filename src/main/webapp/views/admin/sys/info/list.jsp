<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/views/commons/include.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <script type="text/javascript" src="${ctx }resources/js/system.js"></script>
<title>信息管理</title>
<script type="text/javascript">
	var update = function(obj){
		var infoId = $(obj).attr("name");
		var url = '${ctx}admin/sys/info/'+infoId+'/update.html';
		window.location.href=url;
		};
		
		var tianjia = function(){
			var url = "${ctx}admin/sys/info/add.html";
			window.location.href=url;
		};
		
		var del = function(obj){
			var infoId = $(obj).attr("name");
			art.dialog.confirm('确定删除此信息？',function(){
				var url = '${ctx}admin/sys/info/'+infoId+'/delete.html';
				window.location.href=url;
			});
		};
		
		var setPublish = function(obj){
			var infoId = $(obj).attr("name");
			art.dialog.confirm('确定删除此信息？',function(){
				var url = '${ctx}admin/sys/info/'+infoId+'/publishContent.html';
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
		<h3 class="tabs_involved">信息列表</h3>
		<ul class="tabs">
   			<li><a href="javascript:void(0);" onclick="tianjia();">新增信息</a></li>
		</ul>
		</header>
		<div class="tab_container">
			<div id="tab1" class="tab_content">
			<table class="tablesorter"> 
			<thead> 
				<tr> 
    				<th >序号</th>
					<th >名称</th>
					<th >代码</th>
					<th >排序号</th>
					<th >操作</th>
				</tr> 
			</thead> 
			<tbody id="dataContent">
				<c:choose>
				<c:when test="${!(empty page.result) and (page.totalRowNum>0) }">
				<c:forEach items="${page.result }" var="info" varStatus="status">
				<tr>
					<td>${(page.currentPageIndex-1)*page.pageSize+status.index+1 }</td>
					<td title="${info.name }">${info.name }</td>
					<td>${info.code }</td>
					<td>${info.priority }</td>
					<td>
						<input type="image" name="${info.id }" data-toggle="tooltip" data-placement="top" onclick="update(this);"
						src="${ctx }resources/images/icn_edit.png" title="修改"/>&nbsp;
						<input type="image" name="${info.id }" data-toggle="tool1tip" data-placement="top" onclick="del(this);" 
						src="${ctx }resources/images/icn_trash.png" title="删除"/>&nbsp;&nbsp;
					</td>
				</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr class="text-center"><td colspan="5">暂无数据</td></tr>
			</c:otherwise>
			</c:choose>
				</tbody> 
			<tfoot>
				<tr>
                <td colspan="5">
                	<div class="pagination">
                		<c:import url="/views/admin/commons/page.jsp">
                			<c:param name="url" value="admin/sys/info"/>
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