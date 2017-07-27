<head>
    <link href="cool.css" rel="stylesheet">
    <script type="text/javascript" src="js/jquery-1.8.js"></script>
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
    <script type="text/javascript">
        $(function () {
            setTimeout(function () {
                $("#testdiv").fadeOut(1000);
            }, 7599);
        });
    </script>

    <br><br><br>

    <div id="login">


        <h1>Change Password</h1>

        <form action="Changepassword_process.jsp" method="post">
            <table>
                <tr><td class="lab">Faculty_ID*</td><td><input pattern="[0-9]+" style="width: 200px;font-size: 20px" type="text" name="Faculty_ID" required></td></tr>
                <tr><td class="lab">Old Password*</td><td><input type="password" style="width: 200px;font-size: 20px" name="oldpassword" required></td></tr>
                <tr><td class="lab">New Password*</td><td><input type="password" style="width: 200px;font-size: 200px" name="newpassword" required ></td></tr>
            </table>

            <input id="Submit" type="submit" value="Change" name="Change"/>

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
        <button onclick="window.location.href = 'Login.jsp'">Back</button>
    </div>


</body>
</html>