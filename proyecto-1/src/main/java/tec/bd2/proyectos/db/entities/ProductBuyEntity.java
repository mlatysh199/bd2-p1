package tec.bd2.proyectos.db.entities;

public class ProductBuyEntity implements Entity {
    
    private int id;

    private int producto_id;

    private int proveedor_id;

    private String fecha;
    
    private int cantidad;

    private int monto;
    
    private String descripcion;

    public ProductBuyEntity(int producto_id, int proveedor_id, String fecha, int cantidad, int monto,
            String descripcion) {
        this.producto_id = producto_id;
        this.proveedor_id = proveedor_id;
        this.fecha = fecha;
        this.cantidad = cantidad;
        this.monto = monto;
        this.descripcion = descripcion;
    }


    public ProductBuyEntity(int id, int producto_id, int proveedor_id, String fecha, int cantidad, int monto,
            String descripcion) {
        this.id = id;
        this.producto_id = producto_id;
        this.proveedor_id = proveedor_id;
        this.fecha = fecha;
        this.cantidad = cantidad;
        this.monto = monto;
        this.descripcion = descripcion;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProducto_id() {
        return producto_id;
    }

    public void setProducto_id(int producto_id) {
        this.producto_id = producto_id;
    }

    public int getProveedor_id() {
        return proveedor_id;
    }

    public void setProveedor_id(int proveedor_id) {
        this.proveedor_id = proveedor_id;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public int getMonto() {
        return monto;
    }

    public void setMonto(int monto) {
        this.monto = monto;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

}
