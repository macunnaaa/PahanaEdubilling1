package com.pahanaedu.billing;

import com.pahanaedu.billing.dao.CustomerDAO;
import com.pahanaedu.billing.model.Customer;
import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; 


@WebServlet(name = "ListCustomerServlet", urlPatterns = {"/listCustomers"})
public class ListCustomerServlet extends HttpServlet {

    /**
     * Handles the HTTP <code>GET</code> method.
     */
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Session  sucess message
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("successMessage") != null) {
            request.setAttribute("successMessage", session.getAttribute("successMessage"));
            session.removeAttribute("successMessage"); //dete one time
        }
        
        //  Getting all customers using the DAO 
        CustomerDAO customerDAO = new CustomerDAO();
        List<Customer> customerList = customerDAO.getAllCustomers();
        
        // Saving the received list in the request (sending to JSP page)
        request.setAttribute("allCustomers", customerList);
        
        // Sending the request to the customerList.jsp page
        RequestDispatcher dispatcher = request.getRequestDispatcher("customerList.jsp");
        dispatcher.forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     */
    @Override
    public String getServletInfo() {
        return "Servlet to fetch and display all customers";
    }

}