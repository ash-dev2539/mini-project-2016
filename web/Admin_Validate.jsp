
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.*" %>
<%@page import="DBconnection.dbconnection" %>


<%@page contentType="text/html" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
<body>   
    <%

        int emp_id = Integer.parseInt(request.getParameter("empid"));
        String pass = request.getParameter("password");

        Connection con = dbconnection.createConnection();
        try {
            PreparedStatement stmt = con.prepareStatement("select * from Admin_Details where Admin_ID=? and Admin_PWD=?");
            stmt.setInt(1, emp_id);
            stmt.setString(2, pass);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {

                HttpSession ses = request.getSession(true);
                ses.setAttribute("empid", emp_id);

                response.sendRedirect("Admin_Home.jsp");

            } else {
                request.setAttribute("errorMessage","<p style=\"color:red\"  >"
                + "  "                                                                                                 
                + "Invalid Username or Password</p>");
                
                request.getRequestDispatcher("Admin_Login.jsp").include(request, response);

            }
        } catch (Exception e) {            
           request.setAttribute("errorMessage","<font color='red'><center><b><h2>Exception encountered...</h2></b></center></font>"+e);
            request.getRequestDispatcher("Admin_Login.jsp").include(request, response);
        }
    %>
</body>
</html>
