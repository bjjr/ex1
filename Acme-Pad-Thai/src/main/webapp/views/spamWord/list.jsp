<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl"	uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>

<!-- Listing grid -->

<display:table pagesize="5" class="displaytag" keepStatus="true"
	name="spamWords" requestURI="${requestURI}" id="row">
	
	<!-- Attributes -->

	<spring:message code="spamWord.word" var="wordHeader" />
	<display:column property="word" title="${wordHeader}" sortable="true" />
	
	<display:column>
		<jstl:if test="${!obligatorySpamWords.contains(row)}">
			<a href="spamWord/administrator/edit.do?spamWordId=${row.id}">
				<spring:message	code="spamWord.edit" />
			</a>
		</jstl:if>
	</display:column>

</display:table>

<input type="button" name="createSpamWord"
	value="<spring:message code="spamWord.registerSpamWord" />" 
	onclick="window.location='spamWord/administrator/register.do'" />&nbsp;

