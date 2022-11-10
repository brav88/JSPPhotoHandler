<%-- 
    Document   : userProfile
    Created on : 9 nov. 2022, 19:15:51
    Author     : Samuel
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
        <title>User Profile</title>
    </head>
    <body>
        <%!
            
            Connection con;
            ResultSet resultset;

            public void jspInit() {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost/webusers", "root", "Admin$1234");
                    Statement statement = con.createStatement();
                    resultset = statement.executeQuery("select * from users where Id = 2");
                    resultset.next();
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }

            public void jspDestroy() {
                try {
                    con.close();
                    resultset.close();
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
        %>   
        <section class="vh-100" style="background-color: #9de2ff;">
            <div class="container py-5 h-100">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col col-md-9 col-lg-7 col-xl-5">
                        <div class="card" style="border-radius: 15px;">
                            <div class="card-body p-4">
                                <div class="d-flex text-black">
                                    <div class="flex-shrink-0">
                                        <img src=<%=resultset.getString("PhotoPath")%> 
                                             alt="Generic placeholder image" class="img-fluid"
                                             style="width: 180px; border-radius: 10px;">
                                    </div>
                                    <div class="flex-grow-1 ms-3">
                                        <h5 class="mb-1"><%=resultset.getString("Name")%> <%=resultset.getString("LastName")%></h5>
                                        <p class="mb-2 pb-1" style="color: #2b2a2a;"><%=resultset.getString("Email")%></p>
                                        <div class="d-flex justify-content-start rounded-3 p-2 mb-2"
                                             style="background-color: #efefef;">
                                            <div>
                                                <form action="upload.jsp?userId=<%=resultset.getString("Id")%>" method="post" enctype="multipart/form-data">                                                    
                                                    <input type="file" name="file" size="50" style="width:59%"/>
                                                    <br />                                                    
                                                    <div class="d-flex pt-1">                                            
                                                        <button type="submit" class="btn btn-primary flex-grow-1">Update photo</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </body>
</html>
