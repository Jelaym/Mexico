<%-- 
    Document   : Biografias
    Created on : 31-mar-2017, 21:46:06
    Author     : David
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html style="height: 100%; width: 100%; margin: 0px">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Biografias</title>
        <link rel="icon" type="image/x-icon" href="icon.ico" />
        <style type="text/css">
            .div1{
                padding-top: 0px;
                padding-left: 0px;
                width: 100%;
                height: 8%;
                background-color: goldenrod;
                float: left;
            }
            .div2{
                padding-top: 0px;
                padding-left: 0px;
                width: 100%;
                height: 80%;
                top: 20%;
                float: left;
                position: absolute;
            }
            .div3{
                padding-top: 0px;
                padding-left: 0px;
                width: 100%;
                height: 11%;

                top: 8%;
                float: left;
                position: absolute;
            }
            .bio{
                top: 20%;
                left: 20%;
                width: 60%;
                height: 60%;
                position: absolute;
                background-color: dodgerblue;
                visibility: hidden;
                text-align: right;
            }
            .cierre{

                width: 30px;
                height: 30px;
                border: none;
                background-color: red;
                outline: none;
            }

            ul{
                background-color: crimson;
                padding-top: 0px;
                padding-left: 0px;
                width: 100%;
                display: inline;
            }
            li{
                float:left;
                background-color: goldenrod;
                width: 33.1%;
                text-align: center;
                color: white;
                display: inline;
                height: 100%;
                border-right: 2px solid #bbb;

            }
            .lia:hover{
                background-color: black;
                color: whitesmoke;
            }
            .spInd{
                float: left;  
                width: 16%; 
                height: 30%; 
                background-color: green; 
                margin-bottom: 3%; 
                margin-left: 3%; 
                margin-top: 2%;
            }
            .spRef{
                float: left;  
                width: 16%; 
                height: 30%; 
                background-color: purple; 
                margin-bottom: 3%; 
                margin-left: 3%; 
                margin-top: 2%;
            }
            .spRev{
                float: left;  
                width: 16%; 
                height: 30%; 
                background-color: orange; 
                margin-bottom: 3%; 
                margin-left: 3%; 
                margin-top: 2%;
            }
            .sp:hover{
                background-color: black;
                color: whitesmoke;
            }
            .spt:hover{
                background-color: dodgerblue;
                color: whitesmoke;
            }
            .boton{
                height: 100%;
                width: 100%;
                background-color: transparent; 
                border: none; 
                outline: none;
                font-size: 20px;
                color: white;
                font-family: century gothic;
            }
            .boton2{
                top: 85%;
                left: 40%;
                height: 5%;
                width: 20%;
                background-color: red; 
                border-radius: 10px 10px 10px 10px; 
                position: absolute;
                font-size: 20px;
                color: white;
                visibility: hidden;
                font-family: century gothic;
            }
            .botonz{
                position: absolute;
                height: 40%;
                width: 12%;
                top: 20%;
                left: 10%;
                background-color: blue; 
                border: none; 
                outline: none;
                font-size: 15px;
                color: white;
                font-family: century gothic;
            }
            .imgBoton{
                position: absolute;

                top: 70%;
                left: 10%;
                border-radius: 10px 10px 10px 10px;
                background-color: red;
                border-color: orangered;
            }
            .botonL{
                font-size: 20px;
                border-radius: 10px;
                background-color: goldenrod;
                color: white;
                top:90%;
                left:80%;
                position: fixed; 
                
            }
        </style>
        <script>
            var n1 = 0;
            var n2 = 0;
            var n3 = 0;
            var nuevas = 0;
            var eliminadas = 0;
            var numeroBB = 0;
            var Acantidad;
            var seccion;
            var path = "";
            var cacelarTipo = 0;
            
            function modificar() {
                if (seccion === 1) {
                    var id = localStorage.getItem("id1" + numeroBB);
                } else {
                    if (seccion === 2) {
                        var id = localStorage.getItem("id2" + numeroBB);
                    } else {
                        if (seccion === 3) {
                            var id = localStorage.getItem("id3" + numeroBB);
                        }
                    }
                }

                document.getElementById("identificador").value = id;
                document.getElementById("seccion").value = seccion;
                document.getElementById("guardar").style.visibility = "visible";
                document.getElementById("bio").removeAttribute("readonly");
                document.getElementById("nombre").removeAttribute("readonly");
                document.getElementById("bio").style.backgroundColor = "white";
                document.getElementById("nombre").style.backgroundColor = "white";
                document.getElementById("bio").style.color = "black";
                document.getElementById("nombre").style.color = "black";
                document.getElementById("cambiarImg").style.visibility = "visible";

            }

            function conserva() {
                document.getElementById("guardar").style.visibility = "hidden";
                document.getElementById("bio").setAttribute("readonly", true);
                document.getElementById("nombre").setAttribute("readonly", true);
                document.getElementById("imx").value = document.getElementById("archivos").files[0].name;

                return true;

            }

            function eliminar() {
                var ide;
                var limite = 0;
                while (isNaN(Acantidad)) {
                    Acantidad = parseInt(prompt('¿Cual es la biografia que quieres eliminar? (El Número)', ''));
                    if (isNaN(Acantidad)) {
                        Acantidad = "";
                        return false;
                    } else {
                        if (seccion === 1) {
                            limite = n1;
                        } else {
                            if (seccion === 2) {
                                limite = n2;
                            } else {
                                if (seccion === 3) {
                                    limite = n3;
                                }
                            }
                        }
                        if ((Acantidad > 0) && (Acantidad <= limite)) {
                            if (seccion === 1) {
                                ide = localStorage.getItem("id1" + (Acantidad - 1));
                            } else {
                                if (seccion === 2) {
                                    ide = localStorage.getItem("id2" + (Acantidad - 1));
                                } else {
                                    if (seccion === 3) {
                                        ide = localStorage.getItem("id3" + (Acantidad - 1));
                                    }
                                }
                            }

                            document.getElementById("identificador").value = ide;

                            return true;
                        } else {
                            if (Acantidad <= 0 || Acantidad > limite) {
                                alert('Eso es un numero fuera del limte');
                                return false;
                            }
                            Acantidad = 'a';
                        }
                    }
                }
                Acantidad = 'a';
                return false;
            }

            function Epoca(e) {
                cierre();
                var tipo = e.name;
                document.getElementById("inicio").style.display = "none";
                document.getElementById("Agregar").style.visibility = "visible";
                document.getElementById("Borrar").style.visibility = "visible";

                if (tipo === "Independencia") {

                    document.getElementById("titulo").innerHTML = "Independencia";
                    seccion = 1;
                    document.getElementById("ind").style.display = "block";
                    document.getElementById("ref").style.display = "none";
                    document.getElementById("rev").style.display = "none";
                    document.getElementById("bios").style.visibility = "hidden";
                    document.getElementById("crear").style.visibility = "hidden";
                    document.getElementById("editar").style.visibility = "hidden";
                    document.getElementById("guardar").style.visibility = "hidden";
                    document.getElementById("titulo").style.color = "green";

                } else {
                    if (tipo === "Guerra") {
                        document.getElementById("titulo").innerHTML = "Guerra de Reforma";
                        seccion = 2;
                        document.getElementById("ref").style.display = "block";
                        document.getElementById("ind").style.display = "none";
                        document.getElementById("rev").style.display = "none";
                        document.getElementById("bios").style.visibility = "hidden";
                        document.getElementById("crear").style.visibility = "hidden";
                        document.getElementById("editar").style.visibility = "hidden";
                        document.getElementById("guardar").style.visibility = "hidden";
                        document.getElementById("titulo").style.color = "purple";
                    } else {
                        if (tipo === "Revolucion") {
                            document.getElementById("titulo").innerHTML = "Revolución";
                            seccion = 3;
                            document.getElementById("rev").style.display = "block";
                            document.getElementById("ind").style.display = "none";
                            document.getElementById("ref").style.display = "none";
                            document.getElementById("bios").style.visibility = "hidden";
                            document.getElementById("crear").style.visibility = "hidden";
                            document.getElementById("editar").style.visibility = "hidden";
                            document.getElementById("guardar").style.visibility = "hidden";
                            document.getElementById("titulo").style.color = "orange";
                        }
                    }
                }
            }
            function cierre() {

                document.getElementById("bios").style.visibility = "hidden";
                document.getElementById("nombre").style.visibility = "hidden";
                document.getElementById("crear").style.visibility = "hidden";
                document.getElementById("editar").style.visibility = "hidden";
                document.getElementById("guardar").style.visibility = "hidden";
                document.getElementById("bio").style.backgroundColor = "transparent";
                document.getElementById("nombre").style.backgroundColor = "transparent";
                document.getElementById("bio").style.color = "white";
                document.getElementById("nombre").style.color = "white";
                document.getElementById("archivos").style.display = "none";
                document.getElementById("imag").src = "";
                document.getElementById("imag").style.visibility = "hidden";
                document.getElementById("imagen").style.display = "none";
                document.getElementById("cancelarImg").style.visibility = "hidden";
                document.getElementById("cambiarImg").style.visibility = "hidden";
            }



            window.onload = function () {
                var apiFile = (window.File && window.FileReader);
                if (apiFile === false)
                {
                    alert("tu navegador no soporta API files de HTML");
                    return;
                }
                document.getElementById("archivos").addEventListener("change", seleccionaarchivo);
            };
            function seleccionaarchivo(e)
            {
                var archivo = e.target.files[0];
                if (archivo.type.match("image.*") === false)
                {
                    var mag = "este archivo no es una imagen";
                    document.getElementById("salida").innerHTML = mag;
                    return;
                }

                var datos = new FileReader();
                datos.readAsDataURL(archivo);
                datos.onload = function (e)
                {
                    var resultado = e.target.result;
                    document.getElementById("imag").src = resultado;
                    document.getElementById("imag").style.visibility = "visible";
                    document.getElementById("imag").style.display = "block";
                    document.getElementById("archivos").style.position = "absolute";
                    document.getElementById("archivos").style.visibility = "hidden";
                    document.getElementById('cancelarImg').style.visibility ='visible';

                };
            }

            function haz(){
                document.getElementById("imx").value = document.getElementById("archivos").files[0].name;
                return true;
            }


            function cambioImg() {
                document.getElementById("imag").src = "";
                document.getElementById("imag").style.visibility = "hidden";
                document.getElementById("archivos").style.display = "block";
                document.getElementById("cancelarImg").style.visibility = "visible";
                document.getElementById("cambiarImg").style.visibility = "hidden";
            }
            function cancelacionImg() {
                document.getElementById("archivos").value = "";
                if(cancelarTipo === 0){
                    document.getElementById("imag").src = "";
                    document.getElementById("imag").style.visibility = "visible";
                    document.getElementById("archivos").style.display = "none";
                    document.getElementById("cancelarImg").style.visibility = "hidden";
                    document.getElementById("cambiarImg").style.visibility = "visible";
                }else{
                    if(cancelarTipo === 1){
                        document.getElementById("imag").src = "";
                        document.getElementById("imag").style.visibility = "hidden";
                        document.getElementById("archivos").style.display = "block";
                        document.getElementById("archivos").style.visibility = "visible";
                        document.getElementById("cancelarImg").style.visibility = "hidden";
                        
                    }
                }    
            }

        </script>

    </head>
    <body style="height: 100%; width: 100%; margin: 0px">
        <div class="div1">
            <ul>
                <li class="lia" ><input type="button" value="Independencia" name="Independencia" id="Independencia"  onclick="Epoca(Independencia)" class="boton"> </li>
                <li class="lia" ><input type="button" value="Guerra de Reforma" name="Guerra" id="Guerra"  onclick="Epoca(Guerra)" class="boton"> </li>
                <li class="lia" ><input type="button" value="Revolución" name="Revolucion" id="Revolucion"  onclick="Epoca(Revolucion)" class="boton"></li>
            </ul>
        </div>
        <div id='inicio' style='top:8%; height: 92%;  ' class='div2'><image style="position: absolute; width: 100%; height: 100%" src="fondd.jpg"></div>
        <div id='ind' class='div2' style='display: none'></div>
        <div id='ref' class='div2' style='display: none'></div>
        <div id='rev' class='div2' style='display: none'></div>
        <%@page import="java.sql.ResultSet,Biografias.cInformacionBases" %>
        <%
            request.setCharacterEncoding("UTF-8");
            int conta = 0;

            ResultSet result = null;
            out.println("<script>var info = [];</script>");
            out.println("<script>var info2 = [];</script>");
            out.println("<script>var info3 = [];</script>");
            out.println("<script>var titulo = [];</script>");
            out.println("<script>var titulo2 = [];</script>");
            out.println("<script>var titulo3 = [];</script>");
            out.println("<script>var imagen = [];</script>");
            out.println("<script>var imagen2 = [];</script>");
            out.println("<script>var imagen3 = [];</script>");
            
            //Declarar, agrega una biografia
            out.println("<script>function declarar(){");
            out.println("document.getElementById('bio').style.backgroundColor = 'white';");
            out.println("document.getElementById('nombre').style.backgroundColor = 'white';");
            out.println("document.getElementById('bio').style.color = 'black';");
            out.println("document.getElementById('nombre').style.color = 'black';");
            out.println("document.getElementById('bios').style.visibility = 'visible';");
            out.println("document.getElementById('crear').style.visibility = 'visible';");
            out.println("document.getElementById('bio').removeAttribute('readonly');");
            out.println("document.getElementById('nombre').removeAttribute('readonly');");
            out.println("document.getElementById('bio').value = ''; ");
            out.println("document.getElementById('identificador').value = 0; ");
            out.println("document.getElementById('nombre').value = '';");
            out.println("document.getElementById('nombre').style.visibility ='visible';");
            out.println("document.getElementById('seccion').value = seccion;");
            out.println("cancelarTipo = 1;");
            out.println("document.getElementById('imagen').style.display = 'block';");
            out.println("document.getElementById('imag').style.visibility = 'hidden';");
            out.println("document.getElementById('archivos').style.display = 'block';");

            out.println("}</script>");

            cInformacionBases sql = new cInformacionBases();
            String haz = "";
            try {
                sql.conectar();
            } catch (Exception ex) {
                haz = ex.getMessage();
            }
            try {
                result = sql.consultar("SELECT * FROM biografia");
                int contai = 0;
                int contaf = 0;
                int contav = 0;
                while (result.next()) {
                    String Titulo = result.getString("titulo");
                    String Informacion = result.getString("informacion");
                    String Imagen = result.getString("imagen");
                    int tipo = result.getInt("idTipo");
                    int id = result.getInt("idBiografia");

                    if (tipo == 1) {
                        out.println("<script>info [n1] = [\"" + sql.informacion(Informacion) + "\"];</script>");
                        out.println("<script>titulo [n1] = [\"" + Titulo + "\"];</script>");
                        out.println("<script>imagen [n1] = [\"" + Imagen + "\"];</script>");
                        out.println("<script> n1++;");
                        out.println("document.getElementById('ind').innerHTML+=\"<span name='" + (contai) + "' id='" + (contai) + "' onclick='bioind(" + (contai) + ")' class='spInd spt' ><img src='" + Imagen + "' alt='?' id='ima" + contai + "' style='width: 100%; height: 70%;'> <br> <p style='color: white; text-align: center;'>" + Titulo + "</p></span>\"");
                        out.println("localStorage.setItem('id1" + contai + "', '" + id + "');</script>");

                        contai++;

                    }
                    if (tipo == 2) {
                        conta = contaf;
                        out.println("<script>info2 [n2] = [\"" + sql.informacion(Informacion) + "\"];</script>");
                        out.println("<script>titulo2 [n2] = [\"" + Titulo + "\"];</script>");
                        out.println("<script>imagen2 [n2] = [\"" + Imagen + "\"];</script>");
                        out.println("<script> n2++;");
                        out.println("document.getElementById('ref').innerHTML+=\"<span name='" + (contaf) + "' id='" + (contaf) + "' onclick='bioref(" + (contaf) + ")' class='spRef spt'><img src='" + Imagen + "' alt='?' id='ima" + contaf + "' style='width: 100%; height: 70%;'> <br> <p style='color: white; text-align: center;'>" + Titulo + "</p></span>\"");

                        out.println("localStorage.setItem('id2" + contaf + "', '" + id + "');</script>");
                        contaf++;

                    }
                    if (tipo == 3) {
                        out.println("<script>info3 [n3] = [\"" + sql.informacion(Informacion) + "\"];</script>");
                        out.println("<script>titulo3 [n3] = [\"" + Titulo + "\"];</script>");
                        out.println("<script>imagen3 [n3] = [\"" + Imagen + "\"];</script>");
                        out.println("<script> n3++;");
                        out.println("document.getElementById('rev').innerHTML+=\"<span name='" + (contav) + "' id='" + (contav) + "' onclick='biorev(" + (contav) + ")' class='spRev spt'><img src='" + Imagen + "' alt='?' id='ima" + contav + "' style='width: 100%; height: 70%;'> <br> <p style='color: white; text-align: center;'>" + Titulo + "</p></span>\"");
                        out.println("localStorage.setItem('id3" + contav + "', '" + id + "');</script>");
                        contav++;
                    }

                }

            } catch (Exception ex) {
                haz = ex.getMessage();
            }

            out.println("<script>function bioind(e){");
            out.println("document.getElementById('bios').style.top = '20%';");

            out.println("numeroBB  = e;");
            out.println("document.getElementById('crear').style.visibility = 'hidden';");
            out.println("document.getElementById('nombre').style.visibility ='visible';");
            out.println("document.getElementById('bio').setAttribute('readonly', true);");
            out.println("document.getElementById('nombre').setAttribute('readonly', true);");
            out.println("document.getElementById('ima'+e).style.visibility = 'visible';");
            out.println("var im = imagen [e];");
            out.println("document.getElementById('imag').src = im");
            out.println("var id = localStorage.getItem('id1'+e.toString());");
            out.println("document.getElementById('identificador').value = id;");
            out.println("var nombre = titulo [e];");
            out.println("document.getElementById('bios').style.visibility = 'visible';");
            out.println("document.getElementById('nombre').style.visibility = 'visible';");
            out.println("document.getElementById('editar').style.visibility = 'visible';");
            out.println("document.getElementById('bio').innerHTML = info[e];");
            out.println("document.getElementById('nombre').value = nombre;");
            out.println("document.getElementById('imag').style.visibility = 'visible';");
            out.println("document.getElementById('imagen').style.display = 'block';");
            out.println("cancelarTipo = 0;");
            out.println("}");

            out.println("function bioref(e){");
            out.println("numeroBB  = e;");
            out.println("document.getElementById('crear').style.visibility = 'hidden';");
            out.println("document.getElementById('nombre').style.visibility ='visible';");
            out.println("document.getElementById('bio').setAttribute('readonly', true);");
            out.println("document.getElementById('nombre').setAttribute('readonly', true);");
            out.println("document.getElementById('ima'+e).style.visibility = 'visible';");
            out.println("var im = imagen2 [e];");
            out.println("document.getElementById('imag').src = im");
            out.println("var id = localStorage.getItem('id2'+e.toString());");
            out.println("document.getElementById('identificador').value = id;");
            out.println("var nombre = titulo2 [e];");
            out.println("document.getElementById('nombre').value = nombre;");
                out.println("cancelarTipo = 0;");
            out.println("document.getElementById('bios').style.visibility = 'visible';");
            out.println("document.getElementById('nombre').style.visibility = 'visible';");
            out.println("document.getElementById('editar').style.visibility = 'visible';");
            out.println("document.getElementById('bio').value = info2[e];");
            out.println("document.getElementById('imag').style.visibility = 'visible';");
            out.println("document.getElementById('imagen').style.display = 'block';");

            out.println("}");

            out.println("function biorev(e){");
            out.println("numeroBB  = e;");
            out.println("document.getElementById('crear').style.visibility = 'hidden';");
            out.println("document.getElementById('nombre').style.visibility ='visible';");
            out.println("document.getElementById('bio').setAttribute('readonly', true);");
            out.println("document.getElementById('nombre').setAttribute('readonly', true);");
            out.println("document.getElementById('ima'+e).style.visibility = 'visible';");
            out.println("var im = imagen3 [e];");
            out.println("document.getElementById('imag').src = im");
            out.println("var id = localStorage.getItem('id3'+e.toString());");
            out.println("document.getElementById('identificador').value = id;");
            out.println("var nombre = titulo3 [e];");
            out.println("document.getElementById('nombre').value = nombre;");
            out.println("document.getElementById('bios').style.visibility = 'visible';");
            out.println("document.getElementById('nombre').style.visibility = 'visible';");
            out.println("document.getElementById('editar').style.visibility = 'visible';");
            out.println("document.getElementById('bio').value = info3[e];");
            out.println("document.getElementById('imag').style.visibility = 'visible';");
            out.println("document.getElementById('imagen').style.display = 'block';");
            out.println("cancelarTipo = 0;");
            out.println("}</script>");


        %>


        <form name="guardarBio" id="guardarBio" method="post" action="guardarBiografia.jsp">
            <div style="position: absolute; top: 8%; left:40%">
                <p  id="titulo" style="text-align: center; margin-top: 0; color: green; font-size: 40px; margin-bottom: 5px;"></p>
            </div>
            <div class="div3">
                <input type="button" value="Agregar  biografías" name="Agregar" id="Agregar"  onclick="declarar()"  class='sp botonz' style=" visibility: hidden"> &nbsp;&nbsp;
                <input type="submit" value="Eliminar  biografías" name="Borrar" id="Borrar"  onclick="return eliminar()" class="sp botonz" style=" visibility: hidden; left: 75%">
            </div>

            <div id="bios" class="bio" style="position: fixed;">

                <input type="button" value="x" id="cerrar" onclick="cierre()" class="cierre" style="color: white" name="cerrar">
                <input type="text"  id="nombre" name="nombre"  style="height: 5%; width: 25%;font-size: 15px; left: 60%; top: 10%; position: absolute; background-color: transparent; color: white; border: none; resize: none" readonly >

                <input type="button" value="Cambiar Imagen" id="cambiarImg" onclick="cambioImg()" class="imgBoton" name="cambiarImg" style="visibility: hidden">
                <input type="button" value="Cancelar" id="cancelarImg" onclick="cancelacionImg()" class="imgBoton" style="left: 24%; visibility: hidden" name="cancelarImg">

                <textarea id="bio"  name="bio" rows="15" cols="50" style="left: 50%; font-size: 15px; top: 20%; position: absolute; background-color: transparent; color: white; border: none; resize: none" readonly ></textarea>
            </div>
            <div>
                <input type="hidden" name="seccion" id="seccion">
                <input type="hidden" name="identificador" id="identificador">
                <input type="hidden" name="imx" id="imx">
                <input type="button" value="Editar" id="editar" onclick="modificar()" style="position: fixed;" class="boton2" name="editar">
                <input type="submit" value="Crear" id="crear" class="boton2" onclick="return haz()" name="crear" style="visibility: hidden; position: fixed;">
                <input type="submit" value="Guardar" id="guardar" onclick="return conserva()" class="boton2" style="top: 91%; position: fixed;" name="guardar">
                
                    <script>
                        var hola = localStorage.getItem("tipo");
   
                        if(hola === "1"){
               
                            document.getElementById('Agregar').style.display = "none";
                            document.getElementById('Borrar').style.display = "none";
                            document.getElementById('editar').style.display = "none";
                        }
                    </script>
               
                    <input type="button" value="Volver al Menú" id="Seleccion" onclick="location.href = 'Seleccion.html' "  class="botonL" name="seleccion">
            </div>
        </form>
         
        <form>
            <div id="imagen" style="display: none; background-color: white; position: fixed; left: 23%; top: 30%; height:25%; width: 22%;">
                <input type="file" name="ar" id="archivos" style="display: none;  position: absolute;" >
                <img src="" alt="imagen" id="imag" style="width: 100%; height: 100%; ">  
            </div>
        </form>
    </body>
</html>
