<%@page import="DBconnection.dbconnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="false"%>
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
            } else {

                Connection con = dbconnection.createConnection();
                con.setAutoCommit(false);
                try {

                    String academic_year = request.getParameter("academic_year");
                    String year = request.getParameter("year");
                    String branch = request.getParameter("branch");
                    String semester = request.getParameter("semester");
                    String division = request.getParameter("division");
                    String pa = request.getParameter("faculty_ID");
                    String[] parray = pa.split(" - ");
                    String faculty_name=parray[0];
                    int faculty_ID = Integer.parseInt(parray[1]);                    
                   
                    PreparedStatement ps = con.prepareStatement("insert into Class_Teacher_Details values(?, ?, ?, ?, ?, ?, ?)");
                    ps.setInt(1, faculty_ID);
                    ps.setString(2, faculty_name);
                    ps.setString(3, academic_year);
                    ps.setString(4, year);
                    ps.setString(5, branch);
                    ps.setString(6, division);
                    ps.setString(7, semester);
                    
                    int check = ps.executeUpdate();
                    if (check == 0) {
                        request.setAttribute("errorMessage","Sorry..The Record already exists the database...Please try again...");
                        request.getRequestDispatcher("HOD_CT_Assign.jsp").include(request, response);
                    }
                    else
                    {
                    con.commit();
                    request.setAttribute("errorMessage","Class Teacher Allocated Successfully.....Proceed further to add more Records..");
                    request.getRequestDispatcher("HOD_CT_Assign.jsp").include(request, response);
                    }

                } catch (Exception e) {
                    con.rollback();
                    
                    request.setAttribute("errorMessage","<font color='red'><center><b><h2>There is a slight error in the database..try again later..</h2></b></center></font>"+e);
                    request.getRequestDispatcher("HOD_Profile.jsp").include(request, response);
                } finally {
                    con.close();
                }
            }
        %>
    </body>
</html>
