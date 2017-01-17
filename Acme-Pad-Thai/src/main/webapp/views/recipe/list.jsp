<%@page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	
<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security"	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>

<!-- Search Form -->
<form:form action="" modelAttribute="recipe">
	<input type="text" name="recipe"/>
	<input type="submit" name="search" value="<spring:message code="recipe.search"/>"/>
</form:form>
	
<!-- Listing grid -->
<display:table pagesize="5" class="displaytag"
	name="recipes" requestURI="${requestURI}" id="row">
	<!-- Attributes -->
	
	<spring:message code="recipe.title" var="titleHeader" />
	<display:column property="title" title="${titleHeader}" sortable="false" />
	
	<spring:message code="recipe.ticker" var="tickerHeader" />
	<display:column property="ticker" title="${tickerHeader}" sortable="false" />
	
	<spring:message code="recipe.categories" var="categoriesHeader" />
	<display:column title="${categoriesHeader}">
		<jstl:forEach items="${row.categories }" var="category">
			<jstl:out value="${category.name }"></jstl:out>
			<br />
		</jstl:forEach>
	</display:column>
	
	<!-- Action links -->
	<spring:message code="recipe.user.name" var="nameHeader" />
	<display:column title="${nameHeader}">
			<a href="user/display.do?userId=${row.user.id}">${row.user.name}</a>
	</display:column> 
	
	<display:column>
			<a href="recipe/display.do?recipeId=${row.id}">
				<spring:message	code="recipe.display" />
			</a>
	</display:column>
	
	<security:authorize access="hasRole('USER')">
	<jstl:if test="${owner}">
		<display:column>
			<a href="recipe/user/qualify.do?recipeId=${row.id}"><spring:message code="recipe.user.qualify"/></a>
		</display:column>
	
		<display:column>
			<a href="recipe/user/edit.do?recipeId=${row.id}"><spring:message code="recipe.user.edit" /></a>
		</display:column>
		
		<display:column>
			<a href="recipe/user/addCategory.do?recipeId=${row.id}"><spring:message code="recipe.user.add.category" /></a>
		</display:column>
		
		<display:column>
			<a href="recipe/user/removeCategory.do?recipeId=${row.id}"><spring:message code="recipe.user.remove.category" /></a>
		</display:column>
	</jstl:if>
	</security:authorize>
	
	<security:authorize access="hasRole('USER') || hasRole('NUTRITIONIST')">
	<display:column>
	<jstl:choose>
	<jstl:when test="${own.contains(row)}">
		<spring:message code="recipe.own"/>
	</jstl:when>
	<jstl:otherwise>
		<jstl:choose>
		<jstl:when test="${likes.contains(row)}">
			<spring:message code="recipe.like"/>
		</jstl:when>
		<jstl:otherwise>
		<a href="recipe/like.do?recipeId=${row.id}"><spring:message code="likeSA.like"/></a>
		<a href="recipe/dislike.do?recipeId=${row.id}"><spring:message code="likeSA.dislike"/></a>
		</jstl:otherwise>
		</jstl:choose>
	</jstl:otherwise>
	</jstl:choose>		
	</display:column>
	</security:authorize>
	
	<security:authorize access="hasRole('USER') || hasRole('NUTRITIONIST')">
	<display:column>
			<a href="recipe/createComment.do?recipeId=${row.id}"><spring:message code="comment.create"/></a>
	</display:column>
	</security:authorize>
			
</display:table>

<security:authorize access="hasRole('USER')">
	<jstl:if test="${owner}">
		<a href="recipe/user/create.do"><spring:message code="recipe.user.create" /></a>
	</jstl:if>
</security:authorize>