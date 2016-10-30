<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../../commons/include.jsp" %>
<script type="text/javascript">
	var tianjia = function(){
		var url = "${ctx}admin/ad/save.html";
		art.dialog.open(url,{
			title:'添加滚动图片',
			id:'tianjia',
			width: 768,
			height: 440,
			resize: false
		});
	};
	var update = function(obj){
		var url = '${ctx}admin/ad/'+obj.id+'/update.html';
		art.dialog.open(url,{
			title:'添加滚动图片',
			id:'bianji',
			width: 768,
			height: 440,
			resize: false
		});
	};
	//del
	var del = function(obj){
		art.dialog.confirm('确定删除此新闻？',function(){
			var url = '${ctx}admin/ad/'+obj.id+'/delete.html';
			window.location.href=url;
		});
	};
	var changeStatus = function(id,objstatus){
		var statusStr = "正常";
		if(objstatus==0){
			statusStr = "锁定";
		}
		art.dialog.confirm("确定修改为"+statusStr+"状态？",function(){
			var url = '${ctx}admin/ad/'+id+'/updateStatus.html';
			$.getJSON(url,{'status':objstatus},function(json){
				if(json.code==200){
					art.dialog.alert(json.message);
				}
			});
		});
	};
	var adImgFormatter = function(value, row, index){
		return "<img title='"+row.name +"' alt='"+row.name +"' src='${ctx }resources/"+row.picUrl+"' width='107px' height='50px'/>";
	}
	
	var adHrefFormatter = function(value, row, index){
		return "<a href='"+row.url+"' target='_blank'>"+row.url+"</a>";
	}
	
	var adStatusFormatter = function(value, row, index){
		return row.status==1?"<span title='正常' onclick='changeStatus('"+row.id+"','0');' class='label btn label-success'>正常</span>":
			"<span title='锁定' onclick='changeStatus('"+row.id+"','1');' class='label btn label-danger'>锁定</span>";
	}
	$("#table").bootstrapTable();
</script>

	<!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        	滚动图片管理
        <small>更轻松管理您的广告</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="${ctx }admin/index.html"><i class="fa fa-dashboard"></i> 主页</a></li>
        <li><a href="#">滚动图片管理</a></li>
        <li class="active">首页滚动图片</li>
      </ol>
    </section>
    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-header">
              <h3 class="box-title">首页滚动图片列表</h3>
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
    				<th data-formatter="adImgFormatter">图片</th>
					<th data-field="name">图片名称</th>
					<th data-formatter="adHrefFormatter">跳转路径</th>
					<th data-field="width">宽度</th>
					<th data-field="height">高度</th>
					<th data-field="priority">排序号</th>
					<th data-formatter="adStatusFormatter">状态</th>
					<th data-formatter="actionFormatter" data-events="actionEvents">操作</th>
				</tr>
			</thead> 
			<%-- <tbody id="dataContent"> 
				<c:forEach items="${page.result }" var="ad" varStatus="status">
				<tr>
					<td>${(page.currentPageIndex-1)*page.pageSize+status.index+1 }</td>
					<td><img title="${ad.name }" alt="${ad.name }"
					 src="${ctx }resources/${ ad.picUrl}" width="107px" height="50px"/></td>
					<td>${ad.name }</td>
					<td><a href="${ ad.url}" target="_blank">${ ad.url}</a></td>
					<td>${ ad.width}</td>
					<td>${ ad.height}</td>
					<td>${ ad.priority}</td>
					<td>
						<c:choose>
							<c:when test="${ad.status eq 1}">
								<span title="正常" onclick="changeStatus('${ad.id}','0');" class="label btn label-success">正常</span>
							</c:when>
							<c:otherwise>
								<span title="锁定" onclick="changeStatus('${ad.id}','1');" class="label btn label-danger">锁定</span>
							</c:otherwise>
						</c:choose>
					</td>
					<td>
						<input type="image" name="${ad.id }" onclick="update(this);"
						src="${ctx }resources/images/icn_edit.png" title="修改"/>&nbsp;
						<input type="image" name="${ad.id }" onclick="del(this);" 
						src="${ctx }resources/images/icn_trash.png" title="删除"/>&nbsp;
					</td>
				</tr>
				</c:forEach>
				</tbody>  --%>
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