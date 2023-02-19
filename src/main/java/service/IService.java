package service;

import model.Service;

import java.util.List;

public interface IService {
    Service add(Service entity) throws Exception;
    List<Service> findAll() throws Exception;
    Service find(long id) throws Exception;
    void remove(Service entity) throws Exception;
    long count() throws Exception;
}
