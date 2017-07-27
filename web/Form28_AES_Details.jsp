<%-- 
    Document   : Form28_AES
    Created on : Sep 11, 2016, 11:25:32 PM
    Author     : sandeep
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="cool.css" rel="stylesheet">
              <style>
            *{margin:0;padding:0;}
            #login{
                width:650px;
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
                width:550px;
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
                Connection con = DBconnection.dbconnection.createConnection();
                con.setAutoCommit(false);
                try {
                    int emp_id = (Integer) ses.getAttribute("empid");
                    String academic_year = (String) ses.getAttribute("academic_year");
                    String semester = (String) ses.getAttribute("semester");
                    String year = (String) ses.getAttribute("year");
                    String branch = (String) ses.getAttribute("branch");
                    String division = (String) ses.getAttribute("division");
                    int student_count = Integer.parseInt(request.getParameter("student_count"));
                    ses.setAttribute("student_count", student_count);

                    PreparedStatement ps = con.prepareStatement("select max(Batch_No) from Faculty_Allocation_Subjectwise_Pr where Academic_Year=? and Year=? and Branch=? and Semester=? and Division=?");
                    ps.setString(1, academic_year);
                    ps.setString(2, year);
                    ps.setString(3, branch);
                    ps.setString(4, semester);
                    ps.setString(5, division);
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) {
                        int max_batch = rs.getInt(1);
                        ses.setAttribute("max_batch", max_batch);

                    } else {
                        response.sendRedirect("Form13_CT_Login.jsp");

                    }
                    con.commit();

        %>
       


        <div id="login">
            

            <h1>Student Details</h1>

           <form action="Form28_AES_Save.jsp" method="post">

            <table align="center">
                <thead class="hi" style="font-size: 20px;height: 50px">
                <th>Student-Number  
                </th>
                <th>Student-ID</th>
                <th>Student-Name</th>
                </thead>
                <%                    for (int i = 0; i < student_count; i++) {
                %>
                <tr>

                    <td class="label" style="font-size: 20px;width: 100px">
                        Student <%=i + 1%>
                    </td>
                    <td>
                        <input type="text" style="width:  100px;height: 40px" name="student_id_<%=i%>" required>
                    </td>
                    <td>
                        <input type="text" style="width:  300px;height: 40px" name="student_name_<%=i%>" required>
                    </td>


                </tr>
                <%
                    }
                %>

            </table>

                 <input type="submit" value="OK:)">

            </form>

        </div>
        
        <div align="center">
            <button style="color: white" onclick="window.location.href = 'Form13_CT_Login.jsp'">Back</button>
        </div>
        <%
                } catch (Exception e) {
                    con.rollback();
                   request.setAttribute("errorMessage","<font color='red'><center><b><h2>There is nothing to be fetched from database for you...Please Contact the Administrator...</h2></b></center></font>");
                    request.getRequestDispatcher("Form13_CT_Login.jsp").include(request, response);
                } finally {
                    con.close();
                }
            }
        %>
    </body>
</html>
