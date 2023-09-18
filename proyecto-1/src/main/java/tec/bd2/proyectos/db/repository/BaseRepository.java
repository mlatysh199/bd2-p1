package tec.bd2.proyectos.db.repository;

import java.sql.SQLException;
import java.util.List;

import tec.bd2.proyectos.db.entities.Entity;

public interface BaseRepository<T extends Entity> {
    public void save(T entity) throws SQLException;
    public void update(T entity) throws SQLException;
    public void delete(int id) throws SQLException;
    public T findById(int id) throws SQLException;
    public List<T> findAll() throws SQLException;
}
