
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="DBconnection.dbconnection" %>
<%@page import="java.sql.DriverManager"%>

<%@page contentType="text/html" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html>
<html>
    <head>
        <script type="text/javascript" src="js/jquery-1.8.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="cool.css" rel="stylesheet">
        <script src="js/la.jsp" type="text/javascript"></script>
        <style>
            *{margin:0;padding:0;}
            #login{
                width:1250px;
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
                width:150px;
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

            });
        </script>
        <%
            HttpSession ses = request.getSession(false);
            if (ses.getAttribute("empid") == null || ses.getAttribute("empid").equals("")) {
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
                request.getRequestDispatcher("Login.jsp").include(request, response);
            } else {

                Connection con = dbconnection.createConnection();

                try {

                    int Batches = Integer.parseInt(request.getParameter("batches"));
                    String year, branch, division;
                    String academic_year = (String) ses.getAttribute("academic_year");
                    int empid = (Integer) ses.getAttribute("empid");
                    String semester = (String) ses.getAttribute("semester");
                    ses.setAttribute("batches", Batches);
                    year = (String) ses.getAttribute("year");
                    branch = (String) ses.getAttribute("branch");
                    division = (String) ses.getAttribute("division");
                    System.out.print(year);
                    System.out.print(branch);
                    System.out.print(division);
                    System.out.print(academic_year);
                    System.out.print(empid);

                    PreparedStatement ps1 = con.prepareStatement("select Theory_Count,Practical_Count from Subject_Details_Count_Coursewise where Academic_Year=? and Year=? and Branch=? and Semester=? ");
                    ps1.setString(1, academic_year);
                    ps1.setString(2, year);
                    ps1.setString(3, branch);
                    ps1.setString(4, semester);
                    ResultSet rs1 = ps1.executeQuery();
                    rs1.next();
                    int th_count = rs1.getInt(1);
                    int pr_count = rs1.getInt(2);

                    ses.setAttribute("th_count", th_count);
                    ses.setAttribute("pr_count", pr_count);
                    String tablename = academic_year + "_" + year + "_" + branch + "_Sem" + semester + "_Th_Pr";
                    PreparedStatement ps2 = con.prepareStatement("select Subject_Name from " + tablename + " where Subject_Type=?");
                    ps2.setString(1, "Theory");
                    ResultSet rs2 = ps2.executeQuery();
                    PreparedStatement ps3 = con.prepareStatement("select Subject_Code from " + tablename + " where Subject_Type=?");

                    ps3.setString(1, "Theory");
                    ResultSet rs3 = ps3.executeQuery();

                    /* PreparedStatement ps4 = con.prepareStatement("select Faculty_Name, Faculty_ID, branch from Faculty_Details");
                    ResultSet rs4 = ps4.executeQuery();
                     */
                    PreparedStatement ps5 = con.prepareStatement("select Subject_Name from " + tablename + " where Subject_Type=?");

                    ps5.setString(1, "Practical");
                    ResultSet rs5 = ps5.executeQuery();
                    PreparedStatement ps6 = con.prepareStatement("select Subject_Code from " + tablename + " where Subject_Type=?");

                    ps6.setString(1, "Practical");
                    ResultSet rs6 = ps6.executeQuery();

        %>
        <span  class="button" id="toggle-login">Welcome</span>

        <div id="login">
            <div id="triangle"></div>

            <h1>Enter Details Carefully</h1>

            <form action="Form15_SFD_Save.jsp" method="post">
<table>

                <thead class="hi" style="font-size: 15px">
                 
                        <th>Sr.No</th>
                        <th>Subject Name</th>
                        <th>Subject Code</th>
                        <th>Faculty Branch</th>
                        <th>Faculty Name</th>
                        <th>Roll No. From</th>
                        <th>Roll No. To</th>
                
                </thead>
                <tbody>                   

                    <%                        rs2.next();
                        rs3.next();
                        for (int i = 0; i < th_count;) {


                    %>


                    <tr>
                        <td class="lab">Subject <%=i + 1%></td>
                        <td>
                            <input style="width: 150px;" type="text" class="follow" name="Subject_Name_<%=i%>" value="<%=rs2.getString(1)%>" readonly/>
                        </td>
                        <td>
                            <input style="width: 150px;" type="text" class="follow" name="Subject_Code_<%=i%>" value="<%=rs3.getString(1)%>" readonly/>
                        </td>


                        <td><select style="width: 120px" name="branch_<%=i%>" id="branch">
                                <option disabled selected></option>
                                <option>COMP</option>
                                <option>MECH</option>
                                <option>CIVIL</option>
                                <option>ENTC</option>
                                <option>MSW</option>
                                <option>FE</option>
                                <option>ME</option>
                                <option>MBA</option>
                                <option>MCA</option>
                            </select>
                        </td>

                        <td>
                            <select name="Faculty_Name_<%=i%>" style="width: 250px" required id="faculty_name">

                            </select>
                        </td>
                        <td></td>
                        <td></td>
                    </tr>



                <script type="text/javascript">

                    $(document).ready(function () {



                        $("select[name=branch_<%=i%>").change(function ()
                        {

                            $.ajax({
                                url: "ajax_faculty.jsp",
                                data: "sendo=" + $("select[name=branch_<%=i%>").val(),
                                type: "get",
                                success: function (msg)
                                {

                                    $("select[name=Faculty_Name_<%=i%>").html(msg);
                    <%
                        i++;
                    %>
                                }
                            });
                        });

                    });

                </script>



                <% rs2.next();
                        rs3.next();

                    }
                %>

                <%
                    rs5.next();
                    rs6.next();
                    for (int i = 0; i < pr_count;) {
                        for (int j = 0; j < Batches;) {
                %>
                <tr>
                    <td class="lab">Batch <%=j + 1%> for Practical <%=i + 1%></td>
                    <td>
                        <input style="width: 150px;" type="text" class="follow" name="Practical_Name_<%=i%>_<%=j%>" value="<%=rs5.getString(1)%>" readonly/>
                    </td>
                    <td>
                        <input style="width: 150px;" type="text" class="follow" name="Practical_Code_<%=i%>_<%=j%>" value="<%=rs6.getString(1)%>" readonly/>
                    </td>
                    <td><select style="width: 120px" name="branchp_<%=i%>_<%=j%>" id="branch">
                            <option disabled selected></option>
                            <option>COMP</option>
                            <option>MECH</option>
                            <option>CIVIL</option>
                            <option>ENTC</option>
                            <option>MSW</option>
                            <option>FE</option>
                            <option>ME</option>
                            <option>MBA</option>
                            <option>MCA</option>
                        </select>
                    </td>
                    <td>
                        <select name="Faculty_Name_<%=i%>_<%=j%>" style="width: 250px" required>
                            <%-- <option disabled selected></option>
                             <%

                                    while (rs4.next()) {
                                %>
                                <option>

                                    <%=rs4.getString(1)%> - <%=rs4.getInt(2)%>

                                </option><% }
                                    rs4.beforeFirst();

                                %>--%>
                        </select>
                    </td>
                    <td>
                        <input pattern="[0-9]+" style="width: 70px;" type="text" name="roll_<%=i%>_<%=j%>_from" required>
                    </td>
                    <td>
                        <input pattern="[0-9]+" style="width: 70px;" type="text" name="roll_<%=i%>_<%=j%>_to" required>
                    </td>
                </tr>

                <script type="text/javascript">

                    $(document).ready(function () {



                        $("select[name=branchp_<%=i%>_<%=j%>").change(function ()
                        {

                            $.ajax({
                                url: "ajax_faculty.jsp",
                                data: "sendo=" + $("select[name=branchp_<%=i%>_<%=j%>").val(),
                                type: "get",
                                success: function (msg)
                                {

                                    $("select[name=Faculty_Name_<%=i%>_<%=j%>").html(msg);
                    <%
                        j++;
                    %>
                                }
                            });
                        });

                    });

                </script>

                <%}
                        i++;
                        rs5.next();
                        rs6.next();
                    }%>

               
                </tbody>
            </table>

                    <div align="center"> <input  type="submit" value="Allocate" style="width: 25%">
                    </div>

            </form>

        </div>
        
    
    </body>

    <%
            } catch (Exception e) {
                out.println(e);

                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>There is no records in database which matches the given criteria...Please Contact the Administrator...</h2></b></center></font>");
                request.getRequestDispatcher("Form13_CT_Login.jsp").include(request, response);
            } finally {
                con.close();
            }
        }
    %>
</html>
