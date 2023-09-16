package tec.bd2.proyectos;

import java.io.FileNotFoundException;

import javax.servlet.ServletException;
 
import org.apache.catalina.LifecycleException;

import tec.bd2.proyectos.ui.Server;
 
public class App {
 
    public static void main(String[] args) throws LifecycleException, FileNotFoundException, ServletException {
        Server server = new Server();
        server.start();
    }
}
