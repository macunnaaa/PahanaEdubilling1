
package com.pahanaedu.billing;

import com.pahanaedu.billing.dao.ItemDAO;
import com.pahanaedu.billing.model.Item;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "EditItemServlet", urlPatterns = {"/editItem"})
public class EditItemServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        
        ItemDAO itemDAO = new ItemDAO();
        Item existingItem = itemDAO.getItemById(id);
        
        request.setAttribute("itemToEdit", existingItem);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("editItem.jsp");
        dispatcher.forward(request, response);
    }
}