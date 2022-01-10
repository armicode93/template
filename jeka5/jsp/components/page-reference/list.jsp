<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib
	prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><c:if
	test="${fn:length(pages)>0}">
	<c:if test="${not empty title}">
		<h2>${title}</h2>
	</c:if>
	<c:set var="pageRef" value="${comp}" />
	<ul class="page-list">
		<c:forEach items="${pages}" var="page" varStatus="status">
			<li class="item ${status.index%2==0?'odd':'even'} ${page.toTheTopLevel>0?'top':''}">
				<a ${popup?'class="popup" ':''}title="${page.titleForAttribute}" href="${page.linkOn}" ${globalContext.openExternalLinkAsPopup && !page.linkRealContent?'target="_blank"':''}>
					${page.title}
				</a>
			</li>
		</c:forEach>
	</ul>
</c:if>