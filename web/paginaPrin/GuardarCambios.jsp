<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet,Biografias.cInformacionBases, java.sql.SQLException" %>
<%
    HttpSession sesion = request.getSession();
    String usuario= (String) sesion.getAttribute("usuario");

    String opc = request.getParameter("opc");
    String boleta = request.getParameter("bolRF");
    String apellidoP = request.getParameter("apellidoP");
    String apellidoM = request.getParameter("apellidoM");
    String nombre = request.getParameter("nombre");
    String email = request.getParameter("email");
    String contra = request.getParameter("contra");
    String semestre = request.getParameter("semestre");
    String grupos = request.getParameter("grupos");
    
    usuario.cUsuario user= new usuario.cUsuario();
    //VALIDAR QUE NO SEA NULL
    boolean campoXcampo= false;
    boolean camposValidos= false;
    if((boleta != null) && (nombre != null) && (contra != null) && (apellidoP != null)
            && (apellidoM != null) && (semestre != null) && (email != null)){
        camposValidos= true;
    }
    if(camposValidos == true){
        camposValidos= false;
        if((!boleta.equals("")) && (!nombre.equals("")) && (!contra.equals("")) && (!nombre.equals("")) && (!apellidoP.equals(""))
                && (!apellidoM.equals("")) && (!semestre.equals("")) && (!email.equals(""))){
            camposValidos= true;
        }
    }

    if(camposValidos == true){
        camposValidos= false;
        campoXcampo= true;
        //VALIDANDO CARACTERES
        campoXcampo= (campoXcampo != false) ? (user.esPalabra(nombre)): false;
        campoXcampo= (campoXcampo != false) ? (user.esPalabra(apellidoP)): false;
        campoXcampo= (campoXcampo != false) ? (user.esPalabra(apellidoM)): false;
        campoXcampo= (campoXcampo != false) ? (user.esPalabra(semestre)): false;
        //VALIDANDO RANGOS
        campoXcampo= (campoXcampo != false) ? (user.esRangoMenor(nombre, 30)): false;
        campoXcampo= (campoXcampo != false) ? (user.esRangoMenor(apellidoP, 20)): false;
        campoXcampo= (campoXcampo != false) ? (user.esRangoMenor(apellidoM, 20)): false;
        campoXcampo= (campoXcampo != false) ? (user.esRangoMenor(semestre, 20)): false;
        //CAMPOS NO VALIDADOS POR SER MUY DINAMICOS COMO CORREO Y EL NOMBRE DE USUARIO
        campoXcampo= (campoXcampo != false) ? (user.esRangoMenor(email, 40)): false;
    }
    
    if(campoXcampo == true){
        String haz = "";
        cInformacionBases sql = new cInformacionBases();
        try{
            sql.conectar();                
        }catch(Exception ex){
            haz = ex.getMessage();
        }

        String tipo= "";

        if(user.verifyRFC(usuario)){
            tipo= "profesor";
        }else{
            if(user.esNumero(usuario, 10)){
                tipo= "alumno";
            }else{
                tipo= "desconocido";
            }
        }

        try{
            ResultSet resul= null;
            String resultado= "";
            usuario.cExists prod= new usuario.cExists();

            if(opc.equals("guardar")){
                if(tipo.equals("alumno")){
                    try{
                        if(user.verifyGrupo(semestre, grupos, tipo)){
                            prod.accionProcedure("accionAlum",9);
                            prod.agregarParameter(1, boleta);
                            prod.agregarParameter(2, "actualiza");
                            prod.agregarParameter(3, nombre);
                            prod.agregarParameter(4, apellidoP);
                            prod.agregarParameter(5, apellidoM);
                            prod.agregarParameter(6, email);
                            prod.agregarParameter(7, contra);
                            prod.agregarParameter(8, semestre);
                            prod.agregarParameter(9, grupos);
                            resul= prod.ejecutar();

                            while(resul.next()){
                               resultado= resul.getString("estatus"); 
                            }
                            out.println("<script> alert('"+resultado+"'); </script>");
                            if(resultado.equals("Actualizacion Exitosa")){
                                out.println("<script>location.replace('Seleccion.html');</script>");
                            }else{
                                out.println("<script> history.back(1); </script>");
                            }
                        }else{
                            out.println("<script> alert('Grupos no validos'); </script>");
                            out.println("<script> history.back(1); </script>");
                        }
                    }catch(SQLException ex){
                       haz = ex.getMessage();
                    }
                }else{
                    if(tipo.equals("profesor")){
                        String numG= request.getParameter("numG");
                        int numGroups= Integer.parseInt(numG);
                        String agrupar= "";

                        for(int i=0; i < numGroups; i++){
                            grupos= request.getParameter("grupos"+i);

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

                        if(user.verifyGrupo(semestre, agrupar, tipo)){
                            prod.accionProcedure("accionProf", 9);
                            prod.agregarParameter(1, boleta);
                            prod.agregarParameter(2, "actualiza");
                            prod.agregarParameter(3, nombre);
                            prod.agregarParameter(4, apellidoP);
                            prod.agregarParameter(5, apellidoM);
                            prod.agregarParameter(6, email);
                            prod.agregarParameter(7, contra);
                            prod.agregarParameter(8, semestre);
                            prod.agregarParameter(9, agrupar);
                            resul= prod.ejecutar();

                            while(resul.next()){
                               resultado= resul.getString("estatus"); 
                            }
                            out.println("<script> alert('"+resultado+"'); </script>");
                            if(resultado.equals("Actualizacion Exitosa")){
                                out.println("<script> location.replace('Seleccion.html'); </script>");
                            }else{
                                out.println("<script> history.back(1); </script>");
                            }
                        }else{
                            out.println("<script> alert('Grupos no validos.'); </script>");
                            out.println("<script> history.back(1); </script>");
                        }  
                    }else{
                        out.println("<script> alert('Modificación Fallida.'); </script>");
                        out.println("<script> history.back(1); </script>");
                    }
                }
            }else{
                if(opc.equals("eliminar")){
                    if(tipo.equals("alumno")){
                        try{
                            prod.accionProcedure("accionAlum",9);
                            prod.agregarParameter(1, boleta);
                            prod.agregarParameter(2, "elimina");
                            prod.agregarParameter(3, "eliminado");
                            prod.agregarParameter(4, "eliminado");
                            prod.agregarParameter(5, "eliminado");
                            prod.agregarParameter(6, "eliminado");
                            prod.agregarParameter(7, "eliminado");
                            prod.agregarParameter(8, "eliminado");
                            prod.agregarParameter(9, "eli");
                            resul= prod.ejecutar();

                            while(resul.next()){
                               resultado= resul.getString("estatus"); 
                            }
                            out.println("<script> alert('"+resultado+"'); </script>");
                            if(resultado.equals("Cuenta Eliminada Exitosamente")){
                                out.println("<script> location.replace('salir.jsp'); </script>");
                            }else{
                                out.println("<script> history.back(1); </script>");
                            }
                        }catch(Exception ex){
                           haz = ex.getMessage();
                        }
                    }else{
                        if(tipo.equals("profesor")){
                            prod.accionProcedure("accionProf",9);
                            prod.agregarParameter(1, usuario);
                            prod.agregarParameter(2, "actualiza");
                            prod.agregarParameter(2, "elimina");
                            prod.agregarParameter(3, "eliminado");
                            prod.agregarParameter(4, "eliminado");
                            prod.agregarParameter(5, "eliminado");
                            prod.agregarParameter(6, "eliminado");
                            prod.agregarParameter(7, "eliminado");
                            prod.agregarParameter(8, "eliminado");
                            prod.agregarParameter(9, "eliminado");
                            resul= prod.ejecutar();

                            while(resul.next()){
                               resultado= resul.getString("estatus"); 
                            }
                            out.println("<script> alert('"+resultado+"'); </script>");
                            if(resultado.equals("Cuenta Eliminada Exitosamente")){
                                out.println("<script> location.replace('salir.jsp'); </script>");
                            }else{
                                out.println("<script> history.back(1); </script>");
                            }
                        }else{
                            out.println("<script>alert('No se pudo eliminar la cuenta.');</script>");
                            out.println("<script>location.replace('modificarCuenta.jsp');</script>");
                        }
                    }
                }else{
                    out.println("<script> alert('Ah ocurrido un error inesperado, por favor intentelo de nuevo.'); </script>");
                    out.println("<script> history.back(1); </script>");
                }
            }                
        }catch(Exception ex){
            haz = ex.getMessage();
        }
    }else{
        out.println("<script> alert('Datos no validos.'); </script>");
        out.println("<script> history.back(1); </script>");
    }
        
%>