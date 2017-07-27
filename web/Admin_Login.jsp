<%@page contentType="text/html" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html>
<html>
    <head>
        <script type="text/javascript" src="js/jquery-1.8.js"></script>
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title></head>


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
        <br><br>

        <span  class="button" id="toggle-login">Welcome</span>


        <div id="login">
            <div id="triangle"></div>

            <h1>Administrator Log in</h1>

            <form action="Admin_Validate.jsp" method="post">

                                                                                                  
                        <input pattern="[0-9]+" type="text" name="empid"  placeholder="Employee ID" required>

                       <input type="password" name="password" required placeholder="Password">

                   

                <input type="submit" value="Log in" />

            </form>

        </div>

        <div align="center"><button onclick="window.location.href = 'Login.jsp'">Back</button></div>
  
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
</body>
</html>