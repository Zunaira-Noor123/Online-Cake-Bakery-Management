package com.sweettreats.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class utils {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/sweettreatsdb";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "zunaira_noor786";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL Driver not found!");
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
    }
}