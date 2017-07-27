<%-- 
    Document   : Form15_SFD_Save
    Created on : Sep 4, 2016, 1:19:48 AM
    Author     : sandeep
--%>

<%@page import="DBconnection.dbconnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            HttpSession ses = request.getSession(false);
            if (ses.getAttribute("empid") == null || ses.getAttribute("empid").equals("")) {
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
                request.getRequestDispatcher("Login.jsp").include(request, response);
            } else {

                Connection con = dbconnection.createConnection();
                con.setAutoCommit(false);
                try {
                    int faculty_id = Integer.parseInt(request.getParameter("faculty_id"));
                    String faculty_name = request.getParameter("faculty_name");
                    String branch = request.getParameter("branch");
                    String email = request.getParameter("email");

                    PreparedStatement ps = con.prepareStatement("insert into faculty_details values(?, ?, ?, ?)");
                    ps.setInt(1, faculty_id);
                    ps.setString(2, faculty_name);
                    ps.setString(3, branch);
                    ps.setString(4, email);

                    int check = ps.executeUpdate();
                    if (check == 0) {
                        request.setAttribute("errorMessage", "<font color='red'><h2>Sorry..The Record is not inserted into the database...Please try again...</h2>");
                        request.getRequestDispatcher("Faculty_Details.jsp").include(request, response);
                    } else {
                        con.commit();
                        request.setAttribute("errorMessage", "<font color='green'><h2>Faculty saved Successfully.....Proceed further to add more Records..</h2>");
                        request.getRequestDispatcher("Faculty_Details.jsp").include(request, response);
                    }

                } catch (Exception e) {
                    con.rollback();

                    request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Exception occured at: </h2></b></center></font>" + e);
                    request.getRequestDispatcher("Admin_Home.jsp").include(request, response);
                } finally {
                    con.close();
                }
            }
        %>
    </body>
</html>
