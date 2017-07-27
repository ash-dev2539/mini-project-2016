

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
                width:300px;
                margin:0 auto;
                margin-top:8px;
                margin-bottom:2%;
                transition:opacity 1s;
                -webkit-transition:opacity 1s;
            }
            h1{
                font-size: 20px;

            }

            .label{
                width:400px;
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
            form{
                background:#f0f0f0;
                padding:2% 4%;
            }

            input[type="text"],input[type="password"],input[type="tel"],input[type="number"]{
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
            input[type="number"]:focus{
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

                Connection con = dbconnection.createConnection();
                try {

                    int empid = (Integer) ses.getAttribute("empid");

        %>       
        <br><br>
        <div id="login">
         
            <h1>Month Entry</h1>

           <form action="Month_Entry_Save.jsp" method="post">

               <table>

                <tr>
                    <td class="lab">Enter Month 1</td>
                    <td>
                        <input style="width: 100px;height: 35px" type="number" class="follow" pattern="[0-9]+" name="month1" maxlength="2" max="12" placeholder="1 for January" required/>
                    </td>
                </tr>


                <tr>
                    <td class="lab">Enter Month 2</td>
                    <td>
                        <input style="width: 100px;height: 35px" type="number" class="follow" pattern="[0-9]+" name="month2" maxlength="2" max="12"  required/>
                    </td>
                </tr>

                <tr>
                    <td class="lab">Enter Month 3</td>
                    <td>
                        <input style="width: 100px;height: 35px" type="number" class="follow" pattern="[0-9]+" name="month3" maxlength="2" max="12"  required/>
                    </td>
                </tr>


                <tr>
                    <td class="lab">Enter Month 4</td>
                    <td>
                        <input style="width: 100px;height: 35px" type="number" class="follow" pattern="[0-9]+" name="month4" maxlength="2" max="12" required/>
                    </td>
                </tr>  
            </table>

               <input type="submit" value="Save" name="Proceed"/>

            </form>

        </div>
        <%
                if (null != request.getAttribute("errorMessage")) {
                    %>
            <div align="center" class="content" id="testdiv" ><span class="label" style="background: whitesmoke">
                <%
                    out.println(request.getAttribute("errorMessage"));
                    %>
                 </span></div>
                    <%
                }
                %>    
                  
    <div align="center"><button onclick="window.location.href = 'Form13_CT_Login.jsp'">Back</button></div>
               

        <%
                } catch (Exception e) {

                    request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Invalid Combination...please try again....</h2></b></center></font>" + e);
                    request.getRequestDispatcher("Form13_CT_Login.jsp").include(request, response);
                } finally {
                    con.close();
                }
            }%>

    </body>
</html>
