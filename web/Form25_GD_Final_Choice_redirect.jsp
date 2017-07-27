<%-- 
    Document   : Form25_GD_Month_Wise_Before
    Created on : Sep 18, 2016, 5:04:42 PM
    Author     : Jagannath
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            HttpSession ses = request.getSession(false);
            if (ses.getAttribute("empid") == null || ses.getAttribute("empid").equals("")) {
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
                request.getRequestDispatcher("Login.jsp").include(request, response);
            }
            String sub_type = request.getParameter("sub_type");
            if (sub_type.equals("Theory")) {
                response.sendRedirect("Form25_GD_View_Th.jsp");
            } else {
                response.sendRedirect("Form25_GD_View_Pr.jsp");
            }

        %>

    </body>
</html>
