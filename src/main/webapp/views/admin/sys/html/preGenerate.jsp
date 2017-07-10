<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="/views/commons/include.jsp" %>
<!DOCTYPE >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>公司信息</title>
<script type="text/javascript">
	function nextStep(){
		var value = $("input[name='style']:checked").val();
		location.href='${ctx}/admin/sys/html/doGenerate?style='+value;
	}
</script>
</head>
<body>
	<section id="main" class="column">
	<jsp:include page="/views/admin/commons/message.jsp"/>
		<article class="module width_full">
		<header>
		<h3 class="tabs_involved">选择风格</h3>
		</header>
		<div class="tab_container">
		<div id="tab1" class="tab_content">
			<form class="form-inline">
			  <ul class="list-inline">
			  <li>&nbsp;</li>
			  <li class="text-center"><img src="${ctx}/resources/images/style1_small.png" style="height:65px;cursor: pointer; " 
			  	class="img-thumbnail" alt="风格1" onclick="window.open('${ctx}/resources/images/style1_large.png')"><br/>
			  	<div class="radio">
				  <label>
				    <input type="radio" name="style" id="style1" value="0" checked>风格1
				  </label>
				</div>
			  </li>
			  <li class="text-center"><img src="${ctx}/resources/images/style2_small.png" style="height:65px;cursor: pointer;" 
			  	class="img-thumbnail" alt="风格2" onclick="window.open('${ctx}/resources/images/style2_large.png')"><br/>
			  	<div class="radio">
				  <label>
				    <input type="radio" name="style" id="style2" value="1">风格2
				  </label>
				</div>
			  </li>
			</ul>
			<div class="form-group">
			  <div class="col-sm-offset-4 col-sm-8">
			  	<button type="button" class="btn btn-primary" onclick="nextStep();">下一步</button>
			    </div>
			  </div>
			</form>
		</div>
		</div>
		</article>
	</section>
</body>
</html>