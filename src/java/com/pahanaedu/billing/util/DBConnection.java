package com.pahanaedu.billing.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/*** This class creates a new database connection every time.* It includes detailed messages for error detection.*/
public class DBConnection {

    // Sql conection details
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=PahanaDB;trustServerCertificate=true";
    private static final String USERNAME = "sa"; // உங்கள் SQL Server username
    private static final String PASSWORD = "Rasan"; // உங்கள் SQL Server password
    private static final String DRIVER_CLASS = "com.microsoft.sqlserver.jdbc.SQLServerDriver";

    /**
     * This method will create a new database connection.
     * Returns a new Connection object.
     */
    public static Connection createConnection() {
        Connection connection = null;
        try {
            // Registering the JDBC driver
            Class.forName(DRIVER_CLASS);
            
            //  Creating a new connection 
            System.out.println("--- DBConnection: Attempting to connect to database...");
            System.out.println("--- URL: " + URL);
            System.out.println("--- User: " + USERNAME);
            
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            
            System.out.println(">>> DBConnection: New Database Connection Successful!");

        } catch (ClassNotFoundException e) {
            System.err.println("!!! DBConnection FATAL ERROR: SQL Server JDBC Driver not found!");
            System.err.println("!!! தயவுசெய்து 'mssql-jdbc-....jar' ஃபைலை உங்கள் புரோஜெக்ட்டின் 'lib' ஃபோல்டரில் சேர்த்துள்ளீர்களா எனச் சரிபார்க்கவும்.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("!!! DBConnection FATAL ERROR: Failed to connect to the database!");
            System.err.println("!!! பிழைக்கான காரணங்கள்:");
            System.err.println("1. உங்கள் SQL Server ஓடிக்கொண்டிருக்கிறதா (running) எனச் சரிபார்க்கவும்.");
            System.err.println("2. URL, Username (" + USERNAME + "), Password சரியானதா எனச் சரிபார்க்கவும்.");
            System.err.println("3. உங்கள் Firewall, போர்ட் 1433-ஐ தடுக்கிறதா எனச் சரிபார்க்கவும்.");
            e.printStackTrace();
        }
        return connection;
    }
}