package tec.bd2.proyectos;
 
import java.io.IOException;
import java.sql.SQLException;

import org.apache.catalina.LifecycleException;
  
import tec.bd2.proyectos.db.DatabaseContext;
import tec.bd2.proyectos.ui.Server;
 
public class App {
 
    public static void waitForEnter() {
        try {
            System.in.read();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    public static void main(String[] args) throws LifecycleException, ClassNotFoundException, SQLException  {
        DatabaseContext databaseContext = new DatabaseContext("jdbc:oracle:thin:@siuadb2_high", "MLATYSH", "bdAlajuela2023s2", "Wallet_siuadb2");
        Server server = new Server(databaseContext);

        server.start();

        System.out.print("\n\n (*) Press ENTER to stop server thread... ");
        waitForEnter();
        System.out.println("\n (!) Killing server thread...\n\n");

        server.kill();
        databaseContext.getJdbcController().closeConnection();
    }
}
