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
               request.setAttribute("errorMessage","<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
                request.getRequestDispatcher("Login.jsp").include(request, response);
            } else {

                Connection con = dbconnection.createConnection();
                try {
                    String academic_year = (String) ses.getAttribute("academic_year");
                    String year = (String) ses.getAttribute("year");
                    String branch = (String) ses.getAttribute("branch");
                    String semester = (String) ses.getAttribute("semester");
                    String ex_table = academic_year + "_" + year + "_" + branch + "_sem" + semester + "_Th_Pr_Extra";
                    ses.setAttribute("ex_table", ex_table);
                    PreparedStatement ps = con.prepareStatement("create table if not exists " + ex_table + "(Subject_Name varchar(30) not null, Subject_Code varchar(30), Subject_Type varchar(15) not null)");
                    ps.executeUpdate();                    
                   
                    request.getRequestDispatcher("HOD_Extra_SA.jsp").forward(request, response);

                } catch (Exception e) {
                   
                   request.setAttribute("errorMessage","<font color='red'><center><b><h2>There is a slight error in the database..try again later..</h2></b></center></font>"+e);
                    request.getRequestDispatcher("HOD_Profile.jsp").include(request, response);
                } finally {
                    con.close();
                }
            }
        %>
    </body>
</html>
