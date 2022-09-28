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
</head>
<body>
	<div class="container">
		<h2>Edit Book</h2>
	    <form:form action="/books/${book.getId()}/update" method="POST" modelAttribute="book">
	    	<input type="hidden" name="_method" value="put">
	        <div class="form-group">
	            <form:label path="title">Title:</form:label>
	            <form:errors path="title" class="text-danger"/>
	            <form:input class="form-control" type="text" path="title"/>
	        </div>
	        <div class="form-group">
	            <form:label path="author">Author:</form:label>
	            <form:errors path="author" class="text-danger"/>
	            <form:input class="form-control" type="text" path="author"/>
	        </div>
	        <div class="form-group">
	            <form:label path="thoughts">Thoughts:</form:label>
	            <form:errors path="thoughts" class="text-danger"/>
	            <form:textarea class="form-control" path="thoughts" rows="5"></form:textarea>
	        </div>
	        <div class="form-group">
				<form:errors path="user" class="error"/>
				<form:input class="form-control" type="hidden" path="user" value="${user.getId()}"/>
			</div>
	        <input class="btn btn-primary mt-2" type="submit" value="Submit">
	        <a href="/home" type="button" class="btn btn-primary mt-2">Go Back</a>
	    </form:form>
	</div>
</body>
</html>