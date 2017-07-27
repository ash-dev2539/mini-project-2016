<%-- 
    Document   : crazy
    Created on : Nov 30, 2016, 10:35:37 AM
    Author     : Administrator
--%>

<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFCell"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFRow"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFSheet"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFWorkbook"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
         try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/usersdb", "root", "");
            Statement stmt = con.createStatement();
            ResultSet resultSet = stmt.executeQuery("select * from class_teacher_details");
            XSSFWorkbook workbook = new XSSFWorkbook();
            XSSFSheet spreadsheet = workbook.createSheet("employedb");
            XSSFRow row = spreadsheet.createRow(1);
            XSSFCell cell;
            cell = row.createCell(0);
            cell.setCellValue("Emp_ID");
            cell = row.createCell(1);
            cell.setCellValue("EMP NAME");
            cell = row.createCell(2);
            cell.setCellValue("DEG");
            cell = row.createCell(3);
            cell.setCellValue("Email");
            int i = 2;
            while (resultSet.next()) {
                row = spreadsheet.createRow(i);
                cell = row.createCell(0);
                cell.setCellValue(resultSet.getInt("user_id"));
                cell = row.createCell(1);
                cell.setCellValue(resultSet.getString("name"));
                cell = row.createCell(2);
                cell.setCellValue(resultSet.getString("designation"));
                cell = row.createCell(3);
                cell.setCellValue(resultSet.getString("email"));
                i++;
            }
            FileOutputStream out = new FileOutputStream(new File(
                    "exceldatabase.xlsx"));
            workbook.write(out);
            out.close();
            System.out.println("File Successfully created");
            con.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        
        %>
    </body>
</html>
