package service;

import model.Medcin;
import model.Service;
import model.Specialite;

import java.util.List;

public interface IMedcin {
    Medcin add(Medcin entity) throws Exception;
    List<Medcin> findAll() throws Exception;
    Medcin find(long id) throws Exception;
    void remove(Medcin entity) throws Exception;
    long count() throws Exception;
    public boolean findService(Service service);
    public boolean findSpecialite(Specialite specialite) throws Exception;
}
