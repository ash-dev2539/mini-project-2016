<head> <link href="cool.css" rel="stylesheet">
    <style>
        *{margin:0;padding:0;}


        form{
            background:#f0f0f0;
            padding:2% 4%;
        }
        #login{
            width:330px;
            margin:0 auto;
            margin-top:8px;
            margin-bottom:2%;
            transition:opacity 1s;
            -webkit-transition:opacity 1s;
        }

        input[type="text"],input[type="password"]{
            width:92%;
            background:#fff;
            margin-bottom:4%;
            border:1px solid #ccc;
            padding:2%;
            font-family:'Open Sans',sans-serif;
            font-size:95%;
            color:#555;
        }
        input[type="text"]:focus{
            border-width: 2pt;
            border-color: #3399cc;
        }

        input[type="password"]:focus{
            border-width: 2pt;
            border-color:#3399cc;
        }

        input[type="submit"]{
            width:100%;
            background:#3399cc;
            border:0;
            padding:2%;
            font-family:'Open Sans',sans-serif;
            font-size:100%;
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
    <br><br><br><br>
    <div id="login">
        <div id="triangle"></div>

        <h1>Faculty ID*</h1>

        <form action="Signup_validate_process.jsp" method="post">

            <input pattern="[0-9]+" style="width: 300px" type="text" name="emp_id" required title="Only integers">



            <input type="submit" value="Proceed" name="Proceed">

        </form>

    </div>
    <div align="center">
        <button onclick="window.location.href = 'Login.jsp'">Back</button>  
    </div>

</body>