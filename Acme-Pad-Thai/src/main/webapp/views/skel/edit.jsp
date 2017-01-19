<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security"	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@taglib prefix="tg" uri="http://displaytag.sf.net"%>

<!-- Check if action link is correct -->
<!-- Mind the different types of inputs -->
<!-- Check the attributes needed in the form:hidden -->
<!-- Check the end buttons -->

<form:form action="skel/edit.do" modelAttribute="skel">

	<form:hidden path="id"/>
	<form:hidden path="version"/>
	<form:hidden path="propertyToNotEdit"/>
	
	<div>
		<form:label path="propertyToEdit">
			<spring:message code="skel.translation" />
		</form:label>
		
		<form:input path="propertyToEdit"/>
		
		<form:errors cssClass="error" path="propertyToEdit" />
	</div>
	
	<div>
		
		<spring:message code="skel.save" var="saveText"/>
		<input type="submit" name="save" value="${saveText}"/>
		
		<jstl:if test="${skel.id != 0}" >
			<spring:message code="skel.delete" var="deleteText" />
			<spring:message code="skel.confirm.delete" var="confDeleteText" />
			<input type="submit" name="delete" value="${deleteText}"
				onclick="return confirm('${confDeleteText}')" />
		</jstl:if>
	
		<spring:message code="skel.cancel" var="cancelText" />
		<input type="button" name="cancel" value="${cancelText}"
			onclick="window.location='CHANGEPATH'" />
		
	</div>
	
</form:form>