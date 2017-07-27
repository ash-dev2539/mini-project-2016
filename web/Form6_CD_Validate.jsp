<%-- 
    Document   : Which_One_Is_It
    Created on : Sep 3, 2016, 5:05:46 PM
    Author     : sandeep
--%>

<%@page import="DBconnection.dbconnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="false"%>
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
                Connection con = dbconnection.createConnection();

                try {
                    con.setAutoCommit(false);
                    int empid = (Integer) ses.getAttribute("empid");
                    String academic_year = request.getParameter("academic_year");
                    String semester = request.getParameter("sem");
                    String course = request.getParameter("course");

                    PreparedStatement ps = con.prepareStatement("select Designation from Faculty_Personal_Details where Emp_ID=?");
                    ps.setInt(1, empid);
                    ResultSet rs = ps.executeQuery();
                    int last_choice = 0;
                    System.out.println("wowoowowow");
                    if (rs.next()) {
                        String designation = rs.getString(1);

                        String dispatcher = "Login.jsp";
                        if (designation.equals("Principal") || designation.equals("Vice_Principal")) {
                            last_choice = 1;

                        }
                        if (designation.equals("HOD")) {
                            last_choice = 2;

                        }

                        if (designation.equals("Faculty")) {
                            PreparedStatement ps2 = con.prepareStatement("select * from Class_Teacher_details where Emp_ID=? ");
                            ps2.setInt(1, empid);
                            ResultSet rs2 = ps2.executeQuery();
                            if (rs2.next()) {
                                PreparedStatement ps1 = con.prepareStatement("select * from Class_Teacher_details where Emp_ID=? and Academic_Year=? and Semester=? ");
                                ps1.setInt(1, empid);
                                ps1.setString(2, academic_year);
                                ps1.setString(3, semester);
                                ResultSet rs1 = ps1.executeQuery();
                                System.out.print("bala");
                                if (rs1.next()) {
                                    System.out.print("b");
                                    last_choice = 3;

                                } else {
                                    last_choice = 4;

                                }

                            } else {

                                PreparedStatement ps3 = con.prepareStatement("select*from faculty_allocation_subjectwise_th where Emp_ID=? ");
                                ps3.setInt(1, empid);
                                ResultSet rs3 = ps3.executeQuery();
                                PreparedStatement ps4 = con.prepareStatement("select*from faculty_allocation_subjectwise_pr where Emp_ID=? ");
                                ps4.setInt(1, empid);
                                ResultSet rs4 = ps4.executeQuery();
                                rs4.next();

                                if (!rs3.next() && !rs4.next()) {
                                    last_choice = 5;

                                } else {

                                    PreparedStatement ps5 = con.prepareStatement("select*from faculty_allocation_subjectwise_th where Emp_ID=? and Academic_Year=? and Semester=? ");
                                    ps5.setInt(1, empid);
                                    ps5.setString(2, academic_year);
                                    ps5.setString(3, semester);
                                    ResultSet rs5 = ps5.executeQuery();
                                    PreparedStatement ps6 = con.prepareStatement("select*from faculty_allocation_subjectwise_pr where Emp_ID=? and Academic_Year=? and Semester=? ");
                                    ps6.setInt(1, empid);
                                    ps6.setString(2, academic_year);
                                    ps6.setString(3, semester);
                                    ResultSet rs6 = ps6.executeQuery();
                                    if (rs5.next() || rs6.next()) {
                                        last_choice = 6;

                                    } else {
                                        last_choice = 7;

                                    }

                                }
                            }
                        }
                        switch (last_choice) {
                            case 1: {

                                dispatcher = "Principal_Profile.jsp";
                                ses.setAttribute("academic_year", academic_year);
                                ses.setAttribute("semester", semester);
                                ses.setAttribute("course", course);

                            }
                            break;
                            case 2: {
                                dispatcher = "HOD_Profile.jsp";
                                ses.setAttribute("academic_year", academic_year);
                                ses.setAttribute("semester", semester);
                                ses.setAttribute("course", course);
                            }
                            break;
                            case 3: {
                                dispatcher = "Form13_CT_Login.jsp";
                                ses.setAttribute("academic_year", academic_year);
                                ses.setAttribute("semester", semester);
                                ses.setAttribute("course", course);
                            }
                            break;
                            case 4: {
                                request.setAttribute("errorMessage", "<center><font color='red'>sorry invalid combination,Try again</center>");
                                dispatcher = "Form6_CD.jsp";

                            }
                            break;
                            case 5: {
                                request.setAttribute("errorMessage", "<font color='red'><center>Sorry !! You've not been assigned yet..Please contact the Class Teacher.......!");
                                dispatcher = "Login.jsp";
                            }
                            break;
                            case 6: {

                                dispatcher = "Form17_SL.jsp";
                                ses.setAttribute("academic_year", academic_year);
                                ses.setAttribute("semester", semester);
                                ses.setAttribute("course", course);
                            }
                            break;
                            case 7: {
                                request.setAttribute("errorMessage", "<font color='red'><center>Sorry !! Invalid Combination....Please Try again!");
                                dispatcher = "Form6_CD.jsp";
                            }
                            break;

                        }
                        request.getRequestDispatcher(dispatcher).include(request, response);

                    } else {
                        request.setAttribute("errorMessage", "Please Sign In First....");
                        request.getRequestDispatcher("Login.jsp").include(request, response);
                    }
                    con.commit();

                } catch (Exception e) {
                    con.rollback();
                    request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Faculty not assigned yet.</h2></b></center></font>");
                    request.getRequestDispatcher("Login.jsp").include(request, response);
                } finally {
                    con.close();
                }
            }
        %>

    </body>
</html>