package tec.bd2.proyectos.db.repository;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import tec.bd2.proyectos.db.entities.ReceiptEntity;

public class ReceiptRepository implements BaseRepository<ReceiptEntity> {

    private Connection conn;

    public ReceiptRepository(Connection conn) {
        this.conn = conn;
    }

    @Override
    public void save(ReceiptEntity entity) throws SQLException {
        // Sql package: paquete_modificar
        // PROCEDURE insertar_recibo_completo(p_fecha DATE, p_cliente_id NUMBER, p_monto NUMBER, p_cantidad NUMBER, p_metodo_pago VARCHAR2, p_descripcion VARCHAR2);
        // seq_recibo.curval
        // PROCEDURE insertar_producto_recibo(p_producto_id NUMBER, p_recibo_id NUMBER, p_cantidad NUMBER);

        CallableStatement cstmt = conn.prepareCall("{call paquete_modificar.insertar_recibo_completo(?, ?, ?, ?, ?, ?)}");
        cstmt.setString(1, entity.getDate());
        cstmt.setInt(2, entity.getClientId());
        cstmt.setInt(3, entity.getTotal());
        cstmt.setInt(4, entity.getTotalAmount());
        cstmt.setString(5, entity.getPaymentMethod());
        cstmt.setString(6, entity.getDescription());
        cstmt.execute();

        cstmt.close();

        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT seq_recibo.curval FROM dual");
        rs.next();
        entity.setId(rs.getInt(1));

        stmt.close();

        for (Integer productId : entity.getProductsAmounts().keySet()) {
            CallableStatement cstmt2 = conn.prepareCall("{call paquete_modificar.insertar_producto_recibo(?, ?, ?)}");
            cstmt2.setInt(1, productId);
            cstmt2.setInt(2, entity.getId());
            cstmt2.setInt(3, entity.getProductsAmounts().get(productId));
            cstmt2.execute();
            cstmt2.close();
        }
    }

    @Override
    public void update(ReceiptEntity entity) throws SQLException {
        CallableStatement cstmt = conn.prepareCall("{call paquete_modificar.actualizar_recibo(?, ?, ?, ?, ?, ?, ?)}");
        cstmt.setInt(1, entity.getId());
        cstmt.setString(2, entity.getDate());
        cstmt.setInt(3, entity.getClientId());
        cstmt.setInt(4, entity.getTotal());
        cstmt.setInt(5, entity.getTotalAmount());
        cstmt.setString(6, entity.getPaymentMethod());
        cstmt.setString(7, entity.getDescription());

        cstmt.execute();
        cstmt.close();

        CallableStatement cstmt2 = conn.prepareCall("{call paquete_modificar.eliminar_productos_recibo(?)}");
        cstmt2.setInt(1, entity.getId());
        cstmt2.execute();
        cstmt2.close();

        for (Integer productId : entity.getProductsAmounts().keySet()) {
            CallableStatement cstmt3 = conn.prepareCall("{call paquete_modificar.insertar_producto_recibo(?, ?, ?)}");
            cstmt3.setInt(1, productId);
            cstmt3.setInt(2, entity.getId());
            cstmt3.setInt(3, entity.getProductsAmounts().get(productId));
            cstmt3.execute();
            cstmt3.close();
        }
    }

    @Override
    public void delete(int id) throws SQLException {
        CallableStatement cstms = conn.prepareCall("{call paquete_modificar.eliminar_productos_recibo(?)}");
        cstms.setInt(1, id);
        cstms.execute();
        cstms.close();

        CallableStatement cstmt2 = conn.prepareCall("{call paquete_modificar.eliminar_recibo(?)}");
        cstmt2.setInt(1, id);
        cstmt2.execute();
        cstmt2.close();
    }

    @Override
    public ReceiptEntity findById(int id) throws SQLException {
        CallableStatement cstmt = conn.prepareCall("{? = call paquete_select.obtener_productos_recibo(?)}");
        cstmt.registerOutParameter(1, oracle.jdbc.OracleTypes.CURSOR);
        cstmt.setInt(2, id);

        cstmt.execute();

        ResultSet rs = ((oracle.jdbc.OracleCallableStatement)cstmt).getCursor(1);
        HashMap<Integer, Integer> productsAmounts = new HashMap<>();
        while(rs.next()) {
            productsAmounts.put(rs.getInt(1), rs.getInt(2));
        }

        cstmt.close();

        CallableStatement cstmt2 = conn.prepareCall("{? = call paquete_select.obtener_recibo_completo(?)}");
        cstmt2.registerOutParameter(1, oracle.jdbc.OracleTypes.CURSOR);
        cstmt2.setInt(2, id);

        cstmt2.execute();
        

        ResultSet rs2 = ((oracle.jdbc.OracleCallableStatement)cstmt2).getCursor(1);

        if (!rs2.next()) {
            cstmt2.close();
            return null;
        }

        ReceiptEntity receiptEntity = new ReceiptEntity(rs2.getInt(1), rs2.getString(2), rs2.getInt(3), rs2.getInt(4), rs2.getInt(5), rs2.getInt(6), rs2.getString(7), rs2.getString(8), productsAmounts);

        cstmt2.close();

        return receiptEntity;
    }

    @Override
    public List<ReceiptEntity> findAll() throws SQLException {
        CallableStatement cstmt = conn.prepareCall("{? = call paquete_select.obtener_recibos()}");
        cstmt.registerOutParameter(1, oracle.jdbc.OracleTypes.CURSOR);
        
        cstmt.execute();

        ResultSet rs = ((oracle.jdbc.OracleCallableStatement)cstmt).getCursor(1);

        ArrayList<ReceiptEntity> iterable = new ArrayList<>();

        while (rs.next()) {
            CallableStatement cstmt2 = conn.prepareCall("{? = call paquete_select.obtener_productos_recibo(?)}");
            cstmt2.registerOutParameter(1, oracle.jdbc.OracleTypes.CURSOR);
            cstmt2.setInt(2, rs.getInt(1));

            cstmt2.execute();
            

            HashMap<Integer, Integer> productsAmounts = new HashMap<>();

            ResultSet rs2 = ((oracle.jdbc.OracleCallableStatement)cstmt2).getCursor(1);
            while(rs2.next()) {
                productsAmounts.put(rs2.getInt(1), rs2.getInt(2));
            }

            cstmt2.close();

            iterable.add(new ReceiptEntity(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4), rs.getInt(5), rs.getInt(6), rs.getString(7), rs.getString(8), productsAmounts));

        }

        cstmt.close();

        return iterable;
    }
    
}
