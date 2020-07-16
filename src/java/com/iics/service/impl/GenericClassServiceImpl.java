/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.service.impl;

import com.iics.dao.GenericClassDAO;
import com.iics.service.GenericClassService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author gilberto
 */
@Service("genericClassService") 
public class GenericClassServiceImpl implements GenericClassService {
    
    @Autowired
    GenericClassDAO genericClassDAO;
    
    @Override
    public int deleteRecordById(Class clazz, String PK, Integer id) {
        return genericClassDAO.deleteRecordById(clazz, PK, id);
    }
    
    @Override
    public int deleteRecordByByColumns(Class clazz, String[] columns, Object[] columnValues) {
        return genericClassDAO.deleteRecordByByColumns(clazz, columns, columnValues);
    }
    
    @Override
    public int deleteRecordByByColumns(String tablename, String[] columns, Object[] columnValues) {
        return genericClassDAO.deleteRecordByByColumns(tablename, columns, columnValues);
    }
    
    @Override
    public Object saveOrUpdateRecordLoadObject(Object object) {
        return genericClassDAO.saveOrUpdateRecordLoadObject(object);
    }
    
    @Override
    public int deleteRecord(Object object) {
        return genericClassDAO.deleteRecord(object);
    }
    
    @Override
    public List<?> fetchRecord(Class clazz, String[] fields, String whereClause, String[] params, Object[] paramsValues) {
        return genericClassDAO.fetchRecord(clazz, fields, whereClause, params, paramsValues);
    }
    @Override
    public List<?> fetchRecord(Class clazz, String[] fields, String whereClause, String[] params, Object[] paramsValues, Boolean useDistinct) {
        return genericClassDAO.fetchRecord(clazz, fields, whereClause, params, paramsValues, useDistinct);
    }
    @Override
    public List<Object[]> fetchRecordFunction(Class clazz, String[] fields, String whereClause, String[] params, Object[] paramsValues, int minResult, int maxResult) {
        return genericClassDAO.fetchRecordFunction(clazz, fields, whereClause, params, paramsValues, minResult, maxResult);
    }
    
    @Override
    public int updateRecordSQLStyle(Class object, String[] columns, Object[] columnValues, String pk, Object pkid) {
        return genericClassDAO.updateRecordSQLStyle(object, columns, columnValues, pk, pkid);
    }
    
    @Override
    public int fetchRecordCount(Class clazz, String whereClause, String[] params, Object[] paramsValues) {
        return genericClassDAO.fetchRecordCount(clazz, whereClause, params, paramsValues);
    }
    
    @Override
    public int updateRecordSQLStyle(Class object, String[] columns, Object[] columnValues, String[] whereContr, Object[] whereVal, String andOrConstr) {
        return genericClassDAO.updateRecordSQLStyle(object, columns, columnValues, whereContr, whereVal, andOrConstr);
    }

    @Override
    public int updateRecordSQLStyle(String tablename, String[] columns, Object[] columnValues, String[] whereContr, Object[] whereVal, String andOrConstr) {
        return genericClassDAO.updateRecordSQLStyle(tablename, columns, columnValues, whereContr, whereVal, andOrConstr);
    }        

    @Override
    public List<?> fetchRecordPaging(Class clazz, String[] fields, String whereClause, String[] params, Object[] paramsValues, Integer offset, Integer maxResults) {
        return genericClassDAO.fetchRecordPaging(clazz, fields, whereClause, params, paramsValues, offset, maxResults);
    }
    
    @Override
    public List<?> fetchRecordStringEntity(String tablename, String[] fields, String whereClause, String[] params, Object[] paramsValues){
        return genericClassDAO.fetchRecordStringEntity(tablename, fields, whereClause, params, paramsValues);
    }

    @Override
    public int updateRecordSQLSchemaStyle(Class object, String[] columns, Object[] columnValues, String pk, Object pkid, String schema) {
        return genericClassDAO.updateRecordSQLSchemaStyle(object, columns, columnValues, pk, pkid, schema);
    }
    
    @Override
    public Object fetchRecordFunction(Class clazz, String whereClause, String[] params, Object[] paramsValues, String function) {
        return genericClassDAO.fetchRecordFunction(clazz, whereClause, params, paramsValues, function);
    }
    
    @Override
    public int deleteRecordBySchemaByColumns(Class clazz, String[] columns, Object[] columnValues, String schema) {
        return genericClassDAO.deleteRecordBySchemaByColumns(clazz, columns, columnValues, schema);
    }
}
