<%-- 
    Document   : Form15_SFD_Save
    Created on : Sep 4, 2016, 1:19:48 AM
    Author     : sandeep
--%>

<%@page import="java.sql.DatabaseMetaData"%>
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
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
                request.getRequestDispatcher("Login.jsp").include(request, response);
            }
            try {
                String year = (String) ses.getAttribute("year");
                String branch = (String) ses.getAttribute("branch");
                String division = (String) ses.getAttribute("division");
                String academic_year = (String) ses.getAttribute("academic_year");
                String semester = (String) ses.getAttribute("semester");
                int batches = (Integer) ses.getAttribute("batches");
                int th_count = (Integer) ses.getAttribute("th_count");
                int pr_count = (Integer) ses.getAttribute("pr_count");
                int faculty_id;
                String faculty_name = "";
                String muster = "";
                String muster_table = "";
                Connection con = dbconnection.createConnection();
                PreparedStatement ps4 = con.prepareStatement("create table if not exists " + academic_year + "_" + year + "_" + branch + "_" + semester + "_" + division + "_Muster(Student_Roll_No int(5),Student_ID varchar(20),Student_Name varchar(50),primary key(Student_ID))");
                ps4.executeUpdate();

                for (int i = 0; i < th_count; i++) {
                    String subject_name = request.getParameter("Subject_Name_" + i);
                    String subject_code = request.getParameter("Subject_Code_" + i);
                    PreparedStatement ps5 = con.prepareStatement("alter table " + academic_year + "_" + year + "_" + branch + "_" + semester + "_" + division + "_Muster add column " + subject_name + "_" + subject_code + "_FMA_Count int(4) default 0, add column " + subject_name + "_" + subject_code + "_FM_Lecture_Count int(4) default 0,add column " + subject_name + "_" + subject_code + "_SMA_Count int(4) default 0,add column " + subject_name + "_" + subject_code + "_SM_Lecture_Count int(4) default 0,add column " + subject_name + "_" + subject_code + "_TMA_Count int(4) default 0,add column " + subject_name + "_" + subject_code + "_TM_Lecture_Count int(4) default 0,add column " + subject_name + "_" + subject_code + "_FOMA_Count int(4) default 0,add column " + subject_name + "_" + subject_code + "_FOM_Lecture_Count int(4) default 0 ");
                    ps5.executeUpdate();
                }

                PreparedStatement ps8 = con.prepareStatement("select Subject_Name,Subject_Code from " + academic_year + "_" + year + "_" + branch + "_Sem" + semester + "_Th_Pr where Subject_Type=?");
                ps8.setString(1, "Practical");
                ResultSet rs8 = ps8.executeQuery();
                while (rs8.next()) {
                    String prac_name = rs8.getString(1);
                    String prac_code = rs8.getString(2);
                    PreparedStatement ps7 = con.prepareStatement("alter table " + academic_year + "_" + year + "_" + branch + "_" + semester + "_" + division + "_Muster add column " + prac_name + "_" + prac_code + "_FMA_Count int(4) default 0,add column " + prac_name + "_" + prac_code + "_FM_Practical_Count int(4) default 0,add column " + prac_name + "_" + prac_code + "_SMA_Count int(4) default 0,add column " + prac_name + "_" + prac_code + "_SM_Practical_Count int(4) default 0,add column " + prac_name + "_" + prac_code + "_TMA_Count int(4) default 0,add column " + prac_name + "_" + prac_code + "_TM_Practical_Count int(4) default 0,add column " + prac_name + "_" + prac_code + "_FOMA_Count int(4) default 0,add column " + prac_name + "_" + prac_code + "_FOM_Practical_Count int(4) default 0 ");
                    ps7.executeUpdate();
                }

                String stu_muster = academic_year + "_" + year + "_" + branch + "_" + semester + "_" + division + "_Muster";

                PreparedStatement ps6 = con.prepareStatement("select Leave_Type from Leave_Type_Identification where Academic_Year=? and Year=? and Branch=? ");
                ps6.setString(1, academic_year);
                ps6.setString(2, year);
                ps6.setString(3, branch);
                ResultSet rs6 = ps6.executeQuery();                         //added today
                while (rs6.next()) {
                    String leave_type = rs6.getString(1);
                    PreparedStatement ps5 = con.prepareStatement("alter table " + stu_muster + " add column " + leave_type + " int(2) default 0 ");
                    ps5.executeUpdate();

                }

                for (int i = 0; i < th_count; i++) {

                    String pa = request.getParameter("Faculty_Name_" + i);
                    String[] parray = pa.split(" -");
                    faculty_name = parray[0];
                    String subject_name = request.getParameter("Subject_Name_" + i);
                    String subject_code = request.getParameter("Subject_Code_" + i);

                    PreparedStatement ps = con.prepareStatement("select Faculty_ID from Faculty_Details where Faculty_Name=? ");
                    ps.setString(1, faculty_name);
                    ResultSet rs = ps.executeQuery();
                    rs.next();
                    faculty_id = rs.getInt(1);

                    PreparedStatement ps1 = con.prepareStatement("insert into Faculty_Allocation_Subjectwise_Th values(?,?,?,?,?,?,?,?,?)");
                    ps1.setString(1, academic_year);
                    ps1.setString(2, year);
                    ps1.setString(3, branch);
                    ps1.setString(4, division);
                    ps1.setString(5, semester);
                    ps1.setString(6, subject_name);
                    ps1.setString(7, subject_code);
                    ps1.setString(8, faculty_name);
                    ps1.setInt(9, faculty_id);
                    ps1.executeUpdate();

                    muster = "Th_" + branch + "_" + subject_name + "_" + year + "_" + division + "_Sem_" + semester;
                    PreparedStatement ps2 = con.prepareStatement("insert into Theory_Muster_Allocation values(?,?,?,?,?,?,?,?,?,?) ");
                    ps2.setInt(1, faculty_id);
                    ps2.setString(2, faculty_name);
                    ps2.setString(3, academic_year);
                    ps2.setString(4, year);
                    ps2.setString(5, branch);
                    ps2.setString(6, semester);
                    ps2.setString(7, division);
                    ps2.setString(8, subject_name);
                    ps2.setString(9, subject_code);
                    ps2.setString(10, muster);
                    ps2.executeUpdate();

                    muster_table = faculty_id + "_" + academic_year + "_" + year + "_" + branch + "_" + division + "_" + subject_code + "_" + muster;
                    PreparedStatement ps3 = con.prepareStatement("create table " + muster_table + "(Student_Roll_No int(5),Student_ID varchar(15),Student_Name varchar(50),FMA_Count int(3) default 0,FM_Lecture_Count int(2) default 0,SMA_Count int(3) default 0,SM_Lecture_Count int(2) default 0,TMA_Count int(3) default 0,TM_Lecture_Count int(2) default 0,FOMA_Count int(3) default 0,FOM_Lecture_Count int(2) default 0,Total_Lecture_Count int(3) default 0,primary key(Student_ID)) ");
                    ps3.executeUpdate();
                }

                for (int i = 0; i < pr_count; i++) {
                    for (int j = 0; j < batches; j++) {
                        String pa = request.getParameter("Faculty_Name_" + i + "_" + j);
                        String[] parray = pa.split(" -");
                        faculty_name = parray[0];
                        String practical_name = request.getParameter("Practical_Name_" + i + "_" + j);
                        String practical_code = request.getParameter("Practical_Code_" + i + "_" + j);
                        int roll_from = Integer.parseInt(request.getParameter("roll_" + i + "_" + j + "_from"));
                        int roll_to = Integer.parseInt(request.getParameter("roll_" + i + "_" + j + "_to"));

                        PreparedStatement ps7 = con.prepareStatement("select Faculty_ID from Faculty_Details where Faculty_Name=? ");
                        ps7.setString(1, faculty_name);
                        ResultSet rs7 = ps7.executeQuery();
                        rs7.next();
                        faculty_id = rs7.getInt(1);

                        PreparedStatement ps1 = con.prepareStatement("insert into Faculty_Allocation_Subjectwise_Pr values(?,?,?,?,?,?,?,?,?,?,?,?)");
                        ps1.setString(1, academic_year);
                        ps1.setString(2, year);
                        ps1.setString(3, branch);
                        ps1.setString(4, division);
                        ps1.setString(5, semester);
                        ps1.setString(6, practical_name);
                        ps1.setString(7, practical_code);
                        ps1.setInt(8, j + 1);
                        ps1.setInt(9, roll_from);
                        ps1.setInt(10, roll_to);
                        ps1.setString(11, faculty_name);
                        ps1.setInt(12, faculty_id);
                        ps1.executeUpdate();

                        muster = "Pr_" + branch + "_"+ practical_name + "_" + year + "_" + division + "_Batch_" + (j + 1) + "_Sem_" + semester;

                        PreparedStatement ps2 = con.prepareStatement("insert into Practical_Muster_Allocation values(?,?,?,?,?,?,?,?,?,?,?,?,?) ");
                        ps2.setInt(1, faculty_id);
                        ps2.setString(2, faculty_name);
                        ps2.setString(3, academic_year);
                        ps2.setString(4, year);
                        ps2.setString(5, branch);
                        ps2.setString(6, semester);
                        ps2.setString(7, division);
                        ps2.setInt(8, j + 1);
                        ps2.setInt(9, roll_from);
                        ps2.setInt(10, roll_to);
                        ps2.setString(11, practical_name);
                        ps2.setString(12, practical_code);
                        ps2.setString(13, muster);
                        ps2.executeUpdate();

                        muster_table = faculty_id + "_" + academic_year + "_" + year + "_" + branch + "_" + division + "_" + practical_code + "_" + muster;
                        PreparedStatement ps3 = con.prepareStatement("create table " + muster_table + "(Student_Roll_No int(5),Student_ID varchar(15),Student_Name varchar(50),FMA_Count int(3) default 0,FM_Practical_Count int(2) default 0,SMA_Count int(3) default 0,SM_Practical_Count int(2) default 0,TMA_Count int(3) default 0,TM_Practical_Count int(2) default 0,FOMA_Count int(3) default 0,FOM_Practical_Count int(2) default 0,Total_Lecture_Count int(3) default 0,primary key(Student_ID)) ");
                        ps3.executeUpdate();
                    }
                }
                request.setAttribute("errorMessage", "<font color='green'><center><b><h4>Faculty Allocated Successfully...Please upload the Roll Call List....</h4></b></center></font>");
                request.getRequestDispatcher("Form16_UM.jsp").include(request, response);

            } catch (Exception e) {
                out.println(e);
                request.setAttribute("errorMessage", "<font color='red'><center><b><h4>There is nothing to be fetched from database for you...Please Contact the Administrator...</h4></b></center></font>");
                request.getRequestDispatcher("Form13_CT_Login.jsp").include(request, response);
            }
        %>
    </body>
</html>
