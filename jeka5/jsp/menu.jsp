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
	<c:if test="${param._menufix}"><div class="menu_back_block"></div></c:if>
	
        <nav class="navbar navbar-expand-lg navbar-light">
            <div class="prefix"><span>&nbsp;</span></div>	
		
		<jsp:include page="logo.jsp" />
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#mainNavBar" aria-controls="mainNavBar" aria-expanded="false" aria-label="Toggle navigation">
              <span class="navbar-toggler-icon"></span>
            </button>
		<c:if test="${fn:length(menuCurrentPage.realChildren)>0}">
		</c:if>
		<div class="collapse navbar-collapse" id="mainNavBar">			
				<ul class="navbar-nav mr-auto ${menuDepth>1?' dropdown-menu':''}">
					<c:set var="index" value="1" />					
					<c:forEach var="child" items="${menuCurrentPage.children}" varStatus="status">
						<c:if test="${child.visibleForContext && not empty child.link}">
							<c:set var="dropdown" value="${param._menudropdown && child.visibleChildren}" />
							<c:if test="${param.subchild && child.selected}"><c:set var="selectedSubChild" value="${child}" /></c:if>
							<li	class="nav-item read-${child.readAccess} ${dropdown?'dropdown ':''}page_${child.name} depth-${menuDepth} index-${status.index}${status.last?' last-item':''} ${child.realContentAuto?'real-content ':'not-real-content '}${child.selected?contentContext.currentTemplate.selectedClass:''}${fn:length(child.children)>0?' has-children':' no-children'}${child.lastSelected?' last-item':''} item-${index}">
								<a class="nav-link ${dropdown?'dropdown-toggle ':''}" ${dropdown?'data-toggle="dropdown"':''} ${!child.realContentAuto && info.openExternalLinkAsPopup && not empty child.linkOn?'target="_blank"':''} href="${child.link}" data-page="${child.name}" title="${child.info.title}">
									${child.info.label} <c:if test="${child.selected}"><span class="sr-only">(${i18n.view['global.current-page']})</span></c:if>
								</a>
								<c:if test="${dropdown}">
									<div class="dropdown-menu">
									<c:forEach var="subchild" items="${child.children}" varStatus="substatus">
										<a class="dropdown-item" href="${subchild.url}">${subchild.info.label}</a>
									</c:forEach>
									</div>
								</c:if>
							</li>
							<c:set var="index" value="${index+1}" />
						</c:if>
					</c:forEach>	
					<li class="social-first social nav-item">
	                  <a class="nav-link" target="_blank" href="https://www.facebook.com/jeka.belgium"><i class="fab fa-facebook"></i></a>
	                </li><li class="social nav-item">
	                  <a class="nav-link" target="_blank" href="https://www.instagram.com/jekavzw/"><i class="fab fa-instagram"></i></a>
	                </li>				
				</ul></div>
				<c:if test="${not empty selectedSubChild}">
					<div class="navbar navbar-expand-lg justify-content-${not empty param.menuposition?param.menuposition:'end'} subchild">
						<ul class="justify-content-end navbar-nav ${menuDepth>1?' dropdown-menu':''} nav-pills">
							<c:set var="index" value="1" />					
							<c:forEach var="child" items="${selectedSubChild.children}" varStatus="status">
								<c:if test="${child.visibleForContext && not empty child.link}">
									<c:set var="dropdown" value="${param._menudropdown && child.visibleChildren}" />
									<c:if test="${child.selected}"><c:set var="selectedSubChild" value="${child}" /></c:if>
									<li	class="nav-item read-${child.readAccess} ${dropdown?'dropdown ':''}page_${child.name} depth-${menuDepth} index-${status.index}${status.last?' last-item':''} ${child.realContentAuto?'real-content ':'not-real-content '}${child.selected?contentContext.currentTemplate.selectedClass:''}${fn:length(child.children)>0?' has-children':' no-children'}${child.lastSelected?' last-item':''} item-${index}">
										<a class="nav-link ${dropdown?'dropdown-toggle ':''}" ${dropdown?'data-toggle="dropdown"':''} ${!child.realContentAuto && info.openExternalLinkAsPopup && not empty child.linkOn?'target="_blank"':''} href="${child.link}" data-page="${child.name}" title="${child.info.title}">
											${child.info.label} <c:if test="${child.selected}"><span class="sr-only">(${i18n.view['global.current-page']})</span></c:if>
										</a>
										<c:if test="${dropdown}">
											<div class="dropdown-menu">
											<c:forEach var="subchild" items="${child.children}" varStatus="substatus">
												<a class="dropdown-item" href="${subchild.url}">${subchild.info.label}</a>
											</c:forEach>
											</div>
										</c:if>
									</li>
									<c:set var="index" value="${index+1}" />
								</c:if>
							</c:forEach>
						</ul>
					</div>
				</c:if>				
				</div>	
	</nav>	

<c:set var="menuDepth" value="${menuDepth-1}" scope="request" />