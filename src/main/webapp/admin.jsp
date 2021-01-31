<%@page import="com.jeevanpuhan.ecom.entities.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.jeevanpuhan.ecom.helper.FactoryProvider"%>
<%@page import="com.jeevanpuhan.ecom.dao.CategoryDao"%>
<%@page import="com.jeevanpuhan.ecom.entities.User"%>

<%
	User user = (User) session.getAttribute("currentUser");
if (user == null) {
	session.setAttribute("message", "Please login to continue!");
	//System.out.println("user is null");
	response.sendRedirect("login.jsp");
	return;
} else {
	if (user.getUserType().equals("customer")) {
		//System.out.println("user is customer");
		response.sendRedirect("customer.jsp");
		return;
	}
}
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Panel</title>
<%@include file="/components/common_css_js.jsp"%>
</head>
<body>
	<%@include file="/components/navbar.jsp"%>

	<div class="container admin">

		<div class="container-fluid mt-3">
			<%@include file="components/message.jsp"%>
		</div>

		<div class="row mt-3">

			<!-- first column -->
			<div class="col-md-4">
				<div class="card">
					<div class="card-body text-center">
						<div class="container">
							<img style="max-width: 125px;" class="img-fluid"
								src="img/team.png" alt="user-icon" />
						</div>

						<h1>15000</h1>
						<h1 class="text-uppercase text-muted">Users</h1>
					</div>
				</div>
			</div>
			<!-- second column -->
			<div class="col-md-4">
				<div class="card">
					<div class="card-body text-center">
						<div class="container">
							<img style="max-width: 125px;" class="img-fluid"
								src="img/list.png" alt="user-icon" />
						</div>

						<h1>250</h1>
						<h1 class="text-uppercase text-muted">Categories</h1>
					</div>
				</div>
			</div>
			<!-- third column -->
			<div class="col-md-4">
				<div class="card">
					<div class="card-body text-center">
						<div class="container">
							<img style="max-width: 125px;" class="img-fluid"
								src="img/product.png" alt="user-icon" />
						</div>
						<h1>25000</h1>
						<h1 class="text-uppercase text-muted">Products</h1>
					</div>
				</div>
			</div>
		</div>

		<!-- second row -->

		<div class="row mt-3">

			<!-- second row first column -->
			<div class="col-md-6">
				<div class="card" data-toggle="modal"
					data-target="#add-category-modal">
					<div class="card-body text-center">
						<div class="container">
							<img style="max-width: 125px;" class="img-fluid"
								src="img/maths.png" alt="user-icon" />
						</div>
						<p></p>
						<h1 class="text-uppercase text-muted">Add New Category</h1>
					</div>
				</div>
			</div>

			<!-- second row second column -->
			<div class="col-md-6">
				<div class="card" data-toggle="modal"
					data-target="#add-product-modal">
					<div class="card-body text-center">
						<div class="container">
							<img style="max-width: 125px;" class="img-fluid"
								src="img/plus.png" alt="user-icon" />
						</div>
						<p></p>
						<h1 class="text-uppercase text-muted">Add New Product</h1>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Start Add Category modal -->

	<!-- Modal -->
	<div class="modal fade" id="add-category-modal" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header custom-bg text-white">
					<h5 class="modal-title" id="exampleModalLabel">Add New
						Category</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span class="text-white" aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">

					<form action="ProductOperationServlet" method="post">

						<input type="hidden" name="operation" value="addCategory" />

						<div class="form-group">
							<input type="text" class="form-control" name="categoryTitle"
								placeholder="Enter Category Title" required />
						</div>

						<div class="form-group">
							<textarea class="form-control" rows="4" cols="5"
								placeholder="Enter Category Description"
								name="categoryDescription"></textarea>
						</div>

						<div class="container text-center">

							<button class="btn btn-outline-success">Add Category</button>

						</div>

					</form>

				</div>

			</div>
		</div>
	</div>

	<!-- End Add Category modal -->

	<!-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% -->

	<!-- Start Add Product modal -->

	<!-- Modal -->
	<div class="modal fade" id="add-product-modal" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header custom-bg text-white">
					<h5 class="modal-title" id="exampleModalLabel">Add New Product</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span class="text-white" aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">

					<form action="ProductOperationServlet" method="post" enctype="multipart/form-data">
					
					<input type="hidden" name="operation" value="addProduct" />

						<!-- product title -->
						<div class="form-group">
							<input type="text" class="form-control" name="productTitle"
								placeholder="Enter Product Title" required />
						</div>

						<!-- product description -->
						<div class="form-group">
							<textarea class="form-control" rows="4" cols="5"
								placeholder="Enter Product Description"
								name="productDescription"></textarea>
						</div>

						<!-- product price -->
						<div class="form-group">
							<div class="input-group mb-3">
								<div class="input-group-prepend">
									<span class="input-group-text">&#8377</span>
								</div>
								<input type="number" class="form-control" name="productPrice"
									placeholder="Enter Product Price" required />
							</div>
						</div>

						<div class="form-group">
							<div class="input-group mb-3">
								<div class="input-group-prepend">
									<span class="input-group-text">&#8377</span>
								</div>
								<input type="number" class="form-control" name="productDiscount"
									placeholder="Enter Product Discount" required />
							</div>
						</div>

						<!-- product quantity -->
						<div class="form-group">
							<input type="number" class="form-control" name="productQuantity"
								placeholder="Enter Product Quantity" required />
						</div>

						<!-- product category -->

						<%
							CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
						List<Category> list = categoryDao.getCategories();
						%>

						<div class="form-group">
							<select class="custom-select form-control" name="categoryId"
								required>

								<option selected disabled>Select Product Category</option>
								<%
									for (Category c : list) {
								%>
								<option value="<%=c.getCategoryId()%>"><%=c.getCategoryTitle()%></option>
								<%
									}
								%>
							</select>
						</div>

						<!-- product photo -->
						<div class="form-group">
							<label for="productImage">Select Product Image</label> <input
								class="form-control" type="file" id="productImage"
								name="productImage" placeholder="Upload Product Image"
								accept="image/*" required>
						</div>

						<!-- submit button -->
						<div class="container text-center">

							<button class="btn btn-outline-success">Add Product</button>

						</div>

					</form>

				</div>

			</div>
		</div>
	</div>

	<!-- End Add Product modal -->


</body>
</html>