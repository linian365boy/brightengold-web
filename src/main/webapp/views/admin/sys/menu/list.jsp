<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/views/commons/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>资源管理</title>
<script type="text/javascript">
	var update = function(id){
		var url = '${ctx}admin/sys/menu/'+id+'/update.html';
		art.dialog.open(url,{
			title:'编辑菜单',
			id:'bianji',
			width:450,
			height:300,
			resize: false
			});
		};
		
		var tianjia = function(){
			var url = "${ctx}/admin/sys/menu/add.html";
			art.dialog.open(url,{
				title:'添加菜单',
				id:'tianjia',
				width: 450,
				height: 330,
				resize: false
			});
		};
		var deleteMenu = function(id){
			art.dialog.confirm('确定删除此菜单？',function(){
				var url = '${ctx}admin/sys/menu/'+id+'/del.html';
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
		<h3 class="tabs_involved">资源列表</h3>
		<ul class="tabs">
   			<li><a href="javascript:void(0);" onclick="tianjia();">新增资源</a></li>
		</ul>
		</header>

		<div class="tab_container">
			<div id="tab1" class="tab_content">
			<table class="tablesorter table table-striped" cellspacing="0"> 
			<thead> 
				<tr> 
    				<th >序号</th>
                	<th >资源名称</th>
	                <th >别名</th>
	                <th >父级资源</th>
					<th >跳转路径</th>
					<th >排序号</th>
					<th >操作</th>
				</tr> 
			</thead> 
			<tbody id="dataContent"> 
			<c:choose>
				<c:when test="${!(empty page.result) and (page.totalRowNum>0) }">
					<c:forEach items="${page.result }" var="menu" varStatus="status">
					<tr>
						<td>${(page.currentPageIndex-1)*page.pageSize+status.index+1 }</td>
						<td>${menu.name }</td>
						<td>${menu.mark }</td>
						<td>${menu.parentMenuName }</td>
						<td>${menu.url }</td>
						<td>${menu.priority }</td>
						<td>
							<input type="image" onclick="update('${menu.id }');" 
									src="${ctx }resources/images/icn_edit.png" title="编辑"/>&nbsp;&nbsp;
							<input type="image" onclick="deleteMenu('${menu.id }');"
									src="${ctx }resources/images/icn_trash.png" title="删除"/>
						</td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr class="text-center"><td colspan="6">暂无数据</td></tr>
			</c:otherwise>
			</c:choose>
			</tbody> 
			<tfoot>
				<tr>
                <td colspan="12">
                	<div class="pagination">
                		<c:import url="/views/admin/commons/page.jsp">
                			<c:param name="url" value="admin/sys/menu/menus"/>
                		</c:import>
                	</div>
                  <!-- <div class="clear"></div></td> -->
              </tr>
			</tfoot>
			</table>
			</div><!-- end of #tab1 -->
		</div><!-- end of .tab_container -->
		</article><!-- end of content manager article -->
	</section>
</body>
</html>