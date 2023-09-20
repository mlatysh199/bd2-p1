package tec.bd2.proyectos.db.repository;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import tec.bd2.proyectos.db.entities.ProductBuyEntity;

public class ProductBuyRepository implements BaseRepository<ProductBuyEntity> {

        private Connection conn;

    public ProductBuyRepository(Connection conn) {
        this.conn = conn;
    }

    @Override
    public void save(ProductBuyEntity entity) throws SQLException {
        // PROCEDURE insertar_proveedor(p_nombre VARCHAR2, p_descripcion VARCHAR2, p_direccion VARCHAR2);
        // under the sql package paquete_modificar

        CallableStatement cstmt = conn.prepareCall("{call paquete_modificar.insertar_compra_producto_completo(?, ?, ?, ?, ?, ?)}");
        cstmt.setInt(1, entity.getProducto_id());
        cstmt.setInt(2, entity.getProveedor_id());
        cstmt.setDate(3, Date.valueOf(entity.getFecha()));
        cstmt.setInt(4,entity.getCantidad());
        cstmt.setInt(5,entity.getMonto());
        cstmt.setString(6, entity.getDescripcion());
        cstmt.execute();
        cstmt.close();
    }

    @Override
    public void update(ProductBuyEntity entity) throws SQLException {
        CallableStatement cstmt = conn.prepareCall("{call paquete_modificar.actualizar_compra_producto_completo(?, ?, ?, ?, ?, ?, ?)}");
        cstmt.setInt(1, entity.getId());
        cstmt.setInt(2, entity.getProducto_id());
        cstmt.setInt(3, entity.getProveedor_id());
        cstmt.setDate(4, Date.valueOf(entity.getFecha()));
        cstmt.setInt(5,entity.getCantidad());
        cstmt.setInt(6,entity.getMonto());
        cstmt.setString(7, entity.getDescripcion());
        cstmt.execute(); 
        cstmt.close();
    }

    @Override
    public void delete(int id) throws SQLException {
        CallableStatement cstmt = conn.prepareCall("{call paquete_modificar.eliminar_compra_producto_completo(?)}");
        cstmt.setInt(1, id);
        cstmt.execute();
        cstmt.close();
    }

    @Override
    public ProductBuyEntity findById(int id) throws SQLException {
        CallableStatement cstmt = conn.prepareCall("{? = call paquete_select.obtener_compra_producto(?)}");
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

            ProductBuyEntity productBuyEntity = new ProductBuyEntity(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getDate(4).toString(),rs.getInt(5), rs.getInt(6),rs.getString(7));
            cstmt.close();

            return productBuyEntity;
        }
        
    }

    @Override
    public List<ProductBuyEntity> findAll() throws SQLException {
        CallableStatement cstmt = conn.prepareCall("{? = call paquete_select.obtener_compra_productos()}");
        cstmt.registerOutParameter(1, oracle.jdbc.OracleTypes.CURSOR);

        cstmt.execute();

        // process the cursor returned by the stored procedure into a ResultSet
        ResultSet rs = ((oracle.jdbc.OracleCallableStatement)cstmt).getCursor(1);
        ArrayList<ProductBuyEntity> iterable = new ArrayList<>();
        while(rs.next()) {
            iterable.add(new ProductBuyEntity(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getDate(4).toString(),rs.getInt(5), rs.getInt(6),rs.getString(7)));
        }
        cstmt.close();
        return iterable;
    }
    
}
