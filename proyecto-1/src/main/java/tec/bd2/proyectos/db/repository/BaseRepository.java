package tec.bd2.proyectos.db.repository;

import tec.bd2.proyectos.db.entities.Entity;

public interface BaseRepository<T extends Entity> {
    public void save(T entity);
    public void update(T entity);
    public void delete(T entity);
    public T findById(int id);
    public Iterable<T> findAll();
}
