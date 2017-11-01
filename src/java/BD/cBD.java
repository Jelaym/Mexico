/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BD;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.DriverManager;

/**
 *
 * @author Touchier
 */
public class cBD {
    String url, usser, contra, driver;
    
    Connection cont;
    ResultSet resul;
    
    public cBD(){
        this.driver= "com.mysql.jdbc.Driver";
        this.url= "jdbc:mysql://localhost/mexicum";
        this.usser= "root";
        this.contra= "n0m3l0";
    }
    
    public Connection conectar() throws Exception{
        Class.forName(driver).newInstance();
        cont= DriverManager.getConnection(url,usser,contra);
        return cont;
    }
}
