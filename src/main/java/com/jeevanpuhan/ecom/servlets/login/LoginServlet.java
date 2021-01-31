package com.jeevanpuhan.ecom.servlets.login;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.jeevanpuhan.ecom.dao.UserDao;
import com.jeevanpuhan.ecom.entities.User;
import com.jeevanpuhan.ecom.helper.FactoryProvider;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try (PrintWriter out = response.getWriter()) {

			String email = request.getParameter("email");
			String password = request.getParameter("password");

			// validations

			// authenticating user
			UserDao userDao = new UserDao(FactoryProvider.getFactory());
			User user = userDao.getUserByEmailAndPassword(email, password);

			HttpSession httpSession = request.getSession();
			if (user == null) {
				httpSession.setAttribute("message", "Invalid Credentials!");
				response.sendRedirect("login.jsp");
			} else {
				out.println(String.format("<h1>Welcome, %s</h1>", user.getUserName()));

				// login
				httpSession.setAttribute("currentUser", user);

				if (user.getUserType().equals("admin")) {
					// if admin -> admin.jsp
					response.sendRedirect("admin.jsp");
				} else if (user.getUserType().equals("customer")) {
					// if customer -> customer.jsp
					response.sendRedirect("customer.jsp");
				} else {
					out.println("Unidentifiable user type!");
				}

			}
		}

	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession httpSession = request.getSession();
		User user = (User) httpSession.getAttribute("currentUser");
		
//		System.out.println(user);
		
		if (user.getUserType().equals("admin")) {
			response.sendRedirect("admin.jsp");
		}

		else if (user.getUserType().equals("customer")) {
			response.sendRedirect("customer.jsp");
		}
	}

}
