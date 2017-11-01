/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package usuario;

/**
 *
 * @author Touchier
 */
public class cUsuario {
    //VALIDANDO QUE NO SEA ESPACIO
    public boolean NoEsEspacio(String contra){
        boolean palabra= false;
        
        contra= contra.replace(" ","");
        if(contra.length() >= 1){
            palabra= true;
        }
        
        return palabra;
    }
    //VALIDANDO SI ES NUMERO y SI ESTA BIEN EL RANGO (PARA IDs tipo Boleta)
    public boolean esNumero(String textoNum, int rango){
        boolean num= false;
        
        if(textoNum.length() == rango){
            int contaNums= 0;
            
            String numeros= "0123456789";
            for(int a= 0; a < textoNum.length(); a++){
                for(int u= 0; u < numeros.length(); u++){
                    if(textoNum.charAt(a) == numeros.charAt(u)){
                        contaNums++;
                        u= numeros.length();
                    }
                }
            }
            if(contaNums == rango){
                num= true;
            }
        }
        return num;
    }
    public boolean esPalabra(String texto){
        boolean palabra= false;
        texto= texto.toUpperCase();
        String letras= " ABCDEFGHILJKMNÑOPQRSTUVWXYZÁÉÍÓÚÄ";
        int contador= 0;
        
        for(int a= 0; a < texto.length(); a++){
            for(int i= 0; i < letras.length(); i++){
                if(texto.charAt(a) == letras.charAt(i)){
                    contador++;
                }
            }
        }
        
        if(contador == texto.length()){
            palabra= true;
        }
        
        return palabra;
    }
    //EVITA QUE LA BASE CAIGA POR INGRESAR DATOS CON MAYOR NUMERO DE CARACTERES DE LOS QUE RESISTE
    public boolean esRangoMenor(String texto, int rango){
        boolean valido = false;
        
        if(texto.length() <= rango){
            valido= true;
        }
        
        return valido;
    }
    //VERIFICA LOS GRUPOS Y VALIDA TODO ACERCA DE ELLOS
    public boolean verifyGrupo(String semestre, String grupo, String tipo) throws Exception{
        cuestionario.splits separar= new cuestionario.splits();
        boolean valido= false;
        
        String gruSemestre= null;
        if(semestre.equals("Primer Semestre")){
            gruSemestre= "1IM1,1IM2,1IM3,1IM4,1IM5,1IM6,1IM7,1IM8,1IM9";
        }else{
            if(semestre.equals("Segundo Semestre")){
                gruSemestre= "2IM1,2IM2,2IM3,2IM4,2IM5,2IM6,2IM7,2IM8,2IM9";
            }
        }
        
        if(gruSemestre != null){
            int contador= 0, rango= 0;
            int tamanio= separar.tamanioSplit(gruSemestre, ',');
            String[] gruSplit= new String[tamanio];
            gruSplit= separar.miSplit(gruSemestre, ',');

            if(tipo.equals("alumno")){
                if(grupo.length() <= 4){
                    rango= 1;
                    for(int a= 0; a < gruSplit.length; a++){
                        if(grupo.equals(gruSplit[a])){
                            contador++;
                        }
                    }
                }
            }else{
                if(tipo.equals("profesor")){
                    if(grupo.length() <= 50){
                        rango= separar.tamanioSplit(grupo, ',');
                        String[] grupoRecibido= separar.miSplit(grupo, ',');
                        String valor= "";

                        for(int a= 0; a < gruSplit.length; a++){
                            for(int u= 0; u < rango; u++){
                                if(grupoRecibido[u].equals(gruSplit[a])){
                                    valido= true;
                                    contador++;
                                    valor+= a + "";
                                }
                            }
                        }
                        //VALIDANDO QUE NO SE REPITAN GRUPOS
                        if(valido == true){
                            if(rango == contador){
                                int conta= 0;
                                for(int u= 0; u < valor.length(); u++){
                                    for(int a= 0; a < valor.length(); a++){
                                        if(valor.charAt(a) == valor.charAt(u)){
                                            conta++;
                                        }
                                    }

                                    if(conta > 1){
                                        u= valor.length();
                                        //SE REPITIO UNO

                                        contador= rango-1;
                                        valido= false;
                                    }
                                    conta= 0;
                                }
                            }
                        }
                    }
                }  
            }

            if(rango == contador){
                valido= true;
            }else{
                valido= false;
            }
        }
        return valido;
    }
    public boolean verifyRFC(String texto){
        int largo= texto.length();
        
        String letras= "QWERTYUIOPASDFGHJKLÑZXCVBNMÁÉÍÓÚ";
        String numeros= "0123456789";
        boolean val= false;
        
        for(int i= 0; i < largo; i++){
            if((i >= 0)&&(i <= 3)){
                for(int u= 0; u < letras.length(); u++){
                    if(texto.charAt(i) == letras.charAt(u)){
                        u= letras.length();
                        val= true;
                    }
                }
                if(val == true){
                    val= false;
                }else{
                    if(val == false){
                        i= largo;
                    }
                }
            }else{
                if((i >= 4)&&(i <= 9)){
                    for(int u= 0; u < numeros.length(); u++){
                        if(texto.charAt(i) == numeros.charAt(u)){
                            u= letras.length();
                            val= true;
                        }
                    }
                    if(val == true){
                        if(i != (largo-1)){
                            val= false;
                        }else{
                            val= true;
                        }
                    }else{
                        if(val == false){
                            i= largo;
                        }
                    }
                }
            }
        }
        return val;
    }
}
