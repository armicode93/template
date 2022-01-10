<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" 
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" 
%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
%><%@ taglib uri="/WEB-INF/javlo.tld" prefix="jv"%>
<div class="ajax-nav">
<c:if test="${not empty param.sommaire}">
	<c:if test="${empty soundNumberSommaire}">
		<c:set var="soundNumberSommaire" value="0" scope="request" />
	</c:if>
	<c:set var="soundNumberSommaire" value="${soundNumberSommaire+1}" scope="request" />
	<div id="sound-${soundNumberSommaire}" class="chapter-data" data-number="${soundNumberSommaire}" data-url="${file.URL}" data-title="${title.value}" data-position="${position.value}">
	</div>
</c:if>
<c:if test="${empty param.sommaire}">
	<c:if test="${empty soundNumber}">
		<c:set var="soundNumber" value="0" scope="request" />
	</c:if>
	<c:set var="soundNumber" value="${soundNumber+1}" scope="request" />
	<div class="row chapter-command" id="sound-command-${soundNumber}">
	<div class="col-10">
	<c:url var="sommaireURL" value="${info.currentURL}" context="/">
		<c:param name="only-area" value="content" />
		<c:param name="sommaire" value="true" />
	</c:url>
	<h3><a class="play" href="#" onclick="selectChapter(${soundNumber}, true, '${sommaireURL}'); return false;" title="jouer le morceau"><jv:texttohtml>${title.value}</jv:texttohtml></a>
		<c:if test="${not empty information.linkLabel}"><a class="info-link collapse-link" title="${information.linkLabel}" href="${information.link}"><img src="${info.rootTemplateURL}/img/info.png" alt="info" /></a></c:if>
		<span class="current item">
			<img src="${info.rootTemplateURL}/img/current.png" alt="en cours de lecture" />
		</span>
	</h3>
	</div>
	<div class="col-2 d-flex justify-content-end play">
	<span class="time">${timeDisplay.value}</span>
	</div>
	</div>
    <jv:texttohtml>${description.value}</jv:texttohtml>
   </div>
</c:if>