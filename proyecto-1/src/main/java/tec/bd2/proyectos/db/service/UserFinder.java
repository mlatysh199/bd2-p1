package tec.bd2.proyectos.db.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import tec.bd2.proyectos.db.entities.UserEntity;

public class UserFinder {

    private Connection conn;

    public UserFinder(Connection conn) {
        this.conn = conn;
    }

    public UserEntity find(String id) throws SQLException {
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM usuario WHERE nombre = '" + id + "'");
        

        if (!rs.next()) {
            stmt.close();
            return null;
        }
            
        UserEntity userEntity = new UserEntity(rs.getString(1), rs.getInt(2), rs.getInt(3), rs.getInt(4));
        
        stmt.close();

        return userEntity;
    }
}
