<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/views/commons/include.jsp" %>
<script type="text/javascript">
	var update = function(obj){
		var url = '${ctx}/admin/sys/menu/'+obj.id+'/update';
		art.dialog.open(url,{
			title:'编辑菜单',
			id:'bianji',
			width:768,
			height:400,
			resize: false
			});
		};
		
		var tianjia = function(){
			var url = "${ctx}/admin/sys/menu/add";
			art.dialog.open(url,{
				title:'添加菜单',
				id:'tianjia',
				width: 768,
				height: 400,
				resize: false
			});
		};
		var del = function(obj){
			art.dialog.confirm('确定删除此【'+obj.name+'】菜单？',function(){
				var url = '${ctx}/admin/sys/menu/'+obj.id+'/del';
				$.post(url,function(json){
			    		if(json.code==200){
			    			$("button[name='refresh']",window.document).click();
			    		}else{
			    			art.dialog.tips(json.message, 1.5);
			    		}
				},"json");
			});
		};
		<!--
		$("#table").bootstrapTable();
		//-->
</script>
	
	<!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        	菜单管理
        <small>更轻松管理您的后台菜单信息</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="${ctx}/admin/index"><i class="fa fa-dashboard"></i> 主页</a></li>
        <li><a href="#">系统管理</a></li>
        <li class="active">菜单管理</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-header">
              <h3 class="box-title">菜单列表</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
            	<div id="toolbar">
			        <button class="btn btn-block btn-primary" onclick="tianjia();">
			            <i class="glyphicon glyphicon-plus icon-plus"></i> 新增
			        </button>
			    </div>
              <table id="table" data-toggle="table" data-toolbar="#toolbar" 
              class="table table-striped" data-search="true" data-show-refresh="true" 
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
                	<th data-field="name">资源名称</th>
	                <th data-field="mark">别名</th>
	                <th data-field="parentMenuName">父级菜单</th>
					<th data-field="url">跳转路径</th>
					<th data-field="priority">排序号</th>
					<th data-formatter="actionFormatter" data-events="actionEvents">操作</th>
				</tr> 
                </thead>
                <%-- <tbody>
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
									src="${ctx}/resources/images/icn_edit.png" title="编辑"/>&nbsp;&nbsp;
							<input type="image" onclick="deleteMenu('${menu.id }');"
									src="${ctx}/resources/images/icn_trash.png" title="删除"/>
						</td>
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
