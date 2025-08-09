package com.pahanaedu.billing.dao;

import com.pahanaedu.billing.model.Bill;
import com.pahanaedu.billing.model.BillItem;
import com.pahanaedu.billing.model.Customer;
import com.pahanaedu.billing.model.Item;
import com.pahanaedu.billing.util.DBConnection;
import java.sql.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class BillDAO {

    
    
    public int saveBill(Bill bill) throws SQLException {
        String sqlBill = "INSERT INTO bills (customer_id, bill_date, total_amount) VALUES (?, ?, ?)";
        String sqlBillItem = "INSERT INTO bill_items (bill_id, item_id, quantity, price_per_unit) VALUES (?, ?, ?, ?)";
        int billId = -1;
        Connection con = null;

        try {
            con = DBConnection.createConnection();
            
             // Start TRansation
            con.setAutoCommit(false);

            // Saving a new bill in the 'bills' table.
            try (PreparedStatement psBill = con.prepareStatement(sqlBill, Statement.RETURN_GENERATED_KEYS)) {
                psBill.setInt(1, bill.getCustomerId());
                psBill.setDate(2, new java.sql.Date(bill.getBillDate().getTime()));
                psBill.setBigDecimal(3, bill.getTotalAmount());
                psBill.executeUpdate();

                try (ResultSet generatedKeys = psBill.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        billId = generatedKeys.getInt(1);
                    } else {
                        throw new SQLException("Creating bill failed, no ID obtained.");
                    }
                }
            }

            //  Saving items in the 'bill_items' table
            try (PreparedStatement psBillItem = con.prepareStatement(sqlBillItem)) {
                for (BillItem item : bill.getBillItems()) {
                    psBillItem.setInt(1, billId);
                    psBillItem.setInt(2, item.getItem().getId());
                    psBillItem.setInt(3, item.getQuantity());
                    psBillItem.setBigDecimal(4, item.getPricePerUnit());
                    psBillItem.addBatch();
                }
                psBillItem.executeBatch();
            }
            
            
            con.commit();

        } catch (SQLException e) {
            // If any error occurs, cancel the changes.
            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            throw e; //Sending the error out
        } finally {
            // Closing the connection after completing the transaction.
            if (con != null) {
                try {
                    con.setAutoCommit(true);
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return billId;
    }
    
    // getBillById 
    public Bill getBillById(int billId) {
        Bill bill = null;
        String sqlBill = "SELECT b.*, c.name as customer_name, c.account_number FROM bills b JOIN customers c ON b.customer_id = c.id WHERE b.id = ?";
        String sqlBillItems = "SELECT bi.*, i.item_name, i.item_code FROM bill_items bi JOIN items i ON bi.item_id = i.id WHERE bi.bill_id = ?";
        
        try (Connection con = DBConnection.createConnection();
             PreparedStatement psBill = con.prepareStatement(sqlBill)) {
            
            psBill.setInt(1, billId);
            try (ResultSet rsBill = psBill.executeQuery()) {
                if (rsBill.next()) {
                    bill = new Bill();
                    bill.setId(rsBill.getInt("id"));
                    bill.setCustomerId(rsBill.getInt("customer_id"));
                    bill.setBillDate(rsBill.getDate("bill_date"));
                    bill.setTotalAmount(rsBill.getBigDecimal("total_amount"));
                    
                    Customer customer = new Customer();
                    customer.setId(rsBill.getInt("customer_id"));
                    customer.setName(rsBill.getString("customer_name"));
                    customer.setAccountNumber(rsBill.getString("account_number"));
                    bill.setCustomer(customer);
                    
                    List<BillItem> billItems = new ArrayList<>();
                    try (PreparedStatement psBillItems = con.prepareStatement(sqlBillItems)) {
                        psBillItems.setInt(1, billId);
                        try (ResultSet rsItems = psBillItems.executeQuery()) {
                            while (rsItems.next()) {
                                BillItem billItem = new BillItem();
                                Item item = new Item();
                                item.setId(rsItems.getInt("item_id"));
                                item.setItemName(rsItems.getString("item_name"));
                                item.setItemCode(rsItems.getString("item_code"));
                                
                                billItem.setItem(item);
                                billItem.setQuantity(rsItems.getInt("quantity"));
                                billItem.setPricePerUnit(rsItems.getBigDecimal("price_per_unit"));
                                billItems.add(billItem);
                            }
                        }
                    }
                    bill.setBillItems(billItems);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bill;
    }
}