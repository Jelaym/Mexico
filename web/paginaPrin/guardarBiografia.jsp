<%-- 
    Document   : guardarBiografia
    Created on : 15-abr-2017, 18:24:37
    Author     : David
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@page import="java.sql.ResultSet,Biografias.cInformacionBases" %>
        <%
            request.setCharacterEncoding("UTF-8");
            cInformacionBases sql = new cInformacionBases();
            int idbb = 1;
            int Identificador = Integer.parseInt(request.getParameter("identificador"));
            String guardar = request.getParameter("guardar");
            String crear = request.getParameter("crear");
            String eliminar = request.getParameter("Borrar");
            
            ResultSet res = null;
            String haz = "";
            
            try{
                sql.conectar();                
            }catch(Exception ex){
                haz = ex.getMessage();
            }
            if(crear != null){
                int Seccion = Integer.parseInt(request.getParameter("seccion"));
                String Titulo = sql.enlace(request.getParameter("nombre"));
                String Informacion = sql.informacion(request.getParameter("bio"));
                String Imagen = request.getParameter("imx");
                if(Imagen.equals("")){
                    Imagen = "Logo.jpg";
                }
                try{
                    
                    //String IMG = sql.GuardarImagen(Imagen);
                    int idb = 0;
                    res = sql.consultar("SELECT * FROM biografia");
                    
                    while(res.next()){
                        idb = res.getInt("idBiografia");
                    }
                    idbb += idb;
                   
                    sql.insertar("Insert into biografia values("+idbb+",'"+Titulo+"','"+Informacion+"',"+Seccion+",'"+Imagen+"');");
                    
                    out.println("<script>alert('La Biografia fue creada con éxito.');</script>");
                    out.println("<script>location.replace('Biografias.jsp');</script>"); 
                }catch(Exception ex){
                   
                   haz = ex.getMessage();
                   out.println("<script>alert('A ocurrido un error :)');</script>");
                   out.println("<script>location.replace('Biografias.jsp');</script>"); 
                }
            }
            if(guardar != null){
                String Titulo = sql.enlace(request.getParameter("nombre"));
                String Informacion = sql.informacion(request.getParameter("bio"));
                String Imagen = request.getParameter("imx");
                if(Imagen.equals("")){
                    Imagen = "Logo.jpg";
                }
                
                //String Imagen2 = sql.enlace(Imagen);
                try{
                    
                    /*out.println("<script>alert('"+Imagen2+"');</script>");
                    String IMG = sql.GuardarImagen(Imagen2);
                    out.println("<script>alert('La Biografia fue modificada con exito');</script>");*/
                    if(Imagen.equals("Logo.jpg")){
                        sql.insertar("Update biografia set titulo ='"+Titulo+"', informacion = '"+Informacion+"' where idBiografia = "+Identificador+";");
                    }else{
                        sql.insertar("Update biografia set titulo ='"+Titulo+"', informacion = '"+Informacion+"', imagen='"+Imagen+"' where idBiografia = "+Identificador+";");
                    }
                    
                    out.println("<script>alert('La Biografia fue modificada con exito');</script>");
                    out.println("<script>location.replace('Biografias.jsp');</script>"); 
                }catch(Exception ex){
                   
                   haz = ex.getMessage();
                   out.println("<script>alert('A ocurrido un error :)');</script>");
                   out.println("<script>location.replace('Biografias.jsp');</script>"); 
                }
            }
            if(eliminar != null){
                try{
                    
                    sql.insertar("Delete from biografia where idBiografia = "+Identificador+";");
                    out.println("<script>alert('La Biografia fue eliminada con exito');</script>");
                    out.println("<script>location.replace('Biografias.jsp');</script>"); 
                }catch(Exception ex){
                   
                   haz = ex.getMessage();
                   out.println("<script>alert('A ocurrido un error :)');</script>");
                   out.println("<script>location.replace('Biografias.jsp');</script>"); 
                }
            }
        %>
    </body>
</html>
