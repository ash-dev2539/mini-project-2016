/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DBconnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


/**
 *
 * @author rohan
 */
public class dbconnection {
    
 public static Connection createConnection(){
 String url = "jdbc:mysql://localhost:3306/attend"; 
 String username = "root"; 
 String password = "ROOT"; 
 Connection con =null;

try
 {
 try
 {
 Class.forName("com.mysql.jdbc.Driver");
 }
 catch (ClassNotFoundException e)
 {
     System.out.println(e);
 }

 con = DriverManager.getConnection(url, username, password);

}
 catch (SQLException e)
 {
     System.out.println(e);
 }

return con;
 }
}
