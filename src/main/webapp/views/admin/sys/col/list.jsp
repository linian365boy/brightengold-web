<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/views/commons/include.jsp" %>
<script type="text/javascript">
	var update = function(obj){
		var url = '${ctx}/admin/sys/col/'+obj.id+'/update';
		art.dialog.open(url,{
			title:'编辑栏目信息',
			id:'bianji',
			width:768,
			height:360,
			resize: false
			});
		};
		
		var tianjia = function(){
			var url = "${ctx}/admin/sys/col/add";
			art.dialog.open(url,{
				title:'添加栏目类别',
				id:'tianjia',
				width: 768,
				height: 360,
				resize: false
			});
		};
		
		var del = function(obj){
			art.dialog.confirm('确定删除此['+obj.enName+']栏目？',function(){
				var url = '${ctx}/admin/sys/col/'+obj.id+'/delete';
				$.post(url,function(json){
		    		if(json.code==200){
		    			$("button[name='refresh']",window.document).click();
		    		}else{
		    			art.dialog.tips(json.message, 1.5);
		    		}
				},"json");
			});
		};
		var setPublishType = function(obj){
			art.dialog.open("${ctx}/admin/sys/col/"+obj.id+"/setPublishContent",{
				title:'发布内容设置',
				id:'setPublish',
				width: 768,
				height: 300,
				resize: false
			});
		};
		$(function(){
			 $('[data-toggle="tooltip"]').tooltip();
		});
		
		var typeFormatter = function(value, row, index){
			return row.type==1?"<a class='changeType' title='点击修改发布类型' href='javascript:void(0);'>产品列表</a>":
				(row.type==0?"<a class='changeType' title='点击修改发布类型' href='javascript:void(0);'>信息列表</a>":
					"<a class='changeType' title='点击修改发布类型' href='javascript:void(0);'>文章标题</a>");
		};
		
		window.typeEvents = {
			    'click .changeType': function (e, value, row, index) {
			    	setPublishType(row);
			    }
		};
		
		$("#table").bootstrapTable();
</script>

	<!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        	栏目管理
        <small>更轻松管理您的前台菜单栏目</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="${ctx}/admin/index"><i class="fa fa-dashboard"></i> 主页</a></li>
        <li><a href="#">系统管理</a></li>
        <li class="active">栏目管理</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-header">
              <h3 class="box-title">前台菜单栏目列表</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
            	<div id="toolbar">
			        <button class="btn btn-block btn-primary" onclick="tianjia();">
			            <i class="glyphicon glyphicon-plus icon-plus"></i> 新增
			        </button>
			    </div>
              <table id="table" data-toolbar="#toolbar" 
              data-toggle="table" class="table table-striped" data-search="true" data-show-refresh="true" 
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
					<th data-field="enName">栏目名称(英文)</th>
					<th data-field="code">栏目代码</th>
					<th data-field="parentName">父级栏目</th>
					<th data-field="priority">排序号</th>
					<th data-formatter="typeFormatter" data-events="typeEvents">发布类型</th>
					<th data-formatter="actionFormatter" data-events="actionEvents">操作</th>
				</tr> 
                </thead>
                <%-- <tbody>
                <c:choose>
				<c:when test="${!(empty page.result) and (page.totalRowNum>0) }">
				<c:forEach items="${page.result }" var="column" varStatus="status">
				<tr>
					<td>${(page.currentPageIndex-1)*page.pageSize+status.index+1 }</td>
					<td title="${column.name }（${column.enName }）">${column.name }（${column.enName }）</td>
					<td>${column.code }</td>
					<td>${empty column.parentName?"————":column.parentName }</td>
					<td>${column.priority }</td>
					<td>
						<input type="image" name="${column.id }" data-toggle="tooltip" data-placement="top" onclick="update(this);"
						src="${ctx}/resources/images/icn_edit.png" title="修改"/>&nbsp;
						<input type="image" name="${column.id }" onclick="setPublish(this);" 
						src="${ctx}/resources/images/icn_publish.png" data-toggle="tooltip" data-placement="top" 
						title="发布设置（当前使用
						<c:choose>
							<c:when test="${column.type==1 }">
								产品列表
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${column.type==0 }">
										信息列表
									</c:when>
									<c:otherwise>
										文章标题
									</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>
						模式发布）．设置时，其子栏目也会一起设置"/>&nbsp;
						<input type="image" name="${column.id }" data-toggle="tool1tip" data-placement="top" onclick="del(this);" 
						src="${ctx}/resources/images/icn_trash.png" title="删除"/>&nbsp;&nbsp;
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