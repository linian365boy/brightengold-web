<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../../commons/include.jsp" %>
<script type="text/javascript">
	var detail = function(row){
		var myDialog = art.dialog({
			id:'detail',
			title:'反馈留言详情',
			width:600,
			resize: false
		});
		jQuery.ajax({
			url:'${ctx}admin/feedback/'+row.id+'.html',
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
		var feedbackActionFormatter = function(value, row, index){
			return [
			        '<a class="label label-info info" href="javascript:void(0)" title="详情">详情</a>',
					'<a class="label label-danger ml10 remove" href="javascript:void(0)" title="删除">删除</a>'
			    ].join('');
		}
		window.feedbackActionEvents = {
			    'click .info': function (e, value, row, index) {
			    	detail(row);
			    },
			    'click .remove': function (e, value, row, index) {
			    	del(row.id);
			    }
		};
		$("#table").bootstrapTable();
</script>

<!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        	反馈管理
        <small>更轻松管理您的客户反馈信息</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="${ctx }admin/index.html"><i class="fa fa-dashboard"></i> 主页</a></li>
        <li><a href="#">反馈管理</a></li>
        <li class="active">客户留言</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-header">
              <h3 class="box-title">反馈信息列表</h3>
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
					<th data-field="name">姓名</th>
					<th data-field="email">邮箱</th>
					<th data-field="createTime">反馈时间</th>
					<th data-formatter="feedbackActionFormatter" data-events="feedbackActionEvents">操作</th>
				</tr>
                </thead>
                <%-- <tbody>
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