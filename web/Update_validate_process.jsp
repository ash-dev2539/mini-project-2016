<%-- 
    Document   : Update_validate_process
    Created on : 5 Sep, 2016, 11:38:37 AM
    Author     : Aroha
--%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.*" %>
<%@page import="DBconnection.dbconnection" %>

<%
     HttpSession ses = request.getSession(false);
        if (ses.getAttribute("empid") == null || ses.getAttribute("empid").equals("")) {
            request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
            request.getRequestDispatcher("Login.jsp").include(request, response);
        }
        else
        {

    int emp_id = (Integer)ses.getAttribute("empid");
    String password = request.getParameter("password");

    Connection con = DBconnection.dbconnection.createConnection();

    PreparedStatement stmtp = con.prepareStatement("select * from Faculty_Personal_Details where Emp_ID=? and Password=?");
    stmtp.setInt(1, emp_id);
    stmtp.setString(2, password);
    ResultSet rsm = stmtp.executeQuery();

    if (rsm.next()) {
        int Emp_ID = rsm.getInt("Emp_ID");
        String fname = rsm.getString("Fname");
        String lname = rsm.getString("Lname");
        String Email_ID = rsm.getString("Email_ID");
        String Gender = rsm.getString("Gender");
        String Designation = rsm.getString("Designation");
        String Postype = rsm.getString("Postype");
        String Portfolio = rsm.getString("Portfolio");
        String Department = rsm.getString("Department");
        String Qualification = rsm.getString("Qualification");
        String Mobilenumber = rsm.getString("Mobile_Number");
        String Emergencycontactnumber = rsm.getString("Emergency_Contact_Number");
        String Address1 = rsm.getString("Address1");
        String Address2 = rsm.getString("Address2");
        String Bloodgroup = rsm.getString("Blood_group");
        String DOB = rsm.getString("DOB");
        String Details = rsm.getString("Details");
        String Password = rsm.getString("Password");
        String Area = rsm.getString("Area");
        String City = rsm.getString("City");
        String Pincode = rsm.getString("Pincode");
        String State = rsm.getString("State");

        session.setAttribute("emp_id", Emp_ID);

        request.setAttribute("emp_id", Emp_ID);
        request.setAttribute("fname", fname);
        request.setAttribute("lname", lname);
        request.setAttribute("email_id", Email_ID);
        request.setAttribute("gender", Gender);
        request.setAttribute("designation", Designation);
        request.setAttribute("postype", Postype);
        request.setAttribute("portfolio", Portfolio);
        request.setAttribute("department", Department);
        request.setAttribute("qualification", Qualification);
        request.setAttribute("mobilenumber", Mobilenumber);
        request.setAttribute("emergencycontactnumber", Emergencycontactnumber);
        request.setAttribute("address1", Address1);
        request.setAttribute("address2", Address2);
        request.setAttribute("bloodgroup", Bloodgroup);
        request.setAttribute("dob", DOB);
        request.setAttribute("details", Details);        
        request.setAttribute("area", Area);
        request.setAttribute("city", City);
        request.setAttribute("state", State);
        request.setAttribute("pincode", Pincode);
        request.setAttribute("password", Password);
        
          
        request.getRequestDispatcher("Update_details.jsp").include(request, response);
    } else {
       request.setAttribute("errorMessage","<center><p style=\"color:red\">Wrong Password</center>");
        request.getRequestDispatcher("Update_validate.jsp").include(request, response);
    }
        }

%>

