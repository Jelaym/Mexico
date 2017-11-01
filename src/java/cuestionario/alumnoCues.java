/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cuestionario;

import BD.cBD;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Touchier
 */
public class alumnoCues {
    BD.cBD base;
    Connection cont= null;
    Statement stat= null;
    ResultSet resul= null;
    
    public alumnoCues() throws Exception{
        base= new BD.cBD();
        cont= base.conectar();
    }
    
    //VALIDAR QUE EXISTAN
    public boolean validar(int[] num) throws SQLException{
        String agrupar= "";
        stat= cont.createStatement();
        int conta= 0, todo= 0;
        
        for(int i= 0; i < num.length; i++){
            agrupar= "SELECT * FROM rel_preguntaepoca where Num_Pregunta="+num[i]+";";
            resul= stat.executeQuery(agrupar);

            while(resul.next()){
                if(conta == 0){
                    todo++;
                    conta++;
                }else{
                    //SIGNIFICA QUE TRAJO MAS DE UNA RESPUESTA POR LO TANTO ESTA MAL. PORQUE ES UN ID
                    //AL DETECTAR ESTO, ES POSIBLE QUE HAYAN INTENTADO HACER UNA INJECCIÓN.
                    return false;
                }
            }
            conta= 0;
        } 
        
        if(todo == num.length){
            return true;
        }else{
            return false;
        }
    }
    
    //Checar Correctar e Incorrectas
    public int[] scoreQuiz(int[] num, String[] contesto) throws SQLException{
        //PONEMOS EL PRIMERO POR DEFAULT 2, porque SOLO PUEDE HABER DOS OPCIONES, Correctas e Incorrectas.
        //PRIMERA - CORRECTAs ---- SEGUNDA - INCORRECTAs
        int[] score= new int[2];
        String buscar= "";
        
        stat= cont.createStatement();
        
        for(int u= 0; u < num.length; u++){
            buscar= "SELECT * FROM cuestionario where Num_Pregunta="+num[u]+";";

            resul= stat.executeQuery(buscar);

            while(resul.next()){
                String resp= resul.getString("respuesta");
                if(resp.equals(contesto[u])){
                    score[0]++;
                }else{
                    score[1]++;
                }
            }
        }
        return score;
    }
    //OBTENER STATUS ALUMNO
    public String Status(int buenas, int malas){
        String estado= "";
        
        if((buenas+ malas) == 10){
            if(buenas >= 7){
                estado= "Logrado";
            }else{
                estado= "Fallido";
            }
        }else{
            estado= "Error";
        }
        
        return estado;
    }
    
    //AGREGAR PUNTAJE
    public void AgregarScore(int Correct, int Erronea, String estado, String numBoleta, int epo) throws SQLException{
        boolean existe= false;
        int buenas= 0, intentos= 0;
        
        stat= cont.createStatement();
        resul= stat.executeQuery("SELECT * FROM puntaje where Num_Boleta="+numBoleta+" AND idEpoca='"+ epo +"';");
        
        while(resul.next()){
            existe= true;
            buenas= Integer.parseInt(resul.getString("Correctas"));
            intentos= Integer.parseInt(resul.getString("Intentos"))+1;
        }
        
        if(existe == false){
            intentos= 1;
            resul= stat.executeQuery("SELECT MAX(CodScore) as max FROM puntaje");
            int maximo= 0;
            while(resul.next()){
                String nulo= resul.getString("max");
                if(nulo != null){
                    maximo= Integer.parseInt(nulo)+1;
                }else{
                    maximo= 1;
                }
            }
            stat.executeUpdate("INSERT INTO puntaje VALUES("+maximo+","+Correct+","+Erronea+",'"+estado+"',"+numBoleta+","+epo+","+intentos+");");
        }else{
            if(existe == true){
                if(Correct > buenas){
                    stat.executeUpdate("UPDATE puntaje SET Correctas="+Correct+",Erroneas="+Erronea+", Intentos="+intentos+", Estatus='"+estado+"' where Num_Boleta= "+numBoleta+";");
                }else{
                    stat.executeUpdate("UPDATE puntaje SET Intentos="+intentos+" where Num_Boleta= "+numBoleta+";");
                }
            }
        }
    }
}