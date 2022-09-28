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
		<h1>Welcome</h1>
		<div class="row">
			<div class="col">
				<h2>Register</h2>
			    <form:form action="/register" method="POST" modelAttribute="newUser">
			    	<div class="form-group">
			            <form:label path="userName">User Name:</form:label>
			            <form:errors path="userName" class="text-danger"/>
			            <form:input class="form-control" type="text" path="userName"/>
			        </div>
			        <div class="form-group">
			            <form:label path="email">Email:</form:label>
			            <form:errors path="email" class="text-danger"/>
			            <form:input class="form-control" type="text" path="email"/>
			        </div>
			        <div class="form-group">
			            <form:label path="password">Password:</form:label>
			            <form:errors path="password" class="text-danger"/>
			            <form:input class="form-control" type="password" path="password"/>
			        </div>
			        <div class="form-group">
			            <form:label path="confirm">Confirm Password:</form:label>
			            <form:errors path="confirm" class="text-danger"/>
			            <form:input class="form-control" type="password" path="confirm"/>
			        </div>
			        <input class="btn btn-primary mt-2" type="submit" value="Submit">
		    	</form:form>
			</div>
			<div class="col">
				<h2>Log In</h2>
				<form:form action="/login" method="POST" modelAttribute="newLogin">			    	
			        <div class="form-group">
			            <form:label path="email">Email:</form:label>
			            <form:errors path="email" class="text-danger"/>
			            <form:input class="form-control" type="text" path="email"/>
			        </div>
			        <div class="form-group">
			            <form:label path="password">Password:</form:label>
			            <form:errors path="password" class="text-danger"/>
			            <form:input class="form-control" type="password" path="password"/>
			        </div>
			        <input class="btn btn-primary mt-2" type="submit" value="Submit">
			    </form:form>
			</div>
		</div>
	 </div>
</body>
</html>