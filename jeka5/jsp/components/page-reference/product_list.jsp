<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib
	prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><c:if
	test="${fn:length(pages)>0}">
	<c:if test="${not empty title}">
		<h2>${title}</h2>
	</c:if>
	<c:set var="pageRef" value="${comp}" />
	<ul class="products">
		<c:forEach items="${pages}" var="page" varStatus="status">
			<c:set var="image" value="${null}" />
			<c:if test="${fn:length(page.images)>0 && param.image}">
				<c:set var="image" value="${page.images[0]}" />
			</c:if>
			<li class="item ${status.index%2==0?'odd':'even'} ${page.toTheTopLevel>0?'top':''}">
				<a ${popup?'class="popup" ':''}title="${page.titleForAttribute}" href="${page.linkOn}" ${globalContext.openExternalLinkAsPopup && !page.linkRealContent?'target="_blank"':''}>
					<div class="row">				
                    	<c:set var="colorStyle" value="" />
                        <c:if test="${not empty page.color}">
                        	<c:set var="colorStyle" value=' style="background-color: ${page.color.HTMLCode}"' />
                        </c:if>
						<div class="col-sm-4 title bg-${status.index%5+1}"${colorStyle}><span>${page.label}</span></div>				
						<div class="col image"><img class="img-responsive" src="${image.url}" class="frame" alt="${image.description}" /></div>				
					</div>
				</a>
			</li>
		</c:forEach>
	</ul>
</c:if>