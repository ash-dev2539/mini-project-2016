<%-- 
    Document   : Form25_GD_Final_Really
    Created on : Sep 17, 2016, 8:52:08 PM
    Author     : sandeep
--%>

<%@page import="org.apache.poi.ss.usermodel.Workbook"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
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
                width:600px;
                margin:0 auto;
                margin-top:8px;
                margin-bottom:2%;
                transition:opacity 1s;
                -webkit-transition:opacity 1s;
            }
            h1{
                font-size: 20px;

            }
            .label{
                width:400px;
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
    <body id="wow">
        <br>
    <center><img src="images/indira.gif" height="100" width="100">
        <div style="font-size: xx-large; color: white">INDIRA COLLEGE OF ENGINEERING AND MANAGEMENT</div></center>
    <hr>
    <script type="text/javascript">
        function doPrint() {
            var b1 = document.getElementById("b1");
            b1.style.visibility = "hidden";
            var b2 = document.getElementById("b2");
            b2.style.visibility = "hidden";
            var b3 = document.getElementById("b3");
            b3.style.visibility = "hidden";
            var b4 = document.getElementById("b4");
            b4.style.visibility = "hidden";
            var b5 = document.getElementById("b5");
            b5.style.visibility = "hidden";
            document.getElementById("wow").style.color = "black";
            window.print();
            document.getElementById("wow").style.color = "yellow";
            b1.style.visibility = "visible";
            b2.style.visibility = "visible";
            b3.style.visibility = "visible";
            b4.style.visibility = "visible";
            b5.style.visibility = "visible";
        }

    </script>
    <style type="text/css" media="print">
        @page {
            size: auto;   /* auto is the initial value */
            margin: 0;  /* this affects the margin in the printer settings */
        }
    </style>

    <%
        HttpSession ses = request.getSession(false);
        if (ses.getAttribute("empid") == null || ses.getAttribute("empid").equals("")) {
            request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
            request.getRequestDispatcher("Login.jsp").include(request, response);
        }
        Connection con = DBconnection.dbconnection.createConnection();

        int ch1f = Integer.parseInt(request.getParameter("ch1f"));
        int ch1t = Integer.parseInt(request.getParameter("ch1t"));
        int ch2f = Integer.parseInt(request.getParameter("ch2f"));
        int ch2t = Integer.parseInt(request.getParameter("ch2t"));
        int ch3f = Integer.parseInt(request.getParameter("ch3f"));
        int ch3t = Integer.parseInt(request.getParameter("ch3t"));

        int empid = (Integer) ses.getAttribute("empid");
        String year = (String) ses.getAttribute("year");
        String branch = (String) ses.getAttribute("branch");
        String division = (String) ses.getAttribute("division");
        String academic_year = (String) ses.getAttribute("academic_year");
        String semester = (String) ses.getAttribute("semester");
        String stu_muster = academic_year + "_" + year + "_" + branch + "_" + semester + "_" + division + "_Muster";
        PreparedStatement ps6 = con.prepareStatement("select Designation from Faculty_Personal_Details where Emp_ID=? ");
        ps6.setInt(1, empid);
        ResultSet rs6 = ps6.executeQuery();
        rs6.next();
        String faculty_designation = rs6.getString(1);
        String deliver = "";
        if (faculty_designation.equals("Faculty")) {
            deliver = "Form13_CT_Login.jsp";
        } else if (faculty_designation.equals("Principal") || faculty_designation.equals("Vice_Principal")) {

            deliver = "Principal_Check_Status.jsp";
        } else if (faculty_designation.equals("HOD")) {

            deliver = "HOD_Check_Status.jsp";
        }        

        PreparedStatement ps = con.prepareStatement("select Subject_Name,Subject_Code from Faculty_Allocation_Subjectwise_Th where Academic_Year=? and Year=? and Branch=? and Division=? and Semester=? ");
        ps.setString(1, academic_year);
        ps.setString(2, year);
        ps.setString(3, branch);
        ps.setString(4, division);
        ps.setString(5, semester);
        ResultSet rs = ps.executeQuery();

        PreparedStatement ps1 = con.prepareStatement("select distinct(Prac_Subject_Name),Prac_Subject_Code from Faculty_Allocation_Subjectwise_Pr where Academic_Year=? and Year=? and Branch=? and Division=? and Semester=? ");
        ps1.setString(1, academic_year);
        ps1.setString(2, year);
        ps1.setString(3, branch);
        ps1.setString(4, division);
        ps1.setString(5, semester);
        ResultSet rs1 = ps1.executeQuery();

        PreparedStatement ps3 = con.prepareStatement("select Student_ID,Student_Name from " + stu_muster + " order by Student_Roll_No");

        ResultSet rs3 = ps3.executeQuery();

        PreparedStatement ps4 = con.prepareStatement("select Leave_Type from Leave_Type_Identification where Academic_Year=? and Year=? and Branch=? ");
        ps4.setString(1, academic_year);
        ps4.setString(2, year);
        ps4.setString(3, branch);
        ResultSet rs4 = ps4.executeQuery();
        int total_lecture = 0;
        while (rs.next()) {
            String subject_name = rs.getString(1);
            String subject_code = rs.getString(2);
            String lcount = "";

            lcount = subject_name + "_" + subject_code + "_FM_Lecture_Count+ " + subject_name + "_" + subject_code + "_SM_Lecture_Count + " + subject_name + "_" + subject_code + "_TM_Lecture_Count + " + subject_name + "_" + subject_code + "_FOM_Lecture_Count";

            PreparedStatement ps2 = con.prepareStatement("select max(" + lcount + ") from " + stu_muster);
            ResultSet rs2 = ps2.executeQuery();
            if (rs2.next()) {
                total_lecture = total_lecture + rs2.getInt(1);

            } else {
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Looks like Attendance have not been created yet.....<br>Please do that First</h2></b></center></font>");
                request.getRequestDispatcher(deliver).include(request, response);
            }
        }
        rs.beforeFirst();
    %>


    <div align="center" class="label"><h1> Final Defaulter's from <font color="yellow"><%=ch1f%>%</font> to <font color="yellow"><%=ch1t%>%</font></h1></div>
    <table align="center">
        <thead class="hi" style="font-size: 17px">
        <th>
            Student ID
        </th>
        <th>
            Student Name
        </th>

        <th>
            Total Lecture Attended(<font color="yellow">Out of=<%=total_lecture%></font>)
        </th>
        <th>
            Total Practical Attended
        </th>
        <th>
            Total Practical Taken
        </th>


        <th>
            Over All Attended
        </th>
        <th>
            Total Taken(Prac+Th+Leave)
        </th>
        <th>
            Extra Added
        </th>
        <th>
            Attendance(in %)
        </th>
    </thead>
    <%            rs.beforeFirst();
        rs1.beforeFirst();
        int lp_total = 0;

        while (rs3.next()) {
            String count_month = "";
            String lcount_month = "";
            int l_att_total = 0;
            int lp_att_total = 0;

            int p_att_total = 0;
            int p_total = 0;
            int ex_add = 0;
            float check_defaulter = 0;
            String student_id = rs3.getString(1);
            String student_name = rs3.getString(2);
            String count = "";
            int total_practical = 0;

            while (rs1.next()) {
                String subject_name = rs1.getString(1);
                String subject_code = rs1.getString(2);
                String lcount = "";

                lcount = subject_name + "_" + subject_code + "_FM_Practical_Count+ " + subject_name + "_" + subject_code + "_SM_Practical_Count + " + subject_name + "_" + subject_code + "_TM_Practical_Count + " + subject_name + "_" + subject_code + "_FOM_Practical_Count";

                PreparedStatement ps2 = con.prepareStatement("select " + lcount + " from " + stu_muster + " where Student_ID=?");
                ps2.setString(1, student_id);
                ResultSet rs2 = ps2.executeQuery();
                if (rs2.next()) {
                    total_practical = total_practical + rs2.getInt(1);

                } else {

                    request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Looks like Attendance has not been created yet.....<br>Please do that First</h2></b></center></font>");
                    request.getRequestDispatcher(deliver).include(request, response);
                }
            }
            rs1.beforeFirst();

            while (rs.next()) {

                String subject_name = rs.getString(1);
                String subject_code = rs.getString(2);

                count = subject_name + "_" + subject_code + "_FMA_Count + " + subject_name + "_" + subject_code + "_SMA_Count + " + subject_name + "_" + subject_code + "_TMA_Count + " + subject_name + "_" + subject_code + "_FOMA_Count";

                PreparedStatement ps2 = con.prepareStatement("select " + count + " from " + stu_muster + " where Student_ID=? ");
                ps2.setString(1, student_id);
                ResultSet rs2 = ps2.executeQuery();
                if (rs2.next()) {

                    l_att_total = l_att_total + rs2.getInt(1);

                } else {
                    request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Looks like Attendance has not been created yet.....<br>Please do that First</h2></b></center></font>");
                    request.getRequestDispatcher(deliver).include(request, response);
                }

            }
            while (rs1.next()) {

                String subject_name = rs1.getString(1);
                String subject_code = rs1.getString(2);

                count = subject_name + "_" + subject_code + "_FMA_Count + " + subject_name + "_" + subject_code + "_SMA_Count + " + subject_name + "_" + subject_code + "_TMA_Count + " + subject_name + "_" + subject_code + "_FOMA_Count";

                PreparedStatement ps2 = con.prepareStatement("select " + count + " from " + stu_muster + " where Student_ID=? ");
                ps2.setString(1, student_id);
                ResultSet rs2 = ps2.executeQuery();

                if (rs2.next()) {
                    p_att_total = p_att_total + rs2.getInt(1);
                } else {
                    request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Looks like Attendance has not been created yet.....<br>Please do that First</h2></b></center></font>");
                    request.getRequestDispatcher(deliver).include(request, response);
                }

            }

            while (rs4.next()) {
                String leave = rs4.getString(1);
                PreparedStatement ps5 = con.prepareStatement("select " + leave + " from " + stu_muster + " where Student_ID=? ");
                ps5.setString(1, student_id);
                ResultSet rs5 = ps5.executeQuery();
                if (rs5.next()) {
                    ex_add = ex_add + rs5.getInt(1);
                } else {
                    request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Looks like musters have not been created yet.....<br>Please do that First</h2></b></center></font>");
                    request.getRequestDispatcher(deliver).include(request, response);
                }
            }
            rs.beforeFirst();
            rs1.beforeFirst();
            rs4.beforeFirst();

            lp_att_total = l_att_total + p_att_total;
            lp_total = total_lecture + total_practical;
            float lp_totalf = lp_total;
            check_defaulter = (float) (((lp_att_total + ex_add) / lp_totalf) * 100);
            DecimalFormat df = new DecimalFormat("#.##");
            check_defaulter = Float.parseFloat(df.format(check_defaulter));
            if ((check_defaulter <= ch1t) && (check_defaulter >= ch1f)) {

    %>
    <tr>
        <td>
            <label>
                <%=student_id%>
            </label>
        </td>
        <td>
            <label>
                <%=student_name%>
            </label>
        </td>
        <td>
            <label>
                <%=l_att_total%>
            </label>
        </td>

        <td>
            <label>
                <%=p_att_total%>
            </label>
        </td>
        <td>
            <label>
                <%=total_practical%>
            </label>
        </td>


        <td>
            <label>
                <%=lp_att_total%>
            </label>
        </td>
        <td>
            <label>
                <%=lp_total%>
            </label>
        </td>
        <td>
            <label>
                <%=ex_add%>
            </label>
        </td>
        <td>
            <label>
                <%=check_defaulter%>
            </label>
        </td>
    </tr>
    <%
            } else
                continue;
        }
        rs3.beforeFirst();
    %>
</table>

<br/><br/>


<div align="center" class="label"><h1> Final Defaulter's from <font color="yellow"><%=ch2f%>%</font> to <font color="yellow"><%=ch2t%>%</font></h1></div>

<table align="center">
    <thead class="hi" style="font-size: 17px">
    <th>
        Student ID
    </th>
    <th>
        Student Name
    </th>

    <th>
        Total Lecture Attended(<font color="yellow">Out of=<%=total_lecture%></font>)
    </th>
    <th>
        Total Practical Attended
    </th>
    <th>
        Total Practical Taken
    </th>


    <th>
        Over All Attended
    </th>
    <th>
        Total Taken(Prac+Th+Leave)
    </th>
    <th>
        Extra Added
    </th>
    <th>
        Attendance(in %)
    </th>
</thead>
<%            rs.beforeFirst();
    rs1.beforeFirst();
    lp_total = 0;

    while (rs3.next()) {
        String count_month = "";
        String lcount_month = "";
        int l_att_total = 0;
        int lp_att_total = 0;

        int p_att_total = 0;
        int p_total = 0;
        int ex_add = 0;
        float check_defaulter = 0;
        String student_id = rs3.getString(1);
        String student_name = rs3.getString(2);
        String count = "";
        int total_practical = 0;

        while (rs1.next()) {
            String subject_name = rs1.getString(1);
            String subject_code = rs1.getString(2);
            String lcount = "";

            lcount = subject_name + "_" + subject_code + "_FM_Practical_Count+ " + subject_name + "_" + subject_code + "_SM_Practical_Count + " + subject_name + "_" + subject_code + "_TM_Practical_Count + " + subject_name + "_" + subject_code + "_FOM_Practical_Count";

            PreparedStatement ps2 = con.prepareStatement("select " + lcount + " from " + stu_muster + " where Student_ID=?");
            ps2.setString(1, student_id);
            ResultSet rs2 = ps2.executeQuery();
            if (rs2.next()) {
                total_practical = total_practical + rs2.getInt(1);

            } else {

                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Looks like Attendance has not been created yet.....<br>Please do that First</h2></b></center></font>");
                request.getRequestDispatcher(deliver).include(request, response);
            }
        }
        rs1.beforeFirst();

        while (rs.next()) {

            String subject_name = rs.getString(1);
            String subject_code = rs.getString(2);

            count = subject_name + "_" + subject_code + "_FMA_Count + " + subject_name + "_" + subject_code + "_SMA_Count + " + subject_name + "_" + subject_code + "_TMA_Count + " + subject_name + "_" + subject_code + "_FOMA_Count";

            PreparedStatement ps2 = con.prepareStatement("select " + count + " from " + stu_muster + " where Student_ID=? ");
            ps2.setString(1, student_id);
            ResultSet rs2 = ps2.executeQuery();
            if (rs2.next()) {

                l_att_total = l_att_total + rs2.getInt(1);

            } else {
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Looks like Attendance has not been created yet.....<br>Please do that First</h2></b></center></font>");
                request.getRequestDispatcher(deliver).include(request, response);
            }

        }
        while (rs1.next()) {

            String subject_name = rs1.getString(1);
            String subject_code = rs1.getString(2);

            count = subject_name + "_" + subject_code + "_FMA_Count + " + subject_name + "_" + subject_code + "_SMA_Count + " + subject_name + "_" + subject_code + "_TMA_Count + " + subject_name + "_" + subject_code + "_FOMA_Count";

            PreparedStatement ps2 = con.prepareStatement("select " + count + " from " + stu_muster + " where Student_ID=? ");
            ps2.setString(1, student_id);
            ResultSet rs2 = ps2.executeQuery();

            if (rs2.next()) {
                p_att_total = p_att_total + rs2.getInt(1);
            } else {
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Looks like Attendance has not been created yet.....<br>Please do that First</h2></b></center></font>");
                request.getRequestDispatcher(deliver).include(request, response);
            }

        }

        while (rs4.next()) {
            String leave = rs4.getString(1);
            PreparedStatement ps5 = con.prepareStatement("select " + leave + " from " + stu_muster + " where Student_ID=? ");
            ps5.setString(1, student_id);
            ResultSet rs5 = ps5.executeQuery();
            if (rs5.next()) {
                ex_add = ex_add + rs5.getInt(1);
            } else {
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Looks like Attendance has not been created yet.....<br>Please do that First</h2></b></center></font>");
                request.getRequestDispatcher(deliver).include(request, response);
            }
        }
        rs.beforeFirst();
        rs1.beforeFirst();
        rs4.beforeFirst();

        lp_att_total = l_att_total + p_att_total;
        lp_total = total_lecture + total_practical;
        float lp_totalf = lp_total;
        check_defaulter = (((lp_att_total + ex_add) / lp_totalf) * 100);
        DecimalFormat df = new DecimalFormat("#.##");
        check_defaulter = Float.parseFloat(df.format(check_defaulter));
        if ((check_defaulter <= ch2t) && (check_defaulter >= ch2f)) {

%>
<tr>
    <td>
        <label>
            <%=student_id%>
        </label>
    </td>
    <td>
        <label>
            <%=student_name%>
        </label>
    </td>
    <td>
        <label>
            <%=l_att_total%>
        </label>
    </td>

    <td>
        <label>
            <%=p_att_total%>
        </label>
    </td>
    <td>
        <label>
            <%=total_practical%>
        </label>
    </td>


    <td>
        <label>
            <%=lp_att_total%>
        </label>
    </td>
    <td>
        <label>
            <%=lp_total%>
        </label>
    </td>
    <td>
        <label>
            <%=ex_add%>
        </label>
    </td>
    <td>
        <label>
            <%=check_defaulter%>
        </label>
    </td>
</tr>
<%
        } else
            continue;
    }
    rs3.beforeFirst();
%>
</table>

<br><br>

<div align="center" class="label"><h1> Final Defaulter's from <font color="yellow"><%=ch3f%>%</font> to <font color="yellow"><%=ch3t%>%</font></h1></div>

<table align="center">
    <thead class="hi" style="font-size: 17px">
    <th>
        Student ID
    </th>
    <th>
        Student Name
    </th>

    <th>
        Total Lecture Attended(<font color="yellow">Out of=<%=total_lecture%></font>)
    </th>
    <th>
        Total Practical Attended
    </th>
    <th>
        Total Practical Taken
    </th>


    <th>
        Over All Attended
    </th>
    <th>
        Total Taken(Prac+Th+Leave)
    </th>
    <th>
        Extra Added
    </th>
    <th>
        Attendance(in %)
    </th>
</thead>
<%            rs.beforeFirst();
    rs1.beforeFirst();
    lp_total = 0;

    while (rs3.next()) {
        String count_month = "";
        String lcount_month = "";
        int l_att_total = 0;
        int lp_att_total = 0;

        int p_att_total = 0;
        int p_total = 0;
        int ex_add = 0;
        float check_defaulter = 0;
        String student_id = rs3.getString(1);
        String student_name = rs3.getString(2);
        String count = "";
        int total_practical = 0;

        while (rs1.next()) {
            String subject_name = rs1.getString(1);
            String subject_code = rs1.getString(2);
            String lcount = "";

            lcount = subject_name + "_" + subject_code + "_FM_Practical_Count+ " + subject_name + "_" + subject_code + "_SM_Practical_Count + " + subject_name + "_" + subject_code + "_TM_Practical_Count + " + subject_name + "_" + subject_code + "_FOM_Practical_Count";

            PreparedStatement ps2 = con.prepareStatement("select " + lcount + " from " + stu_muster + " where Student_ID=?");
            ps2.setString(1, student_id);
            ResultSet rs2 = ps2.executeQuery();
            if (rs2.next()) {
                total_practical = total_practical + rs2.getInt(1);

            } else {

                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Looks like Attendance has not been created yet.....<br>Please do that First</h2></b></center></font>");
                request.getRequestDispatcher(deliver).include(request, response);
            }
        }
        rs1.beforeFirst();

        while (rs.next()) {

            String subject_name = rs.getString(1);
            String subject_code = rs.getString(2);

            count = subject_name + "_" + subject_code + "_FMA_Count + " + subject_name + "_" + subject_code + "_SMA_Count + " + subject_name + "_" + subject_code + "_TMA_Count + " + subject_name + "_" + subject_code + "_FOMA_Count";

            PreparedStatement ps2 = con.prepareStatement("select " + count + " from " + stu_muster + " where Student_ID=? ");
            ps2.setString(1, student_id);
            ResultSet rs2 = ps2.executeQuery();
            if (rs2.next()) {

                l_att_total = l_att_total + rs2.getInt(1);

            } else {
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Looks like Attendance has not been created yet.....<br>Please do that First</h2></b></center></font>");
                request.getRequestDispatcher(deliver).include(request, response);
            }

        }
        while (rs1.next()) {

            String subject_name = rs1.getString(1);
            String subject_code = rs1.getString(2);

            count = subject_name + "_" + subject_code + "_FMA_Count + " + subject_name + "_" + subject_code + "_SMA_Count + " + subject_name + "_" + subject_code + "_TMA_Count + " + subject_name + "_" + subject_code + "_FOMA_Count";

            PreparedStatement ps2 = con.prepareStatement("select " + count + " from " + stu_muster + " where Student_ID=? ");
            ps2.setString(1, student_id);
            ResultSet rs2 = ps2.executeQuery();

            if (rs2.next()) {
                p_att_total = p_att_total + rs2.getInt(1);
            } else {
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Looks like Attendance has not been created yet.....<br>Please do that First</h2></b></center></font>");
                request.getRequestDispatcher(deliver).include(request, response);
            }

        }

        while (rs4.next()) {
            String leave = rs4.getString(1);
            PreparedStatement ps5 = con.prepareStatement("select " + leave + " from " + stu_muster + " where Student_ID=? ");
            ps5.setString(1, student_id);
            ResultSet rs5 = ps5.executeQuery();
            if (rs5.next()) {
                ex_add = ex_add + rs5.getInt(1);
            } else {
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Looks like Attendance has not been created yet.....<br>Please do that First</h2></b></center></font>");
                request.getRequestDispatcher(deliver).include(request, response);
            }
        }
        rs.beforeFirst();
        rs1.beforeFirst();
        rs4.beforeFirst();

        lp_att_total = l_att_total + p_att_total;
        lp_total = total_lecture + total_practical;
        float lp_totalf = lp_total;

        check_defaulter = (((lp_att_total + ex_add) / lp_totalf) * 100);
        DecimalFormat df = new DecimalFormat("#.##");
        check_defaulter = Float.parseFloat(df.format(check_defaulter));
        if ((check_defaulter <= ch3t) && (check_defaulter >= ch3f)) {

%>
<tr>
    <td>
        <label>
            <%=student_id%>
        </label>
    </td>
    <td>
        <label>
            <%=student_name%>
        </label>
    </td>
    <td>
        <label>
            <%=l_att_total%>
        </label>
    </td>

    <td>
        <label>
            <%=p_att_total%>
        </label>
    </td>
    <td>
        <label>
            <%=total_practical%>
        </label>
    </td>


    <td>
        <label>
            <%=lp_att_total%>
        </label>
    </td>
    <td>
        <label>
            <%=lp_total%>
        </label>
    </td>
    <td>
        <label>
            <%=ex_add%>
        </label>
    </td>
    <td>
        <label>
            <%=check_defaulter%>
        </label>
    </td>
</tr>
<%

        } else
            continue;
    }
%>
</table>

<div align="center">
    <button onclick="window.location.href = 'Form25_GD_View_Ask_Range.jsp'" id="b1">Back To Range</button>
    <button onclick="window.location.href = 'Form25_GD_View_Pr.jsp'" id="b2">Practical Att</button>
    <button onclick="window.location.href = 'Form25_GD_View_Th.jsp'" id="b3">Theory Att</button>
    <button onclick="window.location.href = 'Form25_GD.jsp'" id="b4">Home</button>
    <button onclick="doPrint()" id="b5" >PDF</button>
    <button onclick="doexcel()" id="b5" >PDF</button>
</div>
</body>
</html>
