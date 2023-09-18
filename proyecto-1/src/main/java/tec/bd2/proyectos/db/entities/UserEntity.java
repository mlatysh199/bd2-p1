package tec.bd2.proyectos.db.entities;

public class UserEntity implements Entity {
    /*
     * CREATE TABLE USUARIO(
    nombre VARCHAR2(50) NOT NULL,
    passhash1 NUMBER(10) NOT NULL,
    passhash2 NUMBER(10) NOT NULL,
    nivel NUMBER(2) NOT NULL,
    CONSTRAINT pk_usuario PRIMARY KEY(nombre)
);
     */

    private String name;
    private int passhash1;
    private int passhash2;
    private int level;

    public UserEntity() {
    }

    public UserEntity(String name, int passhash1, int passhash2, int level) {
        this.name = name;
        this.passhash1 = passhash1;
        this.passhash2 = passhash2;
        this.level = level;
    }

    @Override
    public String toString() {
        return "UserEntity [level=" + level + ", name=" + name + ", passhash1=" + passhash1 + ", passhash2=" + passhash2
                + "]";
    }

    public String getName() {
        return name;
    }

    public int getPasshash1() {
        return passhash1;
    }

    public int getPasshash2() {
        return passhash2;
    }

    public int getLevel() {
        return level;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setPasshash1(int passhash1) {
        this.passhash1 = passhash1;
    }

    public void setPasshash2(int passhash2) {
        this.passhash2 = passhash2;
    }

    public void setLevel(int level) {
        this.level = level;
    }
}
