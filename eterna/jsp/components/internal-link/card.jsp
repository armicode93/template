<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib uri="/WEB-INF/javlo.tld" prefix="jv"%>
<div class="icon-box">
<a href="${url}" id="${previewID}" class="featured ${comp.style} ${previewCSS}">
	<c:if test="${not empty page.font}"><i class="${page.font}"></i></c:if>
	<c:if test="${empty page.font && not empty page.image}">
		<jv:changeFilter var="newURL" url="${page.image.previewURL}" filter="standard" newFilter="bloc-4-2" />
		<img src="${newURL}" class="img-top" alt="${page.image.description}" />
	</c:if>
	<h${contentContext.titleDepth+1}>${page.titleOrSubtitle}</h${contentContext.titleDepth+1}>
	<p>${page.description}</p>
</a>
</div>