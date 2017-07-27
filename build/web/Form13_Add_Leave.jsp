<%-- 
    Document   : Form13_Add_Leave
    Created on : Sep 17, 2016, 5:28:14 PM
    Author     : sandeep
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
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
            #login{
                width:400px;
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
                width:400px;
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
            }
            String year = (String) ses.getAttribute("year");
            String branch = (String) ses.getAttribute("branch");
            String division = (String) ses.getAttribute("division");
            String academic_year = (String) ses.getAttribute("academic_year");
            String semester = (String) ses.getAttribute("semester");
            Connection con = DBconnection.dbconnection.createConnection();
            PreparedStatement ps = con.prepareStatement("select Leave_Type from Leave_Type_Identification where Academic_Year=? and Year=? and Branch=? ");
            ps.setString(1, academic_year);
            ps.setString(2, year);
            ps.setString(3, branch);
            ResultSet rs = ps.executeQuery();

        %>
        <table style="width: 400px"> 
            <thead class="hi" style="font-size: 17px">
            <th>
                Existing Types of Leaves
            </th>
        </thead>
        <%while (rs.next()) {
        %> <tr>
            <td>
                <label style="font-size: 20px;color: yellow"><%=rs.getString(1)%></label>
            </td>
        </tr>
        <%
            }
        %>
    </table>
    <br><br><hr><hr>
    
        <div id="login">
           

            <h1>Enter The type of Leave you wish to add</h1>

              <form action="Form13_Add_Leave_Save.jsp">

                <input style="width: 350px;font-size: 20px" type="text" name="leave" required>

                <input type="submit" value="GO :)">

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
    <div align="center">
        <button onclick="window.location.href = 'Form13_CT_Login.jsp'">Back</button>
    </div>
</body>
</html>
