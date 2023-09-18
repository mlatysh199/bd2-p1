package tec.bd2.proyectos.db.entities;

public class ClientEntity implements Entity {

    private int id;
    private String nombre;
    private String fechaUltimaCompra;
    private String correo;
    private String direccion;
    private int cantidadCompras;

    public ClientEntity(int id, String nombre, String fechaUltimaCompra, String correo, String direccion, int cantidadCompras) {
        this.id = id;
        this.nombre = nombre;
        this.fechaUltimaCompra = fechaUltimaCompra;
        this.correo = correo;
        this.direccion = direccion;
        this.cantidadCompras = cantidadCompras;
    }

    public ClientEntity (String nombre, String fechaUltimaCompra, String correo, String direccion, int cantidadCompras) {
        this.nombre = nombre;
        this.fechaUltimaCompra = fechaUltimaCompra;
        this.correo = correo;
        this.direccion = direccion;
        this.cantidadCompras = cantidadCompras;
    }
    
    public int getId() {
        return id;
    }
    public String getNombre() {
        return nombre;
    }
    public String getFechaUltimaCompra() {
        return fechaUltimaCompra;
    }
    public String getCorreo() {
        return correo;
    }
    public String getDireccion() {
        return direccion;
    }
    public int getCantidadCompras() {
        return cantidadCompras;
    }

    public void setId(int id) {
        this.id = id;
    }
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    public void setFechaUltimaCompra(String fechaUltimaCompra) {
        this.fechaUltimaCompra = fechaUltimaCompra;
    }
    public void setCorreo(String correo) {
        this.correo = correo;
    }
    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }
    public void setCantidadCompras(int cantidadCompras) {
        this.cantidadCompras = cantidadCompras;
    }


    
}
