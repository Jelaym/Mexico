/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package GuardarInfo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
/**
 *
 * @author PCCYBER
 */
public class cGuardarInfo {
    Connection con = null;
    Statement stat = null;
    ResultSet res = null;
    ResultSet resinfo = null;
    String usuario;
    String contra;
    String driver;
    String link;
    
    public cGuardarInfo(){
        this.usuario = "root";
        this.contra = "n0m3l0";
        this.driver = "com.mysql.jdbc.Driver";
        this.link = "jdbc:mysql://localhost/mexicum";
    }
    
    public void conectar(){
        try {
            Class.forName(this.driver).newInstance();
            con = DriverManager.getConnection(link, usuario, contra);
        } catch (Exception ex) {
            System.out.println("El Error es: " + ex.getMessage());
        }
    }
    
    public void closeConexion() throws SQLException{
        this.con.close();
    }
    public int inserta(String inserta) throws SQLException{
        stat = con.createStatement();
        return stat.executeUpdate(inserta);
    }
    
    public ResultSet consulta (String consulta) throws SQLException{
        stat = con.createStatement();
        return stat.executeQuery(consulta);
    }
    
    public String informacion (String informa){
        String info = "";
        
        String linea = System.getProperty("line.separator");
        info = informa.replaceAll(linea,"&#13;&#10;");
        return info;
    }
}
