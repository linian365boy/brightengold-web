<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../../../commons/include.jsp" %>
    
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        	反馈管理
        <small>更轻松管理您的反馈信息</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        <li><a href="#">反馈管理</a></li>
        <li class="active">反馈管理</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-header">
              <h3 class="box-title">反馈列表</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <table id="table" class="table table-hover table-striped">
                <thead>
                <tr> 
    				<th >序号</th>
	                <th >操作</th>
	                <th >操作员</th>
	                <!-- <th width="16%">模块</th> -->
	                <th >操作日期</th>
	                <th>内容</th>
				</tr> 
                </thead>
                <tbody>
                <c:choose>
					<c:when test="${!(empty page.result) and (page.totalRowNum>0) }">
						<c:forEach items="${page.result }" var="log" varStatus="status">
							<tr>
								<td>${(page.currentPageIndex-1)*page.pageSize+status.index+1 }</td>
								<td>${log.type }</td>
								<td title="员工号：${log.operator }&nbsp;&nbsp;姓名：${log.operatorRealName}">
									${log.operatorRealName }
								</td>
								<%-- <td>${log.menu.name }</td> --%>
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
