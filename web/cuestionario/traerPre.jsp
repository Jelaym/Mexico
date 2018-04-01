<%-- 
    Document   : traerPre
    Created on : 24/04/2017, 09:35:36 AM
    Author     : CECyT9
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Modificar</title>
        <link rel="icon" type="image/x-icon" href="/MexicoInTempore/icon.ico" />
        
        <style>
            input[type="submit"]{
                border-radius: 10px;
                width: 160px;
                height: 30px;
                font-family: serif;
                background-color: #37C8D2;
            }
        </style>
        <script>
            function numeroEpoca(){
                var combo= document.getElementById("epo");
                var texto= document.getElementById("numE");
                
                texto.value= combo.selectedIndex;
            }
        </script>
        <script>
            window.history.replaceState({}, 'Buscar Pregunta', '/MexicoInTempore/cuestionario/cuesti.jsp');
        </script>
    </head>
    <body style="width: 100%; height: 100%; margin: 0px">
       
        <form name="formu" action="cSecurity.jsp" method="post" style="text-align: center">
            <h1 id="titulo"></h1>
            <h2 id="numero"></h2>
            <div >
                <div>
                    <label> Modificar Epoca: </label>
                    <select id="epo" name="epo" onchange="numeroEpoca()">
                        <option> -- Elige una Época --</option>
                    </select>
                    <input type="hidden" name="numE" id="numE">
                    <input type="hidden" name="num" id="num">
                </div>
                <br>
                <div>
                    <textarea id="textoArea" name="pregunta" style="width: 400px; height: 100px;">
                    
                    </textarea>
                </div>
                <br>
                
                <div>
                    <input type="radio" name="resp" value="A" id="radio1"> <input type="text" name="Res1" id="Res1"> 
                    <input type="radio" name="resp" value="B" id="radio2"> <input type="text" name="Res2" id="Res2"> 
                    <input type="radio" name="resp" value="C" id="radio3"> <input type="text" name="Res3" id="Res3"> 
                    <input type="radio" name="resp" value="D" id="radio4"> <input type="text" name="Res4" id="Res4"> 
                </div>
                <br><br>
                
                <input type="submit" value="Guardar Modificación" name="Modificar" onclick="return numeroEpoca()">
                <input type="submit" name="Eliminar" value="Eliminar esta pregunta." onclick="return confirm('Esta pregunta se eliminará permanentemente. ¿Esta seguro?');">
            </div>
        </form>
        <%
            request.setCharacterEncoding("UTF-8");
            String boton= request.getParameter("Traer");
            if(boton != null){
                String epoca= request.getParameter("epo");
                
                int pregunta= Integer.parseInt(request.getParameter("pre"));
                
                cuestionario.cuestionario cTraer= new cuestionario.cuestionario();
                security.security secu= new security.security();
                
                String[] nombres= cTraer.getEpocas();
                int[] numPre= new int[1];
                numPre[0]= pregunta;
                
                for(int i= 0; i < nombres.length; i++){
                    out.println("<script>"
                                    + "var combo= document.getElementById('epo'); "
                                    + "combo.options["+(i+1)+"]= new Option('"+ nombres[i] +"'); ");
                        if(nombres[i].equals(epoca)){
                            out.println("combo.selectedIndex='"+(i+1)+"';");
                        }
                    out.println("</script>");
                }

                out.println("<script> "
                        + "numeroEpoca(); "
                        + "document.getElementById('titulo').innerHTML='"+ epoca +"'; "
                        + "document.getElementById('numero').innerHTML= '"+pregunta+", El número de pregunta es inmodificable.'; "
                                + "document.getElementById('num').value='"+pregunta+"';");
                
                String textoPre= cTraer.getValPre(pregunta);
                //Traemos las cuatro respuestas de la pregunta
                String[] respuestas= new String[4];
                respuestas= cTraer.getValorResp(numPre);
                
                for(int a= 0; a < respuestas.length; a++){
                    out.println("document.getElementById('Res"+(a+1)+"').value='"+respuestas[a]+"'; ");
                }
                
                textoPre= secu.agregarLineTextarea(textoPre);
                
                out.println("document.getElementById('textoArea').value= '"+textoPre+"'; ");
                
                int num= 0;
                num= cTraer.getCorrectRes(pregunta);
                
                for(int e= 1; e < 5; e++){
                    if(num == e){
                        out.println("document.getElementById('radio"+e+"').checked= 'checked';");
                        e= 5;
                    }
                }
                
                out.println("</script>");
            }else{
                out.println("<script> location.replace('modificar.jsp'); </script>");
            }
        %>
    </body>
</html>
