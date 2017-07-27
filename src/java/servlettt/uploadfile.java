/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlettt;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import java.io.File;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.apache.commons.io.FilenameUtils;

public class uploadfile extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String fname = "";

            HttpSession ses = request.getSession(false);
            if (ses.getAttribute("empid") == null || ses.getAttribute("empid").equals("")) {
                response.sendRedirect("Login.jsp");
            }
            boolean isMultipart = ServletFileUpload.isMultipartContent(request);

            if (isMultipart) {
                // Create a factory for disk-based file items
                FileItemFactory factory = new DiskFileItemFactory();

                // Create a new file upload handler
                ServletFileUpload upload = new ServletFileUpload(factory);

                try {
                    int check = 0;
                    // Parse the request
                    List /* FileItem */ items = upload.parseRequest(request);
                    Iterator iterator = items.iterator();
                    while (iterator.hasNext()) {
                        FileItem item = (FileItem) iterator.next();
                        if (!item.isFormField()) {
                            String fileName = item.getName();
                            String root = getServletContext().getRealPath("/");
                            File path = new File("C:/AMS/Indira_attendance/Roll Call");
                            if (!path.exists()) {
                                boolean status = path.mkdirs();
                            }
                            String ext = FilenameUtils.getExtension(fileName);
                            if (!ext.equals("xlsx")) {
                                check = 1;
                                break;
                            } else {
                                File uploadedFile = new File(path + "/" + fileName);
                                item.write(uploadedFile);
                                fname = uploadedFile.getAbsolutePath();
                                ses.setAttribute("filename", fname);
                            }
                        }
                    }
                    if (check == 0) {
                        response.sendRedirect("Form16_UM_Save.jsp");
                    } else {
                        out.println("<font color='red'><center><b><h2>Please upload only the .xlsx file format...</h2></b></center></font>");
                        request.getRequestDispatcher("Form16_UM.jsp").include(request, response);
                    }

                } catch (FileUploadException e) {
                    System.out.println(e);
                } catch (Exception e) {
                    System.out.println(e);
                }
            }
        }
    }
}
