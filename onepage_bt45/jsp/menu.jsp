<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><c:if test="${empty menuCurrentPage}">
    <c:set var="menuCurrentPage" value="${info.root}" scope="request" />
</c:if>
<c:if test="${not empty menuDepth}">
	<c:set var="menuDepth" value="${menuDepth+1}" scope="request" />
</c:if>
<c:if test="${empty menuDepth}">
	<c:set var="menuDepth" value="1" scope="request" />
</c:if>
<c:if test="${fn:length(menuCurrentPage.children)>0}">
	<nav class="navbar navbar-expand-lg fixed-top navbar-shrink"  id="mainNav">
		<div class="container">
	        <jsp:include page="../logo.jsp?cssClass=navbar-brand" />		
			 <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
               <i class="fa fa-bars"></i>          
             </button>
			<div class="collapse navbar-collapse" id="navbarResponsive">			 
				<ul class="navbar-nav ml-auto${menuDepth>1?' dropdown-menu':''}">
					<c:set var="index" value="1" />
					<c:forEach var="child" items="${menuCurrentPage.children}" varStatus="status">
						<c:if test="${child.visible && not empty child.link}">
							<li
								class="nav-item ${child.visibleChildren?'dropdown ':''}page_${child.name} depth-${menuDepth} index-${status.index}${status.last?' last':''} ${child.selected?contentContext.currentTemplate.selectedClass:''}${child.lastSelected?' last':''} item-${index}">
								<a class="nav-link js-scroll-trigger" ${!child.realContent && info.openExternalLinkAsPopup?'target="blanck"':''} href="${child.link}">
									${child.info.label} <c:if test="${child.selected}"><span class="sr-only">(${i18n.view['global.current-page']})</span></c:if>
								</a>
							</li>
							<c:set var="index" value="${index+1}" />
						</c:if>
					</c:forEach>
				</ul>
			</div>
		</div>
	</nav>
</c:if>
<c:set var="menuDepth" value="${menuDepth-1}" scope="request" />
