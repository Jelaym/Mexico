/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package resultado;

import BD.cBD;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
/**
 *
 * @author Touchier
 */
public class respuesta {
    cBD base;
    
    Statement stat;
    ResultSet resul;
    
    public respuesta() throws Exception{
        base= new cBD();
    }
    
    public ResultSet traerDatos(String sintaxis) throws Exception{
        stat= base.coneccion().createStatement();
        
        resul= stat.executeQuery(sintaxis);
        return resul;
    }
    public void cierre() throws SQLException{
        base.cerrar();
    }
}
