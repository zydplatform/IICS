/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.service;

import com.iics.domain.Person;
import com.iics.utils.general.CustomPerson;
import java.util.List;
   
/**
 *
 * @author samuelwam
 */
public interface PersonService {
    
    /**-------------------------------------------------------SAVE METHODS-----------------------------------------------------
     * 
     * @param object: The object to be saved
     */
    public boolean saveOrUpdatePerson(Person person);
   
    /**-------------------------------------------------------DELETE METHODS-----------------------------------------------------
     * 
     * @param id: The id of the object to be deleted
     */
    public boolean deletePerson(long id);
    

    /**-------------------------------------------------------RETURN ALL RECORDS METHODS-----------------------------------------------------
     * 
     * @return all records in the required table
     */
    public List<Person> getAllPersons();
  

    /**
     * 
     * @param id
     * @return returns a single object of the required object type
     */
    public Person findByPersonId(long id);
   
    public List<Person> searchPersonByName(String [] arr);
}
