/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package usuario;

import java.sql.Connection;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import BD.cBD;

/**
 *
 * @author Touchier
 */
public class cExists{
    cBD conecta;
    
    Connection cont;
    CallableStatement stat;
    ResultSet resul;
    
    int posicion;
    
    public cExists() throws Exception{
        this.conecta= new cBD();
        this.cont= conecta.conectar();
        this.stat= null;
        this.posicion= 0;
    }
    
    public boolean declara(String nombre, String id) throws SQLException{
        boolean existe= false;
        stat= cont.prepareCall("{call "+ nombre +"(?)}");
        stat.setString(1, id);
        String rfc= "No existe";
        
        try{
            resul= stat.executeQuery();
            while(resul.next()){
                rfc= resul.getString("estatus");
            }
        }catch(SQLException e){
            //NOTHING
        }
        existe= (rfc.equals("Existe"))? true: false;
        
        return existe;
    }
    
    public String getInfoUsuario(String parametro, String name) throws SQLException{
        stat= cont.prepareCall("{call "+name+"(?)}");
        stat.setString(1, parametro);
        
        resul= stat.executeQuery();
        boolean dato= false;
        String epoca= "0";
        
        while(resul.next()){
            if(dato == false){
                epoca= resul.getString("idEpoca");
                dato= true;
            }
        }
        if(epoca == null){
            epoca= "0";
        }
        return epoca;
    }
    
    /*public void accionAlum(String name, String boleta, String accion, String nombre, String ap,
                                String am, String correo, String contra, String semes, String grupo) throws SQLException{
        stat= cont.prepareCall("{call "+name+"(?,?,?,?,?,?,?,?,?)}");
        stat.setString(1, boleta);
        stat.setString(2, accion);
        stat.setString(3, nombre);
        stat.setString(4, ap);
        stat.setString(5, am);
        stat.setString(6, correo);
        stat.setString(7, contra);
        stat.setString(8, semes);
        stat.setString(9, grupo);
        stat.execute();
    }*/
    public void accionProcedure(String name, int numero) throws SQLException{
        String consulta= "{call "+ name;
        String signos= "(";
        for(int i= 0; i < numero; i++){
            if(i != (numero-1)){
                signos+= "?,";
            }else{
                signos+= "?)";
            }
        }
        consulta+= signos + "}"; 
                
        this.posicion= numero;
        this.stat= this.cont.prepareCall(consulta);
    }
    public boolean agregarParameter(int pos, String parametro) throws SQLException{
        boolean existeStat= false;
        if(this.stat != null){
            if(pos <= this.posicion){
                existeStat= true;
                this.stat.setString(pos, parametro);
            }
        }
        return existeStat;
    }
    public ResultSet ejecutar() throws SQLException{
        this.resul= stat.executeQuery();
        return resul;
    }
}
