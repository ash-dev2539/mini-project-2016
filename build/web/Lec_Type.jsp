<%-- 
    Document   : Lec_Type
    Created on : 10 Oct, 2016, 6:59:17 PM
    Author     : Sai Kameswari
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String lec_type = request.getParameter("sendo");
            if (lec_type.equals("Guest")) {
        %>              
        <input style="width: 42px" type="checkbox" name="Time" value="1hr" ><span style="color: blue"> 1hr</span> <br>
        <input style="width: 42px" type="checkbox" name="Time" value="2hrs" ><span style="color: blue">2hrs </span><br>
        <input style="width: 42px" type="checkbox" name="Time" value="3hrs" ><span style="color: blue">3hrs </span><br>
        <input style="width: 42px" type="checkbox" name="Time" value="4hrs" ><span style="color: blue">4hrs</span> <br>
        <input style="width: 42px" type="checkbox" name="Time" value="5hrs" ><span style="color: blue">5hrs</span> <br>
        <input style="width: 42px" type="checkbox" name="Time" value="6hrs" ><span style="color: blue">6hrs</span> <br>
        <input style="width: 42px" type="checkbox" name="Time" value="7hrs" ><span style="color: blue">7hrs</span> <br>
        <input style="width: 42px" type="checkbox" name="Time" value="8hrs" ><span style="color: blue">8hrs</span> <br>
        <% } else {
        %>
        <input style="width: 42px" type="radio" name="Time" value="1hr" >  <span style="color: blue"> 1hr </span><br>
        <input style="width: 42px" type="radio" name="Time" value="2hrs" ><span style="color: blue">2hrs</span><br>
        <input style="width: 42px" type="radio" name="Time" value="3hrs" ><span style="color: blue">3hrs</span><br>
        <input style="width: 42px" type="radio" name="Time" value="4hrs" ><span style="color: blue">4hrs </span><br>
        <input style="width: 42px" type="radio" name="Time" value="5hrs" ><span style="color: blue">5hrs </span><br>
        <input style="width: 42px" type="radio" name="Time" value="6hrs" ><span style="color: blue">6hrs </span><br>
        <input style="width: 42px" type="radio" name="Time" value="7hrs" ><span style="color: blue">7hrs </span><br>
        <input style="width: 42px" type="radio" name="Time" value="8hrs" ><span style="color: blue">8hrs </span><br>
        <%
            }
        %>
    </body>
</html>
