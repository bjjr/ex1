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

<jstl:if test="${banner != ''}">
	<img src="${banner}" alt="Banner" style="width: 25vw"/>
</jstl:if>

<h2>
	<spring:message code="recipe.information" />
</h2>
<br />
<display:table pagesize="5" class="displaytag" name="recipe"
	requestURI="${requestURI}" id="row">

	<spring:message code="recipe.title" var="titleHeader" />
	<display:column property="title" title="${titleHeader}"
		sortable="false" />

	<spring:message code="recipe.ticker" var="tickerHeader" />
	<display:column property="ticker" title="${tickerHeader}"
		sortable="false" />

	<spring:message code="recipe.user.name" var="nameUserHeader" />
	<display:column property="user.name" title="${nameUserHeader}"
		sortable="true"></display:column>

	<spring:message code="recipe.summary" var="summaryHeader" />
	<display:column property="summary" title="${summaryHeader}"
		sortable="false" />

	<spring:message code="recipe.momentAuthored" var="momentAuthoredHeader" />
	<display:column property="momentAuthored"
		title="${momentAuthoredHeader}" sortable="false" />

	<spring:message code="recipe.momentLastUpdated"
		var="momentLastUpdatedHeader" />
	<display:column property="momentLastUpdated"
		title="${momentLastUpdatedHeader}" sortable="false" />

	<spring:message code="recipe.pictures" var="picturesHeader" />
	<display:column title="${picturesHeader}">
		<jstl:forEach items="${row.pictures }" var="pic">
			<img src="${pic}" />
			<br />
		</jstl:forEach>
	</display:column>

	<spring:message code="recipe.hints" var="hintsHeader" />
	<display:column title="${hintsHeader}">
		<jstl:forEach items="${row.hints }" var="hint">
			<jstl:out value="${hint }"></jstl:out>
			<br />
		</jstl:forEach>
	</display:column>

	<spring:message code="recipe.likesSA" var="likesSAHeader" />
	<display:column title="${likesSAHeader }">
		<jstl:out value="${likesSA}"></jstl:out>
	</display:column>

	<spring:message code="recipe.dislikesSA" var="dislikesSAHeader" />
	<display:column title="${dislikesSAHeader }">
		<jstl:out value="${dislikesSA}"></jstl:out>
	</display:column>

	<spring:message code="recipe.categories" var="categoriesHeader" />
	<display:column title="${categoriesHeader}">
		<jstl:forEach items="${row.categories }" var="category">
			<jstl:out value="${category.name }"></jstl:out>
			<br />
		</jstl:forEach>
	</display:column>

</display:table>

<h2>
	<spring:message code="recipe.ingredients" />
</h2>
<br />
<display:table pagesize="5" class="displaytag" name="quantities"
	requestURI="${requestURI}" id="quantity">

	<spring:message code="ingredient.name" var="nameIngredientHeader" />
	<display:column property="ingredient.name"
		title="${nameIngredientHeader}" sortable="false" />

	<spring:message code="quantity.quantity" var="quantityHeader" />
	<display:column property="value" title="${quantityHeader}"
		sortable="false" />

	<spring:message code="quantity.unit" var="unitHeader" />
	<display:column property="unit.unit" title="${unitHeader}"
		sortable="false" />

	<security:authorize access="hasRole('USER')">
		<jstl:if test="${owner}">
			<display:column>
				<a
					href="quantity/edit.do?recipeId=${recipe.id}&quantityId=${quantity.id}">
					<spring:message code="quantity.edit" />
				</a>
			</display:column>
		</jstl:if>
	</security:authorize>

</display:table>

<security:authorize access="hasRole('USER')">
	<jstl:if test="${owner}">
		<a href="quantity/create.do?recipeId=${recipe.id}"> <spring:message
				code="quantity.add" />
		</a>
	</jstl:if>
</security:authorize>

<h2>
	<spring:message code="recipe.steps" />
</h2>
<br />
<display:table pagesize="5" class="displaytag" name="steps"
	requestURI="${requestURI}" id="step">

	<spring:message code="step.description" var="descriptionHeader" />
	<display:column property="description" title="${descriptionHeader}"
		sortable="false" />

	<spring:message code="step.picture" var="stepPictureHeader" />
	<display:column property="picture" title="${stepPictureHeader}"
		sortable="false">
		<img src="${picture}" />
	</display:column>

	<spring:message code="step.hints" var="stepHintsHeader" />
	<display:column title="${stepHintsHeader}">
		<jstl:forEach items="${step.hints }" var="hint">
			<jstl:out value="${hint }"></jstl:out>
			<br />
		</jstl:forEach>
	</display:column>

	<security:authorize access="hasRole('USER')">
		<jstl:if test="${owner}">
			<display:column>
				<a href="step/edit.do?recipeId=${recipe.id}&stepId=${step.id}">
					<spring:message code="step.edit" />
				</a>
			</display:column>
		</jstl:if>
	</security:authorize>

</display:table>

<security:authorize access="hasRole('USER')">
	<jstl:if test="${owner}">
		<a href="step/create.do?recipeId=${recipe.id}"> <spring:message
				code="step.add" />
		</a>
	</jstl:if>
</security:authorize>

<h2>
	<spring:message code="recipe.comments" />
</h2>
<br />
<display:table pagesize="5" class="displaytag" name="comments"
	requestURI="${requestURI}" id="comment">

	<spring:message code="comment.title" var="commentTitleHeader" />
	<display:column property="title" title="${commentTitleHeader}"
		sortable="false" />

	<spring:message code="comment.text" var="textHeader" />
	<display:column property="text" title="${textHeader}" sortable="false" />

	<spring:message code="comment.stars" var="starsHeader" />
	<display:column property="stars" title="${starsHeader}"
		sortable="false" />

	<spring:message code="comment.identity" var="identityHeader" />
	<display:column property="identity" title="${identityHeader}"
		sortable="false" />

	<spring:message code="comment.moment" var="momentHeader" />
	<display:column property="moment" title="${momentHeader}"
		sortable="false" />

</display:table>