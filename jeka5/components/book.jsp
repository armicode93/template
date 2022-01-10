<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" 
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" 
%><%@ taglib uri="/WEB-INF/javlo.tld" prefix="jv"%>
<c:url var="cssURL" value="${info.absoluteRootTemplateURL}/css/tickoweb.css"></c:url>
<jv:enc64 var="encodedURL" value="${cssURL}" />
<c:url var="tickedWebURL" value="${url.value}">
	<c:param name="css_url" value="${encodedURL}" />
	<c:param name="lang" value="${info.requestContentLanguage}" />
</c:url>
<c:if test="${!soldoutFestival}">
<iframe src="${tickedWebURL}"></iframe>
</c:if><c:if test="${soldoutFestival}">
<div class="soldout"><img src="${info.rootTemplateURL}/img/soldout.png" alt="sold out" lang="en" /></div>
</c:if>