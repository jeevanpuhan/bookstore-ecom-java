<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<%@include file="/components/common_css_js.jsp" %>
<title>Register User</title>
</head>
<body>
	<%@include file="/components/navbar.jsp" %>
	
	<div class="container-fluid">
		
	<div class="row mt-3">
		<div class="col-md-4 offset-md-4">
			<div class="card">
			
			<%@include file="/components/message.jsp" %>
			
				<div class="card-body px-5">
					
			<h3 class="text-center my-3">Create New Account</h3>
			<form action="/register" method="post">
				<div class="form-group">
			    <label for="username">Username</label>
			    <input name="username" type="text" class="form-control" id="username" aria-describedby="emailHelp" placeholder="Choose a username">
			  	</div>
			  
				<div class="form-group">
			    <label for="email">Email</label>
			    <input name="email" type="email" class="form-control" id="email" aria-describedby="emailHelp" placeholder="Enter your email">
			  	</div>
			  
				<div class="form-group">
			    <label for="password">Password</label>
			    <input name="password" type="password" class="form-control" id="password" aria-describedby="emailHelp" placeholder="Enter your password">
			  	</div>
			  
				<div class="form-group">
			    <label for="phone">Phone</label>
			    <input name="phone" type="tel" class="form-control" id="phone" name="phone" pattern="[0-9]{10}" aria-describedby="emailHelp" placeholder="Enter your Phone Number">
			  	</div>
			  	
				<div class="form-group">
			    <label for="address">Address</label>
			    <textarea name="address" id="address" cols="20" rows="2" class="form-control" placeholder="Enter your address"></textarea>
			  	</div>
			  	
			  	<div class="container text-center">
			  		<button class="btn btn-outline-success" type="submit">Register</button>
			  		<button class="btn btn-outline-warning" type="reset">Reset</button>
			  	
			  	</div>
			</form>
		
				</div>
			</div>
			
		</div>
	</div>
	
	</div>
	
</body>
</html>