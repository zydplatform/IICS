/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.dao.impl;

import com.iics.dao.GenericClassDAO;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
//import javax.persistence.EntityManagerFactory;
//import javax.persistence.PersistenceUnit;
//import javax.persistence.EntityManager;

/**
 *
 * @author gilberto
 */
@Repository("genericClassDAO")
public class GenericClassDAOImpl implements GenericClassDAO {

    @Autowired
    @Qualifier(value = "sessionFactory")
    private SessionFactory sessionFactory;

//    private EntityManagerFactory emf;    
//    
//    @PersistenceUnit
//    public void setEntityManagerFactory(EntityManagerFactory emf) {
//        this.emf = emf;
//    }
    @Override
    @SuppressWarnings("CallToThreadDumpStack")
    public int deleteRecordById(Class clazz, String PK, Integer id) {
        Session session = sessionFactory.openSession();
        try {

            System.out.println("*****" + id);

            Transaction transaction = session.beginTransaction();
            Object deleteObj = session.get(clazz, (int) id);
            session.delete(deleteObj);
            transaction.commit();
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
            session.close();
        }
    }

    @Override
    @SuppressWarnings("CallToThreadDumpStack")
    public int deleteRecordByByColumns(Class clazz, String[] columns, Object[] columnValues) {
        Session session = sessionFactory.openSession();
        try {
            Transaction transaction = session.beginTransaction();
            if ((columns == null && columnValues != null) || (columns != null && columnValues == null)) {
                try {
                    if (columns.length != columnValues.length) {
                        System.out.println("*****************Make sure param size equals paramValues size******************************");
                        return 0;
                    }
                } catch (NullPointerException e) {
                    System.out.println("*****************Make sure param and paramValues are not NULL******************************");
                }

                System.out.println("*****************Make sure both param and paramValues are not null*************************");
                return 0;
            }

            String where = "";
            if (columns.length > 0) {
                where = " " + columns[0].toString().trim() + "=:" + columns[0] + "";
                for (int i = 1; i < columns.length; i++) {
                    where += " AND " + columns[i].toString().trim() + "=:" + columns[i] + "";
                }
            }

            String hql = "DELETE FROM " + extractClassName(clazz.getName()) + " WHERE " + where + " ";
            Query q = session.createSQLQuery(hql);
            if (columns != null && columnValues != null) {
                for (int i = 0; i < columns.length; i++) {
                    q.setParameter(columns[i], columnValues[i]);
                }
            }
            int i = q.executeUpdate();
            transaction.commit();
            return i;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
            session.close();
        }
    }

    @Override
    @SuppressWarnings("CallToThreadDumpStack")
    public int deleteRecordByByColumns(String tablename, String[] columns, Object[] columnValues) {
        Session session = sessionFactory.openSession();
        try {
            Transaction transaction = session.beginTransaction();
            if ((columns == null && columnValues != null) || (columns != null && columnValues == null)) {
                try {
                    if (columns.length != columnValues.length) {
                        System.out.println("*****************Make sure param size equals paramValues size******************************");
                        return 0;
                    }
                } catch (NullPointerException e) {
                    System.out.println("*****************Make sure param and paramValues are not NULL******************************");
                }

                System.out.println("*****************Make sure both param and paramValues are not null*************************");
                return 0;
            }

            String where = "";
            if (columns.length > 0) {
                where = " " + columns[0].toString().trim() + "=:" + columns[0] + "";
                for (int i = 1; i < columns.length; i++) {
                    where += " AND " + columns[i].toString().trim() + "=:" + columns[i] + "";
                }
            }

            String hql = "DELETE FROM " + tablename + " WHERE " + where + " ";
            Query q = session.createSQLQuery(hql);
            if (columns != null && columnValues != null) {
                for (int i = 0; i < columns.length; i++) {
                    q.setParameter(columns[i], columnValues[i]);
                }
            }
            int i = q.executeUpdate();
            transaction.commit();
            return i;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
            session.close();
        }
    }

    @Override
    @SuppressWarnings("CallToThreadDumpStack")
    public int deleteRecord(Object object) {
        Session session = sessionFactory.openSession();
        Transaction transaction = session.beginTransaction();
        try {
            session.delete(object);
            transaction.commit();
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
            session.close();
        }
    }

    @Override
    @SuppressWarnings("CallToThreadDumpStack")
    public List<?> fetchRecordStringEntity(String tablename, String[] fields, String whereClause, String[] params, Object[] paramsValues) {

        if ((params == null && paramsValues != null) || (params != null && paramsValues == null)) {
            try {
                if (params.length != paramsValues.length) {
                    System.out.println("*****************Make sure param size equals paramValues size******************************");
                    return null;
                }
            } catch (NullPointerException e) {
                System.out.println("*****************Make sure param and paramValues are not NULL******************************");
            }

            System.out.println("*****************Make sure both param and paramValues are not null*************************");
            return null;
        }

        Session session = sessionFactory.openSession();
        try {
            String selectFields = "";
            if (fields.length > 0x0) {
                if (tablename.trim() == null || "".equals(tablename.trim())) {
                    selectFields = "SELECT " + fields[0].trim();
                    for (int i = 0x1; i < fields.length; i++) {
                        selectFields += ", " + fields[i].trim();
                    }
                } else {
                    selectFields = "SELECT DISTINCT r." + fields[0].trim();
                    for (int i = 0x1; i < fields.length; i++) {
                        selectFields += ", r." + fields[i].trim();
                    }
                }
            }
            String hql;
            if (tablename.trim() == null || "".equals(tablename.trim())) {
                hql = selectFields;
            } else {
                hql = selectFields + " FROM " + tablename.trim() + " r " + whereClause;
            }
            Query query = session.createSQLQuery(hql);

            if (params != null && paramsValues != null) {
                if (params.length != paramsValues.length) {
                    System.out.println("*****************Make sure both param and paramValues are of same array length*************************");
                    return null;
                }
                for (int i = 0; i < params.length; i++) {
                    if (paramsValues[i] instanceof List) {
                        query.setParameterList(params[i], (List<Object[]>) paramsValues[i]);
                    } else {
                        query.setParameter(params[i], paramsValues[i]);
                    }
                }
            }

            List<Object[]> results = query.list();
            if (results.isEmpty()) {
                return null;
            } else {
                return results;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            session.close();
        }
    }

    @Override
    @SuppressWarnings("CallToThreadDumpStack")
    public List<?> fetchRecord(Class clazz, String[] fields, String whereClause, String[] params, Object[] paramsValues) {

        if ((params == null && paramsValues != null) || (params != null && paramsValues == null)) {
            try {
                if (params.length != paramsValues.length) {
                    System.out.println("*****************Make sure param size equals paramValues size******************************");
                    return null;
                }
            } catch (NullPointerException e) {
                System.out.println("*****************Make sure param and paramValues are not NULL******************************");
            }

            System.out.println("*****************Make sure both param and paramValues are not null*************************");
            return null;
        }

        Session session = sessionFactory.openSession();
        try {
            String selectFields = "";
            if (fields.length > 0x0) {
                selectFields = "SELECT DISTINCT r." + fields[0].toString().trim();
                for (int i = 0x1; i < fields.length; i++) {
                    selectFields += ", r." + fields[i].toString().trim();
                }
            }

            String hql = selectFields + " FROM " + clazz.getName() + " r " + whereClause;
            Query query = session.createQuery(hql);

            if (params != null && paramsValues != null) {
                if (params.length != paramsValues.length) {
                    System.out.println("*****************Make sure both param and paramValues are of same array length*************************");
                    return null;
                }
                for (int i = 0; i < params.length; i++) {
                    if (paramsValues[i] instanceof List) {
                        query.setParameterList(params[i], (List<Object[]>) paramsValues[i]);
                    } else {
                        query.setParameter(params[i], paramsValues[i]);
                    }
                }
            }

            List<Object[]> results = query.list();
            if (results.isEmpty()) {
                return null;
            } else {
                return results;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            session.close();
        }
    }
    //
    @Override
    @SuppressWarnings("CallToThreadDumpStack")
    public List<?> fetchRecord(Class clazz, String[] fields, String whereClause, String[] params, Object[] paramsValues, Boolean useDistinct) {

        if ((params == null && paramsValues != null) || (params != null && paramsValues == null)) {
            try {
                if (params.length != paramsValues.length) {
                    System.out.println("*****************Make sure param size equals paramValues size******************************");
                    return null;
                }
            } catch (NullPointerException e) {
                System.out.println("*****************Make sure param and paramValues are not NULL******************************");
            }

            System.out.println("*****************Make sure both param and paramValues are not null*************************");
            return null;
        }

        Session session = sessionFactory.openSession();
        try {
            String selectFields = "";
            //
            String distinct = (useDistinct) ? "DISTINCT" : "";
            //
            if (fields.length > 0x0) {
                selectFields = "SELECT " + distinct + "r." + fields[0].toString().trim();
                for (int i = 0x1; i < fields.length; i++) {
                    selectFields += ", r." + fields[i].toString().trim();
                }
            }

            String hql = selectFields + " FROM " + clazz.getName() + " r " + whereClause;
            Query query = session.createQuery(hql);

            if (params != null && paramsValues != null) {
                if (params.length != paramsValues.length) {
                    System.out.println("*****************Make sure both param and paramValues are of same array length*************************");
                    return null;
                }
                for (int i = 0; i < params.length; i++) {
                    if (paramsValues[i] instanceof List) {
                        query.setParameterList(params[i], (List<Object[]>) paramsValues[i]);
                    } else {
                        query.setParameter(params[i], paramsValues[i]);
                    }
                }
            }

            List<Object[]> results = query.list();
            if (results.isEmpty()) {
                return null;
            } else {
                return results;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            session.close();
        }
    }
    //   
    
    @Override
    @SuppressWarnings("CallToThreadDumpStack")
    public Object saveOrUpdateRecordLoadObject(Object object) {
        Session session = sessionFactory.openSession();
        try {
            Transaction transaction = session.beginTransaction();
            session.saveOrUpdate(object);
            transaction.commit();

            return object;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            session.close();
        }
    }

    @Override
    @SuppressWarnings("CallToThreadDumpStack")
    public List<Object[]> fetchRecordFunction(Class clazz, String[] fields, String whereClause, String[] params, Object[] paramsValues, int minResult, int maxResult) {

        if ((params == null && paramsValues != null) || (params != null && paramsValues == null)) {
            try {
                if (params.length != paramsValues.length) {
                    System.out.println("*****************Make sure param size equals paramValues size******************************");
                    return null;
                }
            } catch (NullPointerException e) {
                System.out.println("*****************Make sure param and paramValues are not NULL******************************");
            }

            System.out.println("*****************Make sure both param and paramValues are not null*************************");
            return null;
        }

        Session session = sessionFactory.openSession();
        try {
            String selectFields = "";
            if (fields.length > 0x0) {
                selectFields = "SELECT " + fields[0].toString().trim();
                for (int i = 0x1; i < fields.length; i++) {
                    selectFields += ", " + fields[i].toString().trim();
                }
            }

            String hql = selectFields + " FROM " + clazz.getName() + " r " + whereClause;
            Query query = session.createQuery(hql);

            if (params != null && paramsValues != null) {
                for (int i = 0; i < params.length; i++) {
                    query.setParameter(params[i], paramsValues[i]);
                }
            }

            if (maxResult > 0) {
                query.setFirstResult(minResult);
                query.setMaxResults(maxResult);
            }
            List<Object[]> results = query.list();
            if (results.isEmpty()) {
                return null;
            } else {
                return results;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            session.close();
        }
    }

    @Override
    @SuppressWarnings("CallToThreadDumpStack")
    public int updateRecordSQLStyle(Class object, String[] columns, Object[] columnValues, String pk, Object pkid) {
        Session session = sessionFactory.openSession();
//        EntityManager em = emf.createEntityManager();
        try {
            Transaction transaction = session.beginTransaction();
            if ((columns == null && columnValues != null) || (columns != null && columnValues == null)) {
                try {
                    if (columns.length != columnValues.length) {
                        System.out.println("*****************Make sure param size equals paramValues size******************************");
                        return 0;
                    }
                } catch (NullPointerException e) {
                    System.out.println("*****************Make sure param and paramValues are not NULL******************************");
                }

                System.out.println("*****************Make sure both param and paramValues are not null*************************");
                return 0;
            }

            String where = "";
            if (columns.length > 0) {
                where = " " + columns[0].toString().trim() + "=:" + columns[0] + "";
                for (int i = 1; i < columns.length; i++) {
                    where += ", " + columns[i].toString().trim() + "=:" + columns[i] + "";
                }
            }

            String hql = "UPDATE " + object.getSimpleName() + " SET " + where
                    + " WHERE " + pk + "=:" + pk + "";

            System.out.println("#######~~~~~~~~########" + hql);
            Query query = session.createSQLQuery(hql);
//            em.getTransaction().begin();
//            javax.persistence.Query query = em.createQuery(hql);
            query.setParameter(pk, pkid);
            if (columns != null && columnValues != null) {
                for (int i = 0; i < columns.length; i++) {
                    query.setParameter(columns[i], columnValues[i]);
                }
            }
//System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"+query.getQueryString());
//            int result = query.executeUpdate();
            int result = query.executeUpdate();
//            em.getTransaction().commit();
            session.getTransaction().commit();
//            session.close();

            System.out.println("Rows affected: " + result);
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
//            em.close();
//            emf.close();
            session.close();
        }
    }

    @Override
    @SuppressWarnings("CallToThreadDumpStack")
    public int fetchRecordCount(Class clazz, String whereClause, String[] params, Object[] paramsValues) {

        if ((params == null && paramsValues != null) || (params != null && paramsValues == null)) {
            try {
                if (params.length != paramsValues.length) {
                    System.out.println("*****************Make sure param size equals paramValues size******************************");
                    return 0;
                }
            } catch (NullPointerException e) {
                System.out.println("*****************Make sure param and paramValues are not NULL******************************");
            }

            System.out.println("*****************Make sure both param and paramValues are not null*************************");
            return 0;
        }

        Session session = sessionFactory.openSession();
        try {
            String hql = "SELECT COUNT(*) FROM " + clazz.getName() + " r " + whereClause;
            Query query = session.createQuery(hql);

            if (params != null && paramsValues != null) {
                for (int i = 0; i < params.length; i++) {
                    query.setParameter(params[i], paramsValues[i]);
                }
            }

            List<Long> results = query.list();
            if (results.isEmpty()) {
                return 0;
            } else {
                return results.get(0).intValue();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
            session.close();
        }
    }

    @Override
    public int updateRecordSQLStyle(Class object, String[] columns, Object[] columnValues, String[] whereContr, Object[] whereVal, String andOrConstr) {
        Session session = sessionFactory.getCurrentSession();
        try {
            session.beginTransaction();
            if ((columns == null && columnValues != null) || (columns != null && columnValues == null)) {
                try {
                    if (columns.length != columnValues.length) {
                        System.out.println("*****************Make sure param size equals paramValues size******************************");
                        return 0;
                    }
                } catch (NullPointerException e) {
                    System.out.println("*****************Make sure param and paramValues are not NULL******************************");
                }

                System.out.println("*****************Make sure both param and paramValues are not null*************************");
                return 0;
            }

            String where = "";
            if (columns.length > 0) {
                where = " " + columns[0].toString().trim() + "=:" + columns[0] + "";
                for (int i = 1; i < columns.length; i++) {
                    where += ", " + columns[i].toString().trim() + "=:" + columns[i] + "";
                }
            }

            if ((whereContr == null && whereVal != null) || (whereContr != null && whereVal == null)) {
                try {
                    if (whereContr.length != whereVal.length) {
                        System.out.println("*****************Make sure whereContr size equals whereVal size******************************");
                        return 0;
                    }
                } catch (NullPointerException e) {
                    System.out.println("*****************Make sure whereContr and whereVal are not NULL******************************");
                }

                System.out.println("*****************Make sure both whereContr and whereVal are not null*************************");
                return 0;
            }

            if (!(andOrConstr.equalsIgnoreCase("AND") || andOrConstr.equalsIgnoreCase("OR"))) {
                System.out.println("**3***************Last Parameter should be AND or OR*************************");
                return 0;
            }
            String constr = "";
            if (whereContr.length > 0) {
                constr = " " + whereContr[0].toString().trim() + "=:" + whereContr[0] + "";
                for (int i = 1; i < whereContr.length; i++) {
                    constr += " " + andOrConstr.toUpperCase() + " " + whereContr[i].toString().trim() + "=:" + whereContr[i] + "";
                }
            }

            String hql = "UPDATE " + object.getSimpleName() + " SET " + where
                    + " WHERE " + constr + "";

            System.out.println("######XXX#########" + hql);

            Query query = session.createSQLQuery(hql);
            if (columns != null && columnValues != null) {
                for (int i = 0; i < columns.length; i++) {
                    query.setParameter(columns[i], columnValues[i]);
                }
            }

            if (whereContr != null && whereVal != null) {
                for (int i = 0; i < whereContr.length; i++) {
                    query.setParameter(whereContr[i], whereVal[i]);
                }
            }

//            int result = query.executeUpdate();
            session.createQuery(query.getQueryString());
            session.getTransaction().commit();
            session.close();
//            System.out.println("Rows affected: " + result);
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
            session.close();
        }
    }

    @Override
    public int updateRecordSQLStyle(String tablename, String[] columns, Object[] columnValues, String[] whereContr, Object[] whereVal, String andOrConstr) {
        Session session = sessionFactory.openSession();
        try {
            Transaction transaction = session.beginTransaction();
            if ((columns == null && columnValues != null) || (columns != null && columnValues == null)) {
                try {
                    if (columns.length != columnValues.length) {
                        System.out.println("*****************Make sure param size equals paramValues size******************************");
                        return 0;
                    }
                } catch (NullPointerException e) {
                    System.out.println("*****************Make sure param and paramValues are not NULL******************************");
                }

                System.out.println("*****************Make sure both param and paramValues are not null*************************");
                return 0;
            }

            String where = "";
            if (columns.length > 0) {
                where = " " + columns[0].toString().trim() + "=:" + columns[0] + "";
                for (int i = 1; i < columns.length; i++) {
                    where += ", " + columns[i].toString().trim() + "=:" + columns[i] + "";
                }
            }

            if ((whereContr == null && whereVal != null) || (whereContr != null && whereVal == null)) {
                try {
                    if (whereContr.length != whereVal.length) {
                        System.out.println("*****************Make sure whereContr size equals whereVal size******************************");
                        return 0;
                    }
                } catch (NullPointerException e) {
                    System.out.println("*****************Make sure whereContr and whereVal are not NULL******************************");
                }

                System.out.println("*****************Make sure both whereContr and whereVal are not null*************************");
                return 0;
            }

            if (!(andOrConstr.equalsIgnoreCase("AND") || andOrConstr.equalsIgnoreCase("OR"))) {
                System.out.println("**3***************Last Parameter should be AND or OR*************************");
                return 0;
            }
            String constr = "";
            if (whereContr.length > 0) {
                constr = " " + whereContr[0].toString().trim() + "=:" + whereContr[0] + "";
                for (int i = 1; i < whereContr.length; i++) {
                    constr += " " + andOrConstr.toUpperCase() + " " + whereContr[i].toString().trim() + "=:" + whereContr[i] + "";
                }
            }

            String hql = "UPDATE " + tablename.trim() + " SET " + where
                    + " WHERE " + constr + "";

            System.out.println("###############" + hql);

            Query query = session.createSQLQuery(hql);
            if (columns != null && columnValues != null) {
                for (int i = 0; i < columns.length; i++) {
                    query.setParameter(columns[i], columnValues[i]);
                }
            }

            if (whereContr != null && whereVal != null) {
                for (int i = 0; i < whereContr.length; i++) {
                    query.setParameter(whereContr[i], whereVal[i]);
                }
            }

            int result = query.executeUpdate();
            transaction.commit();
            System.out.println("Rows affected: " + result);
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
            session.close();
        }
    }

    private static String extractClassName(String fullname) {
        Pattern p = Pattern.compile(".*?([^.]+)$");
        Matcher m = p.matcher(fullname);

        return (m.find()) ? m.group(1) : "";
    }

    @Override
    public List<?> fetchRecordPaging(Class clazz, String[] fields, String whereClause, String[] params, Object[] paramsValues, Integer offset, Integer maxResults) {
        if ((params == null && paramsValues != null) || (params != null && paramsValues == null)) {
            try {
                if (params.length != paramsValues.length) {
                    System.out.println("*****************Make sure param size equals paramValues size******************************");
                    return null;
                }
            } catch (NullPointerException e) {
                System.out.println("*****************Make sure param and paramValues are not NULL******************************");
            }

            System.out.println("*****************Make sure both param and paramValues are not null*************************");
            return null;
        }

        Session session = sessionFactory.openSession();
        try {
            String selectFields = "";
            if (fields.length > 0x0) {
                selectFields = "SELECT DISTINCT r." + fields[0].toString().trim();
                for (int i = 0x1; i < fields.length; i++) {
                    selectFields += ", r." + fields[i].toString().trim();
                }
            }

            String hql = selectFields + " FROM " + clazz.getName() + " r " + whereClause;
            Query query = session.createQuery(hql);
            query.setFirstResult(offset != null ? offset : 0);
            query.setMaxResults(maxResults != null ? maxResults : 10);

            if (params != null && paramsValues != null) {
                if (params.length != paramsValues.length) {
                    System.out.println("*****************Make sure both param and paramValues are of same array length*************************");
                    return null;
                }
                for (int i = 0; i < params.length; i++) {
                    if (paramsValues[i] instanceof List) {
                        query.setParameterList(params[i], (List<Object[]>) paramsValues[i]);
                    } else {
                        query.setParameter(params[i], paramsValues[i]);
                    }
                }
            }

            List<Object[]> results = query.list();
            if (results.isEmpty()) {
                return null;
            } else {
                return results;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            session.close();
        }
    }

    @Override
    @SuppressWarnings("CallToThreadDumpStack")
    public int updateRecordSQLSchemaStyle(Class object, String[] columns, Object[] columnValues, String pk, Object pkid, String schema) {
        Session session = sessionFactory.openSession();
//        EntityManager em = emf.createEntityManager();
        try {
            Transaction transaction = session.beginTransaction();
            if ((columns == null && columnValues != null) || (columns != null && columnValues == null)) {
                try {
                    if (columns.length != columnValues.length) {
                        System.out.println("*****************Make sure param size equals paramValues size******************************");
                        return 0;
                    }
                } catch (NullPointerException e) {
                    System.out.println("*****************Make sure param and paramValues are not NULL******************************");
                }

                System.out.println("*****************Make sure both param and paramValues are not null*************************");
                return 0;
            }

            String where = "";
            if (columns.length > 0) {
                where = " " + columns[0].toString().trim() + "=:" + columns[0] + "";
                for (int i = 1; i < columns.length; i++) {
                    where += ", " + columns[i].toString().trim() + "=:" + columns[i] + "";
                }
            }

            String hql = "UPDATE " + schema + "." + object.getSimpleName() + " SET " + where
                    + " WHERE " + pk + "=:" + pk + "";

            System.out.println("#######~~~~~~~~########" + hql);
            Query query = session.createSQLQuery(hql);
//            em.getTransaction().begin();
//            javax.persistence.Query query = em.createQuery(hql);
            query.setParameter(pk, pkid);
            if (columns != null && columnValues != null) {
                for (int i = 0; i < columns.length; i++) {
                    query.setParameter(columns[i], columnValues[i]);
                }
            }
//System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"+query.getQueryString());
//            int result = query.executeUpdate();
            int result = query.executeUpdate();
//            em.getTransaction().commit();
            session.getTransaction().commit();
//            session.close();

            System.out.println("Rows affected: " + result);
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
//            em.close();
//            emf.close();
            session.close();
        }
    }

    @Override
    @SuppressWarnings("CallToThreadDumpStack")
    public Object fetchRecordFunction(Class clazz, String whereClause, String[] params, Object[] paramsValues, String function) {

        if ((params == null && paramsValues != null) || (params != null && paramsValues == null)) {
            try {
                if (params.length != paramsValues.length) {
                    System.out.println("*****************Make sure param size equals paramValues size******************************");
                    return null;
                }
            } catch (NullPointerException e) {
                System.out.println("*****************Make sure param and paramValues are not NULL******************************");
            }

            System.out.println("*****************Make sure both param and paramValues are not null*************************");
            return null;
        }

        Session session = sessionFactory.openSession();
        try {
            String hql = "SELECT " + function + " FROM " + clazz.getName() + " r " + whereClause;
            Query query = session.createQuery(hql);
            if (params != null && paramsValues != null) {
                for (int i = 0; i < params.length; i++) {
                    query.setParameter(params[i], paramsValues[i]);
                }
            }

            List<Object> results = query.list();
            if (results.isEmpty()) {
                return 0;
            } else {
                return results.get(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            session.close();
        }
    }

    @Override
    public int deleteRecordBySchemaByColumns(Class clazz, String[] columns, Object[] columnValues, String schema) {

        Session session = sessionFactory.openSession();
        try {
            Transaction transaction = session.beginTransaction();
            if ((columns == null && columnValues != null) || (columns != null && columnValues == null)) {
                try {
                    if (columns.length != columnValues.length) {
                        System.out.println("*****************Make sure param size equals paramValues size******************************");
                        return 0;
                    }
                } catch (NullPointerException e) {
                    System.out.println("*****************Make sure param and paramValues are not NULL******************************");
                }

                System.out.println("*****************Make sure both param and paramValues are not null*************************");
                return 0;
            }

            String where = "";
            if (columns.length > 0) {
                where = " " + columns[0].toString().trim() + "=:" + columns[0] + "";
                for (int i = 1; i < columns.length; i++) {
                    where += " AND " + columns[i].toString().trim() + "=:" + columns[i] + "";
                }
            }

            String hql = "DELETE FROM " + schema + "." + clazz.getSimpleName() + " WHERE " + where + " ";
            Query q = session.createSQLQuery(hql);
            if (columns != null && columnValues != null) {
                for (int i = 0; i < columns.length; i++) {
                    q.setParameter(columns[i], columnValues[i]);
                }
            }
            int i = q.executeUpdate();
            transaction.commit();
            return i;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
            session.close();
        }
    }
}
