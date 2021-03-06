<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><c:if test="${!param.hideform}"><c:if test="${not empty info.userName}">
<div class="widgetbox edit-user">
<h3><span>${i18n.edit['user.change-password']}</span></h3>
<div class="content">
<form id="form-edit-pwd" action="${info.currentURL}" method="post" role="form" enctype="multipart/form-data">
<div class="row">
<div>
	<input type="hidden" name="webaction" value="changePassword" />
	<input type="hidden" name="user" value="${user.name}" />
</div>
<div class="col-sm-6">
<div class="form-group">
	<label>${i18n.edit['user.current-password']}<input class="form-control" type="password" id="password" name="password" value="" /></label> 
</div>
</div><div class="col-sm-6">
<div class="form-group">
	<label>${i18n.edit['user.new-password']}<input class="form-control" type="password" id="newpassword" name="newpassword" value="" /></label>	 
</div>
<div class="form-group"><input type="submit"  class="btn btn-default" name="ok" value="${i18n.edit['global.ok']}" /></div>
</div>
</div>
</form>
</div>
</div>
</c:if>

<div class="widgetbox edit-user">
<c:if test="${not empty info.userName}"><h3><span>${i18n.edit['user.title.edit']} : ${user.name}</span></h3></c:if>
<div class="content">
<form id="form-edit-user" action="${info.userName}" method="post" enctype="multipart/form-data" role="form">

<div>
	<c:if test="${not empty info.userName}"><input type="hidden" name="webaction" value="user-registration.update" /></c:if>
	<c:if test="${empty info.userName}"><input type="hidden" name="webaction" value="user-registration.register" /></c:if>
	<input type="hidden" name="user" value="${user.name}" />
	<input type="hidden" name="comp-id" value="${compid}" />	
</div>

<fieldset>
<legend>${i18n.edit['user.info']}</legend>
<div class="row">
<div class="col-sm-4">
	<div class="form-group login">
		<label for="login">email
		<input class="form-control" type="email" id="login" name="email-login" value="${userInfoMap["login"]}" /></label> 
	</div>
	<c:if test="${empty info.userName}">
		<div class="form-group password">
			<label for="password">${i18n.view['form.password']}
			<input class="form-control" type="password" id="password" name="password" value="" /></label> 
		</div>	
		<div class="form-group password">
			<label for="password2">${i18n.view['form.password2']}
			<input class="form-control" type="password" id="password2" name="password2" value="" /></label>		 
		</div>
	</c:if>
	<div class="form-group firstName">
		<label for="firstName">firstName
		<input class="form-control" type="text" id="firstName" name="firstName" value="${userInfoMap["firstName"]}" /></label> 
	</div>
	<div class="form-group lastName">
		<label for="lastName">lastName
		<input class="form-control" type="text" id="lastName" name="lastName" value="${userInfoMap["lastName"]}" /></label> 
	</div>
	<div class="form-group organization">
		<label for="organization">${i18n.edit['field.organization']}
		<c:if test="${empty list.organization}">
		<input class="form-control" type="text" id="organization" name="organization" value="${userInfoMap["organization"]}" />
		</c:if> 
		<c:if test="${not empty list.organization}">
		 	<select id="organization" name="organization" class="form-control">
		 		<option></option>
		 		<c:forEach var="organization" items="${list.organization}">
		 			<option value="${organization.key}"${userInfoMap["organization"] == organization.key?' selected="selected"':''}>${organization.value}</option>
		 		</c:forEach>		 		
		 	</select>
		 </c:if> 
		 </label>
	</div>
	<div class="form-group phone">
		<label for="phone">phone
		<input type="text" class="form-control" id="phone" name="phone" value="${userInfoMap["phone"]}" /></label> 
	</div>
	<div class="form-group mobile">
		<label for="mobile">mobile
		<input type="text" id="mobile" class="form-control" name="mobile" value="${userInfoMap["mobile"]}" /></label> 
	</div>
</div>
<div class="col-sm-4 address">
	<div class="form-group">
		<label for="address">address
		<input type="text" id="address" class="form-control" name="address" value="${userInfoMap["address"]}" /></label> 
	</div>
	<div class="form-group postCode">
		<label for="postCode">postCode
		<input type="text" id="postCode" class="form-control" name="postCode" value="${userInfoMap["postCode"]}" /></label> 
	</div>
	<div class="form-group city">
		<label for="city">city
		<input type="text" class="form-control" id="city" name="city" value="${userInfoMap["city"]}" /></label> 
	</div>
	<div class="form-group country">
		<label for="country">country
		<c:if test="${empty list.countries}">
			<input type="text" id="country" name="country" class="form-control" value="${userInfoMap["country"]}" />
		</c:if>
		 <c:if test="${not empty list.countries}">
		 	<select class="form-control" id="country" name="country">
		 		<option></option>
		 		<c:forEach var="country" items="${list.countries}">
		 			<option value="${country.key}"${userInfoMap["country"] == country.key?' selected="selected"':''}>${country.value}</option>
		 		</c:forEach>		 		
		 	</select>
		 </c:if>
		 </label>
	</div>
	<div class="form-group url">
		<label for="url">url
		<input class="form-control" type="text" id="url" name="url" value="${userInfoMap["url"]}" /></label> 
	</div>
	<div class="form-group">
		<label for="specialFunction">Special function
		<input class="form-control" type="text" id="specialFunction" name="specialFunction" value="${userInfoMap["specialFunction"]}" /></label> 
	</div>
	<div class="form-group preferredLanguageRaw">
		<label for="preferredLanguageRaw">preferred Language
		<input type="text" id="preferredLanguageRaw" class="form-control" name="preferredLanguageRaw" value="${userInfoMap["preferredLanguageRaw"]}" /></label> 
	</div>		
</div>
<div class="col-sm-4">
<div class="form-group">
		<label for="experience">Experience
		<textarea class="form-control" id="experience" name="experience">${userInfoMap['experience']}</textarea></label>
</div>
<div class="form-group">
		<label for="recommendation">Recommendation
		<textarea class="form-control" id="recommendation" name="recommendation">${userInfoMap['recommendation']}</textarea></label>
</div>
<div class="form-group">
		<label for="info">More info
		<textarea class="form-control" id="info" name="info">${userInfoMap['info']}</textarea></label>
	</div>
</div>
</div>
</fieldset>
<div class="form-group function">
		<label for="function">area of specialisation</label>
		<c:if test="${empty list.functions}">
		<input class="form-control" type="text" id="function" name="function" value="${userInfoMap['function']}" />
		</c:if>
		 <c:if test="${not empty list.functions}">
		 	<div class="form-group">
		 	<c:forEach var="function" items="${list.functions}" varStatus="status"><div class="form-check form-check-inline">
	 		<label class="checkbox-inline form-check-label" for="function-${status.index}"><input class="form-check-input" type="checkbox" name="function" id="function-${status.index}" value="${function.key}" ${not empty functions[function.key]?' checked="checked"':''}/> ${function.value}</label>
	 		</div></c:forEach>	 		
	 		</div>		
		 </c:if>
</div>
<c:if test="${empty info.userName}">
	<div class="form-group">
		<label for="message">you message to the administrator of the site :
		<textarea class="form-control" id="message" name="message">${param.message}</textarea></label>
	</div>
</c:if>
<c:if test="${param.social}">
<fieldset class="social">
<legend>${i18n.edit['user.social']}</legend>
	<div class="col-sm-4">
		<div class="form-group">
			<label for="facebook">facebook
			<input class="form-control" type="text" id="facebook" name="facebook" value="${userInfoMap['facebook']}" /></label> 
		</div>
		<div class="form-group">
			<label for="googleplus">google+
			<input class="form-control" type="text" id="googleplus" name="googleplus" value="${userInfoMap['googleplus']}" /></label> 
		</div>
	</div>
	<div class="col-sm-4">
	<div class="form-group">
		<label for="linkedin">linkedin
		<input class="form-control" type="text" id="linkedin" name="linkedin" value="${userInfoMap['linkedin']}" /></label> 
	</div>
	<div class="form-group">
		<label for="twitter">twitter
		<input class="form-control" type="text" id="twitter" name="twitter" value="${userInfoMap['twitter']}" /></label> 
	</div>
	</div>
	<div class="col-sm-4">
	<div class="form-group">
		<label for="pushbulletToken">pushbullet token
		<input class="form-control" type="text" id="pushbulletToken" name="pushbulletToken" value="${userInfoMap['pushbulletToken']}" /></label> 
	</div>
	</div>
</fieldset>
</c:if>

<fieldset class="avatar">
<legend>${i18n.edit['user.avatar']}</legend>
	<div class="row">
	<div class="col-6">
		<div class="form-group">
			<label>${i18n.edit['user.current-avatar']}</label>
			<c:choose>
				<c:when test="${not empty info.currentUserAvatarUrl}">
					<img src="${info.currentUserAvatarUrl}?rnd=${info.randomId}" />
					<div class="checkbox">
					<label><input type="checkbox" name="deleteAvatar" value="true" />${i18n.edit['global.delete']}</label> 
					</div>
				</c:when>
				<c:otherwise>
					${i18n.edit['user.no-avatar']} 
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<div class="col-6">
		<div class="form-group">
			<label for="avatar">${i18n.edit['user.new-avatar']}</label>
			<input type="file" id="avatar" name="avatar" /> 
		</div>
	</div>
	</div>
</fieldset>

<fieldset class="Attachments">
<legend>${i18n.edit['user.files']}</legend>
	<div class="row">
	<div class="col-6">
		<div class="form-group">
			<label>${i18n.edit['user.current-files']}</label>
			<c:if test="${fn:length(files)>0}">
			<ul>
			<c:forEach var="file" items="${files}">
				<c:url var="delFile" value="${info.currentURL}" context="/">
					<c:param name="webaction" value="user.deleteFile" />
					<c:param name="name" value="${file.name}" />
				</c:url>
				<li><a href="${delFile}"><i class="far fa-trash-alt"></i> </a><a target="_blank" href="${file.URL}">${file.name}</a>
			</c:forEach>
			</ul>
			</c:if>
		</div>
	</div>
	<div class="col-6">
		<div class="form-group">			
			<label for="userFile">${i18n.edit['user.new-files']}</label>
			<input type="file" id="userFile" name="userFile" /> 
		</div>
	</div>
	</div>
</fieldset>


<div class="form-group text-right">	
	<input class="btn btn-default btn-secondary btn-color btn-back" type="submit" name="back" value="${i18n.edit['global.back']}" />
	<input class="btn btn-primary" type="submit" name="ok" value="${i18n.edit['global.ok']}" />
</div>

</form>

</div>
</div></c:if>
