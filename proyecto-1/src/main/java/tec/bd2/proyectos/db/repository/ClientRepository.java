package tec.bd2.proyectos.db.repository;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import tec.bd2.proyectos.db.entities.ClientEntity;

public class ClientRepository implements BaseRepository<ClientEntity> {

     private Connection conn;

    public ClientRepository(Connection conn) {
        this.conn = conn;
    }

    @Override
    public void save(ClientEntity entity) throws SQLException {
        // PROCEDURE insertar_proveedor(p_nombre VARCHAR2, p_descripcion VARCHAR2, p_direccion VARCHAR2);
        // under the sql package paquete_modificar

        CallableStatement cstmt = conn.prepareCall("{call paquete_modificar.insertar_cliente(?, ?, ?, ?, ?)}");
        cstmt.setString(1, entity.getNombre());
        cstmt.setDate(2, Date.valueOf(entity.getFechaUltimaCompra()));
        cstmt.setString(3, entity.getCorreo());
        cstmt.setString(4, entity.getDireccion());
        cstmt.setInt(5, entity.getCantidadCompras());
        cstmt.execute();
        cstmt.close();
    }

    @Override
    public void update(ClientEntity entity) throws SQLException {
        CallableStatement cstmt = conn.prepareCall("{call paquete_modificar.actualizar_cliente(?, ?, ?, ?, ?, ?)}");
        cstmt.setInt(1, entity.getId());
        cstmt.setString(2, entity.getNombre());
        cstmt.setDate(3, Date.valueOf(entity.getFechaUltimaCompra()));
        cstmt.setString(4, entity.getCorreo());
        cstmt.setString(5, entity.getDireccion());
        cstmt.setInt(6, entity.getCantidadCompras());
        cstmt.execute(); 
        cstmt.close();
    }

    @Override
    public void delete(int id) throws SQLException {
        CallableStatement cstmt = conn.prepareCall("{call paquete_modificar.eliminar_cliente(?)}");
        cstmt.setInt(1, id);
        cstmt.execute();
        cstmt.close();
    }

    @Override
    public ClientEntity findById(int id) throws SQLException {
        CallableStatement cstmt = conn.prepareCall("{? = call paquete_select.obtener_cliente(?)}");
        cstmt.registerOutParameter(1, oracle.jdbc.OracleTypes.CURSOR);
        cstmt.setInt(2, id);
        cstmt.execute();

        // process the cursor returned by the stored procedure into a ResultSet
        ResultSet rs = ((oracle.jdbc.OracleCallableStatement)cstmt).getCursor(1);
        if (!rs.next()) {
            cstmt.close();
            return null;
        }
        ClientEntity clientEntity = new ClientEntity(rs.getInt(1), rs.getString(2), rs.getDate(3).toString(), rs.getString(4), rs.getString(5), rs.getInt(6));
        cstmt.close();
        return clientEntity;
    }

    @Override
    public List<ClientEntity> findAll() throws SQLException {
        CallableStatement cstmt = conn.prepareCall("{? = call paquete_select.obtener_clientes()}");
        cstmt.registerOutParameter(1, oracle.jdbc.OracleTypes.CURSOR);

        cstmt.execute();

        // process the cursor returned by the stored procedure into a ResultSet
        ResultSet rs = ((oracle.jdbc.OracleCallableStatement)cstmt).getCursor(1);
        List<ClientEntity> iterable = new ArrayList<>();
        while(rs.next()) {
            iterable.add(new ClientEntity(rs.getInt(1), rs.getString(2), rs.getDate(3).toString(), rs.getString(4), rs.getString(5), rs.getInt(6)));
        }
        cstmt.close();
        return iterable;
    }
    
}
