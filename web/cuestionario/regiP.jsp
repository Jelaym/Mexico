<%-- 
    Document   : regiP
    Created on : 16/04/2017, 03:34:21 PM
    Author     : Touchier
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*,java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8");

    String val= request.getParameter("Regi");
    if(val != null){
        usuario.cUsuario user= new usuario.cUsuario();
        boolean valido= false;

        int numE= Integer.parseInt(request.getParameter("numE"));
        String Preg= request.getParameter("TextPre");

        valido= (Preg != null)? true: false;
        valido= ((!Preg.equals(""))&&(valido == true))? true: false;

        if(valido == true){
            valido = false;
            security.security secu= new security.security();
            secu.notEtiquetas(Preg);
            Preg= secu.quitarLine(Preg);

            String respA= request.getParameter("ra");        
            String respB= request.getParameter("rb");
            String respC= request.getParameter("rc");
            String respD= request.getParameter("rd");

            String correcta= (String)request.getParameter("resp"); 

            valido= (respA != null)? true: false;
            valido= ((respB != null)&&(valido == true))? true: false;
            valido= ((respC != null)&&(valido == true))? true: false;
            valido= ((respD != null)&&(valido == true))? true: false;
            valido= ((correcta != null)&&(valido == true))? true: false;

            if(valido == true){
                valido= ((!respA.equals(""))&&(valido == true))? true: false;
                valido= ((!respB.equals(""))&&(valido == true))? true: false;
                valido= ((!respC.equals(""))&&(valido == true))? true: false;
                valido= ((!respD.equals(""))&&(valido == true))? true: false;
                valido= ((!correcta.equals(""))&&(valido == true)) ? true: false;
            }

            if(valido == true){
                boolean rangos= false;

                rangos= (user.esRangoMenor(respA, 50)) ? true: false;
                rangos= (user.esRangoMenor(respB, 50)) ? true: false;
                rangos= (user.esRangoMenor(respC, 50)) ? true: false;
                rangos= (user.esRangoMenor(respD, 50)) ? true: false;
                rangos= (user.esRangoMenor(correcta, 2)) ? true: false;

                if(rangos == true){
                    String[] resp= {respA,respB,respC,respD};

                    cuestionario.cuestionario cuesti= new cuestionario.cuestionario();
                    int[] nums= new int[3];
                    nums= cuesti.getNums();
                    cuesti.SetPreg(nums[0], Preg, numE);
                    cuesti.SetResp(nums[1], resp, nums[0]);
                    cuesti.SetCuestionario(nums[2], nums[0], correcta);
                    
                    out.println("<script> alert('Pregunta Registrada con exito!.'); </script>");
                    out.println("<script> location.replace('epocas.html'); </script>");
                }else{
                    out.println("<script> alert('Hay campos demasiado extensos.'); </script>");
                    out.println("<script> history.back(1); </script>");
                } 
            }else{
                out.println("<script> alert('Hay campos no validos.'); </script>");
                out.println("<script> history.back(1); </script>");
            }
        }else{
            out.println("<script> alert('Hay campos no validos.'); </script>");
            out.println("<script> history.back(1); </script>");
        }
    }else{
        out.println("<script>");
        out.println("location.replace('/MexicoInTempore/Error.html');");
        out.println("</script>");
    }
%>