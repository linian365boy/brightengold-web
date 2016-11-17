<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../../../commons/include.jsp" %>
<script type="text/javascript">
	var update = function(obj){
		$.get('${ctx}admin/goods/product/'+obj.id+'/update.html',function(data){
			$("div.content-wrapper").html(data);
		});
	};
		
	var tianjia = function(){
		$.get("${ctx}admin/goods/product/add.html",function(data){
			$("div.content-wrapper").html(data);
		});
	};
		
	var del = function(obj){
		art.dialog.confirm('确定删除此商品【'+obj.enName+'】？',function(){
			var url = '${ctx}admin/goods/product/'+obj.id+'/del.html';
			$.post(url,function(json){
	    		if(json.code==200){
	    			$("button[name='refresh']",window.document).click();
	    		}else{
	    			art.dialog.tips(json.message, 1.5);
	    		}
			},"json");
		});
	};
	
	var publish = function(obj){
		$.get("${ctx}admin/goods/product/"+obj.id+"/checkPub.html",function(rs){
			if(rs=="1"){
				art.dialog.confirm('此商品【'+obj.enName+'】已发布，确定重新发布？',function(){
					var url = '${ctx}admin/goods/product/'+obj.id+'/release.html';
					$.post(url,function(json){
						if(json.code==200){
			    			$("button[name='refresh']",window.document).click();
			    		}else{
			    			art.dialog.tips(json.message, 1.5);
			    		}
					},"json");
				});
			}else{
				art.dialog.confirm('确定发布此商品【'+obj.enName+'】？',function(){
					var url = '${ctx}admin/goods/product/'+obj.id+'/release.html';
					$.post(url,function(json){
						if(json.code==200){
			    			$("button[name='refresh']",window.document).click();
			    		}else{
			    			art.dialog.tips(json.message, 1.5);
			    		}
					},"json");
				});
			}
		},"html");
	}
	
	window.changeStatusEvent = {
			'click .editStatus': function(e, value, row, index){
				var statusStr = "正常";
				if(row.status){
					statusStr = "锁定";
				}
				art.dialog.confirm('确定修改【'+row.enName+'】状态为'+statusStr+'？',function(){
					$.post("${ctx}admin/goods/product/"+row.id+"/changeStatus.html",
							{status:row.status},function(text){
						if(text=="1"){
							if(row.status){
								$("#status_"+row.id).text("锁定").removeClass("label-info").addClass("label-default");
							}else{
								$("#status_"+row.id).text("正常").removeClass("label-default").addClass("label-info");
							}
							$("button[name='refresh']",window.document).click();
						}else{
							art.dialog.tips("修改状态失败！", 1.5);
						}
					});
				});
			}
	}
	
	var productImgFormatter = function(value, row, index){
		return "<img src='${staticAccessPath }/"+row.picUrl+"' title='"+row.enName+"' alt='"+row.enName+"' width='50' height='50'></img>";
	}
	
	var isHotFormatter = function(value, row, index){
		return row.hot ? "<span class='label label-danger' title='热门'>热门</span>" : "<span class='label label-primary' title='非热门'>非热门</span>";
	}
	
	var isPublishFormatter = function(value, row, index){
		return row.publish?"<span class='label label-info' title='发布'>发布</span>":"<span class='label label-default' title='未发布'>未发布</span>" ;
	}
	
	var productStatusFormatter = function(value, row, index){
		return row.status?"<a id='status_"+row.id+"' class='label label-info editStatus' title='点击修改状态' href='javascript:void(0)'>正常</a>"
				:"<a id='status_"+row.id+"' class='label label-default editStatus' title='点击修改状态' href='javascript:void(0)'>锁定</a>";
	}
	
	var productActionFormatter = function(value, row, index){
		 return [
			        '<a class="label label-info edit" href="javascript:void(0)" title="修改">修改</a>',
			        '<a class="label label-info publish ml10" href="javascript:void(0)" title="发布">发布</a>',
					'<a class="label label-danger ml10 remove" href="javascript:void(0)" title="删除">删除</a>'
			    ].join('');
	}
	
	window.productActionEvents = {
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
        	产品管理
        <small>更轻松管理您的产品</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="${ctx }admin/index.html"><i class="fa fa-dashboard"></i> 主页</a></li>
        <li><a href="#">产品管理</a></li>
        <li class="active">产品管理</li>
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
					<th data-halign="center" data-align="center" data-formatter="runningFormatter">序号</th>
    				<th data-halign="center" data-align="center" data-formatter="productImgFormatter">商品图片</th>
					<th data-field="enName">商品名称</th>
					<th data-field="categoryEnName">商品分类</th>
					<th data-halign="center" data-align="center" data-formatter="isHotFormatter">是否热门</th>
					<th data-halign="center" data-align="center" data-formatter="isPublishFormatter">是否发布</th>
					<th data-halign="center" data-align="center" data-formatter="productStatusFormatter" data-events="changeStatusEvent">状态</th>
					<th data-halign="center" data-align="center" data-field="priority">排序号</th>
					<th data-formatter="productActionFormatter" data-events="productActionEvents">操作</th>
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
