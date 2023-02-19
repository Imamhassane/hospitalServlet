package service;

import model.Service;
import org.hibernate.Session;
import utils.HibernateUtil;

public class ServiceService extends AbstractFacade<Service> implements IService {
    private Session session;

    public ServiceService()
    {
        super(Service.class);
        session = HibernateUtil.getSession();
    }

    @Override
    public Session getSession() {
        return session;
    }

}