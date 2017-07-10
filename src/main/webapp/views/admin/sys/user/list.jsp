<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../../../commons/include.jsp" %>

<script type="text/javascript">
	function detail(obj){
		var myDialog = art.dialog({
			id:'detail',
			title:'员工详情',
			width:768,
			resize: false
		});
		jQuery.ajax({
			url:'${ctx}/admin/sys/user/'+obj.id+"",
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
		var url = '${ctx}/admin/sys/user/'+obj.id+'/update';
		art.dialog.open(url,{
			title:'编辑员工信息',
			id:'bianji',
			width:768,
			height:340,
			resize: false
			});
		};
		
		var tianjia = function(){
			var url = "${ctx}/admin/sys/user/add";
			art.dialog.open(url,{
				title:'添加用户',
				id:'tianjia',
				width: 768,
				height: 350,
				resize: false
			});
		};
		
		var resetPassword = function(obj){
			art.dialog.confirm('密码将重置为用户名'+obj.username+'，是否确认继续？',function(){
			var url = '${ctx}/admin/sys/user/'+obj.username+'/reset';
			jQuery.get(url,function(json){
			    		art.dialog.tips(json.message, 2);
				},"json");
			});
		};
		
		var unsubscribe = function(obj){
			art.dialog.confirm('注销后将不能使用此账户！是否确定注销此账户？',function(){
				var url = '${ctx}/admin/sys/user/'+obj.username+'/unsubscribe';
				jQuery.get(url,function(json){
			    		if(json.code==200){
				    		$("button[name='refresh']",window.document).click();
			    		}
			    		art.dialog.tips(json.message, 2);
				},"json");
			});
		};
		
		var userRoleFormatter=function(value, row, index){
			var roles = row.roles;
			//console.info("roles-=-="+JSON.stringify(roles));
			if(roles && roles.length>0){
				return roles[0].describes;
			}
			return "--";
		}
		
		var userStatusFormatter=function(value, row, index){
			return row.accountNonLocked?(row.enabled?"<span class='label label-success' title='正常'>正常</span>":
				"<span class='label label-warning' title='禁用'>禁用</span>"):"<span class='label label-danger' title='注销'>注销</span>" ;
		}
		
		var userActionFormatter = function(value, row, index){
			return [
			        '<a class="label label-info detail" href="javascript:void(0)" title="查看详情">查看详情</a>',
			        '<a class="label label-info edit ml10" href="javascript:void(0)" title="修改">修改</a>',
					'<a class="label label-danger ml10 reset" href="javascript:void(0)" title="重置密码">重置密码</a>',
					'<a class="label label-info ml10 unsubscribe" href="javascript:void(0)" title="注销">注销</a>'
			    ].join('');
		};
		
		window.userActionEvents = {
			'click .detail': function(e, value, row, index){
				detail(row);
			},
			'click .edit': function (e, value, row, index) {
		    	update(row);
		    },
		    'click .reset': function (e, value, row, index) {
		    	resetPassword(row);
		    },
		    'click .unsubscribe': function (e, value, row, index) {
		    	unsubscribe(row);
		    }
		};
		$("#table").bootstrapTable();
</script>



<!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        	用户管理
        <small>更轻松管理您的后台登录用户信息</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="${ctx}/admin/index"><i class="fa fa-dashboard"></i> 主页</a></li>
        <li><a href="#">系统管理</a></li>
        <li class="active">用户管理</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-header">
              <h3 class="box-title">用户列表</h3>
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
                	<th data-field="username">用户名</th>
	                <th data-field="realName">姓名</th>
					<th data-formatter="userRoleFormatter">角色</th>
					<th data-formatter="userStatusFormatter">状态</th>
					<th data-formatter="userActionFormatter" data-events="userActionEvents">操作</th>
				</tr> 
                </thead>
                <%-- <tbody>
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
									src="${ctx}/resources/images/icn_reset.png" onclick="resetPassword(this);" 
									title="重置密码"/>&nbsp;&nbsp;
								<input type="image" name="${user.username }" onclick="update(this);" 
									src="${ctx}/resources/images/icn_edit.png" title="编辑"/>&nbsp;&nbsp;
								<input type="image" name="${user.username }" onclick="unsubscribe(this);"
									src="${ctx}/resources/images/icn_trash.png" title="注销"/>
							</c:if>
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
