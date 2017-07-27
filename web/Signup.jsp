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
<body>


    <%
        Connection con = DBconnection.dbconnection.createConnection();
        int emp_id = (Integer) request.getAttribute("emp_id");
        PreparedStatement ps = con.prepareStatement("select Branch from faculty_details where Faculty_ID=?");
        ps.setInt(1, emp_id);
        ResultSet rs = ps.executeQuery();
        rs.next();
        String dept = rs.getString(1);
    %>

    <div id="login">


        <h1>Sign Up</h1>

        <form action="Signup_process.jsp" method="post">
            <table align="center">

                <br>
                <tr>
                    <td class="lab"> Faculty ID </td>
                    <td> <input type="text" name="emp_id" style="width: 300px;font-size: 20px" value="${requestScope.emp_id}" readonly ></td>
                </tr>

                <tr>
                    <td class="lab"> Faculty First Name </td>
                    <td> <input type="text" name="fname" style="width: 300px;font-size: 20px" value="${requestScope.fname}" readonly > </td>
                </tr>

                <tr>
                    <td class="lab"> Last Name </td>
                    <td> <input type="text" name="lname" style="width: 300px;font-size: 20px" value="${requestScope.lname}" readonly > </td>
                </tr>

                <tr>
                    <td class="lab"> Password* </td>
                    <td> <input type="password" style="width: 300px;font-size: 20px" name="password" required> </td>
                </tr>


                <tr>
                    <td class="lab"> Gender* </td>
                    <td> <select name="gender" required style="width: 300px;font-size: 20px">
                            <option  disabled selected></option>
                            <option>Male</option>
                            <option>Female</option>
                        </select> </td>
                </tr>

                <tr>
                    <td class="lab"> Post Type* </td>
                    <td> <select name="designation" required style="width: 300px;font-size: 20px">
                            <option disabled selected></option>
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
                    <td class="lab"> Designation* </td>
                    <td> <select name="posttype" required style="width: 300px;font-size: 20px">
                            <option disabled selected></option>
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
                    <td class="lab"> Portfolio* </td>
                    <td> <input type="text" name="portfolio" required style="width: 300px;font-size: 20px"></td>
                </tr>

                <tr>
                    <td class="lab"> Additional Details </td>
                    <td> <input type="text" name="details" style="width: 300px;font-size: 20px"> </td>
                </tr>

                <tr>
                    <td class="lab"> Department </td>
                    <td><input type="text" name="department" value="<%=dept%>" style="width: 300px;font-size: 20px" readonly>  </td>
                </tr>

                <tr>
                    <td class="lab"> Qualification* </td>
                    <td> <input type="text" name="qualification" required style="width: 300px;font-size: 20px"></td></tr>

                <tr>
                    <td class="lab"> Mobile Number* </td>
                    <td><input value="+91" type="number" style="width: 300px;font-size: 20px" readonly> <input pattern="[0-9]+" type="number" style="width: 300px;font-size: 20px" maxlength=10 max="9999999999" min="7000000000" name="mobilenumber" required></td>
                </tr>

                <tr>
                    <td class="lab"> Emergency Contact number* </td>
                    <td><input value="+91" type="number" style="width: 300px;font-size: 20px" readonly> <input pattern="[0-9]+" type="number" style="width: 300px;font-size: 20px" maxlength=10 name="emergencycontactnumber" max="9999999999" min="7000000000" required> </td>
                </tr>

                <tr>
                    <td class="lab"> Address 1* </td>
                    <td> <input type="text" name="address1" style="width: 300px;font-size: 20px" required> </td>
                </tr>

                <tr>
                    <td class="lab"> Address 2* </td>
                    <td> <input type="text" name="address2" style="width: 300px;font-size: 20px" required> </td>
                </tr>   

                <tr>
                    <td class="lab"> Area*</td>
                    <td> <input pattern="[A-Za-z ]+" type="text" style="width: 300px;font-size: 20px" name="area" required> </td>
                </tr>

                <tr>
                    <td class="lab"> City* </td>
                    <td> <input pattern="[A-Za-z ]+" type="text" style="width: 300px;font-size: 20px" name="city" required> </td>
                </tr>

                <tr>
                    <td class="lab"> Pin Code* </td>
                    <td> <input pattern="[0-9]+" type="text" style="width: 300px;font-size: 20px" maxlength="6" name="pincode" required> </td>
                </tr>

                <tr>
                    <td class="lab"> State* </td>
                    <td> <input pattern="[A-Za-z ]+" type="text" style="width: 300px;font-size: 20px" name="state" required> </td>
                </tr>

                <tr>
                    <td class="lab"> Blood Group* </td>
                    <td> <select name="bloodgroup" required style="width: 300px;font-size: 20px">
                            <option disabled selected></option>
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
                    <td class="lab"> Date Of Birth* </td>
                    <td>  <input type="text" style="width: 300px;font-size: 20px" class="input-group" name="dob" id="date2" value="${requestScope.dob}" class="form-control" readonly>
                        <span class="input-group-btn">
                            <button class="btn btn-primary btn-date" type="button">Select Date</button>
                        </span>

                </tr>

                <tr>
                    <td class="lab"> Email ID </td>
                    <td><input pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$" style="width: 300px;font-size: 20px" type="text" name="email_id" value="${requestScope.email_id}" readonly title="Email ID" > </td>
                </tr>

            </table>

            <input type="submit" value="Submit"/>

        </form>

    </div>


    <div align="center">
        <button onclick="window.location.href = 'Login.jsp'">Back</button>
    </div>

</body>