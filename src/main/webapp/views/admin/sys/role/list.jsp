<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../../../commons/include.jsp" %>

<script type="text/javascript">

	var update = function(obj){
		var url = '${ctx}/admin/sys/role/'+obj.name+'/update';
		art.dialog.open(url,{
			title:'编辑角色信息',
			id:'bianji',
			width:768,
			height:260,
			resize: false
			});
		};
		
		var tianjia = function(){
			var url = "${ctx}/admin/sys/role/add";
			art.dialog.open(url,{
				title:'添加角色',
				id:'tianjia',
				width: 768,
				height: 260,
				resize: false
			});
		};
		
		var del = function(obj){
			art.dialog.confirm('确定删除此['+obj.describes+']角色？',function(){
				var url = '${ctx}/admin/sys/role/'+obj.name+'/del';
				$.post(url,function(json){
			    		if(json.code==200){
			    			$("button[name='refresh']",window.document).click();
			    		}else{
			    			art.dialog.tips(json.message, 1.5);
			    		}
				},"json");
			});
		};
		
		function qxfp(obj){
			$.get("${ctx}/admin/sys/role/"+obj.name+"/qxfp",function(data){
				$("div.content-wrapper").html(data);
			});
		}
		
		function view(obj){
			art.dialog.load("${ctx}/admin/sys/role/"+obj.name+"/viewResource", {
			    title: '查看权限',
			    width: 768,
			    id:'view',
				height: 250
			}, false);
		}
		
		function roleActionFormatter(value, row, index) {
		    return [
		        '<a class="label label-info edit" href="javascript:void(0)" title="修改">修改</a>',
				'<a class="label label-danger ml10 remove" href="javascript:void(0)" title="删除">删除</a>',
				'<a class="label label-info ml10 view" href="javascript:void(0)" title="查看权限">查看权限</a>',
				'<a class="label label-info ml10 distribution" href="javascript:void(0)" title="分配权限">分配权限</a>'
		    ].join('');
		}
		
		window.roleActionEvents = {
				    'click .edit': function (e, value, row, index) {
				    	update(row);
				    },
				    'click .remove': function (e, value, row, index) {
				    	del(row);
				    },
				    'click .view': function (e, value, row, index) {
				    	view(row);
				    },
				    'click .distribution': function (e, value, row, index) {
				    	qxfp(row);
				    }
		};
		
		$("#table").bootstrapTable();
</script>

<!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        	角色管理
        <small>更轻松管理您的权限信息</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="${ctx}/admin/index"><i class="fa fa-dashboard"></i> 主页</a></li>
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
            	<div id="toolbar">
			        <button class="btn btn-block btn-primary" onclick="tianjia();">
			            <i class="glyphicon glyphicon-plus icon-plus"></i> 新增
			        </button>
			    </div>
              <table id="table" data-toggle="table" 
              data-toolbar="#toolbar" class="table table-striped" data-search="true" data-show-refresh="true" 
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
					<th data-field="describes">角色</th>
					<th data-field="priority">排序号</th>
					<th data-field="createDate">创建日期</th>
					<th data-formatter="roleActionFormatter" data-events="roleActionEvents">操作</th>
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
						src="${ctx}/resources/images/icn_edit.png" title="修改"/>
						<input type="image" name="${role.name }" onclick="del(this);" 
						src="${ctx}/resources/images/icn_trash.png" title="删除"/>&nbsp;&nbsp;
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
