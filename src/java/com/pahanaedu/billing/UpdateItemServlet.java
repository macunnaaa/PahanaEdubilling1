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

@WebServlet(name = "UpdateItemServlet", urlPatterns = {"/updateItem"})
public class UpdateItemServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        String itemCode = request.getParameter("itemCode");
        String itemName = request.getParameter("itemName");
        String priceStr = request.getParameter("price");
        
        Item item = new Item();
        item.setId(id);
        item.setItemCode(itemCode);
        item.setItemName(itemName);
        if (priceStr != null && !priceStr.isEmpty()) {
            item.setPrice(new BigDecimal(priceStr));
        }
        
        ItemDAO itemDAO = new ItemDAO();
        itemDAO.updateItem(item);
        
        response.sendRedirect("listItems");
    }
}