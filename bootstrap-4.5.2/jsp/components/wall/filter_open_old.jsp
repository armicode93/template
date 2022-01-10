<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><div class="card filter">
	<a class="btn-block card-header" data-toggle="collapse" href="#filter-fields" role="button" aria-expanded="false" aria-controls="filter-fields">
		<c:if test="${!socialFilter.filterEmpty}"><div class="header-icon">${countResult} <i class="fas fa-filter" aria-hidden="true"></i></div></c:if>
		${i18n.view['content.social.wall.filter']}
	</a>			
	<div class="card-body collapse" id="filter-fields">
		<form action="${info.currentURL}" method="post" id="filter-form">
			<div>
				<input type="hidden" name="webaction" value="wall.updatefilter" />
				<input type="hidden" name="comp-id" value="${compid}" />
				<input type="hidden" name="page" value="1" />						
				<div class="row">
					<div class="col-md-4">
						<div class="form-group row">
							<label for="text-author" class="col-sm-3 col-form-label">${i18n.view['global.author']}</label>
							<div class="col-sm-9"><input type="text" name="text-author" id="text-author" class="form-control" value="${socialFilter.author}" /></div>
						</div>
					</div><div class="col-md-4">
						<div class="form-group row">
							<label for="text-title" class="col-sm-3 col-form-label">${i18n.view['global.title']}</label>
							<div class="col-sm-9"><input type="text" name="text-title" id="text-title" class="form-control" value="${socialFilter.title}" /></div>
						</div>
					</div><c:if test="${!info.admin}"><div class="col-md-4">
						<div class="form-group form-check">
							<input type="checkbox" class="form-check-input" id="filter-mine" name="filter-mine" ${socialFilter.onlyMine?'checked="checked"':''} />
							<label class="form-check-label" for="filter-mine">${i18n.view['global.only-mine']}</label>
						</div>								
					</div></c:if>
					<c:if test="${info.admin}">
						<div class="col-md-4">
							<input type="checkbox" class="form-check-input" id="notvalided-filter" name="notvalided" ${socialFilter.notValided?'checked="checked"':''} />
							<label class="form-check-label" for="notvalided-filter">Not valided</label>
						</div>
					</c:if>
				</div>
				<div class="row">
					<div class="col-6">
							<button type="submit" class="btn btn-standard btn-block btn-sm" name="reset" value="true">${i18n.view['global.reset']}</button>
					</div><div class="col-6">
						<button type="submit" class="btn btn-primary btn-block btn-sm">${i18n.view['content.social.wall.filter-submit']}</button>
					</div>
				</div>
			</div>
		</form>
	</div>
</div>