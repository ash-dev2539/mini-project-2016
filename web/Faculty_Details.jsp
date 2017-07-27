<%@page import="java.util.*" %>


<%@page contentType="text/html" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html>

<html>
    <head>
        <script type="text/javascript" src="js/jquery-1.8.js"></script>
        <link href="cool.css" rel="stylesheet">
        <script src="js/la.js" type="text/javascript"></script>
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
                width:160px;
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

            input[type="text"],input[type="password"],input[type="tel"],input[type="email"]{
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
            input[type="email"]:focus{
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

    <body><script type="text/javascript">
        $(function () {
            setTimeout(function () {
                $("#testdiv").fadeOut(1000);
            }, 7599);

        });
        </script>
        <%
            HttpSession ses = request.getSession(false);
            if (ses.getAttribute("empid") == null || ses.getAttribute("empid").equals("")) {
                request.setAttribute("errorMessage", "<center><font color='red'><b><h2>Sorry...Your Session has Expired....</h2></b></font></center>");
                request.getRequestDispatcher("Login.jsp").include(request, response);
            } else {
        %>
        <br><br>
        <div id="login">


            <h1>Faculty Details Entry</h1>

            <form action="Faculty_Details_Save.jsp" method="post">
                <table>



                    <tr><td><label class="lab">Faculty ID</label></td>                                                                                      
                        <td><input pattern="[0-9]+" type="text" style="width: 260px;font-size: 20px"  name="faculty_id" id="id" required></td>
                        <td><div id="lala" style="font-size: 15px;width: 300px">
                            
                            </div></td>
                    </tr>    

                    <tr><td><label class="lab">Faculty Full Name</label></td>                                                                                      
                        <td><input pattern="[A-Za-z ]+" type="text" style="width: 260px;font-size: 20px" name="faculty_name" required></td>
                    </tr>  

                    <tr><td><label class="lab">Faculty Branch</label></td>                                                                                      
                        <td><select name="branch" style="width: 270px;font-size: 20px;height: 40px">
                                <option disabled selected></option>
                                <option>COMP</option>
                                <option>MECH</option>
                                <option>CIVIL</option>
                                <option>ENTC</option>
                                <option>MSW</option>
                                <option>FE</option>
                                <option>ME</option>
                                <option>MBA</option>
                                <option>MCA</option>
                            </select></td>
                    </tr>

                    <tr><td><label class="lab">Faculty E-mail ID</label></td>                                                                                      
                        <td><input type="email" name="email" style="width: 260px;font-size: 20px" required></td>
                    </tr>  

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

        <script type="text/javascript">

            var request;

            $(document).ready(function ()
            {
                $("#id").keyup(function ()
                {
                    $.ajax({
                        url: "ajax_validate.jsp",
                        data: "sendo=" + $("#id").val(),
                        type: "post",
                        success: function (msg)
                        {
                            $("#lala").html(msg);

                        }
                    });

                });


            });

        </script>
    </body>     
</html>
