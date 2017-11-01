<%-- 
    Document   : preguntas
    Created on : 30/03/2017, 09:18:23 AM
    Author     : CECyT9
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Preguntas</title>
        
        <script>
            function preguntas(){
                
            }
        </script>
        
    </head>
    <body>
        <%@page import="java.io.*,java.sql.*" %>
        <%
            Connection cont= null;
            Statement stat= null;
            ResultSet resultado= null;
            String pregunta;

            try{
                Class.forName("com.mysql.jdbc.driver").newInstance();
                cont= DriverManager.getConnection("jdbc:mysql://localhost/examen"+"root"+"2016090389");
                stat= cont.createStatement();
            }catch(SQLException e){
                out.println("No puedo cargar.");
            }
            int random= (int) Math.floor(Math.random()*50 + 1);
            out.println("<script>alert(random);</script>");
            try{
                pregunta= request.getParameter("pregunta");
                resultado= stat.executeQuery("Select preguntas from cuestionario");
                String preg= resultado.getString("pregunta");
               
            }catch(SQLException e){
                
            }
        %>        
    </body>
</html>
