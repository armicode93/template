<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" 
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" 
%><c:if test="${!previousSame}"><div class="member-group"></c:if>

<c:if test="${not empty group.value}">
<c:if test="${not empty compNumber}"><c:set var="compNumber" value="${compNumber+1}" scope="request" /></c:if>
<c:if test="${empty compNumber}"><c:set var="compNumber" value="1" scope="request" /></c:if>
<c:if test="${empty memberGroup || memberGroup != group.value}">
<c:if test="${not empty memberGroup}"></div></div></c:if>
<c:if test="${not empty groupNumber}"><c:set var="groupNumber" value="${groupNumber+1}" scope="request" /></c:if>
<c:if test="${empty groupNumber}"><c:set var="groupNumber" value="1" scope="request" /></c:if>
<div class="group-${groupNumber}"><div class="row"><div class="col-sm-12"><h2>${group.value}</h2></div></div><div class="row">
</c:if>
</c:if>
<c:set var="colClass" value="col-md-3 col-6" />
<div class="${not empty group.value?colClass:'no-group'} row-3 member screamer color-${compNumber+1}">
	<div class="wrapper">
		<div class="member-box">			
			<div ${previewAttributes}>			
				<figure><img class="img-thumbnail" alt="${picture.label}" src="${picture.previewURL}" /></figure>				
				<div class="info">
					<h3>${name.value}</h3>					
					<c:if test="${not empty function.value}">					
					<div class="item function">${function.value}</div>
					</c:if>
					<c:if test="${not empty phone.value}">					
					<div class="item phone">${phone.value}</div>
					</c:if>
					<c:if test="${not empty moreinfo.value}">					
					<p class="item moreinfo">${moreinfo.value}</p>
					</c:if>
					<div class="item email"><a href="mailto:${email.value}">${i18n.view['global.email']}</a></div>
				</div>			
			</div>			
		</div>
	</div>
</div>
<c:if test="${!nextSame && not empty group.value}"></div></div> <!-- close row --></c:if>
<c:set var="memberGroup" value="${group.value}" scope="request" /><c:if test="${!nextSame}"><c:if test="${not empty group.value}"><div class="clearfix"></div></c:if></div></c:if>