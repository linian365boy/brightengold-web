<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../../commons/include.jsp" %>
<script type="text/javascript">
		var tianjia = function(){
			var url = '${ctx}/admin/news/add';
			$.get(url,function(data){
				$("div.content-wrapper").html(data);
			});
		};
		var update = function(obj){
			var url = '${ctx}/admin/news/'+obj.id+'/update';
			$.get(url,function(data){
				$("div.content-wrapper").html(data);
			});
		};
		//del
		var del = function(obj){
			art.dialog.confirm('确定删除此【'+obj.title+'】新闻？',function(){
				var url = '${ctx}/admin/news/'+obj.id+'/del';
				$.getJSON(url,function(json){
		    		if(json.code==200){
		    			$("button[name='refresh']",window.document).click();
		    		}else{
		    			art.dialog.tips(json.message, 1.5);
		    		}
				});
			});
		};
		//purview
		/* var purview = function(obj){
			var url = '${ctx}admin/news/'+obj.id+"";
			window.open(url);
		}; */
		//publish
		var publish = function(obj){
			var newsId = obj.id;
			$.get("${ctx}/admin/news/"+newsId+"/checkPub",function(rs){
				if(rs=="1"){
					art.dialog.confirm('此新闻【'+obj.title+'】已发布，确定重新发布？',function(){
						$.getJSON("${ctx}/admin/news/"+newsId+"/release",function(data){
							var dialog = art.dialog({
								id:"publish",
								lock:true
							});
							if(data.code==200){
								dialog.content('恭喜您，发布成功！').time(2.5);
								$("button[name='refresh']",window.document).click();
							}else{
								dialog.content('对不起，发布失败！').time(2.5);
							}
						});
					});
				}else{
					art.dialog.confirm('确定发布此【'+obj.title+'】新闻？',function(){
						$.getJSON("${ctx}/admin/news/"+newsId+"/release",function(data){
							var dialog = art.dialog({
								id:"publish",
								lock:true
							});
							 if(data.code==200){
								dialog.content('恭喜您，发布成功！').time(2.5);
								$("button[name='refresh']",window.document).click();
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
		
		var newsActionFormatter = function(value, row, index){
			 return [
				        '<a class="label label-info edit" href="javascript:void(0)" title="修改">修改</a>',
				        '<a class="label label-info publish ml10" href="javascript:void(0)" title="发布">发布</a>',
						'<a class="label label-danger ml10 remove" href="javascript:void(0)" title="删除">删除</a>'
				    ].join('');
		}
		
		window.newsActionEvents = {
				'click .publish':function(e, value, row, index){
					publish(row);
				},
				'click .edit': function (e, value, row, index) {
			    	update(row);
			    },
			    'click .remove': function (e, value, row, index) {
			    	del(row);
			    }
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
        <li><a href="${ctx }/admin/index"><i class="fa fa-dashboard"></i> 主页</a></li>
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
              data-side-pagination="server" data-url="${ctx }/${ajaxListUrl}">
                <thead>
                <tr> 
    				<th data-formatter="runningFormatter">序号</th>
					<th data-field="title">新闻标题</th>
					<th data-field="columnName">所在栏目</th>
					<th data-field="createDate">创建日期</th>
					<th data-formatter="publishDateFormatter">发布日期</th>
					<th data-field="priority">优先值</th>
					<th data-formatter="newsActionFormatter" data-events="newsActionEvents">操作</th>
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
