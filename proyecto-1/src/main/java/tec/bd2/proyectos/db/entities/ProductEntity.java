package tec.bd2.proyectos.db.entities;

public class ProductEntity implements Entity {
    
    private int id;
    
    private String nombre;

    private String descripcion;

    private int precio;

    private String categoria;

    private int inventario;

    public ProductEntity( String nombre, String descripcion, int precio, String categoria, int inventario) {
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.precio = precio;
        this.categoria = categoria;
        this.inventario = inventario;
    }

    public ProductEntity(int id, String nombre, String descripcion, int precio, String categoria, int inventario) {
        this.id = id;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.precio = precio;
        this.categoria = categoria;
        this.inventario = inventario;
    }


    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public int getPrecio() {
        return precio;
    }
    public void setPrecio(int precio) {
        this.precio = precio;
    }

    public String getCategoria() {
        return categoria;
    }
    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public int getInventario() {
        return inventario;
    }
    public void setInventario(int inventario) {
        this.inventario = inventario;
    }

}
