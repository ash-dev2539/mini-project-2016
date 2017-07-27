<%-- 
    Document   : Form15_SFD_Confirm
    Created on : Sep 13, 2016, 10:42:32 PM
    Author     : sandeep
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

         
            form{
                background:#f0f0f0;
                padding:2% 4%;
            }

           input[type="password"]{
                width:92%;
                background:#fff;
                margin-bottom:4%;
                border:1px solid #ccc;
                padding:2%;
                font-family:'Open Sans',sans-serif;
                font-size:95%;
                color:#555;
            }
           

            input[type="password"]:focus{
                border-width: 2pt;
                border-color:#3399cc;
            }

            input[type="submit"]{
                width:100%;
                
                background: lightcoral;
                border:0;
                padding:2%;
                font-family:'Open Sans',sans-serif;
                font-size: 20px;
                color:white;
                cursor:pointer;
                transition:background .3s;
                -webkit-transition:background .3s;
            }
            input[type="submit"]:hover{
                background:rgba(200,10,0,0.5);    
            }
        </style>
    </head>
    <body>
        <%
            HttpSession ses = request.getSession(false);
            if (ses.getAttribute("empid") == null || ses.getAttribute("empid").equals("")) {
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
                request.getRequestDispatcher("Login.jsp").include(request, response);
            } else {

        %>
        <br><br><br><br><br><br><br><br><br>
        
                <div id="login">
            

            <h1>Enter your Password</h1>

            <form action="Form15_SFD_Deallocate.jsp" method="post"/>

                <input type="password" name="pass" required placeholder="Password"/>

                 <input  type="submit" value="OK"/>

            </form>

        </div>
        

        <br><br>

        <div align="center">
            <button  onclick="window.location.href = 'Form13_CT_Login.jsp'">Back</button>
        </div>

        <%}%>
    </body>
</html>
