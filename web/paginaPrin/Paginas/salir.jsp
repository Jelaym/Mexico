<%-- 
    Document   : salir
    Created on : 2/05/2017, 05:28:35 PM
    Author     : Touchier
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%
    HttpSession sesion = request.getSession();
    sesion.invalidate();
    String cuenta= "Tu sesión ha sido cerrada.";
    
    out.print("<script> localStorage.setItem('tipo', 0); </script>");
    out.println("<script> location.href = 'Inicio.html'; </script>");
%>
