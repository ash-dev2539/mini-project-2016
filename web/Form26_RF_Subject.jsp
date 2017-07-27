<%-- 
    Document   : Form26_RF_Subject
    Created on : Sep 12, 2016, 9:01:31 PM
    Author     : sandeep
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
        <%
            HttpSession ses = request.getSession(false);
            if (ses.getAttribute("empid") == null || ses.getAttribute("empid").equals("")) {
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
                request.getRequestDispatcher("Login.jsp").include(request, response);
            } else {
                Connection con = DBconnection.dbconnection.createConnection();
                con.setAutoCommit(false);
                try {

                    String type = request.getParameter("type");
                    ses.setAttribute("type", type);
                    int emp_id = (Integer) ses.getAttribute("empid");
                    int old_faculty_id = Integer.parseInt(request.getParameter("old_faculty_id"));
                    int new_faculty_id = Integer.parseInt(request.getParameter("new_faculty_id"));
                    ses.setAttribute("old_faculty_id", old_faculty_id);
                    ses.setAttribute("new_faculty_id", new_faculty_id);
                    String semester = (String) ses.getAttribute("semester");
                    String academic_year = (String) ses.getAttribute("academic_year");

                    String branch = (String) ses.getAttribute("branch");
                    String division = (String) ses.getAttribute("division");
                    String year = (String) ses.getAttribute("year");
                    String subject_table_name = academic_year + "_" + year + "_" + branch + "_Sem" + semester + "_Th_Pr";
                    PreparedStatement ps1 = con.prepareStatement("select Subject_Name from " + subject_table_name + " where Subject_Type=?");
                    ps1.setString(1, type);
                    ResultSet rs1 = ps1.executeQuery();
                    con.commit();

        %>
         


        <div id="login">
            

            <h1>Enter the Subject-Name for Faculty Replacement</h1>

            <form action="Form26_RF_Validate.jsp" method="get">

                <select name="subject_name" style="width: 100%;height: 50px;font-size: 20px">
                            <option disabled selected></option>

                            <% while (rs1.next()) {
                            %>
                            <option><%=rs1.getString(1)%></option>

                            <%
                                }
                            %>
                        </select>

                <input type="submit" value="OK">

            </form>

        </div>
        
    </body>
    <%
            } catch (Exception e) {
                con.rollback();
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>There is nothing to be fetched from database for you...Please Contact the Administrator...</h2></b></center></font>");
                request.getRequestDispatcher("Form26_RF.jsp").include(request, response);
            } finally {
                con.close();
            }

        }
    %>
</html>
