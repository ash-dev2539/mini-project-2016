<%-- 
    Document   : Changepassword1
    Created on : 1 Sep, 2016, 9:58:56 PM
    Author     : rohan
--%>


<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.*" %>
<%@page import="DBconnection.dbconnection" %>
<%
    int emp_id = Integer.parseInt(request.getParameter("Faculty_ID"));
    String op = request.getParameter("oldpassword");
    String np = request.getParameter("newpassword");

    Connection con = DBconnection.dbconnection.createConnection();

    PreparedStatement stmt = con.prepareStatement("select Password from Faculty_Personal_details where Emp_ID=? ");
    stmt.setInt(1, emp_id);

    ResultSet rs = stmt.executeQuery();
    if (rs.next()) {
        String password=rs.getString(1);
        if(password.equals(op))
        {
                   
        PreparedStatement stmtp = con.prepareStatement("update Faculty_Personal_details set Password=? where Emp_ID=?");
        stmtp.setString(1, np);
        stmtp.setInt(2, emp_id);
        stmtp.executeUpdate();
       
       request.setAttribute("errorMessage","<p style=\"color:yellow\">Password Changed successfully");
        request.getRequestDispatcher("Login.jsp").include(request, response);
        }
        else
        {
        
        request.setAttribute("errorMessage","<p style=\"color:yellow\">Sorry...Your password does not match with our Database Record..Please check again..");
        request.getRequestDispatcher("Changepassword.jsp").include(request, response);
        }
    } else {
        
        request.setAttribute("errorMessage","<p style=\"color:yellow\">Sorrry...Your Account does not exist..Please create a new account first...");
        request.getRequestDispatcher("Changepassword.jsp").include(request, response);
    }
%>