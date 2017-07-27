<%-- 
    Document   : Form14_BD
    Created on : Sep 2, 2016, 11:18:24 AM
    Author     : Administrator
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="false"%>
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
    </head>
    <body>
        <%
            HttpSession ses = request.getSession(false);
            if (ses.getAttribute("empid") == null || ses.getAttribute("empid").equals("")) {
                request.setAttribute("errorMessage","<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
                request.getRequestDispatcher("Login.jsp").include(request, response);
            } else {
        %>
        <br><br><br><br><br><br>
         <div id="login">
            

            <h1>Enter Maximum Batches</h1>

            <form action="Form15_SFD.jsp" method="get">
            <select name="batches" style="width: 100%;font-size: 20px" required>
                            <option disabled selected></option>
                            <option>1</option>
                            <option>2</option>
                            <option>3</option>
                            <option>4</option>
                        </select>
                

                <input type="submit" value="Proceed"/>

            </form>

        </div>
        
        <br><br><br>
        <div align="center"> <button onclick="window.location.href = 'Form13_CT_Login.jsp'">Back</button></div>
        <%}%>
    </body>
</html>
