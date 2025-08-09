package com.pahanaedu.billing.dao;

import com.pahanaedu.billing.model.Item;
import com.pahanaedu.billing.util.DBConnection;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItemDAO {

    public void addItem(Item item) {
        String sql = "INSERT INTO items (item_code, item_name, price) VALUES (?, ?, ?)";
        try (Connection con = DBConnection.createConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, item.getItemCode());
            ps.setString(2, item.getItemName());
            ps.setBigDecimal(3, item.getPrice());
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public List<Item> getAllItems() {
        List<Item> list = new ArrayList<>();
        String sql = "SELECT * FROM items ORDER BY id";
        try (Connection con = DBConnection.createConnection(); Statement stmt = con.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Item i = new Item();
                i.setId(rs.getInt("id"));
                i.setItemCode(rs.getString("item_code"));
                i.setItemName(rs.getString("item_name"));
                i.setPrice(rs.getBigDecimal("price"));
                list.add(i);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
    
    public Item getItemById(int id) {
        // 
        // eorr visible code
        // 
        System.out.println("--- ItemDAO: Searching for item with ID: " + id);
        
        Item item = null;
        String sql = "SELECT * FROM items WHERE id = ?";
        try (Connection con = DBConnection.createConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    item = new Item();
                    item.setId(rs.getInt("id"));
                    item.setItemCode(rs.getString("item_code"));
                    item.setItemName(rs.getString("item_name"));
                    item.setPrice(rs.getBigDecimal("price"));
                    
                    // If the item is found, this message will appear.
                    
                    System.out.println(">>> ItemDAO: Found item: " + item.getItemName());
                } else {
                    
                    //no items this message will come.
                    
                    System.err.println("!!! ItemDAO: Item NOT FOUND for ID: " + id);
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return item;
    }

    public void updateItem(Item item) {
        String sql = "UPDATE items SET item_code = ?, item_name = ?, price = ? WHERE id = ?";
        try (Connection con = DBConnection.createConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, item.getItemCode());
            ps.setString(2, item.getItemName());
            ps.setBigDecimal(3, item.getPrice());
            ps.setInt(4, item.getId());
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public void deleteItem(int id) {
        String sql = "DELETE FROM items WHERE id = ?";
        try (Connection con = DBConnection.createConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }
}
