<%-- 
    Document   : Form13_Add_Leave_Save
    Created on : Sep 17, 2016, 5:49:39 PM
    Author     : sandeep
--%>

<%@page import="java.sql.DatabaseMetaData"%>
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
            HttpSession ses = request.getSession(false);
            if (ses.getAttribute("empid") == null || ses.getAttribute("empid").equals("")) {
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
                request.getRequestDispatcher("Login.jsp").include(request, response);
            }
            String year = (String) ses.getAttribute("year");
            String branch = (String) ses.getAttribute("branch");
            String division = (String) ses.getAttribute("division");
            String academic_year = (String) ses.getAttribute("academic_year");
            String semester = (String) ses.getAttribute("semester");
            Connection con = DBconnection.dbconnection.createConnection();
            PreparedStatement ps = con.prepareStatement("select Leave_Type from Leave_Type_Identification where Academic_Year=? and Year=? and Branch=? ");
            ps.setString(1, academic_year);
            ps.setString(2, year);
            ps.setString(3, branch);
            ResultSet rs = ps.executeQuery();
            String stu_muster = academic_year + "_" + year + "_" + branch + "_" + semester + "_" + division + "_Muster";

            String leave = request.getParameter("leave");
            int check = 0;
            if (rs.next()) {
                rs.beforeFirst();
                while (rs.next()) {
                    String fetched_leave = rs.getString(1);
                    if (fetched_leave.equals(leave)) {
                        check = 1;

                    }

                }
            }
            if (check == 1) {
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Sorry...The Type already exists</h2></b></center></font>");
                request.getRequestDispatcher("Form13_Add_Leave.jsp").include(request, response);
            } else {
                PreparedStatement ps1 = con.prepareStatement("insert into Leave_Type_Identification values(?,?,?,?) ");
                ps1.setString(1, academic_year);
                ps1.setString(2, year);
                ps1.setString(3, branch);
                ps1.setString(4, leave);
                ps1.executeUpdate();

                DatabaseMetaData metadata = con.getMetaData();
                ResultSet rs4 = metadata.getTables(null, null, stu_muster, null);
                int found = 0;

                if (rs4.next()) {
                    PreparedStatement ps2 = con.prepareStatement("alter table " + stu_muster + " add column " + leave + " int(2) default 0 ");
                    ps2.executeUpdate();

                } else {
                    //give something here like teleportation :)
                }
                request.setAttribute("errorMessage", "<font color='green'><center><b><h2>The Leave Type has been inserted </h2></b></center></font>");
                request.getRequestDispatcher("Form13_CT_Login.jsp").include(request, response);

            }
        %>
    </body>
</html>
