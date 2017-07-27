<%-- 
    Document   : Form25_GD_Final_S_Enter
    Created on : Sep 17, 2016, 2:01:46 AM
    Author     : sandeep
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="cool.css" rel="stylesheet">
         <script type="text/javascript" src="js/jquery-1.8.js"></script>
        <script src="js/la.jsp" type="text/javascript"></script>
              <style>
            *{margin:0;padding:0;}
            #login{
                width:450px;
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
                request.setAttribute("errorMessage","<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
                request.getRequestDispatcher("Login.jsp").include(request, response);
            }
            Connection con = DBconnection.dbconnection.createConnection();
            int empid = (Integer) ses.getAttribute("empid");
            String year = (String) ses.getAttribute("year");
            String branch = (String) ses.getAttribute("branch");
            String division = (String) ses.getAttribute("division");
            String academic_year = (String) ses.getAttribute("academic_year");
            String semester = (String) ses.getAttribute("semester");
            String table_name=academic_year+"_"+year+"_"+branch+"_"+semester+"_"+division+"_Muster";
            int student_count = Integer.parseInt(request.getParameter("student_count"));
            ses.setAttribute("student_count", student_count);
            String reason = (String) ses.getAttribute("valid_reason");
            PreparedStatement ps = con.prepareStatement("select Student_Roll_No from " + table_name + " order by Student_Roll_No ");
            ResultSet rs = ps.executeQuery();

        %>
  
        <div id="login">
            <h1>Enter Details</h1>
           <form action="Form25_GD_Final_S_Save.jsp">

                <table align="center"> 
                <thead class="hi" style="font-size: 20px;height: 50px">
                <th></th>
                <th>Student Roll Number</th>
                <th>Attendance Count For <font color="yellow"><%=reason%></font> Leave</th>
                </thead>

                <%                        for (int i = 0; i < student_count; i++) {
                %>
                <tr>
                    <td class="label" style="font-size: 20px;width: 100px">
                       Student <%=i + 1%>
                    </td>
                    <td><select name="student_roll_<%=i%>" style="width:  100px;height: 40px" required>
                            <option disabled selected></option>
                            <%
                                while (rs.next()) {
                            %>
                            <option value="<%=rs.getInt(1)%>"><%=rs.getInt(1)%></option>
                            <%
                                }
                                rs.beforeFirst();
                            %>
                        </select></td>
                    <td>
                        <input pattern="[0-9]+" type="tel" style="width:  100px;height: 40px" name="student_att_add_<%=i%>" required>
                    </td>

                </tr>
                 <script type="text/javascript">
                    $(document).ready(function ()
                    {
                       
                        $("select").change(function (event) {
                            var prevValue = $(this).data("previous");
                            $("select").not(this).find("option[value='" + prevValue + "']").show();
                            var value = $(this).val();
                            $(this).data("previous", value);
                            $("select").not(this).find("option[value='" + value + "']").hide();
                        });

                    });
                </script>
                <%
                    }

                %>

            </table>

                <input type="submit" value="OK :)">

            </form>

        </div>
      
    </body>
</html>
