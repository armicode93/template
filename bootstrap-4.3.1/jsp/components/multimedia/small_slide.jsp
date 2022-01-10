<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib uri="/WEB-INF/javlo.tld" prefix="jv"
%><div class="small-slide multi-slide" id="slide-${compid}">
<div class="commands">
<a class="previous btn btn-default"  href="#previous"><i class="fas fa-arrow-left" aria-hidden="true"></i> <span class="text" lang="en">previous</span></a>
<a class="next btn btn-default" href="#next"><i class="fas fa-arrow-right" aria-hidden="true"></i> <span class="text" lang="en">next</span></a>
</div>
<div id="double-slide-${compid}" class="slideshow-container clickable-multimedia">
  <div class="slideshow-row">
  <c:forEach var="resource" items="${resources}" varStatus="status">  	
  	<div class="slideshow-item preview">
		<div class="slideshow-item-content">
			<jv:changeFilter var="newURL" url="${resource.previewURL}" filter="preview" newFilter="bloc-2-2" />			 			 						
     		<a title="${i18n.view['global.enlargeimage']}" class="thumbnail" href="${resource.URL}" rel="${resource.relation}" data-caption="${resource.allInfoText}" data-width="${resource.size.width}" data-height="${resource.size.height}">
     			<img class="img-responsive" alt="${resource.title} - ${i18n.view['global.enlargeimage']}" src="${newURL}" />
     		</a>
     		<c:if test="${not empty resource.title}"> 		
     		<div class="text">
     		  <div class="text-wrapper">     		  
   			  <h${contentContext.titleDepth+1}>${resource.title}</h${contentContext.titleDepth+1}>
   			  <c:if test="${not empty resource.description}"><p>${resource.description}</p></c:if>
   			  </div>   			  	   			  
 			</div>
 			</c:if>
 		</div> 			 			      
   	</div>	
  </c:forEach>
  </div>
</div>
</div>
<script>
document.addEventListener("DOMContentLoaded", function(event) { 
var slideshow = createSlideshow("#slide-${compid}", ".slideshow-row", ".slideshow-item", ".slideshow-item-content");
$("#slide-${compid} .previous").click(function(e) {
	e.preventDefault();
	slideshow.previous();
	schedule(false);
	return false;
});
$("#slide-${compid} .next").click(function(e) {
	e.preventDefault();
	slideshow.next();
	schedule(false);
	return false;
});
});
</script>