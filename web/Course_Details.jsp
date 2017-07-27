<%@page import="java.util.*" %>


<%@page contentType="text/html" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html>

<html>
    <head>
        <script type="text/javascript" src="js/jquery-1.8.js"></script>
        <link href="cool.css" rel="stylesheet">
        <style>
            *{margin:0;padding:0;}
            #login{
                width:480px;
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
                width:200px;
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
                
            });
        </script>

        <br>

        <div id="login">
            

            <h1>Course Details Entry</h1>

            <form action="Course_Details_Save.jsp" method="post">

                <table>
                    <%
                        HttpSession ses = request.getSession(false);
                        if (ses.getAttribute("empid") == null || ses.getAttribute("empid").equals("")) {
                            request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
                            request.getRequestDispatcher("Login.jsp").include(request, response);
                        } else {
                    %>
                    <tr><td class="lab">Course Name </td><td>
                            <select name="course_name" required style="width: 200px;font-size: 20px;height: 40px">

                                <option disabled selected></option>   
                                <option>UG</option>  
                                <option>PG</option>  
                            </select>
                        </td>
                    </tr>
                    <tr><td class="lab">Branch</td>
                        <td> <select name="branch" required style="width: 200px;font-size: 20px;height: 40px">

                                <option disabled selected></option>
                                <option>COMP</option>
                                <option>MECH</option>
                                <option>ENTC</option>
                                <option>CIVIL</option>
                                <option>FE</option>
                                <option>MBA</option>
                                <option>MCA</option>
                                <option>ME</option>
                            </select>
                        </td></tr>
                    <tr><td class="lab">Academic Year</td><td>
                            <select name="academic_year" required style="width: 200px;font-size: 20px;height: 40px">
                                <option disabled selected></option>
                                <option>2015</option>
                                <option>2016</option>
                                <option>2017</option>
                                <option>2018</option>
                            </select> </td></tr>


                    <tr><td class="lab">Duration of Course  (<font color="yellow">in Years</font>)</td>
                        <td> <select name="duration" required style="width: 200px;font-size: 20px;height: 40px">

                                <option disabled selected></option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option> 
                            </select>
                        </td></tr>   

                </table>

                <input type="submit" value="Save" name="Proceed"/>

            </form>

        </div>
        <%
            if (null != request.getAttribute("errorMessage")) {
        %>
        <div align="center" class="content" id="testdiv" ><span class="label" style="background: whitesmoke;width: 400px">
                <%
                    out.println(request.getAttribute("errorMessage"));
                %>
            </span></div>
            <%
                }
            %> 


        <div align="center">
            <button onclick="window.location.href = 'Admin_Home.jsp'">Home Page</button>
        </div>

        <%}%>
    </body>     
</html>
