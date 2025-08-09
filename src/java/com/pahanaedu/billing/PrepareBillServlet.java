package com.pahanaedu.billing;

import com.pahanaedu.billing.dao.CustomerDAO;
import com.pahanaedu.billing.dao.ItemDAO;
import com.pahanaedu.billing.model.Customer;
import com.pahanaedu.billing.model.Item;
import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "PrepareBillServlet", urlPatterns = {"/prepareBill"})
public class PrepareBillServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // all customers
        CustomerDAO customerDAO = new CustomerDAO();
        List<Customer> customerList = customerDAO.getAllCustomers();
        
        // Obtaining all things
        ItemDAO itemDAO = new ItemDAO();
        List<Item> itemList = itemDAO.getAllItems();
        
        // Save both lists in the request.
        request.setAttribute("allCustomers", customerList);
        request.setAttribute("allItems", itemList);
        
        // Sending the request to the page createBill.jsp
        RequestDispatcher dispatcher = request.getRequestDispatcher("createBill.jsp");
        dispatcher.forward(request, response);
    }
}