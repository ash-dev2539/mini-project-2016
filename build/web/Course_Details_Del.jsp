<%-- 
    Document   : Course_Details_Del
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
            String course_name = request.getParameter("course_name");
            String branch = request.getParameter("branch");
            String academic_year = request.getParameter("academic_year");
            String duration = request.getParameter("duration");
            Connection con = DBconnection.dbconnection.createConnection();
            PreparedStatement ps = con.prepareStatement("select *  from course_details where Course_Name=? and Branch=? and Academic_Year=? and Duration=?");
            ps.setString(1, course_name);
            ps.setString(2, branch);
            ps.setString(3, academic_year);
            ps.setString(4, duration);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                PreparedStatement ps1 = con.prepareStatement("delete from course_details where Course_Name=? and Branch=? and Academic_Year=? and Duration=?");
                ps1.setString(1, course_name);
                ps1.setString(2, branch);
                ps1.setString(3, academic_year);
                ps1.setString(4, duration);
                int check = ps1.executeUpdate();
                if (check != 0) {
                    request.setAttribute("errorMessage", "<font color='green'>Course Details deleted Successfully.....");
                    request.getRequestDispatcher("Admin_CD_Del.jsp").include(request, response);
                }
            } else {
                request.setAttribute("errorMessage", "<font color='red'>Given Course Combination doesn't exist...");
                request.getRequestDispatcher("Admin_CD_Del.jsp").include(request, response);
            }
            con.close();
        %>
</html>
