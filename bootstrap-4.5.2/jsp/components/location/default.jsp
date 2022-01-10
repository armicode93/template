<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib uri="/WEB-INF/javlo.tld" prefix="jv"
%><span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span> <jv:texttohtml><jv:autolink>${value}</jv:autolink></jv:texttohtml>