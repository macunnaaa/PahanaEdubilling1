package com.pahanaedu.billing;

import com.pahanaedu.billing.dao.CustomerDAO;
import com.pahanaedu.billing.model.Customer;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "EditCustomerServlet", urlPatterns = {"/editCustomer"})
public class EditCustomerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // get id in url
        int id = Integer.parseInt(request.getParameter("id"));
        
        // Fetching customer details  ID using DAO.
        CustomerDAO customerDAO = new CustomerDAO();
        Customer existingCustomer = customerDAO.getCustomerById(id);
        
        // saving the received customer object in java
        request.setAttribute("customerToEdit", existingCustomer);
        
        // Sending the request to the page editCustomer.jsp

        RequestDispatcher dispatcher = request.getRequestDispatcher("editCustomer.jsp");
        dispatcher.forward(request, response); 
    }
}