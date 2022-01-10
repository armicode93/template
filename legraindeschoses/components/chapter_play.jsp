<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" 
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" 
%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
%><%@ taglib uri="/WEB-INF/javlo.tld" prefix="jv"%>
<c:if test="${not empty param.sommaire}">
	<c:if test="${empty soundNumberSommaire}">
		<c:set var="soundNumberSommaire" value="0" scope="request" />
	</c:if>
	<c:set var="soundNumberSommaire" value="${soundNumberSommaire+1}" scope="request" />
	<div id="sound-${soundNumberSommaire}" class="chapter-data" data-number="${soundNumberSommaire}" data-url="${file.URL}" data-title="${title.value}" data-position="${position.value}">
	</div>
</c:if>
<c:if test="${empty param.sommaire}">

<c:url var="sommaireURL" value="${info.currentURL}" context="/">
	<c:param name="only-area" value="content" />
	<c:param name="sommaire" value="true" />
</c:url>

	<c:if test="${empty soundNumber}">
		<c:set var="soundNumber" value="0" scope="request" />
	</c:if>
	<c:set var="soundNumber" value="${soundNumber+1}" scope="request" />
	<div class="ajax-nav chapter-command-play chapter-command" id="sound-command-${soundNumber}">
	
	<a class="play" href="#" onclick="selectChapter(${soundNumber}, true, '${sommaireURL}'); return false;" title="jouer le morceau">
		<img class="off" src="${info.rootTemplateURL}/img/play_off.png" alt="" />
		<img class="on" src="${info.rootTemplateURL}/img/play_on.png" alt="" />
		<img class="onde" src="${info.rootTemplateURL}/img/current.png" alt="" />
	</a>
	<a class="title" onclick="selectChapter(${soundNumber}, true, '${sommaireURL}'); return false;" title="jouer le morceau" href="#">
		<div class="main-title">${title.value}</div> <br />
		<div>${description.value}</div>
	</a>
    <c:if test="${!nodownload.value}">
    <div class="command">
    <a class="info collapse-link ajax-nav-done" title="fiche descriptive" href="${information.link}">
		<img class="info collapse-on" src="${info.rootTemplateURL}/img/info.png" alt="" />
        <img class="cruise collapse-off" src="${info.rootTemplateURL}/img/cruise.png" alt="" />
	</a>
	<a class="download" title="telecharger" href="${file.URL}" target="_blank">
		<div class="time">${timeDisplay.value}</div>
		<img src="${info.rootTemplateURL}/img/download.png" alt="" />
	</a>
	</div>
    </c:if>
   </div>
</c:if>