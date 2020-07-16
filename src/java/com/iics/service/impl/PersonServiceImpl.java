/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.service.impl;
import com.iics.dao.PersonDAO;
import com.iics.domain.Person;
import com.iics.service.PersonService;
import com.iics.utils.general.CustomPerson;
import java.util.List;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
   
/**
 *
 * @author samuelwam
 */
@Service("personService")
public class PersonServiceImpl implements PersonService {

    @Autowired
    PersonDAO personDao; 
    protected final Log logger = LogFactory.getLog(getClass());
    
    @Override
    public boolean saveOrUpdatePerson(Person person) {
        return personDao.saveOrUpdatePerson(person);
    }

    @Override
    public boolean deletePerson(long id) {
        return personDao.deletePerson(id);
    }

    @Override
    public List<Person> getAllPersons() {
        return personDao.getAllPersons();
    }

    @Override
    public Person findByPersonId(long id) {
        return personDao.findByPersonId(id);
    }

    @Override
    public List<Person> searchPersonByName(String[] arr) {
        return personDao.searchPersonByName(arr);
    }
   

    
}
