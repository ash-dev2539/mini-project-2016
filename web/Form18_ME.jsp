<%-- 
    Document   : Signup
    Created on : 1 Sep, 2016, 10:33:09 PM
    Author     : rohan
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="false"%>
<head>
    <script type="text/javascript" src="js/jquery-1.8.js"></script>
    <link href="css/jquery-script.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="css/font.css">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link href="css/jquery.dateselect.css" rel="stylesheet" type="text/css">
    <link href="cool.css" rel="stylesheet">

    <script src="js/jquery-min.js"></script> 
    <script src="js/jquery-mousewheel.js"></script> 
    <script src="js/jquery.dateselect.js"></script>
    <script src="js/la.jsp" type="text/javascript"></script>
    <script>
        jQuery(document).ready(function ($) {
            $('.btn-date').on('click', function (e) {
                e.preventDefault();
                $.dateSelect.show({
                    element: 'input[name="Date"]'
                });
            });
        });
    </script>
    <script type="text/javascript">

        var _gaq = _gaq || [];
        _gaq.push(['_setAccount', 'UA-36251023-1']);
        _gaq.push(['_setDomainName', 'jqueryscript.net']);
        _gaq.push(['_trackPageview']);

        (function () {
            var ga = document.createElement('script');
            ga.type = 'text/javascript';
            ga.async = true;
            ga.src = 'js/analytics-ga.js';
            var s = document.getElementsByTagName('script')[0];
            s.parentNode.insertBefore(ga, s);
        })();

    </script>
    <style>
        *{margin:0;padding:0;}
        #login{
            width:500px;
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
            width:220px;
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
            String deliver = "";
            try {
                int empid = (Integer) ses.getAttribute("empid");
                String academic_year = (String) ses.getAttribute("academic_year");
                String Type = request.getParameter("Type");
                String muster = request.getParameter("Muster");
                String subject_type = request.getParameter("Subject_Type");
                Connection con = DBconnection.dbconnection.createConnection();
                ses.setAttribute("musterup", muster);
                ses.setAttribute("subject_type", subject_type);

                if (subject_type.equals("Theory")) {
                    PreparedStatement ps = con.prepareStatement("select * from Theory_Muster_Allocation where Muster_Name=? and Faculty_ID=? ");
                    ps.setString(1, muster);
                    ps.setInt(2, empid);
                    ResultSet rs = ps.executeQuery();
                    rs.next();
                    String year = rs.getString("Year");
                    String branch = rs.getString("Branch");
                    String division = rs.getString("Division");
                    String subject_code = rs.getString("Subject_Code");
                    String Faculty_Name = rs.getString("Faculty_Name");
                    String Subject_Name = rs.getString("Subject_Name");

                    String table_name = empid + "_" + academic_year + "_" + year + "_" + branch + "_" + division + "_" + subject_code + "_" + muster;
                    ses.setAttribute("table_name", table_name);

                    ses.setAttribute("Branch", branch);
                    ses.setAttribute("Division", division);
                    ses.setAttribute("Faculty_Name", Faculty_Name);
                    ses.setAttribute("Subject_Name", Subject_Name);
                    ses.setAttribute("Year", year);

                } else if (subject_type.equals("Practical")) {
                    PreparedStatement ps = con.prepareStatement("select * from Practical_Muster_Allocation where Muster_Name=? and Faculty_ID=? ");
                    ps.setString(1, muster);
                    ps.setInt(2, empid);
                    ResultSet rs = ps.executeQuery();
                    rs.next();
                    String year = rs.getString("Year");
                    String branch = rs.getString("Branch");
                    String division = rs.getString("Division");
                    String subject_code = rs.getString("Subject_Code");
                    String Faculty_Name = rs.getString("Faculty_Name");
                    String Subject_Name = rs.getString("Subject_Name");
                    int roll_from = rs.getInt("Roll_From");
                    int roll_to = rs.getInt("Roll_To");
                    String table_name = empid + "_" + academic_year + "_" + year + "_" + branch + "_" + division + "_" + subject_code + "_" + muster;
                    ses.setAttribute("table_name", table_name);
                    ses.setAttribute("Branch", branch);
                    ses.setAttribute("Division", division);
                    ses.setAttribute("Faculty_Name", Faculty_Name);
                    ses.setAttribute("Subject_Name", Subject_Name);
                    ses.setAttribute("Year", year);
                    ses.setAttribute("roll_from", roll_from);
                    ses.setAttribute("roll_to", roll_to);

                }
                
                

                PreparedStatement ps6 = con.prepareStatement("select Designation from Faculty_Personal_Details where Emp_ID=? ");
                ps6.setInt(1, empid);
                ResultSet rs6 = ps6.executeQuery();
                rs6.next();
                String faculty_designation = rs6.getString(1);

                if (faculty_designation.equals("Faculty")) {
                    PreparedStatement ps10 = con.prepareStatement("select * from Class_Teacher_Details where Emp_ID=?");
                    ps10.setInt(1, empid);
                    ResultSet rs10 = ps10.executeQuery();
                    if (rs10.next()) {
                        deliver = "CT_Own_Musters.jsp";
                    } else {
                        deliver = "Form17_SL.jsp";
                    }
                } else if (faculty_designation.equals("Vice_Principal")) {

                    deliver = "CT_Own_Musters.jsp";
                } else if (faculty_designation.equals("HOD")) {

                    deliver = "CT_Own_Musters.jsp";
                }
                String j = "";
                if (Type.equals("Update")) {
                    j = "update_middle.jsp";
                } else {
                    j = "Form19_NAE.jsp";
                }


    %>

    <div id="login">


        <h1>Attendance Entry</h1>

        <form action="<%=j%>" method="post">
            <table>


                <tr>

                    <td class="lab"> Enter Date</td>
                    <td>  <input type="text" class="input-group" name="Date" id="date2" class="form-control" readonly required style="width: 220px">
                        <span class="input-group-btn">
                            <button class="btn btn-primary btn-date" type="button">Select Date</button>
                        </span> </td>
                </tr>


                <tr><td class="lab">Lecture Type</td><td>
                        <select name="Lecture_Type" style="width: 220px">
                            <option disabled selected></option>
                            <option >Regular</option>
                            <option>Guest</option>
                        </select></td></tr>

                <tr>

                    <td class="lab"> Which Hour of the day</td> 

                    <td id="vary">

                    </td>


                </tr>
                <script type="text/javascript">

                    $(document).ready(function () {



                        $("select[name=Lecture_Type").change(function ()
                        {

                            $.ajax({
                                url: "Lec_Type.jsp",
                                data: "sendo=" + $("select[name=Lecture_Type").val(),
                                type: "get",
                                success: function (msg)
                                {

                                    $("td[id=vary").html(msg);
                                }
                            });
                        });

                    });

                </script>

                <%
                    if (Type.equals("Update")) {
                %>
                <tr><td class="lab">Update Choice</td><td>
                        <select name="upchoice" style="width: 220px">
                            <option disabled selected></option>
                            <option>Drop Existing Date</option>
                            <option>Alter Existing Attendance</option>
                        </select></td></tr>

                <tr></tr>
                <%
                    }
                %>



            </table>

            <input type="submit" value="Proceed" />
            <input type="hidden" value="<%=Type%>" name="Type">
        </form>

    </div>
    <%
        if (null != request.getAttribute("errorMessage")) {
    %>
    <div align="center" class="content" id="testdiv" ><span class="label" style="background: whitesmoke;width: 400px">
            <%
                out.println(request.getAttribute("errorMessage"));
            %>
        </span></div>
        <%
            }
        %>  
    <div align="center">
        <button onclick="window.location.href = '<%=deliver%>'">Back</button>
    </div>


    <script>
        function goBack() {
            window.history.back();
        }
    </script>
</body>
<%
        } catch (Exception e) {

            request.setAttribute("errorMessage", "<font color='red'><center><b><h2>There is no Attendance Record present with the given name...Please Contact the Administrator...</h2></b></center></font>" + e);
            request.getRequestDispatcher(deliver).include(request, response);
        }
    }
%>
