<%-- 
    Document   : ajax_validate
    Created on : Sep 23, 2016, 10:56:36 AM
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
            
            String sendo = request.getParameter("sendo");
            if (sendo == null || sendo.trim().equals("")) {
                out.print("<font color='yellow'><h2>Enter ID Please</h2>");
            } else {
                try
                {
                        Connection con = DBconnection.dbconnection.createConnection();
                    int faculty_id = Integer.parseInt(sendo);
                    PreparedStatement ps = con.prepareStatement("select Faculty_ID,Faculty_Name from Faculty_Details where Faculty_ID=? ");
                    ps.setInt(1, faculty_id);
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) {
                        String name=rs.getString(2);
                        out.print("<font color='yellow'><h2>Faculty_ID Already Exists with Name ' "+name+"'</h2>");
                    } else {
                        out.print("<font color='yellow'><h2>Verified</h2>");
                        
                    }
                } catch (Exception e) {
                   out.print("<font color='yellow'><h2>Invalid Details</h2>");   
                }
                            }
        %>
    </body>
</html>
