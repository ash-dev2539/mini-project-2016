<%-- 
    Document   : Form25_GD_Final_S_Save
    Created on : Sep 17, 2016, 2:45:53 AM
    Author     : sandeep
--%>

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
            HttpSession ses = request.getSession(false);
            if (ses.getAttribute("empid") == null || ses.getAttribute("empid").equals("")) {
                request.setAttribute("errorMessage","<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
                request.getRequestDispatcher("Login.jsp").include(request, response);
            }
            Connection con = DBconnection.dbconnection.createConnection();
            

            String year = (String) ses.getAttribute("year");
            String branch = (String) ses.getAttribute("branch");
            String division = (String) ses.getAttribute("division");
            String academic_year = (String) ses.getAttribute("academic_year");
            String semester = (String) ses.getAttribute("semester");
            int student_count = (Integer) ses.getAttribute("student_count");
            String reason = (String) ses.getAttribute("valid_reason");
            System.out.print(year);
            
            System.out.print(branch);
            System.out.print(academic_year);
            System.out.print(semester);
            System.out.print(student_count);
            System.out.print(reason);
            
            
            String stu_muster = academic_year + "_" + year + "_" + branch + "_" + semester + "_" + division + "_Muster";

            for (int i = 0; i < student_count; i++) {
                int student_roll = Integer.parseInt(request.getParameter("student_roll_" + i));
                int student_att_add = Integer.parseInt(request.getParameter("student_att_add_" + i));
                PreparedStatement ps = con.prepareStatement("Update " + stu_muster + " set " + reason + "=" + student_att_add + " where Student_Roll_No=? ");
                ps.setInt(1, student_roll);
                ps.executeUpdate();
            }
           request.setAttribute("errorMessage","Extra leaves considered successfully....Please proceed further to generate final defaulter list...");
            request.getRequestDispatcher("Form25_GD_View_Ask_Range.jsp").forward(request, response);


        %>
    </body>
</html>
