
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.*" %>
<%@page import="DBconnection.dbconnection" %>
<%
    int emp_id = Integer.parseInt(request.getParameter("emp_id"));

    Connection con = DBconnection.dbconnection.createConnection();

    PreparedStatement stmt = con.prepareStatement("select * from Faculty_Personal_Details where Emp_ID=?");
    stmt.setInt(1, emp_id);
    ResultSet rs = stmt.executeQuery();
    if (rs.next()) {

        request.setAttribute("errorMessage", "Faculty Already Signed up! Please Log in to continue");
        request.getRequestDispatcher("Login.jsp").include(request, response);
        con.close();
    } else {
        PreparedStatement stmtp = con.prepareStatement("select * from Faculty_Details where Faculty_ID=?");
        stmtp.setInt(1, emp_id);
        ResultSet rsm = stmtp.executeQuery();
        if (rsm.next()) {
            int Emp_ID = rsm.getInt("Faculty_ID");
            String Faculty_Name = rsm.getString("Faculty_Name");
            String Email_ID = rsm.getString("Email_ID");

            String[] parray = Faculty_Name.split(" ");
            request.setAttribute("emp_id", Emp_ID);
            request.setAttribute("fname", parray[0]);
            request.setAttribute("lname", parray[1]);
            request.setAttribute("email_id", Email_ID);
            request.getRequestDispatcher("Signup.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "<center><p style=\"color:yellow\" >Invalid Faculty_ID</p></center>");
            request.getRequestDispatcher("Login.jsp").include(request, response);

        }
    }

%>
