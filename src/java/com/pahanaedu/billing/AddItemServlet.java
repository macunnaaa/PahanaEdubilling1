// AddItemServlet.java
package com.pahanaedu.billing;

import com.pahanaedu.billing.dao.ItemDAO;
import com.pahanaedu.billing.model.Item;
import java.io.IOException;
import java.math.BigDecimal;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AddItemServlet", urlPatterns = {"/addItem"})
public class AddItemServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        //  Get data from the form
        String itemCode = request.getParameter("itemCode");
        String itemName = request.getParameter("itemName");
        String priceStr = request.getParameter("price");
        
        //  Creating a new Item 
        Item newItem = new Item();
        newItem.setItemCode(itemCode);
        newItem.setItemName(itemName);
       
        // decimal convert  code 
        if (priceStr != null && !priceStr.isEmpty()) {
            newItem.setPrice(new BigDecimal(priceStr));
        }
        
        //  Storing the database using DAO
        ItemDAO itemDAO = new ItemDAO();
        itemDAO.addItem(newItem);
        
        // resend item lit
        response.sendRedirect("listItems");
    }
}