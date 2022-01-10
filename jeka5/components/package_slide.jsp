<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" 
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" 
%><%@ taglib uri="/WEB-INF/javlo.tld" prefix="jv"%>
<c:if test="${empty inList}">
<c:set var="inList" value="${param.list}" />
</c:if>
<c:if test="${!previousSame || lineNumber == 4}">
	<div class="row package-group">
	<c:set var="lineNumber" value="0" scope="request" />
</c:if>
<div class="col-xs-12 col-md-3">
<div ${previewAttributes}>
<div class="package ${inList?'list':'not-list'} number-${lineNumber+1}">
<h3>${title.value}</h3>
<div class="body">
<div class="date">${startdate.fullDate} - ${enddate.fullDate}</div>	
<div class="info">
<h4>${information.label}</h4>
<p>${information.value}</p>
</div>
</div>
<c:if test="${not empty price.value}"><div class="price"><div class="value">&euro; ${price.value}</div></div></c:if>
<c:if test="${not empty book.link}"><div class="book">
	<a href="${book.link}">${not empty book.linkLabel?book.linkLabel:book.label}</a>
</div></c:if>
<c:if test="${not empty details.value}">
<div class="details">
<a role="button" data-toggle="collapse" href="#details-${compid}" aria-expanded="false" aria-controls="details-${compid}">${details.label}<span class="glyphicon glyphicon-option-horizontal pull-right" aria-hidden="true"></span></a>
<div class="collapse" id="details-${compid}"><div class="text">${details.value}</div></div>
</div>	
</c:if>
</div>
</div>
</div>
<c:if test="${!nextSame || lineNumber == 3}">
	<c:if test="${!nextSame}"><c:set var="lineNumber" value="0" scope="request" /></c:if>
	</div> <!-- close row -->
</c:if>
<c:set var="lineNumber" value="${lineNumber+1}" scope="request" />