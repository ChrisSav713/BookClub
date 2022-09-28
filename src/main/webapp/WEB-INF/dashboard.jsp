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
		<div class="row">
			<h1>Welcome <c:out value="${user.getUserName()}"/> </h1>
		</div>
		<div class="row">
			<div class="col-8">
				<h5>Books from everyone's shelves:</h5>
			</div>
			<div class="col">
				<a href="/books/new">Add a Book to my shelf</a>
			</div>
			<div class="col">
				<a href="/logout">Logout</a>
			</div>
		</div>
	
		
		<div class="grid-container">
	        <table class="table table-striped table-bordered table-hover">
	            <thead class="table-primary ">
	                <tr>
	                    <th>ID</th>
	                    <th>Title</th>
	                    <th>Author</th>
	                    <th>Posted By</th>
	                </tr>
	            </thead>
	            <tbody>
	            	<c:forEach var="book" items="${books}">
	                <tr>
	                	<td><c:out value="${book.getId()}"/></td>
	                	<td><a href="/books/${book.getId()}/view"><c:out value="${book.getTitle()}"/></a></td>                	
	                    <td><c:out value="${book.getAuthor()}"/></td>
	                    <td><c:out value="${book.getUser().getUserName()}"/></td>
	                </tr>
	                </c:forEach>
	            </tbody>
	        </table>
	    </div>
    </div>
</body>
</html>