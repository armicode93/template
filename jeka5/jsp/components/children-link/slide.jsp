<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib uri="/WEB-INF/javlo.tld" prefix="jv"
%><c:if test="${fn:length(children)>0}">
<c:if test="${not empty title}">
	<h2>${title}</h2>
</c:if>

<c:set var="glideId" value="glide-${compid}" />

<div class="glide glide-multi" id="${glideId}">
	<div class="glide__track" data-glide-el="track">	
		<div class="glide__slides">		
    		<c:forEach var="child" items="${children}" varStatus="status">
    		
    			<a class="glide__slide ${popup?'popup ':''}nav-link${child.selected?' active':''}" href="${child.url}">
    			
					<c:if test="${not empty child.pageBean.contentAsMap.dynamicComponent.cottage}">
						<div class="name">${child.pageBean.contentAsMap.dynamicComponent.cottage.name.value}</div>
					</c:if>
					
					<div class="text-wrapper">
						<c:if test="${not empty child.pageBean.contentAsMap.dynamicComponent.cottage}">
							${vi18n['cottage.from']}
							${child.pageBean.contentAsMap.dynamicComponent.cottage.min.value}
							${vi18n['cottage.to']}
							${child.pageBean.contentAsMap.dynamicComponent.cottage.max.value}
							${vi18n['cottage.poeple']}
						</c:if>
						<c:if test="${empty child.pageBean.contentAsMap.dynamicComponent.cottage}">
							${child.fullLabel}
						</c:if>
					</div>
    			
    				<jv:changeFilter var="newURL" url="${child.image.previewURL}" filter="list" newFilter="bloc-2-2" />	
					<img class="img-fluid" src="${newURL}" alt="${child.image.description}" />
    			
    			</a>
    		
			</c:forEach>
		</div>
		<div class="glide__arrows" data-glide-el="controls">
			<button class="glide__arrow glide__arrow--left" data-glide-dir="<"><i class="fas fa-angle-left"></i></button>
			<button class="glide__arrow glide__arrow--right" data-glide-dir=">"><i class="fas fa-angle-right"></i></button>
		</div>
	</div>
</div>
</c:if> 

<script>
{
	const GLIDE_OPTIONS = {
		perView: 4
	}
	if (typeof Glide != "undefined") {
		new Glide('#${glideId}', GLIDE_OPTIONS).mount();
	} else {
		document.addEventListener("DOMContentLoaded", function(event) { 
            setTimeout(function() { new Glide('#${glideId}', GLIDE_OPTIONS).mount(); }, 1000);			
		});
	}
}
</script>