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
	<nav id="main-nav" class="navbar ajax-nav navbar-light navbar-expand-lg${param.fix?' fixed-top':''} ">
		<a class="navbar-brand" href="${info.rootURL}">${info.globalTitle}</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#mainNavBar" aria-controls="mainNavBar" aria-expanded="false" aria-label="Toggle navigation" lang="en">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse justify-content-end ajax-nav" id="mainNavBar">
			<div class="navbar navbar-expand-lg">
				<ul class="justify-content-end navbar-nav ${menuDepth>1?' dropdown-menu':''}">
					<c:set var="index" value="1" />
					<c:forEach var="child" items="${menuCurrentPage.children}" varStatus="status">
						<c:if test="${child.visible && not empty child.link}">
							<li	class="nav-item read-${child.readAccess} ${child.visibleChildren?'dropdown ':''}page_${child.name} depth-${menuDepth} index-${status.index}${status.last?' last':''} ${child.selected?contentContext.currentTemplate.selectedClass:''}${child.lastSelected?' last':''} item-${index}">
								<a class="nav-link" ${!child.realContent && info.openExternalLinkAsPopup?'target="blanck"':''} href="${child.link}" data-page="${child.name}" title="${child.info.title}">
									${child.info.label} <c:if test="${child.selected}"><span class="sr-only">(${i18n.view['global.current-page']})</span></c:if>
								</a>
							</li>
							<c:set var="index" value="${index+1}" />
						</c:if>
					</c:forEach>
				</ul>
			</div>
		</div>		
	<c:if test="${param.intranet && not empty info.userName}">
		<a class="profile btn btn-image btn-secondary bg-light border-light" href="${info.pageByName['registration'].url}">
			<span class="avatar"><img src="${info.currentUserAvatarUrl}" alt="avatar" /></span>
			<div class="btn-body"><span class="username text-dark">${info.userLabel}</span></div>	
		</a>
	</c:if>
	</nav>
</c:if>
<c:set var="menuDepth" value="${menuDepth-1}" scope="request" />