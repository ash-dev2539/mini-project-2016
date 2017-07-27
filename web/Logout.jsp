<%-- 
    Document   : Logout
    Created on : Sep 19, 2016, 4:20:08 PM
    Author     : Aroha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
       
    </head>
    <body>
        
        <%   HttpSession ses = request.getSession(false);
            ses.invalidate();
            request.setAttribute("errorMessage","<center><h3><font color='green'>You have successfully Logged out....Thank you.....</font></h3></center>");
            request.getRequestDispatcher("Login.jsp").include(request, response);
            

        %>
    </body>
</html>
