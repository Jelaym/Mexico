<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="width: 100%; height: 100%; margin: 0px;">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" type="image/x-icon" href="/MexicoInTempore/icon.ico" />
        <title>Cuenta</title>
        <style type="text/css">
            .pn{
                font-size: 40px;
                color: gold;
                text-align: center;
            }
            .dat{
                text-align: center;
                color: gold;
            }
            .pt{
                font-size: 20px;
                text-align: center;
            }
            .conf{
                color: white;
                text-align: center;
                position: absolute;
                background-color: silver;
                left: 40%;
                top: 30%;
                height: 25%;
                width: 25%;
                display: none;
            }
            .cierre{

                width: 5%;
                height: 10%;
                border: none;
                background-color: red;
                outline: none;
            }
            .opci{
                color: white;
                background-color: goldenrod;
                border-radius: 10px;
                border-color: transparent;
                font-size: 30px;
            }
        </style>

        <script>
            var numGrupos;
            function opcis()
            {
                usuario = localStorage.getItem("tipo");

                if (usuario == 2) {
                    var num = document.getElementById('numG').value;

                    numGrupos = document.getElementById("numG").value;
                    var datoID = document.getElementById("semestre");
                    var dato = datoID.options[datoID.selectedIndex].value;
                    if (dato === "Primer Semestre")
                    {
                        comboM = ["1IM1", "1IM2", "1IM3", "1IM4", "1IM5", "1IM6", "1IM7", "1IM8", "1IM9"];
                        for (var i = 0; i < numGrupos; i++)
                        {
                            for (var o = 0; o < comboM.length; o++) {
                                document.getElementById("grupos" + i).options[o + 1] = new Option(comboM[o]);
                            }
                        }
                    } else
                    {
                        if (dato === "Segundo Semestre")
                        {
                            comboH = ["2IM1", "2IM2", "2IM3", "2IM4", "2IM5", "2IM6", "2IM7", "2IM8", "2IM9"];
                            for (i = 0; i < numGrupos; i++)
                            {
                                for (o = 0; o < comboH.length; o++) {
                                    document.getElementById("grupos" + i).options[o + 1] = new Option(comboH[o]);
                                }
                            }
                        }
                    }
                } else {
                    numGrupos = 1;
                    var datoID = document.getElementById("semestre");
                    var dato = datoID.options[datoID.selectedIndex].value;
                    if (dato === "Primer Semestre")
                    {
                        comboM = ["1IM1", "1IM2", "1IM3", "1IM4", "1IM5", "1IM6", "1IM7", "1IM8", "1IM9"];
                        for (var i = 0; i < numGrupos; i++)
                        {
                            for (var o = 0; o < comboM.length; o++) {
                                document.getElementById("grupos").options[o] = new Option(comboM[o]);
                            }
                        }
                    } else
                    {
                        if (dato === "Segundo Semestre")
                        {
                            comboH = ["2IM1", "2IM2", "2IM3", "2IM4", "2IM5", "2IM6", "2IM7", "2IM8", "2IM9"];
                            for (i = 0; i < numGrupos; i++)
                            {
                                for (o = 0; o < comboH.length; o++) {
                                    document.getElementById("grupos").options[o] = new Option(comboH[o]);
                                }
                            }
                        }
                    }
                }

            }
            function actualizar() {
                
                var dato = document.getElementById("semestre");

                if (dato.selectedIndex === 0) {
                    combo = "1IM1,1IM2,1IM3,1IM4,1IM5,1IM6,1IM7,1IM8,1IM9,";
                } else {
                    if (dato.selectedIndex === 1) {
                        combo = "2IM1,2IM2,2IM3,2IM4,2IM5,2IM6,2IM7,2IM8,2IM9,";
                    }
                }
                var temporal = "";
                var valor = [];
                numGrupos = document.getElementById('numG').value;
                for (var i = 0; i < numGrupos; i++) {
                    temporal = document.getElementById("grupos" + i);
                    if (temporal.selectedIndex !== -1) {
                        valor[i] = temporal.options[temporal.selectedIndex].value + ",";
                    } else {
                        valor[i] = "";
                    }
                }

                for (var i = 0; i < valor.length; i++) {
                    if (valor[i] !== "") {
                        combo = combo.replace(valor[i], "");
                    }
                }
                var comboBox = combo.split(",");
                var grupo = "", num = "";
                var cambio = false;
                var aumenta = 1;

                for (var a = 0; a < numGrupos; a++) {
                    temporal = document.getElementById("grupos" + a);

                    if (temporal.selectedIndex !== 0) {
                        grupo = temporal.options[temporal.selectedIndex].value;

                        for (var i = 0; i < temporal.options.length; i++) {
                            temporal.options[i + 1] = null;
                        }

                        if (grupo.length === 4) {
                            num = parseInt(grupo.charAt(3));
                        }
                        cambio = false;
                        aumenta = 1;
                        var numero = 0;

                        for (var i = 0; i < comboBox.length; i++) {
                            if (cambio === false) {
                                numero = parseInt(comboBox[i].charAt(3));
                            }

                            if ((numero > num) && (cambio === false)) {
                                cambio = true;
                                temporal.options[aumenta] = new Option(grupo);
                                temporal.options.selectedIndex = aumenta;
                            } else {
                                if ((cambio === false) && (i < (comboBox.length - 1))) {
                                    temporal.options[aumenta] = new Option(comboBox[i]);
                                } else {
                                    if (cambio === true) {
                                        temporal.options[aumenta] = new Option(comboBox[i - 1]);
                                    } else {
                                        temporal.options[aumenta] = new Option(grupo);
                                        temporal.options.selectedIndex = aumenta;
                                    }
                                }
                            }
                            aumenta++;

                        }
                    } else {
                        for (var i = 0; i < temporal.options.length; i++) {
                            temporal.options[i + 1] = null;
                        }
                        aumenta = 1;
                        for (var i = 0; i < comboBox.length - 1; i++) {
                            temporal.options[aumenta] = new Option(comboBox[i]);
                            aumenta++;
                        }
                    }
                }
            }
            function caracteresEspacio(e)
            {
                var keychar = e.keyCode || e.which;

                if ((keychar >= 65 && keychar <= 90) || (keychar >= 97 && keychar <= 122) || (keychar === 8) || (keychar === 32))
                {
                    return true;
                } else
                {
                    return false;
                }
            }
        </script>

        <script>
            var contra;
            function cierre() {
                document.getElementById("confirmar").style.display = "none";
            }
            function canr() {
                document.getElementById('apellidoP').setAttribute("readonly", true);
                document.getElementById('apellidoM').setAttribute("readonly", true);
                document.getElementById('nombre').setAttribute("readonly", true);
                document.getElementById('email').setAttribute("readonly", true);
                document.getElementById('contra').setAttribute("readonly", true);
                document.getElementById('apellidoP').style.border = "none";
                document.getElementById('apellidoM').style.border = "none";
                document.getElementById('nombre').style.border = "none";
                document.getElementById('usern').style.border = "none";
                document.getElementById('email').style.border = "none";
                document.getElementById('contra').style.border = "none";
                document.getElementById('cancelar').style.visibility = "hidden";
                document.getElementById('guardar').style.visibility = "hidden";
                document.getElementById('semestre').setAttribute("disabled", true);
                document.getElementById('grupos').setAttribute("disabled", true);

                var usuario = localStorage.getItem("tipo");

                if (usuario == "2") {
                    var num = document.getElementById('numG').value;
                    document.getElementById('numG').setAttribute("readonly", true);
                    for (var u = 0; u < num; u++) {
                        document.getElementById('grupos' + u).setAttribute("disabled", true);
                    }
                }
            }
            function cambio() {
                document.getElementById('apellidoP').removeAttribute("readonly");
                document.getElementById('apellidoM').removeAttribute("readonly");
                document.getElementById('nombre').removeAttribute("readonly");
                document.getElementById('email').removeAttribute("readonly");
                document.getElementById('contra').removeAttribute("readonly");
                document.getElementById('apellidoP').style.border = "thin solid black";
                document.getElementById('apellidoM').style.border = "thin solid black";
                document.getElementById('nombre').style.border = "thin solid black";
                document.getElementById('email').style.border = "thin solid white";
                document.getElementById('contra').style.border = "thin solid white";
                document.getElementById('cancelar').style.visibility = "visible";
                document.getElementById('guardar').style.visibility = "visible";
                document.getElementById('semestre').removeAttribute("disabled");
                document.getElementById('grupos').removeAttribute("disabled");

                var usuario = localStorage.getItem("tipo");

                if (usuario == "2") {
                    var num = document.getElementById('numG').value;

                    document.getElementById("numG").removeAttribute("readonly");
                    document.getElementById('numG').style.border = "thin solid black";
                    for (var u = 0; u < num; u++) {
                        document.getElementById('grupos' + u).removeAttribute("disabled");
                    }
                }
            }
            function desplegado(e) {
                if (e.name === "eliminar") {
                    document.getElementById("opc").value = "eliminar";
                } else {
                    if (e.name === "guardar") {
                        document.getElementById("opc").value = "guardar";
                    }
                }
                document.getElementById("confirmar").style.display = "block";
            }
            function fondo(){
                var Colores = ["#EC7063","#5DADE2","#45B39D","#E59866","#45B39D","#F5B7B1","#85C1E9","#FCF3CF","#85929E","#AF7AC5"];
                var Col = Math.floor(Math.random() * 8);
                document.body.style.backgroundColor = Colores[Col];
            }
        </script>    
    </head>
    <body style="width: 100%; height: 90%; margin: 0px; background-image:  url('../imagenes/fondow.jpg');" onload="actualizar()">
        
        <form method="post" action="GuardarCambios.jsp" style="width: 100%; height: 100%;">
            <p id="persona" class="pn"></p>
            <div id="datos" class="dat"> 
                <p id="tipo"></p>
                <input type="text" id="bolRF" name="bolRF" style="text-align: center; border: none; background-color: transparent; color: white; visibility: hidden;" ><br><br><br>
                Nombre:
                <input type="text" id="apellidoP" name="apellidoP" required onkeypress="return caracteresEspacio(event)"  style="text-align: center; border: none; background-color: transparent; color: white;" readonly>
                <input type="text" id="apellidoM" name="apellidoM" required onkeypress="return caracteresEspacio(event)" style="text-align: center; border: none; background-color: transparent; color: white;" readonly>
                <input type="text" id="nombre" name="nombre" required onkeypress="return caracteresEspacio(event)" style="text-align: center; border: none; background-color: transparent; color: white;" readonly><br><br><br><br>
                UserName: <input type="text" id="usern" name="usern" required onkeypress="return caracteresEspacio(event)"  style="text-align: center; border: none; background-color: transparent; color: white;" readonly><br><br><br>
                E-mail: <input type="text" id="email" name="email" required onkeypress="return caracteresEspacio(event)"  style="text-align: center; border: none; background-color: transparent; color: white;" readonly><br><br><br>
                Contraseña: <input type="password" id="contra" name="contra" required onkeypress="return caracteresEspacio(event)"  style="text-align: center; border: none; background-color: transparent; color: white;" readonly><br><br><br>
                Semestre:
                <select id="semestre" name="semestre" onchange="opcis()" disabled>
                    <option value="Primer Semestre">Primer Semestre</option>
                    <option value="Segundo Semestre">Segundo Semestre</option>
                </select>
                <br/><br/>
                Numero de Grupos: <input readonly type="text" onkeyup="opcis()" value="1" style="text-align: center; border: none; background-color: transparent; color: white;" id="numG" name="numG" placeholder="Numero de Grupos" onkeypress="return numeros(event)"><br/>

                Grupo:
                <div id="agregaGrupo">
                    <select id="grupos" name="grupos" disabled>
                    </select>
                </div>

                <br><br><br>
                <input type="hidden" name="opc" id="opc">
                <input type="button" value="Guardar Cambios" name="guardar" id="guardar" onclick="desplegado(guardar)" class="opci" style="visibility: hidden">
                <input type="button" value="Editar" name="cambiar" id="cambiar" class="opci" onclick="cambio()">
                <input type="button" value="Eliminar Cuenta" name="eliminar" id="eliminar" class="opci" onclick="desplegado(eliminar)">
                <input type="button" value="Cancelar" name="cancelar" id="cancelar" onclick="canr()" class="opci" style="visibility: hidden"/><br/><br/>
                <input type="button" value="Volver al Menú" name="menu" id="menu" class="opci" onclick="location.href= 'Seleccion.html'"/>
            </div>
            <div id="confirmar" class="conf">
                <input type="button" value="x" id="cerrar" onclick="cierre()" class="cierre" style="position: absolute; right: 0%; color: white" name="cerrar">
                <br>
                Introduzca su contraseña para confirmar:<br><br><br>
                <input type="password" id="contraCon" placeholder="contraseña" name="contraCon" style="text-align: center; border: none;"><br><br><br><br>
                <input type="submit" value="Aceptar" name="aceptar" id="aceptar" onclick="return aceptar()">
            </div>
        </form>
        <%@page import="java.sql.ResultSet,Biografias.cInformacionBases" %>
        <%
            HttpSession sesion = request.getSession();
            String ses = (String) sesion.getAttribute("usuario");

            if (ses != null) {
                ResultSet result = null;
                cInformacionBases sql = new cInformacionBases();
                String haz = "";
                try {
                    sql.conectar();
                } catch (Exception ex) {
                    haz = ex.getMessage();
                }
                try {

                    String tipo = "";
                    String iden = "", Nombre = "", AP = "", AM = "", user = "", email = "", contra = "", grupo = "", semestre = "";

                    usuario.cUsuario usuario = new usuario.cUsuario();
                    if (usuario.verifyRFC(ses)) {
                        tipo = "profesor";
                    } else if (usuario.esNumero(ses, 10)) {
                        tipo = "alumno";
                    }

                    if (tipo.equals("profesor")) {
                        result = sql.consultar("SELECT * FROM profesor where RFC='" + ses + "';");
                        while (result.next()) {
                            iden = result.getString("RFC");
                            Nombre = result.getString("Nombre");
                            AP = result.getString("A_Paterno");
                            AM = result.getString("A_Materno");
                            user = result.getString("username");
                            email = result.getString("email");
                            contra = result.getString("contra");
                            grupo = result.getString("grupos");
                            semestre = result.getString("semestre");
                        }
                        out.println("<script>document.getElementById('tipo').innerHTML='RFC: " + iden + "'; </script>");

                    } else if (tipo.equals("alumno")) {
                        result = sql.consultar("SELECT * FROM alumno where Num_Boleta='" + ses + "';");
                        while (result.next()) {
                            iden = result.getString("Num_Boleta");
                            Nombre = result.getString("Nombre");
                            AP = result.getString("A_Paterno");
                            AM = result.getString("A_Materno");
                            user = result.getString("username");
                            email = result.getString("email");
                            contra = result.getString("contra");
                            grupo = result.getString("grupos");
                            semestre = result.getString("semestre");
                        }

                        out.println("<script>document.getElementById('tipo').innerHTML='Boleta: " + iden + "';</script>");
                    }

                    out.println("<script> document.getElementById('persona').innerHTML='Bienvenido " + Nombre + " " + AP + " " + AM + " ';");
                    out.println("document.getElementById('bolRF').value = '" + iden + "';");
                    out.println("document.getElementById('apellidoP').value = '" + AP + "';");
                    out.println("document.getElementById('apellidoM').value = '" + AM + "';");
                    out.println("document.getElementById('nombre').value = '" + Nombre + "';");
                    out.println("document.getElementById('usern').value = '" + user + "';");
                    out.println("document.getElementById('email').value = '" + email + "';");
                    out.println("document.getElementById('contra').value = '" + contra + "';");
                    out.println("contra = '" + contra + "';");

                    if (semestre.equals("Primer Semestre")) {
                        out.println("document.getElementById('semestre').options[0].selected = 'selected'");
                    } else if (semestre.equals("Segundo Semestre")) {

                        out.println("document.getElementById('semestre').options[1].selected = 'selected'");
                    }

                    if (tipo.equals("alumno")) {
                        out.println("var grupo = '" + grupo + "';");
                        out.println("var semestre = '" + semestre + "';");
                        out.println("if (semestre === 'Primer Semestre')");
                        out.println("{");
                        out.println("comboM = ['1IM1','1IM2','1IM3','1IM4','1IM5','1IM6','1IM7','1IM8','1IM9'];");

                        out.println("for(var o= 0; o < comboM.length; o++){");
                        out.println("document.getElementById('grupos').options[o] = new Option(comboM[o]);");
                        out.println("if(grupo == comboM[o]){");
                        out.println("document.getElementById('grupos').options[o].selected= 'selected';");
                        out.println("}");
                        out.println("}");

                        out.println("} else{");
                        out.println("if (semestre === 'Segundo Semestre')");
                        out.println("{");
                        out.println("comboH = ['2IM1','2IM2','2IM3','2IM4','2IM5','2IM6','2IM7','2IM8','2IM9'];");

                        out.println("for(o= 0; o < comboH.length; o++){");
                        out.println("document.getElementById('grupos').options[o] = new Option(comboH[o]);");
                        out.println("if(grupo == comboH[o]){");
                        out.println("document.getElementById('grupos').options[o].selected= 'selected';");
                        out.println("}");
                        out.println("}");

                        out.println("}");
                        out.println("}");

                        out.println("for(var o= 0; o < document.getElementById('grupos').options; o++){");
                        out.println("if(document.getElementById('grupos').options[o].text === '" + grupo + "'){");
                        out.println("document.getElementById('grupos').options[o].selected;");
                        out.println("}");
                        out.println("}");
                        out.println("function aceptar(){");
                        out.println("if(document.getElementById('contraCon').value === contra){");
                        out.println("return true;");
                        out.println("}");
                        out.println("}");
                        out.println("</script>");
                    } else //PROFESOR
                    if (tipo.equals("profesor")) {
                        out.println("document.getElementById('grupos').style.display= 'none';");
                        out.println("document.getElementById('grupos').style.visibility= 'hidden';");
                        cuestionario.splits spli = new cuestionario.splits();
                        String[] grupoAgru = spli.miSplit(grupo, ',');
                        out.println("document.getElementById('numG').value = '" + grupoAgru.length + "';</script>");

                        for (int u = 0; u < grupoAgru.length; u++) {
                            out.println("<script>document.getElementById('agregaGrupo').innerHTML+= '<select id=\"grupos" + u + "\" name=\"grupos" + u + "\" onchange=\"actualizar()\" disabled><option value=\"y\">Elije tu grupo</option></select>';</script>");
                        }

                        out.println("<script>");
                        out.println("function numeros(e){");
                        out.println("var keychar= e.keyCode || e.which;");
                        out.println("var campo= document.getElementById('numG').value;");
                        out.println("if(campo.length === 0){");
                        out.println("if((keychar >= 49 && keychar <= 57) || (keychar === 8)){");
                        out.println("campo= String.fromCharCode(keychar); "
                                + "document.getElementById('agregaGrupo').innerHTML= ''; "
                                + "for(var u= 0; u < parseInt(campo); u++){"
                                + "document.getElementById('agregaGrupo').innerHTML+= '<select id=\"grupos\'+u+\'\" name=\"grupos\'+u+\'\" onchange=\"actualizar()\">"
                                + "<option value=\"y\">Elije tu grupo</option>"
                                + "</select>';"
                                + "}"
                                + "return true;");
                        out.println("} "
                                + "} "
                                + "return false"
                                + "}");
                        out.println("</script>");

                        for (int u = 0; u < grupoAgru.length; u++) {

                            out.println("<script> grupo = '" + grupoAgru[u] + "';");
                            out.println("var semestre = '" + semestre + "';");
                            if (semestre.equals("Primer Semestre")) {
                                out.println("if (semestre === 'Primer Semestre')");
                                out.println("{");
                                out.println("comboM = ['1IM1','1IM2','1IM3','1IM4','1IM5','1IM6','1IM7','1IM8','1IM9'];");
                                out.println("for(var o= 0; o < comboM.length; o++){");
                                out.println("document.getElementById('grupos" + u + "').options[o+1] = new Option(comboM[o]);");
                                out.println("if(grupo == comboM[o]){");
                                out.println("document.getElementById('grupos" + u + "').options[o+1].selected= 'selected';");;
                                out.println("}");
                                out.println("}");
                                out.println("}</script>");
                            } else if (semestre.equals("Segundo Semestre")) {
                                out.println("if(semestre === 'Segundo Semestre')");
                                out.println("{");
                                out.println("comboH = ['2IM1','2IM2','2IM3','2IM4','2IM5','2IM6','2IM7','2IM8','2IM9'];");
                                out.println("for(o= 0; o < comboH.length; o++){");
                                out.println("document.getElementById('grupos" + u + "').options[o+1] = new Option(comboH[o]);");
                                out.println("if(grupo == comboH[o]){");
                                out.println("document.getElementById('grupos" + u + "').options.selectedIndex= o;");
                                out.println("}");
                                out.println("}");
                                out.println("}</script>");
                            }
                        }
                        out.println("<script>");
                        out.println("function aceptar(){");
                        out.println("if(document.getElementById('contraCon').value === contra){");
                        out.println("return true;");
                        out.println("}");
                        out.println("}");
                        out.println("</script>");
                    }
                } catch (Exception ex) {
                    haz = ex.getMessage();
                }
            } else {
                response.sendRedirect("Inicio.html");
            }
        %>
    </body>
</html>