<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- c:out ; c:forEach etc. --> 
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Formatting (dates) --> 
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- form:form -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- for rendering errors on PUT routes -->
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/main.css"> <!-- change to match your file/naming structure -->
<script src="/webjars/jquery/jquery.min.js"></script>
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
<style>
.buttons{
	display:flex;
}
</style>
</head>
<body>
	<div class="container">
		<p class="h5">${book.getTitle()}</p>
		<br>
		<c:if test="${user.getId() == book.getUser().getId()}">
			<p class="h5">You read ${book.getTitle()} by ${book.getAuthor()}</p>
			<br>
			<p class="h5">Here are your thoughts:</p>
		</c:if>
		<c:if test="${user.getId() != book.getUser().getId()}">
			<p class="h5">${book.getUser().getUserName()} read ${book.getTitle()} by ${book.getAuthor()}</p>
			<br>
			<p class="h5">Here are ${book.getUser().getUserName()}'s thoughts:</p>
		</c:if>
		<hr>
		<div style="word-wrap: break-word;">
			<p>${book.getThoughts()}</p>
		</div>
		<hr>
	    
	    <div class="buttons">    
	    <a href="/home" type="button" class="btn btn-primary mt-2">Go Back</a>
	    <c:if test="${user.getId() == book.getUser().getId()}">
	    <a href="/books/${book.getId()}/edit" type="button" class="btn btn-primary mt-2">Edit</a>
	    <form:form action="/books/${book.getId()}/delete" method="DELETE"> 
	    	<input type="hidden" name="_method" value="put">  
	    	<input class="btn btn-primary mt-2" type="submit" value="Delete">
	    </form:form>
	    </c:if>
	    </div>
	</div>
</body>
</html>