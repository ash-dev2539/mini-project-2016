<%-- 
    Document   : Form15_SFD_Validate
    Created on : Sep 13, 2016, 10:08:29 PM
    Author     : sandeep
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
        <link href="cool.css" rel="stylesheet">
        
    </head>
    <body>
        <%
            HttpSession ses = request.getSession(false);
            if (ses.getAttribute("empid") == null || ses.getAttribute("empid").equals("")) {
                request.setAttribute("errorMessage","<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
                request.getRequestDispatcher("Login.jsp").include(request, response);

            } else {
                Connection con = DBconnection.dbconnection.createConnection();
                // con.setAutoCommit(false);
                try {
                    int empid = (Integer) ses.getAttribute("empid");
                    String semester = (String) ses.getAttribute("semester");
                    String academic_year = (String) ses.getAttribute("academic_year");
                    String year = (String) ses.getAttribute("year");
                    String branch = (String) ses.getAttribute("branch");
                    String division = (String) ses.getAttribute("division");

                    PreparedStatement ps1 = con.prepareStatement("select Faculty_Name,Subject_Name from Faculty_Allocation_Subjectwise_Th where Academic_Year=? and Year=? and Branch=? and Division=? and Semester=? ");
                    ps1.setString(1, academic_year);
                    ps1.setString(2, year);
                    ps1.setString(3, branch);
                    ps1.setString(4, division);
                    ps1.setString(5, semester);
                    ResultSet rs1 = ps1.executeQuery();
                    PreparedStatement ps2 = con.prepareStatement("select Faculty_Name,Prac_Subject_Name from Faculty_Allocation_Subjectwise_Pr where Academic_Year=? and Year=? and Branch=? and Division=? and Semester=? ");
                    ps2.setString(1, academic_year);
                    ps2.setString(2, year);
                    ps2.setString(3, branch);
                    ps2.setString(4, division);
                    ps2.setString(5, semester);
                    ResultSet rs2 = ps2.executeQuery();
                    if (rs1.next() && rs2.next()) {
                        rs1.beforeFirst();
                        rs2.beforeFirst();
        %>


        <table style="width:80%">

            <thead>
            <th class="hi" style="width: 400px"><div><b>  The Faculties below</b></div> </th><th class="hi" style="width: 400px"> <div><b>has already been allocated for Subjects below</b></div>
            </th>
        </thead>
        <%
            while (rs1.next()) {
        %>
        <tr>

            <td>

                <input type="text" value="<%=rs1.getString(1)%>" readonly>
            </td>
            <td>
                <input type="text" value="<%=rs1.getString(2)%>" readonly>
            </td>
        </tr>
        <%
            }
            while (rs2.next()) {
        %>
        <tr>

            <td>

                <input type="text" value="<%=rs2.getString(1)%>" readonly>
            </td>
            <td>
                <input type="text" value="<%=rs2.getString(2)%>" readonly>
            </td>
        </tr>
        <%
            }
        %>
    </table>
    <form action="Form15_SFD_Warning.jsp" method="post">
        <table align="center">
            <tr>
                <td>
                    <div class="neon" style="color: red;font-size: 25px"><b> Do you wish to allocate all faculties again....?</b></div>
                </td>
            </tr>
            <tr>
                <td>
                    <input type="submit" style="background: lightcoral" value="Yes">
                </td>
            </tr>
        </table>
    </form>
    <table align="center">
        <tr>
            <td>
                <button onclick="window.location.href = 'Form13_CT_Login.jsp'">No</button>            

            </td>

        </tr>
    </table>
    <%
                } else {
                    request.getRequestDispatcher("Form14_BD.jsp").forward(request, response);
                }
                //con.commit();
            } catch (Exception e) {
                request.setAttribute("errorMessage","<font color='red'><center><b><h2>There is nothing to be fetched from database for you...Please Contact the Administrator...</h2></b></center></font>");
                request.getRequestDispatcher("Form15_SFD.jsp").include(request, response);
            } finally {
                con.close();
            }
        }
    %>
</body>
</html>
