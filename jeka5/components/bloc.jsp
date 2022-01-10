<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" 
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" 
%>
<c:if test="${display.value=='left'}">

<div class="row left">
	<div class="col-md-4 bloc-1 bloc-text">		
		${link.viewXHTMLCode}
		${text.viewXHTMLCode}		
	</div>
	<div class="col-md-8 bloc-2 bloc-image">
		${image.viewXHTMLCode}
	</div>

</div>

</c:if><c:if test="${display.value=='right'}">
<div class="row right">	
	<div class="col-md-8 bloc-2 bloc-image">
		${image.viewXHTMLCode}
	</div>
	<div class="col-md-4 bloc-1 bloc-text">		
		${link.viewXHTMLCode}
		${text.viewXHTMLCode}		
	</div>
</div>
</c:if>