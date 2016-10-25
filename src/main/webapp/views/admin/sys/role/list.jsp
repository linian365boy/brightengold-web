<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../../../commons/include.jsp" %>

<script type="text/javascript">

	var update = function(obj){
		var roleName = $(obj).attr("name");
		var url = '${ctx}admin/sys/role/'+roleName+'/update.html';
		art.dialog.open(url,{
			title:'编辑角色信息',
			id:'bianji',
			width:450,
			height:140,
			resize: false
			});
		};
		
		var tianjia = function(){
			var url = "${ctx}admin/sys/role/add.html";
			art.dialog.open(url,{
				title:'添加角色',
				id:'tianjia',
				width: 450,
				height: 140,
				resize: false
			});
		};
		
		var del = function(obj){
			var roleName = $(obj).attr("name");
			art.dialog.confirm('确定删除此角色？',function(){
				var url = '${ctx}admin/sys/role/'+roleName+'/del.html';
				window.location.href=url;
			});
		};
		
		function qxfp(){
			window.location.href = '${ctx}admin/sys/role/qxfp.html';
		}
		
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
					<th >角色</th>
					<th >权限</th>
					<th >操作</th>
				</tr> 
                </thead>
                <tbody>
                <c:choose>
				<c:when test="${!(empty page.result) and (page.totalRowNum>0) }">
				<c:forEach items="${page.result }" var="role" varStatus="status">
				<tr>
					<td>${(page.currentPageIndex-1)*page.pageSize+status.index+1 }</td>
					<td>${role.desc }</td>
					<td>
						<c:forEach items="${role.resources }" var="resource" varStatus="rowm">
							<span class="label label-primary" title="${resource.descn }">${resource.descn }
							</span>&nbsp;
              			</c:forEach>
					</td>
					<td>
						<input type="image" name="${role.name }" onclick="update(this);"
						src="${ctx }resources/images/icn_edit.png" title="修改"/>
						<input type="image" name="${role.name }" onclick="del(this);" 
						src="${ctx }resources/images/icn_trash.png" title="删除"/>&nbsp;&nbsp;
					</td>
				</tr>
			</c:forEach>
			</c:when>
			<c:otherwise>
				<tr class="text-center"><td colspan="4">暂无数据</td></tr>
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
