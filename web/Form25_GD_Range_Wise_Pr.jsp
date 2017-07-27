<%-- 
    Document   : Form25_GD_Month_Wise
    Created on : Sep 17, 2016, 1:51:24 PM
    Author     : sandeep
--%>


<%@page import="java.util.Calendar"%>
<%@page import="org.apache.poi.ss.usermodel.DateUtil"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.DatabaseMetaData"%>
<%@page import="java.util.ArrayList"%>
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
            h1{
                font-size: 30px;
                
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
        <style type="text/css" media="print">
            @page {
                size: auto;   /* auto is the initial value */
                margin: 0;  /* this affects the margin in the printer settings */
            }
        </style>

    </head>
    <body id="wow">
        <script type="text/javascript">
            function doPrint() {
                //  var b1 = document.getElementById("b1");
                //   b1.style.visibility = "hidden";
                var b2 = document.getElementById("b2");
                b2.style.visibility = "hidden";
                var b3 = document.getElementById("b3");
                b3.style.visibility = "hidden";
                var b5 = document.getElementById("b5");
                b5.style.visibility = "hidden";
                document.getElementById("wow").style.color = "black";
                window.print();

                //  b1.style.visibility = "visible";
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
            try {
                Connection con = DBconnection.dbconnection.createConnection();
                int percent = (Integer) ses.getAttribute("percent");
                String Date_F = (String) ses.getAttribute("Date_F");
                String Date_T = (String) ses.getAttribute("Date_T");
                /* String Date_From = (String) ses.getAttribute("Date_From");
            String Date_To = (String) ses.getAttribute("Date_To");
            int Month_From = Integer.parseInt(Date_From.substring(3, 5));
            int Month_To = Integer.parseInt(Date_To.substring(3, 5));
            int Year_From = Integer.parseInt(Date_From.substring(6, 10));
            int Year_To = Integer.parseInt(Date_To.substring(6, 10));
            int Day_From = Integer.parseInt(Date_From.substring(0, 2));
            int Day_To = Integer.parseInt(Date_To.substring(0, 2));*/
        %>
        
          <div align="center" style="color: white"><h1>Practical-Attendance From = <font color="yellow"><%=Date_F%></font> To = <font color="yellow"><%=Date_T%></font> </h1></div>
        
          <%
            //System.out.println(Date_From);
// Output "2012-09-26"
            String[] Hour = {"1hr", "2hrs", "3hrs", "4hrs", "5hrs", "6hrs", "7hrs", "8hrs"};

            String year = (String) ses.getAttribute("year");
            String branch = (String) ses.getAttribute("branch");
            String division = (String) ses.getAttribute("division");
            String academic_year = (String) ses.getAttribute("academic_year");
            String semester = (String) ses.getAttribute("semester");
            PreparedStatement ps5 = con.prepareStatement("select max(Batch_No) from Practical_Muster_Allocation where Academic_Year=? and Year=? and Branch=? and Division=? and Semester=? order by Batch_No ");
            ps5.setString(1, academic_year);
            ps5.setString(2, year);
            ps5.setString(3, branch);
            ps5.setString(4, division);
            ps5.setString(5, semester);
            ResultSet rs5 = ps5.executeQuery();
            rs5.next();
            int batch_count = rs5.getInt(1);
            for (int i = 0; i < batch_count; i++) {
                PreparedStatement ps7 = con.prepareStatement("select Faculty_ID,Subject_Code,Muster_Name,Subject_Name,Roll_From,Roll_To from Practical_Muster_Allocation where Academic_Year=? and Year=? and Branch=? and Division=? and Semester=? and Batch_No=? ");
                ps7.setString(1, academic_year);
                ps7.setString(2, year);
                ps7.setString(3, branch);
                ps7.setString(4, division);
                ps7.setString(5, semester);
                ps7.setInt(6, i + 1);
                ResultSet rs7 = ps7.executeQuery();
                PreparedStatement ps9 = con.prepareStatement("select max(Roll_From),max(Roll_To) from Practical_Muster_Allocation where Academic_Year=? and Year=? and Branch=? and Division=? and Semester=? and Batch_No=? ");
                ps9.setString(1, academic_year);
                ps9.setString(2, year);
                ps9.setString(3, branch);
                ps9.setString(4, division);
                ps9.setString(5, semester);
                ps9.setInt(6, i + 1);
                ResultSet rs9 = ps9.executeQuery();
                rs9.next();
                int roll_from = rs9.getInt(1);
                int roll_to = rs9.getInt(2);
                String stu_muster = academic_year + "_" + year + "_" + branch + "_" + semester + "_" + division + "_Muster";
                PreparedStatement ps8 = con.prepareStatement("select Student_ID,Student_Name from " + stu_muster + " where Student_Roll_No between " + roll_from + " and " + roll_to + " order by Student_Roll_No ");
                ResultSet rs8 = ps8.executeQuery();
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

        <div class="label" align="center"  style="font-size: 20px">Batch <%=i + 1%></div>
        <table align="center">
            <thead class="hi" style="font-size: 15px">
            <th>
             Student ID
            </th>
            <th>
              Student Name
            </th>
            <%
                if (rs7.next()) {
                    rs7.beforeFirst();
                    while (rs7.next()) {
                        String subject_name = rs7.getString(4);
            %>
            <th>
                Lecture(s) Attended in <font color="yellow"><%=subject_name%></font>
            </th>
            <th>
                Total Lecture(s) in <font color="yellow"><%=subject_name%></font>
            </th>
            <%
                    }
                }
                rs7.beforeFirst();
            %>
            <th>
                Percentage
            </th>
            <th>
              Status
            </th>
        </thead>
        <%if (rs8.next()) {
                rs8.beforeFirst();
                while (rs8.next()) {
                    String stu_id = rs8.getString(1);
                    String stu_name = rs8.getString(2);

                    // String Date_From = Date_F.replaceAll(("-"), "_");
                    // String Date_To = Date_T.replaceAll(("-"), "_");
                    SimpleDateFormat format = new SimpleDateFormat("dd-MM-yyyy");
                    Date myDate_F = format.parse(Date_F);
                    Date myDate_T = format.parse(Date_T);

                    Calendar cal_from = Calendar.getInstance();
                    Calendar cal_to = Calendar.getInstance();

                    cal_to.setTime(myDate_T);
                    String Date_From = "";

                    String Date_To = format.format(cal_to.getTime());
                    System.out.print("Ok=" + Date_To);
                    String date_to = Date_To.replaceAll(("-"), "_");
                    System.out.print("Date To=" + date_to);

                    int overall_lecture_attend = 0;
                    int overall_lecture = 0;

        %>
        <tr>
            <td>
                <label>
                    <%=stu_id%>
                </label>
            </td>
            <td>
                <label>
                    <%=stu_name%>
                </label>
            </td>
            <%
                if (rs7.next()) {
                    rs7.beforeFirst();
                    while (rs7.next()) {

                        int lecture_attend = 0;
                        int total_lecture = 0;
                        int f_id = rs7.getInt(1);
                        cal_from.setTime(myDate_F);
                        String date_from = "";
                        System.out.println("Student id " + stu_id + "\nFaculty ID=" + f_id);
                        String subject_code = rs7.getString(2);
                        String muster = rs7.getString(3);
                        // String subject_name = rs7.getString(4);
                        ArrayList str = new ArrayList();
                        String table_name = f_id + "_" + academic_year + "_" + year + "_" + branch + "_" + division + "_" + subject_code + "_" + muster;
                        while (!date_from.equals(date_to)) {

                            Date_From = format.format(cal_from.getTime());
                            date_from = Date_From.replaceAll(("-"), "_");
                            System.out.println("\n date_from=" + date_from);
                            for (int k = 0; k < 8; k++) {
                                String column = date_from + "_" + Hour[k];
                                DatabaseMetaData metadata = con.getMetaData();
                                ResultSet rs3 = metadata.getColumns(null, null, table_name, column);
                                System.out.println("Reached column count " + column + " \ntable name " + table_name);

                                if (rs3.next()) {

                                    System.out.println("\n adding column" + column);
                                    str.add(column);

                                }
                            }
                            System.out.print(str);
                            cal_from.add(Calendar.DATE, 1);

                        }

                        int count_str = str.size();
                        for (int j = 0; j < count_str; j++) {
                            PreparedStatement ps6 = con.prepareStatement("select " + str.get(j) + " from " + table_name + " where Student_ID=? ");
                            ps6.setString(1, stu_id);
                            ResultSet rs6 = ps6.executeQuery();
                            if (rs6.next()) {
                                String check = rs6.getString(1);
                                if (check.equals("P")) {
                                    lecture_attend++;

                                }
                                total_lecture++;

                            } else {
                                System.out.print("error");
                            }

                        }
            %>


            <td>
                <label>
                    <%=lecture_attend%>
                </label>
            </td>
            <td>
                <label>
                    <%=total_lecture%>
                </label>
            </td>

            <%
                        overall_lecture_attend = overall_lecture_attend + lecture_attend;
                        overall_lecture = overall_lecture + total_lecture;

                    }
                } else {
                    System.out.print("error......i'm fain...n..tttti...ng.......");
                }
                String status = "";

                float check = (float) ((overall_lecture_attend * 100 / overall_lecture));
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
                rs7.beforeFirst();
            %>

        </tr>
        <%
                }
            } else {
                System.out.print("errrrrrrrr rrrrr o");
            }


        %>

    </table>
    <%            }
    %>


    <div align="center">
        <%--<button onclick="window.location.href = 'Form25_GD_Month.jsp'" id="b1">View Defaulter List</button>--%>
        <button onclick="window.location.href = 'Form25_GD.jsp'" id="b2">Go Back</button>
        <button onclick="window.location.href = 'Form25_GD_Range_Wise_Th.jsp'" id="b3">View Theory Attendance</button>
        <button onclick="doPrint()" id="b5" >PDF</button>
    </div>
</body>
<%
    } catch (Exception e) {
        out.print(e);

    }
%>
</html>
