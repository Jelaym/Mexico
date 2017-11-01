<%-- 
    Document   : quizVal
    Created on : 29/04/2017, 12:25:09 PM
    Author     : Touchier
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String boton= request.getParameter("qui");
    if(boton != null){
        //out.println("Entro a la pagina.");
        String letras= "ABCDEFJHIJ", separa= "";
        String[] valores= new String[letras.length()];
        
        for(int a= 0; a < letras.length(); a++){
            separa= "" + letras.charAt(a);
            valores[a]= request.getParameter(separa);
        }
        
        String numPre= request.getParameter("pre");
        
        cuestionario.splits spli= new cuestionario.splits();
        cuestionario.alumnoCues alum= new cuestionario.alumnoCues();
        
        int[] nums= spli.miSplitNumero(numPre, ',');
        
        if(alum.validar(nums)){
            //TODOS EXISTEN
            int[] score= alum.scoreQuiz(nums, valores);
            
            String estado= alum.Status(score[0], score[1]);
            
            HttpSession sesion= request.getSession();
            String usuar= sesion.getAttribute("usuario").toString();
            
            if(usuar != null){
                //RECUERDA QUE NUMBOLETA Y ALUMNO DEBEMOS TRAERLAS CON ALGO
                String epo= request.getParameter("epo");
                if((epo.equals("1")) || (epo.equals("2")) || (epo.equals("3"))){
                    alum.AgregarScore(score[0], score[1], estado, usuar, Integer.parseInt(epo));
                    
                    if(epo.equals("1")){
                        if(estado.equals("Logrado")){
                            out.println("<script> alert('Bien has pasado la segunda Epoca!!'); "
                                    + "location.href='/MexicoInTempore/Mapa/Mapa2.html'; "
                                    + "</script>");
                        }else{
                            out.println("<script> alert('No has alcanzado los puntos necesarios'); "
                                    + "location.href='/MexicoInTempore/Mapa/Mapa.html'; "
                                    + "</script>");
                        }
                    }else{
                        if(epo.equals("2")){
                            if(estado.equals("Logrado")){
                                out.println("<script> alert('Bien has pasado a la tercera Epoca!!'); "
                                        + "location.href='/MexicoInTempore/Mapa/Mapa3.html'; "
                                        + "</script>");
                            }else{
                                out.println("<script> alert('No has alcanzado los puntos necesarios'); "
                                        + "location.href='/MexicoInTempore/Mapa/Mapa2.html'; "
                                        + "</script>");
                            }
                        }else{
                            if(epo.equals("3")){
                                if(estado.equals("Logrado")){
                                    out.println("<script> alert('Bien has completado los cuestionarios exitosamente! :D'); "
                                            + "location.href='/MexicoInTempore/paginaPrin/Seleccion.html'; "
                                            + "</script>");
                                }else{
                                    out.println("<script> alert('No has alcanzado los puntos necesarios'); "
                                            + "location.href='/MexicoInTempore/Mapa/Mapa3.html'; "
                                            + "</script>");
                                }
                            }
                        }
                    }
                }
            }else{
                response.sendRedirect("Error.html");
            }
            //AQUI DEBEMOS DE PONER EN QUE EPOCA ESTA PARA ENVIARLO AL MAPA YA SEA ENVIARLO POR LOCAL STORAGE O POST
        }else{
            out.println("Mal");
        }
    }else{
        out.println("Imposible entrar a la pagina.");
    }
%>
