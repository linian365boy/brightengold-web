<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="../../../commons/include.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改用户信息</title>
<!-- jQuery 2.2.3 -->
<script src="/resources/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- jQuery form plugin -->
<script src="/resources/plugins/jQueryForm/jquery.form.min.js"></script>
<script type="text/javascript" src="/resources/plugins/jQueryValidate/jquery.validate.js"></script>
<script type="text/javascript" src="/resources/plugins/jQueryValidate/jquery.metadata.js"></script>
<!-- Bootstrap 3.3.6 -->
<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="/resources/dist/css/AdminLTE.min.css">
<link rel="stylesheet" type="text/css" href="/resources/dist/css/customUse.css" />
<script type="text/javascript">
$(document).ready(function(){
	$("#form").validate({
			rules:{
				"username":{
					required:true,
					remote:{
						type:'POST',
						url:'${ctx}/admin/sys/user/existUser',
						data:{
							username:function(){
								return $("#username").val();
							},
							u:function(){
								return "${model.username}";
							}
						}
					}
				}
			},
			messages:{
				"username":{
					required:"用户名不能为空",
					remote:"用户名已存在"
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
				    		if(json.code==200){
				    			$("button[name='refresh']",top.document).click();
				    			top.art.dialog.list['bianji'].close();
				    		}else{
				    			$("span.help-block").html(json.message);
				    			$(".has-error").removeClass("hide");
				    		}
			        }
				});
			}
	});
});
</script>
</head>
<body>
	<form id="form" class="form-horizontal content" action="${ctx}/admin/sys/user/${model.id }/update" method="post" target="_parent">
	<div class="form-group">
	    	<label for="username" class="col-sm-2 control-label">用户名<code>*</code></label>
			<div class="col-sm-8">
			     <input type="text" class="form-control" id="username" value="${model.username }" name="username"/>
			</div>
		</div>
		
		<div class="form-group">
	    	<label for="realName" class="col-sm-2 control-label">姓名</label>
			<div class="col-sm-8">
			     <input type="text" class="form-control" value="${model.realName }" id="realName" name="realName"/>
			</div>
		</div>
		<c:forEach items="${roles }" var="myRole">
           	<c:set var="mr" value="${myRole.name }" scope="page"/>
        </c:forEach>
		<div class="form-group">
		    <label for="roles" class="col-sm-2 control-label">角色分配</label>
		    	<div class="col-xs-8" style="overflow:hidden;">
		    		<select name="role" id="roles" class="col-xs-5 selectpicker">
		    			<option>--请选择--</option>
		            	<c:forEach items="${rolesAjax }" var="r">
		            		<option value="${r.name }"
		            			<c:if test="${r.name eq mr }">
		            				selected="selected"
		            			</c:if>
		            		>
		            			${r.describes }
		            		</option>
		            	</c:forEach>
		            </select>
		    	</div>
		  </div>
		  <div class="form-group">
		  	<div class="col-sm-offset-2 col-sm-10">
                        <div class="checkbox">
                          <label>
                            <input type="checkbox" name="enabled" <c:if test="${model.enabled }">checked</c:if> /> （勾选表示启用此账号，否则禁用）
                          </label>
                        </div>
                      </div>
		  </div>
		  <div class="form-group has-error hide">
			  	  <label class="col-sm-2 control-label">&nbsp;</label>
                  <span class="help-block"></span>
               </div>
            <input type="hidden" name="id" value="${model.id }"/>
            <div class="form-group">
			  <div class="col-sm-offset-4 col-sm-8">
			  	<button type="submit" class="btn btn-primary">保存</button>
			      <button class="btn btn-default" type="reset">重置</button>
			    </div>
			  </div>
          </form>
</body>
</html>