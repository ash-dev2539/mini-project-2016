<%-- 
    Document   : Update_process
    Created on : 5 Sep, 2016, 6:07:07 PM
    Author     : Aroha
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.*" %>
<%

    Connection con = DBconnection.dbconnection.createConnection();
    int emp_id = Integer.parseInt(request.getParameter("emp_id"));

    String mobilenumber = request.getParameter("mobilenumber");
    String emergencycontactnumber = request.getParameter("emergencycontactnumber");

    String gender = request.getParameter("gender");
    String designation = request.getParameter("designation");
    String postype = request.getParameter("postype");
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
    String email_id = request.getParameter("email_id");
    String details = request.getParameter("details");

    PreparedStatement stmt = con.prepareStatement("update Faculty_Personal_Details set Gender=?, Designation=?, PosType=?,Portfolio=?, Details=?, Department=?,Qualification=?,  Mobile_Number=?, Emergency_Contact_Number=?, Address1=?,Address2=?, Area=?, City=?, Pincode=?, State=?, Blood_group=?, DOB=?, Email_ID=? where Emp_ID=?");

    stmt.setString(1, gender);
    stmt.setString(2, designation);
    stmt.setString(3, postype);
    stmt.setString(4, portfolio);
    stmt.setString(5, details);
    stmt.setString(6, department);
    stmt.setString(7, qualification);
    stmt.setString(8, mobilenumber);
    stmt.setString(9, emergencycontactnumber);
    stmt.setString(10, address1);
    stmt.setString(11, address2);
    stmt.setString(12, area);
    stmt.setString(13, city);
    stmt.setString(14, pincode);
    stmt.setString(15, state);
    stmt.setString(16, bloodgroup);
    stmt.setString(17, dob);
    stmt.setString(18, email_id);
    stmt.setInt(19, emp_id);

    stmt.executeUpdate();

    request.setAttribute("errorMessage", "<font color='green'><center><b><h2>Details Successfully Updated</h2></b></center></font>");
    request.getRequestDispatcher("Login.jsp").include(request, response);


%>