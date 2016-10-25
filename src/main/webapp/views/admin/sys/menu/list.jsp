<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/views/commons/include.jsp" %>
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
                	<th >资源名称</th>
	                <th >别名</th>
	                <th >父级资源</th>
					<th >跳转路径</th>
					<th >排序号</th>
					<th >操作</th>
				</tr> 
                </thead>
                <tbody>
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
