package tec.bd2.proyectos.db.repository;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import tec.bd2.proyectos.db.entities.LogEntity;

public class LogRepository implements BaseRepository<LogEntity> {
     private Connection conn;

    public LogRepository(Connection conn) {
        this.conn = conn;
    }
    @Override
    public void save(LogEntity entity) {
       
    }

    @Override
    public void update(LogEntity entity) {
        
    }

    @Override
    public void delete(int id) {
  
    }

    @Override
    public LogEntity findById(int id) throws SQLException {
        CallableStatement cstmt = conn.prepareCall("{? = call paquete_select.obtener_bitacora_producto(?)}");
        cstmt.registerOutParameter(1, oracle.jdbc.OracleTypes.CURSOR);
        cstmt.setInt(2, id);
        cstmt.execute();

        ResultSet rs = ((oracle.jdbc.OracleCallableStatement)cstmt).getCursor(1);
        if (!rs.next()) {
            cstmt.close();
            return null;
        }
        LogEntity logEntity = new LogEntity(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4));
        cstmt.close();
        return logEntity;
    }

    @Override
    public List<LogEntity> findAll() throws SQLException {
        CallableStatement cstmt = conn.prepareCall("{? = call paquete_select.obtener_bitacora_productos()}");
        cstmt.registerOutParameter(1, oracle.jdbc.OracleTypes.CURSOR);

        cstmt.execute();

        // process the cursor returned by the stored procedure into a ResultSet
        ResultSet rs = ((oracle.jdbc.OracleCallableStatement)cstmt).getCursor(1);
        List<LogEntity> iterable = new ArrayList<>();
        while(rs.next()) {
            iterable.add(new LogEntity(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4)));
        }
        cstmt.close();
        return iterable;
    }
    
    
}
