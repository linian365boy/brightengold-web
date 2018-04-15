<%@ include file="/views/commons/include.jsp"%>
<c:if test="${!empty success}">
	<h4 class="alert_success">${success}</h4>
	<c:set var="success" value="" scope="session"/>
</c:if>
<c:if test="${!empty error}">
	<h4 class="alert_error">${error}</h4>
	<c:set var="error" value="" scope="session"/>
</c:if>
<c:if test="${!empty info}">
	<h4 class="alert_info">${info}</h4>
	<c:set var="info" value="" scope="session"/>
</c:if>
