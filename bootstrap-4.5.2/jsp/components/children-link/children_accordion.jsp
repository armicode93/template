<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><c:if test="${fn:length(children)>0}">
	<c:if test="${not empty title}">
		<h3>${title}</h3>
	</c:if>
	<c:set var="localCompId" value="${compid}" />
	<div id="accordion_${localCompId}" class="panel-group children-link">
		<c:set var="currentPageCached" value="${contentContext.currentPageCached}" />
		<c:forEach var="child" items="${children}" varStatus="status">
			<c:if test="${child.realContent}">
				<div class="card">
					<div class="card-header">
						<h4 class="panel-title">
							<a data-toggle="collapse" data-parent="#accordion_${localCompId}" href="#col_${compid}_${status.index}">${child.fullLabel}</a>
						</h4>
					</div>
					<div class="collapse multi-collapse" id="col_${compid}_${status.index}">
						<div class="card-body">
							<jsp:setProperty name="contentContext" property="allLanguage" value="${child.contentLanguage}" />
							<jsp:setProperty name="contentContext" property="currentPageCached" value="${child.page}" />
							<jsp:include page="/jsp/view/content_view.jsp?area=${contentContext.area}" />
						</div> <!--  /card-body -->
					</div>
				</div>
			</c:if>
		</c:forEach>
		<jsp:setProperty name="contentContext" property="currentPageCached" value="${currentPageCached}" />
	</div>
</c:if>