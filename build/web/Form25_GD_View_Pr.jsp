<%-- 
    Document   : Form25_GD_Month_Wise
    Created on : Sep 17, 2016, 1:51:24 PM
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
                width:600px;
                margin:0 auto;
                margin-top:8px;
                margin-bottom:2%;
                transition:opacity 1s;
                -webkit-transition:opacity 1s;
            }
            .label{
                width:100px;
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
            }

            String year = (String) ses.getAttribute("year");
            String branch = (String) ses.getAttribute("branch");
            String division = (String) ses.getAttribute("division");
            String academic_year = (String) ses.getAttribute("academic_year");
            String semester = (String) ses.getAttribute("semester");
            String stu_muster = academic_year + "_" + year + "_" + branch + "_" + semester + "_" + division + "_Muster";

            Connection con = DBconnection.dbconnection.createConnection();

            PreparedStatement ps1 = con.prepareStatement("select distinct(Prac_Subject_Name),Prac_Subject_Code from Faculty_Allocation_Subjectwise_Pr where Academic_Year=? and Year=? and Branch=? and Division=? and Semester=? ");
            ps1.setString(1, academic_year);
            ps1.setString(2, year);
            ps1.setString(3, branch);
            ps1.setString(4, division);
            ps1.setString(5, semester);
            ResultSet rs1 = ps1.executeQuery();

            PreparedStatement ps4 = con.prepareStatement("select distinct(Batch_No),Roll_From,Roll_To from Practical_Muster_Allocation where Academic_Year=? and Year=? and Branch=? and Division=? and Semester=? order by Batch_No ");
            ps4.setString(1, academic_year);
            ps4.setString(2, year);
            ps4.setString(3, branch);
            ps4.setString(4, division);
            ps4.setString(5, semester);
            ResultSet rs4 = ps4.executeQuery();

            PreparedStatement ps5 = con.prepareStatement("select max(Batch_No) from Practical_Muster_Allocation where Academic_Year=? and Year=? and Branch=? and Division=? and Semester=? order by Batch_No ");
            ps5.setString(1, academic_year);
            ps5.setString(2, year);
            ps5.setString(3, branch);
            ps5.setString(4, division);
            ps5.setString(5, semester);
            ResultSet rs5 = ps5.executeQuery();
            rs5.next();
            int batch_count = rs5.getInt(1);

        %>
        <div align="center" style="color: greenyellow"><h1>Final-Practical-Attendance</h1></div>

        <%            for (int i = 0; i < batch_count; i++) {
                rs4.next();
                int roll_from = rs4.getInt(2);
                int roll_to = rs4.getInt(3);
                %><div class="label" align="center"  style="font-size: 20px">Batch <%=i + 1%></div>

        <table align="center">
            <thead class="hi" style="font-size: 15px">
            <th>
                Student ID
            </th>
            <th>
                Student Name
            </th>
            <%
                while (rs1.next()) {
                    String subject_name = rs1.getString(1);
                    String subject_code = rs1.getString(2);
                    String lcount = "";
                    int total_lecture = 0;

                    lcount = subject_name + "_" + subject_code + "_FM_Practical_Count+ " + subject_name + "_" + subject_code + "_SM_Practical_Count + " + subject_name + "_" + subject_code + "_TM_Practical_Count + " + subject_name + "_" + subject_code + "_FOM_Practical_Count";

                    PreparedStatement ps2 = con.prepareStatement("select max(" + lcount + ") from " + stu_muster + " where Student_Roll_No between " + roll_from + " and " + roll_to);
                    ResultSet rs2 = ps2.executeQuery();
                    if (rs2.next()) {
                        total_lecture = rs2.getInt(1);

                    } else {
                        request.setAttribute("errorMessage","<font color='red'><center><b><h2>Looks like Attendance has not been created yet.....<br>Please do that First</h2></b></center></font>");
                        request.getRequestDispatcher("Form13_CT_Login.jsp").include(request, response);
                    }

            %>
            <th>
                Practical Attended(<font color="yellow">Out of=<%=total_lecture%></font>) in <font color="yellow"><%=subject_name%></font>
            </th>
            <%
                }
                rs1.beforeFirst();

            %>

        </thead>
        <%            PreparedStatement ps3 = con.prepareStatement("select Student_ID,Student_Name from " + stu_muster + " where Student_Roll_No between " + roll_from + " and " + roll_to + " order by Student_Roll_No");
            String count_month = "";
            String lcount_month = "";
            ResultSet rs3 = ps3.executeQuery();

            while (rs3.next()) {
                int l_att_total = 0;
                int lp_att_total = 0;
                int lp_total = 0;
                int p_att_total = 0;
                float check_defaulter = 0;
                String count = "";
                String student_id = rs3.getString(1);
                String student_name = rs3.getString(2);


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
            <%
                while (rs1.next()) {
                    p_att_total = 0;

                    String subject_name = rs1.getString(1);
                    String subject_code = rs1.getString(2);

                    count = subject_name + "_" + subject_code + "_FMA_Count + " + subject_name + "_" + subject_code + "_SMA_Count + " + subject_name + "_" + subject_code + "_TMA_Count + " + subject_name + "_" + subject_code + "_FOMA_Count";

                    PreparedStatement ps2 = con.prepareStatement("select " + count + " from " + stu_muster + " where Student_ID=? ");
                    ps2.setString(1, student_id);
                    ResultSet rs2 = ps2.executeQuery();

                    if (rs2.next()) {
                        p_att_total = p_att_total + rs2.getInt(1);
                    } else {
                        request.setAttribute("errorMessage","<font color='red'><center><b><h2>Looks like Attendance has not been created yet.....<br>Please do that First</h2></b></center></font>");
                        request.getRequestDispatcher("Form13_CT_Login.jsp").include(request, response);
                    }

            %>
            <td>
                <label>
                    <%=p_att_total%>
                </label>
            </td>
            <%                }
                rs1.beforeFirst();


            %>
        </tr>
        <%            }
            rs3.beforeFirst();
        %>
    </table>
    <%
        }
    %>

    <div align="center">
        <button onclick="window.location.href = 'Form25_GD_View_Ask_Range.jsp'">View Final Defaulter List</button>
    </div>
</body>
</html>
