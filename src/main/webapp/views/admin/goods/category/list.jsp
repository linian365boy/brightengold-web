<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../../../commons/include.jsp" %>
<script type="text/javascript">
	var update = function(obj){
		var categoryId = $(obj).attr("name");
		var url = '${ctx}admin/goods/category/'+categoryId+'/update.html';
		art.dialog.open(url,{
			title:'编辑分类信息',
			id:'bianji',
			width:550,
			height:330,
			resize: false
			});
		};
		
		var tianjia = function(){
			var url = "${ctx}admin/goods/category/add.html";
			art.dialog.open(url,{
				title:'添加商品分类',
				id:'tianjia',
				width: 550,
				height: 330,
				resize: false
			});
		};
		
		var del = function(obj){
			var categoryId = $(obj).attr("name");
			art.dialog.confirm('确定删除此分类',function(){
				var url = '${ctx}admin/goods/category/'+categoryId+'/del.html';
				window.location.href=url;
			});
		};
		
		$("#table").bootstrapTable();
		
</script>
	
	<!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        	产品分类管理
        <small>更轻松管理您的分类</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="${ctx }admin/index.html"><i class="fa fa-dashboard"></i> 主页</a></li>
        <li><a href="#">产品管理</a></li>
        <li class="active">产品分类管理</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-header">
              <h3 class="box-title">产品分类列表</h3>
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
					<th data-field="parentName">父级分类</th>
					<th data-field="name">名称（中）</th>
					<th data-field="enName">名称（英）</th>
					<th data-field="columnName">所在栏目</th>
					<th data-field="createDate">创建日期</th>
					<th data-formatter="actionFormatter" data-events="actionEvents">操作</th>
				</tr> 
                </thead>
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