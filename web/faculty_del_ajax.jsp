<%-- 
    Document   : faculty_del_ajax
    Created on : 13 Oct, 2016, 11:18:01 PM
    Author     : Sai Kameswari
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
                out.print("<font color='yellow'><h3>Enter ID Please</h3>");
            } else {
                try
                {

                int faculty_id = Integer.parseInt(sendo);
                Connection con = DBconnection.dbconnection.createConnection();
                PreparedStatement ps = con.prepareStatement("select Faculty_Name from faculty_details where Faculty_ID=?");
                ps.setInt(1, faculty_id);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    out.println("<h3>ID exists with name: "+rs.getString(1)+"</h3>");
                } else {
                    out.println("<font color='yellow'><h3>Invalid ID</h3>");
                }                
                }catch(Exception e)
                {
                    out.print("<font color='yellow'>Invalid Details");
                }
            }
        %>
    </body>
</html>
