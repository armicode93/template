<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" 
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><c:if test="${not empty title.value}">
  	<div class="alert-heading font-weight-bold">${title.value}</div>
  	 <hr>
  </c:if> 
  <p class="mb-0">${description.value}</p>