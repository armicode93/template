<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" 
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" 
%><div class="cottage-details">
<div class="header">
<h1>${info.page.parent.info.title} - ${name.reference.value}</h1>

<div class="row row-text">
		<div class="col-md-4">
			<h2>${vi18n['cottage.capacity']}</h2>
			<div class="text">
				${vi18n['cottage.from']} ${min.value} ${vi18n['cottage.to']} ${max.value} ${vi18n['cottage.poeple']}
			</div>
		</div>
		<div class="col-md-4">
        	<c:if test="${not empty facilities.value}">
			<h2>${vi18n['cottage.facilities']}</h2>
			<div class="text">${facilities.viewXHTMLCode}</div>
            </c:if>
		</div>
		<div class="col">
        	<c:if test="${not empty occupancy.reference.value}">
			<h2>${vi18n['cottage.rooms']}</h2>
			<div class="text">${occupancy.viewXHTMLCode}</div>
            </c:if>
		</div>
	</div>
</div>
</div>