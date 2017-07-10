<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../../commons/include.jsp" %>
<script type="text/javascript">
	var tianjia = function(){
		var url = "${ctx}/admin/ad/save";
		art.dialog.open(url,{
			title:'添加滚动图片',
			id:'tianjia',
			width: 768,
			height: 440,
			resize: false
		});
	};
	var update = function(obj){
		var url = '${ctx}/admin/ad/'+obj.id+'/update';
		art.dialog.open(url,{
			title:'修改滚动图片',
			id:'bianji',
			width: 768,
			height: 440,
			resize: false
		});
	};
	//del
	var del = function(obj){
		art.dialog.confirm('确定删除此新闻？',function(){
			var url = '${ctx}/admin/ad/'+obj.id+'/delete';
			$.getJSON(url,function(json){
	    		if(json.code==200){
	    			$("button[name='refresh']",window.document).click();
	    		}else{
	    			art.dialog.tips(json.message, 1.5);
	    		}
			});
		});
	};
	var changeStatus = function(row){
		var statusStr = "正常";
		if(row.status==1){
			statusStr = "锁定";
		}
		art.dialog.confirm("确定修改为【"+statusStr+"】状态？",function(){
			var url = '${ctx}/admin/ad/'+row.id+'/updateStatus';
			$.getJSON(url,{'status':row.status},function(json){
				if(json.code==200){
					$("button[name='refresh']",window.document).click();
				}else{
					art.dialog.tips(json.message, 2);
				}
			});
		});
	};
	var adImgFormatter = function(value, row, index){
		return "<img title='"+row.name +"' alt='"+row.name +"' src='${applicationScope.staticAccessPath }/"+row.picUrl+"' width='107px' height='50px'/>";
	}
	
	var adHrefFormatter = function(value, row, index){
		return "<a href='"+row.url+"' target='_blank'>"+row.url+"</a>";
	}
	
	var adStatusFormatter = function(value, row, index){
		return row.status==1?"<span title='正常' class='label btn label-success editStatus'>正常</span>":
			"<span title='锁定' class='label btn label-danger editStatus'>锁定</span>";
	}
	
	window.adStatusActionEvents = {
		    'click .editStatus': function (e, value, row, index) {
		    	changeStatus(row);
		    }
	};
	$("#table").bootstrapTable();
</script>

	<!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        	滚动图片管理
        <small>更轻松管理您的广告</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="${ctx }/admin/index"><i class="fa fa-dashboard"></i> 主页</a></li>
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
              data-side-pagination="server" data-url="${ctx }/${ajaxListUrl}"> 
			<thead> 
				<tr> 
    				<th data-formatter="runningFormatter">序号</th>
    				<th data-formatter="adImgFormatter">图片</th>
					<th data-field="name">图片名称</th>
					<th data-formatter="adHrefFormatter">跳转路径</th>
					<th data-field="width">宽度</th>
					<th data-field="height">高度</th>
					<th data-field="priority">排序号</th>
					<th data-formatter="adStatusFormatter" data-events="adStatusActionEvents">状态</th>
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