<%-- 
    Document   : Signup
    Created on : 1 Sep, 2016, 10:33:09 PM
    Author     : rohan
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html>
<html>
    <head><link href="cool.css" rel="stylesheet">
        <script type="text/javascript" src="js/jquery-1.8.js"></script>
        <script src="js/la.jsp" type="text/javascript"></script>
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
                width:200px;
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

        <%    HttpSession ses = request.getSession(false);
            if (ses.getAttribute("empid") == null || ses.getAttribute("empid").equals("")) {
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
                request.getRequestDispatcher("Login.jsp").include(request, response);
            } else {
                Connection con = DBconnection.dbconnection.createConnection();

                try {
                    String Type = request.getParameter("Type");
                    String table_name = (String) ses.getAttribute("table_name");
                    String mark_type = request.getParameter("mark_type");
                    int number = Integer.parseInt(request.getParameter("Number"));

                    String Lecture_Type = request.getParameter("Lecture_Type");
                    String j = null;
                    System.out.print("Type after: " + Type);

                    if (Type.equals("Add")) {

                        j = "Form20_AE_Add.jsp";
                    } else if (Type.equals("Update")) {

                        j = "Form20_AE_Update.jsp";
                    }
                    String mark = "";
                    if (mark_type.equals("Mark Present Students")) {
                        mark = "Present";
                    } else {
                        mark = "Absent";
                    }
                    PreparedStatement ps = con.prepareStatement("select Student_Roll_No from " + table_name + " order by Student_Roll_No ");
                    ResultSet rs = ps.executeQuery();
        %>

        <div id="login">
            <div id="triangle"></div>

            <h1><%=mark%> Entry</h1>

            <form action="<%=j%>" method="post">
                <table align="center" style="width: 70%">
                    <% for (int i = 0; i < number; i++) {%>

                    <tr>
                        <td class="lab">Enter <%=mark%> <%= i + 1%> Roll-Number</td>
                        <td><select name="Roll_No_<%=i%>" required id="roll" style="font-size: 20px;width: 100px">
                                <option disabled selected></option>
                                <%
                                    while (rs.next()) {
                                %>
                                <option value="<%=rs.getInt(1)%>"><%=rs.getInt(1)%></option>
                                <%
                                    }
                                    rs.beforeFirst();
                                %>
                            </select>
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
                <input type="hidden" value="<%=Lecture_Type%>" name ="Lecture_Type" >
                <input type="hidden" name="Number" value="<%=number%>"/> 
                <input type="hidden" name="mark_type" value="<%=mark%>"/>

                <input type="submit" value="Save" />

            </form>

        </div>


        <%
                } catch (Exception e) {
                    out.println(e);
                    request.setAttribute("errorMessage", "<font color='red'><center><b><h2>There is nothing to be fetched from database for you, please contact the Administrator.</h2></b></center></font>");
                    //request.getRequestDispatcher("Form18_ME.jsp").include(request, response);
                }
            }
        %> 
    </body>
</html>