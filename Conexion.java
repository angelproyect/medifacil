import com.sun.jdi.connect.spi.Connection;
import java.sql.DriverManager;
import javax.swing.JOptionPane;


public class Conexion {
    //Conector
    public static final String URL = "jdbc:mysql://localhost:3306/";
    // tienes que poner la usuario que tienes en Mysql
    public static final String USER = "root";
    // tienes que poner la contraseña que tienes en Mysql
    public static final String CLAVE = "";
    //nombre la de la base de datos
    public static final String BASE="carrera";

    public static Connection getConexion(String a){
        Connection con = null;
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = (Connection) DriverManager.getConnection(URL+a, USER, CLAVE);
        }catch(Exception e){
            JOptionPane.showMessageDialog(null, "Error: " + e.getMessage(), "Excepcion ", JOptionPane.ERROR_MESSAGE);
        }
        return con;
    }
    public static Connection getConexion(){
        Connection con = null;
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = (Connection) DriverManager.getConnection(URL+BASE, USER, CLAVE);
        }catch(Exception e){
            JOptionPane.showMessageDialog(null, "Error: " + e.getMessage(), "Excepcion ", JOptionPane.ERROR_MESSAGE);

        }
        return con;
    }
}