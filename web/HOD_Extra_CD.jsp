

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.*" %>
<%@page import="DBconnection.dbconnection" %>

<%@page contentType="text/html" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html>

<html>
    <head>
        <script type="text/javascript" src="js/jquery-1.8.js"></script>
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
        <script type="text/javascript">
            $(function () {
                setTimeout(function () {
                    $("#testdiv").fadeOut(1000);
                }, 7599);
                $('#btnclick').click(function () {
                    $('#testdiv').show();
                    setTimeout(function () {
                        $("#testdiv").fadeOut(1000);
                    }, 7599);
                });
            });
        </script>
        <%

            HttpSession ses = request.getSession(false);
            if (ses.getAttribute("empid") == null || ses.getAttribute("empid").equals("")) {
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
                request.getRequestDispatcher("Login.jsp").include(request, response);
            } else {

                int empid = (Integer) ses.getAttribute("empid");

                String academic_year = (String) ses.getAttribute("academic_year");
                String semester = (String) ses.getAttribute("semester");
                String course = (String) ses.getAttribute("course");

                Connection con = dbconnection.createConnection();
                try {
                    PreparedStatement ps = con.prepareStatement("select  Department from faculty_personal_details where Emp_ID=?");
                    ps.setInt(1, empid);
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) {
                        String branch = rs.getString(1);
                        rs.beforeFirst();

                        PreparedStatement ps1 = con.prepareStatement("select Faculty_Name from Faculty_Details where Faculty_ID=? ");
                        ps1.setInt(1, empid);
                        ResultSet rs1 = ps1.executeQuery();
                        rs1.next();

        %>       
                <div align="right" style="position:absolute;top:20px;right:10px;font-size: 30px;color: white"><marquee>Welcome Prof.<%=rs1.getString(1)%></marquee> </div>

                <div id="login">
           

            <h1>Course Details Allocation</h1>

             <form action="HOD_Extra_CD_Save.jsp" method="post">
<table>

                <tr>
                    <td class="lab">Academic Year</td>
                    <td>
                        <input style="width: 285px;font-size: 20px;height: 30px" type="text" class="follow" name="academic_year" value="<%=academic_year%>" readonly/>
                    </td>
                </tr>


                <%
                    if (!branch.equals("FE")) {   %>
                <tr><td class="lab">Year(SE, TE, BE)</td><td> <select style="width: 300px;font-size: 20px" style="width: 300px;" name="year" required>
                            <option disabled selected></option>                            
                            <option>2</option>    
                            <option>3</option>   
                            <option>4</option>   
                        </select> </td></tr>    
                        <% } else { %>
                <tr><td class="neon">Year(SE, TE, BE)</td><td> 
                        <input style="width: 285px;font-size: 20px;height: 30px" type="text" class="follow" name="year" value="1" readonly/>
                        <%  }
                        %>
                    </td>
                </tr>


                <tr>
                    <td class="lab">Branch</td>
                    <td>
                        <input style="width: 285px;font-size: 20px;height: 30px" type="text" class="follow" name="branch" value="<%=branch%>" readonly/>
                    </td>
                </tr>           


                <tr><td class="lab">Semester</td><td> <select style="width: 300px;font-size: 20px" name="semester" required>
                            <option disabled selected></option>
                            <option>I</option>
                            <option>II</option>
                        </select> </td></tr>    

                <tr>
                    <td class="lab">Extra Theory Count</td>
                    <td>
                        <input pattern="[0-9]+" style="width: 285px;font-size: 20px;height: 30px" type="text" class="follow" name="ex_th_count"  required/>
                    </td>
                </tr>

                <tr>
                    <td class="lab">Extra Practical Count</td>
                    <td>
                        <input pattern="[0-9]+" style="width: 285px;font-size: 20px;height: 30px" type="text" class="follow" name="ex_pr_count" required/>
                    </td>
                </tr>
              

            </table>

               <input type="submit" value="Proceed" name="Proceed"/>

            </form>

        </div>
                     <%
                if (null != request.getAttribute("errorMessage")) {
                    %>
            <div align="center" class="content" id="testdiv" ><span class="lab" style="background: whitesmoke">
                <%
                    out.println(request.getAttribute("errorMessage"));
                    %>
                 </span></div>
                    <%
                }
                %>   
            
        <div align="center">
            <button onclick="window.location.href = 'HOD_Profile.jsp'">Home Page</button>
        </div>

        <%
                    }
                } catch (Exception e) {
                    con.rollback();

                    request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Invalid Combination...please try again....</h2></b></center></font>" + e);
                    request.getRequestDispatcher("HOD_Profile.jsp").include(request, response);
                } finally {
                    con.close();
                }
            }%>

    </body>
</html>
