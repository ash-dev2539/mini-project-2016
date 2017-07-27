<%@page contentType="text/html" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>


    <%@page import="java.sql.PreparedStatement"%>
    <%@page import="java.sql.Connection"%>
    <%@page import="java.sql.ResultSet"%>
    <%@page import="java.sql.SQLException"%>
    <%@page import="java.util.*" %>
    <%@page import="DBconnection.dbconnection" %>
    <%
        try {

            int emp_id = Integer.parseInt(request.getParameter("empid"));
            String p = request.getParameter("password");

            Connection con = dbconnection.createConnection();

            PreparedStatement stmt = con.prepareStatement("select * from faculty_personal_details where Emp_ID=? and Password=?");
            stmt.setInt(1, emp_id);
            stmt.setString(2, p);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {

                HttpSession ses = request.getSession();
                ses.setAttribute("empid", emp_id);

                request.getRequestDispatcher("Form6_CD.jsp").forward(request, response);

            } else {
                request.setAttribute("errorMessage", "<p style=\"color:red\"  >"
                        + "  "
                        + "Invalid Username or Password</p>");
                request.getRequestDispatcher("Login.jsp").include(request, response);

            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Exception occured at: </h2></b></center></font>" + e);

            request.getRequestDispatcher("Login.jsp").include(request, response);
        }
    %>
