package tec.bd2.proyectos.db.service;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.util.GregorianCalendar;

public class Metrics {
    private Connection conn;
    
    public Metrics(Connection conn) {
        this.conn = conn;
    }

    public int getAmountOfItemsSoldPerMonth(int year, int month) throws SQLException {
        long time = new GregorianCalendar(year, month, 1).getTimeInMillis();
        Date date = new Date(time);
        // FUNCTION obtener_articulos_vendido_mes(anio_mes DATE) RETURN NUMBER AS articulos_vendidos NUMBER;

        CallableStatement cstmt = conn.prepareCall("{? = call paquete_select.obtener_articulos_vendido_mes(?)}");
        cstmt.setDate(2, date);
        cstmt.registerOutParameter(1, java.sql.Types.INTEGER);

        cstmt.execute();
        int result = cstmt.getInt(1);
        cstmt.close();

        return result;
    }

    public int getAmountOfItemSoldPerMonth(int year, int month, int itemId) throws SQLException {
        long time = new GregorianCalendar(year, month, 1).getTimeInMillis();
        Date date = new Date(time);
        // FUNCTION obtener_articulo_vendido_mes(anio_mes DATE, id_articulo NUMBER) RETURN NUMBER AS articulos_vendidos NUMBER;

        CallableStatement cstmt = conn.prepareCall("{? = call paquete_select.obtener_articulo_vendido_mes(?, ?)}");
        cstmt.setDate(3, date);
        cstmt.setInt(2, itemId);
        cstmt.registerOutParameter(1, java.sql.Types.INTEGER);

        cstmt.execute();
        int result = cstmt.getInt(1);
        cstmt.close();

        return result;
    }
}
