<%-- 
    Document   : Entrar
    Created on : 3/04/2017, 11:03:50 PM
    Author     : PCCYBER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@page import="java.sql.*, java.io.*" %>
        <%
            String correo = request.getParameter("correo");
            String contra = request.getParameter("c");
            Connection conect = null;
            Statement stateP = null;
            Statement stat = null;
            ResultSet resultProf= null;
            ResultSet result= null; 
            
            try{
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                conect= DriverManager.getConnection("jdbc:mysql://localhost/mexicum","root","n0m3l0");
                //state = conect.createStatement();
                stateP = conect.createStatement();
                stat = conect.createStatement();
            } catch(SQLException error){
                out.print(error.toString());
            }
            try{
               
                resultProf= stateP.executeQuery("SELECT * FROM profesor");
                
                while(resultProf.next()){
                    String cor = resultProf.getString("email");
                    String con = resultProf.getString("contra");
                    
                    
                    if(correo.equals(cor) && con.equals(contra)){
                        out.print("<script>localStorage.setItem('tipo', 2);</script>");
                        
                        String rfc= resultProf.getString("rfc");
                        HttpSession sesion = request.getSession();
                        sesion.setAttribute("usuario", rfc);
                        
                        out.println("<script>location.replace('/MexicoInTempore/paginaPrin/Seleccion.html');</script>");
                        
                    }
                    
                }
                
                result= stat.executeQuery("SELECT * FROM alumno");
                
                while(result.next()){
                    String cor = result.getString("email");
                    String con = result.getString("contra");
                    
                    
                    if(correo.equals(cor) && con.equals(contra)){
                        out.print("<script>localStorage.setItem('tipo', 1);</script>");
                        
                        String boleta= result.getString("Num_Boleta");
                        HttpSession sesion = request.getSession();
                        sesion.setAttribute("usuario", boleta);
                        
                        out.println("<script>location.href = '/MexicoInTempore/paginaPrin/Seleccion.html';</script>");
                        
                    }
                    
                }
                
                out.println("<script>alert('no se encontro tu cuenta');</script>");
                out.println("<script>location.href='/MexicoInTempore/paginaPrin/Inicio.html';</script>");
                
                
            } catch(SQLException error){
                out.println(error.toString());
            }
        %>
    </body>
</html>
