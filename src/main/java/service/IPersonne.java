package service;

import model.Medcin;
import model.Personne;

import java.util.List;

public interface IPersonne {
    Personne add(Personne entity) throws Exception;
    List<Personne> findAll() throws Exception;
    Personne find(long id) throws Exception;
    void remove(Personne entity) throws Exception;
    long count() throws Exception;
    public Personne findByEmailAndPassword(String email , String password);
}
