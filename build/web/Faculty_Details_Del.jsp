<%-- 
    Document   : Faculty_Details_Del
    Created on : 13 Oct, 2016, 11:23:27 PM
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
            int faculty_id = Integer.parseInt(request.getParameter("faculty_id"));
            Connection con = DBconnection.dbconnection.createConnection();
            PreparedStatement ps = con.prepareStatement("select Faculty_ID from faculty_details where Faculty_ID=?");
            ps.setInt(1, faculty_id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                
                
                
                PreparedStatement ps1 = con.prepareStatement("delete from faculty_details where Faculty_ID=?");
                ps1.setInt(1, faculty_id);
                ps1.executeUpdate();

                PreparedStatement ps2 = con.prepareStatement("select * from Faculty_Personal_Details where Emp_ID=?");
                ps2.setInt(1, faculty_id);
                ResultSet rs2 = ps2.executeQuery();
                if (rs2.next()) {
                    PreparedStatement ps3 = con.prepareStatement("delete from faculty_personal_details where Emp_ID=?");
                    ps3.setInt(1, faculty_id);
                    ps3.executeUpdate();
                }
                request.setAttribute("errorMessage","<font color='yellow'><h3>Faculty deleted Successfully.....</h3></font>");
                request.getRequestDispatcher("Admin_Facluty_Del.jsp").include(request, response);
            }
            else
            {
                request.setAttribute("errorMessage","<font color='yellow'>Given Faculty doesn't exist...</h3></font>");
                request.getRequestDispatcher("Admin_Facluty_Del.jsp").include(request, response);
            }
            con.close();
        %>
</html>
