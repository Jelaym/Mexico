/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package security;

/**
 *
 * @author Touchier
 */
public class security {
    String encri= "#987";
    String linea= System.getProperty("line.separator");
    String salto= "<br>";
    
    public boolean notEtiquetas(String texto){
        int tamanio= texto.length();
        int conta= 0;
        String parametros= "<>';";
        
        for(int a= 0; a < tamanio; a++){
            for(int i= 0; i < parametros.length(); i++){
                if(texto.charAt(a) == parametros.charAt(i)){
                    texto= texto.replace(parametros.charAt(i), ' ');
                    conta++;
                }
            }
        }
        if(conta > 0){
            return true;
        }
        
        return false;
    }

    //ENCRIPTANDO LINEA DE SALTO
    public String quitarLine(String tex){
        String texto= tex.replaceAll(linea, encri);
        
        return texto;
    }
    
    public String agregarLineTextarea(String tex){
        String texto= tex.replaceAll(encri, " \\\\n");
        
        return texto;
    }
    
    public String agregarLine(String tex){
        String texto= tex.replaceAll(encri, salto);
        
        return texto;
    }
}
