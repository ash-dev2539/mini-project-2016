<%-- 
    Document   : Form25_GD_TV
    Created on : 15 Sep, 2016, 11:26:52 PM
    Author     : MYSELF
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="DBconnection.dbconnection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript" src="js/jquery-1.8.js"></script>
        <link href="css/jquery-script.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" href="css/font.css">
        <link rel="stylesheet" href="css/bootstrap.css">
        <link href="css/jquery.dateselect.css" rel="stylesheet" type="text/css">
        <link href="cool.css" rel="stylesheet">

        <script src="js/jquery-min.js"></script> 
        <script src="js/jquery-mousewheel.js"></script> 
        <script src="js/jquery.dateselect.js"></script>
        <script>
            jQuery(document).ready(function ($) {
                $('.btn-date').on('click', function (e) {
                    e.preventDefault();
                    $.dateSelect.show({
                        element: 'input[name="Date_From"]'
                    });
                });
            });
        </script>
        <script>
            jQuery(document).ready(function ($) {
                $('.btn-date1').on('click', function (e) {
                    e.preventDefault();
                    $.dateSelect.show({
                        element: 'input[name="Date_To"]'
                    });
                });
            });
        </script>
        <script type="text/javascript">

            var _gaq = _gaq || [];
            _gaq.push(['_setAccount', 'UA-36251023-1']);
            _gaq.push(['_setDomainName', 'jqueryscript.net']);
            _gaq.push(['_trackPageview']);

            (function () {
                var ga = document.createElement('script');
                ga.type = 'text/javascript';
                ga.async = true;
                ga.src = 'js/analytics-ga.js';
                var s = document.getElementsByTagName('script')[0];
                s.parentNode.insertBefore(ga, s);
            })();

        </script>
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
            }
            Connection con = dbconnection.createConnection();
            try {
                int empid = (Integer) ses.getAttribute("empid");
                PreparedStatement ps = con.prepareStatement("select Designation from Faculty_Personal_Details where Emp_ID=? ");
                ps.setInt(1, empid);
                ResultSet rs = ps.executeQuery();
                rs.next();
                String faculty_designation = rs.getString(1);
                String deliver = "";
                if (faculty_designation.equals("Faculty")) {
                    deliver = "Form13_CT_Login.jsp";
                } else if (faculty_designation.equals("Principal") || faculty_designation.equals("Vice_Principal")) {

                    deliver = "Principal_Check_Status.jsp";
                } else if (faculty_designation.equals("HOD")) {

                    deliver = "HOD_Check_Status.jsp";
                }
                String type = request.getParameter("type");
                ses.setAttribute("type", type);

                if (type.equals("Monthly")) {


        %>
        <div id="login">


            <h1>Month-Wise</h1>

            <form action="Form25_GD_Month_Wise_Before.jsp" method="post">

                <table align="center">
                    <tr>
                        <td class="label">
                            Academic Month Number
                        </td>
                        <td>
                            <select name="academic_month" style="width: 200px;font-size: 20px" required>
                                <option disabled selected>
                                </option>
                                <option>
                                    1
                                </option>
                                <option>
                                    2
                                </option>
                                <option>
                                    3
                                </option>
                                <option>
                                    4
                                </option>
                            </select>
                        </td>
                    </tr>
                    <% if (faculty_designation.equals("Faculty")) {
                    %>
                    <tr>
                        <td class="label">
                            Minimum Percent for Regular Students
                        </td>
                        <td>
                            <input style="width: 200px;font-size: 20px" pattern="[0-9]+" type="tel" name="percent" maxlength="2" required>
                        </td>
                    </tr>
                    <%
                    } else {
                    %>

                    <input  type="hidden" name="percent" value="75">
                    <%
                        }
                    %>

                    <tr>
                        <td class="label">
                            Subject type for Attendance
                        </td>
                        <td>
                            <select name="sub_type" style="width: 200px;font-size: 20px" required>
                                <option disabled selected>
                                </option>
                                <option>
                                    Theory
                                </option>
                                <option>
                                    Practical
                                </option>

                            </select>
                        </td>
                    </tr>

                </table>

                <input type="submit" value="Show :)" />

            </form>

        </div>




        <div align="center">
            <button onclick="window.location.href = '<%=deliver%>'">Back</button>
        </div>


        <%        } else if (type.equals("Final")) {
        %>
        <div id="login">


            <h1>Final Attendance Process</h1>

            <form action="Form25_GD_Final_Start.jsp" method="post">

                <%
                    if (faculty_designation.equals("Faculty")) {

                %>

                <div class="lab">
                    Do you wish to add the Leave count To Student Attendance First Or Generate Defaulter Directly
                </div>
                <br>
                <input type="submit" value="Add Leave Count"> 
                <%                    }%>


            </form>
        </div>
        <br><br>
        <div align="center">

            <button onclick="window.location.href = 'Form25_GD_Final_Choice.jsp'">Generate Defaulter</button>
        </div><br>
        <div align="center">


            <button onclick="window.location.href = 'Form25_GD.jsp'">Back</button>

        </div>


        <%
        } else if (type.equals("Manual Range")) {
        %>
        <div id="login">


            <h1>Enter Range</h1>

            <form action="Form25_GD_Range_Wise_Before.jsp" method="post">

                <table align="center" style="width: 60%">
                    <tr>
                        <td class="label">
                            From
                        </td>

                        <td>  <input type="text" class="input-group" name="Date_From" id="date2" class="form-control" readonly required style="width: 200px;font-size: 20px">
                            <span class="input-group-btn">
                                <button class="btn btn-primary btn-date" type="button">Select Date</button>
                            </span> </td>

                    </tr>
                    <tr>
                        <td class="label">
                            To
                        </td>
                        <td>  <input type="text" class="input-group" name="Date_To" id="date2" class="form-control" readonly required style="width: 200px;font-size: 20px">
                            <span class="input-group-btn">
                                <button class="btn btn-primary btn-date1" type="button">Select Date</button>
                            </span> </td>
                    </tr>
                    <% if (faculty_designation.equals("Faculty")) {
                    %>
                    <tr>
                        <td class="lab" style="height: 60px;width: 300px">
                            Enter The Minimum Percent for Regular Students
                        </td>
                        <td>
                            <input style="width: 200px;font-size: 20px" pattern="[0-9]+" type="tel" name="percent" maxlength="2" required>
                        </td>
                    </tr>
                    <%
                        }
                    %>

                    <tr>
                        <td class="lab" style="height: 60px;width: 300px">
                            Select the Subject type to display the Attendance for
                        </td>
                        <td>
                            <select name="sub_type" style="width: 200px;font-size: 20px" required>
                                <option disabled selected>
                                </option>
                                <option>
                                    Theory
                                </option>
                                <option>
                                    Practical
                                </option>

                            </select>
                        </td>
                    </tr>

                </table>

                <input type="submit" value="Show">

            </form>

        </div>


        <div align="center">
            <button onclick="window.location.href = '<%=deliver%>'">Back</button>
        </div>

        <%
                }
            } catch (Exception e) {
                out.println(e);

            }

        %>
    </body>
</html>
