/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cuestionario;

//import java.sql.*;
import BD.cBD;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Random;
/**
 *
 * @author Touchier
 */
public class cuestionario {
    cBD base;
    
    String preguntas;
    String respuestas[];
    
    int[] numP= new int[3];
    int numE= 0;
    int numModi= 0;
    
    Connection cont= null;
    Statement stat= null;
    ResultSet resul= null;
    
    public cuestionario() throws Exception{
        base= new cBD();
        cont= base.conectar();
    }
    
    public void SetPreg(int num_preg, String textPreg, int idEpo) throws SQLException{
        stat= cont.createStatement();
        stat.executeUpdate("INSERT INTO rel_preguntaepoca VALUES("+ num_preg +",'"+ textPreg +"',"+ idEpo +");");
    }
    
    public void SetResp(int idRe, String[] resp, int numPre) throws SQLException{
        stat= cont.createStatement();
        String principio= "INSERT INTO respuestas VALUES(";
        stat.executeUpdate(principio+ idRe   +",'A','"+ resp[0] +"',"+numPre+");");
        stat.executeUpdate(principio+(idRe+1)+",'B','"+ resp[1] +"',"+numPre+");");
        stat.executeUpdate(principio+(idRe+2)+",'C','"+ resp[2] +"',"+numPre+");");
        stat.executeUpdate(principio+(idRe+3)+",'D','"+ resp[3] +"',"+numPre+");");
    }
    
    public void SetCuestionario(int numT, int numP, String resp) throws SQLException{
        stat= cont.createStatement();
        stat.executeUpdate("INSERT INTO cuestionario VALUES("+numT+","+numP+",'"+resp+"')");
    }
    
    public int[] getNums(){
        try{
            stat= cont.createStatement();
            //1 - pregunta
            resul= stat.executeQuery("SELECT Count(*) as conta FROM rel_preguntaepoca");
            while(resul.next()){
                numP[0]= Integer.parseInt(resul.getString("conta"))+1;
            }
            //2 - respuestas
            resul= stat.executeQuery("SELECT Count(*) as conta FROM respuestas");
            while(resul.next()){
                numP[1]= Integer.parseInt(resul.getString("conta"))+1;
            }
            //3 - correcta
            resul= stat.executeQuery("SELECT Count(*) as conta FROM cuestionario");
            while(resul.next()){
                numP[2]= Integer.parseInt(resul.getString("conta"))+1;
            }
        }catch(SQLException e){
            //NOThiNG; Nada :d porque no se que poner :d
        }
        return this.numP;
    }
    
    public int getPregEpoca(int epoca) throws SQLException{
        stat= cont.createStatement();

        resul= stat.executeQuery("SELECT count(*) as num FROM rel_preguntaepoca where idEpoca="+epoca+";");
        while(resul.next()){
            numE= Integer.parseInt(resul.getString("num"))+1;
        }
        if(numE == 0){
            numE= 1;
        }
        return this.numE;
    }
    public void setTempo(int num){
        this.numModi= num;
    }
    public String[] getValorCuesti(int numPregs, int epoca) throws SQLException{
        Random rand= new Random();
        stat= cont.createStatement();
        int apoyo= 0;
        int random= 0;
        ArrayList<String> nums= new ArrayList<String>();
        
        resul= stat.executeQuery("SELECT * FROM rel_preguntaepoca where idEpoca='"+epoca+"'");
        while(resul.next()){
            nums.add(apoyo,resul.getString("Num_Pregunta"));
            apoyo++;
        }
        apoyo= 0;
        
        if(numPregs > nums.size()){
            numPregs= nums.size();
        }
        String[] preguntasEnvio= new String[numPregs];
        
        for(int i= 0; i < numPregs; i++){
            random= (int)(rand.nextInt(nums.size()));
            apoyo= Integer.parseInt(nums.get(random));
            resul= stat.executeQuery("SELECT * FROM rel_preguntaepoca where Num_Pregunta= "+apoyo+";");
            while(resul.next()){
                String decribePreg= resul.getString("Descripcion");
                preguntasEnvio[i]= decribePreg + "×" + apoyo;
            }
            nums.remove(random);
        }
        return preguntasEnvio;
    }
    //TRAE PREGUNTAS ORDENADAS
    public String[] getValorCuestiOrdenadas(int numPregs, int epoca) throws SQLException{
        stat= cont.createStatement();
        int apoyo= 0;
        ArrayList<String> nums= new ArrayList<String>();
        
        resul= stat.executeQuery("SELECT * FROM rel_preguntaepoca where idEpoca='"+epoca+"'");
        while(resul.next()){
            nums.add(apoyo,resul.getString("Num_Pregunta"));
            apoyo++;
        }
        apoyo= 0;
        
        if(numPregs > nums.size()){
            numPregs= nums.size();
        }
        String[] preguntasEnvio= new String[numPregs];
        
        for(int i= 0; i < numPregs; i++){
            apoyo= Integer.parseInt(nums.get(i));
            resul= stat.executeQuery("SELECT * FROM rel_preguntaepoca where Num_Pregunta= "+apoyo+";");
            while(resul.next()){
                String decribePreg= resul.getString("Descripcion");
                preguntasEnvio[i]= decribePreg + "×" + apoyo;
            }
        }
        return preguntasEnvio;
    }
    //SOLO TRAEN UNA PREGUNTA 
    public String getValPre(int numPre) throws SQLException{
        int val= 0;
        String valor= null;
        stat= cont.createStatement();
        
        resul= stat.executeQuery("SELECT Descripcion FROM rel_preguntaepoca where Num_Pregunta= "+numPre+";");
        while(resul.next()){
            if(val == 0){
                valor= resul.getString("Descripcion");
            }
        }
        return valor;
    }
    //HASTA ACA DEJAN DE TRAER SOLO UNA PREGUNTA
    public String[] getValorResp(int[] numPreg) throws SQLException{
        //MULTIPLICAMOS POR 4, SON 4 RESPUESTAS
        String[] respuestas= new String[numPreg.length*4];
        stat= cont.createStatement();
        int conta= 0;
        
        for(int i= 0; i < numPreg.length; i++){
            resul= stat.executeQuery("SELECT * FROM respuestas where Num_Pregunta='"+numPreg[i]+"'");
            while(resul.next()){
                String describe= resul.getString("Descripcion");
                respuestas[conta]= describe;
                conta++;
            }
        }
        return respuestas;
    }
    
    public String[] getEpocas() throws SQLException{
        stat= cont.createStatement();
        
        resul= stat.executeQuery("SELECT count(*) as conta FROM epoca");
        
        int numero= 0;
        while(resul.next()){
            numero= Integer.parseInt(resul.getString("conta"));
        }
        String[] nombre= new String[numero];
        resul= stat.executeQuery("SELECT * FROM epoca");
        
        numero= 0;
        while(resul.next()){
            nombre[numero]= resul.getString("Epoca");
            numero++;
        }
        return nombre;
    }
    //COMO EL METODO .split UNICAMENTE PARA CUESTIONARIO
    public String[] separarPregs(int numPres, String[] pregs){
        String[] textPreg= new String[numPres];
        boolean texto= false, numeroVal= false;
        String agrupar= "";
        
        for(int i= 0; i < pregs.length; i++){
            for(int o= 0; o < pregs[i].length(); o++){
                if((pregs[i].charAt(o) != '×')){
                    if(texto == false){
                        agrupar+= pregs[i].charAt(o);
                    }
                }else{
                    texto= true;
                }
            }
            textPreg[i]= agrupar;
            agrupar= "";
            texto= false;
        }
        
        return textPreg;
    }
    public int[] separarResps(int numPres, String[] pregs){
        
        int[] numPregunta= new int[numPres];
        boolean texto= false;
        String agruparNums= "";
        
        for(int i= 0; i < pregs.length; i++){
            for(int o= 0; o < pregs[i].length(); o++){
                if(pregs[i].charAt(o) != '×'){
                    if(texto == true){
                        agruparNums+= pregs[i].charAt(o);
                    }
                }else{
                    texto= true;
                }
            }
            numPregunta[i]= Integer.parseInt(agruparNums);
            agruparNums= "";
            texto= false;
        }
        return numPregunta;
    }
    //TRAER RESPUESTA CORRECTA
    public int getCorrectRes(int numPre) throws SQLException{
        String letra= "";
        int num= 0;
        stat= cont.createStatement();
        
        resul= stat.executeQuery("SELECT respuesta from cuestionario where Num_Pregunta= '"+numPre+"'");
        while(resul.next()){
            letra= resul.getString("respuesta");
        }
        if(letra.equals("A")){
            num= 1;
        }else{
            if(letra.equals("B")){
                num= 2;
            }else{
                if(letra.equals("C")){
                    num= 3;
                }else{
                    if(letra.equals("D")){
                        num= 4;
                    }
                }
            }
        }
        return num;
    }

    //ACTUALIZAR DATO (cSecurity.j<sp)
    public void cActualizar(int numPre, String text, int epo, String[] textResp, String correcta) throws SQLException{
        stat= cont.createStatement();
        stat.executeUpdate("UPDATE rel_preguntaepoca SET Descripcion='"+text+"', idEpoca='"+epo+"' WHERE Num_Pregunta='"+numPre+"';");
        
        resul= stat.executeQuery("SELECT * FROM respuestas where Num_Pregunta= '"+numPre+"';");
        int a= 0;
        int[] numId= new int[4];
        while(resul.next()){
            numId[a]= Integer.parseInt(resul.getString("idRespuesta"));
            a++;
        }
        
        for(a= 0; a < 4; a++){
            stat.executeUpdate("UPDATE respuestas SET Descripcion='"+textResp[a]+"' WHERE idRespuesta='"+numId[a]+"';");
        }
        stat.executeUpdate("UPDATE cuestionario SET respuesta='"+correcta+"' WHERE Num_Pregunta='"+numPre+"';");
    }
    //ELIMINAR, numPre es el id de la pregunta que se quiere eliminar
    //PARA EVITAR FUTUROS PROBLEMAS RECORREREMOS LOS IDS, si es que hay antes de la pregunta y/o respuestas
    public void cEliminar(int numPre) throws SQLException{
        stat= cont.createStatement();
        int numResp= 0, numP= 0, numCuesti= 0;
        
        //ANTES DE TODO QUITAMOS LAS LLAVES FORANEAS PARA PODER RECORRER LAS IDS de REL_PREGUNTAEPOCA
        stat.executeUpdate("ALTER TABLE respuestas drop foreign key respuestas_ibfk_1;");
        stat.executeUpdate("ALTER TABLE cuestionario drop foreign key cuestionario_ibfk_1;");
        
        
        //ELIMINANDO DESDE TABLA CUESTIONARIO
        //EL VALOR MAYOR de CUESTIONARIO
        //ASUMIMOS QUE 'NUM_PREGUNTA' = 'COD_PREG_RESP'
        resul= stat.executeQuery("SELECT Cod_Preg_Resp as Mayor FROM cuestionario where Cod_Preg_Resp=(SELECT MAX(Cod_Preg_Resp) FROM cuestionario)");
        while(resul.next()){
            numCuesti= Integer.parseInt(resul.getString("Mayor"));
        }
        //BORRAMOS ID
        stat.executeUpdate("DELETE FROM cuestionario WHERE Num_Pregunta='"+numPre+"'");
        //RECORREMOS IDs
        if(numCuesti != numPre){
            for(int recorrer= numPre; recorrer < numCuesti; recorrer++){
                stat.executeUpdate("UPDATE cuestionario SET Num_Pregunta='"+recorrer+"', Cod_Preg_Resp='"+recorrer+"' where Cod_Preg_Resp='"+(recorrer+1)+"'");
            }
        }
        
        //TABLA RESPUESTAS
        resul= stat.executeQuery("SELECT idRespuesta as num FROM respuestas where idRespuesta=(SELECT MAX(idRespuesta) FROM respuestas);");
        
        while(resul.next()){
            numResp= Integer.parseInt(resul.getString("num"));
        }
        //Traer el rango que sera eliminado
        resul= stat.executeQuery("SELECT idRespuesta FROM respuestas where Num_Pregunta='"+numPre+"' and (OpcionRes='A' or OpcionRes='D')");
        int[] limites= new int[2];
        int conta= 0;
        while(resul.next()){
            limites[conta]= Integer.parseInt(resul.getString("idRespuesta")); 
            conta++;
        }
        //Se eliminan
        for(limites[0] = limites[0]; limites[0] <= limites[1]; limites[0]++){
            stat.executeUpdate("DELETE FROM respuestas where idRespuesta='"+limites[0]+"';");
        }
        if(limites[1] != numResp){
            //LOS RECORREMOS
            int num= 0;
            conta= numPre;
            for(limites[0]-= 6; limites[0] < (numResp-4); limites[0]++){
                stat.executeUpdate("UPDATE respuestas SET idRespuesta='"+(limites[0]+1)+"', Num_Pregunta='"+conta+"' WHERE idRespuesta='"+limites[1]+"';");
                limites[1]++;
                if(num == 4){
                    conta++;
                    num= 0;
                }
                num++;
            }
        }
        //TABLA REL_PREGUNTAEPOCA
        //VALOR ID TOTAL
        resul= stat.executeQuery("SELECT count(*) as numP FROM rel_preguntaepoca");
        while(resul.next()){
            numP= Integer.parseInt(resul.getString("numP"));
        }
        
        stat.executeUpdate("DELETE FROM rel_preguntaepoca where Num_Pregunta='"+numPre+"'");
        //RECORREMOS PREGUNTAS
        if(numPre != numP){
            for(numPre= numPre; numPre <= numP; numPre++){
                stat.executeUpdate("UPDATE rel_preguntaepoca SET Num_Pregunta='"+numPre+"' where Num_Pregunta='"+(numPre+1)+"'");
            }
        }
    
        stat.executeUpdate("ALTER TABLE respuestas ADD CONSTRAINT respuestas_ibfk_1 FOREIGN KEY (Num_Pregunta) REFERENCES rel_preguntaepoca(Num_Pregunta);");
        stat.executeUpdate("ALTER TABLE cuestionario ADD CONSTRAINT cuestionario_ibfk_1 FOREIGN KEY (Num_Pregunta) REFERENCES rel_preguntaepoca(Num_Pregunta);");
    }
}
