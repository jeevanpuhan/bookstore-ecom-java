package com.jeevanpuhan.ecom.servlets;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Paths;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.jeevanpuhan.ecom.dao.CategoryDao;
import com.jeevanpuhan.ecom.dao.ProductDao;
import com.jeevanpuhan.ecom.entities.Category;
import com.jeevanpuhan.ecom.entities.Product;
import com.jeevanpuhan.ecom.helper.FactoryProvider;

@MultipartConfig
@WebServlet("/ProductOperationServlet")
public class ProductOperationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try (PrintWriter out = response.getWriter()) {

			String operation = request.getParameter("operation");

			if (operation.trim().equals("addCategory")) {

				// add Category
				// fetching category data
				String title = request.getParameter("categoryTitle");
				String description = request.getParameter("categoryDescription");

				Category category = new Category();
				category.setCategoryTitle(title);
				category.setCategoryDescription(description);

				// save category to database
				CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());

				int categoryId = categoryDao.saveCategory(category);
//				 out.println("Category Saved with id:"+categoryId);
				HttpSession httpSession = request.getSession();
				httpSession.setAttribute("message", "Category added successfully: " + categoryId);
				response.sendRedirect("admin.jsp");
				return;

			} else if (operation.trim().equals("addProduct")) {
				// add Product

				String productName = request.getParameter("productTitle");
				String productDesc = request.getParameter("productDescription");
				int productPrice = Integer.parseInt(request.getParameter("productPrice"));
				int productDiscount = Integer.parseInt(request.getParameter("productDiscount"));
				int productQuantity = Integer.parseInt(request.getParameter("productQuantity"));
				int categoryId = Integer.parseInt(request.getParameter("categoryId"));

				Part part = request.getPart("productImage");

				Product product = new Product();

				product.setpName(productName);
				product.setpDesc(productDesc);
				product.setpPrice(productPrice);
				product.setpDiscount(productDiscount);
				product.setpQuantity(productQuantity);
				product.setpPhoto(getSubmittedFileName(part));

				// get category by Id
				CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
				Category category = categoryDao.getCategoryById(categoryId);

				product.setCategory(category);

				// save product
				ProductDao productDao = new ProductDao(FactoryProvider.getFactory());
				int productId = productDao.saveProduct(product);

				// pic upload

				// find out the path to upload photo
				String path = request.getRealPath("img") + File.separator + "products" + File.separator
						+ getSubmittedFileName(part);
				System.out.println(path);

				// pic upload code

				try {
					FileOutputStream fout = new FileOutputStream(path);

					InputStream in = part.getInputStream();

					// reading data

					byte[] data = new byte[in.available()];
					in.read(data);

					// writing the data
					fout.write(data);
					fout.close();

					in.close();

				} catch (FileNotFoundException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}

				out.println("Product Saved Successfully, with ID: " + productId);
				HttpSession httpSession = request.getSession();
				httpSession.setAttribute("message", "Product added successfully: " + productId);
				response.sendRedirect("admin.jsp");
				return;

			}

		}
	}

	// get the uploaded file name
	private static String getSubmittedFileName(Part part) {
		for (String cd : part.getHeader("content-disposition").split(";")) {
			if (cd.trim().startsWith("filename")) {
				String fileName = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
				return fileName.substring(fileName.lastIndexOf('/') + 1).substring(fileName.lastIndexOf('\\') + 1); // MSIE
																													// fix.
			}
		}
		return null;
	}

}
