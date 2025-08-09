package com.pahanaedu.billing;

import com.pahanaedu.billing.dao.CustomerDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "DeleteCustomerServlet", urlPatterns = {"/deleteCustomer"})
public class DeleteCustomerServlet extends HttpServlet {

    /**
     
     * This is called when a user clicks the "Delete" link.
     
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        //get id
        int id = Integer.parseInt(request.getParameter("id"));
        
        // id using DAO
        CustomerDAO customerDAO = new CustomerDAO();
        customerDAO.deleteCustomer(id);
        
        //Redirect cutomer list
        response.sendRedirect("listCustomers");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet to delete a customer";
    }

}