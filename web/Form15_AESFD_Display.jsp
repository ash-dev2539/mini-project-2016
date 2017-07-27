<%-- 
    Document   : Form15_SFD
    Created on : Sep 2, 2016, 11:53:09 AM
    Author     : Administrator
--%>


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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="cool.css" rel="stylesheet">
        <style>
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
                request.setAttribute("errorMessage","<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
                request.getRequestDispatcher("Login.jsp").include(request, response);
            } else {
                Connection con = dbconnection.createConnection();
                con.setAutoCommit(false);
                try {

                    String subject_type = (String) ses.getAttribute("subject_type");

                    String academic_year = (String) ses.getAttribute("academic_year");
                    int empid = (Integer) ses.getAttribute("empid");
                    String semester = (String) ses.getAttribute("semester");
                    String year, branch, division;
                    year = (String) ses.getAttribute("year");
                    branch = (String) ses.getAttribute("branch");
                    division = (String) ses.getAttribute("division");

                    if (subject_type.equals("Theory")) {
                        String tablename = academic_year + "_" + year + "_" + branch + "_Sem" + semester + "_Th_Pr_Extra";
                        PreparedStatement ps = con.prepareStatement("select Subject_Name from " + tablename + " where Subject_Type=?");
                        ps.setString(1, subject_type);
                        ResultSet rs = ps.executeQuery();
                        PreparedStatement ps1 = con.prepareStatement("select Faculty_Name, Faculty_ID from Faculty_Details ");

                        ResultSet rs1 = ps1.executeQuery();
        %>
        <form action="Form15_AESFD_Save.jsp" method="post">
            <div class="fire" align="center"><h1>Adding Faculty</h1></div><br><br><br>
            <table>
                <thead>
                <th>
                    Subject Name
                </th>
                <th>
                    Faculty Name
                </th>
                </thead>
                <tr>
                    <td class="neon" style="color: black">
                        <select name="subject_name" required>
                            <option disabled selected></option>
                            <%while (rs.next()) {%>
                            <option><%=rs.getString(1)%></option>
                            <%
                                }
                            %>
                        </select>
                    </td>
                    <td class="neon" style="color: black">
                        <select name="faculty_name">
                            <option disabled selected></option>
                            <%while (rs1.next()) {%>
                            <option>

                                <%=rs1.getString(1)%> - <%=rs1.getInt(2)%>

                            </option>
                            <%
                                }
                            %>
                        </select>
                    </td>


                <tr>   
                    <td></td>
                    <td>
                        <input type="submit" value="submit">
                    </td>
                </tr>
            </table>

        </form>
        <%
        } else if (subject_type.equals("Practical")) {

            String tablename = academic_year + "_" + year + "_" + branch + "_Sem" + semester + "_Th_Pr_Extra";
            int extra_batch = Integer.parseInt(request.getParameter("batches"));
            ses.setAttribute("batches", extra_batch);
            PreparedStatement ps = con.prepareStatement("select Subject_Name from " + tablename + " where Subject_Type=?");
            ps.setString(1, subject_type);
            ResultSet rs = ps.executeQuery();

            PreparedStatement ps1 = con.prepareStatement("select Faculty_Name, Faculty_ID from Faculty_Details ");
            ResultSet rs1 = ps1.executeQuery();

        %>
        <form action="Form15_AESFD_Save.jsp" method="post">
            <div class="fire" align="center"><h1>Adding Faculty</h1></div><br><br><br>
            <table>
                <thead>
                <th>
                    Subject Name
                </th>
                <th>
                    Faculty Name
                </th>

                <tr>
                    <td class="neon" style="color: black">
                        <select name="subject_name" required>
                            <option disabled selected></option>
                            <%while (rs.next()) {%>
                            <option><%=rs.getString(1)%></option>
                            <%
                                }
                            %>
                        </select>
                    </td>
                    <td class="neon" style="color: black">
                        <select name="faculty_name" required>
                            <option disabled selected></option>
                            <%while (rs1.next()) {%>
                            <option>

                                <%=rs1.getString(1)%> - <%=rs1.getInt(2)%>

                            </option>
                            <%
                                }
                            %>
                        </select>
                    </td>
                </tr>
            </table>
            <div align="center">You have Selected <%=extra_batch%> batches..Please enter the Roll no. range</div><br/><br/>
            <table>
                <thead>   
                <th></th>
                <th>
                    Roll From
                </th> 
                <th>
                    Roll To
                </th> 
                </thead>

                <%
                    for (int i = 0; i < extra_batch; i++) {
                %>
                <tr>
                    <td>
                        Batch <%=i + 1%>
                    </td>
                    <td>
                        <input pattern="[0-9]+" type="text" name="roll_from_<%=i%>" required>

                    </td>
                    <td>
                        <input pattern="[0-9]+" type="text" name="roll_to_<%=i%>" required>

                    </td>

                </tr>
                <%
                    }
                %>              

                <tr>   
                    <td></td>                       
                    <td>
                        <input type="submit" value="submit">
                    </td>
                </tr>
            </table>
        </form>  
        <% } else {
                    request.setAttribute("errorMessage","<font color='red'><center><b><h2>Sorry Unexpected Interference....Try Again</h2></b></center></font>");
                    request.getRequestDispatcher("Form13_CT_Login.jsp").include(request, response);
                }

                con.commit();
            } catch (Exception e) {
                e.printStackTrace();
                con.rollback();
                request.setAttribute("errorMessage","<font color='red'><center><b><h2>There is no records in  this database which matches the given criteria...Please Contact the Administrator...</h2></b></center></font>");
                request.getRequestDispatcher("Form13_CT_Login.jsp").include(request, response);
            } finally {
                con.close();
            }
}


        %>
</html>
