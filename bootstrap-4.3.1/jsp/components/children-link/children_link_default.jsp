<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><c:if test="${fn:length(children)>0}">
<c:if test="${not empty title}">
	<h2>${title}</h2>
</c:if>
<ul class="links children-link nav flex-column nav-pills">
<c:forEach var="child" items="${children}" varStatus="status">
	<li class="${child.selected?'selected':'unselected'} ${status.index % 2 == 0?'odd':'even'} nav-item"><a class="${popup?'popup ':''}nav-link${child.selected?' active':''}" href="${child.url}">${child.fullLabel}</a></li>
</c:forEach>
</ul>
</c:if> 