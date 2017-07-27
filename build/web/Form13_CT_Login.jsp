<%-- 
    Document   : Form13_CT_Login
    Created on : Sep 2, 2016, 10:55:32 AM
    Author     : Administrator
--%>


<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="false"%>
<html>
    <head>
        <script type="text/javascript" src="js/jquery-1.8.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Class Teacher Login </title>
        <link href="cool.css" rel="stylesheet" type="text/css">


    </head>
    <body>
        <script type="text/javascript">
            $(function () {
                setTimeout(function () {
                    $("#testdiv").fadeOut(1000);
                }, 7599);             
            });
        </script>
        <br><br><br><br><br><br>
    <center>
        <%
            HttpSession ses = request.getSession(false);
            if (ses.getAttribute("empid") == null || ses.getAttribute("empid").equals("")) {
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
                request.getRequestDispatcher("Login.jsp").include(request, response);
            } else {
                Date hour=new Date();
                Calendar c1 = GregorianCalendar.getInstance();
                c1.setTime(hour);
                int hr=c1.get(Calendar.HOUR_OF_DAY);
                
                String wish="Good Morning";
                 if(hr>=12&&hr<18)
                 {
                 wish="Good Afternoon";
                 }
                 else if(hr>=18&&hr<24)
                 {
                 wish="Good Evening";
                 }
                
                int empid = (Integer) ses.getAttribute("empid");
                Connection con = DBconnection.dbconnection.createConnection();
                String academic_year = (String) ses.getAttribute("academic_year");
                String semester = (String) ses.getAttribute("semester");
                PreparedStatement ps = con.prepareStatement("select Fname,Lname from Faculty_Personal_Details where Emp_ID=? ");
                ps.setInt(1, empid);
                ResultSet rs = ps.executeQuery();
                String name = "";
                PreparedStatement ps1 = con.prepareStatement("select Branch,Division,Year from Class_Teacher_Details where Emp_ID=? and Academic_Year=? ");
                ps1.setInt(1, empid);
                ps1.setString(2, academic_year);
                ResultSet rs1 = ps1.executeQuery();
                if (rs1.next()) {

                    String branch = rs1.getString(1);
                    String division = rs1.getString(2);
                    String year = rs1.getString(3);
                    ses.setAttribute("branch", branch);
                    ses.setAttribute("division", division);
                    ses.setAttribute("year", year);

                }

                if (rs.next()) {
                    name = rs.getString(1) + " " + rs.getString(2);
                }
        %>
        <div align="left"><label class="topcornerl" style="font-size: 30px;color: white "><%=wish%> <%=name%></label></div>
                    <jsp:include page="link.jsp"/>
        <style>
            button {
                display: inline-block;
                -webkit-box-sizing: border-box;
                -moz-box-sizing: border-box;
                box-sizing: border-box;
                width: 300px;
                height: 60px;
                cursor: pointer;
                top: 0;
                right: 0;

                bottom: 0;
                left: 0;
                padding: 0 20px;
                overflow: hidden;
                border: none;
                -webkit-border-radius: 21px;
                border-radius: 21px;
                font: normal 20px/normal "Antic", Helvetica, sans-serif;
                color: oldlace;
                -o-text-overflow: ellipsis;
                text-overflow: ellipsis;
                background: rgba(255,140,0,0.4);
                -webkit-box-shadow: 1px 1px 2px 0 rgba(0,0,0,0.5) inset;
                box-shadow: 1px 1px 2px 0 rgba(0,0,0,0.5) inset;
                -webkit-transition: all 502ms cubic-bezier(0.68, -0.75, 0.265, 1.75);
            }

            button:hover {
                color: black;
                background: #00BFFF;
                -webkit-transition: all 1ms cubic-bezier(0.68, -0.75, 0.265, 1.75);
            }
            button:focus {
                width: 300px;
                cursor: default;
                padding: -13px 20px 0;
                color: rgba(255,255,255,1);
                -webkit-transition: all 601ms cubic-bezier(0.68, -0.75, 0.265, 1.75);
                outline:none;
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

        </style>


        <table>
            <tr><td><button onclick="window.location.href = 'Form15_SFD_Validate.jsp'">Allocate Subject Faculty<br></button></td>
                <td><button onclick="window.location.href = 'Form15_AESFD_Type.jsp'">Allocate Faculty For Extra Subjects<br></button></td></tr>
            <tr><td><button onclick="window.location.href = 'Form25_GD.jsp'">Generate Defaulter</button></td>
                <td><button onclick="window.location.href = 'Form26_RF.jsp'">Replace Allocated Faculty</button></td></tr>
            <tr><td><button onclick="window.location.href = 'Form27_WM.jsp'">Withdraw Attendance Record</button></td>
                <td><button onclick="window.location.href = 'Form28_AES.jsp'">Add Extra Students</button></td></tr>   
            <tr><td><button onclick="window.location.href = 'CT_Own_Musters.jsp'">Show your Allocated Roll calls</button></td>
                <td><button onclick="window.location.href = 'Division_All_Musters.jsp'">Show all Roll calls</button></td></tr>
            <tr><td><button onclick="window.location.href = 'Form13_Add_Leave.jsp'">Add Leave Type</button></td>
                <td><button onclick="window.location.href = 'Month_Entry.jsp'">Assign Academic Month</button></td>

        </table>
        

            <%
                if (null != request.getAttribute("errorMessage")) {
                    %>
            <div align="center" class="content" id="testdiv" ><span class="lab" style="background: whitesmoke">
                <%
                    out.println(request.getAttribute("errorMessage"));
                    %>
                 </span></div>
                    <%
                }
                %>               
    </center>

    <%}%>
</body>
</html>

