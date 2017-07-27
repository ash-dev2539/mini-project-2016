<%-- 
    Document   : Form25_GD_TV
    Created on : 15 Sep, 2016, 11:26:52 PM
    Author     : MYSELF
--%>

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
                width:550px;
                margin:0 auto;
                margin-top:8px;
                margin-bottom:2%;
                transition:opacity 1s;
                -webkit-transition:opacity 1s;
            }
            .label{
                width:250px;
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
            String type = request.getParameter("type");
            ses.setAttribute("type", type);
            String student_id = (String) ses.getAttribute("student_id");
            if (type.equals("Monthly")) {

        %>

        <div id="login">


            <h1>Month-Wise</h1>

            <form action="Studentwise_GD_Month_Before.jsp" method="post">
                <table align="center">
                    <tr>
                        <td class="label">
                            Enter The Academic Month Number
                        </td>
                        <td>
                            <select name="academic_month" style="width: 200px" required>
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


                    <tr>
                        <td class="label">
                            Select the Subject type to display the Attendance for
                        </td>
                        <td>
                            <select name="sub_type" style="width: 200px" required>
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

                <input type="submit" value="Next">

            </form>

        </div>


    <div align="center">
        <button style="color: white" onclick="window.location.href = 'Studentwise_GD.jsp'">Back</button>
    </div>

    <%} else {

            request.getRequestDispatcher("Studentwise_Final.jsp").forward(request, response);
        }

    %>
</body>
</html>
