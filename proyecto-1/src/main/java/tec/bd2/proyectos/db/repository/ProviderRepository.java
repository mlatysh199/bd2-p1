package tec.bd2.proyectos.db.repository;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import tec.bd2.proyectos.db.entities.ProviderEntity;

public class ProviderRepository implements BaseRepository<ProviderEntity> {

    private Connection conn;

    public ProviderRepository(Connection conn) {
        this.conn = conn;
    }

    @Override
    public void save(ProviderEntity entity) throws SQLException {
        // PROCEDURE insertar_proveedor(p_nombre VARCHAR2, p_descripcion VARCHAR2, p_direccion VARCHAR2);
        // under the sql package paquete_modificar

        CallableStatement cstmt = conn.prepareCall("{call paquete_modificar.insertar_proveedor(?, ?, ?)}");
        cstmt.setString(1, entity.getName());
        cstmt.setString(2, entity.getDescription());
        cstmt.setString(3, entity.getAddress());
        cstmt.execute();
        cstmt.close();
    }

    @Override
    public void update(ProviderEntity entity) throws SQLException {
        CallableStatement cstmt = conn.prepareCall("{call paquete_modificar.actualizar_proveedor(?, ?, ?, ?)}");
        cstmt.setInt(1, entity.getId());
        cstmt.setString(2, entity.getName());
        cstmt.setString(3, entity.getDescription());
        cstmt.setString(4, entity.getAddress());
        cstmt.execute(); 
        cstmt.close();
    }

    @Override
    public void delete(int id) throws SQLException {
        CallableStatement cstmt = conn.prepareCall("{call paquete_modificar.eliminar_proveedor(?)}");
        cstmt.setInt(1, id);
        cstmt.execute();
        cstmt.close();
    }

    @Override
    public ProviderEntity findById(int id) throws SQLException {
        CallableStatement cstmt = conn.prepareCall("{? = call paquete_select.obtener_proveedor(?)}");
        cstmt.registerOutParameter(1, oracle.jdbc.OracleTypes.CURSOR);
        cstmt.setInt(2, id);
        cstmt.execute();

        

        // process the cursor returned by the stored procedure into a ResultSet
        ResultSet rs = ((oracle.jdbc.OracleCallableStatement)cstmt).getCursor(1);
        if (!rs.next()) {
            cstmt.close();
            return null;
        }
        ProviderEntity providerEntity = new ProviderEntity(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4));

        cstmt.close();

        return providerEntity;
    }

    @Override
    public List<ProviderEntity> findAll() throws SQLException {
        CallableStatement cstmt = conn.prepareCall("{? = call paquete_select.obtener_proveedores()}");
        cstmt.registerOutParameter(1, oracle.jdbc.OracleTypes.CURSOR);

        cstmt.execute();

        

        // process the cursor returned by the stored procedure into a ResultSet
        ResultSet rs = ((oracle.jdbc.OracleCallableStatement)cstmt).getCursor(1);
        ArrayList<ProviderEntity> iterable = new ArrayList<>();
        while(rs.next()) {
            iterable.add(new ProviderEntity(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4)));
        }
        cstmt.close();
        return iterable;
    }
    
}
