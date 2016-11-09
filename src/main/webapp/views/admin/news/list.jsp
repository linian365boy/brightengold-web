<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../../commons/include.jsp" %>
<script type="text/javascript">
		var tianjia = function(){
			var url = '${ctx}admin/news/add.html';
			$.get(url,function(data){
				$("div.content-wrapper").html(data);
			});
		};
		var update = function(obj){
			var url = '${ctx}admin/news/'+obj.id+'/update.html';
			$.get(url,function(data){
				if(JSON.stringify(data).indexOf("login page")!=-1){
		    		 location.href="${ctx}admin/login.html";
		    	}else{
					$("div.content-wrapper").html(data);
		    	}
			});
		};
		//del
		var del = function(obj){
			art.dialog.confirm('确定删除此新闻？',function(){
				var url = '${ctx}admin/news/'+obj.id+'/del.html';
				window.location.href=url;
			});
		};
		//purview
		var purview = function(obj){
			var url = '${ctx}admin/news/'+obj.id+".html";
			window.open(url);
		};
		//publish
		var publish = function(obj){
			var newsId = obj.id;
			$.get("${ctx}admin/news/"+newsId+"/checkPub.html",function(rs){
				if(rs=="1"){
					art.dialog.confirm('此新闻已发布，确定重新发布？',function(){
						$.getJSON("${ctx}admin/news/"+newsId+"/release.html",function(data){
							var dialog = art.dialog({
								id:"publish",
								lock:true
							});
							if(data.code==200){
								dialog.content('恭喜您，发布成功！').time(2.5);
								$("#"+newsId).html(data.data);
							}else{
								dialog.content('对不起，发布失败！').time(2.5);
							}
						});
					});
				}else{
					art.dialog.confirm('确定发布此新闻？',function(){
						var newsId = $(obj).attr("name");
						$.getJSON("${ctx}admin/news/"+newsId+"/release.html",function(data){
							var dialog = art.dialog({
								id:"publish",
								lock:true
							});
							 if(data.code==200){
								dialog.content('恭喜您，发布成功！').time(2.5);
								$("#"+newsId).html(data.data);
							}else{
								dialog.content('对不起，发布失败！').time(2.5);
							} 
						});
					});
				}
			},"html");
		};
		
		var publishDateFormatter=function(value, row, index){
			return row.publishDate?row.publishDate:"<span class='label label-default' title='未发布'>未发布</span>";
		};
		$("#table").bootstrapTable();
</script>
	<!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        	新闻管理
        <small>更轻松管理您的新闻</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="${ctx }admin/index.html"><i class="fa fa-dashboard"></i> 主页</a></li>
        <li><a href="javascript:void(0);">新闻管理</a></li>
        <li class="active">新闻管理</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-header">
              <h3 class="box-title">新闻列表</h3>
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
              data-side-pagination="server" data-url="${ctx }${ajaxListUrl}">
                <thead>
                <tr> 
    				<th data-formatter="runningFormatter">序号</th>
					<th data-field="title">新闻标题</th>
					<th data-field="columnName">所在栏目</th>
					<th data-field="createDate">创建日期</th>
					<th data-formatter="publishDateFormatter">发布日期</th>
					<th data-field="priority">优先值</th>
					<th data-formatter="actionFormatter" data-events="actionEvents">操作</th>
				</tr> 
                </thead>
                <%-- <tbody>
                <c:forEach items="${page.result }" var="news" varStatus="status">
				<tr>
					<td>${(page.currentPageIndex-1)*page.pageSize+status.index+1 }</td>
					<td><a href="${ctx }admin/news/${news.id}.html" title="${news.title }" target="_blank">${news.title }</a></td>
					<td>${news.columnName }</td>
					<td>${news.createDate }</td>
					<td id="${news.id }">
						<c:choose>
							<c:when test="${ empty news.publishDate}">
								<span class='label label-default' title='未发布'>未发布</span>
							</c:when>
							<c:otherwise>
								${ news.publishDate}
							</c:otherwise>
						</c:choose>
					</td>
					<td>${ news.priority}</td>
					<td>
						<span class="label label-info" name="${news.id }" onclick="update(this);">修改</span>
						<span class="label label-primary" name="${news.id }" onclick="publish(this);">发布</span>
						<span class="label label-danger" name="${news.id }" onclick="del(this);">删除</span>
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
