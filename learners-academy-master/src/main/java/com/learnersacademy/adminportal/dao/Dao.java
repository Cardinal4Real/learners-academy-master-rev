package com.learnersacademy.adminportal.dao;

import org.hibernate.Session;
import org.hibernate.Transaction;

import javax.persistence.criteria.CriteriaQuery;
import java.util.List;

public class Dao<T, S> {

    private final Class<T> type;

    public Dao(Class<T> type) {
        this.type = type;
    }


    public T save(T entity) {
       Session session = DbResource.getSession();
        Transaction tran = session.getTransaction();
        tran.begin();
        session.saveOrUpdate(entity);
        tran.commit();
        return (T) entity;
    }
    public T findOne(S id) {
        Session session = DbResource.getSession();
        return session.find(type, id);
    }
    public List<T> findAll() {
        Session session = DbResource.getSession();
        CriteriaQuery<T> criteria = session.getCriteriaBuilder().createQuery(type);
        criteria.from(type);
        return session.createQuery(criteria).getResultList();
    }
    public void deleteOne(S id) {
        Session session = DbResource.getSession();
        T data = session.find(type, id);
        if(data != null) {
            System.out.println("deleting item with id " + id);
            Transaction transaction = session.beginTransaction();
            session.delete(data);
            transaction.commit();
        }
        else {
            System.out.println("Could not find item with id " + id);
        }
    }
}
