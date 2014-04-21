<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../../../commons/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <%@include file="/views/admin/commons/listJsCss.jsp" %>
 <%@include file="/views/admin/commons/jsCss.jsp" %>
 <script type="text/javascript" src="${ctx }resources/js/system.js"></script>
<title>商品分类管理</title>

<script type="text/javascript">

	var update = function(obj){
		var productId = $(obj).attr("name");
		location.href= '${ctx}admin/goods/product/'+productId+'/update';
	};
		
	var tianjia = function(){
		location.href="${ctx}admin/goods/product/add";
	};
		
	var del = function(obj){
		var productId = $(obj).attr("name");
		art.dialog.confirm('确定删除此商品',function(){
			var url = '${ctx}admin/goods/product/'+productId+'/del';
			window.location.href=url;
		});
	};
	
	var publish = function(obj){
		var productId = $(obj).attr("name");
		art.dialog.confirm('确定发布此商品',function(){
			var url = '${ctx}admin/goods/product/'+productId+'/publish';
			window.location.href=url;
		});
	}
	
		
</script>
</head>
<body>
	<jsp:include page="/views/admin/commons/header.jsp"/>
	<jsp:include page="/views/admin/commons/left.jsp">
		<jsp:param value="8" name="menuId"/>
		<jsp:param value="商品管理" name="menuName"/>
	</jsp:include>
	<section id="main" class="column">
	<jsp:include page="/views/admin/commons/message.jsp"/>
		<article class="module width_full">
		<header>
		<h3 class="tabs_involved">商品列表</h3>
		<ul class="tabs">
   			<li><a href="javascript:void(0);" onclick="tianjia();">新增商品</a></li>
		</ul>
		</header>

		<div class="tab_container">
			<div id="tab1" class="tab_content">
			<table class="tablesorter" cellspacing="0"> 
			<thead> 
				<tr> 
    				<th >序号</th>
    				<th >商品图片</th>
					<th >商品名称</th>
					<th >商品分类</th>
					<th >是否热门</th>
					<th >是否发布</th>
					<th >创建人</th>
					<th >操作</th>
				</tr> 
			</thead> 
			<tbody id="dataContent"> 
				<c:forEach items="${page.result }" var="product" varStatus="status">
				<tr>
					<td>${(pageNo*pageSize)+status.index+1 }</td>
					<td>
						<img src="${ctx }resources/${product.picUrl }" 
						title="${product.enName }" alt="${product.enName }" 
						name="picUrl" width="50" height="50"/>
					</td>
					<td><a href="${ctx }admin/goods/product/${product.id}" title="${ product.enName}">${product.enName }</a></td>
					<td>${product.category.enName }</td>
					<td>${product.hot?"<span class='label label-danger' title='热门'>热门</span>":"<span class='label label-primary' title='非热门'>非热门</span>" }</td>
					<td>${product.publish?"<span class='label label-info' title='发布'>发布</span>":"<span class='label label-default' title='未发布'>未发布</span>" }</td>
					<td>${product.createUser.realName }(${product.createUser.username })</td>
					<td>
						<input type="image" name="${product.id }" onclick="update(this);"
						src="${ctx }resources/images/icn_edit.png" title="修改"/>
						<input type="image" name="${product.id }" onclick="publish(this);" 
						src="${ctx }resources/images/icn_publish.png" title="发布"/>&nbsp;
						<input type="image" name="${product.id }" onclick="del(this);" 
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
                			<c:param name="url" value="admin/goods/product/products"/>
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