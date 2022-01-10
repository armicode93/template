<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" 
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" 
%><%@ taglib uri="/WEB-INF/javlo.tld" prefix="jv"
%>

<c:if test="${empty bookAnchor}">
	<div id="book-anchor"></div>
	<c:set var="bookAnchor" scope="request" />
</c:if>

<c:if test="${empty inList}">
<c:set var="inList" value="${param.list}" />
</c:if>
<c:if test="${!previousSame || lineNumber == 4 || lineNumber == 0}">
	<c:if test="${lineNumber == 4}"></div></c:if>
	<div class="row package-group">	
	<c:set var="lineNumber" value="0" scope="request" />
</c:if>
<div class="col-md-3"><div class="package service">
<div ${previewAttributes}>
<h3>${not empty title.value?title.value:'[title]'}</h3>
</div>
<img class="img-responsive" src="${photo.previewURL}" />

<c:if test="${not empty price.value}"><div class="price"><div class="value">&euro; ${price.value}</div></div></c:if>
<div class="details">
<c:if test="${not empty information.value}">
<a role="button" data-toggle="collapse" href="#details-${compid}" aria-expanded="false" aria-controls="details-${compid}">${information.label}<span class="glyphicon glyphicon-option-horizontal pull-right" aria-hidden="true"></span></a>
<div class="collapse" id="details-${compid}"><div class="text">${information.value}</div></div>
</c:if><c:if test="${empty information.value}"><span class="fake-link">&nbsp;</span></c:if>
</div>
</div></div>
<c:if test="${!nextSame || lineNumber == 3}">
	<c:if test="${!nextSame}"><c:set var="lineNumber" value="0" scope="request" /></c:if>
	</div> <!-- close row -->
</c:if>
<c:set var="lineNumber" value="${lineNumber+1}" scope="request" />
