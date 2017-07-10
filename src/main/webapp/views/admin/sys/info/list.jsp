<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/views/commons/include.jsp" %>
<script type="text/javascript">
	var update = function(obj){
		var url = '${ctx}/admin/sys/info/'+obj.id+'/update';
		$.get(url,function(data){
			$("div.content-wrapper").html(data);
		});
	};
		
		var tianjia = function(){
			var url = "${ctx}/admin/sys/info/add";
			$.get(url,function(data){
				$("div.content-wrapper").html(data);
			});
		};
		
		var del = function(obj){
			art.dialog.confirm('确定删除此'+obj.name+'信息？',function(){
				var url = '${ctx}/admin/sys/info/'+obj.id+'/delete';
				$.post(url,function(json){
		    		if(json.code==200){
		    			$("button[name='refresh']",window.document).click();
		    		}else{
		    			art.dialog.tips(json.message, 2);
		    		}
				},"json");
			});
		};
		
		var setPublish = function(obj){
			art.dialog.confirm('确定删除此信息？',function(){
				var url = '${ctx}/admin/sys/info/'+obj.id+'/publishContent';
				window.location.href=url;
			});
		};
		$("#table").bootstrapTable();
</script>

<!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        	信息管理
        <small>更轻松管理您的信息页面</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="${ctx}/admin/index"><i class="fa fa-dashboard"></i> 主页</a></li>
        <li><a href="#">系统管理</a></li>
        <li class="active">信息管理</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-header">
              <h3 class="box-title">信息列表</h3>
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
					<th data-field="name">名称</th>
					<th data-field="code">代码</th>
					<th data-field="priority">排序号</th>
					<th data-formatter="actionFormatter" data-events="actionEvents">操作</th>
				</tr> 
                </thead>
                <%-- <tbody>
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
						src="${ctx}/resources/images/icn_edit.png" title="修改"/>&nbsp;
						<input type="image" name="${info.id }" data-toggle="tool1tip" data-placement="top" onclick="del(this);" 
						src="${ctx}/resources/images/icn_trash.png" title="删除"/>&nbsp;&nbsp;
					</td>
				</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr class="text-center"><td colspan="5">暂无数据</td></tr>
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