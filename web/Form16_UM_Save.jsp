<%-- 
    Document   : Form16_UM_Save
    Created on : Sep 8, 2016, 12:26:34 AM
    Author     : sandeep
--%><%@page import="org.apache.poi.ss.usermodel.Sheet"%>
<%@page import="org.apache.poi.ss.usermodel.Workbook"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.apache.poi.ss.usermodel.Cell"%>
<%@page import="org.apache.poi.ss.usermodel.Row"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFSheet"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFWorkbook"%>


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
                con.setAutoCommit(false);
                try {
                    String year = (String) ses.getAttribute("year");
                    String branch = (String) ses.getAttribute("branch");
                    String division = (String) ses.getAttribute("division");
                    String academic_year = (String) ses.getAttribute("academic_year");
                    String semester = (String) ses.getAttribute("semester");

                    PreparedStatement ps = con.prepareStatement("select Faculty_ID,Subject_Code,Muster_Name from Theory_Muster_Allocation where Academic_Year=? and Year=? and Branch=? and Division=? and Semester=? ");
                    ps.setString(1, academic_year);
                    ps.setString(2, year);
                    ps.setString(3, branch);
                    ps.setString(4, division);
                    ps.setString(5, semester);
                    ResultSet rs = ps.executeQuery();

                    PreparedStatement ps1 = con.prepareStatement("select Faculty_ID,Subject_Code,Roll_From,Roll_To,Muster_Name from Practical_Muster_Allocation where Academic_Year=? and Year=? and Branch=? and Division=? and Semester=? ");
                    ps1.setString(1, academic_year);
                    ps1.setString(2, year);
                    ps1.setString(3, branch);
                    ps1.setString(4, division);
                    ps1.setString(5, semester);
                    ResultSet rs1 = ps1.executeQuery();

                    try {
                        String file_name = (String) ses.getAttribute("filename");
                        FileInputStream fs = new FileInputStream(new File(file_name));
                        Workbook workbook = new XSSFWorkbook(fs);
                        Sheet firstSheet = workbook.getSheetAt(0);

                        Iterator<Row> rowIterator = firstSheet.iterator();

                        int roll = 0, flag;
                        String student_id = "";
                        String student_name = "";

                        while (rowIterator.hasNext()) {
                            Row row = rowIterator.next();

                            Iterator<Cell> cellIterator = row.cellIterator();
                            flag = 0;
                            while (cellIterator.hasNext()) {
                                Cell cell = cellIterator.next();

                                switch (cell.getCellType()) {

                                    case Cell.CELL_TYPE_NUMERIC:
                                        roll = (int) cell.getNumericCellValue();
                                        break;

                                    case Cell.CELL_TYPE_STRING:
                                        if (flag == 0) {
                                            student_id = cell.getStringCellValue();//in this algorithm studentid always has to be before student name in xlsx
                                            flag++;
                                            break;

                                        } else {
                                            student_name = cell.getStringCellValue();
                                            break;
                                        }
                                }
                            }
                            if(roll>0)
                            {
                            PreparedStatement ps4 = con.prepareStatement("insert into " + academic_year + "_" + year + "_" + branch + "_" + semester + "_" + division + "_Muster(Student_Roll_No,Student_ID,Student_Name) values(?,?,?) ");
                            ps4.setInt(1, roll);
                            ps4.setString(2, student_id);               //recently added
                            ps4.setString(3, student_name);
                            ps4.executeUpdate();
                            while (rs.next()) {
                                int faculty_ID = rs.getInt(1);
                                String subject_code = rs.getString(2);
                                String muster_name = rs.getString(3);
                                String table_name = faculty_ID + "_" + academic_year + "_" + year + "_" + branch + "_" + division + "_" + subject_code + "_" + muster_name;
                                PreparedStatement ps2 = con.prepareStatement("insert into " + table_name + "(Student_Roll_No,Student_ID,Student_Name)values(?,?,?)");
                                ps2.setInt(1, roll);
                                ps2.setString(2, student_id);
                                ps2.setString(3, student_name);
                                ps2.executeUpdate();

                            }
                        
                            rs.beforeFirst();
                            while (rs1.next()) {
                                int faculty_ID = rs1.getInt(1);
                                String subject_code = rs1.getString(2);
                                int roll_from = rs1.getInt(3);
                                int roll_to = rs1.getInt(4);
                                String muster_name = rs1.getString(5);
                                if (roll >= roll_from && roll <= roll_to) {
                                    String table_name = faculty_ID + "_" + academic_year + "_" + year + "_" + branch + "_" + division + "_" + subject_code + "_" + muster_name;
                                    PreparedStatement ps3 = con.prepareStatement("insert into " + table_name + "(Student_Roll_No,Student_ID,Student_Name)values(?,?,?)");
                                    ps3.setInt(1, roll);
                                    ps3.setString(2, student_id);
                                    ps3.setString(3, student_name);
                                    ps3.executeUpdate();
                                }

                            }
                            rs1.beforeFirst();
                            }
                        }

                    } catch (Exception e) {
                        out.println(e);
                    }
                    con.commit();
                    request.setAttribute("errorMessage", "<font color='green'><center><h3>Roll Call List uploaded Successfully.....</h3></center></font>");
                    request.getRequestDispatcher("Form13_CT_Login.jsp").include(request, response);
        %>
    </body>
    <%
            } catch (Exception e) {
                con.rollback();
                request.setAttribute("errorMessage", "<font color='red'><center><b><h2>Problematic data(Repeated ID or Roll no.) in the file...Please check and try again...</h2></b></center></font>");
                request.getRequestDispatcher("Form16_UM.jsp").include(request, response);
            } finally {
                con.close();
            }
        }
    %>
</html>
