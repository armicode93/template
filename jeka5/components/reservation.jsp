<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" 
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" 
%>

<c:if test="${!previousSame}">
  <table class="table">
  <thead>
    <tr class="dynamic-component reservation">
      <th scope="col">${days.label}</th>
      <th scope="col">${start.label}</th>
      <th scope="col">${end.label}</th>
      <th scope="col">${price.label} p.p.</th>
      <th scope="col"></th>
    </tr>
  </thead>
  <tbody>
</c:if>

<tr ${previewAttributes}>
	<td><c:if test="${not empty days.reference.value}"><c:set var="daynightmessage" value="true" scope="request" /><div class="days">${days.reference.value}</div></c:if></td>
	<td class="start-date">${start.reference.viewXHTMLCode}<c:if test="${not empty startmsg.value}"><span class="msg startmsg"> ${startmsg.value}</span></c:if><c:if test="${not empty startdn && not empty startdn.reference.value && startdn.reference.value != 'undefined'}">
		<span class="daynight">
			<c:if test="${startdn.reference.value=='day'}"><i class="day fas fa-sun" title="${startdn.reference.value}"></i></c:if>
			<c:if test="${startdn.reference.value=='night'}"><i class="night fas fa-moon" title="${startdn.reference.value}"></i></c:if>
		</span>
	</c:if></td>
	<td class="end-date">${end.reference.viewXHTMLCode}<c:if test="${not empty endmsg.value}"><span class="msg endmsg"> ${endmsg.value}</span></c:if><c:if test="${not empty enddn && not empty enddn.reference.value && enddn.reference.value != 'undefined'}">
		<span class="daynight">
			<span class="daynight">
				<c:if test="${enddn.reference.value=='day'}"><i class="day fas fa-sun" title="${enddn.reference.value}"></i></c:if>
				<c:if test="${enddn.reference.value=='night'}"><i class="night fas fa-moon" title="${enddn.reference.value}"></i></c:if>
			</span>
		</span></c:if></td>
	<td class="price"><span>${price.reference.displayValue}</span></td>
	<td class="link">  
	  <c:url var="url" value="${info.pageByName['book'].url}" context="/">
		<c:param name="A_category" value="${info.page.parent.parent.info.title} ${info.page.parent.info.title}" />
	 	<c:param name="B_destination" value="${info.pageTitle} - ${info.page.info.subTitle} - ${price.displayValue}" />
		<c:if test="${not empty start.reference.displayValue || not empty end.reference.displayValue}">
	  		<c:param name="C_period" value="${start.reference.displayValue} - ${end.reference.displayValue}" />
	  	</c:if>
	  	<c:if test="${info.section != 'group'}"> 		
	  		<c:param name="forcedSubject" value="Reservation" /> 
	  	</c:if>   	
	  	<c:if test="${empty start.reference.displayValue && empty end.reference.displayValue && not empty information.reference.displayValue}">
	  		<c:param name="C_period" value="${information.reference.displayValue}" />
	  	</c:if>
	  	<c:if test="${empty start.reference.displayValue && empty end.reference.displayValue}">
	  		<c:param name="forcedSubject" value="${info.page.parent.parent.name} ${info.page.parent.name} - ${info.pageTitle}" />  		
	  	</c:if>
	  </c:url>
  	<a class="btn btn-default" href="${not empty regurl.value?regurl.value:not empty urli.link?urli.link:url}">${i18n.view['reservation.book']}</a>
	</td>
</tr>

<c:if test="${!nextSame}">
</tbody></table>
</c:if>