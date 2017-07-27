<%-- 
    Document   : Form17_SL_Muster
    Created on : Dec 1, 2016, 10:56:16 PM
    Author     : sandeep
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.DatabaseMetaData"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
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
            form{
                background:#f0f0f0;
                padding:2% 4%;
            }

            input[type="text"],input[type="password"],input[type="tel"]{
                width:92%;

                font-family:'Open Sans',sans-serif;
                font-size:100%;

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
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
                request.getRequestDispatcher("Login.jsp").include(request, response);

            } else {
                Connection con = DBconnection.dbconnection.createConnection();
                String deliver = "";
                try {

                    int empid = (Integer) ses.getAttribute("empid");
                    
                    String month = request.getParameter("month");
                    String academic_year = (String) ses.getAttribute("academic_year");
                    String year = (String) ses.getAttribute("year");
                    String branch = (String) ses.getAttribute("branch");
                    String semester = (String) ses.getAttribute("semester");
                    String division = (String) ses.getAttribute("division");
                    PreparedStatement ps6 = con.prepareStatement("select Designation from Faculty_Personal_Details where Emp_ID=? ");
                    ps6.setInt(1, empid);
                    ResultSet rs6 = ps6.executeQuery();
                    rs6.next();
                    String faculty_designation = rs6.getString(1);

                    if (faculty_designation.equals("Faculty")) {
                        PreparedStatement ps10 = con.prepareStatement("select * from Class_Teacher_Details where Emp_ID=?");
                        ps10.setInt(1, empid);
                        ResultSet rs10 = ps10.executeQuery();
                        if (rs10.next()) {
                            deliver = "CT_Own_Musters.jsp";
                        } else {
                            deliver = "Form17_SL.jsp";
                        }
                    } else if (faculty_designation.equals("Vice_Principal")) {

                        deliver = "CT_Own_Musters.jsp";
                    } else if (faculty_designation.equals("HOD")) {

                        deliver = "CT_Own_Musters.jsp";
                    }

                    PreparedStatement ps0 = con.prepareStatement("select Month1,Month2,Month3,Month4 from Month_Entry where Academic_Year=? and Year=? and Branch=? and Semester=? and Division=?");

                    ps0.setString(1, academic_year);
                    ps0.setString(2, year);
                    ps0.setString(3, branch);
                    ps0.setString(4, semester);
                    ps0.setString(5, division);
                    int month_num = 0;
                    ResultSet rs0 = ps0.executeQuery();
                    if (rs0.next()) {

                        if (month.equals("1st Month")) {
                            month_num = rs0.getInt(1);
                        } else if (month.equals("2nd Month")) {
                            month_num = rs0.getInt(2);
                        } else if (month.equals("3rd Month")) {
                            month_num = rs0.getInt(3);
                        } else if (month.equals("4th Month")) {
                            month_num = rs0.getInt(4);
                        }

                    } else {
                        request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Month has not been initialised......</h2></b></center></font>");
                        request.getRequestDispatcher(deliver).include(request, response);
                    }

                    
                    SimpleDateFormat format = new SimpleDateFormat("dd-MM-yyyy");
                    Date date = format.parse("1-" + month_num + "-" + academic_year);
                    System.out.print("date_wa"+date);
                    Calendar cal = Calendar.getInstance();

                    cal.setTime(date);
                    String Date_To = format.format(cal.getTime());
                    System.out.print("Ok=" + Date_To);
                    //String date_to = Date_To.replaceAll(("-"), "_");
                   // System.out.print("Date To=" + date_to);
                    // String year = (String) ses.getAttribute("year");
                    String table_name = (String) ses.getAttribute("table_name");
                    String[] Hour = {"1hr", "2hrs", "3hrs", "4hrs", "5hrs", "6hrs", "7hrs", "8hrs"};
                    String date_to=null;
                    PreparedStatement ps1 = con.prepareStatement("select count(Student_Roll_No) from " + table_name);
                    ResultSet rs1 = ps1.executeQuery();
                    if (rs1.next()) {
                        int count = rs1.getInt(1);

                        PreparedStatement ps = con.prepareStatement("select Student_Roll_No,Student_Name from " + table_name);
                        ResultSet rs = ps.executeQuery();

                        ArrayList str = new ArrayList();
                        for (int l = 1; l <= 31; l++) {

                            Date_To = format.format(cal.getTime());
                            date_to = Date_To.replaceAll(("-"), "_");
                            for (int k = 0; k < 8; k++) {
                                String column = date_to + "_" + Hour[k];
                                DatabaseMetaData metadata = con.getMetaData();
                                ResultSet rs4 = metadata.getColumns(null, null, table_name, column);
                                System.out.println("Reached column count" + column);
                                int found = 0;

                                if (rs4.next()) {

                                    str.add(column);

                                } else {
                                    continue;
                                }
                            }
                            cal.add(Calendar.DATE, 1);

                        }
                        int count_str = str.size();


        %>
        <span class="lab" align="center"><h3>Below Is the attendance visual look for month <%=month_num%></h3></span>

        <span style="position:absolute;top:20px;right:20px;">
            <button onclick="window.location.href = '<%=deliver%>'">Home Page</button>  

        </span>
        <table align="center">
            <thead class="hi" style="font-size: 15px">
            <th>
                Student Roll
            </th>
            <th>
                Student Name
            </th>



            <%            for (int k = 0; k < count_str; k++) {

            %>


            <th><%=str.get(k)%></th>
                <%
                    }
                %>
        </thead>

        <%
            while (rs.next()) {

        %>
        <tr>
            <td> 
                <input style="width: 35px" type="text" value="<%=rs.getInt(1)%>" readonly>
            </td>
            <td>
                <input style="width: 300px" type="text" value="<%=rs.getString(2)%>" readonly>
            </td>
            <%            for (int k = 0; k < count_str; k++) {
                    PreparedStatement ps3 = con.prepareStatement("select " + str.get(k) + " from " + table_name + " where Student_Roll_No=? ");
                    ps3.setInt(1, rs.getInt(1));
                    ResultSet rs3 = ps3.executeQuery();
                    rs3.next();
            %>
            <td>
                <input style="width: 35px" type="text" value="<%=rs3.getString(1)%>" readonly>
            </td>
            <%
                }

            %> 
        </tr>
        <%                                }

        %>
    </table>
    <div align="center">
        <button onclick="window.location.href = '<%=deliver%>'">Home Page</button>  
    </div>
    <%
                }

            } catch (Exception e) {
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>There is no Attendance Record present with the given name...Please Contact the Administrator...</h2></b></center></font>" + e);
                request.getRequestDispatcher(deliver).include(request, response);
            }
        }
    %>
</body>
</html>
