<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%>
<!-- conditions script -->
<script>
	function form${compid}Change() {
		var form = document.getElementById('form-${compid}');		
		<c:forEach var="field" items="${comp.fields}"><c:if test="${not empty field.conditionField}">
		    var value = form['${field.conditionField}'].checked;
		    if (value == undefined) {
		    	value = form['${field.conditionField}'].value;
		    }
		    
		    let inputWrapper = form['${field.name}'];
		    while (inputWrapper != null && !inputWrapper.classList.contains('row')) {
		    	inputWrapper = inputWrapper.parentElement;
		    }
		    if(inputWrapper==null) {
		    	inputWrapper = form['${field.name}'];
		    }
		    
		    if (value == ${field.conditionTest}) {
				inputWrapper.classList.add('visible');
				inputWrapper.classList.remove('hidden');
				console.log("inputWrapper.data.requiered = ",inputWrapper.dataset.required)
				if (form['${field.name}'].getAttribute("data-required") == null) {
					form['${field.name}'].setAttribute("data-required", form['${field.name}'].getAttribute("required") != null);
				}
				if (form['${field.name}'].dataset.required) {
					form['${field.name}'].setAttribute("required","");
				}
			} else {
				inputWrapper.classList.add('hidden');
				inputWrapper.classList.remove('visible');
				if (form['${field.name}'].dataset.required) {
					form['${field.name}'].removeAttribute("required");
				}
			}
		</c:if></c:forEach>
	}
	var form = document.getElementById('form-${compid}');
	form.onChange = form${compid}Change;
	form${compid}Change();
</script>