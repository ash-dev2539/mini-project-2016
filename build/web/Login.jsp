<%@page contentType="text/html" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="cool.css" rel="stylesheet">
        <script type="text/javascript" src="js/jquery-1.8.js"></script>

        <style>
            *{margin:0;padding:0;}


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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title></head>


    <body>
        <script type="text/javascript">
            $(function () {
                setTimeout(function () {
                    $("#testdiv").fadeOut(1000);
                }, 7599);

            })
        </script>

        <span  class="button" id="toggle-login">Welcome</span>

        <div id="login">
            <div id="triangle"></div>

            <h1>Log in</h1>

            <form action="Login_validate.jsp" method="post">

                <input pattern="[0-9]+" type="text" name="empid" required placeholder="Faculty ID" />

                <input type="password" name="password" required placeholder="Password" />

                <input type="submit" value="Log in" />

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


        <table>    

            <tr><td>
                    <button onclick="window.location.href = 'Signup_validate.jsp'">Sign Up</button></td>

                <td><button style="width: 250px" onclick="window.location.href = 'Changepassword.jsp'">Change password</button></td></tr>
        </table>



        <table>    

            <tr><td>
                    <button onclick="window.location.href = 'Admin_Login.jsp'">Admin Login</button></td>               
        </table>

    </body>
</html>