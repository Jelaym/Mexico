<%-- 
    Document   : modificar
    Created on : 22/04/2017, 03:52:09 PM
    Author     : Touchier
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> Modificar </title>
        <link rel="icon" type="image/x-icon" href="icon.ico" />
        
        <style>
            h1{
                font-size: 3em;
                color: white;
            }
            select{
                width: 24%;
                font-size: 1.5em;
                background-color: deepskyblue;
                color: white;
            }
            input{
                width: 15%;
                font-size: 1.5em;
                border-radius: 10px;
                border-color: black;
                background-color: deepskyblue;
                color: white;
                text-align: center;
                align-content: center;
            }
        </style>
        
        <script>
            function encontrar(){
                var combo= document.getElementById("epo");
                var comboPre= document.getElementById("pre");
                var numI= combo.selectedIndex;
            
                for(var i= comboPre.options.length; i > 0; i--){
                    comboPre.options[i]= null;
                }
                
                if(numI === 1){
                    document.getElementById("pre").style.visibility = "visible";
                    primero();
                    
                }else{
                    if(numI === 2){
                        document.getElementById("pre").style.visibility = "visible";
                        segundo();
                    }else{
                        if(numI === 3){
                            document.getElementById("pre").style.visibility = "visible";
                            tercero();
                        }else{
                            alert("No valido.");
                        }
                    }
                }
            }
            function siguiente(){
                document.getElementById("Traer").style.visibility = "visible";
            }
            function preg(){
                if((document.getElementById("epo").options.selectedIndex === 0) || (document.getElementById("pre").options.selectedIndex === 0)){
                    alert("Elige una epoca y/o Pregunta correcta.");
                    return false;
                }
            }
        </script>
        <script>
            window.history.replaceState({}, 'Buscar Pregunta', '/MexicoInTempore/cuestionario/cuesti.jsp');
        </script>
    </head>
    <body style="height: 100%; width: 100%; margin: 0px">
        <img src="imgCuesti/patron.jpeg" style="width: 100%; height: 100%; position: absolute; top: 0px; left: 0px; z-index: -1">
        <form method="post" action="traerPre.jsp" style="text-align: center; position: relative; z-index: 1; line-height: 200px">
            <h1> Buscar Pregunta </h1>
            <div style="line-height: 40px">
                <select id="epo" onchange="encontrar()" name="epo">
                    <option> -- Elige una Época -- </option>
                </select><br>
                <select id="pre" name="pre" onchange="siguiente()" style="visibility: hidden">
                    <option> -- Selecciona la pregunta -- </option>
                </select><br>
                <input type="submit" value="Traer Pregunta" id="Traer" name="Traer" onclick="return preg()" style="visibility: hidden">
            </div>
            <input type="hidden" id="ocul" name="ocul" >
        </form>
        
        <%
            cuestionario.cuestionario cuesti= new cuestionario.cuestionario();
            String[] nombres= cuesti.getEpocas();
            
            for(int i= 0; i < nombres.length; i++){
                out.println("<script>"
                                + "var combo= document.getElementById('epo'); "
                                + "combo.options["+(i+1)+"]= new Option('"+ nombres[i] +"');"
                            + "</script>");
            }
            
            int conta= 0, numT= 0;
            String[] textPregs= new String[numT];
            String[] pregs= new String[numT];
            int[] numPre= new int[numT];
            
            out.println("<script> var comb= 0; function primero(){");
                conta= 1;
                numT= cuesti.getPregEpoca(conta);

                if(numT != 0){
                    textPregs= cuesti.getValorCuesti(numT, conta);

                    pregs= cuesti.separarPregs(numT, textPregs);
                    numPre= cuesti.separarResps(numT, textPregs);

                    int orden= 0, oi= 0;
                    for(int io= 0; io < numPre.length; io++){
                        for(oi= 0; oi < numPre.length; oi++){
                            if(numPre[io] > numPre[oi]){
                                orden= numPre[oi];
                                numPre[oi]= numPre[io];
                                numPre[io]= orden;
                            }
                        }
                        oi= 0;
                    }
                    for(int a= 0; a < numPre.length-1 ; a++){
                        out.println("var combo2= document.getElementById('pre');");
                        out.println("combo2.options["+(a+1)+"]= new Option('"+ numPre[a] +"');");
                    }
                }else{
                    out.println("alert('No hay preguntas registradas.');");
                }
                
            out.println("} \n function segundo(){"); 
                conta= 2;
                numT= cuesti.getPregEpoca(conta);

                if(numT != 0){
                    textPregs= cuesti.getValorCuesti(numT, conta);

                    pregs= cuesti.separarPregs(numT, textPregs);
                    numPre= cuesti.separarResps(numT, textPregs);

                    int orden= 0, oi= 0;
                    for(int io= 0; io < numPre.length; io++){
                        for(oi= 0; oi < numPre.length; oi++){
                            if(numPre[io] > numPre[oi]){
                                orden= numPre[oi];
                                numPre[oi]= numPre[io];
                                numPre[io]= orden;
                            }
                        }
                        oi= 0;
                    }
                    
                    for(int a= 0; a < numPre.length-1; a++){
                        out.println("var combo2= document.getElementById('pre');");
                        out.println("combo2.options["+(a+1)+"]= new Option('"+ numPre[a] +"');");
                    }
                }else{
                    out.println("alert('No hay preguntas registradas.');");
                }
                
            out.println("} \n function tercero(){");
                conta= 3;
                numT= cuesti.getPregEpoca(conta);
                if(numT != 0){
                    textPregs= cuesti.getValorCuesti(numT, conta);

                    pregs= cuesti.separarPregs(numT, textPregs);
                    numPre= cuesti.separarResps(numT, textPregs);

                    int orden= 0, oi= 0;
                    for(int io= 0; io < numPre.length; io++){
                        for(oi= 0; oi < numPre.length; oi++){
                            if(numPre[io] > numPre[oi]){
                                orden= numPre[oi];
                                numPre[oi]= numPre[io];
                                numPre[io]= orden;
                            }
                        }
                        oi= 0;
                    }
                    
                    for(int a= 0; a < numPre.length-1; a++){
                        out.println("var combo2= document.getElementById('pre');");
                        out.println("combo2.options["+(a+1)+"]= new Option('"+ numPre[a] +"');");
                    }
                }else{
                    out.println("alert('No hay preguntas registradas.');");
                }
            out.println("}</script>");
        %>    
    </body>
</html>
