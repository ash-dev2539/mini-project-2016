<%-- 
    Document   : Form25_GD
    Created on : 15 Sep, 2016, 11:18:09 PM
    Author     : MYSELF
--%>

<%@page import="DBconnection.dbconnection"%>
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
        <style>
            *{margin:0;padding:0;}
            #login{
                width:530px;
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
                width:150px;
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
                request.setAttribute("errorMessage","<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
                request.getRequestDispatcher("Login.jsp").include(request, response);
            } else {
                int empid = (Integer) ses.getAttribute("empid");
                Connection con = dbconnection.createConnection();
                PreparedStatement ps6 = con.prepareStatement("select Designation from Faculty_Personal_Details where Emp_ID=? ");
                ps6.setInt(1, empid);
                ResultSet rs6 = ps6.executeQuery();
                rs6.next();
                String faculty_designation = rs6.getString(1);
                String deliver = "";
                if (faculty_designation.equals("Faculty")) {
                    deliver = "Form13_CT_Login.jsp";
                } else if (faculty_designation.equals("Principal") || faculty_designation.equals("Vice_Principal")) {

                    deliver = "Principal_Check_Status.jsp";
                } else if (faculty_designation.equals("HOD")) {

                    deliver = "HOD_Check_Status.jsp";
                }
                try {

                    String academic_year = (String) ses.getAttribute("academic_year");
                    String year = (String) ses.getAttribute("year");
                    String branch = (String) ses.getAttribute("branch");
                    String division = (String) ses.getAttribute("division");
                    String semester = (String) ses.getAttribute("semester");
                    String stu_table = academic_year + "_" + year + "_" + branch + "_" + semester + "_" + division + "_Muster";

                    PreparedStatement ps = con.prepareStatement("select Student_Name,Student_ID from " + stu_table);
                    ResultSet rs = ps.executeQuery();

                    if (!rs.next()) {
                        request.setAttribute("errorMessage","Sorry...no Attendance uploaded yet");
                        request.getRequestDispatcher(deliver).include(request, response);
                    } else {
                        rs.beforeFirst();

        %>
       
        <br><br><br>

        <div id="login">
            

            <h1>Enter the Student ID</h1>

            <form action="Studentwise_GD_Select.jsp" method="post">

                 <select name="student_id" style="width: 100%;font-size: 20px;height: 50px" required>
                            <option disabled selected></option>
                            <%                                while (rs.next()) {
                            %>

                            <option>
                                <%=rs.getString(1)%> - <%=rs.getString(2)%>
                            </option>
                            <%
                                }
                            %>
                        </select>

                <input type="submit" value="Next">

            </form>

        </div>
        
        

        <div align="center">
            <button onclick="window.location.href = '<%=deliver%>'">Home Page</button>
        </div>
        <%}
                } catch (Exception e) {

                    out.println(e);
                    request.setAttribute("errorMessage","<font color='red'><center><b><h2>Class Teacher has not uploaded the Roll Call yet....</h2></b></center></font>");
                    request.getRequestDispatcher(deliver).include(request, response);
                } finally {
                    con.close();
                }
            }
        %>
    </body>
</html>
