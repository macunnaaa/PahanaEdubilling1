package com.pahanaedu.billing;

import com.pahanaedu.billing.dao.UserDAO;
import com.pahanaedu.billing.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        UserDAO userDAO = new UserDAO();
        User user = userDAO.checkLogin(username, password);
        
        // Checking whether login was successful or failed.
        if (user != null) {
            // when login succes
            // creating new session
            HttpSession session = request.getSession();
            
              // Save user details in the session
            
            session.setAttribute("loggedInUser", user);
            
               // Sending to the customer list
            response.sendRedirect("listCustomers");
        } else {
            // Login failed!
            // Redirecting to the login page with an error message.
            response.sendRedirect("login.jsp?error=1");
        }
    }
}