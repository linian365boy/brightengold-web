<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/views/commons/include.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <script type="text/javascript" src="${ctx }resources/js/system.js"></script>
<title>栏目分类管理</title>
<script type="text/javascript">
	var update = function(obj){
		var categoryId = $(obj).attr("name");
		var url = '${ctx}admin/sys/col/'+categoryId+'/update.html';
		art.dialog.open(url,{
			title:'编辑分类信息',
			id:'bianji',
			width:550,
			height:340,
			resize: false
			});
		};
		
		var tianjia = function(){
			var url = "${ctx}admin/sys/col/add.html";
			art.dialog.open(url,{
				title:'添加栏目类别',
				id:'tianjia',
				width: 550,
				height: 340,
				resize: false
			});
		};
		
		var del = function(obj){
			var categoryId = $(obj).attr("name");
			art.dialog.confirm('确定删除此栏目？',function(){
				var url = '${ctx}admin/sys/col/'+categoryId+'/delete.html';
				$.getJSON(url,function(json){
					art.dialog.alert(json.message,function(){
						if(json.code==200){
							$("#searchForm").submit();
						}
					});
				});
			});
		};
		var setPublish = function(obj){
			var categoryId = $(obj).attr("name");
			art.dialog.open("${ctx}admin/sys/col/"+categoryId+"/setPublishContent.html",{
				title:'发布内容设置',
				id:'setPublish',
				width: 550,
				height: 300,
				resize: false
			});
		};
		$(function(){
			 $('[data-toggle="tooltip"]').tooltip();
		});
</script>
</head>
<body>
	<section id="main" class="column">
	<jsp:include page="/views/admin/commons/message.jsp"/>
		<article class="module width_full">
		<form class="form-inline" id="searchForm">
		  <div class="form-group">
		    <label class="sr-only" for="exampleInputAmount">Amount (in dollars)</label>
		    <div class="input-group">
		      <div class="input-group-addon">关键字</div>
		      <input type="text" class="form-control" name="keyword" value="${param.keyword }" id="exampleInputAmount" placeholder="请输入关键字搜索">
		      <div class="input-group-addon"></div>
		    </div>
		  </div>
		  <button type="submit" class="btn btn-primary">搜索</button>
		</form>
		<header>
		<h3 class="tabs_involved">栏目分类列表</h3>
		<ul class="tabs">
   			<li><a href="javascript:void(0);" onclick="tianjia();">新增栏目</a></li>
		</ul>
		</header>
		<div class="tab_container">
			<div id="tab1" class="tab_content">
			<table class="tablesorter"> 
			<thead> 
				<tr> 
    				<th >序号</th>
					<th >栏目名称(英文)</th>
					<th >栏目代码</th>
					<th >父级栏目</th>
					<th >排序号</th>
					<th >操作</th>
				</tr> 
			</thead> 
			<tbody id="dataContent">
				<c:choose>
				<c:when test="${!(empty page.result) and (page.totalRowNum>0) }">
				<c:forEach items="${page.result }" var="column" varStatus="status">
				<tr>
					<td>${(page.currentPageIndex-1)*page.pageSize+status.index+1 }</td>
					<td title="${column.name }（${column.enName }）">${column.name }（${column.enName }）</td>
					<td>${column.code }</td>
					<td>${empty column.parentColumn?"————":column.parentColumn.name }</td>
					<td>${column.priority }</td>
					<td>
						<input type="image" name="${column.id }" data-toggle="tooltip" data-placement="top" onclick="update(this);"
						src="${ctx }resources/images/icn_edit.png" title="修改"/>&nbsp;
						<input type="image" name="${column.id }" onclick="setPublish(this);" 
						src="${ctx }resources/images/icn_publish.png" data-toggle="tooltip" data-placement="top" 
						title="发布设置（当前使用
						<c:choose>
							<c:when test="${column.type==1 }">
								产品列表
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${column.type==0 }">
										信息列表
									</c:when>
									<c:otherwise>
										文章标题
									</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>
						模式发布）．设置时，其子栏目也会一起设置"/>&nbsp;
						<input type="image" name="${column.id }" data-toggle="tool1tip" data-placement="top" onclick="del(this);" 
						src="${ctx }resources/images/icn_trash.png" title="删除"/>&nbsp;&nbsp;
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
                			<c:param name="url" value="admin/sys/col/cols"/>
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