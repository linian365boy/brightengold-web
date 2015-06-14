<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../../commons/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <%@include file="/views/admin/commons/listJsCss.jsp" %>
 <%@include file="/views/admin/commons/jsCss.jsp" %>
<title>新闻管理</title>
<script type="text/javascript">
	var tianjia = function(){
		var url = "${ctx}admin/ad/save.html";
		art.dialog.open(url,{
			title:'添加滚动图片',
			id:'tianjia',
			width: 550,
			height: 440,
			resize: false
		});
	};
	var update = function(obj){
		var newsId = $(obj).attr("name");
		var url = '${ctx}admin/ad/'+newsId+'/update.html';
		art.dialog.open(url,{
			title:'添加滚动图片',
			id:'tianjia',
			width: 550,
			height: 440,
			resize: false
		});
	};
	//del
	var del = function(obj){
		var newsId = $(obj).attr("name");
		art.dialog.confirm('确定删除此新闻？',function(){
			var url = '${ctx}admin/ad/'+newsId+'/delete.html';
			window.location.href=url;
		});
	};
	var changeStatus = function(id,objstatus){
		var statusStr = "正常";
		if(objstatus==0){
			statusStr = "锁定";
		}
		art.dialog.confirm("确定修改为"+statusStr+"状态？",function(){
			var url = '${ctx}admin/ad/'+id+'/updateStatus.html';
			$.getJSON(url,{'status':objstatus},function(json){
				if(json.code==200){
					art.dialog.alert(json.message);
				}
			});
		});
	};
</script>
</head>
<body>
	<section id="main" class="column">
	<jsp:include page="/views/admin/commons/message.jsp"/>
		<article class="module width_full">
		<header>
		<h3 class="tabs_involved">首页滚动图片列表</h3>
		<ul class="tabs">
   			<li><a href="javascript:void(0);" onclick="tianjia();">新增首页滚动图片</a></li>
		</ul>
		</header>

		<div class="tab_container">
			<div id="tab1" class="tab_content">
			<table class="tablesorter" cellspacing="0"> 
			<thead> 
				<tr> 
    				<th >序号</th>
    				<th >图片</th>
					<th >图片名称</th>
					<th >跳转路径</th>
					<th >宽度</th>
					<th >高度</th>
					<th >排序号</th>
					<th >状态</th>
					<th >操作</th>
				</tr>
			</thead> 
			<tbody id="dataContent"> 
				<c:forEach items="${page.result }" var="ad" varStatus="status">
				<tr>
					<td>${(page.currentPageIndex-1)*page.pageSize+status.index+1 }</td>
					<td><img title="${ad.name }" alt="${ad.name }"
					 src="${ctx }resources/${ ad.picUrl}" width="107px" height="50px"/></td>
					<td>${ad.name }</td>
					<td>${ ad.url}</td>
					<td>${ ad.width}</td>
					<td>${ ad.height}</td>
					<td>${ ad.priority}</td>
					<td>
						<c:choose>
							<c:when test="${ad.status eq 1}">
								<span title="正常" onclick="changeStatus('${ad.id}','0');" class="label btn label-success">正常</span>
							</c:when>
							<c:otherwise>
								<span title="锁定" onclick="changeStatus('${ad.id}','1');" class="label btn label-danger">锁定</span>
							</c:otherwise>
						</c:choose>
					</td>
					<td>
						<input type="image" name="${ad.id }" onclick="update(this);"
						src="${ctx }resources/images/icn_edit.png" title="修改"/>&nbsp;
						<input type="image" name="${ad.id }" onclick="del(this);" 
						src="${ctx }resources/images/icn_trash.png" title="删除"/>&nbsp;
					</td>
				</tr>
				</c:forEach>
				</tbody> 
			<tfoot>
				<tr>
                <td colspan="12">
                	<div class="pagination">
                		<c:import url="/views/admin/commons/page.jsp">
                			<c:param name="url" value="admin/ad/ads"/>
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