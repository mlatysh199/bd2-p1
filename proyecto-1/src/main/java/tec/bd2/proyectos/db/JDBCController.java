package tec.bd2.proyectos.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;


public class JDBCController {
    private final Connection conn;

    public JDBCController(String jdbcURL, String username, String password, String walletLocation) throws SQLException, ClassNotFoundException {
        //System.out.println(DriverManager.getDrivers().nextElement().getClass().getName());
        //Class.forName("oracle.jdbc.driver.OracleDriver");
        Properties props = new Properties();
        props.setProperty("user", username);
        props.setProperty("password", password);
        props.setProperty("oracle.net.tns_admin", walletLocation);
        conn = DriverManager.getConnection(jdbcURL, props);
    }

    public Connection getConnection() {
        return this.conn;
    }

    public void closeConnection() throws SQLException {
        this.conn.close();
    }
}
