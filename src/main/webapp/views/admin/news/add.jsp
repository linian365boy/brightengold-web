<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/views/commons/include.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }resources/js/skins/blue.css" rel="stylesheet"/>
 <script type="text/javascript" src="${ctx }resources/js/jquery-1.11.1.min.js"></script>
 <script type="text/javascript" src="${ctx }resources/js/ckEditor/ckeditor.js"></script>
 <script type="text/javascript" src="${ctx }resources/js/ckEditor/lang/zh-cn.js"></script>
 <script type="text/javascript" src="${ctx }resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.metadata.js"></script>
<link href="${ctx }resources/css/bootstrap.min.css" rel="stylesheet"/>
<link href="${ctx }resources/css/style.css" rel="stylesheet"/>
<!--引入CSS-->
<link rel="stylesheet" type="text/css" href="${ctx }resources/js/plugins/webuploader/webuploader.css">
<link rel="stylesheet" type="text/css" href="${ctx }resources/css/upload.css">
<!--引入JS-->
<script type="text/javascript" src="${ctx }resources/js/plugins/webuploader/webuploader.js"></script>
<script type="text/javascript" src="${ctx }resources/js/upload.js"></script>
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
<title>添加新闻</title>
<script type="text/javascript">
	var uploader;
	var basePath = "${ctx}";
	$(document).ready(function(){
		changeContent($("#type1")[0]);
		$("#type1").prop("checked","checked");
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
			}
		});
	});
	
	function changeCol(obj){
		var colId = $(obj).val();
		$.post("${ctx }admin/sys/col/getChildren/"+colId+".html",{
			id:colId
		},function(json){
			$(obj).next().remove();
			var html = "";
			if(json.length>0){
				html+='<select class="col-xs-3 selectpicker" name="secondColId" >';
				html+='<option value="">--请选择--</option>';
				$.each(json,function(i,n){
					html+="<option value='"+n[0]+"'>"+n[1]+"</option>";
				});
				html+="</select>";
			}
			$(obj).after(html);
		},"json");
	};
	
	function changeContent(obj){
		if(obj.value==1){
			var len = $(".imgWrap").find("img").size();
			if(len>0){
				art.dialog.confirm('你确定清空队列中的图片？',function(){
					$(".filelist").find("span.cancel").click();
					$(".typeclassb").hide();
					$(".typeclass").show();
				},function(){
					$("#type2").prop("checked","checked");
				});
			}else{
				//图文
				$(".typeclassb").hide();
				$(".typeclass").show();
			}
		}else{
			var inputObjs = $(".typeclass").find(".form-control");
			var flag = false;
			var data = CKEDITOR.instances.content.getData();
			$.each(inputObjs,function(i,n){
				if($(n).val()!='' || data!=''){
					flag = true;
				}
			});
			if(flag){
				art.dialog.confirm('你确定清空所填信息？',function(){
					$.each(inputObjs,function(i,n){
						$(n).val("");
					});
					CKEDITOR.instances.content.setData("");
					if("undefined"==typeof(uploader)){
						initUpload();
					}
					$(".typeclass").hide();
					$(".typeclassb").show();
				},function(){
					$("#type1").prop("checked","checked");
				});
			}else{
				if("undefined"==typeof(uploader)){
					initUpload();
				}
				$(".typeclass").hide();
				$(".typeclassb").show();
			}
		}
	}
</script>
</head>
<body>
	<section id="main" class="column">
		<article class="module width_full">
		<header>
		<h3 class="tabs_involved">添加新闻</h3>
		</header>
		<div class="tab_container">
		<div id="tab1" class="tab_content">
		<form action="${ctx }admin/news/add.html" class="form-horizontal" id="form" method="post">
			<div class="form-group">
			    <label for="title" class="col-sm-2 control-label">栏目<span class="asterisk">*</span></label>
			    <div class="row">
			    	<div class="col-xs-8" style="overflow:hidden;">
			    		<c:if test="${fn:length(parentCol)>0 }">
			    			<select class="col-xs-3 selectpicker" name="firstColId" onchange="changeCol(this);">
			    				<option value="">--请选择--</option>
				    			<c:forEach items="${parentCol }" var="col">
				    				<option value="${col[0] }">${col[1] }</option>
				    			</c:forEach>
				      		</select>
			    		</c:if>
			    	</div>
			    </div>
		   </div>
			<div class="form-group">
			    <label for="title" class="col-sm-2 control-label">标题<span class="asterisk">*</span></label>
			    <div class="col-sm-8">
			      <input type="text" class="form-control" id="title" name="title" placeholder="标题">
			    </div>
		   </div>
			<div class="typeclass">
		   <div class="form-group">
		   		<div class="form-group">
					<label for="introduce" class="col-sm-2 control-label">摘要</label>
					<div class="col-sm-8">
						<textarea rows="3" class="form-control" id="introduce" placeholder="摘要" name="introduce"></textarea>
					</div>
				</div>
			</div>
			<div class="form-group">
			    <label for="keyWords" class="col-sm-2 control-label">关键字</label>
			    <div class="col-sm-8">
			      <input type="text" class="form-control" id="keyWords" name="keyWords" placeholder="关键字（多个以英文;隔开）">
			    </div>
		   </div>
		   
		   <div class="form-group">
			    <label for="priority" class="col-sm-2 control-label">优先值</label>
			    <div class="col-sm-8">
			      <input type="text" class="form-control" id="priority" name="priority" placeholder="优先值（越大排名越前）">
			    </div>
		   </div>
		   
		   <div class="form-group">
			    <label for="content" class="col-sm-2 control-label">内容<span class="asterisk">*</span></label>
			    <div class="col-sm-9">
			      <textarea id="content" name="content" class="form-control ckeditor"></textarea>
			    </div>
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