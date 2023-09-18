package tec.bd2.proyectos.db.repository;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import tec.bd2.proyectos.db.entities.ProductEntity;

public class ProductRepository implements BaseRepository<ProductEntity> {

    private Connection conn;

    public ProductRepository(Connection conn) {
        this.conn = conn;
    }

    @Override
    public void save(ProductEntity entity) throws SQLException {
        // PROCEDURE insertar_proveedor(p_nombre VARCHAR2, p_descripcion VARCHAR2, p_direccion VARCHAR2);
        // under the sql package paquete_modificar

        CallableStatement cstmt = conn.prepareCall("{call paquete_modificar.insertar_producto(?, ?, ?, ?, ?)}");
        cstmt.setString(1, entity.getNombre());
        cstmt.setString(2, entity.getDescripcion());
        cstmt.setInt(3, entity.getPrecio());
        cstmt.setString(4,entity.getCategoria());
        cstmt.setInt(5,entity.getInventario());
        cstmt.execute();
        cstmt.close();
    }

    @Override
    public void update(ProductEntity entity) throws SQLException {
        CallableStatement cstmt = conn.prepareCall("{call paquete_modificar.actualizar_producto(?, ?, ?, ?, ?, ?)}");
        cstmt.setInt(1, entity.getId());
        cstmt.setString(2, entity.getNombre());
        cstmt.setString(3, entity.getDescripcion());
        cstmt.setInt(4, entity.getPrecio());
        cstmt.setString(5,entity.getCategoria());
        cstmt.setInt(6,entity.getInventario());
        cstmt.execute(); 
        cstmt.close();
    }

    @Override
    public void delete(int id) throws SQLException {
        CallableStatement cstmt = conn.prepareCall("{call paquete_modificar.eliminar_producto(?)}");
        cstmt.setInt(1, id);
        cstmt.execute();
        cstmt.close();
    }

    @Override
    public ProductEntity findById(int id) throws SQLException {
        CallableStatement cstmt = conn.prepareCall("{? = call paquete_select.obtener_producto(?)}");
        cstmt.registerOutParameter(1, oracle.jdbc.OracleTypes.CURSOR);
        cstmt.setInt(2, id);
        cstmt.execute();

        // process the cursor returned by the stored procedure into a ResultSet
        ResultSet rs = ((oracle.jdbc.OracleCallableStatement)cstmt).getCursor(1);
        if(rs == null){
            cstmt.close();
            return null;

        }
        else{

            if (!rs.next()) {
                cstmt.close();
                return null;
            }

            ProductEntity productEntity = new ProductEntity(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4),rs.getString(5), rs.getInt(6));
            cstmt.close();

            return productEntity;

        }
        
    }

    @Override
    public List<ProductEntity> findAll() throws SQLException {
        CallableStatement cstmt = conn.prepareCall("{? = call paquete_select.obtener_proveedores()}");
        cstmt.registerOutParameter(1, oracle.jdbc.OracleTypes.CURSOR);

        cstmt.execute();

        // process the cursor returned by the stored procedure into a ResultSet
        ResultSet rs = ((oracle.jdbc.OracleCallableStatement)cstmt).getCursor(1);
        ArrayList<ProductEntity> iterable = new ArrayList<>();
        while(rs.next()) {
            iterable.add(new ProductEntity(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4),rs.getString(5), rs.getInt(6)));
        }

        cstmt.close();

        return iterable;
    }
    
}
