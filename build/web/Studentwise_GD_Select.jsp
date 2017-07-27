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
                try {

                    String academic_year = (String) ses.getAttribute("academic_year");
                    String year = (String) ses.getAttribute("year");
                    String branch = (String) ses.getAttribute("branch");
                    String division = (String) ses.getAttribute("division");
                    String semester = (String) ses.getAttribute("semester");
                    String pa=request.getParameter("student_id");
                    String[] para=pa.split(" - ");
                    String student_id=para[1];
                    ses.setAttribute("student_id", student_id);
                    ses.setAttribute("student_name", para[0]);
                    String stu_table = academic_year + "_" + year + "_" + branch + "_" + semester + "_" + division + "_Muster";

                   
                   
        %>
        
        <br><br><br><br>

        <div id="login">
           

            <h1> Select type of Attendance for <font color="yellow"><%=para[0]%></font></h1>

            <form action="Studentwise_GD_TV.jsp" method="post">

            <select name="type" style="width: 100%;font-size: 20px;height: 50px" required>
                            <option disabled selected>
                            </option>
                            <option>
                                Monthly
                            </option>
                            <option>
                                Final
                            </option>
                        </select>

                <input type="submit" value="Next">

            </form>

        </div>
        
                    <div align="center">
                        <button style="color: white" onclick="window.location.href = 'Studentwise_GD.jsp'">Back</button>
                    </div>

        <%
                    
                } catch (Exception e) {
                    PreparedStatement ps6 = con.prepareStatement("select Designation from Faculty_Personal_Details where Emp_ID=? ");
                    ps6.setInt(1, empid);
                    ResultSet rs6 = ps6.executeQuery();
                    rs6.next();
                    String faculty_designation = rs6.getString(1);
                    String deliver = "";
                    if (faculty_designation.equals("Faculty")) {
                        deliver = "Form13_CT_Login.jsp";
                    } else if (faculty_designation.equals("Principal") || faculty_designation.equals("Vice_Principal")) {
                        deliver = "Principal_Check_Status";
                    } else if (faculty_designation.equals("HOD")) {

                        deliver = "HOD_Check_Status.jsp";
                    }
                   request.setAttribute("errorMessage","Faculty not yet Allocated to the Subjects...Please try again after allocating...");
                    request.getRequestDispatcher(deliver).include(request, response);
                }
            }

        %>
    </body>
</html>
