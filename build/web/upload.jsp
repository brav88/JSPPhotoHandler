<%-- 
    Document   : upload.jsp
    Created on : 9 nov. 2022, 19:26:49
    Author     : Samuel
--%>

<%@page import="java.sql.*"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.apache.tomcat.util.http.fileupload.FileItem"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory"%>
<%@page import="java.io.File"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            File file;
            String filePath = "C:/Users/Samuel/Documents/NetBeansProjects/JSPPhotoHandler/web/img/";
            ServletFileUpload upload = new ServletFileUpload(new DiskFileItemFactory());
            
            String userId = request.getParameter("userId");

            List fileItems = upload.parseRequest(new ServletRequestContext(request));
            Iterator i = fileItems.iterator();
            while (i.hasNext()) {
                FileItem fi = (FileItem)i.next();
                if (!fi.isFormField()) {
                    /*String fileName = fi.getName();*/
                    file = new File(filePath + userId + ".jpg");
                    fi.write(file);                    
                    /*Actualice la base de datos*/
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost/webusers", "root", "Admin$1234");
                    Statement statement = con.createStatement();
                    statement.executeUpdate("UPDATE users SET PhotoPath = 'img/"+ userId +".jpg' WHERE Id =" + userId);
                    out.println("<script type='text/javascript'>alert('Photo updated succesfully');</script>");
                    /**/
                    response.sendRedirect("/JSPPhotoHandler/userProfile.jsp");
                    /*RequestDispatcher rd = request.getRequestDispatcher("/userProfile.jsp");
                    rd.include(request, response);*/
                }
            }
        %>
    </body>
</html>
