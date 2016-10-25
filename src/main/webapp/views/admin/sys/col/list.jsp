<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/views/commons/include.jsp" %>
<script type="text/javascript">
	var update = function(obj){
		var categoryId = $(obj).attr("name");
		var url = '${ctx}admin/sys/col/'+categoryId+'/update.html';
		art.dialog.open(url,{
			title:'编辑分类信息',
			id:'bianji',
			width:550,
			height:340,
			resize: false
			});
		};
		
		var tianjia = function(){
			var url = "${ctx}admin/sys/col/add.html";
			art.dialog.open(url,{
				title:'添加栏目类别',
				id:'tianjia',
				width: 550,
				height: 340,
				resize: false
			});
		};
		
		var del = function(obj){
			var categoryId = $(obj).attr("name");
			art.dialog.confirm('确定删除此栏目？',function(){
				var url = '${ctx}admin/sys/col/'+categoryId+'/delete.html';
				$.getJSON(url,function(json){
					art.dialog.alert(json.message,function(){
						if(json.code==200){
							$("#searchForm").submit();
						}
					});
				});
			});
		};
		var setPublish = function(obj){
			var categoryId = $(obj).attr("name");
			art.dialog.open("${ctx}admin/sys/col/"+categoryId+"/setPublishContent.html",{
				title:'发布内容设置',
				id:'setPublish',
				width: 550,
				height: 300,
				resize: false
			});
		};
		$(function(){
			 $('[data-toggle="tooltip"]').tooltip();
		});
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
					<th >栏目名称(英文)</th>
					<th >栏目代码</th>
					<th >父级栏目</th>
					<th >排序号</th>
					<th >操作</th>
				</tr> 
                </thead>
                <tbody>
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
						src="${ctx }resources/images/icn_edit.png" title="修改"/>&nbsp;
						<input type="image" name="${column.id }" onclick="setPublish(this);" 
						src="${ctx }resources/images/icn_publish.png" data-toggle="tooltip" data-placement="top" 
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
						src="${ctx }resources/images/icn_trash.png" title="删除"/>&nbsp;&nbsp;
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