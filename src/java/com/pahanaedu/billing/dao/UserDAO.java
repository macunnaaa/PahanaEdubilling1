package com.pahanaedu.billing.dao;

import com.pahanaedu.billing.model.User;
import com.pahanaedu.billing.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
    
    /**
     * If the username and password are correct, it will provide the User object. * If not, it will provide null.
     * @param username
     * @param password
     * @return User object or null
     */
    public User checkLogin(String username, String password) {
        User user = null;
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        
        try (Connection con = DBConnection.createConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, username);
            ps.setString(2, password);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return user;
    }
}