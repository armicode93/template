<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%><%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"
%><%@ taglib uri="/WEB-INF/javlo.tld" prefix="jv"%><c:if test="${!previousSame && nextSame}">
	<div class="row">
	<c:set var="openRow" value="true" scope="request" />
</c:if>
<c:if test="${openRow}"><div class="col-sm-4"></c:if>
<div ${previewAttributes}>
<div class="card">
<div class="card-img-top"><div class="carousel-inner"> <div id="carousel-${compid}" class="carousel slide ${param.caption?'with-caption':'without-caption'}" data-ride="carousel"> 
  <c:forEach var="resource" items="${resources}" varStatus="status">
  	<div class="carousel-item item${status.index==0?' active':''}">
  	  <jv:changeFilter var="newURL" url="${resource.previewURL}" filter="preview" newFilter="square" />
      <img class="d-block w-100" alt="${resource.title}" src="${newURL}" />
      <c:if test="${!resource.staticInfo.emptyInfo && param.caption}"> 
      <c:if test="${not empty resource.staticInfo.title || not empty resource.staticInfo.description || not empty resource.staticInfo.copyright}">
      <div class="carousel-caption d-none d-md-block">
      	<c:if test="${not empty resource.staticInfo.title}"><p class="title">${resource.staticInfo.title}</p></c:if>
      	<c:if test="${not empty resource.staticInfo.description}"><p class="description">${resource.staticInfo.description}</p></c:if>
      	<c:if test="${not empty resource.staticInfo.copyright}"><span class="copyright">&copy; ${resource.staticInfo.copyright}</span></c:if>
      </div>     
      </c:if></c:if>
    </div>
  </c:forEach>
  </div></div></div>
<div class="card-body align-items-center">
<div class="half-container"><c:if test="${not empty title}"><div class="col-xs-6 text">${title}</div></c:if></div>
</div>
</div>
</div>
<c:if test="${openRow}"></div></c:if><c:if test="${!nextSame && openRow}"><c:set var="openRow" value="false" scope="request" />
	</div> <!-- /row -->
</c:if>