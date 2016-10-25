<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/views/commons/include.jsp" %>
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
					<th >名称</th>
					<th >代码</th>
					<th >排序号</th>
					<th >操作</th>
				</tr> 
                </thead>
                <tbody>
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