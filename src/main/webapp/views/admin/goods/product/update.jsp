<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="../../../commons/include.jsp" %>
<title>商品编辑</title>
<script type="text/javascript" src="${ctx }resources/plugins/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${ctx }resources/plugins/ckeditor/lang/zh-cn.js"></script>
<script type="text/javascript" src="/resources/plugins/jQueryValidate/jquery.validate.js"></script>
<script type="text/javascript" src="/resources/plugins/jQueryValidate/jquery.metadata.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/dist/css/customUse.css" />
<style type="text/css">
	.selectpicker {
		background-color: #fff;
	    background-image: none;
	    border: 1px solid #ccc;
	    border-radius: 4px;
	    box-shadow: 0 1px 1px rgba(0, 0, 0, 0.075) inset;
	    color: #555;
	    display: block;
	    font-size: 14px;
	    height: 34px;
	    line-height: 1.42857;
	    padding: 6px 12px;
	    transition: border-color 0.15s ease-in-out 0s, box-shadow 0.15s ease-in-out 0s;
	    vertical-align: middle;
	}
</style>
<script type="text/javascript">
$(document).ready(function(){
	$("#form").validate({
		rules:{
			"enName":{
				required:true
			},
			"category":{
				required:true
			},
			"description":{
				required:true
			},
			"priority":{
				number:true
			}
		},
		messages:{
			"enName":{
				required:"商品名称不能为空！"
			},
			"category":{
				required:"分类不能为空！"
			},
			"description":{
				required:"详情不能为空！"
			},
			"priority":{
				number:"请输入数字！"
			}
		},
		highlight: function(element) {
		      jQuery(element).closest('.form-group').removeClass('has-success').addClass('has-error');
		},
		success: function(element) {
		      jQuery(element).closest('.form-group').removeClass('has-error');
		},
		submitHandler: function(form){
			$(form).ajaxSubmit({
				dataType:'json',
				success:function(json) {
		            if(JSON.stringify(json).indexOf("login")!=-1){
			    		 location.href="${ctx}admin/login.html";
			    	}else{
			    		if(json.code==200){
			    			$("ul.treeview-menu.menu-open a").click();
			    		}else{
			    			
			    		}
			    	}
		        }
			});
		}
	});
	CKEDITOR.replace('description');
});
	function changeCol(obj){
		var cateId = $(obj).val();
		var currentCateId = "${model.categoryId}";
		$.post("${ctx }admin/goods/category/getChildrenCate/"+cateId+".html",{
			parentCateId:cateId
		},function(json){
			$(obj).next().remove();
			var html = "";
			if(json && json.length>0){
				html+='<select class="col-xs-5 selectpicker" name="childrenC" >';
				html+="<option value='0'>==请选择==</option>";
				$.each(json,function(i,n){
					html+="<option value='"+n.id+"' >"+n.enName+"</option>";
				});
				html+="</select>";
			}
			$(obj).after(html);
		},"json");
	};
</script>
	
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
    
	<section class="content">
		<div class="row">
		<div class="col-md-12">
		<div class="box box-info">
		<div class="box-header with-border">
                  <h3 class="box-title">编辑产品
                  </h3>
                  <label class="error">编辑产品失败！</label>
                </div><!-- /.box-header -->
	<form id="form" class="form-horizontal"
	 action="${ctx }admin/goods/product/${model.id }/update.html" method="post" enctype="multipart/form-data">
	 <div class="box-body">
	 	<div class="form-group">
			    <label for="enName" class="col-sm-2 control-label">商品名称<code>*</code></label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" value="${model.enName }" id="enName" name="enName" placeholder="商品名称">
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="introduce" class="col-sm-2 control-label">商品简介</label>
			    <div class="col-sm-10">
			      <textarea class="form-control" rows="3" name="introduce" id="introduce">${model.introduce }</textarea>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="photo" class="col-sm-2 control-label">商品图片<code>*</code></label>
			    <div class="col-sm-10">
			    <img alt="${model.enName }" width="100px" height="100px" title="${model.enName }" src="${ctx }resources/${model.picUrl}" >
			      <input type="file" name="photo" id="photo"/>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="parents" class="col-sm-2 control-label">商品分类<code>*</code></label>
			    <div class="col-sm-10">
			    <c:set value="${category.parentId }" var="parentCateId" scope="page"/>
	            <c:choose>
	             	<c:when test="${empty parentCateId }">
	             	<!-- 一级分类 -->
				      <select name="parents" id="parents" class="col-xs-5 selectpicker" onchange="changeCol(this);">
					      <c:forEach items="${parents }" var="parent">
		            			<option value="${parent.id }"
		            				<c:if test="${parent.id eq model.categoryId }">
			            				selected="selected"
			            			</c:if>
			            			>
		            			${parent.enName }
		            			</option>
		            		</c:forEach>
	            		</select>
	            		<select class="col-xs-5 selectpicker" name="childrenC">
	           				<option value='0'>==请选择==</option>
	           				<c:forEach items="${category.children }" var="childrenC">
		      					<option value="${childrenC.id }" >${childrenC.enName }</option>
		      				</c:forEach>
	           			</select>
	             	</c:when>
	            	<c:otherwise>
	            	<!-- 二级分类 -->
	            		<select name="parents" id="parents" class="col-xs-5 selectpicker" onchange="changeCol(this);">
					      <c:forEach items="${parents }" var="parent">
		            			<option value="${parent.id }"
		            				<c:if test="${parent.id eq parentCateId }">
			            				selected="selected"
			            			</c:if>
			            			>
		            			${parent.enName }
		            			</option>
		            		</c:forEach>
	            		</select>
	            		<select class="col-xs-5 selectpicker" name="childrenC">
	           				<option value='0'>==请选择==</option>
	           				<c:forEach items="${parentCategory.children }" var="childrenCate">
		      					<option value="${childrenCate.id }" 
		      					<c:if test="${childrenCate.id eq model.categoryId }">
		      						selected="selected"
		      					</c:if>
		      					>${childrenCate.enName }</option>
		      				</c:forEach>
	           			</select>
	            	</c:otherwise>
	            </c:choose>
			    </div>
			  </div>
			  <div class="form-group">
                      <div class="col-sm-offset-2 col-sm-10">
                        <div class="checkbox">
                          <label>
                            <input type="checkbox" name="hot" <c:choose>
			 		<c:when test="${model.hot }">
			 			checked="checked"
			 		</c:when>
			 	</c:choose>/> 是否热门（勾选表示热门，否则非热门商品）
                          </label>
                        </div>
                      </div>
                    </div>
			  <div class="form-group">
			    <label for="keyWords" class="col-sm-2 control-label">关键字</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" id="keyWords" value="${model.keyWords }" name="keyWords" placeholder="商品关键字(以英文分号隔开不同的关键字)">
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="priority" class="col-sm-2 control-label">排序号</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" id="priority" name="priority" placeholder="排序号，越大排名越前">
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="description" class="col-sm-2 control-label">产品详情<code>*</code></label>
			    <div class="col-sm-10">
			      <textarea id="description" rows="16" name="description" class="form-control ckeditor">${model.description }</textarea>
			    </div>
		   	</div>
		   <input type="hidden" name="id" value="${model.id }"/>
		   </div>
            <div class="box-footer">
                    <button class="btn btn-default" type="reset">重置</button>
                    <button class="btn btn-info pull-right" type="submit">保存</button>
            </div><!-- /.box-footer -->
          </form>
          </div>
          </div>
          </div>
   </section>