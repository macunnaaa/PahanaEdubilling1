package com.pahanaedu.billing;

import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import com.pahanaedu.billing.dao.BillDAO;
import com.pahanaedu.billing.dao.CustomerDAO;
import com.pahanaedu.billing.dao.ItemDAO;
import com.pahanaedu.billing.model.Bill;
import com.pahanaedu.billing.model.BillItem;
import com.pahanaedu.billing.model.Customer;
import com.pahanaedu.billing.model.Item;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "SaveBillServlet", urlPatterns = {"/saveBill"})
public class SaveBillServlet extends HttpServlet {

    private static final Font BOLD_FONT = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD);

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String customerIdStr = request.getParameter("customerId");
            String itemsData = request.getParameter("itemsData");

            if (itemsData == null || itemsData.isEmpty() || customerIdStr == null || customerIdStr.isEmpty()) {
                response.sendRedirect("prepareBill?error=Please select a customer and add at least one item.");
                return;
            }

            int customerId = Integer.parseInt(customerIdStr);
            ItemDAO itemDAO = new ItemDAO();
            List<BillItem> billItems = new ArrayList<>();
            BigDecimal grandTotal = BigDecimal.ZERO;

            String[] itemPairs = itemsData.split(",");
            for (String pair : itemPairs) {
                if (pair == null || pair.trim().isEmpty()) continue;
                String[] itemInfo = pair.split(":");
                if (itemInfo.length < 2) continue;

                try {
                    int itemId = Integer.parseInt(itemInfo[0]);
                    int quantity = Integer.parseInt(itemInfo[1]);
                    Item item = itemDAO.getItemById(itemId);

                    if (item != null) {
                        BillItem billItem = new BillItem();
                        billItem.setItem(item);
                        billItem.setQuantity(quantity);
                        billItem.setPricePerUnit(item.getPrice());
                        billItems.add(billItem);
                        grandTotal = grandTotal.add(item.getPrice().multiply(new BigDecimal(quantity)));
                    }
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                    continue;
                }
            }

            if (billItems.isEmpty()) {
                response.sendRedirect("prepareBill?error=No valid items were added to the bill.");
                return;
            }

            Bill billToSave = new Bill();
            billToSave.setCustomerId(customerId);
            billToSave.setBillDate(new Date());
            billToSave.setTotalAmount(grandTotal);
            billToSave.setBillItems(billItems);

            BillDAO billDAO = new BillDAO();
            int newBillId = billDAO.saveBill(billToSave);

            if (newBillId != -1) {
                // ===== PDF GENERATION =====
                
                CustomerDAO customerDAO = new CustomerDAO();
                Customer customer = customerDAO.getCustomerById(customerId);

                response.setContentType("application/pdf");
                response.setHeader("Content-Disposition", "attachment; filename=Bill_" + newBillId + ".pdf");

                Document document = new Document();
                PdfWriter.getInstance(document, response.getOutputStream());
                document.open();
                
                document.add(new Paragraph("Pahana Edu Billing System", BOLD_FONT));
                document.add(new Paragraph("------------------------------------"));
                document.add(new Paragraph("Bill ID: " + newBillId));
                if (customer != null) {
                    document.add(new Paragraph("Customer Name: " + customer.getName()));
                    document.add(new Paragraph("Account Number: " + customer.getAccountNumber()));
                }
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                document.add(new Paragraph("Date: " + formatter.format(new Date())));
                document.add(new Paragraph(" "));

                PdfPTable table = new PdfPTable(4);
                table.setWidthPercentage(100);
                
                table.addCell(new PdfPCell(new Phrase("Item Name", BOLD_FONT)));
                table.addCell(new PdfPCell(new Phrase("Quantity", BOLD_FONT)));
                table.addCell(new PdfPCell(new Phrase("Unit Price", BOLD_FONT)));
                table.addCell(new PdfPCell(new Phrase("Total", BOLD_FONT)));
                
                for (BillItem bi : billItems) {
                    table.addCell(bi.getItem().getItemName());
                    table.addCell(String.valueOf(bi.getQuantity()));
                    table.addCell(String.format("%.2f", bi.getPricePerUnit()));
                    BigDecimal itemTotal = bi.getPricePerUnit().multiply(new BigDecimal(bi.getQuantity()));
                    table.addCell(String.format("%.2f", itemTotal));
                }

                document.add(table);
                document.add(new Paragraph(" "));
                
                Paragraph totalPara = new Paragraph("Grand Total: Rs. " + String.format("%.2f", grandTotal), BOLD_FONT);
                totalPara.setAlignment(Element.ALIGN_RIGHT);
                document.add(totalPara);

                document.close();
                
            } else {
                throw new ServletException("Failed to save bill. BillDAO returned -1.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An unexpected error occurred: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}