/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package security;

import BD.cBD;
import java.sql.Connection;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Touchier
 */
public class cSecurityBD {
    cBD base;
    Connection cont;
    CallableStatement call;
    ResultSet resul;
    
    public cSecurityBD() throws Exception{
        base= new cBD();
        cont= base.conectar();
    }
    
    public boolean verifyP(String nombre, String parametro,
                    String rfc, String name, String apellidop, String apellidom, String nombreu,
                    String correo, String contra, String semestre, String agrupar) throws SQLException{
        String mensaje= "";
        boolean registro= false;
        call= cont.prepareCall("{call "+nombre+"(?,?,?,?,?,?,?,?,?,?)}");
        call.setString(1, parametro);
        call.setString(2, rfc);
        call.setString(3, name);
        call.setString(4, apellidop);
        call.setString(5, apellidom);
        call.setString(6, nombreu);
        call.setString(7, correo);
        call.setString(8, contra);
        call.setString(9, semestre);
        call.setString(10, agrupar);
        
        resul= call.executeQuery();
        while(resul.next()){
            mensaje= resul.getString("estatus");
        }
        if(mensaje.equals("Registrado con exito")){
            registro= true;
        }
        return registro;
    }
    
    public boolean verifyA(String nombre,
                    String boleta, String name, String apellidop, String apellidom, String nombreu,
                    String correo, String contra, String semestre, String agrupar) throws SQLException{
        String mensaje= "";
        boolean registro= false;
        call= cont.prepareCall("{call "+nombre+"(?,?,?,?,?,?,?,?,?)}");
        call.setString(1, boleta);
        call.setString(2, name);
        call.setString(3, apellidop);
        call.setString(4, apellidom);
        call.setString(5, nombreu);
        call.setString(6, correo);
        call.setString(7, contra);
        call.setString(8, semestre);
        call.setString(9, agrupar);
        
        resul= call.executeQuery();
        while(resul.next()){
            mensaje= resul.getString("estatus");
        }
        if(mensaje.equals("Registrado con exito")){
            registro= true;
        }
        return registro;
    }
}
