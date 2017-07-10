<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/views/commons/include.jsp" %>
<title>角色权限分配</title>
<link rel="stylesheet" type="text/css" href="${ctx}/resources/plugins/dhtmlx/dhtmlxtree.css"/>
<script src="${ctx}/resources/plugins/dhtmlx/dhtmlxtree.js"></script>
<script type="text/javascript">
	$(function(){
		<%--包括所有被选中的菜单与资源 --%>
		$("#actionForm").ajaxForm({
			type:'POST',
			dataType:'json',
			beforeSubmit:function(arr, form, options){
				var allChecked = myTree.getAllChecked();
				if(allChecked.length==0){
					$(".box-header .error").removeClass("hide").html("请选择资源分配给角色！");
					return false;
				}
			},
			success:function(json) {
		    		if(json.code==200){
		    			$("ul.treeview-menu.menu-open li.active a").click();
		    		}else{
		    			$(".box-header .error").removeClass("hide").html(json.message);
		    		}
			}
		});
		loadTree();
	});
	
	var myTree;
	function loadTree(){
		myTree = new dhtmlXTreeObject({
			parent: "tree",
			checkbox: true,
			image_path: "${ctx}/resources/plugins/dhtmlx/skins/web/imgs/dhxtree_web/"
		});
		myTree.setXMLAutoLoading("${ctx}/admin/sys/menu/findAllMenu?name=${role.name}");
		myTree.setDataMode("json");
		myTree.enableThreeStateCheckboxes(true);
		myTree.attachEvent("onCheck", function(id, state){
			var allCheckedArr = myTree.getAllChecked();
			if(state==1){
				$(allCheckedArr).splice(allCheckedArr.length,0,id);
			}else{
				$(allCheckedArr).splice($.inArray(id,allCheckedArr),1);
			}
			$("#str").val(allCheckedArr.split(","));
		});
		myTree.load("${ctx}/admin/sys/menu/findAllMenu?id=0&name=${role.name}",function(){
			myTree.openAllItems(0);
		},"json");
	}
</script>

<section class="content-header">
      <h1>
        	角色管理
        <small>更轻松管理您的权限分配</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="${ctx}/admin/index"><i class="fa fa-dashboard"></i> 主页</a></li>
        <li><a href="#">系统管理</a></li>
        <li class="active">角色管理</li>
      </ol>
    </section>
    
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box box-info">
					<div class="box-header with-border text-center">
						<h3 class="box-title pull-left">权限分配</h3>
						<label class="error hide"></label>
					</div>
					<div class="tab_container">
							<form action="${ctx}/admin/sys/role/${role.name }/distribute" id="actionForm" class="form-horizontal" method="post">
								<div class="box-body">
								<div class="form-group">
			                      <label class="col-sm-2 control-label" for="enName">当前角色：</label>
			                      <div class="col-sm-5">
			                        <input type="text" disabled value="${role.describes }" class="form-control">
			                      </div>
			                    </div>
			                    <div class="form-group">
			                    	<label class="col-sm-2 control-label" for="enName">选择权限：</label>
			                    	<div class="col-sm-5" style="overflow-y:auto; overflow-x:auto; height:500px;">
										<div id="tree" ></div>
			                      	</div>
			                    </div>
			                    <input name="str" type="hidden" id="str" value="${menuOrResource }"/>
								<%--很诡异的一个错误，下面这个input的type不能为submit，否则在IE下会出现提交两次的结果 --%>
								</div>
								<div class="box-footer">
								<button type="submit" class="btn btn-danger">确认分配</button>
								<%--&nbsp;&nbsp; <input type="reset" id="button"value="重置" />--%>
								</div><!-- /.box-footer -->
							</form>
						</div>
						</div>
					</div>
				</div>
		</section>