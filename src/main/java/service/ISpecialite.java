package service;

import model.Service;
import model.Specialite;

import java.util.List;

public interface ISpecialite {
    Specialite add(Specialite entity) throws Exception;
    List<Specialite> findAll() throws Exception;
    Specialite find(long id) throws Exception;
    void remove(Specialite entity) throws Exception;
    long count() throws Exception;
    public boolean findService(Service service) throws Exception;
}
