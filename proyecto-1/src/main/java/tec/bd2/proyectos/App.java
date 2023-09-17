package tec.bd2.proyectos;
 
import org.apache.catalina.LifecycleException;

import tec.bd2.proyectos.ui.Server;
 
public class App {
 
    public static void main(String[] args) throws LifecycleException  {
        Server server = new Server();
        server.start();
    }
}
