<%-- 
    Document   : Form26_RF_Change
    Created on : Sep 11, 2016, 2:05:17 PM
    Author     : sandeep
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            HttpSession ses = request.getSession(false);
            if (ses.getAttribute("empid") == null || ses.getAttribute("empid").equals("")) {
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Sorry...Your Session has Expired....</h2></b></center></font>");
                request.getRequestDispatcher("Login.jsp").include(request, response);
            } else {
                Connection con = DBconnection.dbconnection.createConnection();
                //con.setAutoCommit(false);
                try {

                    String academic_year = (String) ses.getAttribute("academic_year");
                    String semester = (String) ses.getAttribute("semester");
                    String year = (String) ses.getAttribute("year");
                    String branch = (String) ses.getAttribute("branch");
                    String division = (String) ses.getAttribute("division");
                    String type = (String) ses.getAttribute("type");
                    String subject_name = (String) ses.getAttribute("subject_name");
                    int old_faculty_id = (Integer) ses.getAttribute("old_faculty_id");
                    int new_faculty_id = (Integer) ses.getAttribute("new_faculty_id");
                    String new_name = request.getParameter("new_name");
                    String old_name = request.getParameter("old_name");

                    if (type.equals("Theory")) {
                        PreparedStatement ps = con.prepareStatement("update Faculty_Allocation_Subjectwise_Th set Emp_ID=?,Faculty_Name=? where Emp_ID=? and Academic_Year=? and Year=? and Branch=? and Semester=? and Division=? and Subject_Name=? ");
                        ps.setInt(1, new_faculty_id);
                        ps.setString(2, new_name);
                        ps.setInt(3, old_faculty_id);
                        ps.setString(4, academic_year);
                        ps.setString(5, year);
                        ps.setString(6, branch);
                        ps.setString(7, semester);
                        ps.setString(8, division);
                        ps.setString(9, subject_name);
                        ps.executeUpdate();
                        PreparedStatement ps1 = con.prepareStatement("select Subject_Code,Muster_Name from Theory_Muster_Allocation where Faculty_ID=? and Academic_Year=? and Year=? and Branch=? and Semester=? and Division=? and Subject_Name=? ");
                        ps1.setInt(1, old_faculty_id);
                        ps1.setString(2, academic_year);
                        ps1.setString(3, year);
                        ps1.setString(4, branch);
                        ps1.setString(5, semester);
                        ps1.setString(6, division);
                        ps1.setString(7, subject_name);
                        ResultSet rs1 = ps1.executeQuery();

                        PreparedStatement ps2 = con.prepareStatement("Update Theory_Muster_Allocation set Faculty_ID=?,Faculty_Name=? where Faculty_ID=? and Academic_Year=? and Year=? and Branch=? and Semester=? and Division=? and Subject_Name=? ");
                        ps2.setInt(1, new_faculty_id);
                        ps2.setString(2, new_name);
                        ps2.setInt(3, old_faculty_id);
                        ps2.setString(4, academic_year);
                        ps2.setString(5, year);
                        ps2.setString(6, branch);
                        ps2.setString(7, semester);
                        ps2.setString(8, division);
                        ps2.setString(9, subject_name);
                        ps2.executeUpdate();
                        while (rs1.next()) {
                            String subject_code = rs1.getString(1);
                            String muster_name = rs1.getString(2);
                            String old_table_name = old_faculty_id + "_" + academic_year + "_" + year + "_" + branch + "_" + division + "_" + subject_code + "_" + muster_name;
                            String new_table_name = new_faculty_id + "_" + academic_year + "_" + year + "_" + branch + "_" + division + "_" + subject_code + "_" + muster_name;
                            PreparedStatement ps3 = con.prepareStatement("alter table " + old_table_name + " rename to " + new_table_name);
                            ps3.executeUpdate();
                        }
                        request.setAttribute("errorMessage", "<font color='green'><center><h2>Faculty Changed Successfully.....</h2></center></font>");
                        request.getRequestDispatcher("Form13_CT_Login.jsp").include(request, response);
                    } else if (type.equals("Practical")) {
                        PreparedStatement ps = con.prepareStatement("update Faculty_Allocation_Subjectwise_Pr set Emp_ID=?,Faculty_Name=? where Emp_ID=? and Academic_Year=? and Year=? and Branch=? and Semester=? and Division=? and Prac_Subject_Name=? ");
                        ps.setInt(1, new_faculty_id);
                        ps.setString(2, new_name);
                        ps.setInt(3, old_faculty_id);
                        ps.setString(4, academic_year);
                        ps.setString(5, year);
                        ps.setString(6, branch);
                        ps.setString(7, semester);
                        ps.setString(8, division);
                        ps.setString(9, subject_name);
                        ps.executeUpdate();

                        PreparedStatement ps1 = con.prepareStatement("select Subject_Code,Roll_From,Roll_To,Muster_Name from Practical_Muster_Allocation where Faculty_ID=? and Academic_Year=? and Year=? and Branch=? and Semester=? and Division=? and Subject_Name=? ");
                        ps1.setInt(1, old_faculty_id);
                        ps1.setString(2, academic_year);
                        ps1.setString(3, year);
                        ps1.setString(4, branch);
                        ps1.setString(5, semester);
                        ps1.setString(6, division);
                        ps1.setString(7, subject_name);
                        ResultSet rs1 = ps1.executeQuery();

                        PreparedStatement ps2 = con.prepareStatement("Update Practical_Muster_Allocation set Faculty_ID=? and Faculty_Name=? where Faculty_ID=? and Academic_Year=? and Year=? and Branch=? and Semester=? and Division=? and Subject_Name=? ");
                        ps2.setInt(1, new_faculty_id);
                        ps2.setString(2, new_name);
                        ps2.setInt(3, old_faculty_id);
                        ps2.setString(4, academic_year);
                        ps2.setString(5, year);
                        ps2.setString(6, branch);
                        ps2.setString(7, semester);
                        ps2.setString(8, division);
                        ps2.setString(9, subject_name);
                        ps2.executeUpdate();
                        while (rs1.next()) {
                            String subject_code = rs1.getString(1);                            
                            String muster_name = rs1.getString(4);
                            String old_table_name = old_faculty_id + "_" + academic_year + "_" + year + "_" + branch + "_" + division + "_" + subject_code + "_" + muster_name;
                            String new_table_name = new_faculty_id + "_" + academic_year + "_" + year + "_" + branch + "_" + division + "_" + subject_code + "_" + muster_name;
                            PreparedStatement ps3 = con.prepareStatement("alter table " + old_table_name + " rename to " + new_table_name);
                            ps3.executeUpdate();
                        }

                        request.setAttribute("errorMessage", "<font color='green'><center><h2>Faculty Changed Successfully.....</h2></center></font>");
                        request.getRequestDispatcher("Form13_CT_Login.jsp").include(request, response);
                    } else {
                        request.setAttribute("errorMessage", "<font color='red'><center><h2>Sorry..There is Some error...Please try again..</h2></center></font>");
                        request.getRequestDispatcher("Form13_CT_Login.jsp").include(request, response);
                    }
                    //con.commit();
                } catch (Exception e) {
                    
                    request.setAttribute("errorMessage", "<font color='red'><center><b><h2>There is nothing to be fetched from database for you...Please Contact the Administrator...</h2></b></center></font>"+e);
                    request.getRequestDispatcher("Form26_RF.jsp").include(request, response);
                } finally {
                    con.close();
                }

            }

        %>
    </body>
</html>
