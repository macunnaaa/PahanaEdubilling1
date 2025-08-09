package com.pahanaedu.billing;

import com.pahanaedu.billing.dao.ItemDAO;
import com.pahanaedu.billing.model.Item;
import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ListItemServlet", urlPatterns = {"/listItems"})
public class ListItemServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        ItemDAO itemDAO = new ItemDAO();
        List<Item> itemList = itemDAO.getAllItems();
        
        request.setAttribute("allItems", itemList);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("itemList.jsp");
        dispatcher.forward(request, response);
    }
}