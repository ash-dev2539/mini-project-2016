<%-- 
    Document   : Form28_AES_Save
    Created on : Sep 12, 2016, 11:54:08 AM
    Author     : Administrator
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
    </head>
    <body>
        <%
            HttpSession ses = request.getSession(false);
            if (ses.getAttribute("empid") == null || ses.getAttribute("empid").equals("")) {
                request.setAttribute("errorMessage","<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
                request.getRequestDispatcher("Login.jsp").include(request, response);
            } else {

                Connection con = DBconnection.dbconnection.createConnection();
                //con.setAutoCommit(false);
                try {
                    int emp_id = (Integer) ses.getAttribute("empid");
                    String academic_year = (String) ses.getAttribute("academic_year");

                    String semester = (String) ses.getAttribute("semester");
                    String year = (String) ses.getAttribute("year");
                    String branch = (String) ses.getAttribute("branch");
                    String division = (String) ses.getAttribute("division");
                    int student_count = (Integer) ses.getAttribute("student_count");
                    int max_batch = (Integer) ses.getAttribute("max_batch");
                    PreparedStatement ps1 = con.prepareStatement("select Faculty_ID,Subject_Code,Muster_Name from Theory_Muster_Allocation where Academic_Year=? and Year=? and Branch=? and Semester=? and Division=?");
                    ps1.setString(1, academic_year);
                    ps1.setString(2, year);
                    ps1.setString(3, branch);
                    ps1.setString(4, semester);
                    ps1.setString(5, division);
                    ResultSet rs1 = ps1.executeQuery();

                    PreparedStatement ps2 = con.prepareStatement("select Faculty_ID,Subject_Code,Roll_From,Roll_To,Muster_Name from Practical_Muster_Allocation where Academic_Year=? and Year=? and Branch=? and Semester=? and Division=? and Batch_No=?");
                    ps2.setString(1, academic_year);
                    ps2.setString(2, year);
                    ps2.setString(3, branch);
                    ps2.setString(4, semester);
                    ps2.setString(5, division);
                    ps2.setInt(6, max_batch);
                    ResultSet rs2 = ps2.executeQuery();

                    PreparedStatement ps4 = con.prepareStatement("select max(Roll_To) from Practical_Muster_Allocation where Academic_Year=? and Year=? and Branch=? and Semester=? and Division=? and Batch_No=?");
                    ps4.setString(1, academic_year);
                    ps4.setString(2, year);
                    ps4.setString(3, branch);
                    ps4.setString(4, semester);
                    ps4.setString(5, division);
                    ps4.setInt(6, max_batch);
                    ResultSet rs4 = ps4.executeQuery();
                    rs4.next();
                    int max_roll_to = rs4.getInt(1);
                    int max_roll = max_roll_to;
                    ses.setAttribute("max_roll_to", max_roll_to);
                    for (int i = 0; i < student_count; i++) {
                        String student_id = request.getParameter("student_id_" + i);
                        String student_name = request.getParameter("student_name_" + i);
                        ++max_roll_to;
                        while (rs1.next()) {
                            int faculty_id = rs1.getInt(1);
                            String subject_code = rs1.getString(2);
                            String muster_name = rs1.getString(3);

                            String table_name = faculty_id + "_" + academic_year + "_" + year + "_" + branch + "_" + division + "_" + subject_code + "_" + muster_name;
                            PreparedStatement ps3 = con.prepareStatement("insert into " + table_name + "(Student_Roll_No,Student_ID,Student_Name) values(?,?,?) ");
                            ps3.setInt(1, max_roll_to);
                            ps3.setString(2, student_id);
                            ps3.setString(3, student_name);
                            ps3.executeUpdate();

                        }
                        rs1.beforeFirst();
                        String table = academic_year + "_" + year + "_" + branch + "_" + semester + "_" + division + "_Muster";
                        PreparedStatement ps5 = con.prepareStatement("insert into " + table + "(Student_Roll_No,Student_ID,Student_Name) values(?,?,?) ");
                        ps5.setInt(1, max_roll_to);
                        ps5.setString(2, student_id);
                        ps5.setString(3, student_name);
                        ps5.executeUpdate();
                    }

                    for (int i = 0; i < student_count; i++) {
                        String student_id = request.getParameter("student_id_" + i);
                        String student_name = request.getParameter("student_name_" + i);
                        ++max_roll;
                        while (rs2.next()) {
                            int faculty_id = rs2.getInt(1);
                            String subject_code = rs2.getString(2);
                            int roll_from = rs2.getInt(3);
                            int roll_to = rs2.getInt(4);
                            String muster_name = rs2.getString(5);

                            String table_name = faculty_id + "_" + academic_year + "_" + year + "_" + branch + "_" + division + "_" + subject_code + "_" + muster_name;
                            PreparedStatement ps3 = con.prepareStatement("insert into " + table_name + "(Student_Roll_No,Student_ID,Student_Name) values(?,?,?) ");
                            ps3.setInt(1, max_roll);
                            ps3.setString(2, student_id);
                            ps3.setString(3, student_name);
                            ps3.executeUpdate();

                        }
                        rs2.beforeFirst();

                    }

                    while (rs2.next()) {
                        int faculty_id = rs2.getInt(1);                                       

                        PreparedStatement ps6 = con.prepareStatement("Update Practical_Muster_Allocation set Roll_To=? where Faculty_ID=? and Academic_Year=? and Year=? and Branch=? and Semester=? and Division=? and Batch_No=? ");
                        ps6.setInt(1, max_roll);
                        ps6.setInt(2, faculty_id);
                        ps6.setString(3, academic_year);
                        ps6.setString(4, year);
                        ps6.setString(5, branch);
                        ps6.setString(6, semester);
                        ps6.setString(7, division);
                        ps6.setInt(8, max_batch);
                        ps6.executeUpdate();

                        PreparedStatement ps7 = con.prepareStatement("Update Faculty_Allocation_Subjectwise_Pr set Roll_To=? where Emp_ID=? and Academic_Year=? and Year=? and Branch=? and Semester=? and Division=? and Batch_No=? ");
                        ps7.setInt(1, max_roll);
                        ps7.setInt(2, faculty_id);
                        ps7.setString(3, academic_year);
                        ps7.setString(4, year);
                        ps7.setString(5, branch);
                        ps7.setString(6, semester);
                        ps7.setString(7, division);
                        ps7.setInt(8, max_batch);
                        ps7.executeUpdate();

                    }
                    //con.commit();
                    request.setAttribute("errorMessage","<center><font color='green'><h2>Student Added Successfully!!!</h2></center>");
                    request.getRequestDispatcher("Form13_CT_Login.jsp").include(request, response);

                } catch (Exception e) {
                    // con.rollback();
                    out.println(e);
                    request.setAttribute("errorMessage","<font color='red'><center><b><h2>There is nothing to be fetched from database for you...Please Contact the Administrator...</h2></b></center></font>");
                    request.getRequestDispatcher("Form13_CT_Login.jsp").include(request, response);
                } finally {
                    con.close();
                }

            }


        %>
    </body>
</html>
