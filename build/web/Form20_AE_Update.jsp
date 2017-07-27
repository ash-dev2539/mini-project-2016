<%-- 
    Document   : Form20_AE_Update
    Created on : 12 Sep, 2016, 12:15:31 AM
    Author     : student
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*" %>
<%@page import="DBconnection.dbconnection" %>
<%@page contentType="text/html" pageEncoding="UTF-8" session="false"%>
<html>
    <head>
        <script>
            function doit()
            {
                document.getElementById("f1").submit();
            }
            function doitt()
            {
                document.getElementById("f2").submit();
            }
        </script>
    </head>
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

                    int empid = (Integer) ses.getAttribute("empid");

                    String Date1 = (String) ses.getAttribute("Date");
                    String Date = Date1.replaceAll(("-"), "_");

                    String Month = Date.substring(3, 5);
                    int month1 = Integer.parseInt(Month);

                    String[] Hour = (String[]) ses.getAttribute("Hour");
                    int Hours = Hour.length;

                    String subject_type = (String) ses.getAttribute("subject_type");
                    String table_name = (String) ses.getAttribute("table_name");

                    String a_year = (String) ses.getAttribute("academic_year");
                    int A_year = Integer.parseInt(a_year);

                    String Sem = (String) ses.getAttribute("semester");
                    String Year = (String) ses.getAttribute("Year");
                    String Branch = (String) ses.getAttribute("Branch");
                    String Division = (String) ses.getAttribute("Division");
                    String Subject_Name = (String) ses.getAttribute("Subject_Name");
                    String Faculty_Name = (String) ses.getAttribute("Faculty_Name");
                    String count = "";
                    String lcount = "";
                    String subject_code = "";
                    String stu_table_name = a_year + "_" + Year + "_" + Branch + "_" + Sem + "_" + Division + "_Muster";

                    if (subject_type.equals("Theory")) {
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
                        PreparedStatement stmt5 = con.prepareStatement("select Prac_Subject_Code from Faculty_Allocation_Subjectwise_Pr where Academic_Year=? and Year=? and Branch=? and Division=? and Semester=? and Practical_Subject_Name=?");
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

                        deliver = "HOD_Check_Status.jsp";
                    }

                    if (month1 == 6 || month1 == 12) {

                        count = "FMA_Count";

                        if (subject_type.equals("Theory")) {
                            lcount = "FM_Lecture_Count";
                        } else if (subject_type.equals("Practical")) {
                            lcount = "FM_Practical_Count";
                        }

                    } else if (month1 == 7 || month1 == 1) {

                        count = "SMA_Count";

                        if (subject_type.equals("Theory")) {
                            lcount = "SM_Lecture_Count";
                        } else if (subject_type.equals("Practical")) {
                            lcount = "SM_Practical_Count";
                        }

                    } else if (month1 == 8 || month1 == 2) {

                        count = "TMA_Count";

                        if (subject_type.equals("Theory")) {
                            lcount = "TM_Lecture_Count";
                        } else if (subject_type.equals("Practical")) {
                            lcount = "TM_Practical_Count";
                        }

                    } else if (month1 == 9 || month1 == 3) {

                        count = "FOMA_Count";

                        if (subject_type.equals("Theory")) {
                            lcount = "FOM_Lecture_Count";
                        } else if (subject_type.equals("Practical")) {
                            lcount = "FOM_Practical_Count";
                        }

                    } else {

                        request.setAttribute("errorMessage", "<center><p style=\"color:red\"  >Invalid Month<center>");
                        request.getRequestDispatcher(deliver).include(request, response);

                    }

                    int found = 0;
                    //System.out.print("Hours: " + Date + " d " + found);

                    for (int z = 0; z < Hours; z++) {

                        String column = Date + "_" + Hour[z];
                        System.out.print("Hours: " + column + " d " + found);
                        DatabaseMetaData metadata = con.getMetaData();
                        ResultSet rs4 = metadata.getColumns(null, null, table_name, column);

                        if (rs4.next()) {
                            found = found + 1;

                        }
                    }
                    System.out.print("Hours: " + Hours + " d " + found);
                    if (found == Hours) {

                        for (int k = 0; k < Hours; k++) {
                            String column = Date + "_" + Hour[k];
                            PreparedStatement ps1 = con.prepareStatement("select Student_Roll_No from " + table_name + " where " + column + "='P'");
                            ResultSet rs1 = ps1.executeQuery();

                            if (subject_type.equals("Theory")) {

                                String Statement4 = "Update " + table_name + " set " + count + "=" + count + "-1 where " + column + "='P'";
                                PreparedStatement stmt4 = con.prepareStatement(Statement4);
                                stmt4.executeUpdate();
                                String Statement1 = "Update " + table_name + " set " + lcount + "=" + lcount + "-1 ,Total_Lecture_Count=Total_Lecture_Count-1 ";
                                PreparedStatement stmt1 = con.prepareStatement(Statement1);
                                stmt1.executeUpdate();

                                PreparedStatement ps = con.prepareStatement("Update " + stu_table_name + " set " + Subject_Name + "_" + subject_code + "_" + lcount + "=" + Subject_Name + "_" + subject_code + "_" + lcount + "-1");
                                ps.executeUpdate();
                                while (rs1.next()) {
                                    int stu_roll_no = rs1.getInt(1);
                                    PreparedStatement ps2 = con.prepareStatement("Update " + stu_table_name + " set " + Subject_Name + "_" + subject_code + "_" + count + "=" + Subject_Name + "_" + subject_code + "_" + count + "-1 where Student_Roll_No=? ");
                                    ps2.setInt(1, stu_roll_no);
                                    ps2.executeUpdate();
                                }
                                rs1.beforeFirst();

                            } else if (subject_type.equals("Practical")) {
                                String Statement4 = "Update " + table_name + " set " + count + "=" + count + "-1 where " + column + "='P'";
                                PreparedStatement stmt4 = con.prepareStatement(Statement4);
                                stmt4.executeUpdate();

                                String Statement1 = "Update " + table_name + " set " + lcount + "=" + lcount + "-1 ,Total_Lecture_Count=Total_Lecture_Count-1 ";
                                PreparedStatement stmt1 = con.prepareStatement(Statement1);
                                stmt1.executeUpdate();

                                PreparedStatement ps = con.prepareStatement("Update " + stu_table_name + " set " + Subject_Name + "_" + subject_code + "_" + lcount + "=" + Subject_Name + "_" + subject_code + "_" + lcount + "+1");
                                ps.executeUpdate();

                                while (rs1.next()) {
                                    int stu_roll_no = rs1.getInt(1);
                                    PreparedStatement ps2 = con.prepareStatement("Update " + stu_table_name + " set " + Subject_Name + "_" + subject_code + "_" + count + "=" + Subject_Name + "_" + subject_code + "_" + count + "+1 where Student_Roll_No=? ");
                                    ps2.setInt(1, stu_roll_no);
                                    ps2.executeUpdate();
                                }
                                rs1.beforeFirst();
                            }

                            String Statement0 = "Alter table " + table_name + " drop column " + Date + "_" + Hour[k] + " ";
                            PreparedStatement stmt0 = con.prepareStatement(Statement0);
                            stmt0.executeUpdate();

                            PreparedStatement ps2 = con.prepareStatement("select " + Hour[k] + "_Faculty_Name, " + Hour[k] + "_Subject_Name from Daywise_Hourly_Muster where Date=? ");
                            ps2.setString(1, Date);
                            ResultSet rs2 = ps2.executeQuery();
                            if (rs2.next()) {

                                int check = 0;
                                int check1 = 0;
                                if (rs2.getString(1).equals("NULL")) {
                                } else {
                                    rs2.beforeFirst();
                                    rs2.next();
                                    String faculty_name_already = rs2.getString(1);
                                    String subject_name_already = rs2.getString(2);
                                    String[] fac = faculty_name_already.split("_");
                                    String[] sub = subject_name_already.split("_");
                                    String new_faculty_name = "";
                                    String new_subject_name = "";
                                    for (int i = 0; i < fac.length; i++) {
                                        if (fac[i].equals(Faculty_Name)) {
                                            fac[i] = null;
                                            check = 1;
                                        }
                                    }
                                    for (int i = 0; i < sub.length; i++) {
                                        if (sub[i].equals(Subject_Name)) {
                                            sub[i] = null;
                                            check1 = 1;
                                        }
                                    }
                                    if (check == 1 && check1 == 1) {
                                        for (int i = 0; i < fac.length; i++) {
                                            new_faculty_name = new_faculty_name + "_" + fac[i];
                                        }
                                        for (int i = 0; i < sub.length; i++) {
                                            new_subject_name = new_subject_name + "_" + sub[i];
                                        }
                                    }

                                    String stmt = "update Daywise_Hourly_Muster set " + Hour[k] + "_Faculty_Name=?," + Hour[k] + "_Subject_Name=? where Date =? ";
                                    PreparedStatement stmtp = con.prepareStatement(stmt);
                                    stmtp.setString(1, new_faculty_name);
                                    stmtp.setString(2, new_subject_name);
                                    stmtp.setString(3, Date);
                                    stmtp.executeUpdate();

                                }

                            }

                        }
                        String go = "";
                        String upchoice = (String) ses.getAttribute("upchoice");
                        String musterup = (String) ses.getAttribute("musterup");
                        String lec_type = (String) ses.getAttribute("Lecture_Type");
                        if (upchoice.equals("Drop Existing Date")) {

        %>
        <form action="Form18_ME.jsp" method="post" id="f1">       
            <input type="hidden" value="<%=musterup%>" name ="Muster">
            <input type="hidden" value="Add" name ="Type">
            <input type="hidden" value="<%=subject_type%>" name ="Subject_Type">   
            <script>
                window.onload = doit();
            </script>
        </form>
        <%
        } else if (upchoice.equals("Alter Existing Attendance")) {

        %>
        <form action="Form19_NAE.jsp" method="post" id="f2">    
            <input type="hidden" value="<%=Date%>" name ="Date">    
            <input type="hidden" value="Update" name ="Type">  
            <input type="hidden" value="Alter Existing Date" name ="upchoice">   
            <input type="hidden" value="<%=lec_type%>" name ="Lecture_Type">              
            <script>
                window.onload = doitt();
            </script>
        </form>
        <%
                        }

                    } else {
                        request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Sorry...data for given data and hours combination doesn't exitst....<br>Please check the lectures taken or add the entries..</h2></b></center></font>");
                        request.getRequestDispatcher(deliver).include(request, response);

                    }
                } catch (Exception e) {
                    out.println(e);

                }
            }
        %>
    </body>
</html>