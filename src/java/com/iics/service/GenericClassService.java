/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.service;

import java.util.List;

/**
 *
 * @author gilberto
 */
public interface GenericClassService {

    public int deleteRecordById(Class clazz, String PK, Integer id);

    public int deleteRecord(Object object);

    public Object saveOrUpdateRecordLoadObject(Object object);

    public List<?> fetchRecord(Class clazz, String[] fields, String whereClause, String[] params, Object[] paramsValues);

    //
    public List<?> fetchRecord(Class clazz, String[] fields, String whereClause, String[] params, Object[] paramsValues, Boolean useDistinct);
    //
    
    public List<Object[]> fetchRecordFunction(Class clazz, String[] fields, String whereClause, String[] params, Object[] paramsValues, int minResult, int maxResult);

    public int updateRecordSQLStyle(Class object, String[] columns, Object[] columnValues, String pk, Object pkid);
    
    public int updateRecordSQLSchemaStyle(Class object, String[] columns, Object [] columnValues, String pk, Object pkid, String schema);

    public int updateRecordSQLStyle(String tablename, String[] columns, Object[] columnValues, String[] whereContr, Object[] whereVal, String andOrConstr);
    
    public List<?> fetchRecordStringEntity(String tablename, String[] fields, String whereClause, String[] params, Object[] paramsValues);
    /**
     * Update a record where constraints equals parsed values
     *
     * @param object class
     * @param columns columns to update
     * @param columnValues update column values
     * @param whereContr update where clause columns
     * @param whereVal update where clause column values
     * @param andOrConstr
     * @return 0 for failure and 1 for success
     */
    public int updateRecordSQLStyle(Class object, String[] columns, Object[] columnValues, String[] whereContr, Object[] whereVal, String andOrConstr);

    public int deleteRecordByByColumns(Class clazz, String[] columns, Object[] columnValues);
    
    public int deleteRecordByByColumns(String tablename, String[] columns, Object[] columnValues);
    
    public int deleteRecordBySchemaByColumns(Class clazz, String[] columns, Object[] columnValues, String schema);

    /**
     * This method returns the number of columns from specified domain class
     *
     * @param clazz (Domain class. e.g. Person.class)
     * @param whereClause (String for where query constraints. note always use r
     * alias. e.g WHERE r.personid=:pID)
     * @param params (This is a String Array of query parameters. e.g. WHERE
     * r.personid=:pID, pID is the query parameter)
     * @param paramsValues (This is an Object array of parameter values. They
     * should be in order of the params)
     * @return (int)size
     */
    public int fetchRecordCount(Class clazz, String whereClause, String[] params, Object[] paramsValues);

    public List<?> fetchRecordPaging(Class clazz, String[] fields, String whereClause, String[] params, Object[] paramsValues, Integer offset, Integer maxResults);
    
    public Object fetchRecordFunction(Class clazz, String whereClause, String[] params, Object[] paramsValues, String function);
}
