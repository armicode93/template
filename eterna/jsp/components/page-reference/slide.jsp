<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib uri="/WEB-INF/javlo.tld" prefix="jv"
%><c:if test="${fn:length(pages)>0}">

	<c:if test="${not empty title}">
		<h2>${title}</h2>
	</c:if>

	<div id="carousel-${compid}" class="carousel slide carousel-fade ${param.caption?'with-caption':'without-caption'}" >

		<ol class="carousel-indicators" id="hero-carousel-indicators"></ol>

		<div class="carousel-inner" role="listbox">
			<c:forEach items="${pages}" var="page" varStatus="status">
				<c:set var="image" value="${page.images[0]}" />
				<jv:changeFilter var="newURL" url="${image.url}" filter="reference-list" newFilter="full" />
				<!-- Slide ${status.index+1} -->
				<div class="carousel-item${status.index==0?' active':''}" style="background: url('${newURL}')">
					<div class="carousel-container">
						<div class="carousel-content">
							<h2 class="animate__animated animate__fadeInDown">${page.title}</h2>
							<p class="animate__animated animate__fadeInUp">${page.description}</p>
							<a href="${page.linkOn}" class="btn-get-started animate__animated animate__fadeInUp">${vi18n['global.read-more']}</a>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>

		<a class="carousel-control-prev" href="#carousel-${compid}" role="button" data-bs-slide="prev" lang="en"> <span class="carousel-control-prev-icon bi bi-chevron-left" aria-hidden="true"></span>
		</a> <a class="carousel-control-next" href="#carousel-${compid}" role="button" data-bs-slide="next" lang="en"> <span class="carousel-control-next-icon bi bi-chevron-right" aria-hidden="true"></span>
		</a>

	</div>
</c:if>

<!-- <script> -->
// 	if (typeof (bootstrap) != 'undefined') {
// 		var myCarousel = document.querySelector('#carousel-${compid}');
// 		var carousel = new bootstrap.Carousel(myCarousel);
// 	} else {
// 		document.addEventListener("DOMContentLoaded", function(event) {
// 			var myCarousel = document.querySelector('#carousel-${compid}');
// 			var carousel = new bootstrap.Carousel(myCarousel);
// 			console.log("carousel = ", carousel);
// 		});
// 	}
<!-- </script> -->