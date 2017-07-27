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
              <style>
            *{margin:0;padding:0;}
            #login{
                width:530px;
                margin:0 auto;
                margin-top:8px;
                margin-bottom:2%;
                transition:opacity 1s;
                -webkit-transition:opacity 1s;
            }
            .label{
                width:300px;
                background:limegreen;
                display:block;
                margin:0 auto;
                margin-top:1%;
                padding:10px;
                text-align:center;
                text-decoration:none;
                color:#fff;
                cursor:default;
                font-size: 15px;
                transition:background .3s;
                -webkit-transition:background .3s;
            }
            .lab{
                width:150px;
                background:limegreen;
                display:block;
                margin:0 auto;
                margin-top:1%;
                padding:10px;
                text-align:center;
                text-decoration:none;
                color:#fff;
                cursor:default;
                font-size: 15px;
                transition:background .3s;
                -webkit-transition:background .3s;
            }
            form{
                background:#f0f0f0;
                padding:2% 4%;
            }

            input[type="text"],input[type="password"],input[type="tel"]{
                width:92%;

                background:#fff;
                margin-bottom:4%;
                border:1px solid #ccc;
                padding:2%;
                font-family:'Open Sans',sans-serif;
                font-size:95%;
                color:#555;
                height: 40px;
            }
            input[type="text"]:focus{
                border-width: 2pt;
                border-color: #3399cc;
            }

            input[type="password"]:focus{
                border-width: 2pt;
                border-color:#3399cc;
            }
            input[type="tel"]:focus{
                border-width: 2pt;
                border-color:#3399cc;

            }

            input[type="submit"]{
                width:100%;
                background:#3399cc;
                border:0;
                padding:2%;
                font-family:'Open Sans',sans-serif;
                font-size:20px;
                color:#fff;
                cursor:pointer;
                transition:background .3s;
                -webkit-transition:background .3s;
            }
            input[type="submit"]:hover{
                background:#2288bb;    
            }

        </style>
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
                    int th_count = Integer.parseInt(request.getParameter("th_count"));
                    int pr_count = Integer.parseInt(request.getParameter("pr_count")); 
                    ses.setAttribute("academic_year", academic_year);
                    ses.setAttribute("th_count", th_count);
                    ses.setAttribute("pr_count", pr_count);
                    ses.setAttribute("year", year);
                    ses.setAttribute("branch", branch);
                    ses.setAttribute("semester", semester);

                    PreparedStatement ps = con.prepareStatement("insert into subject_details_count_coursewise(Academic_Year, Year, Branch, Semester, Theory_Count, Practical_Count) values(?, ?, ?, ?, ?, ?)");
                    ps.setString(1, academic_year);
                    ps.setString(2, year);
                    ps.setString(3, branch);
                    ps.setString(4, semester);
                    ps.setInt(5, th_count);
                    ps.setInt(6, pr_count); 

                    int check = ps.executeUpdate();
                    if (check == 0) {
                       request.setAttribute("errorMessage","Sorry..The Record is not inserted into the database...Please try again...");
                        request.getRequestDispatcher("HOD_Course_Details.jsp").include(request, response);
                    }
                    else
                    {
                    con.commit();
                   request.setAttribute("errorMessage","Course Details saved Successfully.....Proceed further to add more Records..");
                    request.getRequestDispatcher("HOD_Subject_Add_Before.jsp").include(request, response);
                    }

                } catch (Exception e) {
                    con.rollback();
                   
                    request.setAttribute("errorMessage","<font color='red'><center><b><h2>There is a slight error in the database..try again later..</h2></b></center></font>"+e);
                    request.getRequestDispatcher("HOD_Course_Details.jsp").include(request, response);
                } finally {
                    con.close();
                }
            }
        %>
    </body>
</html>
