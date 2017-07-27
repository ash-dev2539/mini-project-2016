<%-- 
    Document   : Form13_CT_Login
    Created on : Sep 2, 2016, 10:55:32 AM
    Author     : Aroha
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html>
<html>
    <head>
        <script type="text/javascript" src="js/jquery-1.8.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Department HOD Login </title>
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
    
            <%
                HttpSession ses = request.getSession(false);
                if (ses.getAttribute("empid") == null || ses.getAttribute("empid").equals("")) {
                    request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
                    request.getRequestDispatcher("Login.jsp").include(request, response);
                } else
                {
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
                    Connection con=DBconnection.dbconnection.createConnection();
                    PreparedStatement ps1 = con.prepareStatement("select Faculty_Name from Faculty_Details where Faculty_ID=? ");
                    ps1.setInt(1, empid);
                    ResultSet rs1 = ps1.executeQuery();
                    rs1.next();
            %>
            <div align="left"><label class="topcornerl" style="font-size: 30px;color: white "><%=wish%> <%=rs1.getString(1)%>m</label></div>
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

        </style>
        <center><table>
            <tr><td><button onclick="window.location.href = 'Principal_Check_Status.jsp'">View Attendance<br></button></td></tr>  

        </table>
        <div class="content" id="testdiv" >

            <%  if (null != request.getAttribute("errorMessage")) {
                    out.println(request.getAttribute("errorMessage"));
                }
            %>                </div>
    </center>
    <%}%>
</body>
</html>
