package tec.bd2.proyectos.db.entities;

public class LogEntity implements Entity {

    private int id;
    private String fecha;
    private String descripcion;
    private String usuarioDb;

    public LogEntity(int id, String fecha, String descripcion, String usuarioDb) {
        this.id = id;
        this.fecha = fecha;
        this.descripcion = descripcion;
        this.usuarioDb = usuarioDb;
    }

    public LogEntity (String fecha, String descripcion, String usuarioDb) {
        this.fecha = fecha;
        this.descripcion = descripcion;
        this.usuarioDb = usuarioDb;
    }

    public int getId() {
        return id;
    }
    public String getFecha() {
        return fecha;
    }
    public String getDescripcion() {
        return descripcion;
    }
    public String getUsuarioDb() {
        return usuarioDb;
    }

    public void setId(int id) {
        this.id = id;
    }
    public void setFecha(String fecha) {
        this.fecha = fecha;
    }
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    public void setUsuarioDb(String usuarioDb) {
        this.usuarioDb = usuarioDb;
    }

}
