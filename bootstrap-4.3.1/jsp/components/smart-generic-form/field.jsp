<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
 %><c:if test="${field.first}">
	<div class="row">
</c:if>
<c:if test="${empty quiz}">
<c:set var="labelWidth" value="${field.width == 12?'1':field.width > 10?'2':field.width > 8?'3':'4'}" />
<c:set var="bigLabelWidth" value="${field.width > 6?'10':'7'}" />
</c:if>
<c:if test="${not empty quiz}">
<c:set var="labelWidth" value="6" />
</c:if>
<div class="col-sm-${field.width}${field.last?' lastcol':''}${field.first?' firstcol':''}">
	<div class="${field.type}${not empty errorFields[field.name]?' error':''}">
		<c:set var="requireHTML"><abbr title="${ci18n['message.required']}" class="require">*</abbr></c:set>
		<c:choose>	
			<c:when test="${field.type eq 'text' || field.type eq 'email' || field.type eq 'vat'}">
				<div class="form-group${not empty errorFields[field.name]?' has-error':''} has-feedback">
					<label class="control-label" for="${field.name}">${field.label} ${field.require?requireHTML:''}</label>				
					<input class="form-control" type="text" name="${field.name}" id="${field.name}" value="${requestService.parameterForAttributeMap[field.name]}" placeholder="${field.label}${field.require?'*':''}" />
					<c:if test="${not empty errorFields[field.name]}"><span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span></c:if>
				</div>
			</c:when>
			<c:when test="${field.type eq 'number'}">
				<div class="form-group${not empty errorFields[field.name]?' has-error':''} has-feedback">
					<label class="control-label" for="${field.name}">${field.label} ${field.require?requireHTML:''}</label>				
					<input class="form-control" type="number" name="${field.name}" id="${field.name}" value="${requestService.parameterForAttributeMap[field.name]}" placeholder="${field.label}${field.require?'*':''}" />
					<c:if test="${not empty errorFields[field.name]}"><span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span></c:if>
				</div>
			</c:when>
			<c:when test="${field.type eq 'large-text'}">
				<div class="form-group${not empty errorFields[field.name]?' has-error':''} has-feedback">
					<label class="control-label" for="${field.name}">${field.label} ${field.require?requireHTML:''}</label>
					<textarea class="form-control" name="${field.name}" id="${field.name}" placeholder="${field.label}${field.require?'*':''}">${requestService.parameterForAttributeMap[field.name]}</textarea>
					<c:if test="${not empty errorFields[field.name]}"><span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span></c:if>
				</div>
			</c:when>
			<c:when test="${field.type eq 'yes-no'}">				
				<div class="form-group${not empty errorFields[field.name]?' has-error':''} has-feedback">
					<div class="row">
						<c:if test="${not empty errorFields[field.name]}"><div class="col-sm-1"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></div></c:if>		
						<div class="col-sm-${bigLabelWidth}">				
							<label class="control-label" for="${field.name}">${field.label} ${field.require?requireHTML:''}</label>
						</div><div class="col-sm-${not empty errorFields[field.name]?12-bigLabelWidth-1:12-bigLabelWidth}">
							<div class="pull-right">
							<label class="radio-inline" for="${field.name}-yes"><input type="radio" name="${field.name}" value="yes" id="${field.name}-yes"${requestService.parameterForAttributeMap[field.name] eq 'yes'?' checked="checked"':''} />${i18n.view["global.yes"]}</label>
							<label class="radio-inline" for="${field.name}-no"><input type="radio" name="${field.name}" value="no" id="${field.name}-no"${requestService.parameterForAttributeMap[field.name] eq 'no'?' checked="checked"':''} />${i18n.view["global.no"]}</label>
							</div>
						</div>						
					</div>
				</div>				
			</c:when>
			<c:when test="${field.type eq 'true-false'}">				
				<div class="form-group${not empty errorFields[field.name]?' has-error':''} has-feedback">
					<div class="row">
						<c:if test="${not empty errorFields[field.name]}"><div class="col-sm-1"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></div></c:if>		
						<div class="col-sm-${labelWidth}">				
							<label class="control-label" for="${field.name}">${field.label} ${field.require?requireHTML:''}</label>
						</div><div class="col-sm-${not empty errorFields[field.name]?12-labelWidth-1:12-labelWidth}">
							<div class="pull-right">
							<label class="radio-inline" for="${field.name}-true"><input type="radio" name="${field.name}" value="true" id="${field.name}-true"${requestService.parameterForAttributeMap[field.name] eq 'true'?' checked="checked"':''} />${i18n.view["global.true"]}</label>
							<label class="radio-inline" for="${field.name}-false"><input type="radio" name="${field.name}" value="false" id="${field.name}-false"${requestService.parameterForAttributeMap[field.name] eq 'false'?' checked="checked"':''} />${i18n.view["global.false"]}</label>
							</div>
						</div>						
					</div>
				</div>				
			</c:when>	
			<c:when test="${field.type eq 'file'}">				
				<div class="form-group">											
						<label class="control-label" for="${field.name}">${field.label} ${field.require?requireHTML:''}</label>
						<c:if test="${empty requestService.parameterForAttributeMap[field.name]}">
							<input class="form-control" type="file" name="${field.name}" id="${field.name}" />
						</c:if><c:if test="${not empty requestService.parameterForAttributeMap[field.name]}">						
						<div class="input-group mb-2">
        					<div class="input-group-prepend">
        						<c:set var="pathparts" value="${fn:split(requestService.parameterForAttributeMap[field.name], '/')}" /><c:set var="filename" value="${pathparts[fn:length(pathparts) - 1]}" />
          						<a target="_blank" href="${requestService.parameterForAttributeMap[field.name]}" class="input-group-text">${filename}</a>
        					</div>
        					<input class="form-control" type="file" name="${field.name}" id="${field.name}" />
     					</div>
						</c:if>
				</div>
			</c:when>	
			<c:when test="${field.type eq 'list'}">
				<div class="form-group">
						<label class="control-label" for="${field.name}">${field.label} ${field.require?requireHTML:''}</label>
						<div class="form-group${not empty errorFields[field.name]?' has-error':''} has-feedback">				
							<select class="form-control" name="${field.name}" id="${field.name}">
								<c:forEach var="item" items="${field.list}">
									<c:set var="valueAtt" value=' value="${item}"' /><option${requestService.parameterForAttributeMap[field.name] eq item?' selected="selected"':''}${fn:startsWith(item, ".")?' class="title" value=""':valueAtt}>
										${fn:startsWith(item, ".")?fn:substring(item,1,fn:length(item)):item}
									</option>
								</c:forEach>
							</select>
						<c:if test="${not empty errorFields[field.name]}"><span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span></c:if>							
					</div>
				</div>
			</c:when>		
			<c:when test="${field.type eq 'registered-list'}">
					<label class="control-label" for="${field.name}">${field.label} ${field.require?requireHTML:''}</label>					
					<div class="form-group${not empty errorFields[field.name]?' has-error':''} has-feedback">
						<select class="form-control" name="${field.name}" id="${field.name}">
							<option value=""></option>
							<c:forEach var="item" items="${sortedList[field.registeredList]}"> 
								<c:set var="valueAtt" value='value="${item.key}"' /><option${requestService.parameterForAttributeMap[field.name] eq item.key?' selected="selected"':''} ${fn:startsWith(item.value, ".")?' class="title" value=""':valueAtt}>
									${fn:startsWith(item.value, ".")?fn:substring(item.value,1,fn:length(item.value)):item.value}
								</option> 
							</c:forEach>
						</select>
						<c:if test="${not empty errorFields[field.name]}"><span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span></c:if>								
					</div>
			</c:when>
			<c:when test="${field.type eq 'static-title'}">
				<div class="form-group">
					<div class="row">
						<div class="col-12 static-title">
							<h3>${field.label}</h3>
						</div>						
					</div>
				</div>
			</c:when>
			<c:when test="${field.type eq 'static-text'}">
				<div class="form-group">
					<div class="row">
						<div class="col-12 static-text">
							<p>${field.label}</p>
						</div>						
					</div>
				</div>
			</c:when>
			<c:when test="${field.type eq 'validation'}">				
				 <div class="checkbox"><label for="${field.name}"><input type="checkbox" name="${field.name}" id="${field.name}" ${not empty requestService.parameterForAttributeMap[field.name]?'checked="checked"':''} />${field.label} ${field.require?requireHTML:''}</label></div>
			</c:when>
			<c:otherwise><p>type not found (${field.name}) : ${field.type}</p></c:otherwise>
		</c:choose>
	</div>
</div>
<c:if test="${field.last}">
	</div> <!-- /col-line  -->
</c:if>