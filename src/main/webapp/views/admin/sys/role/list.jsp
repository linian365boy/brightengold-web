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
		
		var roleResourceFormatter = function(value, row, index){
			return "";
		}
		
		$("#table").bootstrapTable();
</script>

<!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        	角色管理
        <small>更轻松管理您的权限信息</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="${ctx }admin/index.html"><i class="fa fa-dashboard"></i> 主页</a></li>
        <li><a href="#">系统管理</a></li>
        <li class="active">角色管理</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-header">
              <h3 class="box-title">角色列表</h3>
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
              data-side-pagination="server" data-url="${ctx }${ajaxListUrl}">
                <thead>
                <tr> 
    				<th data-formatter="runningFormatter">序号</th>
					<th data-field="desc">角色</th>
					<th data-field="roleResourceFormatter">权限</th>
					<th data-formatter="actionFormatter" data-events="actionEvents">操作</th>
				</tr> 
                </thead>
                <%-- <tbody>
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
