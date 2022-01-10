<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" 
%>
<div class="mt-3 mb-3">
<c:if test="${not empty msg}"><div class="message">
    <div class="alert alert-${msg.typeLabel == 'error'?'danger':msg.typeLabel}" role="alert">${msg.message}</div>
</div></c:if>
<c:if test="${empty valid}">
<c:url var="actionURL" value="${info.currentURL}" context="/">
	<c:if test="${not empty param.small}"><c:param name="small" value="${param.small}" /></c:if>
	<c:if test="${not empty param.B_destination}"><c:param name="B_destination" value="${param.B_destination}" /></c:if>
</c:url>
<form method="post" action="${actionURL}" class="form-horizontal" enctype="multipart/form-data" role="form" id="form-${comp.id}">
<input type="hidden" name="webaction" value="gform.submit" />
<input type="hidden" name="comp_id" value="${comp.id}" />
<div class="form-body">
<c:if test="${not empty param.B_destination}">
<fieldset>
<legend>${ci18n["field.title.booking"]}</legend>
<jsp:include page="field.jsp?fieldName=category&fieldLetter=A&mandatory=true&fieldReadOnly=true" />
<jsp:include page="field.jsp?fieldName=destination&fieldLetter=B&mandatory=true&fieldReadOnly=true" />
<jsp:include page="field.jsp?fieldName=period&fieldLetter=C&mandatory=true&fieldReadOnly=true" />
</fieldset>
</c:if>
<fieldset>
<c:if test="${empty param.small}"><legend>${ci18n["field.title.group"]}</legend></c:if>
<c:if test="${not empty param.small}"><legend>${ci18n["field.title.info"]}</legend></c:if>
<input type="hidden" name="A0_ffield" value="fake" />
<c:if test="${empty param.small}"><jsp:include page="field.jsp?fieldName=size&fieldLetter=d&mandatory=false&fieldType=number" />
<jsp:include page="field.jsp?fieldName=groupName&fieldLetter=E&mandatory=true" /></c:if>
<c:if test="${empty param.small}"><jsp:include page="field.jsp?fieldName=groupType&fieldLetter=Ea&mandatory=false&fieldList=types" /></c:if>
<c:if test="${not empty param.small}">
<c:if test="${empty param.forcedSubject}"><jsp:include page="field.jsp?fieldName=subject&fieldLetter=F&mandatory=true&fieldList=subject" /></c:if>
<c:if test="${not empty param.forcedSubject}"><jsp:include page="field.jsp?fieldName=subject&fieldLetter=F&mandatory=true&forcedValue=${param.forcedSubject}" /></c:if>
</c:if>
<jsp:include page="field.jsp?fieldName=firstName&fieldLetter=G&mandatory=true" />
<jsp:include page="field.jsp?fieldName=lastName&fieldLetter=G&mandatory=true" />
<jsp:include page="field.jsp?fieldName=phone&fieldLetter=H&mandatory=true" />
<jsp:include page="field.jsp?fieldName=email&fieldLetter=J&mandatory=true&fieldType=email" />
<jsp:include page="field.jsp?fieldName=zip&fieldLetter=n&mandatory=true" />
<jsp:include page="field.jsp?fieldName=message&fieldLetter=q&mandatory=false&type=textarea" />
</fieldset>
</div>
<div class="alert-fields text-right" role="alert"><span class="mandatory_symbol">*</span> ${ci18n['field.mandatory']}</div>
<div class="d-flex justify-content-end">
	<button class="btn btn-primary" type="submit">${i18n.view['global.confirm']}</button>
</div>
</form>
</c:if>
<c:if test="${error}">
<div class="alert alert-warning" role="alert">${error}</div>
</c:if>
</div>