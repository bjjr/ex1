<%@page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security"	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>

<!-- Check model variables  -->
<!-- Check conditions and authorities  -->
<!-- Check translations codes -->

<display:table name="skels" id="skel"
  requestURI="${requestURI}" pagesize="5"
  class="displaytag">
  		
  	<spring:message code="skel.translation" var="skelHeader" />
  	<display:column property="skel.property" title="${skelHeader}" sortable="true"/>
  	
  	<!-- Most complex situation, evaluation of various conditions to add a column with a link -->
  	
  	<security:authorize access="isAuthenticated()">
  		<jstl:if test="${CONDITION == false}">
  			<display:column>
  				<a href="ENTITY/ACTION.do?ENTITY_Id=${ENTITY.id}">
		  			<spring:message code="skel.translation" var="skelText" />
		  			<jstl:out value="${skelText}" />
		  		</a>
  			</display:column>
  		</jstl:if>
  	</security:authorize>
  	
  	<!-- Examples of has(Any)Role('ACTOR') conditions -->
  	
  	<security:authorize access="hasRole('COOK')">
  	</security:authorize>
  	
  	<security:authorize access="hasAnyRole('COOK','ADMINISTRATOR')">
	</security:authorize>
	
	<!-- Example of a link with a confirmation popup -->
	
	<spring:message code="masterClass.confirm.promote" var="confirmPromote" />
	<a href="masterClass/administrator/promote.do?masterClassId=${masterClass.id}"
	 onclick="return confirm('${confirmPromote}')">
		<spring:message code="masterClass.promote" var="promoteText" />
		<jstl:out value="${promoteText}" />
	</a>
				
</display:table>