/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Biografias;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.imageio.ImageIO;
import javax.swing.JLabel;
import javax.swing.JOptionPane;


public class cInformacionBases {
    Connection con = null;
    Statement stat = null;
    ResultSet res = null;
    ResultSet resinfo = null;
    String usuario;
    String contra;
    String driver;
    String link;
    
    public cInformacionBases(){
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
        public int insertar(String inserta) throws SQLException{
        stat = con.createStatement();
        return stat.executeUpdate(inserta);
    }
    public ResultSet consultar (String consulta) throws SQLException{
        stat = con.createStatement();
        return stat.executeQuery(consulta);
    }
    
    public String informacion (String informa){
        String info = "";
        String escape = "";
        
        String linea = System.getProperty("line.separator");
        escape = informa.replaceAll(linea,"&#13;&#10;");
        info = this.enlace(escape);
        return info;
    }
    public String enlace (String primero){
        String enlace = "";
        String enlace2 = "";
        String enlace3 = "";
        String enlace4 = "";
        String enlace5 = "";

        enlace2 =  primero.replaceAll("<", "");
        enlace3 =  enlace2.replaceAll(">", "");
        enlace4 =  enlace3.replaceAll("drop", "");
        enlace5 =  enlace4.replaceAll("DROP", "");
        enlace  = enlace5.replaceAll("\"", "\\\\\"");
        
        return enlace;
    }
    
    
    public String GuardarImagen(String path){
        String ax = "";
        try{
            BufferedImage img = null;
            try {
                img = ImageIO.read(new File(path));
            } catch (IOException e) {
            }
            File file= new File("web\\ImagenesBiografias" + path+ ".jpg");
            ax = "web\\ImagenesBiografias" + path+ ".jpg";
            ImageIO.write(img, "jpg", file);
        }catch(IOException a){
            ax = "";
        }
        return ax;
    }
    
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
}
