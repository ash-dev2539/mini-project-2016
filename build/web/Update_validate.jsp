<%-- 
    Document   : Update_validate
    Created on : 5 Sep, 2016, 11:37:56 AM
    Author     : Aroha
--%>

<%@page import="DBconnection.dbconnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script type="text/javascript" src="js/jquery-1.8.js"></script>
    <title>JSP Page</title>
    <link href="cool.css" rel="stylesheet">
    <style>
        *{margin:0;padding:0;}


        form{
            background:#f0f0f0;
            padding:2% 4%;
        }

        input[type="password"]{
            width:92%;
            background:#fff;
            margin-bottom:4%;
            border:1px solid #ccc;
            padding:2%;
            font-family:'Open Sans',sans-serif;
            font-size:95%;
            color:#555;
        }


        input[type="password"]:focus{
            border-width: 2pt;
            border-color:#3399cc;
        }

        input[type="submit"]{
            width:100%;

            background: lightcoral;
            border:0;
            padding:2%;
            font-family:'Open Sans',sans-serif;
            font-size: 20px;
            color:white;
            cursor:pointer;
            transition:background .3s;
            -webkit-transition:background .3s;
        }
        input[type="submit"]:hover{
            background:rgba(200,10,0,0.5);    
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
    
    
    <br><br><br>

    <%
        HttpSession ses = request.getSession(false);
        if (ses.getAttribute("empid") == null || ses.getAttribute("empid").equals("")) {
            request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
            request.getRequestDispatcher("Login.jsp").include(request, response);
        }
        Connection con = dbconnection.createConnection();
        int empid = (Integer) ses.getAttribute("empid");
        PreparedStatement ps = con.prepareStatement("select Designation from Faculty_Personal_Details where Emp_ID=? ");
        ps.setInt(1, empid);
        ResultSet rs = ps.executeQuery();
        rs.next();
        String faculty_designation = rs.getString(1);
        String deliver = "";
        if (faculty_designation.equals("Faculty")) {
            PreparedStatement ps1 = con.prepareStatement("select * from Class_Teacher_Details where Emp_ID=? ");
            ps1.setInt(1, empid);
            ResultSet rs1 = ps1.executeQuery();
            if (rs1.next()) {
                deliver = "Form13_CT_Login.jsp";
            } else {
                deliver = "Form17_SL.jsp";
            }

        } else if (faculty_designation.equals("Principal") || faculty_designation.equals("Vice_Principal")) {

            deliver = "Principal_Profile.jsp";
        } else if (faculty_designation.equals("HOD")) {

            deliver = "HOD_Profile.jsp";
        }
    %>
<span  class="button" id="toggle-login">Update Details</span>
    <div id="login">
<div id="triangle"></div>

        <h1>Enter your Password</h1>

        <form action="Update_validate_process.jsp" method="post">

            <input type="password" style="width: 99%" name="password" required placeholder="Password">

            <input type="submit" value="Proceed" name="Proceed">

        </form>

    </div>

    <%
        if (null != request.getAttribute("errorMessage")) {
    %>
    <div align="center" class="content" id="testdiv" ><span class="label" style="background: whitesmoke">
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


</body>
