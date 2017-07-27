<%-- 
    Document   : Form15_SFD_Save
    Created on : Sep 4, 2016, 1:19:48 AM
    Author     : sandeep
--%>

<%@page import="java.sql.DatabaseMetaData"%>
<%@page import="DBconnection.dbconnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="false"%>
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
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
                request.getRequestDispatcher("Login.jsp").include(request, response);
            } else {

                Connection con = dbconnection.createConnection();
                try {
                    String academic_year = (String) ses.getAttribute("academic_year");
                    String year = request.getParameter("year");
                    String branch = (String) ses.getAttribute("branch");
                    String semester = (String) ses.getAttribute("semester");
                    String table = academic_year + "_" + year + "_" + branch + "_sem" + semester + "_Th_Pr";
                    String ex_table = academic_year + "_" + year + "_" + branch + "_sem" + semester + "_Th_Pr_Extra";
                    PreparedStatement ps = con.prepareStatement("select * from " + table);
                    ResultSet rs = ps.executeQuery();
                    int found = 0;

                    if (!rs.next()) {
                        request.setAttribute("errorMessage", "Subjects not assigned for this Year yet...Please add the Subjects...");
                        request.getRequestDispatcher("HOD_Course_Details.jsp").include(request, response);
                    } else {
                        rs.beforeFirst();

        %>
        <br><br>
        <div align="center" class="label" style="color: white"><h2>Courses Assigned for Year:<font color="yellow"> <%=year%></font>, Semester: <font color="yellow"><%=semester%></font>, A_Y: <font color="yellow"><%=academic_year%></font> and Branch: <font color="yellow"><%=branch%> </font></h2></div>
        <table align="center">
            <thead class="hi" style="font-size: 15px">


            <th>Subject Name</th>
            <th>Subject Code</th>
            <th>Subject Type</th>         


        </thead>

        <%while (rs.next()) {
        %>        
        <tr>  <td>
                <%=rs.getString(1)%>
            </td>
            <td>
                <%=rs.getString(2)%>
            </td>  
            <td>
                <%=rs.getString(3)%>
            </td>  

        </tr>  
        <%}%>

    </table>   
    <br/><br/>


    <% DatabaseMetaData metadata = con.getMetaData();
        ResultSet rs4 = metadata.getTables(null, null, ex_table, null);
        if (rs4.next()) {
            PreparedStatement ps1 = con.prepareStatement("select * from " + ex_table);
            ResultSet rs1 = ps1.executeQuery();
            if (!rs1.next()) {

            } else {
                rs1.beforeFirst();
    %>

    <div align="center"><h2><font color="yellow">Extra Courses Assigned for Year: <%=year%>, Semester: <%=semester%>, A_Y: <%=academic_year%> and Branch: <%=branch%> </font></h2></div>
    <table border="2">
        <thead>
            <tr class="neon" style="font-size: 30px">                    

                <th>Subject Name</th>
                <th>Subject Code</th>
                <th>Subject Type</th>         

            </tr>
        </thead>
        <tbody>
            <%while (rs1.next()) {
            %>        
            <tr>  
                <td>
                    <%=rs1.getString(1)%>
                </td>
                <td>
                    <%=rs1.getString(2)%>
                </td>  
                <td>
                    <%=rs1.getString(3)%>
                </td>  

            </tr>  
            <%}%>
        </tbody>
    </table>
    <br/><br/>
    <%}
    } else {%>




    <%       }
                }

            } catch (Exception e) {
                out.println(e);
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>There is a slight error in the database..try again later..</h2></b></center></font>");
                request.getRequestDispatcher("HOD_Profile.jsp").include(request, response);
            } finally {
                con.close();
            }
        }
    %>

    <div align="center"><button onclick="window.location.href = 'HOD_Profile.jsp'">Home Page</button></div>
</body>
</html>
