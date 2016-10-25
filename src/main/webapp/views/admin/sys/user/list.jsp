<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../../../commons/include.jsp" %>

<script type="text/javascript">

	function detail(obj){
		var myDialog = art.dialog({
			id:'detail',
			title:'员工详情',
			width:400,
			resize: false
		});
		var username = $(obj).attr("name");
		jQuery.ajax({
			url:'${ctx}admin/sys/user/'+username+".html",
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
	
	var update = function(obj){
		var username = $(obj).attr("name");
		var url = '${ctx}admin/sys/user/'+username+'/update.html';
		art.dialog.open(url,{
			title:'编辑员工信息',
			id:'bianji',
			width:450,
			height:300,
			resize: false
			});
		};
		
		var tianjia = function(){
			var url = "${ctx}admin/sys/user/add.html";
			art.dialog.open(url,{
				title:'添加用户',
				id:'tianjia',
				width: 450,
				height: 330,
				resize: false
			});
		};
		
		var resetPassword = function(obj){
			art.dialog.confirm('密码将重置为888888，是否确认继续？',function(){
			var username = $(obj).attr("name");
			var url = '${ctx}admin/sys/user/'+username+'/reset.html';
			jQuery.ajax({
				url:url,
				success:function(data){
					art.dialog({
						title:'提示消息',
						content:'<span style="color:red">'+data+'</span>',
						width:300,
						time:2.5
					});
				},
				error:function(data){
					art.dialog({
						title:'提示消息',
						content:'连接失败!',
						time:2.5
					});
				}
			});
			});
		};
		
		var unsubscribe = function(obj){
			var username = $(obj).attr("name");
			art.dialog.confirm('注销后将不能使用此账户！是否确定注销此账户？',function(){
				var url = '${ctx}admin/sys/user/'+username+'/unsubscribe.html';
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
    				<tr> 
    				<th >序号</th>
                	<th >员工号</th>
	                <th >姓名</th>
					<th >角色</th>
					<th >状态</th>
					<th >操作</th>
				</tr> 
				</tr> 
                </thead>
                <tbody>
                <c:choose>
				<c:when test="${!(empty page.result) and (page.totalRowNum>0) }">
					<c:forEach items="${page.result }" var="user" varStatus="status">
					<tr>
						<td>${(page.currentPageIndex-1)*page.pageSize+status.index+1 }</td>
						<td><a onclick="detail(this)" name="${user.username }" href="javascript:void(0);">${user.username }</a></td>
						<td>${user.realName }</td>
						<td>
	              			<c:forEach items="${user.roles }" var="role">
	              				<c:if test="${role.name!='ROLE_DEFAULT' }">
									${role.desc }
	              				</c:if>
							</c:forEach>
						</td>
						<td>
							${user.accountNonLocked?(user.enabled?"<span class='label label-success' title='正常'>正常</span>":"<span class='label label-warning' title='禁用'>禁用</span>"):"<span class='label label-danger' title='注销'>注销</span>" }
						</td>
						<td>
							<c:if test="${user.accountNonLocked }">
								<input type="image" name="${user.username }" 
									src="${ctx }resources/images/icn_reset.png" onclick="resetPassword(this);" 
									title="重置密码"/>&nbsp;&nbsp;
								<input type="image" name="${user.username }" onclick="update(this);" 
									src="${ctx }resources/images/icn_edit.png" title="编辑"/>&nbsp;&nbsp;
								<input type="image" name="${user.username }" onclick="unsubscribe(this);"
									src="${ctx }resources/images/icn_trash.png" title="注销"/>
							</c:if>
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
