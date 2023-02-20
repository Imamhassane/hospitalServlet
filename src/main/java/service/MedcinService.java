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

    public boolean findService(Service service) throws Exception {
        boolean result = false;
        if (count() > 0){
            for (Medcin m : findAll()){
                if (m.getService().equals(service)) {
                    result = true;
                    break;
                }
            }
        }
        return result;
    }
    public boolean findSpecialite(Specialite specialite) throws Exception {
        List<Specialite> specialiteList = new ArrayList<>();
        boolean result = false;
        for (Medcin m : findAll()){
            specialiteList.addAll(m.getSpecialites());
        }
        for (Specialite s : specialiteList){
            if (specialite.equals(s)) {
                result = true;
                break;
            }
        }
       return result;
    }
}
