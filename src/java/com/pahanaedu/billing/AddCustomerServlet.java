package com.pahanaedu.billing;

import com.pahanaedu.billing.dao.CustomerDAO;
import com.pahanaedu.billing.model.Customer;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; 

@WebServlet(name = "AddCustomerServlet", urlPatterns = {"/addCustomer"})
public class AddCustomerServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accountNumber = request.getParameter("accountNumber");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String telephoneNumber = request.getParameter("telephoneNumber");
        
        Customer newCustomer = new Customer();
        newCustomer.setAccountNumber(accountNumber);
        newCustomer.setName(name);
        newCustomer.setAddress(address);
        newCustomer.setTelephoneNumber(telephoneNumber);
        
        CustomerDAO customerDAO = new CustomerDAO();
        customerDAO.addCustomer(newCustomer);
        
        
        // suces notification code but not complte
        HttpSession session = request.getSession();
        session.setAttribute("successMessage", "New customer '" + name + "' added successfully!");
        session.setAttribute("showBellNotification", "true"); // Bell flag
        
       
        response.sendRedirect("listCustomers");
    }
}