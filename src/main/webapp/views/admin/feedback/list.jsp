<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../../commons/include.jsp" %>
<script type="text/javascript">
	var detail = function(id){
		var myDialog = art.dialog({
			id:'detail',
			title:'留言详情',
			width:600,
			resize: false
		});
		jQuery.ajax({
			url:'${ctx}admin/feedback/'+id+'.html',
			type:'GET',
			success:function(data){
				myDialog.content(data);
			},
			error:function(data){
				myDialog.content("连接失败");
				myDialog.time(2.5);
			}
		});
	}
	
		var del = function(obj){
			var feedbackId = $(obj).attr("name");
			art.dialog.confirm('确定删除此留言?',function(){
				var url = '${ctx}admin/feedback/'+feedbackId+'/del.html';
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
					<th >姓名</th>
					<th >邮箱</th>
					<th >反馈时间</th>
					<th >操作</th>
				</tr> 
                </thead>
                <tbody>
                <c:forEach items="${page.result }" var="feedback" varStatus="status">
				<tr>
					<td>${(page.currentPageIndex-1)*page.pageSize+status.index+1 }</td>
					<td>${feedback.name }</td>
					<td>${feedback.email }</td>
					<td><fmt:formatDate value="${feedback.createTime }" type="both"/></td>
					<td>
						<input type="image" name="details" onclick="detail(${feedback.id });"
						src="${ctx }resources/images/icn_alert_info.png" title="详情"/>
						<input type="image" name="${feedback.id }" onclick="del(this);" 
						src="${ctx }resources/images/icn_trash.png" title="删除"/>&nbsp;&nbsp;
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
