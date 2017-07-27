<%-- 
    Document   : Form25_GD_Month_Wise_Before
    Created on : Sep 18, 2016, 5:04:42 PM
    Author     : Aroha
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
                
            String academic_year=request.getParameter("academic_year");
             String branch=request.getParameter("branch");
              String semester=request.getParameter("semester");
               String division=request.getParameter("division");
                String year=request.getParameter("year");
                String status_type=request.getParameter("status_type");
              
            ses.setAttribute("academic_year", academic_year);
            ses.setAttribute("branch", branch);
            ses.setAttribute("year", year);
            ses.setAttribute("division", division);
            ses.setAttribute("semester", semester);
            
            
if(status_type.equals("Overall"))
{
    request.getRequestDispatcher("Form25_GD.jsp").forward(request, response);
}else if(status_type.equals("Student_wise"))
{
     request.getRequestDispatcher("Studentwise_GD.jsp").forward(request, response);
}

        %>
        
    </body>
</html>
