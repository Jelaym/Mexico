<%-- 
    Document   : registrarPre
    Created on : 16/04/2017, 02:33:24 PM
    Author     : Touchier
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html style="width: 100%; height: 100%; margin: 0px;">
    <head>
        <title>Registrar una pregunta</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="icon" type="image/x-icon" href="icon.ico" />
        
        <style>
            label.sLab{
                color: white;
            }
            input[type= "text"]{
                background-color: #D0E9FA;
                border-radius: 10px;
                width: 140px;            
            }
            input[type= "text"]:focus{
                box-shadow: 0px 0px 18px cornflowerblue;
            }
            #epocas{
                position: relative;
                background-color: white;
                z-index: 1;
                color: black;
            }
            #cNumPre{
                position: relative;
                z-index: 1;
            }
        </style>
        
        <script>
            function traer()
            {
                var loc = document.location.href;
                if(loc.indexOf('?')>0)
                {
                    var getString = loc.split('?')[1];
                    var GET = getString.split('&');
                    var get = {};
                    for(var i = 0, l = GET.length; i < l; i++){
                        var tmp = GET[i].split('=');
                        get[tmp[0]] = unescape(decodeURI(tmp[1]));
                    }
                    return get;
                }
            }
            
            window.onload = function ()
            {
                var valores= traer();
                if(valores)
                {
                    var epoca = valores['E'];
                    var numE= valores['T'];
                    
                    document.getElementById("epocas").innerHTML= '<center><h1>' + epoca + '</h1></center>';
                    document.getElementById("epocas").innerHTML+= '<input type="text" name="numE" value="'+numE+'" style="visibility: hidden">';
                    document.getElementById("epocas").innerHTML+= '<center><label class="regi"> Registrar Pregunta </label></center>';
                    
                    window.history.replaceState({}, 'Registrar Preguntas', '/MexicoInTempore/cuestionario/ModifyCuesti.html');
                }else{
                    location.replace("ModifyCuesti.html");
                }
            };
        </script>
    </head>
    <body style="width: 100%; height: 95%; margin: 0px;">
        <%@page import="java.io.*,java.sql.*"%>
        <img src="imgCuesti/patron.jpeg" style="width: 100%; height: 100%; position: absolute; top: 0px; left: 0px; z-index: 0">
        
        <form name="formu" method="post" action="regiP.jsp">
            <div id="epocas" style="color: #37C8D2; background-color: transparent;">
                <script>//AQUI SE PONDRA EL TEMA</script>
            </div>
            <br><br>
            
            <center id="cNumPre">
                <label style="text-align: center; color: white; font-size: 20px;"> Pregunta No.  </label>
                <input type="number" id="nume" placeholder="Numero de Pregunta" name="numPre" style="font-size: 20px; background-color: transparent; outline: none; color:white; border: none;" readonly>
                <%
                    cuestionario.cuestionario cuesti= new cuestionario.cuestionario();
                    
                    int numE= Integer.parseInt(request.getParameter("epoca"));
                    
                    int num= 0;
                    num= cuesti.getPregEpoca(numE);
                    out.println("<script> document.getElementById('nume').value="+num+"; </script>");
                %>
            </center>
            <br><br>
            
            <label class="sLab" style="position: absolute; top: 35%; left: 22%"> Escriba la Pregunta: </label>
            <div style="position: absolute; top: 40%; left: 20%">
                <textarea cols="40" rows="10" style="resize: none" name="TextPre" required></textarea>
            </div>
            
            <div style="position: absolute; top: 40%; right: 20%; color: white">
                A) <input type="text" placeholder="Escriba la respuesta A)" required name="ra"> <input type="radio" value='A' name="resp"> <br><br>
                B) <input type="text" placeholder="Escriba la respuesta B)" required name="rb"> <input type="radio" value='B' name="resp"> <br><br>
                C) <input type="text" placeholder="Escriba la respuesta C)" required name="rc"> <input type="radio" value='C' name="resp"> <br><br>
                D) <input type="text" placeholder="Escriba la respuesta D)" required name="rd"> <input type="radio" value='D' required name="resp"> <br><br>
            </div>
            
            <div style="position: absolute; top: 79%; width: 100%; height: 4%; text-align: center">
                <input type="submit" value="Registrar" name="Regi" style="color: white; background-color: #37C8D2; border-radius: 10px; border-color: transparent; font-size: 20px;">
            </div>    
        </form>
    </body>
</html>
