<%@page import="com.jeevanpuhan.ecom.entities.User"%>
<%
	User user1 = (User) session.getAttribute("currentUser");
%>

<nav class="navbar navbar-expand-lg navbar-dark custom-bg">
	<div class="container">

		<a class="navbar-brand" href="index.jsp">BookStore</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="nav-link"
					href="index.jsp">Home</a></li>
				<li class="nav-item active"><a class="nav-link"
					href="about.jsp">About</a></li>

			</ul>

			
				<ul class="navbar-nav ml-auto mr-auto mb-auto">
					<li>
						<form action="#" method="get" class="form-inline">
							<input class="form-control mr-sm-2" type="search"
								placeholder="Search" aria-label="Search">
							<button class="btn btn-warning my-2 my-sm-0" type="submit">Search</button>
						</form>
					</li>
				</ul>
			



			<ul class="navbar-nav ml-auto">

				<li class="nav-item active"><a class="nav-link" href="#"
					data-toggle="modal" data-target="#cart"><i
						class="fa fa-cart-plus" style="font-size: 20px;"></i> <span
						class="cart-items">(0)</span> </a></li>

				<%
					if (user1 == null) {
				%>
				<li class="nav-item active"><a class="nav-link"
					href="login.jsp">Login</a></li>

				<li class="nav-item active"><a class="nav-link"
					href="register.jsp">Register</a></li>
				<%
					} else {
				%>
				<li class="nav-item active"><a class="nav-link"
					href="customer.jsp"><%=user1.getUserName()%></a></li>

				<li class="nav-item active"><a class="nav-link" href="/logout">Logout</a></li>
				<%
					}
				%>

			</ul>

		</div>
	</div>
</nav>