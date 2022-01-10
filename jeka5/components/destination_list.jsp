<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" 
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" 
%><%@ taglib uri="/WEB-INF/javlo.tld" prefix="jv"%>

<c:if test="${empty glideId}">
<c:set var="glideId" value="glide-${compid}" scope="request" />
</c:if>

<c:if test="${first}">
<div class="glide glide-multi" id="${glideId}">
	<div class="glide__track" data-glide-el="track">	
		<div class="glide__slides">
</c:if>

<a class="glide__slide" href="${page.url}">
<div class="destination-item ${inList?'list':'not-list'}">

	<div class="text-wrapper">${title.value}</div>

	<c:if test="${not empty page.image}">		
		<jv:changeFilter var="image" url="${page.image.previewURL}" filter="standard" newFilter="list" />
		<img src="${image}" alt="${page.image.description}" class="img-fluid" />
	</c:if>

	<div class="price d-flex flex-column">
		<div class="label text-right">${pricePrefix.value}</div>
		<div class="value text-right">${price.value}</div>
	</div>

</div>
</a>

<c:if test="${last}">
		</div>

		<div class="glide__arrows" data-glide-el="controls">
			<button class="glide__arrow glide__arrow--left" data-glide-dir="<"><i class="fas fa-angle-left"></i></button>
			<button class="glide__arrow glide__arrow--right" data-glide-dir=">"><i class="fas fa-angle-right"></i></button>
		</div>

	</div>	
</div>

<script>
{
	var size=4;
    if (window.innerWidth<1000) {
       size=2;
    }
    const GLIDE_OPTIONS = {
		perView: size
	}
	if (typeof Glide != "undefined") {
		new Glide('#${glideId}', GLIDE_OPTIONS).mount();
	} else {
		document.addEventListener("DOMContentLoaded", function(event) {
			new Glide('#${glideId}', GLIDE_OPTIONS).mount();
		});
	}
}
</script>

<c:set var="glideId" value="" scope="request" />
</c:if>