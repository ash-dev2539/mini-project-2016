<%-- 
    Document   : Form27_WM_Clear
    Created on : Sep 11, 2016, 9:40:03 PM
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
    </head>
    <body>
        <%
            HttpSession ses = request.getSession(false);
            if (ses.getAttribute("empid") == null || (Integer) ses.getAttribute("empid") == null) {
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
                request.getRequestDispatcher("Login.jsp").include(request, response);
            } else {

                Connection con = DBconnection.dbconnection.createConnection();
                con.setAutoCommit(false);
                try {
                    int emp_id = (Integer) ses.getAttribute("empid");

                    PreparedStatement ps5 = con.prepareStatement("select Password from Faculty_Personal_Details where Emp_ID=? ");
                    ps5.setInt(1, emp_id);
                    ResultSet rs5 = ps5.executeQuery();
                    if (rs5.next()) {
                        String pass = rs5.getString(1);
                        if (pass.equals(request.getParameter("pass"))) {
                            String semester = (String) ses.getAttribute("semester");
                            String academic_year = (String) ses.getAttribute("academic_year");
                            PreparedStatement ps6 = con.prepareStatement("select Branch,Division,Year from Class_Teacher_Details where Emp_ID=? ");
                            ps6.setInt(1, emp_id);
                            ResultSet rs6 = ps6.executeQuery();
                            rs6.next();
                            String branch = rs6.getString(1);
                            String division = rs6.getString(2);
                            String year = rs6.getString(3);

                            PreparedStatement ps = con.prepareStatement("select Faculty_ID,Subject_Code,Muster_Name from Theory_Muster_Allocation where Academic_Year=? and Year=? and Branch=? and Semester=? and Division=? ");
                            ps.setString(1, academic_year);
                            ps.setString(2, year);
                            ps.setString(3, branch);
                            ps.setString(4, semester);
                            ps.setString(5, division);
                            ResultSet rs = ps.executeQuery();
                            PreparedStatement ps1 = con.prepareStatement("select Faculty_ID,Subject_Code,Roll_From,Roll_To,Muster_Name from Practical_Muster_Allocation where Academic_Year=? and Year=? and Branch=? and Semester=? and Division=? ");
                            ps1.setString(1, academic_year);
                            ps1.setString(2, year);
                            ps1.setString(3, branch);
                            ps1.setString(4, semester);
                            ps1.setString(5, division);
                            ResultSet rs1 = ps1.executeQuery();
                            if (rs.next() && rs1.next()) {
                                rs.beforeFirst();
                                rs1.beforeFirst();
                                String student_attendance = academic_year + "_" + year + "_" + branch + "_" + semester + "_" + division + "_Muster";
                                PreparedStatement ps4 = con.prepareStatement("delete from " + student_attendance);
                                ps4.executeUpdate();

                                while (rs.next()) {
                                    int faculty_id = rs.getInt(1);
                                    String subject_code = rs.getString(2);
                                    String muster_name = rs.getString(3);
                                    String table_name = faculty_id + "_" + academic_year + "_" + year + "_" + branch + "_" + division + "_" + subject_code + "_" + muster_name;
                                    PreparedStatement ps2 = con.prepareStatement("drop table " + table_name);
                                    ps2.executeUpdate();
                                    PreparedStatement ps3 = con.prepareStatement("create table " + table_name + "(Student_Roll_No int(5),Student_ID varchar(15),Student_Name varchar(50),FMA_Count int(3) default 0,FM_Lecture_Count int(2) default 0,SMA_Count int(3) default 0,SM_Lecture_Count int(2) default 0,TMA_Count int(3) default 0,TM_Lecture_Count int(2) default 0,FOMA_Count int(3) default 0,FOM_Lecture_Count int(2) default 0,Total_Lecture_Count int(3) default 0,primary key(Student_ID)) ");
                                    ps3.executeUpdate();

                                }

                                while (rs1.next()) {
                                    int faculty_id = rs1.getInt(1);
                                    String subject_code = rs1.getString(2);
                                    int roll_from = rs1.getInt(3);
                                    int roll_to = rs1.getInt(4);
                                    String muster_name = rs1.getString(5);
                                    String table_name = faculty_id + "_" + academic_year + "_" + year + "_" + branch + "_" + division + "_" + subject_code + "_" + muster_name;
                                    PreparedStatement ps3 = con.prepareStatement("drop table " + table_name);
                                    ps3.executeUpdate();                                    
                                    PreparedStatement ps10 = con.prepareStatement("create table " + table_name + "(Student_Roll_No int(5),Student_ID varchar(15),Student_Name varchar(50),FMA_Count int(3) default 0,FM_Practical_Count int(2) default 0,SMA_Count int(3) default 0,SM_Practical_Count int(2) default 0,TMA_Count int(3) default 0,TM_Practical_Count int(2) default 0,FOMA_Count int(3) default 0,FOM_Practical_Count int(2) default 0,Total_Lecture_Count int(3) default 0,primary key(Student_ID)) ");
                                    ps10.executeUpdate();

                                }
                                out.println("<div align=\"center\"><button onclick='window.location.href=\"Form16_UM.jsp\"'>Upload Xlsx</button></div>");
                                request.setAttribute("errorMessage", "<font color='green'><center><b><h2>Attendance Records Deleted Successfully...Please Upload again if required</h2></b></center></font>");
                                request.getRequestDispatcher("Form13_CT_Login.jsp").include(request, response);

                            } else {
                                request.setAttribute("errorMessage", "<font color='red'><center><h2>Subject Faculty Not Assigned Yet<br>Enter Subject Faculty First...</h2></center></font>");
                                request.getRequestDispatcher("Form13_CT_Login.jsp").include(request, response);
                            }
                        } else {
                            request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Wrong Password!!!!!<br>Try again...</h2></b></center></font>");
                            request.getRequestDispatcher("Form13_CT_Login.jsp").include(request, response);

                        }
                    }
                    con.commit();
                } catch (Exception e) {
                    con.rollback();
                    request.setAttribute("errorMessage", "<font color='red'><center><b><h2>There is nothing to be fetched from database for you...Please Contact the Administrator...</h2></b></center></font>");
                    request.getRequestDispatcher("Form13_CT_Login.jsp").include(request, response);
                } finally {
                    con.close();
                }

            }

        %>
    </body>
</html>
