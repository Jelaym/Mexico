<%-- 
    Document   : mostrarPregs
    Created on : 15/05/2017, 03:38:20 PM
    Author     : Touchier
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    String boton= request.getParameter("boton");
    if(boton == null){
        out.println("<script> location.replace('/MexicoInTempore/Error.html'); </script>");
    }
%>    
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mostrar Preguntas</title>
        
        <style>
            #nombreEpo{
                text-align: center;
            }
            #contenido{
                width: 100%;
                height: 100%;
                text-align: center;
                overflow-x: auto;
            }
            table{
                border-collapse: collapse;
                border: 5px solid black;
                text-align: center;
            }
            tr:hover{
                background: #444444; 
                color: white;
            }
            
            .princ td{
                background-color: black;
                color: white;
            }
            .divi{
                visibility: hidden;
                position: absolute;
                top: 0px;
                left: 0px;
                height: 0px;
                width: 0px;
                z-index: -2;
            }
        </style>
        
        <script>
            function modificar(pre){
                document.getElementById("preguntas").innerHTML+= "<input class='divi' type='text' value='"+pre+"' name='pre'>";
                
                document.formu.method= "post";
                document.formu.action= 'traerPre.jsp';
                document.formu.Traer.click();
            }
        </script>
        
    </head>
    <body style="heigth: 100%; width: 100%; margin: 0px; background-color: white">
        <div id="contenido">
            <h1 id="nombreEpo">Preguntas de</h1>
            <div class="divi">
                <form class="divi" name="formu">
                    <input type="hidden" name="epo" id="epo">
                    <input class='divi' type='submit' name='Traer'>
                    <div id="preguntas">
                        
                    </div>
                </form>
            </div>
        <%
            cuestionario.cuestionario cuesti= new cuestionario.cuestionario();
            security.security secu= new security.security();
            
            String epoca= request.getParameter("epoca");
            if(epoca != null){
                out.println("<script> document.getElementById('nombreEpo').innerHTML+=' \""+epoca+"\"'; </script>");
                out.println("<script> document.getElementById('epo').value='"+epoca+"'; </script>");
                int numero= 0;
                if(epoca.equals("Independencia de México")){
                    numero= 1;
                }else{
                    if(epoca.equals("Guerra de Reforma")){
                        numero= 2;
                    }else{
                        if(epoca.equals("Revolución Mexicana")){
                            numero= 3;
                        }else{
                            out.println("<script> alert('"+epoca+"'); </script>");
                            out.println("<script> location.replace('/MexicoInTempore/Error.html'); </script>");
                        } 
                    }
                }
                int todas= cuesti.getPregEpoca(numero);
                
                String[] preguntasXrespuestas= cuesti.getValorCuestiOrdenadas(todas, numero);
                String[] preguntas= cuesti.separarPregs(todas, preguntasXrespuestas);
                
                int[] numPregunta= cuesti.separarResps(todas, preguntasXrespuestas);
                String[] respuestas= cuesti.getValorResp(numPregunta);
                
                out.println("<center>");
                out.println("<table>");
                    out.println("<tr class='princ'>");
                    
                    out.println("<td> No. Pregunta (Por Epoca)</td>");
                    out.println("<td> Pregunta </td>");
                    out.println("<td> Respuesta \"A\" </td>");
                    out.println("<td> Respuesta \"B\" </td>");
                    out.println("<td> Respuesta \"C\" </td>");
                    out.println("<td> Respuesta \"D\" </td>");
                    out.println("<td> Correcta </td>");
                    out.println("<td> Modificar </td>");
                    
                    out.println("</tr>");
                
                int conta= 0;
                String letras= "ABCD";
                
                for(int a= 0; a < todas-1; a++){
                    int correcta= cuesti.getCorrectRes(numPregunta[a]);
                    preguntas[a]= secu.agregarLine(preguntas[a]);
                    
                    out.println("<tr>");
                        out.println("<td> "+(a+1)+" </td>");
                        out.println("<td> "+preguntas[a]+" </td>");
                        out.println("<td> "+respuestas[conta++]+" </td>");
                        out.println("<td> "+respuestas[conta++]+" </td>");
                        out.println("<td> "+respuestas[conta++]+" </td>");
                        out.println("<td> "+respuestas[conta++]+" </td>");
                        out.println("<td> "+letras.charAt(correcta-1)+" </td>");
                        out.println("<td> <input type='button' value='Modificar' id='"+numPregunta[a]+"' onclick='modificar(this.id)'> </td>");
                    out.println("</tr>");
                }
                out.println("</table>");
                out.println("</center>");
            }else{
                out.println("<script> location.replace('/MexicoInTempore/Error.html'); </script>");
            }
        %>  
        </div>
    </body>
</html>
