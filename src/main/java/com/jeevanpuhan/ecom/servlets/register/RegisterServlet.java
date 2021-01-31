package com.jeevanpuhan.ecom.servlets.register;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.jeevanpuhan.ecom.entities.User;
import com.jeevanpuhan.ecom.helper.FactoryProvider;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try (PrintWriter out = response.getWriter()) {

			try {

				String userName = request.getParameter("username");
				String userEmail = request.getParameter("email");
				String userPassword = request.getParameter("password");
				String userPhone = request.getParameter("phone");
				String userAddress = request.getParameter("address");

				// validations

				if (userName.isEmpty()) {
					out.println("Name is blank!");
					return;
				}

				// creating user object to store data

				User user = new User(userName, userEmail, userPassword, userPhone, "default.jpg", userAddress,
						"customer");

				try {
					Session hibernateSession = FactoryProvider.getFactory().openSession();
					Transaction tx = hibernateSession.beginTransaction();

					int userId = (int) hibernateSession.save(user);

					tx.commit();
					hibernateSession.close();

					HttpSession httpSession = request.getSession();
					httpSession.setAttribute("message", "Registration Successful!");

					response.sendRedirect("register.jsp");
					return;
					
				} catch (Exception e) {
					e.printStackTrace();
					HttpSession httpSession = request.getSession();
					httpSession.setAttribute("message", "User already registered with this email!");

					response.sendRedirect("register.jsp");
					return;
				}

			} catch (Exception e) {
				e.printStackTrace();
			}

		}
	}

}
