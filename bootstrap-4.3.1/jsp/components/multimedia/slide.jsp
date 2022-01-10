<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib uri="/WEB-INF/javlo.tld" prefix="jv"
%><c:if test="${fn:length(resources)>0}"><div id="carousel-${compid}" class="slide ${param.caption?'with-caption':'without-caption'}">
<c:if test="${not empty title}"><h2>${title}</h2></c:if>
<div class="owl-carousel owl-theme">
  <c:forEach var="resource" items="${resources}" varStatus="status">
  	<div class="item${status.index==0?' active':' unactive'}">
  	  <jv:changeFilter var="newURL" url="${resource.previewURL}" filter="preview" newFilter="slide" />
      <img class="d-block w-100" alt="${resource.title}" src="${newURL}" />
      <c:if test="${!resource.staticInfo.emptyInfo && param.caption}"> 
      <c:if test="${not empty resource.staticInfo.title || not empty resource.staticInfo.description || not empty resource.staticInfo.copyright}">
      <div class="caption d-none d-md-block">
      	<c:if test="${not empty resource.staticInfo.title}"><p class="title">${resource.staticInfo.title}</p></c:if>
      	<c:if test="${not empty resource.staticInfo.description}"><p class="description">${resource.staticInfo.description}</p></c:if>
      	<c:if test="${not empty resource.staticInfo.copyright}"><span class="copyright">&copy; ${resource.staticInfo.copyright}</span></c:if>
      </div>     
      </c:if></c:if>
    </div>
  </c:forEach>
  </div>
</div>
<script>
function initOwl${compid}() {
	$('#carousel-${compid} .owl-carousel').owlCarousel({
	    loop:true,
	    autoplay:true,
	    autoplayHoverPause:true,
	    margin:1,
	    nav:${not empty param.control || not empty param.caption},
	    dots:${not empty param.control},
	    responsiveClass:true,
	    items:1
	});
}
if (window.jQuery) {
	setTimeout(function() { initOwl${compid}(); }, 1000);
} else {
	document.addEventListener("DOMContentLoaded", function(event) {initOwl${compid}();});
}
</script></c:if>