package com.pahanaedu.billing;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Handles the user logout process.
 */
@WebServlet(name = "LogoutServlet", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {

    /**
     * Handles the HTTP <code>GET</code> method.
     * This is called when a user clicks the "Logout" link.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Fetch the current session (do not create a new one)
        HttpSession session = request.getSession(false); 
        
        // If there is a session, it should be invalidated.
        if (session != null) {
            session.invalidate();
        }
        
        // Redirecting the user to the login page.
        response.sendRedirect("login.jsp");
    }

    /**
     * Returns a short description of the servlet.
     */
    @Override
    public String getServletInfo() {
        return "Servlet to handle user logout";
    }
}