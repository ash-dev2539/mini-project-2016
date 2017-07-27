<%-- 
    Document   : ajax_faculty
    Created on : Sep 26, 2016, 10:41:12 AM
    Author     : Administrator
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
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
        String branch=request.getParameter("sendo");
        System.out.print("print "+branch);
        Connection con=DBconnection.dbconnection.createConnection();
        try{
        PreparedStatement ps=con.prepareStatement("select Faculty_Name,Faculty_ID from Faculty_Details where Branch=?");
        ps.setString(1, branch);
        ResultSet rs=ps.executeQuery();
        if(rs.next())
        {
            rs.beforeFirst();
            out.print("<option disabled selected></option>");
            while(rs.next())
            {
            
            out.print("<option>"+rs.getString(1)+" - "+rs.getInt(2)+"</option>");
            }
        }
        }
        catch(Exception e)
        {
        
        }
        %>
    </body>
</html>
