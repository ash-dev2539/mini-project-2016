<%-- 
    Document   : Form15_SFD_Deallocate
    Created on : Sep 13, 2016, 10:35:04 PM
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
        <style>
            button {
                display: inline-block;
                -webkit-box-sizing: border-box;
                -moz-box-sizing: border-box;
                box-sizing: border-box;
                width: 300px;
                height: 60px;
                cursor: pointer;
                top: 0;
                right: 0;

                bottom: 0;
                left: 0;
                padding: 0 20px;
                overflow: hidden;
                border: none;
                -webkit-border-radius: 21px;
                border-radius: 21px;
                font: normal 20px/normal "Antic", Helvetica, sans-serif;
                color: oldlace;
                -o-text-overflow: ellipsis;
                text-overflow: ellipsis;
                background: rgba(255,140,0,0.4);
                -webkit-box-shadow: 1px 1px 2px 0 rgba(0,0,0,0.5) inset;
                box-shadow: 1px 1px 2px 0 rgba(0,0,0,0.5) inset;
                -webkit-transition: all 502ms cubic-bezier(0.68, -0.75, 0.265, 1.75);
            }

            button:hover {
                color: black;
                background: #00BFFF;
                -webkit-transition: all 1ms cubic-bezier(0.68, -0.75, 0.265, 1.75);
            }
            button:focus {
                width: 300px;
                cursor: default;
                padding: -13px 20px 0;
                color: rgba(255,255,255,1);
                -webkit-transition: all 601ms cubic-bezier(0.68, -0.75, 0.265, 1.75);
                outline:none;
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
                    String pass = request.getParameter("pass");

                    PreparedStatement ps0 = con.prepareStatement("select password from faculty_personal_details where Emp_ID=? and Password=?");
                    ps0.setInt(1, emp_id);
                    ps0.setString(2, pass);
                    ResultSet rs0 = ps0.executeQuery();
                    if (!rs0.next()) {
                        request.setAttribute("errorMessage","Sorry...Your Password does not match..Please check the details and try again....");
                        request.getRequestDispatcher("Form13_CT_Login.jsp").include(request, response);
                    } else {

                        String semester = (String) ses.getAttribute("semester");
                        String academic_year = (String) ses.getAttribute("academic_year");
                        String branch = (String) ses.getAttribute("branch");
                        String division = (String) ses.getAttribute("division");
                        String year = (String) ses.getAttribute("year");

                        PreparedStatement ps = con.prepareStatement("select Faculty_ID,Subject_Code,Muster_Name from Theory_Muster_Allocation where Academic_Year=? and Year=? and Branch=? and Division=? and Semester=? ");
                        ps.setString(1, academic_year);
                        ps.setString(2, year);
                        ps.setString(3, branch);
                        ps.setString(4, division);
                        ps.setString(5, semester);
                        ResultSet rs = ps.executeQuery();
                        PreparedStatement ps1 = con.prepareStatement("select Faculty_ID,Subject_Code,Roll_From,Roll_To,Muster_Name from Practical_Muster_Allocation where Academic_Year=? and Year=? and Branch=? and Division=? and Semester=? ");
                        ps1.setString(1, academic_year);
                        ps1.setString(2, year);
                        ps1.setString(3, branch);
                        ps1.setString(4, division);
                        ps1.setString(5, semester);
                        ResultSet rs1 = ps1.executeQuery();

                        while (rs.next()) {
                            int faculty_id = rs.getInt(1);
                            String subject_code = rs.getString(2);
                            String muster_name = rs.getString(3);
                            String table_name = faculty_id + "_" + academic_year + "_" + year + "_" + branch + "_" + division + "_" + subject_code + "_" + muster_name;
                            PreparedStatement ps3 = con.prepareStatement("drop table if exists " + table_name);
                            ps3.executeUpdate();
                            PreparedStatement ps4 = con.prepareStatement("delete from Faculty_Allocation_Subjectwise_Th where Emp_ID=? and Academic_Year=? and Year=? and Branch=? and Division=? and Semester=? ");
                            ps4.setInt(1, faculty_id);
                            ps4.setString(2, academic_year);
                            ps4.setString(3, year);
                            ps4.setString(4, branch);
                            ps4.setString(5, division);
                            ps4.setString(6, semester);
                            ps4.executeUpdate();

                            PreparedStatement ps5 = con.prepareStatement("delete from Theory_Muster_Allocation where Faculty_ID=? and Academic_Year=? and Year=? and Branch=? and Division=? and Semester=? ");
                            ps5.setInt(1, faculty_id);
                            ps5.setString(2, academic_year);
                            ps5.setString(3, year);
                            ps5.setString(4, branch);
                            ps5.setString(5, division);
                            ps5.setString(6, semester);
                            ps5.executeUpdate();
                        }
                        rs.beforeFirst();
                        while (rs1.next()) {
                            int faculty_id = rs1.getInt(1);
                            String subject_code = rs1.getString(2);
                            int roll_from = rs1.getInt(3);
                            int roll_to = rs1.getInt(4);
                            String muster_name = rs1.getString(5);
                            String table_name = faculty_id + "_" + academic_year + "_" + year + "_" + branch + "_" + division + "_" + subject_code + "_" + muster_name;
                            PreparedStatement ps2 = con.prepareStatement("drop table if exists " + table_name);
                            ps2.executeUpdate();

                            PreparedStatement ps4 = con.prepareStatement("delete from Faculty_Allocation_Subjectwise_Pr where Emp_ID=? and Academic_Year=? and Year=? and Branch=? and Division=? and Semester=? ");
                            ps4.setInt(1, faculty_id);
                            ps4.setString(2, academic_year);
                            ps4.setString(3, year);
                            ps4.setString(4, branch);
                            ps4.setString(5, division);
                            ps4.setString(6, semester);
                            ps4.executeUpdate();

                            PreparedStatement ps5 = con.prepareStatement("delete from Practical_Muster_Allocation where Faculty_ID=? and Academic_Year=? and Year=? and Branch=? and Division=? and Semester=? ");
                            ps5.setInt(1, faculty_id);
                            ps5.setString(2, academic_year);
                            ps5.setString(3, year);
                            ps5.setString(4, branch);
                            ps5.setString(5, division);
                            ps5.setString(6, semester);
                            ps5.executeUpdate();
                        }
                        String stu_table = academic_year + "_" + year + "_" + branch + "_" + semester + "_" + division + "_Muster";
                        PreparedStatement ps6 = con.prepareStatement("drop  table " + stu_table);
                        ps6.executeUpdate();

                        request.setAttribute("errorMessage","<font color='green'><center><h2>Attendance Records and Faculties has been successfully deallocated<br>Now you can allocate the subject faculties</h2></center></font>");
                        request.getRequestDispatcher("Form13_CT_Login.jsp").include(request, response);
                    }

                } catch (Exception e) {
                   
                    con.rollback();
                    request.setAttribute("errorMessage","<font color='red'><center><b><h2>There is nothing to be fetched from database for you...Please Contact the Administrator...</h2></b></center></font>"+e);
                    request.getRequestDispatcher("Form13_CT_Login.jsp").include(request, response);

                } finally {
                    con.close();
                }
            }
        %>
    </body>
</html>
