<%@page import="com.jeevanpuhan.ecom.entities.User"%>

<%

	User user = (User) session.getAttribute("currentUser");
	if(user == null) {
		session.setAttribute("message", "Please login to continue!");
		//System.out.println("user is null");
		response.sendRedirect("login.jsp");
		return;
	}	

%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer Panel</title>
<%@include file="/components/common_css_js.jsp" %>
</head>
<body>
	<%@include file="/components/navbar.jsp" %>
	<h1>This is Customer Panel</h1>
</body>
</html>