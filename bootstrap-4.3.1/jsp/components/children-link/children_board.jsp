<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><c:if test="${fn:length(children)>0}">
<c:if test="${not empty title}"><h3>${title}</h3></c:if>
<div id="board-${compid}" class="board-group children-link">
<c:set var="currentPageCached" value="${contentContext.currentPageCached}" /><c:set var="lineNumber" value="0" />
<c:forEach var="child" items="${children}" varStatus="status">
<c:if test="${status.index%3==0}"><c:set var="lineNumber" value="${lineNumber+1}" /></c:if>
<c:if test="${!child.realContent || lineNumber == 2}"><a href="${child.linkOn}"<c:if test="${!child.realContent}"> target="_blank"</c:if>></c:if>
<div class="board-out">
<div class="board board-${status.index+1} row align-items-center ${status.index%3==0?'first':''} line-${lineNumber}" style="background-image: url('${child.image.previewURL}'); background-size: cover;" >	 
	<h3 class="col">${child.fullLabel}</h3>
	<c:if test="${child.realContent && lineNumber != 2}"><div class="subboard-out"><div class="subboard"><div class="subboard-in">
		<jsp:setProperty name="contentContext" property="allLanguage" value="${child.contentLanguage}" /><jsp:setProperty name="contentContext" property="currentPageCached" value="${child.page}" />		
		<jsp:include page="/jsp/view/content_view.jsp?area=${contentContext.area}" />
	</div></div></div></c:if> 	
</div>
</div>
<c:if test="${!child.realContent}"></a></c:if>
</c:forEach>
</div>
<jsp:setProperty name="contentContext" property="currentPageCached" value="${currentPageCached}" /> 
</c:if>