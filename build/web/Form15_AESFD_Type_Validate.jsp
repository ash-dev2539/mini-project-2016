<%-- 
    Document   : Form15_AESFD_Type_Validate
    Created on : 14 Sep, 2016, 10:21:26 AM
    Author     : MYSELF
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
                request.setAttribute("errorMessage","<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
                request.getRequestDispatcher("Login.jsp").include(request, response);
            }
            else
            {
            
            String subject_type=request.getParameter("subject_type");
            if(subject_type.equals("Theory"))
            {
            
                ses.setAttribute("subject_type", subject_type);
                 request.getRequestDispatcher("Form15_AESFD_Display.jsp").forward(request, response);
            }
            else
            {
            ses.setAttribute("subject_type", subject_type);
            request.getRequestDispatcher("Form15_AESFD_BD.jsp").forward(request, response);
            }
            
            }
        %>
    </body>
</html>
