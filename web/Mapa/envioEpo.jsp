<%-- 
    Document   : envioEpo
    Created on : 1/05/2017, 08:29:57 PM
    Author     : Touchier
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    request.setCharacterEncoding("UTF-8");
    
    String boton= request.getParameter("avanza");
    
    HttpSession sesion= request.getSession();
    
    if(boton != null){
        String usuar= (sesion.getAttribute("usuario") != null)? sesion.getAttribute("usuario").toString(): null;
        if(usuar != null){
            int epo= Integer.parseInt(request.getParameter("epo"));
            
            usuario.cExists existe= new usuario.cExists();
            boolean exists= existe.declara("existeP", usuar);
            
            out.print("<script>localStorage.setItem('epoch', epo);</script>");
            
            if(exists == true){
                if(epo == 1){
                    response.sendRedirect("/MexicoInTempore/Mapa/Mapa2.html");
                }else{
                    if(epo == 2){
                        response.sendRedirect("/MexicoInTempore/Mapa/Mapa3.html");
                    }else{
                        out.println("<script> history.back(1); </script>");
                    }
                }
            }
        }
    }else{
        if(request.getSession() != null){
            String usuar= (sesion.getAttribute("usuario") != null)? sesion.getAttribute("usuario").toString(): null;

            if(usuar != null){
                usuario.cUsuario user= new usuario.cUsuario();
                int epoca= Integer.parseInt(user.getInfoUsuario(Integer.parseInt(usuar)));

                if(epoca < 3){
                   epoca++;
                }

                if(epoca != 0 && epoca != 1){
                    if(epoca == 2){
                        out.println("<script> location.href= 'Mapa2.html'; </script>");
                    }else{
                        if(epoca == 3){
                            out.println("<script> location.href= 'Mapa3.html'; </script>");
                        }
                    }
                }else{
                    out.println("<script> location.href='Mapa.html'; </script>");
                }
                out.println(epoca);
            }else{
                response.sendRedirect("/MexicoInTempore/paginaPrin/Inicio.html");
            }
        }else{
            response.sendRedirect("/MexicoInTempore/paginaPrin/Inicio.html");
        }
    }
%>
