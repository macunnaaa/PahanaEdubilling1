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

@WebServlet(name = "UpdateCustomerServlet", urlPatterns = {"/updateCustomer"})
public class UpdateCustomerServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Obtaining all data from the modified form.
        int id = Integer.parseInt(request.getParameter("id"));
        String accountNumber = request.getParameter("accountNumber");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String telephoneNumber = request.getParameter("telephoneNumber");
        
        // Create a Customer object and set new details.

        Customer customer = new Customer();
        customer.setId(id);
        customer.setAccountNumber(accountNumber);
        customer.setName(name);
        customer.setAddress(address);
        customer.setTelephoneNumber(telephoneNumber);
        
        // Updating the database using CustomerDAO
        CustomerDAO customerDAO = new CustomerDAO();
        customerDAO.updateCustomer(customer);
        
        // sucess meage 
        
        HttpSession session = request.getSession();
        session.setAttribute("successMessage", "Customer '" + name + "' updated successfully!");
        
        // redirect list customer jsp
        response.sendRedirect("listCustomers");
    }
}