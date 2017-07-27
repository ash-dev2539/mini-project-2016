<%-- 
    Document   : Form28_AES
    Created on : Sep 11, 2016, 11:25:32 PM
    Author     : sandeep
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="cool.css" rel="stylesheet">       
        <style>
            *{margin:0;padding:0;}
            #login{
                width:600px;
                margin:0 auto;
                margin-top:8px;
                margin-bottom:2%;
                transition:opacity 1s;
                -webkit-transition:opacity 1s;
            }
            .label{
                width:300px;
                background:limegreen;
                display:block;
                margin:0 auto;
                margin-top:1%;
                padding:10px;
                text-align:center;
                text-decoration:none;
                color:#fff;
                cursor:default;
                font-size: 15px;
                transition:background .3s;
                -webkit-transition:background .3s;
            }
            .lab{
                width:550px;
                background:limegreen;
                display:block;
                margin:0 auto;
                margin-top:1%;
                padding:10px;
                text-align:center;
                text-decoration:none;
                color:#fff;
                cursor:default;
                font-size: 15px;
                transition:background .3s;
                -webkit-transition:background .3s;
            }
            form{
                background:#f0f0f0;
                padding:2% 4%;
            }

            input[type="text"],input[type="password"],input[type="tel"]{
                width:92%;

                background:#fff;
                margin-bottom:4%;
                border:1px solid #ccc;
                padding:2%;
                font-family:'Open Sans',sans-serif;
                font-size:95%;
                color:#555;
                height: 40px;
            }
            input[type="text"]:focus{
                border-width: 2pt;
                border-color: #3399cc;
            }

            input[type="password"]:focus{
                border-width: 2pt;
                border-color:#3399cc;
            }
            input[type="tel"]:focus{
                border-width: 2pt;
                border-color:#3399cc;

            }

            input[type="submit"]{
                width:100%;
                background:#3399cc;
                border:0;
                padding:2%;
                font-family:'Open Sans',sans-serif;
                font-size:20px;
                color:#fff;
                cursor:pointer;
                transition:background .3s;
                -webkit-transition:background .3s;
            }
            input[type="submit"]:hover{
                background:#2288bb;    
            }

        </style>
    </head>
    <body>
        <%
            HttpSession ses = request.getSession(false);
            if (ses.getAttribute("empid") == null || ses.getAttribute("empid").equals("")) {
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
                request.getRequestDispatcher("Login.jsp").include(request, response);
            } else {
                Connection con = DBconnection.dbconnection.createConnection();

                try {
                    int emp_id = (Integer) ses.getAttribute("empid");
                    String semester = (String) ses.getAttribute("semester");
                    String year = (String) ses.getAttribute("year");
                    String branch = (String) ses.getAttribute("branch");
                    String division = (String) ses.getAttribute("division");
                    String academic_year = (String) ses.getAttribute("academic_year");

                    String table_name = academic_year + "_" + year + "_" + branch + "_" + semester + "_" + division + "_Muster";
                    PreparedStatement ps1 = con.prepareStatement("select Student_Roll_No from " + table_name);

                    ResultSet rs1 = ps1.executeQuery();

                    if (!rs1.next()) {
                        request.setAttribute("errorMessage", "Faculty not Allocated yet.....Please allocate the Faculty first and try again....");
                        request.getRequestDispatcher("Form13_CT_Login.jsp").include(request, response);
                    } else {
                        PreparedStatement ps = con.prepareStatement("select Student_Roll_No from " + table_name);
                        ResultSet rs = ps.executeQuery();
                        if (!rs.next()) {
                            request.setAttribute("errorMessage", "Attendance not yet uploaded...Please upload the Attendance...");
                            request.getRequestDispatcher("Form16_UM.jsp").include(request, response);
                        } else {

        %>
        <span  class="button" id="toggle-login">Adding Students</span>


        <div id="login">
            <div id="triangle"></div>

            <h1>Enter the Number of Students required to Add for <font color="yellow">Branch=<%=branch%></font> and <font color="yellow">Year=<%=year%></font> and <font color="yellow">Semester=<%=semester%></font> and <font color="yellow">Division=<%=division%></font></h1>

            <form action="Form28_AES_Details.jsp" method="post">

                <input type="text" pattern="[0-9]+" name="student_count" required>

                <input type="submit" value="OK:)">

            </form>

        </div>
        <div align="center">
            <button onclick="window.location.href = 'Form13_CT_Login.jsp'">Back</button>
        </div>
        <%}
                    }
                } catch (Exception e) {
                    request.setAttribute("errorMessage", "Faculty not Allocated yet.....Please allocate the Faculty first and try again....");
                    request.getRequestDispatcher("Form13_CT_Login.jsp").include(request, response);
                } finally {
                    con.close();
                }

            }

        %>
    </body>
</html>
