package service;

import model.Personne;
import org.hibernate.Session;
import org.hibernate.Transaction;

import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;

public abstract class AbstractFacade<T> implements IFacade<T>{
    private Class<T> entityClass;

    public AbstractFacade(Class<T> entityClass) {
        this.entityClass = entityClass;
    }

    public abstract Session getSession();

    public T add(T entity) throws Exception{
        Transaction t = getSession().getTransaction();
        try {
            List<T> classList = findAll();
            t.begin();
            for (T s : classList){
                if (s.equals(entity)){
                    getSession().update(entity);
                }else {
                    getSession().save(entity);
                }
            }
            t.commit();
            return entity;
        }catch (Exception e){
            t.rollback();
            throw e;
        }
    }

    public void remove(T entity) throws Exception{
        Transaction t = getSession().getTransaction();
        try {
            t.begin();
            getSession().remove(entity);
            t.commit();
        }catch (Exception e){
            t.rollback();
            throw e;
        }
    }

    public T find(long id)  throws Exception{
        return getSession().find(entityClass, id);
    }

    public List<T> findAll()  throws Exception{
        final CriteriaBuilder cb = getSession().getCriteriaBuilder();
        final CriteriaQuery<T> criteria = cb.createQuery(entityClass);
        final Root<T> r = criteria.from(entityClass);
        criteria.select(r);
        final TypedQuery<T> query = getSession().createQuery(criteria);
        return  query.getResultList(); //Empty - but there is data in the table
    }

    public long count()  throws Exception{
        CriteriaBuilder qb = getSession().getCriteriaBuilder();
        CriteriaQuery<Long> cq = qb.createQuery(Long.class);
        cq.select(qb.count(cq.from(entityClass)));
        // cq.where();
        return getSession().createQuery(cq).getSingleResult();
    }


}
