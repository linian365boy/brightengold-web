<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../../../commons/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <%@include file="/views/admin/commons/listJsCss.jsp" %>
 <%@include file="/views/admin/commons/jsCss.jsp" %>
<title>日志管理</title>
</head>
<body>
	<section id="main" class="column">
		<article class="module width_full">
		<header>
		<h3 class="tabs_involved">日志列表</h3>
		</header>

		<div class="tab_container">
			<div id="tab1" class="tab_content">
			<table class="tablesorter table table-striped" cellspacing="0"> 
			<thead> 
				<tr> 
    				<th width="10%">序号</th>
	                <th width="16%">操作</th>
	                <th width="12%">操作员</th>
	                <th width="16%">模块</th>
	                <th width="16%">操作日期</th>
	                <th width="30%">内容</th>
				</tr> 
			</thead> 
			<tbody id="dataContent">
				<c:choose>
					<c:when test="${!(empty page.result) and (page.totalRowNum>0) }">
						<c:forEach items="${page.result }" var="log" varStatus="status">
							<tr>
								<td>${(page.currentPageIndex-1)*page.pageSize+status.index+1 }</td>
								<td>${log.type }</td>
								<td title="员工号：${log.operator }&nbsp;&nbsp;姓名：${log.operatorRealName}">
									${log.operatorRealName }
								</td>
								<td>${log.menu.name }</td>
								<td>
									<fmt:formatDate value="${log.createTime }" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td>${log.content }</td>
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
                			<c:param name="url" value="sys/log/logs"/>
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