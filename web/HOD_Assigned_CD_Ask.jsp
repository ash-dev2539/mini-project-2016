<%-- 
    Document   : Form15_SFD_Save
    Created on : Sep 4, 2016, 1:19:48 AM
    Author     : sandeep
--%>

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
                width:320px;
                margin:0 auto;
                margin-top:8px;
                margin-bottom:2%;
                transition:opacity 1s;
                -webkit-transition:opacity 1s;
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
                height: 30px;
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

                    int empid = (Integer) ses.getAttribute("empid");

                    String academic_year = (String) ses.getAttribute("academic_year");
                    String semester = (String) ses.getAttribute("semester");
                    String course = (String) ses.getAttribute("course");

                    PreparedStatement ps = con.prepareStatement("select  Department from faculty_personal_details where Emp_ID=?");
                    ps.setInt(1, empid);
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) {
                        String branch = rs.getString(1);
        %>     
        <br><br><br><br>
        <div id="login">

            <%
                if (!branch.equals("FE")) {   %>
            <h1>Select Year(<font color="yellow">SE, TE, BE</font>)</h1>

            <form action="HOD_Assigned_CD.jsp" method="post">

                <select style="width: 300px;font-size: 20px" name="year" required>
                    <option disabled selected></option>                            
                    <option>2</option>    
                    <option>3</option>   
                    <option>4</option>   
                </select> 
                <input type="submit" value="Submit">

            </form>
            <% } else { %>
            <h1>Year(<font color="yellow">SE, TE, BE</font>)</h1>

            <form action="HOD_Assigned_CD.jsp" method="post">

                <input type="text" style="width: 285px;font-size: 20px" class="follow" name="year" value="1" readonly/>
                
                <input type="submit" value="Submit">

            </form>
            <%  }
            %>



        </div>

    </form>
    <%                }
            } catch (Exception e) {
                out.println(e);
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Invalid Combination...please try again....</h2></b></center></font>");
                request.getRequestDispatcher("HOD_Profile.jsp").include(request, response);
            } finally {
                con.close();
            }
        }
    %>
</body>
</html>
