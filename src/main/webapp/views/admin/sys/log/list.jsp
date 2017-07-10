<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/views/commons/include.jsp" %>
    <script type="text/javascript">
	<!--
	$("#table").bootstrapTable();
	//-->
	</script>
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        	日志管理
        <small>更轻松管理您的操作日志</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="${ctx}/admin/index"><i class="fa fa-dashboard"></i> 主页</a></li>
        <li><a href="#">系统管理</a></li>
        <li class="active">日志管理</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-header">
              <h3 class="box-title">日志列表</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <table id="table" data-toggle="table" class="table table-striped" data-search="true" data-show-refresh="true" 
              data-show-columns="true" 
              data-show-export="true" 
              data-show-pagination-switch="true" 
              data-pagination="true" 
              data-id-field="id" 
              data-page-list="[10, 25, 50]" 
              data-show-footer="false" 
              data-side-pagination="server" data-url="${ctx}/${ajaxListUrl}">
                <thead>
                <tr> 
    				<th data-formatter="runningFormatter">序号</th>
	                <th data-field="type">操作</th>
	                <th data-field="operatorRealName">操作员</th>
	                <th data-field="createTime">操作日期</th>
	                <th data-field="content">内容</th>
				</tr> 
                </thead>
                <%-- <tbody>
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
                </tbody> --%>
              </table>
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
      </div>
      <!-- /.row -->
    </section>
    <!-- /.content -->
