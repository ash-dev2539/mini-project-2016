
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*" %>
<%@page import="DBconnection.dbconnection" %>
<%@page contentType="text/html" pageEncoding="UTF-8" session="false"%>

<html>
    <body>
        <%

            HttpSession ses = request.getSession(false);
            if (ses.getAttribute("empid") == null || ses.getAttribute("empid").equals("")) {
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
                request.getRequestDispatcher("Login.jsp").include(request, response);
            } else {

                Connection con = DBconnection.dbconnection.createConnection();
                String deliver = "";
                try {
                    int Number = Integer.parseInt(request.getParameter("Number"));
                    String Date = (String) ses.getAttribute("Date");
                    String mark_type = request.getParameter("mark_type");
                    String mark = "";
                    String mark_opp = "";
                    if (mark_type.equals("Present")) {
                        mark = "A";
                        mark_opp = "P";
                    } else {
                        mark = "P";
                        mark_opp = "A";
                    }
                    int empid = (Integer) ses.getAttribute("empid");
                    PreparedStatement ps6 = con.prepareStatement("select Designation from Faculty_Personal_Details where Emp_ID=? ");
                    ps6.setInt(1, empid);
                    ResultSet rs6 = ps6.executeQuery();
                    rs6.next();
                    String faculty_designation = rs6.getString(1);
                    if (faculty_designation.equals("Faculty")) {
                        PreparedStatement ps7 = con.prepareStatement("select*from Class_Teacher_Details where Emp_ID=? ");
                        ps7.setInt(1, empid);
                        ResultSet rs7 = ps7.executeQuery();
                        if (rs7.next()) {
                            deliver = "CT_Own_Musters.jsp";
                        } else {
                            deliver = "Form17_SL.jsp";
                        }

                    } else if (faculty_designation.equals("HOD")) {

                        deliver = "CT_Own_Musters.jsp";
                    }

                    String Month = Date.substring(3, 5);
                    int month1 = Integer.parseInt(Month);
                    int flag = 0, found = 0;

                    String[] Hour = (String[]) ses.getAttribute("Hour");
                    int hour_length = Hour.length;
                    String subject_type = (String) ses.getAttribute("subject_type");
                    String table_name = (String) ses.getAttribute("table_name");

                    String a_year = (String) ses.getAttribute("academic_year");
                    String Sem = (String) ses.getAttribute("semester");
                    String Year = (String) ses.getAttribute("Year");
                    String Branch = (String) ses.getAttribute("Branch");
                    String Division = (String) ses.getAttribute("Division");
                    String Subject_Name = (String) ses.getAttribute("Subject_Name");
                    String Faculty_Name = (String) ses.getAttribute("Faculty_Name");
                    String after = "";
                    String count = "";
                    String lcount = "";
                    String subject_code = "";
                    String stu_table_name = a_year + "_" + Year + "_" + Branch + "_" + Sem + "_" + Division + "_Muster";
                    PreparedStatement ps0 = con.prepareStatement("select Month1, Month2, Month3, Month4 from Month_Entry where Academic_Year=? and Year=? and Branch=? and Semester=? and Division=?");
                    ps0.setString(1, a_year);
                    ps0.setString(2, Year);
                    ps0.setString(3, Branch);
                    ps0.setString(4, Sem);
                    ps0.setString(5, Division);
                    ResultSet rs0 = ps0.executeQuery();
                    if (rs0.next()) {
                        if (month1 == rs0.getInt(1)) {

                            count = "FMA_Count";

                            if (subject_type.equals("Theory")) {
                                after = "Student_Name";
                                lcount = "FM_Lecture_Count";
                            } else if (subject_type.equals("Practical")) {
                                after = "Student_Name";
                                lcount = "FM_Practical_Count";
                            }

                        } else if (month1 == rs0.getInt(2)) {

                            count = "SMA_Count";

                            if (subject_type.equals("Theory")) {
                                after = "FM_Lecture_Count";
                                lcount = "SM_Lecture_Count";
                            } else if (subject_type.equals("Practical")) {
                                after = "FM_Practical_Count";
                                lcount = "SM_Practical_Count";
                            }

                        } else if (month1 == rs0.getInt(3)) {

                            count = "TMA_Count";

                            if (subject_type.equals("Theory")) {
                                after = "SM_Lecture_Count";
                                lcount = "TM_Lecture_Count";
                            } else if (subject_type.equals("Practical")) {
                                after = "SM_Practical_Count";
                                lcount = "TM_Practical_Count";
                            }

                        } else if (month1 == rs0.getInt(4)) {

                            count = "FOMA_Count";

                            if (subject_type.equals("Theory")) {
                                after = "TM_Lecture_Count";
                                lcount = "FOM_Lecture_Count";
                            } else if (subject_type.equals("Practical")) {
                                after = "TM_Practical_Count";
                                lcount = "FOM_Practical_Count";
                            }

                        } else {

                            request.setAttribute("errorMessage", "<center><p style=\"color:red\">Invalid Month<center>");
                            System.out.print("deliver:" + deliver);
                            request.getRequestDispatcher(deliver).include(request, response);

                        }
                    }

                    if (subject_type.equals("Theory")) {

                        PreparedStatement ps4 = con.prepareStatement("select Date from Daywise_Hourly_Muster where Academic_Year=? and Year=? and Branch=? and Division=? and Semester=? and Date=?");
                        ps4.setString(1, a_year);
                        ps4.setString(2, Year);
                        ps4.setString(3, Branch);
                        ps4.setString(4, Division);
                        ps4.setString(5, Sem);
                        ps4.setString(6, Date);
                        ResultSet rs4 = ps4.executeQuery();
                        if (!rs4.next()) {
                            String stmtpa = "insert into Daywise_Hourly_Muster(Academic_Year,Year,Branch,Division,Semester,Date) values(?,?,?,?,?,?)";
                            PreparedStatement stmtpan = con.prepareStatement(stmtpa);

                            stmtpan.setString(1, a_year);
                            stmtpan.setString(2, Year);
                            stmtpan.setString(3, Branch);
                            stmtpan.setString(4, Division);
                            stmtpan.setString(5, Sem);
                            stmtpan.setString(6, Date);
                            stmtpan.executeUpdate();

                        }
                        rs4.beforeFirst();

                        PreparedStatement stmt5 = con.prepareStatement("select Subject_Code from Faculty_Allocation_Subjectwise_Th where Academic_Year=? and Year=? and Branch=? and Division=? and Semester=? and Subject_Name=?");
                        stmt5.setString(1, a_year);
                        stmt5.setString(2, Year);
                        stmt5.setString(3, Branch);
                        stmt5.setString(4, Division);
                        stmt5.setString(5, Sem);
                        stmt5.setString(6, Subject_Name);
                        ResultSet rs5 = stmt5.executeQuery();
                        if (rs5.next()) {
                            subject_code = rs5.getString(1);
                        }
                    } else if (subject_type.equals("Practical")) {

                        PreparedStatement ps4 = con.prepareStatement("select Date from Daywise_Hourly_Muster where Academic_Year=? and Year=? and Branch=? and Division=? and Semester=? and Date=?");
                        ps4.setString(1, a_year);
                        ps4.setString(2, Year);
                        ps4.setString(3, Branch);
                        ps4.setString(4, Division);
                        ps4.setString(5, Sem);
                        ps4.setString(6, Date);
                        ResultSet rs4 = ps4.executeQuery();
                        if (!rs4.next()) {
                            String stmtpa = "insert into Daywise_Hourly_Muster(Academic_Year,Year,Branch,Division,Semester,Date) values(?,?,?,?,?,?)";
                            PreparedStatement stmtpan = con.prepareStatement(stmtpa);

                            stmtpan.setString(1, a_year);
                            stmtpan.setString(2, Year);
                            stmtpan.setString(3, Branch);
                            stmtpan.setString(4, Division);
                            stmtpan.setString(5, Sem);
                            stmtpan.setString(6, Date);
                            stmtpan.executeUpdate();
                        }
                        rs4.beforeFirst();
                        PreparedStatement stmt5 = con.prepareStatement("select Prac_Subject_Code from Faculty_Allocation_Subjectwise_Pr where Academic_Year=? and Year=? and Branch=? and Division=? and Semester=? and Prac_Subject_Name=?");
                        stmt5.setString(1, a_year);
                        stmt5.setString(2, Year);
                        stmt5.setString(3, Branch);
                        stmt5.setString(4, Division);
                        stmt5.setString(5, Sem);
                        stmt5.setString(6, Subject_Name);
                        ResultSet rs5 = stmt5.executeQuery();
                        if (rs5.next()) {
                            subject_code = rs5.getString(1);
                        }
                    }

                    if (subject_type.equals("Theory")) {
                        for (int i = 0; i < hour_length; i++) {

                            String att_check = "select " + Hour[i] + "_Faculty_Name from Daywise_Hourly_Muster where Academic_Year=? and Year=? and Branch=? and Division=? and Semester=? and Date=?";
                            PreparedStatement ps10 = con.prepareStatement(att_check);
                            ps10.setString(1, a_year);
                            ps10.setString(2, Year);
                            ps10.setString(3, Branch);
                            ps10.setString(4, Division);
                            ps10.setString(5, Sem);
                            ps10.setString(6, Date);
                            ResultSet rs10 = ps10.executeQuery();
                            rs10.next();
                            String checked = rs10.getString(1);

                            if (checked != null) {
                                flag = 1;
                                break;
                            } else {
                                String column = "";
                                column = Date + "_" + Hour[i];
                                DatabaseMetaData metadata = con.getMetaData();
                                ResultSet rs4 = metadata.getColumns(null, null, table_name, column);
                                if (rs4.next()) {
                                    found = 1;
                                }

                                if (found == 0) {
                                    String Statement0 = "alter table " + table_name + " add " + column + " varchar(2) default ? after " + after;
                                    PreparedStatement stmt0 = con.prepareStatement(Statement0);
                                    stmt0.setString(1, mark);
                                    stmt0.executeUpdate();

                                    for (int j = 0; j < Number; j++) {

                                        int roll_no = Integer.parseInt(request.getParameter("Roll_No_" + j));

                                        String Statement2 = "Update " + table_name + " set " + column + "=? where Student_Roll_No=? ";
                                        PreparedStatement stmt2 = con.prepareStatement(Statement2);
                                        stmt2.setString(1, mark_opp);
                                        stmt2.setInt(2, roll_no);

                                        stmt2.executeUpdate();

                                    }

                                    PreparedStatement ps1 = con.prepareStatement("select Student_Roll_No from " + table_name + " where " + column + "='P'");
                                    ResultSet rs1 = ps1.executeQuery();

                                    String Statement4 = "Update " + table_name + " set " + count + "=" + count + "+1 where " + column + "='P'";
                                    PreparedStatement stmt4 = con.prepareStatement(Statement4);
                                    stmt4.executeUpdate();

                                    String Statement1 = "Update " + table_name + " set " + lcount + "= " + lcount + " +1 ,Total_Lecture_Count=Total_Lecture_Count+1 ";
                                    PreparedStatement stmt1 = con.prepareStatement(Statement1);
                                    stmt1.executeUpdate();

                                    PreparedStatement ps = con.prepareStatement("Update " + stu_table_name + " set " + Subject_Name + "_" + subject_code + "_" + lcount + "= " + Subject_Name + "_" + subject_code + "_" + lcount + "+1");
                                    ps.executeUpdate();

                                    while (rs1.next()) {
                                        int stu_roll_no = rs1.getInt(1);
                                        PreparedStatement ps2 = con.prepareStatement("Update " + stu_table_name + " set " + Subject_Name + "_" + subject_code + "_" + count + "=" + Subject_Name + "_" + subject_code + "_" + count + "+1 where Student_Roll_No=? ");
                                        ps2.setInt(1, stu_roll_no);
                                        ps2.executeUpdate();
                                    }
                                    rs1.beforeFirst();

                                    /*else if (subject_type.equals("Practical")) {

                                        int roll_from = (Integer) ses.getAttribute("roll_from");
                                        int roll_to = (Integer) ses.getAttribute("roll_to");
                                        System.out.print("from: " + roll_from);
                                        System.out.print("to: " + roll_to);

                                        String Statement4 = "Update " + table_name + " set " + count + "=" + count + "+1 where " + column + "='P'";
                                        PreparedStatement stmt4 = con.prepareStatement(Statement4);
                                        stmt4.executeUpdate();

                                        String Statement1 = "Update " + table_name + " set " + lcount + "=" + lcount + "+1 ,Total_Lecture_Count=Total_Lecture_Count+1 ";
                                        PreparedStatement stmt1 = con.prepareStatement(Statement1);
                                        stmt1.executeUpdate();

                                        PreparedStatement ps = con.prepareStatement("Update " + stu_table_name + " set " + Subject_Name + "_" + subject_code + "_" + lcount + "=" + Subject_Name + "_" + subject_code + "_" + lcount + "+1 where Student_Roll_No>=" + roll_from + " and Student_Roll_No<=" + roll_to);
                                        ps.executeUpdate();

                                        while (rs1.next()) {
                                            int stu_roll_no = rs1.getInt(1);
                                            PreparedStatement ps2 = con.prepareStatement("Update " + stu_table_name + " set " + Subject_Name + "_" + subject_code + "_" + count + "=" + Subject_Name + "_" + subject_code + "_" + count + "+1 where Student_Roll_No=? ");
                                            ps2.setInt(1, stu_roll_no);
                                            ps2.executeUpdate();
                                        }
                                        rs1.beforeFirst();

                                    }*/
                                    PreparedStatement ps2 = con.prepareStatement("select " + Hour[i] + "_Faculty_Name, " + Hour[i] + "_Subject_Name from Daywise_Hourly_Muster where Academic_Year=? and Year=? and Branch=? and Division=? and Semester=? and Date=? ");
                                    ps2.setString(1, a_year);
                                    ps2.setString(2, Year);
                                    ps2.setString(3, Branch);
                                    ps2.setString(4, Division);
                                    ps2.setString(5, Sem);
                                    ps2.setString(6, Date);
                                    ResultSet rs2 = ps2.executeQuery();
                                    if (rs2.next()) {
                                        int check = 0;
                                        if (rs2.getString(1) == null) {
                                            String stmt = "update Daywise_Hourly_Muster set " + Hour[i] + "_Faculty_Name=?, " + Hour[i] + "_Subject_Name=? where Academic_Year=? and Year=? and Branch=? and Division=? and Semester=? and Date=? ";
                                            PreparedStatement stmtp = con.prepareStatement(stmt);
                                            stmtp.setString(1, Faculty_Name);
                                            stmtp.setString(2, Subject_Name);
                                            stmtp.setString(3, a_year);
                                            stmtp.setString(4, Year);
                                            stmtp.setString(5, Branch);
                                            stmtp.setString(6, Division);
                                            stmtp.setString(7, Sem);
                                            stmtp.setString(8, Date);
                                            stmtp.executeUpdate();
                                        }
                                       
                                    }

                                } else {
                                    flag = 1;
                                    break;
                                }
                            }
                        }
                    }

                    if (subject_type.equals("Practical")) {
                        for (int i = 0; i < hour_length; i++) {
                            String column = "";
                            column = Date + "_" + Hour[i];
                            DatabaseMetaData metadata = con.getMetaData();
                            ResultSet rs4 = metadata.getColumns(null, null, table_name, column);
                            if (rs4.next()) {
                                found = 1;
                            }

                            if (found == 0) {
                                String Statement0 = "alter table " + table_name + " add " + column + " varchar(2) default ? after " + after;
                                PreparedStatement stmt0 = con.prepareStatement(Statement0);
                                stmt0.setString(1, mark);
                                stmt0.executeUpdate();

                                for (int j = 0; j < Number; j++) {

                                    int roll_no = Integer.parseInt(request.getParameter("Roll_No_" + j));

                                    String Statement2 = "Update " + table_name + " set " + column + "=? where Student_Roll_No=? ";
                                    PreparedStatement stmt2 = con.prepareStatement(Statement2);
                                    stmt2.setString(1, mark_opp);
                                    stmt2.setInt(2, roll_no);

                                    stmt2.executeUpdate();

                                }

                                PreparedStatement ps1 = con.prepareStatement("select Student_Roll_No from " + table_name + " where " + column + "='P'");
                                ResultSet rs1 = ps1.executeQuery();

                                /*if (subject_type.equals("Theory")) {

                                        String Statement4 = "Update " + table_name + " set " + count + "=" + count + "+1 where " + column + "='P'";
                                        PreparedStatement stmt4 = con.prepareStatement(Statement4);
                                        stmt4.executeUpdate();

                                        String Statement1 = "Update " + table_name + " set " + lcount + "= " + lcount + " +1 ,Total_Lecture_Count=Total_Lecture_Count+1 ";
                                        PreparedStatement stmt1 = con.prepareStatement(Statement1);
                                        stmt1.executeUpdate();

                                        PreparedStatement ps = con.prepareStatement("Update " + stu_table_name + " set " + Subject_Name + "_" + subject_code + "_" + lcount + "= " + Subject_Name + "_" + subject_code + "_" + lcount + "+1");
                                        ps.executeUpdate();

                                        while (rs1.next()) {
                                            int stu_roll_no = rs1.getInt(1);
                                            PreparedStatement ps2 = con.prepareStatement("Update " + stu_table_name + " set " + Subject_Name + "_" + subject_code + "_" + count + "=" + Subject_Name + "_" + subject_code + "_" + count + "+1 where Student_Roll_No=? ");
                                            ps2.setInt(1, stu_roll_no);
                                            ps2.executeUpdate();
                                        }
                                        rs1.beforeFirst();

                                    } else*/ if (subject_type.equals("Practical")) {

                                    int roll_from = (Integer) ses.getAttribute("roll_from");
                                    int roll_to = (Integer) ses.getAttribute("roll_to");
                                    System.out.print("from: " + roll_from);
                                    System.out.print("to: " + roll_to);

                                    String Statement4 = "Update " + table_name + " set " + count + "=" + count + "+1 where " + column + "='P'";
                                    PreparedStatement stmt4 = con.prepareStatement(Statement4);
                                    stmt4.executeUpdate();

                                    String Statement1 = "Update " + table_name + " set " + lcount + "=" + lcount + "+1 ,Total_Lecture_Count=Total_Lecture_Count+1 ";
                                    PreparedStatement stmt1 = con.prepareStatement(Statement1);
                                    stmt1.executeUpdate();

                                    PreparedStatement ps = con.prepareStatement("Update " + stu_table_name + " set " + Subject_Name + "_" + subject_code + "_" + lcount + "=" + Subject_Name + "_" + subject_code + "_" + lcount + "+1 where Student_Roll_No>=" + roll_from + " and Student_Roll_No<=" + roll_to);
                                    ps.executeUpdate();

                                    while (rs1.next()) {
                                        int stu_roll_no = rs1.getInt(1);
                                        PreparedStatement ps2 = con.prepareStatement("Update " + stu_table_name + " set " + Subject_Name + "_" + subject_code + "_" + count + "=" + Subject_Name + "_" + subject_code + "_" + count + "+1 where Student_Roll_No=? ");
                                        ps2.setInt(1, stu_roll_no);
                                        ps2.executeUpdate();
                                    }
                                    rs1.beforeFirst();

                                }
                                PreparedStatement ps2 = con.prepareStatement("select " + Hour[i] + "_Faculty_Name, " + Hour[i] + "_Subject_Name from Daywise_Hourly_Muster where Academic_Year=? and Year=? and Branch=? and Division=? and Semester=? and Date=? ");
                                ps2.setString(1, a_year);
                                ps2.setString(2, Year);
                                ps2.setString(3, Branch);
                                ps2.setString(4, Division);
                                ps2.setString(5, Sem);
                                ps2.setString(6, Date);
                                ResultSet rs2 = ps2.executeQuery();
                                if (rs2.next()) {
                                    int check = 0;
                                    if (rs2.getString(1) == null) {
                                        String stmt = "update Daywise_Hourly_Muster set " + Hour[i] + "_Faculty_Name=?, " + Hour[i] + "_Subject_Name=? where Academic_Year=? and Year=? and Branch=? and Division=? and Semester=? and Date=? ";
                                        PreparedStatement stmtp = con.prepareStatement(stmt);
                                        stmtp.setString(1, Faculty_Name);
                                        stmtp.setString(2, Subject_Name);
                                        stmtp.setString(3, a_year);
                                        stmtp.setString(4, Year);
                                        stmtp.setString(5, Branch);
                                        stmtp.setString(6, Division);
                                        stmtp.setString(7, Sem);
                                        stmtp.setString(8, Date);
                                        stmtp.executeUpdate();
                                    } else {
                                        rs2.beforeFirst();
                                        rs2.next();
                                        String faculty_name_already = rs2.getString(1);
                                        String subject_name_already = rs2.getString(2);
                                        String[] fac = faculty_name_already.split("_");
                                        String[] sub = subject_name_already.split("_");
                                        for (int k = 0; k < fac.length; k++) {
                                            if (fac[k].equals(Faculty_Name)) {
                                                check = 1;
                                            }
                                        }
                                        if (check == 0) {
                                            String stmt = "update Daywise_Hourly_Muster set " + Hour[i] + "_Faculty_Name=?, " + Hour[i] + "_Subject_Name=? where Academic_Year=? and Year=? and Branch=? and Division=? and Semester=? and Date=? ";
                                            PreparedStatement stmtp = con.prepareStatement(stmt);
                                            stmtp.setString(1, faculty_name_already + "_" + Faculty_Name);
                                            stmtp.setString(2, subject_name_already + "_" + Subject_Name);
                                            stmtp.setString(3, a_year);
                                            stmtp.setString(4, Year);
                                            stmtp.setString(5, Branch);
                                            stmtp.setString(6, Division);
                                            stmtp.setString(7, Sem);
                                            stmtp.setString(8, Date);
                                            stmtp.executeUpdate();
                                        }
                                    }
                                }

                            } else {
                                flag = 1;
                                break;
                            }
                        }
                    }
                    if (flag == 1) {
                        request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Sorry...data already exitsts....</h2></b></center></font>");
                        request.getRequestDispatcher(deliver).include(request, response);
                    } else {
                        request.setAttribute("errorMessage", "<center><p style=\"color:green\"><h2>Records Added Successfully</h2></center");
                        request.getRequestDispatcher(deliver).include(request, response);
                    }

                } catch (Exception e) {
                    out.println(e);
                }
            }
        %>
    </body>
</html>