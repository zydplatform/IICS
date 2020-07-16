/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.dao.impl;

import com.iics.dao.PersonDAO;
import com.iics.domain.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;
import java.util.Iterator;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

/**
 *
 * @author samuelwam
 */
@Repository("personDAO")
public class PersonDAOImpl implements PersonDAO {

    @Autowired
    @Qualifier(value = "sessionFactory")
    private SessionFactory sessionfactory;   
    
    @SuppressWarnings("FieldNameHidesFieldInSuperclass")
    private final Log logger = LogFactory.getLog(getClass());

    @Override
    public boolean saveOrUpdatePerson(Person person) {
        Session session = sessionfactory.openSession();
        try {
            Transaction transaction = session.beginTransaction();
            session.saveOrUpdate(person);
            transaction.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            session.close();
        }
    }

    @Override
    public boolean deletePerson(long id) {
        Session session = sessionfactory.openSession();
        try {
//            String hql = "DELETE FROM Person p WHERE p.personid='"+id+"'";
//            Query qryObj = session.createQuery(hql);
//            int result = qryObj.executeUpdate();
            Transaction transaction = session.beginTransaction();
            Object deleteObj = session.load(Person.class, id);
            session.delete(deleteObj);
            transaction.commit();
            logger.info(String.format("Person " + id + " deleted from the database...r:" + id));
            return true;
        } catch (Exception ex) {
            ex.printStackTrace();
            return false;
        } finally {
            session.close();
        }
    }

    @Override
    public List<Person> getAllPersons() {
        logger.info("Fetching all persons");
        Session session = sessionfactory.openSession();
        try {
            List<Person> returnList = new ArrayList<Person>();
            List<Person> list = new ArrayList<Person>();
            String hql = "SELECT p.personid, p.verified, p.imagepath "
                    + "FROM Person p ORDER BY p.regions, p.district ASC";
            Query qryObj = session.createQuery(hql);
            if (!qryObj.list().isEmpty()) {
                list = qryObj.list();
            }
            if (list.isEmpty()) {
                return null;
            } else {
                if (!list.isEmpty()) {
                    Iterator it = list.iterator();
                    while (it.hasNext()) {
                        Object[] row = (Object[]) it.next();
                        Person p = new Person();
                        p.setPersonid((Long) row[0]);
                        p.setImagepath((String) row[3]);

                        returnList.add(p);
                    }
                }
                return returnList;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        } finally {
            session.close();
        }

    }

    
    @Override
    public Person findByPersonId(long id) {
        Session session = sessionfactory.openSession();
        try {
            logger.info(id+"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#");
            String hql = "FROM Person f WHERE f.personid='" + id + "'";
            Query qryObj = session.createQuery(hql);
            if (!qryObj.list().isEmpty()) {
                return (Person) qryObj.list().get(0);
            } else {
                return null;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        } finally {
            session.close();
        }
    }

    @Override
    public List<Person> searchPersonByName(String[] arr) {
        Session session = sessionfactory.openSession();
        String fname = arr[0].trim().toLowerCase();
        String lname = arr[1].trim().toLowerCase();
        String oname = arr[2].trim().toLowerCase();
        
        try {
            List<Person> list = new ArrayList<Person>();
            List<Person> persons = new ArrayList<Person>();

            String qry = "SELECT "
                    + "s.personid, s.firstname, s.othername, s.lastname, "
                    + "s.dob, s.gender, s.imagepath, s.verified, s.personname "
                    + "FROM Person s where  ";

            
            String cond = "";
            if (!fname.equalsIgnoreCase("")) {
                if (cond.equalsIgnoreCase("")) {
                    cond = " (lower(s.firstname) LIKE '"+fname+"%' OR lower(s.lastname) LIKE '"+fname+"%' OR lower(s.othername) LIKE '"+fname+"%') ";
                }else{
                    cond = cond + " AND " + "(lower(s.firstname) LIKE '"+fname+"%' OR lower(s.lastname) LIKE '"+fname+"%' OR lower(s.othername) LIKE '"+fname+"%')  AND s.firstname IS NOT NULL ";
                }
            }
            
            if (!lname.equalsIgnoreCase("")) {
                if (cond.equalsIgnoreCase("")) {
                    cond = " (lower(s.firstname) LIKE '"+lname+"%' OR lower(s.lastname) LIKE '"+lname+"%' OR lower(s.othername) LIKE '"+lname+"%') ";
                }else{
                    cond = cond + " AND " + " (lower(s.firstname) LIKE '"+lname+"%' OR lower(s.lastname) LIKE '"+lname+"%' OR lower(s.othername) LIKE '"+lname+"%') AND s.lastname IS NOT NULL  ";
                }
            }
            
            if (!oname.equalsIgnoreCase("")) {
                if (cond.equalsIgnoreCase("")) {
                    cond = " (lower(s.firstname) LIKE '"+oname+"%' OR lower(s.lastname) LIKE '"+oname+"%' OR lower(s.othername) LIKE '"+oname+"%') ";
                }else{
                    cond = cond + " AND " + " (lower(s.firstname) LIKE '"+oname+"%' OR lower(s.lastname) LIKE '"+oname+"%' OR lower(s.othername) LIKE '"+oname+"%') AND s.othername IS NOT NULL ";
                }
            }
            
             
             System.out.println("@@@@@@@@@@@@@@@@@@@@@: \n"+cond);
             qry = qry + cond;
             Query qryObj = session.createQuery(qry);
                if (!qryObj.list().isEmpty()) {
                    list = qryObj.list();
                }
            //List<Person> personList = hibernateTemplate.find(qry);

            if (list.isEmpty()) {
                return null;
            } else {
                Iterator it = list.iterator();
                while (it.hasNext()) {
                    Object[] row = (Object[]) it.next();
                    Person sperson = new Person();
                    sperson.setPersonid((Long) row[0]);
                    sperson.setFirstname((String) row[1]);
                    sperson.setOthernames((String) row[2]);
                    sperson.setLastname((String) row[3]);
                    sperson.setDob((Date) row[4]);
                    sperson.setGender((String) row[5]);
                    Date d = new Date();
                    if(row[4]!=null){
                        int age = d.getYear() - sperson.getDob().getYear();
                        if (d.getMonth() < sperson.getDob().getMonth()) {
                            --age;
                            if (age < 1) {
                                age = 0;
                            }
                        }
//                        sperson.setEstimatedage(age);
                    }
                    sperson.setImagepath((String) row[6]);
                    persons.add(sperson);
                }
                return persons;
            }
        }catch (Exception ex) {
            ex.printStackTrace();
            return null;
        } finally {
            session.close();
        }
    }

    
}
