<%-- 
    Document   : Signup1
    Created on : 1 Sep, 2016, 10:35:34 PM
    Author     : rohan
--%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.*" %>
<%@page import="DBconnection.dbconnection" %>
<%

    Connection con = DBconnection.dbconnection.createConnection();
    int emp_id = Integer.parseInt(request.getParameter("emp_id"));
    String fname = request.getParameter("fname");
    String lname = request.getParameter("lname");
    String email_id = request.getParameter("email_id");
    String mobilenumber = request.getParameter("mobilenumber");
    String emergencycontactnumber = request.getParameter("emergencycontactnumber");

    String gender = request.getParameter("gender");
    String designation = request.getParameter("designation");
    String posttype = request.getParameter("posttype");
    String portfolio = request.getParameter("portfolio");
    String department = request.getParameter("department");
    String qualification = request.getParameter("qualification");

    String address1 = request.getParameter("address1");
    String address2 = request.getParameter("address2");
    String area = request.getParameter("area");
    String city = request.getParameter("city");
    String pincode = request.getParameter("pincode");
    String state = request.getParameter("state");
    String bloodgroup = request.getParameter("bloodgroup");
    String dob = request.getParameter("dob");

    String details = request.getParameter("details");
    String password = request.getParameter("password");
   
    String query = "insert into Faculty_Personal_details values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    PreparedStatement stmt = con.prepareStatement(query);

    stmt.setInt(1, emp_id);
    stmt.setString(2, fname);
    stmt.setString(3, lname);
    stmt.setString(4, password);
    stmt.setString(5, gender);
    stmt.setString(6, designation);
    stmt.setString(7, posttype);
    stmt.setString(8, portfolio);
    stmt.setString(9, details);
    stmt.setString(10, department);
    stmt.setString(11, qualification);
    stmt.setString(12, mobilenumber);
    stmt.setString(13, emergencycontactnumber);
    stmt.setString(14, address1);
    stmt.setString(15, address2);
    stmt.setString(16, area);
    stmt.setString(17, city);
    stmt.setString(18, pincode);
    stmt.setString(19, state);
    stmt.setString(20, bloodgroup);
    stmt.setString(21, dob);
    stmt.setString(22, email_id);
    int che=stmt.executeUpdate();
    if(che==0)
    {
        out.println("Sorry...Your data is not stored in our database....");
        request.getRequestDispatcher("Signup.jsp").include(request, response);
    }
    request.setAttribute("errorMessage", "<center><p style=\"color:blue\">Sign Up successful..Please Login Now..</p></center>");
    request.getRequestDispatcher("Login.jsp").include(request, response);
%>