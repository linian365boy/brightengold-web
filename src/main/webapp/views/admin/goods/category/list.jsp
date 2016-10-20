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
		
</script>
	
	<!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        	产品分类管理
        <small>更轻松管理您的分类</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
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
              <h3 class="box-title">产品列表</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <table id="table" class="table table-hover table-striped">
                <thead>
                <tr> 
    				<th >序号</th>
					<th >一级分类</th>
					<th >二级分类</th>
					<th >所在栏目</th>
					<th >操作</th>
				</tr> 
                </thead>
                <tbody>
                <c:forEach items="${page.result }" var="category" varStatus="status">
	                <tr>
	                  <td>${(page.currentPageIndex-1)*page.pageSize+status.index+1 }</td>
	                  <td><c:choose>
							<c:when test="${!(empty category.parentName) }">
								${category.parentName }
							</c:when>
							<c:otherwise>
								————
							</c:otherwise>
						</c:choose>
	                  </td>
	                  <td>${category.name }（${category.enName }）</td>
	                  <td>${category.columnName }</td>
	                  <td>
						<span class="label label-info" name="${category.id }" onclick="update(this);">修改</span>
						<span class="label label-danger" name="${category.id }" onclick="del(this);">删除</span>
					</td>
	                </tr>
                </c:forEach>
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