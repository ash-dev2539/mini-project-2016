<%@page import="DBconnection.dbconnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<head>
    <link href="css/jquery-script.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="css/font.css">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link href="css/jquery.dateselect.css" rel="stylesheet" type="text/css">
    <link href="cool.css" rel="stylesheet">

    <script src="js/jquery-min.js"></script> 
    <script src="js/jquery-mousewheel.js"></script> 
    <script src="js/jdate.js"></script>
    <script>
        jQuery(document).ready(function ($) {
            $('.btn-date').on('click', function (e) {
                e.preventDefault();
                $.dateSelect.show({
                    element: 'input[name="dob"]'
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
                width:100px;
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

            input[type="text"],input[type="password"],input[type="tel"],input[type="number"]{
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
            input[type="number"]:focus{
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


        </style></head>
<body><%
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
     <div id="login">
          

            <h1> Update Details</h1>

            <form action="Update_process.jsp" method="post">

                <table>


            <tr>
                <td class="lab"> Faculty ID </td>
                <td> <input type="text" style="width: 300px;font-size: 20px" name="emp_id" value="${requestScope.emp_id}" readonly ></td>
            </tr>

            <tr>
                <td class="lab"> Faculty First Name </td>
                <td> <input type="text" style="width: 300px;font-size: 20px" name="fname" value="${requestScope.fname}" readonly > </td>
            </tr>

            <tr>
                <td class="lab"> Last Name </td>
                <td> <input type="text" style="width: 300px;font-size: 20px" name="lname" value="${requestScope.lname}" readonly > </td>
            </tr>

            <tr>
                <td class="lab"> Password </td>
                <td> <input type="password" style="width: 300px;font-size: 20px" name="password"  value="${requestScope.password}" required > </td>
            </tr>


            <tr>
                <td class="lab"> Gender </td>
                <td> <select name="gender" style="width: 300px;font-size: 20px" required>
                        <option  selected>${requestScope.gender}</option>
                        <option>Male</option>
                        <option>Female</option>
                    </select> </td>
            </tr>

            <tr>
                <td class="lab"> Post Type </td>
                <td> <select name="designation" style="width: 300px;font-size: 20px" required>
                        <option selected>${requestScope.designation}</option>
                        <option>
                            Principal
                        </option> 
                        <option>
                            Vice_Principal
                        </option> 
                        <option>
                            HOD
                        </option> 
                        <option>
                            Faculty
                        </option> 
                    </select></td>
            </tr>

            <tr>
                <td class="lab"> Designation </td>
                <td> <select name="postype" style="width: 300px;font-size: 20px" required >
                        <option selected>${requestScope.postype}</option>
                        <option>
                            Dean
                        </option> 
                        <option>
                            Professor
                        </option> 
                        <option>
                            Asst. Professor
                        </option> 
                        <option>
                            Asso. Professor
                        </option> 
                        <option>
                            Lecturer
                        </option> 
                    </select></td>
            </tr>

            <tr>
                <td class="lab"> Portfolio </td>
                <td> <input type="text" style="width: 300px;font-size: 20px" name="portfolio" value="${requestScope.portfolio}" required></td>
            </tr>

            <tr>
                <td class="lab"> Additional Details </td>
                <td> <input type="text" style="width: 300px;font-size: 20px" name="details" value="${requestScope.details}"> </td>
            </tr>

            <tr>
                <td class="lab"> Department </td>
                <td> <select name="department" style="width: 300px;font-size: 20px" required>
                        <option selected>${requestScope.department}</option>
                        <option>
                            COMP
                        </option> 
                        <option>
                            MECH
                        </option>
                        <option>
                            MSW
                        </option>
                        <option>
                            CIVIL
                        </option> 
                        <option>
                            ENTC
                        </option> 
                        <option>
                            FE
                        </option> 
                        <option>
                            ME
                        </option> 
                        <option>
                            MBA
                        </option>
                        <option>
                            MCA
                        </option> 
                    </select> </td>
            </tr>

            <tr>
                <td class="lab"> Qualification </td>
                <td> <input type="text" style="width: 300px;font-size: 20px" name="qualification" value="${requestScope.qualification}" required></td></tr>

            <tr>
                <td class="lab"> Mobile Number </td>
                <td> <input pattern="[0-9]+" type="tel" style="width: 300px;font-size: 20px" maxlength=10 name="mobilenumber" value="${requestScope.mobilenumber}" required></td>
            </tr>

            <tr>
                <td class="lab"> Emergency Contact number </td>
                <td> <input pattern="[0-9]+" type="tel" style="width: 300px;font-size: 20px" maxlength=10 name="emergencycontactnumber" value="${requestScope.emergencycontactnumber}" required> </td>
            </tr>

            <tr>
                <td class="lab"> Address 1 </td>
                <td> <input type="text" style="width: 300px;font-size: 20px" name="address1" value="${requestScope.address1}" required> </td>
            </tr>

            <tr>
                <td class="lab"> Address 2 </td>
                <td> <input type="text" style="width: 300px;font-size: 20px" name="address2" value="${requestScope.address2}" required> </td>
            </tr>   

            <tr>
                <td class="lab"> Area</td>
                <td> <input pattern="[A-Za-z ]+" type="text" style="width: 300px;font-size: 20px" name="area" value="${requestScope.area}" required> </td>
            </tr>

            <tr>
                <td class="lab"> City </td>
                <td> <input pattern="[A-Za-z ]+" type="text" style="width: 300px;font-size: 20px" name="city" value="${requestScope.city}" required> </td>
            </tr>

            <tr>
                <td class="lab"> Pin Code </td>
                <td> <input pattern="[0-9]+" type="text" style="width: 300px;font-size: 20px" maxlength="6" name="pincode" value="${requestScope.pincode}" required> </td>
            </tr>

            <tr>
                <td class="lab"> State </td>
                <td> <input pattern="[A-Za-z ]+" type="text" style="width: 300px;font-size: 20px" name="state" value="${requestScope.state}" required> </td>
            </tr>

            <tr>
                <td class="lab"> Blood Group </td>
                <td> <select name="bloodgroup" style="width: 300px;font-size: 20px" required>
                        <option selected>${requestScope.bloodgroup}</option>
                        <option>
                            O+
                        </option> 
                        <option>
                            O-
                        </option> 
                        <option>
                            A+
                        </option> 
                        <option>
                            A-
                        </option> 
                        <option>
                            B+
                        </option> 
                        <option>
                            B-
                        </option>
                        <option>
                            AB+
                        </option> 
                        <option>
                            AB-
                        </option>

                    </select> </td>
            </tr>

            <tr>
                <td class="lab"> Date Of Birth </td>
                <td>  <input type="text" style="width: 300px;font-size: 20px" class="input-group" name="dob" id="date2" value="${requestScope.dob}" >
                    <span class="input-group-btn">
                        <button class="btn btn-primary btn-date" type="button">Select Date</button>
                    </span>

            </tr>

            <tr>
                <td class="lab"> Email ID </td>
                <td><input pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$" type="text" style="width: 300px;font-size: 20px" name="email_id" value="${requestScope.email_id}" title="Email ID" > </td>
            </tr>

        </table>

                <input type="submit" value="Submit"/>

            </form>

        </div>
            <div align="center">
        <button onclick="window.location.href = '<%=deliver%>'">Back</button>
    </div>
    
</body>