<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" 
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" 
%><%@ taglib uri="/WEB-INF/javlo.tld" prefix="jv"%>
<c:if test="${empty inList}">
<c:set var="inList" value="${param.list}" />
</c:if>
<div class="destination ${inList?'list':'not-list'}">

	<h2>${title.value}</h2>

	<div class="row">
    	<c:if test="${not empty list1.value}">
		<div class="col-md-6">
		    <c:if test="${not empty list1title.value}">
				<h3>${list1title.value}</h3>
			</c:if>
			<c:if test="${empty list1title.value}">
				<h3>${vi18n['destination.activities']} <i class="fas fa-bicycle"></i></h3>
			</c:if>
			<div class="text">${list1.viewXHTMLCode}</div>
		</div>
        </c:if>
        <c:if test="${not empty list2.value}">
		<div class="col">
			<c:if test="${not empty list2title.value}">
				<h3>${list2title.value}</h3>
			</c:if>
			<c:if test="${empty list2title.value}">
				<h3>${vi18n['destination.visits']} <i class="fas fa-camera-retro"></i></h3>
			</c:if>
			<div class="text">${list2.viewXHTMLCode}</div>
		</div>
        </c:if>
	</div>
	
	
</div>