<%-- 
    Document   : Month_Entry_Save
    Created on : Oct 12, 2016, 12:42:14 PM
    Author     : Administrator
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
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
            } else {
                int month1 = Integer.parseInt(request.getParameter("month1"));
                int month2 = Integer.parseInt(request.getParameter("month2"));
                int month3 = Integer.parseInt(request.getParameter("month3"));
                int month4 = Integer.parseInt(request.getParameter("month4"));
                String academic_year = (String) ses.getAttribute("academic_year");
                String semester = (String) ses.getAttribute("semester");
                String year = (String) ses.getAttribute("year");
                String branch = (String) ses.getAttribute("branch");
                String division = (String) ses.getAttribute("division");

                Connection con = DBconnection.dbconnection.createConnection();                
                try {
                PreparedStatement ps = con.prepareStatement("insert into Month_Entry values(?,?,?,?,?,?,?,?,?)");
                ps.setString(1, academic_year);
                ps.setString(2, year);
                ps.setString(3, branch);
                ps.setString(4, semester);
                ps.setString(5, division);
                ps.setInt(6, month1);
                ps.setInt(7, month2);
                ps.setInt(8, month3);
                ps.setInt(9, month4);
                int check=ps.executeUpdate();
                if(check!=0)
                {
                    request.setAttribute("errorMessage", "<font color='green'><center><b><h2>Record inserted successfully....</h2></b></center></font>");
                    request.getRequestDispatcher("Form13_CT_Login.jsp").include(request, response);
                } 
                }catch(Exception e)
                {
                     request.setAttribute("errorMessage", "<font color='red'><b><h2>Record Already Exists...</h2></b></font>");
                    request.getRequestDispatcher("Month_Entry.jsp").include(request, response);
                } finally {
                    con.close();
                }
            }
        %>
    </body>
</html>
