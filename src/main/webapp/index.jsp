<%@page import="com.jeevanpuhan.ecom.entities.Category"%>
<%@page import="com.jeevanpuhan.ecom.dao.CategoryDao"%>
<%@page import="com.jeevanpuhan.ecom.entities.Product"%>
<%@page import="java.util.List"%>
<%@page import="com.jeevanpuhan.ecom.dao.ProductDao"%>
<%@page import="com.jeevanpuhan.ecom.helper.FactoryProvider"%>
<%@page import="com.jeevanpuhan.ecom.helper.Helper"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<%@include file="/components/common_css_js.jsp"%>
<title>Online BookStore</title>
</head>
<body>
	<%@include file="/components/navbar.jsp"%>
	
	<div class="container-fluid">
	<div class="row mt-3 mx-2">

		<%
			String cat = request.getParameter("category");
			/* out.println(cat); */
			
			ProductDao productDao = new ProductDao(FactoryProvider.getFactory());
			List<Product> plist = null;
			
			if(cat == null || cat.trim().equals("all")) {
				plist = productDao.getAllProducts();
				
			} else {
				
				int cid = Integer.parseInt(cat.trim());
				plist = productDao.getProductsByCategoryId(cid);
			}
			

			CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
			List<Category> clist = categoryDao.getCategories();
		%>

		<!-- show categories -->
		<div class="col-md-2">

			<div class="list-group mt-4">

				<a href="index.jsp?category=all" class="list-group-item list-group-item-action active">
					All Categories </a>

				<%
					for (Category c : clist) {
		
				%>	
					<a href="index.jsp?category=<%= c.getCategoryId() %>" class="list-group-item list-group-item-action"><%= c.getCategoryTitle() %></a>
	
				<%		
					}
				%>

			</div>
		</div>

		<!-- show products -->
		<div class="col-md-10">
			
			<!-- row -->
			<div class="row mt-4">
			
				<div class="col-md-`12">
					
					<div class="card-columns">
						
						<!-- traversing products -->
						
						<%
							for(Product p:plist) {

						%>
						<!-- product card -->
						<div class="card product-card">
						
						<div class="container text-center">
							<img class="card-img-top m-2" src="img/products/<%= p.getpPhoto() %>" style="max-height: 200px; max-width: 100%; width: auto;" alt="Card image cap">
						</div>
						
							<div class="card-body">
								
								<h5 class="card-title"><%= p.getpName() %></h5>
								<p class="card-text">
									<%= Helper.getShortDesc(p.getpDesc()) %>
								</p>
							</div>
							
							<div class="card-footer text-center">
								
								<button class="btn custom-bg text-white" onclick="addToCart(<%= p.getpId()%>,'<%= p.getpName()%>',<%= p.getPriceAfterDiscount()%>)">Add To Cart</button>
								<button class="btn btn-outline-success">&#8377 <%= p.getPriceAfterDiscount()%>/- <span class="text-secondary discount-label font-weight-bold font-italic"> &#8377 <%= p.getpPrice() %>, <%= p.getpDiscount() %>% off</span></button>
								
							</div>
							
						</div>
						
						
						<%}
							
						if(plist.size() == 0) {
							
							out.println("<h3>No item in this category!</h3>");
						}
						%>
						
					</div>
					
				</div>
			
			</div>
			

		</div>

	</div>
	</div>
	
	<%@include file="/components/common_modals.jsp" %>
	
</body>
</html>