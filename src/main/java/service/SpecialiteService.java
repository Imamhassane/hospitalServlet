package service;

import model.Medcin;
import model.Service;
import model.Specialite;
import org.hibernate.Session;
import utils.HibernateUtil;

public class SpecialiteService  extends AbstractFacade<Specialite> implements  ISpecialite {

    private Session session;

    public SpecialiteService()
    {
        super(Specialite.class);
        session = HibernateUtil.getSession();
    }


    @Override
    public Session getSession() {
        return session;
    }

    public boolean findService(Service service) throws Exception {
        boolean result = false;
        if (count() > 0){
            for (Specialite m : findAll()){
                if (m.getService().equals(service)) {
                    result = true;
                    break;
                }
            }
        }
        return result;
    }
}
