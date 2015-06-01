<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="../../commons/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品分类编辑</title>
<link href="${ctx }resources/js/skins/blue.css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }resources/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.metadata.js"></script>
<link rel="stylesheet" type="text/css"
	href="${ctx }resources/css/style.css" />
<script type="text/javascript">
	$("#form").validate({
			rules:{
				"enName":{
					required:true,
					remote:{
						type:'POST',
						url:'${ctx}admin/goods/category/existCategory',
						data:{
							username:function(){
								return $("#enName").val();
							},
							u:function(){
								return "${model.enName}";
							}
						}
					}
				}
			},
			messages:{
				"enName":{
					required:"商品分类不能为空",
					remote:"该商品分类已存在，请更换！"
				}
			}
	});

function formSubmit(){
	var categoryId = "${model.id}";
	$("#form").attr("action","${ctx}admin/goods/category/"+categoryId+"/update");
	$("#form").submit();
}
</script>
</head>
<body>
	<form id="form" action="#" method="post" target="_parent">
            <div id="label"><label for="pName">一级分类：</label></div>
             <select name="parents" id="parents" style="width: 158px;margin-left: 0px;margin-bottom: 5px;">
            <c:forEach items="${parents }" var="parent">
            	<option value="${parent[0] }"
            			<c:if test="${parent[0] eq model.parent.id }">
            				selected="selected"
            			</c:if>
            		>
            			${parent[1] }
            		</option>
            </c:forEach>
            </select>
             <br />
            <div id="label"><label for="enName">名称：</label></div>
            <input name="enName" value="${model.enName }"  type="text" tabindex="4" />
             <br />
            <br/>
            <input type="hidden" name="id" value="${model.id }"/>
            <div class="aui_buttons" style="width:388px;">
              <button class="aui_state_highlight" type="submit" onclick="formSubmit();">提交</button>
              <button type="reset">重置</button>
            </div>
          </form>
</body>
</html>