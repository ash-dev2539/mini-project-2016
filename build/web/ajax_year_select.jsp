<%-- 
    Document   : ajax_year_select
    Created on : Sep 24, 2016, 4:26:45 PM
    Author     : Administrator
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

            String branch = request.getParameter("sendo");
            System.out.println(branch);
            if (branch.equals("MBA") || branch.equals("ME")) {
                out.println("<option disabled selected></option><option>1</option><option>2</option>");
            } else if (branch.equals("MCA")) {
                out.println("<option disabled selected></option><option>1</option><option>2</option><option>3</option>");
            } else if (branch.equals("FE")) {
                out.println("<option disabled selected></option><option>1</option>");
            } else {
                out.println("<option disabled selected></option><option>2</option><option>3</option><option>4</option>");
            }
        %>
    </body>
</html>
