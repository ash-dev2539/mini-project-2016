<%-- 
    Document   : Form17_SL_Muster_Before
    Created on : Dec 1, 2016, 10:55:43 PM
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
                width:300px;
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
                width:200px;
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
    <body><%
        HttpSession ses = request.getSession(false);
        if (ses.getAttribute("empid") == null || ses.getAttribute("empid").equals("")) {
            request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
            request.getRequestDispatcher("Login.jsp").include(request, response);
        } else {

            int empid = (Integer) ses.getAttribute("empid");
            String academic_year = (String) ses.getAttribute("academic_year");
            // String semester = (String) ses.getAttribute("Semester");

            String muster = request.getParameter("Muster");
            String subject_type = request.getParameter("Subject_Type");
            ses.setAttribute("subject_type", subject_type);
            Connection con = DBconnection.dbconnection.createConnection();
            ses.setAttribute("subject_type", subject_type);
            if (subject_type.equals("Theory")) {
                PreparedStatement ps = con.prepareStatement("select * from Theory_Muster_Allocation where Muster_Name=? and Faculty_ID=? ");
                ps.setString(1, muster);
                ps.setInt(2, empid);
                ResultSet rs = ps.executeQuery();
                rs.next();
                String year = rs.getString("Year");
                String branch = rs.getString("Branch");
                String division = rs.getString("Division");
                String subject_code = rs.getString("Subject_Code");
                String Faculty_Name = rs.getString("Faculty_Name");
                String Subject_Name = rs.getString("Subject_Name");
                String semester=rs.getString("Semester");

                String table_name = empid + "_" + academic_year + "_" + year + "_" + branch + "_" + division + "_" + subject_code + "_" + muster;
                ses.setAttribute("table_name", table_name);
                ses.setAttribute("branch", branch);
                ses.setAttribute("division", division);
                ses.setAttribute("faculty_name", Faculty_Name);
                ses.setAttribute("subject_name", Subject_Name);
                ses.setAttribute("year", year);
                ses.setAttribute("semester", semester);
            } else {
                PreparedStatement ps = con.prepareStatement("select * from Practical_Muster_Allocation where Muster_Name=? and Faculty_ID=? ");
                ps.setString(1, muster);
                ps.setInt(2, empid);
                ResultSet rs = ps.executeQuery();
                rs.next();
                String year = rs.getString("Year");
                String branch = rs.getString("Branch");
                String division = rs.getString("Division");
                String subject_code = rs.getString("Subject_Code");
                String Faculty_Name = rs.getString("Faculty_Name");
                String Subject_Name = rs.getString("Subject_Name");
                int roll_from = rs.getInt("Roll_From");
                int roll_to = rs.getInt("Roll_To");
                String semester=rs.getString("Semester");
                String table_name = empid + "_" + academic_year + "_" + year + "_" + branch + "_" + division + "_" + subject_code + "_" + muster;

                ses.setAttribute("table_name", table_name);
                ses.setAttribute("branch", branch);
                ses.setAttribute("division", division);
                ses.setAttribute("faculty_name", Faculty_Name);
                ses.setAttribute("subject_name", Subject_Name);
                ses.setAttribute("year", year);
                 ses.setAttribute("semester", semester);

            }

            PreparedStatement ps6 = con.prepareStatement("select Designation from Faculty_Personal_Details where Emp_ID=? ");
            ps6.setInt(1, empid);
            ResultSet rs6 = ps6.executeQuery();
            rs6.next();
            String faculty_designation = rs6.getString(1);
            String deliver = "";
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

        %>

        <br><br><br><br>

        <div id="login">


            <h1>Please Select a Month</h1>

            <form action="Form17_SL_Muster.jsp" method="get">  
                <table>
                    <tr>

                        <td>  <select name="month" required style="font-size: 20px;width: 200px">
                            <option selected disabled></option>
                            <option>1st Month</option>
                            <option>2nd Month</option>
                            <option>3rd Month</option>
                            <option>4th Month</option>
                        </select></td>

                    </tr>

                </table>

                <input type="submit" value="Display">

            </form>

        </div>

        <div align="center"><button  onclick="window.location.href = '<%=deliver%>'">Go Back</button></div>


        <%}%>
    </body>
</html>
