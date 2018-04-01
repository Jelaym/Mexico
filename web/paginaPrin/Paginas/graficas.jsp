<%-- 
    Document   : graf
    Created on : 07/11/2017, 02:56:53 PM
    Author     : LearnSoftTech
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="resultado.respuesta, java.sql.ResultSet" %>
<%
    request.setCharacterEncoding("UTF-8");
    /*HttpSession sesion= request.getSession();
    String usuario= (String)sesion.getAttribute("usuario");
    if(usuario != null){
        if(!usuario.equals("admin")){
            out.println("<script> alert('"+usuario+"'); </script>");
            response.sendRedirect("/encuesta2/menu.html");
        }
    }else{
        response.sendRedirect("/encuesta2/menu.html");
    }*/
    
    respuesta resp= new respuesta();
    ResultSet resul= null;
    
    int preguntas= 0, conta= 0;
    
    resul= resp.traerDatos("SELECT COUNT(*) as Total FROM epoca");
    
    while(resul.next()){
        preguntas= Integer.parseInt(resul.getString("Total"));
    }
    resul= resp.traerDatos("SELECT * FROM epoca");
    
    String datos = "", valores= "";
    
    while(resul.next()){
        if(conta < preguntas){
            if((conta+1) == preguntas){
                datos += "'" + resul.getString("idEpoca") + "']";
                valores += resul.getString("Epoca") + "]";
            }else{
                if(conta == 0){
                    datos += "['"+ resul.getString("idEpoca") + "',";
                    valores += "[" + resul.getString("Epoca") + ",";
                }else{
                    datos += "'" + resul.getString("idEpoca") + "',";
                    valores += resul.getString("Epoca") + ",";
                }
            }
            conta++;
        }
    }
%>
<!DOCTYPE html>
<html style="margin: 0px; width: 100%; height: 100%">
    <script>
        var hola = localStorage.getItem("tipo");
        if(hola === 2){
           location.replace('/MexicoInTempore/Error.html');
        }
    </script>
    <head style="margin: 0px; width: 100%; height: 100%">
        <title> Graficas </title>
        <meta charset="UTF-8"/>
        <script src="../libs/Chart.min.js" type="text/javascript"></script>
        <script src="../libs/Chart.js" type="text/javascript"></script>
        
        <link href='https://fonts.googleapis.com/css?family=Galdeano' rel='stylesheet'>
        <link href="../estilos/csGraf.css" rel="stylesheet" type="text/css"/>
    </head>

    <body style="width: 100%; height: 100%; margin: 0px; background-color: white">
        <div class='diviTitulo'>
            <h1> MEXICO IN TEMPORE </h1>
        </div>
        
        <label class="datoX2"> Epoca </label>
        
        <div class="divi2"><canvas id="grafic2" height="250"></canvas></div>
        <input class="botonk" type="button" value="Volver al menu" onclick="location.replace('Seleccion.html')"/>
        <%
            resul= resp.traerDatos("SELECT DISTINCT Num_Boleta, ifnull(Count(*),0) as personas FROM puntaje;");
            String encues= "0";
            while(resul.next()){
                encues= resul.getString("personas");
        %>
                <div class='total'><label> Numero de Personas que han contestado: <%= encues %> </label></div>
        <%   
                if(encues.equals("0")){
                %>
                    <script> alert("No han contestado el cuestionario.\nGraficas no disponibles"); </script>
                <%
                }
            }
        %>
        <%
            resul= resp.traerDatos("SELECT ifnull(COUNT(idEpoca),0) as Total FROM epoca");
            int max= 0;
            while(resul.next()){
                max= Integer.parseInt(resul.getString("Total"));
            }
            
            
            conta= 0;
            datos= "";
            valores= "";
            String valoresB= "";
            boolean cambio= true, completo= true;
            
            if(max > 2){
                resul= resp.traerDatos("SELECT AVG(Correctas) as Correctas, AVG(Erroneas) as Erroneas, epoca.Epoca as Epoca FROM puntaje INNER JOIN epoca ON (epoca.idEpoca = puntaje.idEpoca) GROUP BY puntaje.idEpoca;");
                while(resul.next()){
                    if(conta == 0){
                        datos+= "['" + resul.getString("Epoca") + "'";
                        valores+= "['" + resul.getString("Correctas") + "'";
                        valoresB+= "['" + resul.getString("Erroneas") + "'";
                    }else{
                        if(conta == 1){
                            datos+= ",'" + resul.getString("Epoca") + "'";
                            valores+= ",'" + resul.getString("Correctas") + "'";
                            valoresB+= ",'" + resul.getString("Erroneas") + "'";
                        }else{
                            if(conta == 2){
                                datos+= ",'" + resul.getString("Epoca") + "']";
                                valores+= ",'" + resul.getString("Correctas") + "']";
                                valoresB+= ",'" + resul.getString("Erroneas") + "']";
                            }
                        }
                    }
                    conta++;
                }
                if(conta != 1){
                    datos+= "['Independencia de México','Guerra de Reforma','Revolución Mexicana']";
                    valores+= "['0','0','0']";
                    valoresB+= "['0','0','0']";
                }else{
                    if(conta != 2){
                        datos+= ",'Guerra de Reforma','Revolución Mexicana']";
                        valores+= ",'0','0']";
                        valoresB+= ",'0','0']";
                    }else{
                        if(conta != 3){
                            datos+= ",'Revolución Mexicana']";
                            valores+= ",'0']";
                            valoresB+= ",'0']";
                        }
                    }
                }
            }else{
                resul= resp.traerDatos("SELECT * FROM puntaje WHERE Estatus='Logrado' LIMIT 2");
                
                cambio= completo= false;
                while(resul.next()){
                    String respues= resul.getString("Respuesta");
                    if(respues.equals("6")){
                        valores+= "[" + resul.getString("Contador") + ",";
                        cambio= true;
                    }else{
                        if(respues.equals("7")){
                            valoresB+= "[" + resul.getString("Contador") + ",";
                            completo= true;
                        }
                    }
                }
                if(cambio == true && completo == false){
                    valoresB+= "[0,";
                }else{
                    if(cambio == false && completo == true){
                        valores+= "[0,";
                    }
                }
                    
                for(int a= 8; a < 10; a++){
                    resul= resp.traerDatos("SELECT * FROM puntaje WHERE Estatus='" + a + "' LIMIT 2");

                    cambio= completo= false;
                    while(resul.next()){
                        String respues= resul.getString("Respuesta");
                        if(respues.equals("6")){
                            valores+= resul.getString("Contador") + ",";
                            cambio= true;
                        }else{
                            if(respues.equals("7")){
                                valoresB+= resul.getString("Contador") + ",";
                                completo= true;
                            }
                        }
                    }
                    if(cambio == true && completo == false){
                        valoresB+= "0,";
                    }else{
                        if(cambio == false && completo == true){
                            valores+= "0,";
                        }
                    }
                }
                
                resul= resp.traerDatos("SELECT * FROM puntaje WHERE Estatus='10' LIMIT 2");
                
                cambio= completo= false;
                while(resul.next()){
                    String respues= resul.getString("Respuesta");
                    if(respues.equals("6")){
                        valores+= resul.getString("Contador") + "]";
                        cambio= true;
                    }else{
                        if(respues.equals("7")){
                            valoresB+= resul.getString("Contador") + "]";
                            completo= true;
                        }
                    }
                }
                if(cambio == true && completo == false){
                    valoresB+= "0]";
                }else{
                    if(cambio == false && completo == true){
                        valores+= "0]";
                    }
                }
            }
        %>    
            
        <script>
            var ctx2 = document.getElementById("grafic2").getContext('2d');
            var myChart2 = new Chart(ctx2, {
                type: 'bar',
                data: {
                    labels: <%= datos %>,
                    datasets: [{
                        label: 'Correctas',
                        backgroundColor: "rgba(42, 226, 27, 0.4)",
                        borderColor: "rgba(60, 205, 133, 1)",
                        highlightFill: "#1864f2",
                        highlightStroke: "#ffffff",
                        borderWidth: 1,
                        data: <%= valores %>
                    }, {
                        label: 'Erroneas',
                        backgroundColor: "rgba(242, 55, 29, 0.4)",
                        borderColor: "rgb(247, 233, 30)",
                        highlightFill : "#ee7f49",
                        highlightStroke : "#ffffff",
                        borderWidth: 1,
                        data: <%= valoresB %>
                    }]
                },
                options: {
                    resize: true,
                    barValueSpacing: 20,
                    title: {
                        display: true,
                        text: 'Promedio de Correctas y Erroneas',
                        fontColor: "black",
                        fontSize: 18
                    },
                    scales: {
                        xAxes: [{
                            gridLines:{
                                color:"rgba(75,75,75,0.8)"
                            },
                            ticks:{
                                min: 0,
                                fontColor: "black",
                                fontSize: 12
                            }
                        }],
                        yAxes: [{
                            gridLines:{
                                color:"rgba(75,75,75,0.2)"
                            },
                            ticks:{
                                min: 0,
                                fontColor: "black",
                                fontSize: 13
                            }
                        }]
                    },
                    legend: {
                        labels:{
                            fontColor:"black", 
                            fontSize: 14
                        },
                        position: 'top'
                    }
                }
            });
        </script>
    </body>
</html>