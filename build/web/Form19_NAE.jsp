<%-- 
    Document   : Signup
    Created on : 1 Sep, 2016, 10:33:09 PM
    Author     : rohan
--%>
<%@page import="java.sql.DatabaseMetaData"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html>
<html>
    <head><link href="cool.css" rel="stylesheet">
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

        <%
            HttpSession ses = request.getSession(false);
            if (ses.getAttribute("empid") == null || ses.getAttribute("empid").equals("")) {
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
                request.getRequestDispatcher("Login.jsp").include(request, response);
            } else {
                Connection con = DBconnection.dbconnection.createConnection();
                try {
                    String Lecture_Type, Date1;
                    String[] Time;
                    String table_name = (String) ses.getAttribute("table_name");
                    String Type = request.getParameter("Type");
                    if (Type.equals("Update")) {
                        Lecture_Type = request.getParameter("Lecture_Type");
                        Date1 = request.getParameter("Date");
                        Time = (String[]) ses.getAttribute("Hour");
                        Type = "Add";
                    } else {
                        Lecture_Type = request.getParameter("Lecture_Type");
                        Time = request.getParameterValues("Time");
                        Date1 = request.getParameter("Date");
                    }
                    String Date = Date1.replaceAll(("-"), "_");
                    int found = 0;
                    int hour_length = Time.length;
                    for (int i = 0; i < hour_length; i++) {
                        String column = Date + "_" + Time[i];
                        DatabaseMetaData metadata = con.getMetaData();
                        ResultSet rs4 = metadata.getColumns(null, null, table_name, column);
                        if (rs4.next()) {
                            found = 1;
                            System.out.println("I'm there");
                            break;
                        }
                    }
                    if (found == 0) {
                        System.out.println("I'm not there");
                        ses.setAttribute("Hour", Time);
                        ses.setAttribute("Lecture_Type", Lecture_Type);

                        ses.setAttribute("Date", Date);

                        PreparedStatement ps = con.prepareStatement("select count(Student_Roll_No) from " + table_name);
                        ResultSet rs = ps.executeQuery();
                        rs.next();
                        int strength = rs.getInt(1);
                        request.setAttribute("strength", strength);
        %>
        <br><br><br>
        <div id="login">


            <h1>Number of Student(s) Entry<br>
                <font color="yellow">Your Class/Batch(for Practicals) Strength is: <%=rs.getInt(1)%></font></h1>


            <form action="Form20_AE.jsp" method="post">

                <table>


                    <tr>
                        <td class="lab"> Select the type of Attendance to be marked</td>
                        <td> <select name="mark_type" required style="font-size: 20px;width: 300px">
                                <option selected disabled></option>
                                <option>Mark Present Students</option>
                                <option>Mark Absent Students</option>
                            </select>
                        </td>
                    </tr> 
                    <tr>
                        <td class="lab"> Enter Number of Students</td>
                        <td> <input pattern="[0-9]+" type="number" style="font-size: 20px;color: #000;width: 285px;height: 25px" maxlength="3"  min="0" max="<%=rs.getInt(1)%>" name="Number" required/></td>
                    </tr>   


                    <input type="hidden" value="<%=Lecture_Type%>" name ="Lecture_Type" >
                    <input type="hidden" value="<%=Type%>" name ="Type" >

                </table>

                <input style="color: white" type="submit" value="Proceed" /> 

            </form>

        </div>


    </body>
    <%
    } else {
    %>
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
            width: 150px;
            height: 40px;
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
        .hi{
            background:#3399cc;
            padding:20px 0;
            font-size:100%;
            font-weight:300;
            text-align:center;
            color:#fff;
        }


    </style>

    <%
                    request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Given Date and Hour Already present in Attendance...</h2></b></center></font>");
                    request.getRequestDispatcher("Form17_SL.jsp").include(request, response);
                }
            } catch (Exception e) {
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>No value is Fetched.....Try again</h2></b></center></font>");
                request.getRequestDispatcher("Form17_SL.jsp").include(request, response);
            }
        }
    %>
</html>