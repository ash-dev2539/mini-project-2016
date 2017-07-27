<%-- 
    Document   : yearwise_comparision
    Created on : 5 Aug, 2016, 12:10:51 PM
    Author     : Pragati Choudhari
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*;" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ICEM ResultAnalysis</title>

    </head>
    <% response.setContentType("image/jpg");%>
    <center>

        <img src="college_logo.jpg" alt="Indira College Of Engineering" style="width:1200px;height:150px"/>
    </center>
    <%
GregorianCalendar date=new GregorianCalendar(); 
String d=date.get(Calendar.DAY_OF_MONTH)+"/"+date.get(Calendar.MONTH)+"/"+date.get(Calendar.YEAR); 
  
    %>
    <p align="left">         Date:<%=d%></p>
    <script type="text/javascript">
        function doPrint() {
            window.print();
        }

    </script>



    <center>
        <%
        try{
            //response.setContentType("application/pdf");
            response.setContentType("text/html");
          String year=request.getParameter("year");
            String branch=request.getParameter("branch");
            String exam=request.getParameter("exam");
            String a_year=request.getParameter("A_year");
            String course=request.getParameter("course");
     //       out.print(""+year+" "+branch+""+exam+""+course);
     Class.forName("com.mysql.jdbc.Driver");  // MySQL database connection
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/RA","root","root");    
        PreparedStatement pst = conn.prepareStatement("select a_year from overall where year=? and branch=? and exam=? and course=? order by a_year");
        pst.setString(1,year);
        pst.setString(2,branch);
        pst.setString(3,exam);
       // pst.setString(4,a_year);
        pst.setString(4,course);
        
        ResultSet rs = pst.executeQuery(); 
int i=0;%>


        <table border="1" cellpadding="5" cellspacing="2">
            <thead>
                <tr><th colspan="10">Overall Result Comparison</th></tr><tr><th colspan="10" align="left"><b>Year:</b><%=year%><br><b>Branch:</b><%=branch%><br><b>Exam:</b><%=exam%><br><b>Course:</b><%=course%></th></tr>
                <tr>

                    <td>Year</td><td>All Clear</td><td> Distinction</td><td> First Class</td><td>Higher Second Class</td><td>Second Class</td><td>Pass Class</td><td>ATKT</td><td>Fail</td><td>UOP</td>

                </tr>
            </thead>

            <% ResultSet rs1=null;
            double all_clear[]=new double[10];  
    double dist[]=new double[10];                           
    double fc[]=new double[10];                            
    double hsc[]=new double[10];                            
    double sc[]=new double[10];                            
    double pass[]=new double[10]; 
    double atkt[]=new double[10];                            
    double fail[]=new double[10]; 
    double uop[]=new double[10];
    int App[]=new int[10];
    String a_year1[]=new String[10];
            while(rs.next()){
                //out.print("Hello a_year");
        
    pst=conn.prepareStatement("Select * from overall where year=? and branch=? and exam=? and course=? and a_year=?");
    pst.setString(1,year);
            pst.setString(2,branch);
            pst.setString(3,exam);
           // pst.setString(4,a_year);
            pst.setString(4,course);
            pst.setString(5,rs.getString("a_year"));
            //out.print("hello");
            a_year1[i]=rs.getString("a_year");
           rs1 = pst.executeQuery();   

    while(rs1.next()){
      

            all_clear[i]=((rs1.getInt("total_pass")*100)/rs1.getInt("appear"));
                                                 
            dist[i]=((rs1.getInt("dist")*100)/rs1.getInt("appear"));
             fc[i]=((rs1.getInt("fc")*100)/rs1.getInt("appear"));
              hsc[i]=((rs1.getInt("hsc")*100)/rs1.getInt("appear"));
               sc[i]=((rs1.getInt("sc")*100)/rs1.getInt("appear"));
                pass[i]=((rs1.getInt("pass")*100)/rs1.getInt("appear"));
                 atkt[i]=((rs1.getInt("atkt")*100)/rs1.getInt("appear"));
                  fail[i]=((rs1.getInt("fail")*100)/rs1.getInt("appear"));
                  uop[i]=rs1.getInt("uop");
    App[i]=rs1.getInt("appear");





            %>
            <%}i++;}
            %>
            <%int count=i-1;
            int j=0; 
            while(j<=count){%>        

            <tbody>
                <tr>

                    <td> <%=a_year1[j]%><br>(<%=App[j]%>)</td>
                    <td> <%=all_clear[j]%>
                        <%
                        if(j>=1){if(all_clear[j]>all_clear[j-1]){%> <font color="green" size="15"> &uarr;</font><%}if(all_clear[j]<all_clear[j-1]){%><font color="red" size="15"> &darr;</font><%} }   
                        %> 
                    </td>
                    <td> <%=dist[j]%>
                        <%
                        if(j>=1){if(dist[j]>dist[j-1]){%> <font color="green" size="15"> &uarr;</font><%}if(dist[j]<dist[j-1]){%><font color="red" size="15"> &darr;</font><%} }   
                        %> 
                    </td>
                    <td> <%=fc[j]%>
                        <%
                        if(j>=1){if(fc[j]>fc[j-1]){%> <font color="green" size="15"> &uarr;</font><%}if(fc[j]<fc[j-1]){%><font color="red" size="15"> &darr;</font><%} }   
                        %> 
                    </td>
                    <td> <%=hsc[j]%>
                        <%
                        if(j>=1){if(hsc[j]>hsc[j-1]){%> <font color="green" size="15"> &uarr;</font><%}if(hsc[j]<hsc[j-1]){%><font color="red" size="15"> &darr;</font><%} }   
                        %> 
                    </td>
                    <td> <%=sc[j]%>
                        <%
                        if(j>=1){if(sc[j]>sc[j-1]){%> <font color="green" size="15"> &uarr;</font><%}if(sc[j]<sc[j-1]){%><font color="red" size="15"> &darr;</font><%} }   
                        %> 
                    </td>
                    <td> <%=pass[j]%>
                        <%
                        if(j>=1){if(pass[j]>pass[j-1]){%> <font color="green" size="15"> &uarr;</font><%}if(pass[j]<pass[j-1]){%><font color="red" size="15"> &darr;</font><%} }   
                        %> 
                    </td>
                    <td> <%=atkt[j]%>
                        <%
                        if(j>=1){if(atkt[j]>atkt[j-1]){%> <font color="red" size="15"> &uarr;</font><%}if(atkt[j]<atkt[j-1]){%><font color="green" size="15"> &darr;</font><%} }   
                        %> 
                    </td>
                    <td> <%=fail[j]%>
                        <%
                        if(j>=1){if(fail[j]>fail[j-1]){%> <font color="red" size="15"> &uarr;</font><%}if(fail[j]<fail[j-1]){%><font color="green" size="15"> &darr;</font><%} }   
                        %> 
                    </td>
                    <td> <%=uop[j]%>
                        <%
                        if(j>=1){if(uop[j]>uop[j-1]){%> <font color="green" size="15"> &uarr;</font><%}if(uop[j]<uop[j-1]){%><font color="red" size="15"> &darr;</font><%} }
                        %> 
                    </td>


                </tr>


                <% j++;}}catch(Exception e)
                                        {
                                     out.print(e);
                                }
       
                %>     
            </tbody>
        </table>                         
        <button   onclick=doPrint(); value="Create Pdf">Pdf</button>
        <!--<input type="submit" value="Download pdf">-->
    </center>

    <%//response.setContentType("application/pdf"); %>
</body>
</html>
