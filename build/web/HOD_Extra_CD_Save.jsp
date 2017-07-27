<%-- 
    Document   : Form15_SFD_Save
    Created on : Sep 4, 2016, 1:19:48 AM
    Author     : sandeep
--%>

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
                    int ex_th_count = Integer.parseInt(request.getParameter("ex_th_count"));
                    int ex_pr_count = Integer.parseInt(request.getParameter("ex_pr_count"));
                    int ex_total_count=ex_th_count+ex_pr_count;
                    ses.setAttribute("extra_total_count", ex_total_count);
                     ses.setAttribute("ex_th_count", ex_th_count);
                      ses.setAttribute("ex_pr_count", ex_pr_count);
                    ses.setAttribute("year", year);
                    ses.setAttribute("branch", branch);
                    ses.setAttribute("semester", semester);

                    PreparedStatement ps = con.prepareStatement("update subject_details_count_coursewise set Extra_Theory_Count=? , Extra_Practical_Count=? where Academic_Year=? and Year=? and Branch=? and Semester=? ");
                   
                    ps.setInt(1, ex_th_count);
                    ps.setInt(2, ex_pr_count);
                    ps.setString(3, academic_year);
                    ps.setString(4, year);
                    ps.setString(5, branch);
                    ps.setString(6, semester);

                    int check = ps.executeUpdate();
                    if (check == 0) {
                        request.setAttribute("errorMessage","Sorry..The Record is not inserted into the database...Please try again...");
                        request.getRequestDispatcher("HOD_Extra_CD.jsp").include(request, response);
                    }
                    else
                    {
                    con.commit();
                  request.setAttribute("errorMessage","Course Details saved Successfully.....Proceed further to add more Records..");
                    request.getRequestDispatcher("HOD_Extra_SAB.jsp").include(request, response);
                    }

                } catch (Exception e) {
                    con.rollback();
                    out.println(e);
                   request.setAttribute("errorMessage","<font color='red'><center><b><h2>There is a slight error in the database..try again later..</h2></b></center></font>");
                    request.getRequestDispatcher("HOD_Extra_CD.jsp").include(request, response);
                } finally {
                    con.close();
                }
            }
        %>
    </body>
</html>
