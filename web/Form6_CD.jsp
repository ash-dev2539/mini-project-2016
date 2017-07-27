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
        <link href="cool.css" rel="stylesheet">
        <style>
            *{margin:0;padding:0;}


            #login{
                width:550px;
                margin:0 auto;
                margin-top:8px;
                margin-bottom:2%;
                transition:opacity 1s;
                -webkit-transition:opacity 1s;
            }
            button:hover{
                background:rgba(0,253,140,0.5);;
            }


            form{
                background:#f0f0f0;
                padding:2% 4%;
            }

            input[type="text"],input[type="password"]{
                width:92%;
                background:#fff;
                margin-bottom:4%;
                border:1px solid #ccc;
                padding:2%;
                font-family:'Open Sans',sans-serif;
                font-size:95%;
                color:#555;
            }
            input[type="text"]:focus{
                border-width: 2pt;
                border-color: #3399cc;
            }

            input[type="password"]:focus{
                border-width: 2pt;
                border-color:#3399cc;
            }

            input[type="submit"]{
                width:100%;
                background:#3399cc;
                border:0;
                padding:2%;
                font-family:'Open Sans',sans-serif;
                font-size:100%;
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

    <body><script type="text/javascript">
        $(function () {
            setTimeout(function () {
                $("#testdiv").fadeOut(1000);
            }, 7599);

        });
        </script>


        <br><br>


        <br><br><br>

        <%
            HttpSession ses = request.getSession(false);
            if (ses.getAttribute("empid") == null || ses.getAttribute("empid").equals("")) {
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
                request.getRequestDispatcher("Login.jsp").include(request, response);
            } else {
                Connection con = dbconnection.createConnection();
                con.setAutoCommit(false);
                try {

                    PreparedStatement stmt = con.prepareStatement("select distinct Academic_Year from course_details order by Academic_Year ");

                    ResultSet rs = stmt.executeQuery();
                    con.commit();
        %>

        <div id="login">

            <h1>Enter Details</h1>

            <form action="Form6_CD_Validate.jsp" method="post">
                <table align="center">

                    <tr>
                        <td class="label">
                            Academic Year*
                        </td>
                        <td>
                            <select name="academic_year" style="width: 300px;font-size: 20px" required>
                                <option disabled selected></option>
                                <%  while (rs.next()) {%>
                                <option><%= rs.getString(1)%></option>
                                <% } %>

                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label">
                            Course*
                        </td>
                        <td>
                            <select name="course" style="width: 300px;font-size: 20px" required>
                                <%
                                    PreparedStatement stmt1 = con.prepareStatement("select distinct Course_Name from course_details order by Course_Name ");
                                    ResultSet rs1 = stmt1.executeQuery();
                                %>
                                <option disabled selected></option>
                                <%while (rs1.next()) {%>
                                <option><%=rs1.getString(1)%></option>
                                <%}%>

                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label">
                            Semester* 
                        </td>
                        <td>
                            <select name="sem" style="width: 300px;font-size: 20px" required>
                                <option disabled selected></option>
                                <option>I</option>
                                <option>II</option>
                            </select> 
                        </td>
                    </tr>
                </table>

                <input type="submit" value="Proceed" />

            </form>

        </div>
        <div class="content" id="testdiv" >

            <%
                if (null != request.getAttribute("errorMessage")) {
                    out.println(request.getAttribute("<span style='background:white'>errorMessage</span>"));
                }
            %>                </div>

    </body>     
</html>
<%
        } catch (Exception e) {
            con.rollback();
            out.println(e);
            request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Exception occured at: </h2></b></center></font>" + e);
            request.getRequestDispatcher("Login.jsp").include(request, response);
        } finally {
            con.close();
        }
    }
%>

