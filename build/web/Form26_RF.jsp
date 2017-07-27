<%-- 
    Document   : Form26_RF
    Created on : Sep 11, 2016, 1:05:33 PM
    Author     : sandeep
--%>

<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script type="text/javascript" src="js/jquery-1.8.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <link href="cool.css" rel="stylesheet">
        <style>
            *{margin:0;padding:0;}
            #log{
                width:600px;
                margin:0 auto;
                margin-top:8px;
                margin-bottom:2%;
                transition:opacity 1s;
                -webkit-transition:opacity 1s;
            }
            #log h1{
    background:#3399cc;
    padding:20px 0;
    font-size:140%;
    font-weight:300;
    text-align:center;
    color:#fff;
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
    <body>
        <script type="text/javascript">
            $(function () {
                setTimeout(function () {
                    $("#testdiv").fadeOut(1000);
                }, 7599);
                $('#btnclick').click(function () {
                    $('#testdiv').show();
                    setTimeout(function () {
                        $("#testdiv").fadeOut(1000);
                    }, 7599);
                });
            });
        </script>
        <%
            HttpSession ses = request.getSession(false);
            if (ses.getAttribute("empid") == null || ses.getAttribute("empid").equals("")) {
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
                request.getRequestDispatcher("Login.jsp").include(request, response);
            } else {
                Connection con = DBconnection.dbconnection.createConnection();
                try {

                    String academic_year = (String) ses.getAttribute("academic_year");
                    String semester = (String) ses.getAttribute("semester");
                    String branch = (String) ses.getAttribute("branch");
                    String division = (String) ses.getAttribute("division");
                    String year = (String) ses.getAttribute("year");
                    PreparedStatement ps = con.prepareStatement("select * from Faculty_Allocation_Subjectwise_Th where Academic_Year=? and Year=? and Branch=? and Semester=? and Division=? ");
                    ps.setString(1, academic_year);
                    ps.setString(2, year);
                    ps.setString(3, branch);
                    ps.setString(4, semester);
                    ps.setString(5, division);

                    ResultSet rs = ps.executeQuery();
                    if (!rs.next()) {
                        request.setAttribute("errorMessage", "Faculty not Allocated yet.....Please allocate the Faculty first and try again....");
                        request.getRequestDispatcher("Form13_CT_Login.jsp").include(request, response);
                    } else {


        %>
         
        <br><br>

        <div id="log">
            

            <h1>Replacement Of Faculty</h1>

            <form action="Form26_RF_Subject.jsp" method="post">

                <table>
                <tr>
                    <td class="lab" style="font-size: 20px;width: 300px">
                        Enter the Emp ID of faculty to be changed
                    </td>
                    <td>
                        <input type="text" pattern="[0-9]+"  style="font-size: 20px;width: 200px" name="old_faculty_id" required placeholder="Enter Emp ID">

                    </td>
                </tr>
                <tr>
                    <td class="lab" style="font-size: 20px;width: 300px">
                        Enter the Emp ID of the new faculty to be replaced with
                    </td>
                    <td>
                        <input type="text" pattern="[0-9]+"  style="font-size: 20px;width: 200px" name="new_faculty_id" required placeholder="Enter Emp ID">
                    </td>
                </tr>
                <tr>
                    <td class="lab" style="font-size: 20px;width: 300px">
                        Type of Subject
                    </td>
                    <td>
                        <select name="type"   style="font-size: 20px;width: 210px" required>
                            <option disabled selected></option>
                            <option>Theory</option>
                            <option>Practical</option>
                        </select>
                    </td>
                </tr>
                
            </table>

               <input type="submit" value="submit">

            </form>

        </div>
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
        
        
        <div align="center"><button onclick="window.location.href = 'Form13_CT_Login.jsp'">Go Back</button></div>
    </body>
    <%   }
            } catch (Exception e) {
                out.println(e);
                request.setAttribute("errorMessage", "Exception Caught...");
                request.getRequestDispatcher("Form13_CT_Login.jsp").include(request, response);
            } finally {
                con.close();
            }
        }
    %>
</html>
