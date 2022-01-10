<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@
taglib
	prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><c:if
	test="${empty menuCurrentPage}">
	<c:set var="menuCurrentPage" value="${info.root}" scope="request" />
</c:if>
<nav class="full-menu">
	<div class="full-inner row">
		<nav class="col-md-8">
			<ul>
				<c:forEach var="child" items="${menuCurrentPage.children}"
					varStatus="status"><c:if test="${child.visible}">
					<li
						class="index-${status.index}${status.last?' last-item':''} ${child.selected?contentContext.currentTemplate.selectedClass:''}">
						<a href="${child.url}"> ${child.info.label}</a>
					</li></c:if>
				</c:forEach>
			</ul>
		</nav>
		<div class="col-md-4 full-contact">
			<ul>
				<li class="title">Get in Touch</li>
				<li>${globalContext.ownerEmail}</li>
				<li>
					<div class="social">
						<a href="#"><i class="fab fa-facebook"></i> </a> <a href="#"><i
							class="fab fa-twitter" aria-hidden="true"></i> </a>
					</div>
				</li>
			</ul>
		</div>
	</div>
</nav>

