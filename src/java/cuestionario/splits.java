/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cuestionario;

/**
 *
 * @author Touchier
 */
public class splits {
    public splits(){
        
    }
    //SPLIT
    public int tamanioSplit(String tex, char parametro){
        int conta= 0, coma= 0;
        for(int a= 0; a < tex.length(); a++){
            if(tex.charAt(a) != parametro){
                if(coma == 0){
                    conta++;
                }
                coma++;
            }else{
                coma= 0;
            }
        }
        
        return conta;
    }
    
    public String[] miSplit(String tex, char parametro){
        int largo= tamanioSplit(tex, parametro);
        int conta= 0;
        String[] palabra= new String[largo];
        
        palabra[0]= "";
        for(int a= 0; a < tex.length(); a++){
            if(tex.charAt(a) != parametro){
                palabra[conta]+= tex.charAt(a) + "";
            }else{
                conta++;
                palabra[conta]= "";
            }
        }
        return palabra;
    }
    
    //CONVERTIR ARREGLO STRING A ARREGLO NUMERO
    public int[] miSplitNumero(String tex, char parametro){
        int largo= tamanioSplit(tex, parametro);
        int conta= 0, comas= 0;
        int[] numeros= new int[largo];
        String apoyo= "";
        
        for(int a= 0; a < tex.length(); a++){
            if(tex.charAt(a) != parametro){
                apoyo+= tex.charAt(a) + "";
                comas= 0;
            }else{
                if(comas == 0){
                    numeros[conta]= Integer.parseInt(apoyo);
                    conta++;
                    comas++;
                    apoyo= "";
                }
            }
            //HACEMOS UNO MANUAL PARA EL ULTIMO, PORQUE LA VALIDACION ES POR COMAS Y SEGURAMENTE NO TENDRAN COMAS LOS ULTIMOS
            if((a+1)==tex.length() && (tex.charAt(a) != ',') && (tex.charAt(a) != '.')){
                numeros[conta]= Integer.parseInt(apoyo);
            }
        }
        return numeros;
    }
}
