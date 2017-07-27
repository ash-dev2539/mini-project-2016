<%-- 
    Document   : Form15_SFD_Save
    Created on : Sep 4, 2016, 1:19:48 AM
    Author     : sandeep
--%>

<%@page import="java.sql.SQLException"%>
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
            }
            else
            {

            Connection con = dbconnection.createConnection();
            //con.setAutoCommit(false);
            try {
                String subject_type = (String) ses.getAttribute("subject_type");
                String year = (String) ses.getAttribute("year");
                String branch = (String) ses.getAttribute("branch");
                String division = (String) ses.getAttribute("division");
                String academic_year = (String) ses.getAttribute("academic_year");
                String semester = (String) ses.getAttribute("semester");
                String subject_code;
                String student_id;
                String student_name;
                int student_roll = 0;
                int faculty_id = 0;               

                if (subject_type.equals("Theory")) {
                    String subject_name = request.getParameter("subject_name");
                    String pa = request.getParameter("faculty_name");
                    String[] parray = pa.split(" -");
                    String faculty_name = parray[0];
                    String tablename = academic_year + "_" + year + "_" + branch + "_Sem" + semester + "_Th_Pr_Extra";
                    PreparedStatement ps = con.prepareStatement("select Subject_Code from " + tablename + " where Subject_Name=?");
                    ps.setString(1, subject_name);
                    ResultSet rs = ps.executeQuery();

                    PreparedStatement ps1 = con.prepareStatement("select Faculty_ID from Faculty_Details where Faculty_Name=?");
                    ps1.setString(1, faculty_name);
                    ResultSet rs1 = ps1.executeQuery();

                    if (rs.next() && rs1.next()) {
                        subject_code = rs.getString(1);
                        faculty_id = rs1.getInt(1);
                        String muster = "Th_" + subject_name + "_" + year + "_" + division + "_Sem_" + semester;
                        String muster_table = faculty_id + "_" + academic_year + "_" + year + "_" + branch + "_" + division + "_" + subject_code + "_" + muster;
                        PreparedStatement ps4 = con.prepareStatement("create table if not exists" + muster_table + "(Student_Roll_No int(5),Student_ID varchar(15),Student_Name varchar(50),FMA_Count int(3) default 0,FM_Lecture_Count int(2) default 0,SMA_Count int(3) default 0,SMA_Lecture_Count int(2) default 0,TMA_Count int(3) default 0,TMA_Lecture_Count int(2) default 0,FOMA_Count int(3) default 0,FOMA_Lecture_Count int(2) default 0,primary key(Student_ID)) ");
                        ps4.execute();
                        String stu_table = academic_year + "_" + year + "_" + branch + "_" + semester + "_" + division + "_Muster";
                        PreparedStatement ps5 = con.prepareStatement("alter table " + stu_table + " add column " + subject_name + "_" + subject_code + "_Attendance int(4) default 0 ");
                        ps5.executeUpdate();

                        PreparedStatement ps6 = con.prepareStatement("select Student_Roll_No,Student_ID,Student_Name from " + stu_table);

                        ResultSet rs6 = ps6.executeQuery();

                        while (rs6.next()) {

                            student_roll = rs6.getInt(1);
                            student_id = rs6.getString(2);
                            student_name = rs6.getString(3);
                            PreparedStatement ps7 = con.prepareStatement("insert into " + muster_table + "(Student_Roll_No,Student_ID,Student_Name) values(?,?,?)");
                            ps7.setInt(1, student_roll);
                            ps7.setString(2, student_id);
                            ps7.setString(3, student_name);
                            ps7.executeUpdate();
                        }
                        
                        PreparedStatement ps2 = con.prepareStatement("insert into Faculty_Allocation_Subjectwise_Th values(?,?,?,?,?,?,?,?,?)");
                        ps2.setString(1, academic_year);
                        ps2.setString(2, year);
                        ps2.setString(3, branch);
                        ps2.setString(4, division);
                        ps2.setString(5, semester);
                        ps2.setString(6, subject_name);
                        ps2.setString(7, subject_code);
                        ps2.setString(8, faculty_name);
                        ps2.setInt(9, faculty_id);
                        ps2.executeUpdate();

                        PreparedStatement ps3 = con.prepareStatement("insert into Theory_Muster_Allocation values(?,?,?,?,?,?,?,?,?,?)");
                        ps3.setInt(1, faculty_id);
                        ps3.setString(2, faculty_name);
                        ps3.setString(3, academic_year);
                        ps3.setString(4, year);
                        ps3.setString(5, branch);
                        ps3.setString(6, semester);
                        ps3.setString(7, division);
                        ps3.setString(8, subject_name);
                        ps3.setString(9, subject_code);
                        ps3.setString(10, muster);
                        ps3.executeUpdate();

                    }

                } else if(subject_type.equals("Practical"))
                {
                    int batches = (Integer) ses.getAttribute("batches");
                    int roll = 1;
                    String subject_name = request.getParameter("subject_name");
                    String pa = request.getParameter("faculty_name");
                    String[] parray = pa.split(" -");
                    String faculty_name = parray[0];
                    String tablename = academic_year + "_" + year + "_" + branch + "_Sem" + semester + "_Th_Pr_Extra";
                    
                    PreparedStatement ps = con.prepareStatement("select Subject_Code from " + tablename + " where Subject_Name=?");
                    ps.setString(1, subject_name);
                    ResultSet rs = ps.executeQuery();
                    
                    PreparedStatement ps1 = con.prepareStatement("select Faculty_ID from Faculty_Details where Faculty_Name=?");
                    ps1.setString(1, faculty_name);
                    ResultSet rs1 = ps1.executeQuery();
                    
                    if (rs.next() && rs1.next()) {
                        subject_code = rs.getString(1);
                        faculty_id = rs1.getInt(1);

                        for (int i = 0; i < batches; i++) {
                            String muster = "Pr_" + subject_name + "_" + year + "_" + division + "_Batch_" + (i + 1) + "_Sem_" + semester;
                            int roll_from = Integer.parseInt(request.getParameter("roll_from_" + i));
                            int roll_to = Integer.parseInt(request.getParameter("roll_to_" + i));
                            String muster_table = faculty_id + "_" + academic_year + "_" + year + "_" + branch + "_" + division + "_" + subject_code + "_" + roll_from + "_" + roll_to + "_" + muster;
                            PreparedStatement ps4 = con.prepareStatement("create table if not exists" + muster_table + "(Student_Roll_No int(5),Student_ID varchar(15),Student_Name varchar(50),FMA_Count int(3) default 0,FM_Lecture_Count int(2) default 0,SMA_Count int(3) default 0,SMA_Lecture_Count int(2) default 0,TMA_Count int(3) default 0,TMA_Lecture_Count int(2) default 0,FOMA_Count int(3) default 0,FOMA_Lecture_Count int(2) default 0,primary key(Student_ID)) ");
                            ps4.execute();
                            String stu_table = academic_year + "_" + year + "_" + branch + "_" + semester + "_" + division + "_Muster";
                            PreparedStatement ps5 = con.prepareStatement("alter table " + stu_table + " add column " + subject_name + "_" + subject_code + "_Attendance int(4) default 0 ");
                            ps5.executeUpdate();

                            PreparedStatement ps6 = con.prepareStatement("select Student_Roll_No,Student_ID,Student_Name from " + stu_table);
                            ResultSet rs6 = ps6.executeQuery();
                            int j = 1;
                            while (rs6.next()) {

                                 student_roll = rs6.getInt(1);
                                 student_id = rs6.getString(2);
                                 student_name = rs6.getString(3);

                                if (j <= roll_to) {
                                    PreparedStatement ps7 = con.prepareStatement("insert into " + muster_table + "(Student_Roll_No,Student_ID,Student_Name) values(?,?,?)");
                                    ps7.setInt(1, j);
                                    ps7.setString(2, student_id);
                                    ps7.setString(3, student_name);
                                    ps7.executeUpdate();
                                    j++;
                                }
                            }
                            PreparedStatement ps2 = con.prepareStatement("insert into Faculty_Allocation_Subjectwise_Pr values(?,?,?,?,?,?,?,?,?,?,?,?)");
                            ps2.setString(1, academic_year);
                            ps2.setString(2, year);
                            ps2.setString(3, branch);
                            ps2.setString(4, division);
                            ps2.setString(5, semester);
                            ps2.setString(6, subject_name);
                            ps2.setString(7, subject_code);
                            ps2.setInt(8, i + 1);
                            ps2.setInt(9, roll_from);
                            ps2.setInt(10, roll_to);
                            ps2.setString(11, faculty_name);
                            ps2.setInt(12, faculty_id);
                            ps2.executeUpdate();

                            PreparedStatement ps3 = con.prepareStatement("insert into Practical_Muster_Allocation values(?,?,?,?,?,?,?,?,?,?,?,?,?)");
                            ps3.setInt(1, faculty_id);
                            ps3.setString(2, faculty_name);
                            ps3.setString(3, academic_year);
                            ps3.setString(4, year);
                            ps3.setString(5, branch);
                            ps3.setString(6, semester);
                            ps3.setString(7, division);
                            ps3.setInt(8, i + 1);
                            ps3.setInt(9, roll_from);
                            ps3.setInt(10, roll_to);
                            ps3.setString(11, subject_name);
                            ps3.setString(12, subject_code);
                            ps3.setString(13, muster);
                            ps3.executeUpdate();

                        }
                    }

                }
                // con.commit();
                request.setAttribute("errorMessage","<font color='red'><center><b><h2>Faculty Allocated Successfully for Extra Subject....</h2></b></center></font>");
                request.getRequestDispatcher("Form13_CT_Login.jsp").include(request, response);

            } catch (Exception e) {
                // con.rollback();
                e.printStackTrace();
                out.println(e);
                request.setAttribute("errorMessage","<font color='red'><center><b><h2>There are no records in database which matches the given criteria...Please Contact the Administrator...</h2></b></center></font>");
                request.getRequestDispatcher("Form13_CT_Login.jsp").include(request, response);
            } finally {
                con.close();
            }
            }
        %>
    </body>
</html>
