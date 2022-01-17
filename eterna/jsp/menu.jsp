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
<c:if test="${param._menufix}">
	<div class="menu_back_block"></div>
</c:if>
<header class="d-flex align-items-center">
	<div class="container d-flex justify-content-between align-items-center">
		<jsp:include page="logo.jsp" />
		<nav id="navbar" class="navbar">
			<ul>
				<c:forEach var="child" items="${menuCurrentPage.children}" varStatus="status">
					<c:if test="${child.visibleForContext && not empty child.link}">
						<c:set var="dropdown" value="${param._menudropdown && child.visibleChildren}" />
						<c:if test="${param.subchild && child.selected}">
							<c:set var="selectedSubChild" value="${child}" />
						</c:if>
						<li class="read-${child.readAccess} ${dropdown?'dropdown ':''}page_${child.name} depth-${menuDepth} index-${status.index}${status.last?' last-item':''} ${child.realContentAuto?'real-content ':'not-real-content '}${child.selected?contentContext.currentTemplate.selectedClass:''}${fn:length(child.children)>0?' has-children':' no-children'}${child.lastSelected?' last-item':''} item-${index}">
						<a class="${dropdown?'dropdown-toggle ':''} ${child.selected?'active':''}" ${dropdown?'data-toggle="dropdown"':''} ${!child.realContentAuto && info.openExternalLinkAsPopup && not empty child.linkOn?'target="_blank"':''} href="${child.link}" data-page="${child.name}" title="${child.info.title}"> ${child.info.label} <c:if test="${child.selected}">
						<span class="visually-hidden">(${i18n.view['global.current-page']})</span>
								</c:if>
						</a> <c:if test="${dropdown}">
								<div class="dropdown-menu">
									<c:forEach var="subchild" items="${child.children}" varStatus="substatus">
										<a class="dropdown-item" href="${subchild.url}">${subchild.info.label}</a>
									</c:forEach>
								</div>
							</c:if></li>
						<c:set var="index" value="${index+1}" />
					</c:if>
				</c:forEach>
			</ul>
			
			<div class="nav-actions d-flex justify-content-end">

				<c:if test="${param._menulogin}">
					<div class="login-bloc collapse-bloc me-3">
						<a class="btn-login btn btn-sm btn-user d-none-logged btn-outline-secondary" data-bs-toggle="modal" href="#loginForm" aria-expanded="false" aria-controls="loginForm" title="${i18n.view['login.nologin']}"> <i class="bi bi-person-fill"></i>
						</a> <a class="btn-login btn btn-sm btn-user d-logged" data-bs-toggle="modal" href="#loginForm" aria-expanded="false" aria-controls="loginForm"> <i class="bi bi-person-fill"></i>
						</a>
						<div id="loginForm" class="modal" tabindex="-1"><jsp:include page="menu_login.jsp?noAjaxMenuLogin=true" /></div>
					</div>
				</c:if>

				<c:if test="${param._menujssearch}">
					<div class="search-bloc collapse-bloc">
						<a class="btn-search btn btn-outline-secondary btn-sm me-3" data-bs-toggle="modal" href="#searchForm" aria-expanded="false" aria-controls="searchForm" title="${i18n.view['global.open-search']}"><i class="bi bi-search"></i></a>
						<div id="searchForm" class="modal" tabindex="-1">
							<div class="modal-dialog modal-md">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title">${i18n.view['global.search']}</h5>
										<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<div class="modal-body">
										<form id="search-form">
											<input name="webaction" value="search.search" type="hidden" />
											<div class="input-group">
												<input id="staticSearchButton" class="form-control" type="text" placeholder="${i18n.view['global.query']}" aria-label="${i18n.view['global.search']}" accesskey="4" name="keywords">
												<div class="input-group-append">
													<button class="btn-search btn btn-primary" type="submit">
														<i class="bi bi-chevron-double-right"></i><span class="visually-hidden">${i18n.view['global.send']}</span>
													</button>
												</div>
												<div id="staticSearchResult"></div>
												<a href="${info.staticRootURL}/sitemap.json" style="display: none;" id="staticSearchData">staticSeach data</a>
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</c:if>

				<c:if test="${fn:length(info.languages)>1}">
					<form method="get" action="${info.currentURL}">
						<div class="lang-bloc">
							<input type="hidden" name="webaction" value="view.language" />
							<select name="lg" class="form-select" onchange="this.form.submit();" aria-label="${vi18nAttribute['global.change-language']}">
								<c:forEach var="lg" items="${info.languages}">
									<option ${info.language==lg?' selected':''} value="${lg}">${lg}</option>
								</c:forEach>
							</select>
						</div>
					</form>
				</c:if>
				
				 <i class="bi bi-list mobile-nav-toggle"></i>
		</nav>
	</div>
</header>

<c:set var="menuDepth" value="${menuDepth-1}" scope="request" />

<!-- ======= Breadcrumbs ======= -->
<c:if test="${fn:length(info.pagePath) > 1}">
	<section id="breadcrumbs" class="breadcrumbs">
		<div class="container">
			<ol>
				<c:forEach var="page" items="${info.pagePath}" varStatus="status">
					<c:if test="${status.index>0}">
						<li itemscope itemtype="http://data-vocabulary.org/Breadcrumb"><c:if test="${page.realContent}">
								<a href="${page.url}" itemprop="url"> <span itemprop="title">${page.info.label}</span></a>
							</c:if> <c:if test="${!page.realContent}">
								<span itemprop="title">${page.info.label}</span>
							</c:if></li>
					</c:if>
				</c:forEach>
			</ol>

			<h2>${info.pageTitle}</h2>

		</div>
	</section>
</c:if>
<!-- End Breadcrumbs -->