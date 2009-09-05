package org.terracotta.tutorial;

import java.sql.Connection;
import java.sql.DriverManager;

public class JDBCTest {
    public static void main(String[] args) throws Exception {
	System.out.println("Loading HSQLDB JDBC driver...");
	try {
	    Class.forName("org.hsqldb.jdbc.JDBCDriver" );
	} catch (Exception e) {
	    System.err.println("ERROR: failed to load HSQLDB JDBC driver.");
	    e.printStackTrace();
	    return;
	}
	
	Connection c = DriverManager.getConnection("jdbc:hsqldb:hsql://localhost/tutorial", "SA", "");
	System.out.println("Connection established successfully.");
	
    }
}

