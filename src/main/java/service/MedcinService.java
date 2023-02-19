package service;

import model.Medcin;
import model.Service;
import model.Specialite;
import org.hibernate.Session;
import utils.HibernateUtil;

import java.util.ArrayList;
import java.util.List;

public class MedcinService extends AbstractFacade<Medcin> implements IMedcin {

    private Session session;

    public MedcinService(){
        super(Medcin.class);
        session = HibernateUtil.getSession();
    }


    @Override
    public Session getSession() {
        return session;
    }

    public boolean findService(Service service){
        try{
            session.createQuery("SELECT m FROM Medcin m where m.service = :service" , Medcin.class)
                    .setParameter("service" , service)
                    .getSingleResult();
            return true;
        }catch (Exception e){
            return false;
        }
    }
    public boolean findSpecialite(Specialite specialite) throws Exception {
        List<Medcin> medcinList = findAll();
        List<Specialite> specialiteList = new ArrayList<>();
        boolean result = false;
        for (int i = 0; i < medcinList.size(); i++) {
            specialiteList.add(medcinList.get(i).getSpecialites().get(i));
            if (specialiteList.get(i).getId()== specialite.getId()){
                result =  true;
            }
        }
       return result;
    }
}
