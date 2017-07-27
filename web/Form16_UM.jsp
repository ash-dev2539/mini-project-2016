<%-- 
    Document   : Form16_UM
    Created on : Sep 5, 2016, 1:54:07 PM
    Author     : sandeep
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script type="text/javascript" src="js/jquery-1.8.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="cool.css" rel="stylesheet">
        <style>
            *{margin:0;padding:0;}
            #login{
                width:700px;
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
            .custom-file-input {
                display: inline-block;
                position: relative;
                color: #533e00;
            }
            .custom-file-input input {
                visibility: hidden;
                width: 100px;
            }
            .custom-file-input:before {
                width: 150px;
                height: 40px;
                content: 'Browse';
                display: inline-block;
                background: -webkit-linear-gradient( -180deg, #ffdc73, #febf01);
                background: -o-linear-gradient( -180deg, #ffdc73, #febf01);
                background: -moz-linear-gradient( -180deg, #ffdc73, #febf01);
                background: linear-gradient( -180deg, #ffdc73, #febf01);
                border: 3px solid #dca602;
                border-radius: 10px;
                padding: 5px 0px;
                outline: none;
                white-space: nowrap;
                cursor: pointer;
                text-shadow: 1px 1px rgba(255,255,255,0.7);
                font-weight: bold;
                text-align: center;
                font-size: 17pt;
                position: absolute;
                left: 0;
                right: 0;
                border-color: whitesmoke;
                background: greenyellow;


            }
            .custom-file-input:hover:before {
                border-color: #533e00;
                background: #533e00;
                color: azure;
            }
            .custom-file-input:active:before {
                background: orange;
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
                try {
        %>
        <br><br><br><br><br>
        <span  class="button" id="toggle-login">File Upload Form</span>

        <div id="login">
            <div id="triangle"></div>

            <h1>Upload File</h1>

            <form action="uploadfile" method="post" enctype="multipart/form-data">
<table>  
                    <tr>
                        <td>

                            <input style="width: 500px;height: 60px" type="text" id="uploadFile" placeholder="Choose File" disabled="disabled" required/>
                        </td><td> <label  class="custom-file-input" >  
                                <input type="file" id="uploadBtn" name="filename">
                            </label>
                            <script type="text/javascript">

                                document.getElementById("uploadBtn").onchange = function () {
                                    document.getElementById("uploadFile").value = this.value;
                                };
                            </script>
                        </td></tr>


                </table> 

                <input type="submit" value="Upload"/>

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
 
</body>         
<%    } catch (Exception e) {
            request.setAttribute("errorMessage", "<font color='red'><center><b><h2>There is nothing to be fetched from database for you...Please Contact the Administrator...</h2></b></center></font>");
            ses.invalidate();
            request.getRequestDispatcher("Login.jsp").include(request, response);
        }
    }
%>
</html>



