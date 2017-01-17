<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl"	uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>

<!-- Listing grid -->

<display:table pagesize="5" class="displaytag" keepStatus="true"
	name="messages" requestURI="${requestURI}" id="row">
	
	<!-- Attributes -->

	<spring:message code="message.moment" var="momentHeader" />
	<display:column property="moment" title="${momentHeader}" sortable="true" />
	
	<spring:message code="message.subject" var="subjectHeader" />
	<display:column property="subject" title="${subjectHeader}" sortable="false" />
	
	<spring:message code="message.body" var="bodyHeader" />
	<display:column property="body" title="${bodyHeader}" sortable="false" />
	
	<spring:message code="message.priority" var="priorityHeader" />
	<display:column property="priority.priority" title="${priorityHeader}" sortable="true" />
	
	<spring:message code="message.sender" var="senderHeader" />
	<display:column property="sender.userAccount.username" title="${senderHeader}" sortable="true" />
	
	<jstl:if test="${outbox == true}">
		<spring:message code="message.recipients" var="recipientsHeader" />
		<display:column title="${recipientsHeader}" sortable="false">
			<jstl:forEach var="r" items="${row.recipients}">
				<jstl:out value="${r.userAccount.username}"></jstl:out>
				<br />
			</jstl:forEach>
		</display:column>
		
	</jstl:if>	
	
	<display:column>
		<a href="message/selectFolder.do?messageId=${row.id}&actualFolderId=${actualFolderId}">
			<spring:message	code="message.move" />
		</a>
	</display:column>
	
	<display:column>
		<jstl:if test="${trashbox == true}">
			<a href="message/delete.do?messageId=${row.id}&actualFolderId=${actualFolderId}"
			onclick="return confirm('<spring:message code="message.confirm.delete" />')"><spring:message code="message.delete" /></a>
		</jstl:if>
		<jstl:if test="${trashbox == false}">
			<a href="message/moveToTrashbox.do?messageId=${row.id}&folderId=${folderId}"
				onclick="return confirm('<spring:message code="message.confirm.moveToTrashbox" />')"><spring:message code="message.moveToTrashbox" /></a>
		</jstl:if>
	</display:column>

</display:table>
<br />
	<input type="button" name="createMessage"
		value="<spring:message code="message.createMessage" />" 
		onclick="window.location='message/create.do'" />&nbsp;
		
