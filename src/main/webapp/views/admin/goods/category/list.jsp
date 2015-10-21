<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../../../commons/include.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <script type="text/javascript" src="${ctx }resources/js/system.js?${style_v}"></script>
<title>商品分类管理</title>

<script type="text/javascript">
	var update = function(obj){
		var categoryId = $(obj).attr("name");
		var url = '${ctx}admin/goods/category/'+categoryId+'/update.html';
		art.dialog.open(url,{
			title:'编辑分类信息',
			id:'bianji',
			width:550,
			height:290,
			resize: false
			});
		};
		
		var tianjia = function(){
			var url = "${ctx}admin/goods/category/add.html";
			art.dialog.open(url,{
				title:'添加商品分类',
				id:'tianjia',
				width: 550,
				height: 290,
				resize: false
			});
		};
		
		var del = function(obj){
			var categoryId = $(obj).attr("name");
			art.dialog.confirm('确定删除此分类',function(){
				var url = '${ctx}admin/goods/category/'+categoryId+'/del.html';
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
		<h3 class="tabs_involved">商品分类列表<span style="color:red;">（*商品分类必须在二级栏目下，前台页面才起作用）</span></h3>
		<ul class="tabs">
   			<li><a href="javascript:void(0);" onclick="tianjia();">新增分类</a></li>
		</ul>
		</header>

		<div class="tab_container">
			<div id="tab1" class="tab_content">
			<table class="tablesorter" cellspacing="0"> 
			<thead> 
				<tr> 
    				<th >序号</th>
					<th >一级分类</th>
					<th >二级分类</th>
					<th >所在栏目</th>
					<th >操作</th>
				</tr> 
			</thead> 
			<tbody id="dataContent"> 
				<c:forEach items="${page.result }" var="category" varStatus="status">
				<tr>
					<td>${(page.currentPageIndex-1)*page.pageSize+status.index+1 }</td>
					<td>
						<c:choose>
							<c:when test="${!(empty category.parent) }">
								${category.parent.name }（${category.parent.enName }）
							</c:when>
							<c:otherwise>
								————
							</c:otherwise>
						</c:choose>
					</td>
					<td>${category.name }（${category.enName }）</td>
					<td>${category.column.name }（${category.column.enName }）</td>
					<td>
						<input type="image" name="${category.id }" onclick="update(this);"
						src="${ctx }resources/images/icn_edit.png" title="修改"/>
						<input type="image" name="${category.id }" onclick="del(this);" 
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
                			<c:param name="url" value="admin/goods/category/categorys"/>
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