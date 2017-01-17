<%@page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>

<form:form action="text/cook/edit.do?masterClassId=${masterClassId}" modelAttribute="text">

	<form:hidden path="id" />
	<form:hidden path="version" />
	
	<form:label path="title">
		<spring:message code="text.title" />
	</form:label>
	<form:input path="title" />
	<form:errors cssClass="error" path="title" />
	<br />
	
	<form:label path="abstractText">
		<spring:message code="text.abstractText" />
	</form:label>
	<form:input path="abstractText" />
	<form:errors cssClass="error" path="abstractText" />
	<br />
	
	<form:label path="attachments">
		<spring:message code="text.attachments" />
	</form:label>
	<form:textarea path="attachments" />
	<form:errors cssClass="error" path="attachments" />
	<br />
	
	<form:label path="body">
		<spring:message code="text.body" />
	</form:label>
	<form:textarea path="body" />
	<form:errors cssClass="error" path="body" />
	<br />

	<!-- Action buttons -->
	<input type="submit" name="save"
		value="<spring:message code="text.save"/>" />
	<jstl:if test="${text.id != 0}">
		<input type="submit" name="delete"
		 value="<spring:message code="text.delete" />"
		 onclick="return confirm('<spring:message code="text.confirm.delete" />')"/>
	</jstl:if>
	<input type="button" name="cancel"
		value="<spring:message code="text.cancel" />"
		onclick="window.location='learningMaterial/cook/list.do?masterClassId=${masterClassId}'" />
		
</form:form>