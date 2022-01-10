<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" 
%>
<c:set var="fieldKey" value="${param.fieldLetter}_${param.fieldName}" /><c:set var="i18nKey" value="field.${param.fieldName}" /><div class="form-group row${not empty errorFields[fieldKey]?' has-error':''}">
<c:if test="${empty param.fieldList}"><label class="col-md-4 control-label" for="${param.fieldName}">${ci18n[i18nKey]}<c:if test="${param.mandatory == 'true'}"><span class="mandatory_symbol">*</span></c:if></label>
<div class="col-md-8">
<c:if test="${param.type != 'textarea'}">
<input type="${empty param.fieldType?'text':param.fieldType}"${param.fieldReadOnly == 'true'?' readonly="readonly"':''} id="${param.fieldName}" name="${fieldKey}"${not empty param.forcedValue?' readonly="readonly"':''} value="${not empty param.forcedValue?param.forcedValue:requestService.parameterMap[fieldKey]}" class="form-control" />
</c:if><c:if test="${param.type == 'textarea'}">
<textarea ${param.fieldReadOnly == 'true'?' readonly="readonly"':''} id="${param.fieldName}" name="${fieldKey}" class="form-control">${requestService.parameterMap[fieldKey]}</textarea>	
</c:if></div></c:if>
<c:if test="${not empty param.fieldList}">
<c:set var="list" value="${list[param.fieldList]}" />
<c:if test="${not empty list}">
<label class="col-md-4 control-label" for="${param.fieldName}">${ci18n[i18nKey]}<c:if test="${param.mandatory == 'true'}"><span class="mandatory_symbol">*</span></c:if></label>
<div class="col-md-8">
<select ${param.fieldReadOnly == 'true'?'readonly="readonly"':''}id="${param.fieldName}" name="${fieldKey}" class="form-control">
<c:forEach var="item" items="${list}">
    <option${item.key==requestService.parameterMap[fieldKey]?' selected="selected"':''} value="${item.key}">${item.value}</option>
</c:forEach>
</select>
</div>
</c:if>
</c:if>
</div>