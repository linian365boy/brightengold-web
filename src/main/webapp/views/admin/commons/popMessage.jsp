<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/views/commons/include.jsp"%>
<c:if test="${!empty success}">
	<script>
	art.dialog({content:"${success}",time:2,cancelVal: '关闭',cancel: true});
	</script>
	<c:set var="success" value="" scope="session"/>
</c:if>
<c:if test="${!empty error}">
	<script>
	art.dialog({content:"${error}",time:2,cancelVal: '关闭',cancel: true});
	</script>
	<c:set var="error" value="" scope="session"/>
</c:if>
<c:if test="${!empty info}">
	<script>
	art.dialog({content:"${info}",time:2,cancelVal: '关闭',cancel: true});
	</script>
	<c:set var="info" value="" scope="session"/>
</c:if>
<c:if test="${!empty block}">
	<script>
	art.dialog({content:"${block}",time:2,cancelVal: '关闭',cancel: true});
	</script>
	<c:set var="block" value="" scope="session"/>
</c:if>