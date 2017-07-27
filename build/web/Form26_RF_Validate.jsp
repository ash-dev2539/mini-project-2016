<%-- 
    Document   : Form26_RF_Validate
    Created on : Sep 11, 2016, 1:17:52 PM
    Author     : sandeep
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="cool.css" rel="stylesheet">
        <style>
            *{margin:0;padding:0;}
            #login{
                width:1250px;
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
        <br><br><br><br>
        <%
            HttpSession ses = request.getSession(false);
            if (ses.getAttribute("empid") == null || ses.getAttribute("empid").equals("")) {
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
                request.getRequestDispatcher("Login.jsp").include(request, response);
            } else {

                Connection con = DBconnection.dbconnection.createConnection();
                con.setAutoCommit(false);
                try {

                    String old_name = "";
                    String new_name = "";
                    int emp_id = (Integer) ses.getAttribute("empid");
                    int old_faculty_id = (Integer) ses.getAttribute("old_faculty_id");
                    int new_faculty_id = (Integer) ses.getAttribute("new_faculty_id");
                    String semester = (String) ses.getAttribute("semester");

                    String subject_name = request.getParameter("subject_name");
                    ses.setAttribute("subject_name", subject_name);
                    String academic_year = (String) ses.getAttribute("academic_year");
                    String branch = (String) ses.getAttribute("branch");
                    String division = (String) ses.getAttribute("division");
                    String year = (String) ses.getAttribute("year");
                    String type = (String) ses.getAttribute("type");
                    PreparedStatement ps = con.prepareStatement("select * from Faculty_Details where Faculty_ID=? ");
                    ps.setInt(1, old_faculty_id);
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) {
                        PreparedStatement ps2 = con.prepareStatement("select * from Faculty_Details where Faculty_ID=? ");
                        ps2.setInt(1, new_faculty_id);
                        ResultSet rs2 = ps2.executeQuery();
                        if (rs2.next()) {
                            PreparedStatement ps1 = con.prepareStatement("select Fname, Lname from Faculty_Personal_Details where Emp_ID=? ");
                            ps1.setInt(1, old_faculty_id);
                            ResultSet rs1 = ps1.executeQuery();
                            PreparedStatement ps3 = con.prepareStatement("select Fname, Lname from Faculty_Personal_Details where Emp_ID=? ");
                            ps3.setInt(1, new_faculty_id);
                            ResultSet rs3 = ps3.executeQuery();
                            if (rs1.next() && rs3.next()) {
                                if (type.equals("Theory")) {
                                    PreparedStatement ps4 = con.prepareStatement("select Faculty_Name, Subject_Code from faculty_Allocation_Subjectwise_Th where Emp_ID=? and Academic_Year=? and Branch=? and Division=? and Semester=? and Year=? and Subject_Name=?");
                                    ps4.setInt(1, old_faculty_id);
                                    ps4.setString(2, academic_year);
                                    ps4.setString(3, branch);
                                    ps4.setString(4, division);
                                    ps4.setString(5, semester);
                                    ps4.setString(6, year);
                                    ps4.setString(7, subject_name);
                                    ResultSet rs4 = ps4.executeQuery();
                                    if (rs4.next()) {
                                        old_name = rs1.getString(1) + " " + rs1.getString(2);
                                        new_name = rs3.getString(1) + " " + rs3.getString(2);
        %>
        


        <div id="login">


            <h1>Replacing The Faculty</h1>

            <form action="Form26_RF_Change.jsp" method="get">

                <table>
                    <thead  class="hi" style="font-size: 20px;width: 50px;height: 50px">
                    <th>
                        Change Faculty
                    </th>
                    <th>To</th>
                    <th>Below Faculty</th>
                    <th>For</th>
                    <th>In</th>
                    </thead>
                    <tr>
                        <td>
                            <input style="width: 300px" type="text" name="old_name" value="<%=old_name%>" readonly>
                        </td>
                        <td></td>
                        <td>
                            <input style="width: 300px" type="text" name="new_name" value="<%=new_name%>" readonly>
                        </td>
                        <td><input style="width: 180px" type="text" value="<%=subject_name%>" readonly></td>
                        <td>
                            <input style="width: 150px" type="text" value="<%=type%>" readonly>
                        </td>
                    </tr>


                </table>

                <input type="submit" value="Replace">

            </form>

        </div>

        <div align="center">

            <button onclick="window.location.href = 'Form26_RF.jsp'">Go Back</button>

        </div>
        <% } else {
                request.setAttribute("errorMessage", "<font color='red'><center><h2>Sorry The old Theory Faculty is not assigned to " + subject_name + " yet!!</h2></center></font>");
                request.getRequestDispatcher("Form26_RF.jsp").include(request, response);
            }
        } else if (type.equals("Practical")) {
            PreparedStatement ps5 = con.prepareStatement("select Faculty_Name from faculty_Allocation_Subjectwise_Pr where Emp_ID=? and Academic_Year=? and Branch=? and Division=? and Semester=? and Year=? and Prac_Subject_Name=?");
            ps5.setInt(1, old_faculty_id);
            ps5.setString(2, academic_year);
            ps5.setString(3, branch);
            ps5.setString(4, division);
            ps5.setString(5, semester);
            ps5.setString(6, year);
            ps5.setString(7, subject_name);
            ResultSet rs5 = ps5.executeQuery();
            if (rs5.next()) {

                old_name = rs1.getString(1) + " " + rs1.getString(2);
                new_name = rs3.getString(1) + " " + rs3.getString(2);
        %>
        <div id="login">


            <h1>Replacing The Faculty</h1>

            <form action="Form26_RF_Change.jsp" method="get">

                <table>
                   <thead  class="hi" style="font-size: 20px;width: 50px;height: 50px">
                    <th>
                        Change Faculty
                    </th>
                    <th>To</th>
                    <th>Below Faculty</th>
                    <th>For</th>
                    <th>In</th>
                    </thead>
                    <tr>
                        <td>
                            <input style="width: 300px" type="text" name="old_name" value="<%=old_name%>" readonly>
                        </td>
                        <td></td>
                        <td>
                            <input style="width: 300px" type="text" name="new_name" value="<%=new_name%>" readonly>
                        </td>
                        <td><input style="width: 180px" type="text" value="<%=subject_name%>" readonly></td>
                        <td>
                            <input style="width: 150px" type="text" value="<%=type%>" readonly>
                        </td>
                    </tr>


                </table>

                <input type="submit" value="Replace">

            </form>

        </div>


        <div align="center">

            <button style="color: white" onclick="window.location.href = 'Form26_RF.jsp'">Go Back</button>

        </div>
        <% } else {
                                        request.setAttribute("errorMessage", "<font color='red'><center><h2>Sorry The Old PR Faculty is not assigned to " + subject_name + " yet!!</h2></center></font>");
                                        request.getRequestDispatcher("Form26_RF.jsp").include(request, response);
                                    }
                                }

                            } else {
                                request.setAttribute("errorMessage", "<font color='red'><center><h2>Sorry Either of faculty has not signed Up yet<br>please inform the Faculty</h2></center></font>");
                                request.getRequestDispatcher("Form26_RF.jsp").include(request, response);
                            }

                        } else {
                            request.setAttribute("errorMessage", "<font color='red'><center><h2>Sorry such faculty in Text-Field 2 does not exist<br>please contact the Admin</h2></center></font>");
                            request.getRequestDispatcher("Form26_RF.jsp").include(request, response);

                        }
                    } else {
                        request.setAttribute("errorMessage", "<font color='red'><center><h2>Sorry such faculty in Text-Field 1 does not exist<br>please contact the Admin</h2></center></font>");
                        request.getRequestDispatcher("Form26_RF.jsp").include(request, response);
                    }
                    con.commit();
                } catch (Exception e) {
                    con.rollback();
                    request.setAttribute("errorMessage", "<font color='red'><center><b><h2>There is nothing to be fetched from database for you...Please Contact the Administrator...</h2></b></center></font>" + e);
                    request.getRequestDispatcher("Form26_RF.jsp").include(request, response);
                } finally {
                    con.close();
                }

            }

        %>       
    </body>
</html>
