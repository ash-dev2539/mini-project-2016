<%-- 
    Document   : Hod_profile
    Created on : 2 Sep, 2016, 1:37:47 AM
    Author     : aroha
--%>


<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.*" %>
<%@page import="DBconnection.dbconnection" %>
<%@page contentType="text/html" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html>

<html>

    <head>
        <script type="text/javascript" src="js/jquery-1.8.js"></script>
        <link href="cool.css" rel="stylesheet">

    </head>

    <body>
        <script type="text/javascript">
            $(function () {
                setTimeout(function () {
                    $("#testdiv").fadeOut(1000);
                }, 7599);               
            });
        </script>

        <%
            HttpSession ses = request.getSession(false);
            if (ses.getAttribute("empid") == null || ses.getAttribute("empid").equals("")) {
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
                request.getRequestDispatcher("Login.jsp").include(request, response);
            } else {
                Date hour = new Date();
                Calendar c1 = GregorianCalendar.getInstance();
                c1.setTime(hour);
                int hr = c1.get(Calendar.HOUR_OF_DAY);

                String wish = "Good Morning";
                if (hr >= 12 && hr < 18) {
                    wish = "Good Afternoon";
                } else if (hr >= 18 && hr < 24) {
                    wish = "Good Evening";
                }
                int empid = (Integer) ses.getAttribute("empid");
                Connection con = DBconnection.dbconnection.createConnection();
                String academic_year = (String) ses.getAttribute("academic_year");
                String semester = (String) ses.getAttribute("semester");
                PreparedStatement ps = con.prepareStatement("select Fname,Lname from Faculty_Personal_Details where Emp_ID=? ");
                ps.setInt(1, empid);
                ResultSet rs2 = ps.executeQuery();
                String name = "";

                if (rs2.next()) {
                    name = rs2.getString(1) + " " + rs2.getString(2);
                }
        %>
        <div align="left"><label class="topcornerl" style="font-size: 30px;color: white "><%=wish%> <%=name%></label></div>
        <br><br><br><br><br><br>
        <jsp:include page="link.jsp"/>
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
                width:615px;
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
            button {
                display: inline-block;
                -webkit-box-sizing: border-box;
                -moz-box-sizing: border-box;
                box-sizing: border-box;
                width: 150px;
                height: 40px;
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
            .hi{
                background:#3399cc;
                padding:20px 0;
                font-size:100%;
                font-weight:300;
                text-align:center;
                color:#fff;
            }


        </style>
        <br/>
        <br/>

        <%
            try {

                int Faculty_ID = (Integer) ses.getAttribute("empid");
                String Academic_year = (String) ses.getAttribute("academic_year");

                PreparedStatement stmt = con.prepareStatement("select Muster_Name from Theory_Muster_Allocation where Faculty_ID=? and Academic_Year=?");
                stmt.setInt(1, Faculty_ID);
                stmt.setString(2, Academic_year);
                ResultSet rs = stmt.executeQuery();
                PreparedStatement stmt1 = con.prepareStatement("select Muster_Name from Practical_Muster_Allocation where Faculty_ID=? and Academic_Year=?");
                stmt1.setInt(1, Faculty_ID);
                stmt1.setString(2, Academic_year);
                ResultSet rs1 = stmt1.executeQuery();
        %>

        <table>
            <%  while (rs.next()) {

            %>

            <tr>
                <td class="hi" style="height: 15px"><%= rs.getString(1)%></td>
                <td> <button onclick="window.location.href = 'Form18_ME.jsp?Muster=<%= rs.getString(1)%>&Subject_Type=Theory&Type=Add'">Add<br></button></td>
                <td><button onclick="window.location.href = 'Form18_ME.jsp?Muster=<%= rs.getString(1)%>&Subject_Type=Theory&Type=Update'">Update<br></button></td>
                <td><button onclick="window.location.href = 'Form17_SL_ASk.jsp?Muster=<%= rs.getString(1)%>&Subject_Type=Theory'">Display<br></button></td>
                <td><button onclick="window.location.href = 'Form17_SL_Dynamo.jsp?Muster=<%= rs.getString(1)%>&Subject_Type=Theory'">Attendance<br></button></td>

            </tr>


            <% }%>
            <%  while (rs1.next()) {

            %>

            <tr>
                <td class="hi" style="height: 15px"><%= rs1.getString(1)%></td>
                <td><button onclick="window.location.href = 'Form18_ME.jsp?Muster=<%= rs1.getString(1)%>&Subject_Type=Practical&Type=Add'">Add<br></button></td>
                <td><button onclick="window.location.href = 'Form18_ME.jsp?Muster=<%= rs1.getString(1)%>&Subject_Type=Practical&Type=Update'">Update<br></button></td>
                <td><button onclick="window.location.href = 'Form17_SL_ASk.jsp?Muster=<%= rs1.getString(1)%>&Subject_Type=Practical'">Display<br></button></td>
                <td><button onclick="window.location.href = 'Form17_SL_Dynamo.jsp?Muster=<%= rs1.getString(1)%>&Subject_Type=Practical'">Attendance<br></button></td>

            </tr>



            <% }%>
        </table>   
        <%
            if (null != request.getAttribute("errorMessage")) {
        %>
        <div align="center" class="content" id="testdiv" ><span class="lab" style="background: whitesmoke;color:#00BFFF;width: 500px">
                <%
                    out.println(request.getAttribute("errorMessage"));
                %>
            </span></div>
            <%
                }
            %> 
    </body>
    <%
            } catch (Exception e) {
                out.println(e);
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>There is no Attendance Record present with the given name...Please Contact the Administrator...</h2></b></center></font>");
                request.getRequestDispatcher("Login.jsp").include(request, response);
            }
        }
    %>
</html>