<%-- 
    Document   : Form27_WM
    Created on : Sep 11, 2016, 4:31:36 PM
    Author     : sandeep
--%>

<%@page import="java.sql.DatabaseMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
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
                try {
                    String academic_year = (String) ses.getAttribute("academic_year");
                    String semester = (String) ses.getAttribute("semester");
                    String branch = (String) ses.getAttribute("branch");
                    String division = (String) ses.getAttribute("division");
                    String year = (String) ses.getAttribute("year");
                    String table_name =academic_year + "_" + year + "_" + branch + "_" + semester + "_" + division + "_Muster";
                    DatabaseMetaData metadata = con.getMetaData();
                    ResultSet rs4 = metadata.getTables(null, null, table_name, null);

                    if (!rs4.next()) {
                        request.setAttribute("errorMessage","Faculty not Allocated yet.....Please allocate the Faculty first and try again....");
                        request.getRequestDispatcher("Form13_CT_Login.jsp").include(request, response);
                    } else {
                        String table_name1 = academic_year + "_" + year + "_" + branch + "_" + semester + "_" + division + "_Muster";
                        PreparedStatement ps = con.prepareStatement("select Student_Roll_No from " + table_name1);

                        ResultSet rs = ps.executeQuery();
                        if (!rs.next()) {
                           request.setAttribute("errorMessage","Attendance not yet uploaded...Please upload the Attendance Record...");
                            request.getRequestDispatcher("Form16_UM.jsp").include(request, response);
                        } else {


        %>
       
        <div class="login" align="center" style="color: white"><h1>Withdrawing The Attendance Record</h1></div><br>
        <div class="neon" style="color: red" align="center"><h4>( Warning!! This will lead to Clearing of your Attendance Records!! )</h4></div><br>
        <form action="Form27_WM_Confirm.jsp" method="post">
            <div class="neon" align="center"><h2>Are You Sure About this ?</h2></div><br>
<div align="center">
                            <input style="background: lightcoral" type="submit" value="Yes">
                        </div>

        </form>
        <br><br>
        
                    <div align="center">
                        <button onclick="window.location.href = 'Form13_CT_Login.jsp'">Back</button>
                    </div>
               
        <%        }
                    }

                } catch (Exception e) {                    
                    request.setAttribute("errorMessage","Attendance not yet uploaded.....");
                    request.getRequestDispatcher("Form13_CT_Login.jsp").include(request, response);
                } finally {
                    con.close();
                }
            }
        %>
    </body>
</html>
