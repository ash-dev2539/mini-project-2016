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
        <style type="text/css" media="print">
            @page {
                size: auto;   /* auto is the initial value */
                margin: 0;  /* this affects the margin in the printer settings */
            }
        </style>
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
    <body id="wow">
        <script type="text/javascript">
            function doPrint() {
                var b1 = document.getElementById("b1");
                b1.style.visibility = "hidden";
                var b2 = document.getElementById("b2");
                b2.style.visibility = "hidden";
                var b3 = document.getElementById("b3");
                b3.style.visibility = "hidden";
                var b5 = document.getElementById("b5");
                b5.style.visibility = "hidden";
                document.getElementById("wow").style.color = "black";
                window.print();

                b1.style.visibility = "visible";
                b2.style.visibility = "visible";
                b3.style.visibility = "visible";
                b5.style.visibility = "visible";
            }

        </script>

        <%
            HttpSession ses = request.getSession(false);
            if (ses.getAttribute("empid") == null || ses.getAttribute("empid").equals("")) {
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
                request.getRequestDispatcher("Login.jsp").include(request, response);
            }

            int percent = (Integer) ses.getAttribute("percent");
            int academic_month = (Integer) ses.getAttribute("academic_month");

            String year = (String) ses.getAttribute("year");
            String branch = (String) ses.getAttribute("branch");
            String division = (String) ses.getAttribute("division");
            String academic_year = (String) ses.getAttribute("academic_year");
            String semester = (String) ses.getAttribute("semester");
            String stu_muster = academic_year + "_" + year + "_" + branch + "_" + semester + "_" + division + "_Muster";

            Connection con = DBconnection.dbconnection.createConnection();
            PreparedStatement ps = con.prepareStatement("select Subject_Name,Subject_Code from Faculty_Allocation_Subjectwise_Th where Academic_Year=? and Year=? and Branch=? and Division=? and Semester=? ");
            ps.setString(1, academic_year);
            ps.setString(2, year);
            ps.setString(3, branch);
            ps.setString(4, division);
            ps.setString(5, semester);
            ResultSet rs = ps.executeQuery();

            PreparedStatement ps3 = con.prepareStatement("select Student_ID,Student_Name from " + stu_muster + " order by Student_Roll_No");
            String count_month = "";
            String lcount_month = "";
            ResultSet rs3 = ps3.executeQuery();
            int empid = (Integer) ses.getAttribute("empid");
            PreparedStatement ps4 = con.prepareStatement("select Designation from Faculty_Personal_Details where Emp_ID=? ");
            ps4.setInt(1, empid);
            ResultSet rs4 = ps4.executeQuery();
            rs4.next();
            String faculty_designation = rs4.getString(1);
            String deliver = "";
            if (faculty_designation.equals("Faculty")) {
                deliver = "Form13_CT_Login.jsp";
            } else if (faculty_designation.equals("Principal") || faculty_designation.equals("Vice_Principal")) {

                deliver = "Principal_Check_Status.jsp";
            } else if (faculty_designation.equals("HOD")) {

                deliver = "HOD_Check_Status.jsp";
            }

        %>
        <div align="center" style="color: white"><h1>Till <font color="yellow">Month <%=academic_month%> </font>Theory-Attendance</h1></div>


        <table align="center">
            <thead class="hi" style="font-size: 15px">
            <th>
                Student ID
            </th>
            <th>
                Student Name
            </th>
            <%
                int overall_lectures = 0;

                while (rs.next()) {
                    String subject_name = rs.getString(1);
                    String subject_code = rs.getString(2);
                    String count = "";
                    String lcount = "";
                    int total_lecture = 0;
                    switch (academic_month) {
                        case 1: {

                            lcount = subject_name + "_" + subject_code + "_FM_Lecture_Count";

                        }
                        break;
                        case 2: {

                            lcount = subject_name + "_" + subject_code + "_FM_Lecture_Count+ " + subject_name + "_" + subject_code + "_SM_Lecture_Count";

                        }
                        break;
                        case 3: {

                            lcount = subject_name + "_" + subject_code + "_FM_Lecture_Count+ " + subject_name + "_" + subject_code + "_SM_Lecture_Count+ " + subject_name + "_" + subject_code + "_TM_Lecture_Count";
                        }
                        break;
                        case 4: {

                            lcount = subject_name + "_" + subject_code + "_FM_Lecture_Count+ " + subject_name + "_" + subject_code + "_SM_Lecture_Count + " + subject_name + "_" + subject_code + "_TM_Lecture_Count + " + subject_name + "_" + subject_code + "_FOM_Lecture_Count";
                        }
                        break;
                        default: {
                            request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Sorry...There was an internal error..Please try again</h2></b></center></font>");
                            request.getRequestDispatcher(deliver).include(request, response);
                        }
                    }

                    PreparedStatement ps2 = con.prepareStatement("select max(" + lcount + ") from " + stu_muster);
                    ResultSet rs2 = ps2.executeQuery();
                    if (rs2.next()) {
                        total_lecture = rs2.getInt(1);
                        overall_lectures = overall_lectures + total_lecture;

                    } else {
                        request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Looks like Attendance has not been created yet</h2></b></center></font>");
                        request.getRequestDispatcher(deliver).include(request, response);
                    }

            %>
            <th>
                Lecture Attended(<font color="yellow">Out of=<%=total_lecture%></font>) in <font color="yellow"><%=subject_name%></font>
            </th>
            <%
                }
                rs.beforeFirst();

            %>
            <th>
                Percentage
            </th>
            <th>
                Status
            </th>
        </thead>
        <%            while (rs3.next()) {
                int l_att_total = 0;
                int lp_att_total = 0;
                int lp_total = 0;
                int p_att_total = 0;
                float check_defaulter = 0;
                String count = "";
                int overall_attended = 0;
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
            <%            while (rs.next()) {
                    l_att_total = 0;
                    String subject_name = rs.getString(1);
                    String subject_code = rs.getString(2);

                    switch (academic_month) {
                        case 1: {
                            count = subject_name + "_" + subject_code + "_FMA_Count";

                        }
                        break;
                        case 2: {
                            count = subject_name + "_" + subject_code + "_FMA_Count + " + subject_name + "_" + subject_code + "_SMA_Count";

                        }
                        break;
                        case 3: {
                            count = subject_name + "_" + subject_code + "_FMA_Count + " + subject_name + "_" + subject_code + "_SMA_Count + " + subject_name + "_" + subject_code + "_TMA_Count";
                        }
                        break;
                        case 4: {
                            count = subject_name + "_" + subject_code + "_FMA_Count + " + subject_name + "_" + subject_code + "_SMA_Count + " + subject_name + "_" + subject_code + "_TMA_Count + " + subject_name + "_" + subject_code + "_FOMA_Count";
                        }
                        break;
                        default: {
                            request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Sorry...There was an internal error..Please try again</h2></b></center></font>");
                            request.getRequestDispatcher(deliver).include(request, response);
                        }
                    }

                    PreparedStatement ps2 = con.prepareStatement("select " + count + " from " + stu_muster + " where Student_ID=? ");
                    ps2.setString(1, student_id);
                    ResultSet rs2 = ps2.executeQuery();
                    if (rs2.next()) {

                        l_att_total = l_att_total + rs2.getInt(1);

                    } else {
                        request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Looks like Attendance has not been created yet.</h2></b></center></font>");
                        request.getRequestDispatcher(deliver).include(request, response);
                    }
                    overall_attended = overall_attended + l_att_total;


            %>
            <td>
                <label>
                    <%=l_att_total%>
                </label>
            </td>


            <%            }
                String status = "";

                float check = (float) ((overall_attended * 100 / overall_lectures));
                if (check < percent) {
                    status = "Defaulter";
                } else {
                    status = "Regular";
                }

            %>
            <td>
                <label>
                    <%=check%>
                </label>
            </td>
            <td>
                <label>
                    <%=status%>
                </label>
            </td>
            <%
                rs.beforeFirst();
            %>

        </tr>
        <%            }
        %>
    </table>

    <div align="center">
        <button onclick="window.location.href = 'Form25_GD_Month.jsp'" id="b1">View Defaulter List</button>
        <button onclick="window.location.href = 'Form25_GD.jsp'" id="b2">Go Back</button>
        <button onclick="window.location.href = 'Form25_GD_Month_Wise_Pr.jsp'" id="b3">View Practical Attendance</button>
        <button onclick="doPrint()" id="b5" >PDF</button>
    </div>
</body>
</html>
