<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="/views/commons/include.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- jQuery 2.2.3 -->
<script src="/resources/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- jQuery form plugin -->
<script src="/resources/plugins/jQueryForm/jquery.form.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="/resources/dist/css/AdminLTE.min.css">
<script type="text/javascript">
	$(document).ready(function(){
		$("#form").ajaxForm({
			dataType:'json',
			success:function(json) { 
	    		if(json.code==200){
	    			$("button[name='refresh']",top.document).click();
	    			top.art.dialog.list['setPublish'].close();
	    		}else{
	    			$("span.help-block").html(json.message);
	    			$(".has-error").removeClass("hide");
	    		}
			}
		});
	});
</script>
</head>
<body>
	<form class="form-horizontal content" id="form" method="post" action="${ctx}/admin/sys/col/${column.id }/setPublishContent" target="_parent">
		 <div class="form-group">
		    <label for="name" class="col-sm-3 control-label">中文名称</label>
		    <div class="col-sm-7">
		      <input type="text" class="form-control" value="${column.name }" disabled id="name">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="enName" class="col-sm-3 control-label">英文名称</label>
		    <div class="col-sm-7">
		      <input type="text" class="form-control" value="${column.enName }" disabled id="enName">
		    </div>
		  </div>
		   <div class="form-group">
		   	<label for="type" class="col-sm-3 control-label">页面填充</label>
		    <div class="col-sm-7">       
	        	<select class="form-control" name="type" id="type">
	        		<option value="1" ${column.type==1?'selected':'' }>使用产品列表填充</option>
	        		<option value="2" ${column.type==2?'selected':'' }>使用文章标题填充</option>
	        		<option value="0" ${column.type==0?'selected':'' }>使用信息内容填充</option>
	        	</select>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="hasNeedForm" class="col-sm-3 control-label">是否嵌入表单</label>
		    <div class="col-sm-7">
			  <div class="checkbox">
			  	<label>
		      	<input type="checkbox" name="hasNeedForm" 
		      		<c:if test="${column.hasNeedForm }">
			 			checked="checked"
			 		</c:if>
		      	> （勾选表示生成的页面嵌入表单）
		    	</label>
		  	</div>
		  </div>
		  </div>
		  <div class="form-group has-error hide">
			  	  <label class="col-sm-3 control-label">&nbsp;</label>
                  <span class="help-block"></span>
               </div>
	  <div class="form-group">
	    <div class="col-sm-offset-4 col-sm-8">
	      <button type="submit" class="btn btn-primary">保存</button>
	    </div>
	  </div>
	</form>
</body>
</html>