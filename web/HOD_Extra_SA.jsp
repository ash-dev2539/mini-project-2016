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
        <script type="text/javascript" src="js/jquery-1.8.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="cool.css" rel="stylesheet">
        <style>
            *{margin:0;padding:0;}
            #login{
                width:1200px;
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
                height: 30px;
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
                int ex_total = (Integer) ses.getAttribute("extra_total_count");
                int ex_theory = (Integer) ses.getAttribute("ex_th_count");
                int ex_prac = (Integer) ses.getAttribute("ex_pr_count");


        %>        
        <div id="login">


            <h1>Enter Details</h1>

            <form action="HOD_Extra_SAS.jsp" method="post">
                <table>
                    <thead class="hi" style="font-size: 15px">
                        
                            <th>Sr.No</th>
                            <th>Subject Name (<font color="yellow">Full form</font>)</th>
                            <th>Subject Name (<font color="yellow">Only short form</font>)</th>
                            <th>Subject Code</th>
                            <th>Subject Type</th>                        
                       
                    </thead>
                    <t<%  for (int i = 0; i < ex_theory; i++) {

                        %>
                        <tr>
                            <td class="lab">Subject <%=i + 1%></td>
                            <td>
                                <input style="width: 300px;" type="text" class="follow" name="Subject_Name_Full_<%=i%>"  required/>
                            </td>
                            <td>
                                <input style="width: 200px;" type="text" class="follow" name="Subject_Name_<%=i%>"  required/>
                            </td>
                            <td>
                                <input style="width: 200px;" type="text" class="follow" name="Subject_Code_<%=i%>" required/>
                            </td>
                            <td>                           
                                <input style="width: 100px;" type="text" class="follow" value="Theory" name="Subject_Type_<%=i%>" readonly/>  
                            </td>
                        </tr>
                        <%}%>

                        <%  for (int j = 0; j < ex_prac; j++) {

                        %>
                        <tr>
                            <td class="lab">Subject <%=j + 1%></td>
                            <td>
                                <input style="width: 300px;" type="text" class="follow" name="Subject_Name_pr_Full_<%=j%>"  required/>
                            </td>
                            <td>
                                <input style="width: 200px;" type="text" class="follow" name="Subject_Name_pr_<%=j%>"  required/>
                            </td>
                            <td>
                                <input style="width: 200px;" type="text" class="follow" name="Subject_Code_pr_<%=j%>" required/>
                            </td>
                            <td>
                                <input style="width: 100px;" type="text" class="follow" value="Practical" name="Subject_Type_pr_<%=j%>" readonly/>  
                            </td>
                        </tr>
                        <%}%>
                        </tbody>


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
            <%
                }
            %>
    </body>
</html>
