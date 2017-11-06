<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../../commons/include.jsp" %>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>rockechogroup---${news.title }</title>
	<meta http-equiv="keywords" content="${news.keyWords }"/>
	 <link href="${ctx }/resources/css/basic.css" rel="stylesheet"/>
	 <%@include file="/views/admin/commons/listJsCss.jsp" %>
	 <%@include file="/views/admin/commons/jsCss.jsp" %>
</head>
  <body>
  <jsp:include page="/views/admin/commons/header.jsp"/>
  <div class="wrapper cFloat">
	<div class="content">
        <div class="fl cFloat" id="left">
        	<div class="info_text">
            	<h1>${news.title}</h1>
                <div class="titBar">点击率：<span id="clickcount">${news.clicks }</span> | 发表时间：<fmt:formatDate value="${news.publishDate}" pattern="yyyy-MM-dd"/></div>
                <div class="bd cFloat">
                	                	<div class="introduction"><strong>摘要：</strong>&#12288;&#12288;${news.introduce }</div>
					                    <div class="bd-content" style="word-wrap: break-word;word-break: normal; ">
					                    ${news.content }
                    </div>
                    <div class="info-text-foot cFloat">
                		<div class="fl">
                		标签：<c:forTokens items="${news.keyWords }" delims=";" var="keyword" varStatus="n">
                			<a href="${ctx }/cu/news/news_li.do?title=${keyword}">${keyword }</a>&nbsp;&nbsp;
                			<c:if test="${!n.last }">
                				|&nbsp;&nbsp;
                			</c:if>
                		</c:forTokens>
                		</div>
					</div>
                    <div class="hq-pagination hq-pagination-centered">
            			<div id="pager"></div>
            		</div><!--end hq-pagination-->
					<!-- Baidu Button END -->
                 </div><!--end bd-->
		</div><!--end info_text-->
    </div><!--end left-->
 </div><!--end content-->
</div>
  </body>
</html>
