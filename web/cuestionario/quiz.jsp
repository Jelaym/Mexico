<%-- 
    Document   : quiz
    Created on : 17/04/2017, 05:33:05 PM
    Author     : Touchier
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style='height: 100%; width: 100%; margin: 0px'>
    <head style='height: 100%; width: 100%; margin: 0px'>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> Cuestionario </title>
        <link rel="icon" type="image/x-icon" href="/MexicoInTempore/icon.ico" />
        <link href="cssCuesti/sQuiz.css" rel="stylesheet" type="text/css"/>
        
        <script>
            var numeroPri, numeroSeg, contador;
            var intervalo;
            function cambiar() {
                numeroPri= 0;
                contador= 0;
                
                document.getElementById("sig").style.visibility = 'hidden';
                document.getElementById("vol").style.visibility = 'hidden';
                
                document.getElementById("primera").style.opacity= 0;
                document.getElementById("segunda").style.opacity= 0;
                document.getElementById("segunda").style.visibility = 'visible';
                document.getElementById("primera").style.visibility = 'hidden';
                intervalo= setInterval("animacionDis()",100);
            }

            function volver() {
                numeroSeg= 0;
                contador= 0;
                
                document.getElementById("vol").style.visibility = 'hidden';
                document.getElementById("sig").style.visibility = 'hidden';
                
                document.getElementById("segunda").style.opacity= 0;
                document.getElementById("primera").style.opacity= 0;
                document.getElementById("primera").style.visibility = 'visible';
                document.getElementById("segunda").style.visibility = 'hidden';
                intervalo= setInterval("animacionAum()",100);
            }
            
            function animacionAum(){
                numeroSeg+= 0.1;
                document.getElementById("primera").style.opacity= numeroSeg;
                contador++;
                
                if(contador === 10){
                    clearInterval(intervalo);
                    document.getElementById("sig").style.visibility = 'visible';
                }
            }
            function animacionDis(){
                numeroPri+= 0.1;
                document.getElementById("segunda").style.opacity= numeroPri;
                contador++;
                
                if(contador === 10){
                    clearInterval(intervalo);
                    document.getElementById("vol").style.visibility = 'visible';
                }
            }

            function agregar() {
                document.getElementById("titulo").innerHTML += "<input type='submit' name='qui' style='visibility: hidden'>";
            }
        </script>

        <script>
            function ponerColor(id){
                document.getElementById(id).style.color= "white";
                document.getElementById(id).style.background= "#494848";
            }
            function quitarColor(id){
                document.getElementById(id).style.color= "black";
                document.getElementById(id).style.background= "transparent";
            }
            function quitarColorError(id){
                document.getElementById(id).style.color= "red";
                document.getElementById(id).style.background= "transparent";
            }
        </script>    
        
        <script>
            function contest() {
                var numeMax = parseInt(document.getElementById("numer").value), num = 0, cuatro = 0;
                var todo = false, conta = 0;
                var letras = "ABCDEFGHIJ";
                var radio1, radio2, radio3, radio4;
                var agrupar= "Faltan por responder las preguntas: <br>";
                
                for (var i = 0; i < numeMax; i++) {
                    cuatro++;
                    radio1 = document.getElementById("resp" + (letras.charAt(num) + (cuatro++)));
                    radio2 = document.getElementById("resp" + (letras.charAt(num) + (cuatro++)));
                    radio3 = document.getElementById("resp" + (letras.charAt(num) + (cuatro++)));
                    radio4 = document.getElementById("resp" + (letras.charAt(num) + (cuatro++)));

                    if ((radio1.checked) || (radio2.checked) || (radio3.checked) || (radio4.checked)) {
                        conta++;
                        
                        if(i <= 4){
                            document.getElementById("div" + (i+1)).style.boxShadow= "inset 0px 0px 0px 0px lawngreen";
                        }else{
                            if(i <= 9){
                                document.getElementById("divi" + (i-4)).style.boxShadow= "inset 0px 0px 0px 0px lawngreen";
                            }
                        }
                        
                        if (conta === 10) {
                            agregar();
                            todo = true;
                        }
                    }else{
                        if(i !== (numeMax-1)){
                            agrupar+= (i+1) + ", ";
                        }else{
                            agrupar+= (i+1) + ".";
                        }
                        
                        if(i <= 4){
                            document.getElementById("div" + (i+1)).style.boxShadow= "inset 0px 0px 4px 6px red";
                        }else{
                            if(i <= 9){
                                document.getElementById("divi" + (i-4)).style.boxShadow= "inset 0px 0px 4px 6px red";
                            }
                        }
                    }
                    num++;
                    cuatro = 0;
                }

                if (todo === true) {
                    document.getElementById("div6").style.boxShadow= "inset 0px 0px 0px 0px lawngreen";
                    document.getElementById("divi6").style.boxShadow= "inset 0px 0px 0px 0px lawngreen";
                    
                    document.formu.qui.click();
                }else{
                    document.getElementById("div6").style.boxShadow= "inset 0px 0px 4px 6px red";
                    document.getElementById("divi6").style.boxShadow= "inset 0px 0px 4px 6px red";
                    
                    document.getElementById("div6").innerHTML= agrupar;
                    document.getElementById("divi6").innerHTML= agrupar;
                }
            }
        </script>
    </head>
    <body onload="contatiempo()" style='height: 100%; width: 100%; margin: 0px'>
        <div id="elimina">
            <script>
                function contatiempo() {
                    setTimeout('document.getElementById(\'primera\').style.visibility= \'visible\';', 150);
                    setTimeout('eliminar()', 150);
                }
                function eliminar() {
                    var nodoP = document.getElementById("asdB");
                    var nodoH = document.getElementById("borrar");

                    nodo = nodoP.removeChild(nodoH);

                    nodoP = document.body;
                    nodoH = document.getElementById("elimina");
                    nodo = nodoP.removeChild(nodoH);
                }
            </script>
        </div>
        <form action="quizVal.jsp" method="post" name="formu" id="formu" style='height: 100%; width: 100%; margin: 0px'> 
            <header id="menu">
                <a id="cabeza">
                    <span id="titulo">Cuestionario de</span><br>
                    <span class="instruccion">Responde todas las preguntas.</span>
                    <span class="instruccion">Recuerda leer con cuidado cada pregunta.</span>
                </a>
                <nav>
                    <ul>
                        <li><a onclick="cambiar()" id="sig"> Siguientes Preguntas </a></li>
                        <li><a id="vol" onclick="volver()" style="visibility: hidden"> Anteriores Preguntas </a></li>
                        <li><a id="env" onclick="contest()"> Enviar </a></li>
                    </ul>
                </nav>
                <input type="hidden" id="numer">
            </header>

            <section id="contenido">
                <article id="primera">
                    <div class="divPri">
                        <input type="hidden" id="pre" name="pre">
                        <div id="div1" onmouseover="ponerColor(this.id)" onmouseout="quitarColor(this.id)">
                            <p id="preg1" name="preg1"></p>
                            <label id="A1" for="respA1"> </label> <input name="A" value="A" id="respA1" type="radio"> <br>
                            <label id="A2" for="respA2"> </label> <input name="A" value="B" id="respA2" type="radio"> <br>
                            <label id="A3" for="respA3"> </label> <input name="A" value="C" id="respA3" type="radio"> <br>
                            <label id="A4" for="respA4"> </label> <input name="A" value="D" id="respA4" type="radio"> 
                        </div>
                        
                        <div id="div2" onmouseover="ponerColor(this.id)" onmouseout="quitarColor(this.id)">
                            <p id="preg2" name="preg2"></p>
                            <label id="B1" for="respB1"> </label> <input name="B" value="A" id="respB1" type="radio"> <br>
                            <label id="B2" for="respB2"> </label> <input name="B" value="B" id="respB2" type="radio"> <br>
                            <label id="B3" for="respB3"> </label> <input name="B" value="C" id="respB3" type="radio"> <br>
                            <label id="B4" for="respB4"> </label> <input name="B" value="D" id="respB4" type="radio">
                        </div>

                        <div id="div3" onmouseover="ponerColor(this.id)" onmouseout="quitarColor(this.id)">
                            <p id="preg3" name="preg3"></p> 
                            <label id="C1" for="respC1"> </label> <input name="C" value="A" id="respC1" type="radio"> <br>
                            <label id="C2" for="respC2"> </label> <input name="C" value="B" id="respC2" type="radio"> <br>
                            <label id="C3" for="respC3"> </label> <input name="C" value="C" id="respC3" type="radio"> <br>
                            <label id="C4" for="respC4"> </label> <input name="C" value="D" id="respC4" type="radio">
                        </div>

                        <div id="div4" onmouseover="ponerColor(this.id)" onmouseout="quitarColor(this.id)">
                            <p id="preg4" name="preg4"></p>
                            <label id="D1" for="respD1"> </label> <input name="D" value="A" id="respD1" type="radio"> <br>
                            <label id="D2" for="respD2"> </label> <input name="D" value="B" id="respD2" type="radio"> <br>
                            <label id="D3" for="respD3"> </label> <input name="D" value="C" id="respD3" type="radio"> <br>
                            <label id="D4" for="respD4"> </label> <input name="D" value="D" id="respD4" type="radio">
                        </div>

                        <div id="div5" onmouseover="ponerColor(this.id)" onmouseout="quitarColor(this.id)">
                            <p id="preg5" name="preg5"></p> 
                            <label id="E1" for="respE1"> </label> <input name="E" value="A" id="respE1" type="radio"> <br>
                            <label id="E2" for="respE2"> </label> <input name="E" value="B" id="respE2" type="radio"> <br>
                            <label id="E3" for="respE3"> </label> <input name="E" value="C" id="respE3" type="radio"> <br>
                            <label id="E4" for="respE4"> </label> <input name="E" value="D" id="respE4" type="radio">
                        </div>
                        
                        <div id="div6" onmouseover="ponerColor(this.id)" onmouseout="quitarColorError(this.id)">
                            Responde todas las preguntas.
                        </div>
                    </div>
                </article>
                
                <article id="segunda">
                    <div class="divPri">
                        <div id="divi1" onmouseover="ponerColor(this.id)" onmouseout="quitarColor(this.id)">
                            <p id="preg6" name="preg6"></p>
                            <label id="F1" for="respF1"> </label> <input name="F" value="A" id="respF1" type="radio"> <br>
                            <label id="F2" for="respF2"> </label> <input name="F" value="B" id="respF2" type="radio"> <br>
                            <label id="F3" for="respF3"> </label> <input name="F" value="C" id="respF3" type="radio"> <br>
                            <label id="F4" for="respF4"> </label> <input name="F" value="D" id="respF4" type="radio"> 
                        </div>

                        <div id="divi2" onmouseover="ponerColor(this.id)" onmouseout="quitarColor(this.id)">
                            <p id="preg7" name="preg7"></p>
                            <label id="G1" for="respG1"> </label> <input name="G" value="A" id="respG1" type="radio"> <br>
                            <label id="G2" for="respG2"> </label> <input name="G" value="B" id="respG2" type="radio"> <br>
                            <label id="G3" for="respG3"> </label> <input name="G" value="C" id="respG3" type="radio"> <br>
                            <label id="G4" for="respG4"> </label> <input name="G" value="D" id="respG4" type="radio">
                        </div>

                        <div id="divi3" onmouseover="ponerColor(this.id)" onmouseout="quitarColor(this.id)">
                            <p id="preg8" name="preg8"></p>
                            <label id="H1" for="respH1"> </label> <input name="H" value="A" id="respH1" type="radio"> <br>
                            <label id="H2" for="respH2"> </label> <input name="H" value="B" id="respH2" type="radio"> <br>
                            <label id="H3" for="respH3"> </label> <input name="H" value="C" id="respH3" type="radio"> <br>
                            <label id="H4" for="respH4"> </label> <input name="H" value="D" id="respH4" type="radio">
                            <input type="hidden" value="0" name="epo" id="epo">
                        </div>

                        <div id="divi4" onmouseover="ponerColor(this.id)" onmouseout="quitarColor(this.id)">
                            <p id="preg9" name="preg9"></p>
                            <label id="I1" for="respI1"> </label> <input name="I" value="A" id="respI1" type="radio"> <br>
                            <label id="I2" for="respI2"> </label> <input name="I" value="B" id="respI2" type="radio"> <br>
                            <label id="I3" for="respI3"> </label> <input name="I" value="C" id="respI3" type="radio"> <br>
                            <label id="I4" for="respI4"> </label> <input name="I" value="D" id="respI4" type="radio">
                        </div>

                        <div id="divi5" onmouseover="ponerColor(this.id)" onmouseout="quitarColor(this.id)">
                            <p id="preg10" name="preg10"></p>
                            <label id="J1" for="respJ1"> </label> <input name="J" value="A" id="respJ1" type="radio"> <br>
                            <label id="J2" for="respJ2"> </label> <input name="J" value="B" id="respJ2" type="radio"> <br>
                            <label id="J3" for="respJ3"> </label> <input name="J" value="C" id="respJ3" type="radio"> <br>
                            <label id="J4" for="respJ4"> </label> <input name="J" value="D" id="respJ4" type="radio">
                        </div>
                        
                        <div id="divi6" onmouseover="ponerColor(this.id)" onmouseout="quitarColorError(this.id)">
                            Responde todas las preguntas.
                        </div>
                    </div>
                </article>
            </section>
        </form>
        
        <div id="asdB">    
            <div id="borrar">
                <%
                    request.setCharacterEncoding("UTF-8");
                    cuestionario.cuestionario cuesti = new cuestionario.cuestionario();
                    security.security secu = new security.security();

                    int numPres = 10;

                    String[] pregs = new String[numPres];

                    String epoca = request.getParameter("epo");
                    int epo = 0;
                    if (epoca != null) {
                        epo = Integer.parseInt(epoca);
                        pregs = cuesti.getValorCuesti(numPres, epo);
                        if (epo == 1) {
                            out.println("<script> document.getElementById('titulo').innerHTML+=' Independencia de México';</script>");
                            out.println("<script> document.getElementById('epo').value='1';</script>");
                        } else {
                            if (epo == 2) {
                                out.println("<script> document.getElementById('titulo').innerHTML+=' Guerra de Reforma';</script>");
                                out.println("<script> document.getElementById('epo').value='2';</script>");
                            } else {
                                if (epo == 3) {
                                    out.println("<script> document.getElementById('titulo').innerHTML+=' Revolución';</script>");
                                    out.println("<script> document.getElementById('epo').value='3';</script>");
                                }
                            }
                        }
                    } else {
                        pregs = cuesti.getValorCuesti(numPres, 1);
                        out.println("<script> document.getElementById('titulo').innerHTML+=' Independencia de México';</script>");
                    }

                    String[] textPreg = new String[numPres];
                    String[] textResp = new String[numPres * 4];
                    int[] numPregunta = new int[numPres];

                    textPreg = cuesti.separarPregs(numPres, pregs);

                    numPregunta = cuesti.separarResps(numPres, pregs);

                    textResp = cuesti.getValorResp(numPregunta);
                    int conta = 0, cuatro = 0, contaPre = 1, num = 0;
                    String letras = "ABCDEFGHIJ", coma = "";
                    //out.println("<script> alert('"+pregs.length+"'); </script>");

                    for (int i = 0; i < pregs.length; i++) {
                        //out.println("<script> "+letras.charAt(num) + (cuatro++)+" </script>");
                        cuatro++;
                        textPreg[contaPre - 1] = secu.agregarLine(textPreg[contaPre - 1]);
                        out.println("<script id='Scri" + (i + 1) + "'>"
                                + "document.getElementById('preg" + (contaPre) + "').innerHTML='" + (contaPre) + ") " + textPreg[contaPre - 1] + "';"
                                + "document.getElementById('" + letras.charAt(num) + (cuatro++) + "').innerHTML='" + textResp[(conta++)] + "';"
                                + "document.getElementById('" + letras.charAt(num) + (cuatro++) + "').innerHTML='" + textResp[(conta++)] + "';"
                                + "document.getElementById('" + letras.charAt(num) + (cuatro++) + "').innerHTML='" + textResp[(conta++)] + "';"
                                + "document.getElementById('" + letras.charAt(num) + (cuatro++) + "').innerHTML='" + textResp[(conta++)] + "';");
                        out.println("document.getElementById('pre').value+='" + coma + numPregunta[contaPre - 1] + "'; </script>");

                        num++;
                        cuatro = 0;
                        contaPre++;
                        if (i == 0) {
                            coma = ",";
                        }
                    }
                    out.println("<script id='asdBOR'> document.getElementById('numer').value='" + pregs.length + "' </script>");
                %>
            </div>
        </div>
        <script>
            var mayor= 0, mayorB= 0;
            var numero= "1", numeroB= "1";
            var margenA= 0, margenB= 0;
            var div1, div2, divA, divB;
            
            for(var a= 1; a <= 5; a++){
                div2= document.getElementById("div"+(a)).offsetHeight + 10;
                
                if(div2 > mayor){
                    mayor= div2;
                }else{
                    numero+= a + "";
                }
                
                div2= document.getElementById("divi"+(a)).offsetHeight + 10;
                if(div2 > mayorB){
                    mayorB= div2;
                }else{
                    numeroB+= a + "";
                }
            }
            
            var encontrado= false;
            
            for(var i= 1; i <= 6; i++){
                for(var a= 0; a < numero.length; a++){
                    if(numero.charAt(a) === (i + '')){
                        encontrado= true;
                        divA= document.getElementById("div"+i).offsetHeight;
                        div1= document.getElementById("div"+numero.charAt(a));
                        margenA= (mayor - divA - 10)/2;
                        div1.style.paddingTop= margenA + "px";
                        div1.style.height= (mayor - margenA) + "px";
                        a= numero.length;
                    }
                }
                if(encontrado === false){
                    if(i !== 6){
                        div1= document.getElementById("div"+i);
                        div1.style.height= mayor + "px";
                    }else{
                        div1= document.getElementById("div"+i);
                        div1.style.height= (mayor-50) + "px";
                    }
                }else{
                    encontrado= false;
                }
                //PARA B
                for(var u= 0; u < numeroB.length; u++){
                    if(numeroB.charAt(u) === (i + '')){
                        encontrado= true;
                        divA= document.getElementById("divi"+i).offsetHeight;
                        div2= document.getElementById("divi"+i);
                        margenB= (mayorB - divA - 10)/2;
                        div2.style.paddingTop= margenB + "px";
                        div2.style.height= (mayorB - margenB) + "px";
                        u= numeroB.length;
                    }
                }
                if(encontrado === false){
                    if(i !== 6){
                        div1= document.getElementById("divi"+i);
                        div1.style.height= mayorB + "px";
                    }else{
                        div1= document.getElementById("divi"+i);
                        div1.style.height= (mayorB-50) + "px";
                    }
                }else{
                    encontrado= false;
                }
            }
        </script> 
    </body>
</html>
