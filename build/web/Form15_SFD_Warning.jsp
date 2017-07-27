<%-- 
    Document   : Form15_SFD_Warning
    Created on : Sep 13, 2016, 10:36:00 PM
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
            .neon {
                font-size: 30px;
                color: black;
                text-shadow: 0 0 5px #A5F1FF, 0 0 10px #A5F1FF,
                    0 0 20px #A5F1FF, 0 0 30px #A5F1FF,
                    0 0 40px #A5F1FF;
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
        
        <div class="neon" style="color: red" align="center"><h4>( Warning!! This will lead to Removing all the earlier set Faculty Attendance Records!! )</h4></div><br>
        <form action="Form15_SFD_Confirm.jsp" method="post">
            <div class="neon" align="center"><h2>Are You Sure you want to proceed?</h2></div><br>

            <div align="center">
                            <input style="background: lightcoral" type="submit" value="De-allocate">
                        </div>

        </form>
        <br>
        <br>
        <div align="center">
                        <button style="color: white" onclick="window.location.href = 'Form13_CT_Login.jsp'">No</button>
                    </div>
              
        <%}%>
    </body>
</html>
