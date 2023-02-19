package service;

import model.Personne;
import model.Service;

import java.util.List;

public interface IFacade<T> {
    public T add(T entity) throws Exception;
    public List<T> findAll() throws Exception;
    public T find(long id) throws Exception;
    public void remove(T entity) throws Exception;
    public long count() throws Exception;
}
