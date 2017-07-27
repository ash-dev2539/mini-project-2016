<%-- 
    Document   : update_middle
    Created on : 13 Oct, 2016, 1:12:48 AM
    Author     : Sai Kameswari
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update page</title>
    </head>
    <body>
        <%
            HttpSession ses = request.getSession(false);
            if (ses.getAttribute("empid") == null || ses.getAttribute("empid").equals("")) {
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
                request.getRequestDispatcher("Login.jsp").include(request, response);
            } else {
                
                
                String Date = request.getParameter("Date");
                String Lecture_Type = request.getParameter("Lecture_Type");
                String[] Time = request.getParameterValues("Time");
                String upchoice = request.getParameter("upchoice");
                String Type = request.getParameter("Type");
                
                ses.setAttribute("Hour", Time);
                ses.setAttribute("Date", Date);
                ses.setAttribute("Lecture_Type", Lecture_Type);
                ses.setAttribute("upchoice", upchoice);
                ses.setAttribute("Type", Type);
                
                response.sendRedirect("Form20_AE_Update.jsp");
            }


        %>
    </body>
</html>
