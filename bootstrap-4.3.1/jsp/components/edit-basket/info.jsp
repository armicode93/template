<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt"
%>
<c:set var="basketPage" value="${info.pageByName.basket}" />
<c:if test="${not empty basketPage && empty param.basketLink}"><a href="${basketPage.url}"></c:if>
<h3><i class="fas fa-shopping-cart"></i> ${i18n.view['ecom.basket']}</h3>
<c:if test="${basket.productCount > 0 && basket.displayInfo}">
<div class="total list-group">
	<div class="list-group-item">
		<span class="badge">${basket.productCount}</span>
		<span class="label">${i18n.view['ecom.product.total']}</span>		
	</div>
	<div class="list-group-item">
		<span class="badge">${total}</span>
		<span class="label">${i18n.view['ecom.total_vat']}</span>		
	</div>
</div>
</c:if>
<c:if test="${basket.productCount == 0 || not basket.displayInfo}">
<p>${i18n.view['ecom.basket-empty']}</p>
</c:if>
<c:if test="${not empty basketPage && empty param.basketLink}"><span class="link">${i18n.view['ecom.confirm']}</span></a></c:if>
