<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../../commons/include.jsp" %>
<script type="text/javascript" src="${ctx }/resources/plugins/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${ctx }/resources/plugins/ckeditor/lang/zh-cn.js"></script>
<script type="text/javascript" src="/resources/plugins/jQueryValidate/jquery.validate.js"></script>
<script type="text/javascript" src="/resources/plugins/jQueryValidate/jquery.metadata.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/dist/css/customUse.css" />
<title>添加新闻</title>
<script type="text/javascript">
	$(document).ready(function(){
		$("#form").validate({
			rules:{
				"title":{
					required:true
				},
				"priority":{
					number:true
				},
				"content":{
					required:true
				}
			},
			messages:{
				"title":{
					required:"标题不能为空！"
				},
				"priority":{
					number:"优先值为数字！"
				},
				"content":{
					required:"内容不能为空！"
				}
			},
			highlight: function(element) {
			      jQuery(element).closest('.form-group').removeClass('has-success').addClass('has-error');
			},
			success: function(element) {
			      jQuery(element).closest('.form-group').removeClass('has-error');
			},
			submitHandler: function(form){
				CKEDITOR.instances.content.updateElement();
				$(form).ajaxSubmit({
					dataType:'json',
					success:function(json) {
			    		if(json.code==200){
			    			$("ul.treeview-menu.menu-open li.active a").click();
			    		}else{
			    			$(".box-header .error").removeClass("hide").html(json.message);
			    		}
			        }
				});
			}
		});
		CKEDITOR.replace('content');
	});
	
	function changeCol(obj){
		var colId = $(obj).val();
		$.post("${ctx }/admin/sys/col/getChildren/"+colId+"",{
			id:colId
		},function(json){
			$(obj).next().remove();
			var html = "";
			if(json.length>0){
				html+='<select class="col-xs-5 selectpicker" name="secondColId" >';
				html+='<option value="">--请选择--</option>';
				$.each(json,function(i,n){
					html+="<option value='"+n.id+"'>"+n.name+"</option>";
				});
				html+="</select>";
			}
			$(obj).after(html);
		},"json");
	};
</script>
	
	<section class="content-header">
      <h1>
        	新闻管理
        <small>更轻松管理您的新闻</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="${ctx }/admin/index"><i class="fa fa-dashboard"></i> 主页</a></li>
        <li><a href="#">新闻管理</a></li>
        <li class="active">新闻管理</li>
      </ol>
    </section>
	
	<section class="content">
		<div class="row">
		<div class="col-md-12">
			<div class="box box-info">
				<div class="box-header with-border text-center">
					<h3 class="box-title pull-left">编辑新闻</h3>
					<label class="error hide"></label>
				</div>
		<form action="${ctx }/admin/news/${news.id}/update" class="form-horizontal" id="form" method="post">
			<div class="box-body">
			<div class="form-group">
			    <label for="title" class="col-sm-2 control-label">栏目<code>*</code></label>
			    <div class="row">
			    	<div class="col-xs-8" style="overflow:hidden;">
			    			<select class="col-xs-5 selectpicker" name="firstColId" onchange="changeCol(this);">
			    				<option value="">--请选择--</option>
			    				<c:forEach items="${parentCol }" var="col">
				    				<c:choose>
				    					<c:when test="${empty (column.parentId) }">
				    						<c:choose>
						    					<c:when test="${column.id==col.id }">
						    						<option value="${col.id }" selected="selected">${col.name }</option>
						    					</c:when>
						    					<c:otherwise>
						    						<option value="${col.id }">${col.name }</option>
						    					</c:otherwise>
						    				</c:choose>
				    					</c:when>
				    					<c:otherwise>
				    						<c:choose>
						    					<c:when test="${column.parentId==col.id }">
						    						<option value="${col.id }" selected="selected">${col.name }</option>
						    					</c:when>
						    					<c:otherwise>
						    						<option value="${col.id }">${col.name }</option>
						    					</c:otherwise>
						    				</c:choose>
				    					</c:otherwise>
				    				</c:choose>
				    			</c:forEach>
				      		</select>
				      		<c:forEach items="${childs }" var="childColumn">
					      		<select class="col-xs-5 selectpicker" name="secondColId" >
				      				<c:choose>
					      				<c:when test="${not empty (column.parentId) }">
								      			<option value='${column.id }' selected="selected">${column.name }</option>
						      			</c:when>
						      			<c:otherwise>
						      					<option value='' selected="selected">--请选择--</option>
						      			</c:otherwise>
				      				</c:choose>
				      				<option value='${childColumn.id }'>${childColumn.name }</option>
							      </select>
				      		</c:forEach>
			    	</div>
			    </div>
		   </div>
		   
		   <div class="form-group">
			    <label for="title" class="col-sm-2 control-label">标题<code>*</code></label>
			    <div class="col-sm-8">
			      <input type="text" class="form-control" id="title" value="${news.title }" name="title" placeholder="标题">
			    </div>
		   </div>
		   <div class="form-group">
					<label for="introduce" class="col-sm-2 control-label">摘要</label>
					<div class="col-sm-8">
						<textarea rows="3" class="form-control" id="introduce" placeholder="摘要" name="introduce">${news.introduce }</textarea>
					</div>
			</div>
			<div class="form-group">
			    <label for="keyWords" class="col-sm-2 control-label">关键字</label>
			    <div class="col-sm-8">
			      <input type="text" class="form-control" id="keyWords" value="${news.keyWords }" name="keyWords" placeholder="关键字（多个以英文;隔开）">
			    </div>
		   </div>
		   
		   <div class="form-group">
			    <label for="priority" class="col-sm-2 control-label">优先值</label>
			    <div class="col-sm-8">
			      <input type="text" class="form-control" id="priority" value="${news.priority }" name="priority" placeholder="优先值（越大排名越前）">
			    </div>
		   </div>
		   
		   <div class="form-group">
			    <label for="content" class="col-sm-2 control-label">内容<code>*</code></label>
			    <div class="col-sm-8">
			      <textarea id="content" name="content" class="form-control ckeditor">${news.content }</textarea>
			    </div>
		   </div>
		    </div><!-- /.box-body -->
            <div class="box-footer">
		   		<button class="btn btn-default" type="reset">重置</button>
                <button class="btn btn-info pull-right" type="submit">保存</button>
		  	</div>
            <input type="hidden" name="id" value="${news.id }"/>
          </form>
          </div>
          </div>
          </div>
         </section>
