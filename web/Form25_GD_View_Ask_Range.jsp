<%-- 
    Document   : Form25_GD_View_Ask_Range
    Created on : Sep 17, 2016, 6:27:26 PM
    Author     : sandeep
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                width:350px;
                margin:0 auto;
                margin-top:8px;
                margin-bottom:2%;
                transition:opacity 1s;
                -webkit-transition:opacity 1s;
            }
            .label{
                width:100px;
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
            }
            Connection con = DBconnection.dbconnection.createConnection();

            int empid = (Integer) ses.getAttribute("empid");
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
        %>
        <span  class="button" id="toggle-login">Final Attendance Process</span>


        <div id="login">
            <div id="triangle"></div>

            <h1>Enter a Range</h1>

            <form action="Form25_GD_Final_Really.jsp" method="post">
                <table>
                    <thead class="hi" style="font-size: 20px">
                    <th>
                        Sr No.
                    </th>
                    <th>
                        From
                    </th>
                    <th>
                        To
                    </th>

                    </thead>

                    <tr>
                        <td class="label">
                            1
                        </td>
                        <td>
                            <input type="tel" style="width:  60px;height: 30px" pattern="[0-9]+" max="99" min="1" value="60" name="ch1f" >
                        </td>
                        <td>
                            <input type="tel" style="width:  60px;height: 30px" pattern="[0-9]+" max="99" min="1" value="75" name="ch1t" >
                        </td>
                    </tr>
                    <tr>
                        <td class="label">
                           2
                        </td>
                        <td>
                            <input type="tel" style="width:  60px;height: 30px" pattern="[0-9]+" max="99" min="1" value="50" name="ch2f">
                        </td>
                        <td>
                            <input type="tel" style="width:  60px;height: 30px" pattern="[0-9]+" max="99" min="1" value="60" name="ch2t">
                        </td>
                    </tr>
                    <tr>
                        <td class="label">
                           3
                        </td>
                        <td>
                            <input type="tel" style="width:  60px;height: 30px" pattern="[0-9]+" max="99" min="1" value="0" name="ch3f">
                        </td>
                        <td>
                            <input type="tel" style="width:  60px;height: 30px" pattern="[0-9]+" max="99" min="1" value="50" name="ch3t">
                        </td>
                    </tr>

                </table>

                <input type="submit" value="Generate"> 
            </form>

        </div>






        <div class="content" id="testdiv" >

            <%
                if (null != request.getAttribute("errorMessage")) {
                    out.println(request.getAttribute("errorMessage"));
                }
            %>                </div>



        <div align="center">
            <button onclick="window.location.href = 'Form25_GD.jsp'">Back</button>
        </div>
    </body>
</html>
