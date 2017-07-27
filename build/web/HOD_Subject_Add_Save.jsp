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
                con.setAutoCommit(false);
                try {
                    String academic_year = (String)ses.getAttribute("academic_year");
                    String year = (String)ses.getAttribute("year");
                    String branch = (String)ses.getAttribute("branch");
                    String semester = (String)ses.getAttribute("semester");

                    String table = (String) ses.getAttribute("table");
                    int th_total = (Integer) ses.getAttribute("th_count");
                    int pr_total = (Integer) ses.getAttribute("pr_count");
                    for (int i = 0; i < th_total; i++) {
                        String subject_name_full = request.getParameter("Subject_Name_Full_" + i);
                        String subject_name = request.getParameter("Subject_Name_" + i);
                        String subject_code = request.getParameter("Subject_Code_" + i);
                        subject_code=subject_code.replaceAll("-", "_");
                        subject_name=subject_name.replaceAll("-", "_");
                        subject_name_full=subject_name_full.replaceAll("-", "_");
                        String subject_type = request.getParameter("Subject_Type_" + i);

                        PreparedStatement ps = con.prepareStatement("insert into " + table + " values(?, ?, ?)");
                        ps.setString(1, subject_name);
                        ps.setString(2, subject_code);
                        ps.setString(3, subject_type);
                        ps.executeUpdate();

                        PreparedStatement ps1 = con.prepareStatement("insert into Subject_Details values(?,?,?,?,?,?,?)");

                        ps1.setString(1, subject_name_full);
                        ps1.setString(2, subject_name);
                        ps1.setString(3, subject_type);
                        ps1.setString(4, academic_year);
                        ps1.setString(5, year);
                        ps1.setString(6, branch);
                        ps1.setString(7, semester);
                        ps1.executeUpdate();

                    }
                    for (int j = 0; j < pr_total; j++) {
                        String subject_name_full = request.getParameter("Subject_Name_pr_Full_" + j);
                        String subject_name = request.getParameter("Subject_Name_pr_" + j);
                        String subject_code = request.getParameter("Subject_Code_pr_" + j);
                        subject_code=subject_code.replaceAll(("-"), "_");
                        String subject_type = request.getParameter("Subject_Type_pr_" + j);

                        PreparedStatement ps = con.prepareStatement("insert into " + table + " values(?, ?, ?)");
                        ps.setString(1, subject_name);
                        ps.setString(2, subject_code);
                        ps.setString(3, subject_type);
                        ps.executeUpdate();
                        PreparedStatement ps1 = con.prepareStatement("insert into Subject_Details values(?,?,?,?,?,?,?)");

                        ps1.setString(1, subject_name_full);
                        ps1.setString(2, subject_name);
                        ps1.setString(3, subject_type);
                        ps1.setString(4, academic_year);
                        ps1.setString(5, year);
                        ps1.setString(6, branch);
                        ps1.setString(7, semester);
                        ps1.executeUpdate();

                    }

                    con.commit();
                    request.setAttribute("errorMessage","Subjects saved Successfully.....");
                    request.getRequestDispatcher("HOD_Profile.jsp").include(request, response);

                } catch (Exception e) {
                    con.rollback();
                    
                    request.setAttribute("errorMessage","<font color='red'><center><b><h2>There is a slight error in the database..try again later..</h2></b></center></font>"+e);
                    request.getRequestDispatcher("HOD_Subject_Add.jsp").include(request, response);
                } finally {
                    con.close();
                }
            }
        %>
    </body>
</html>
