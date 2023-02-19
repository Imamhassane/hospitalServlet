package service;

import model.Personne;
import org.hibernate.Session;
import utils.HibernateUtil;

public class PersonneService extends AbstractFacade<Personne> implements IPersonne {
    private Session session;

    public PersonneService()
    {
        super(Personne.class);
        session = HibernateUtil.getSession();
    }

    @Override
    public Session getSession() {
        return session;
    }

    public Personne findByEmailAndPassword(String email , String password){
        try {
            return session.createQuery("SELECT p FROM Personne p where p.email = :email and p.password = :password" , Personne.class)
                    .setParameter("email", email)
                    .setParameter("password", password)
                    .getSingleResult();
        }catch (Exception e){
            return null;
        }
    }
}