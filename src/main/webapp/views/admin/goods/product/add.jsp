<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="../../../commons/include.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品新增</title>
<script type="text/javascript" src="${ctx }resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${ctx }resources/js/ckEditor/ckeditor.js"></script>
<script type="text/javascript" src="${ctx }resources/js/ckEditor/lang/zh-cn.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.metadata.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.equalHeight.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx }resources/css/style.css?${style_v}" />
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
				"photo":{
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
					required:"标题不能为空！"
				},
				"photo":{
					required:"图片不能为空！"
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
			}
		});
		
		$.getJSON("${ctx}admin/goods/category/getParentByAjax/0.html",function(returnJson){
			var json = $(returnJson);
			var str = "";
			for(var i=0;i<json.length;i++){
				str+="<option value="+json.get(i)[0]+">"+json.get(i)[1]+"</option>";
			}
			$("#parentCs").append(str);
			changeCol($("#parentCs"));
		});
	});
	
	function changeCol(obj){
		var cateId = $(obj).val();
		$.post("${ctx }admin/goods/category/getChildrenCate/"+cateId+".html",{
			parentCateId:cateId
		},function(json){
			$(obj).next().remove();
			var html = "";
			if(json && json.length>0){
				html+='<select class="col-xs-5 selectpicker" name="childrenC" >';
				html+="<option value='0'>==请选择==</option>";
				$.each(json,function(i,n){
					html+="<option value='"+n[0]+"'>"+n[1]+"</option>";
				});
				html+="</select>";
			}
			$(obj).after(html);
		},"json");
	};
	</script>
</head>
<body>
	<section id="main" class="column">
		<article class="module width_full">
		<header>
		<h3 class="tabs_involved">新增商品</h3>
		</header>
		<div class="tab_container">
		<div id="tab1" class="tab_content">
	<form id="form" class="form-horizontal" action="${ctx }admin/goods/product/add.html" 
		method="post" enctype="multipart/form-data">
             <div class="form-group">
			    <label for="enName" class="col-sm-1 control-label">商品名称<span class="asterisk">*</span></label>
			    <div class="col-sm-8">
			      <input type="text" class="form-control" id="enName" name="enName" placeholder="商品名称">
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="introduce" class="col-sm-1 control-label">商品简介</label>
			    <div class="col-sm-8">
			      <textarea class="form-control" rows="3" name="introduce" id="introduce"></textarea>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="photo" class="col-sm-1 control-label">商品图片<span class="asterisk">*</span></label>
			    <div class="col-sm-8">
			      <input type="file" name="photo" id="photo" class="required" accept="image/*"/>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="parentCs" class="col-sm-1 control-label">商品分类<span class="asterisk">*</span></label>
			    <div class="col-sm-8">
			      <select name="parentC" id="parentCs" class="col-xs-5 selectpicker" onchange="changeCol(this);">
            		</select>
			    </div>
			  </div>
			  <div class="form-group">
			  	<label for="parentCs" class="col-sm-1 control-label">是否热门</label>
			  	<div class="col-sm-8">
				  <div class="checkbox">
				  	<label>
				      <input type="checkbox" name="hot"> （勾选表示热门，否则非热门商品）
				    </label>
				  </div>
				  </div>
			  </div>
			  <div class="form-group">
			    <label for="keyWords" class="col-sm-1 control-label">关键字</label>
			    <div class="col-sm-8">
			      <input type="text" class="form-control" id="keyWords" name="keyWords" placeholder="商品关键字(以英文分号隔开不同的关键字)">
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="priority" class="col-sm-1 control-label">排序号</label>
			    <div class="col-sm-8">
			      <input type="text" class="form-control" id="priority" name="priority" placeholder="排序号，越大排名越前">
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="description" class="col-sm-1 control-label">产品详情<span class="asterisk">*</span></label>
			    <div class="col-sm-9">
			      <textarea id="description" rows="16" name="description" class="form-control ckeditor"></textarea>
			    </div>
		   </div>
            <div class="form-group">
			  <div class="col-sm-offset-4 col-sm-8">
			  	<button type="submit" class="btn btn-primary">保存</button>
			      <button class="btn btn-default" type="reset">重置</button>
			    </div>
			  </div>
          </form>
          </div>
          </div>
          </article>
       </section>
</body>
</html>