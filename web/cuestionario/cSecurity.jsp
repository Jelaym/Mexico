<%-- 
    Document   : cSecurity
    Created on : 26/04/2017, 06:40:09 PM
    Author     : Touchier
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    security.security secury= new security.security();
    usuario.cUsuario user= new usuario.cUsuario();
                
    String boton1= request.getParameter("Eliminar");
    String boton2= request.getParameter("Modificar");
    
    if((boton2 != null) || (boton1 != null)){
        String texto= request.getParameter("pregunta");
        boolean notNull= false;
        
        notNull= ((texto != null)||(!texto.equals("")))? true: false;
        
        if(notNull == true){
            if(secury.notEtiquetas(texto) == true){
                out.println("<script> alert('Hay algunos caracteres especiales no permitidos.\n No se puede registrar la Pregunta'); </script>");
                //out.println("<script>location.replace('/MexicoInTempore/Error.html');</script>");
                out.println("<script> history.back(1); </script>");
            }else{
                cuestionario.cuestionario cGuardar= new cuestionario.cuestionario();

                if(boton2 != null){
                    int numPre= Integer.parseInt(request.getParameter("num"));
                    //String texto= request.getParameter("pregunta");
                    int epo= Integer.parseInt(request.getParameter("numE"));

                    String[] textResp= new String[4];
                    textResp[0]= request.getParameter("Res1");
                    textResp[1]= request.getParameter("Res2");
                    textResp[2]= request.getParameter("Res3");
                    textResp[3]= request.getParameter("Res4");

                    notNull= (((textResp[0] != null)||(!textResp[0].equals(""))&&(notNull == true)))? true: false;
                    notNull= (((textResp[1] != null)||(!textResp[1].equals(""))&&(notNull == true)))? true: false;
                    notNull= (((textResp[2] != null)||(!textResp[2].equals(""))&&(notNull == true)))? true: false;
                    notNull= (((textResp[3] != null)||(!textResp[3].equals(""))&&(notNull == true)))? true: false;
                    
                    String Correcta= request.getParameter("resp");
                    notNull= (((Correcta != null)||(!Correcta.equals(""))&&(notNull == true)))? true: false;
                    
                    if(notNull == true){
                        security.security secu= new security.security();
                        texto= secu.quitarLine(texto);
                        boolean valido= false;

                        valido= (user.esRangoMenor(textResp[0], 50))? true: false;
                        valido= ((user.esRangoMenor(textResp[1], 50)) && (valido == true))? true: false;
                        valido= ((user.esRangoMenor(textResp[2], 50)) && (valido == true))? true: false;
                        valido= ((user.esRangoMenor(textResp[3], 50)) && (valido == true))? true: false;

                        if(valido == true){
                            cGuardar.cActualizar(numPre, texto, epo, textResp, Correcta);

                            out.println("<script> alert('Modificada con exito!'); </script>");
                        }else{
                            out.println("<script> alert('Error al modificar.'); </script>");
                            out.println("<script> history.back(1); </script>");
                        }
                    }else{
                        out.println("<script> alert('Un campo es invalido.'); </script>");
                        out.println("<script> history.back(1); </script>");
                    }
                }else{
                    if(boton1 != null){
                        int numPre= Integer.parseInt(request.getParameter("num"));
                        cGuardar.cEliminar(numPre);

                        out.println("<script> alert('Eliminada con exito!'); </script>");
                    }else{
                        out.println("<script>location.assign('/MexicoInTempore/Error.html');</script>");
                    }
                }
                out.println("<script>location.replace('modificar.jsp');</script>");
            }
        }else{
            out.println("<script> alert('Un campo es invalido.'); </script>");
            out.println("<script> history.back(1); </script>");
        }
    }else{
        out.println("<script>location.replace('/MexicoInTempore/Error.html');</script>");
    }
%>
