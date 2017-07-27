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
        <title>Class Teacher Login </title>
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
            h1{
                font-size: 20px;
                
            }
            .label{
                width:750px;
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
            else
            {

            String year = (String) ses.getAttribute("year");
            String branch = (String) ses.getAttribute("branch");
            String division = (String) ses.getAttribute("division");
            String academic_year = (String) ses.getAttribute("academic_year");
            String semester = (String) ses.getAttribute("semester");
            System.out.println("Year: "+year);
            System.out.println("br "+branch);
            System.out.println("div "+division);
            System.out.println("ay "+academic_year);
            System.out.println("sem "+semester);
            Connection con = DBconnection.dbconnection.createConnection();

            try {
                PreparedStatement ps = con.prepareStatement("select * from Theory_Muster_Allocation where Academic_Year=? and Year=? and Branch=? and Semester=? and Division=?");
                ps.setString(1, academic_year);
                ps.setString(2, year);
                ps.setString(3, branch);
                ps.setString(4, semester);
                ps.setString(5, division);
                ResultSet rs = ps.executeQuery();

                PreparedStatement ps1 = con.prepareStatement("select * from Practical_Muster_Allocation where Academic_Year=? and Year=? and Branch=? and Semester=? and Division=? order by Roll_From");
                ps1.setString(1, academic_year);
                ps1.setString(2, year);
                ps1.setString(3, branch);
                ps1.setString(4, semester);
                ps1.setString(5, division);
                ResultSet rs1 = ps1.executeQuery();
                if (!rs.next() && !rs1.next()) {
                    request.setAttribute("errorMessage","Attendance not assigned to Faculty for this Division yet...Please assign Faculty and try again...");
                    request.getRequestDispatcher("Form13_CT_Login.jsp").include(request, response);
                } else {
                    rs.beforeFirst();
                    rs1.beforeFirst();
        %>
        <br>
         
        <div align="center" class="label"><h2>Theory Subject Attendance with Allocated Faculty for <font color="yellow"><%=academic_year%> Semester <%=semester%></font></h2></div>
        <table border="2">
            <thead class="hi" style="font-size: 17px">
                
                    <th>Faculty ID</th>
                    <th>Faculty Name</th>
                    <th>Subject Name</th>
                    <th>Subject Code</th>
                    <th>Attendance Record</th>  
                    <th>Year</th>
                    <th>Division</th>
                    <th>Branch</th>    
                    
                
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
                        <%=rs.getString(8)%>
                    </td>  
                    <td>
                        <%=rs.getString(9)%>
                    </td>  
                    <td>
                        <%=rs.getString(10)%>
                    </td>  
                    <td>
                        <%=rs.getString(6)%>
                    <td>
                        <%=rs.getString(7)%>
                    </td>  
                    <td>
                        <%=rs.getString(5)%>
                    </td>  
                    
                </tr>  
                <%}%>
            </tbody>
        </table>   
        <br/><br/>
        
        
        
        <div align="center" class="label"><h2>Practical Subject Attendance with Allocated Faculty for <font color="yellow">A_Y: <%=academic_year%> Semester: <%=semester%> Year: <%=year%> Division: <%=division%> and Branch: <%=branch%></font></h2></div>
        <table border="2">
            <thead class="hi" style="font-size: 17px">
               
                    <th>Faculty ID</th>
                    <th>Faculty Name</th>
                    <th>Subject Name</th>
                    <th>Subject Code</th>
                    <th>Batch</th>
                    <th>Roll From</th>
                    <th>Roll To</th>
                    <th>Attendance Record</th>  
              
            </thead>
            <tbody>
                <%while (rs1.next()) {
                %>        
                <tr>
                    <td>
                        <%=rs1.getInt(1)%>
                    </td>  
                    <td>
                        <%=rs1.getString(2)%>
                    </td>  
                    <td>
                        <%=rs1.getString(11)%>
                    </td>  
                    <td>
                        <%=rs1.getString(12)%>
                    </td>  
                    <td>
                        <%=rs1.getInt(8)%>
                    </td>  
                    <td>
                        <%=rs1.getInt(9)%>
                    <td>
                        <%=rs1.getInt(10)%>
                    </td>  
                    <td>
                        <%=rs1.getString(13)%>
                    </td>  
                    
                </tr>  
                <%  }
                %>
            </tbody>
        </table>
        <br/>
        <div align="center"><button onclick="window.location.href = 'Form13_CT_Login.jsp'">Home Page</button></div>
        
        <% 
                        }

                    } catch (Exception e) {
                        out.println(e);
                        request.setAttribute("errorMessage","<font color='red'><center><b><h2>No Attendance allocated for this Division yet...Please allocate the Faculty first...</h2></b></center></font>");
                        request.getRequestDispatcher("Form13_CT_Login.jsp").include(request, response);
                    } finally {
                        con.close();
                    }
}
                %>
    </body>
</html>
