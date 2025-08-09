package com.pahanaedu.billing;

import com.pahanaedu.billing.dao.ItemDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "DeleteItemServlet", urlPatterns = {"/deleteItem"})
public class DeleteItemServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        
        ItemDAO itemDAO = new ItemDAO();
        itemDAO.deleteItem(id);
        
        response.sendRedirect("listItems");
    }
}