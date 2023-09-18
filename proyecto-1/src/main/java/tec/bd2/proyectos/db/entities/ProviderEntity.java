package tec.bd2.proyectos.db.entities;

public class ProviderEntity implements Entity {
    private int id;
    private String name;
    private String description;
    private String address;

    public ProviderEntity() {
    }

    public ProviderEntity(String name, String description, String address) {
        this.name = name;
        this.description = description;
        this.address = address;
    }

    public ProviderEntity(int id, String name, String description, String address) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.address = address;
    }

    @Override
    public String toString() {
        return "ProviderEntity [address=" + address + ", description=" + description + ", id=" + id + ", name=" + name
                + "]";
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getDescription() { 
        return description;
    }

    public String getAddress() {
        return address;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) { 
        this.name = name;
    }

    public void setAddress(String address) { 
        this.address = address;
    }

    public void setDescription(String description) { 
        this.description = description;
    }
}
