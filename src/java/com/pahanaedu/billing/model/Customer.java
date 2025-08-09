package com.pahanaedu.billing.model;


public class Customer {
    
    // Variables for customer details
    private int id;
    private String accountNumber;
    private String name;
    private String address;
    private String telephoneNumber;

    // Default constructor
    public Customer() {
    }

    //Parameterized constructor - Create a Customer object using all the details.
    public Customer(int id, String accountNumber, String name, String address, String telephoneNumber) {
        this.id = id;
        this.accountNumber = accountNumber;
        this.name = name;
        this.address = address;
        this.telephoneNumber = telephoneNumber;
    }

    //  Getters and Setters 
    // These methods help to get and modify the values of private variables.
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getTelephoneNumber() {
        return telephoneNumber;
    }

    public void setTelephoneNumber(String telephoneNumber) {
        this.telephoneNumber = telephoneNumber;
    }
}