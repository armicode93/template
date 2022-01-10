<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" 
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" 
%><%@ taglib uri="/WEB-INF/javlo.tld" prefix="jv"
%>
<c:if test="${empty inList}">
<c:set var="inList" value="${param.list}" />
</c:if>
<c:if test="${!previousSame}">
<div class="service-slide">
<div class="double-slide">
<div class="service-group">
<div class="commands">
<a class="previous btn btn-default" id="previous-service" href="#previous-service"><span class="glyphicon glyphicon-menu-left"></span> <span class="text" lang="en">previous</span></a>
<a class="next btn btn-default" id="next-service" href="#next-service"><span class="glyphicon glyphicon-menu-right"></span> <span class="text" lang="en">next</span></a>
</div>
<div class="slideshow-row">
<div class="package-group">
</c:if>
<div class="package service"><div class="service-content">
<div ${previewAttributes}>
<h3>${not empty title.value?title.value:'[title]'}</h3>
</div>
<img class="img-responsive" src="${photo.previewURL}" />

<c:if test="${not empty price.value}"><div class="price"><div class="value">&euro; ${price.value}</div></div></c:if>
<c:if test="${not empty information.value}">
<div class="details">
<a role="button" data-toggle="collapse" href="#details-${compid}" aria-expanded="false" aria-controls="details-${compid}">${information.label}<span class="glyphicon glyphicon-option-horizontal pull-right" aria-hidden="true"></span></a>
<div class="collapse" id="details-${compid}"><div class="text">${information.value}</div></div>
</div>	
</c:if>
</div></div>
<c:if test="${!nextSame}">
</div></div></div></div></div>
<script>
jQuery(window).load(function() {
var slideshow = createSlideshow(".service-group", ".slideshow-row", ".service", ".service-content");
$("#previous-service").click(function(e) {
	e.preventDefault();
	slideshow.previous();
	schedule(false);
	return false;
});
$("#next-service").click(function(e) {
	e.preventDefault();
	slideshow.next();
	schedule(false);
	return false;
});
});
</script>
</c:if>
