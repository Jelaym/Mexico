<%-- 
    Document   : registraUsser
    Created on : 4/04/2017, 01:02:52 AM
    Author     : Touchier
--%>
<%@page import="java.sql.Connection,java.sql.SQLException, java.sql.Statement" %>
<%
    String registrar= request.getParameter("regi");

    if(registrar != null){
        usuario.cUsuario user= new usuario.cUsuario();

        String rfc= request.getParameter("rfc");
        String nombre = request.getParameter("nombre");
        String contra = request.getParameter("contra");
        String nombreu = request.getParameter("nombreU");
        String apellidop = request.getParameter("apellidoP");
        String apellidom = request.getParameter("apellidoM");
        String semestre= request.getParameter("Semestre");
        String correo = request.getParameter("correo");

        //PRIMERA VALIDACIÓN
        boolean camposValidos= false;
        boolean campoXcampo= false;
        if((rfc != null) && (nombre != null) && (contra != null) && (nombreu != null) && (apellidop != null)
                && (apellidom != null) && (semestre != null) && (correo != null)){
            camposValidos= true;
        }
        if(camposValidos == true){
            camposValidos= false;
            if((!rfc.equals("")) && (!nombre.equals("")) && (!contra.equals("")) && (!nombreu.equals("")) && (!apellidop.equals(""))
                    && (!apellidom.equals("")) && (!semestre.equals("")) && (!correo.equals(""))){
                camposValidos= true;
            }
        }
        //SEGUNDA VALIDACIÓN
        String tipo= "";
        if(user.esNumero(rfc, 10)){
            tipo= "alumno";
            campoXcampo= true;
        }else{
            if(user.verifyRFC(rfc)){
                tipo= "profesor";
                campoXcampo= true;
            }else{
                camposValidos= false;
            }
        }

        if(camposValidos == true){
            camposValidos= false;
            //VALIDANDO CARACTERES
            campoXcampo= (campoXcampo != false) ? (user.esPalabra(nombre)): false;
            campoXcampo= (campoXcampo != false) ? (user.esPalabra(apellidop)): false;
            campoXcampo= (campoXcampo != false) ? (user.esPalabra(apellidom)): false;
            campoXcampo= (campoXcampo != false) ? (user.esPalabra(semestre)): false;
            //VALIDANDO RANGOS
            campoXcampo= (campoXcampo != false) ? (user.esRangoMenor(nombre, 30)): false;
            campoXcampo= (campoXcampo != false) ? (user.esRangoMenor(apellidop, 20)): false;
            campoXcampo= (campoXcampo != false) ? (user.esRangoMenor(apellidom, 20)): false;
            campoXcampo= (campoXcampo != false) ? (user.esRangoMenor(semestre, 20)): false;
            //CAMPOS NO VALIDADOS POR SER MUY DINAMICOS COMO CORREO Y EL NOMBRE DE USUARIO
            campoXcampo= (campoXcampo != false) ? (user.esRangoMenor(correo, 40)): false;
            campoXcampo= (campoXcampo != false) ? (user.esRangoMenor(nombreu, 20)): false;
        }


        if(campoXcampo == true){
            //TERCERDA VALIDACIÓN
            usuario.cExists exists= new usuario.cExists();
            boolean existe= false;
            
            if(exists.declara("existeP", rfc)){
                existe= true;
            }
            if(exists.declara("existeA", rfc)){
                existe= true;
            }
            
            if(existe == true){
                if(tipo == "profesor"){
                    out.println("<script>alert('Este RFC ya ha sido registrado.')</script>");
                }else{
                    if(tipo == "alumno"){
                        out.println("<script>alert('Este Numero de Boleta ya ha sido registrado.')</script>");
                    }
                }
                out.println("<script> history.back(1); </script>");
            }else{
                if(exists.declara("buscarCorreo", correo)){
                    out.println("<script> alert('Este Correo ya ha sido registrado.'); </script>");
                    out.println("<script> history.back(1); </script>");
                }else{
                    if(tipo.equals("profesor")){
                        String numG= request.getParameter("numG");//FALTA
                        int numGroups= Integer.parseInt(numG);
                        String agrupar= "";

                        for(int i=0; i < numGroups; i++){
                            String grupos= request.getParameter("Grupos"+i);

                            if(i == (numGroups-1)){
                                agrupar+= grupos;
                            }else{
                                if(i == numGroups-1){
                                    agrupar+= grupos;
                                }else{
                                    agrupar+= grupos + ",";
                                }
                            }
                        }
                        //VALIDACIÓN DE SUS GRUPOS (NO SE REPITAN NI QUE ABARQUEN MAS DE LO DEBIDO)
                        if(user.verifyGrupo(semestre, agrupar, tipo)){
                            //TRAER CONTRA PARA REGISTRO
                            String pase= request.getParameter("pase");
                            
                            if((pase != null)  && (!pase.equals("")) && (pase.length() <= 10)){
                                if(user.NoEsEspacio(pase)){
                                    security.cSecurityBD regi= new security.cSecurityBD();
                                    if(regi.verifyP("verifyC", pase, rfc, nombre, apellidop, apellidom, nombreu, correo, contra, semestre, agrupar)){
                                        out.println("<script>alert('Registro dado de alta exitosamente!.')</script>");
                                        out.println("<script> location.replace('/MexicoInTempore/paginaPrin/Paginas/Inicio.html'); </script>");
                                    }else{
                                        out.println("<script>alert('El registro fallo. Por favor, Vuelvalo a Intentar.')</script>");
                                        out.println("<script> history.back(1); </script>");
                                    }
                                }
                            }
                        }else{
                            out.println("<script> alert('El registro ha fallado.'); </script>");
                            out.println("<script> history.back(1); </script>");
                        }
                    }else{
                        if(tipo.equals("alumno")){
                            String grupo= request.getParameter("Grupos0");
                            //VERIFICA QUE SOLO TENGA UN GRUPO
                            if(user.verifyGrupo(semestre, grupo, tipo)){
                                security.cSecurityBD regi= new security.cSecurityBD();
                                if(regi.verifyA("verifyA", rfc, nombre, apellidop, apellidom, nombreu, correo, contra, semestre, grupo)){
                                    out.println("<script>alert('Registro dado de alta exitosamente!.')</script>");
                                    out.println("<script> location.replace('/MexicoInTempore/paginaPrin/Paginas/Inicio.html'); </script>");
                                }else{
                                    out.println("<script>alert('El registro fallo. Por favor, Vuelvalo a Intentar.')</script>");
                                    out.println("<script> history.back(1); </script>");
                                }
                            }else{
                                out.println("<script> alert('El registro ha fallado.'); </script>");
                                out.println("<script> history.back(1); </script>");
                            }
                        }
                    }
                }  
            }
        }else{
            out.println("<script> alert('El registro ha fallado, por favor intentelo de nuevo.'); </script>");
            out.println("<script> history.back(1); </script>");
        }
    }else{
        out.println("<script> location.replace('/MexicoInTempore/registro/registro.html'); </script>");
    }
%>