<%-- 
    Document   : Division_All_Musters
    Created on : Sep 15, 2016, 3:38:48 PM
    Author     : Jagannath
--%>

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

        </style>
    </head>    

    <body>

        <%
            HttpSession ses = request.getSession(false);
            if (ses.getAttribute("empid") == null || ses.getAttribute("empid").equals("")) {
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
                request.getRequestDispatcher("Login.jsp").include(request, response);
            } else {

                String branch = (String) ses.getAttribute("branch");
                String academic_year = (String) ses.getAttribute("academic_year");

                Connection con = DBconnection.dbconnection.createConnection();

                try {
                    PreparedStatement ps = con.prepareStatement("select * from Class_Teacher_Details where Academic_Year=? and Branch=?");
                    ps.setString(1, academic_year);
                    ps.setString(2, branch);
                    ResultSet rs = ps.executeQuery();

                    if (!rs.next()) {
                        request.setAttribute("errorMessage", "Class Teacher not assigned yet.....Please assign Class teacher and try again...");
                        request.getRequestDispatcher("HOD_CT_Assign.jsp").include(request, response);
                    } else {
                        rs.beforeFirst();
        %>
        <br>
        <div align="center" class="label" style="color: white"><h2>Class Teachers Assigned for <font color="yellow"> <%=academic_year%> </font>and Branch: <font color="yellow"> <%=branch%> </font></h2></div>
        <table>
            <thead class="hi" style="font-size: 15px">

            <th>Faculty ID</th>   
            <th>Faculty Name</th> 
            <th>Year</th>
            <th>Branch</th>   
            <th>Division</th>
            <th>Semester</th>

        </thead>
        <tbody>
            <%while (rs.next()) {
            %>        
            <tr>
                <td>
                    <%=rs.getInt(1)%>
                </td>  
                <td>
                    <%=rs.getString(2)%>
                </td>  
                <td>
                    <%=rs.getString(4)%>
                </td>  
                <td>
                    <%=rs.getString(5)%>
                </td>  
                <td>
                    <%=rs.getString(6)%>
                </td>  
                <td>
                    <%=rs.getString(7)%>
                </td>  
            </tr>  
            <%}%>
        </tbody>
    </table>  
    <br/><br/>
    <div align="center"><button onclick="window.location.href = 'HOD_Profile.jsp'">Home Page</button></div>

    <%
                }

            } catch (Exception e) {
                out.println(e);
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>No Attendance Record allocated for this Division yet...Please allocate the Faculty first...</h2></b></center></font>");
                request.getRequestDispatcher("HOD_Profile.jsp").include(request, response);
            } finally {
                con.close();
            }
        }
    %>
</body>
</html>
