/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.iics.controlpanel.Autoactivityrunsetting;
import com.iics.controlpanel.Services;
import com.iics.service.GenericClassService;
import com.iics.store.Activitycell;
import com.iics.store.Bayrowcell;
import com.iics.store.Stockactivity;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.support.CronSequenceGenerator;
import org.springframework.stereotype.Component;

/**
 *
 * @author IICS
 */
@Component("stocktakingservice")
public class StockTakingService implements Runnable {

    DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    String cronexpression = "";
    String componentname = "stocktakingservice";
    @Autowired
    GenericClassService genericClassService;

    @Override
    public void run() {
        checkforcellstostocktake();
    }

    private void checkforcellstostocktake() {
        try {

            String[] params = {"beanname"};
            Object[] paramsValues = {componentname};
            String[] fields = {"autoactivityrunsettingid", "activityname"};
            List<Object[]> autoactivityrunsettingid = (List<Object[]>) genericClassService.fetchRecord(Autoactivityrunsetting.class, fields, "WHERE beanname=:beanname", params, paramsValues);
            if (autoactivityrunsettingid != null) {
                String[] params1 = {"autoactivityrunsetting"};
                Object[] paramsValues1 = {(Long) autoactivityrunsettingid.get(0)[0]};
                String[] fields1 = {"serviceid", "completed", "startonstartup", "startingtimepattern"};
                List<Object[]> service = (List<Object[]>) genericClassService.fetchRecord(Services.class, fields1, "WHERE autoactivityrunsetting=:autoactivityrunsetting", params1, paramsValues1);
                if (service != null) {
                    try {
                        cronexpression = (String) service.get(0)[3];
                        String[] columns = {"startingtime", "status", "completed", "interrupted"};
                        Object[] columnValues = {new Date(), Boolean.TRUE, Boolean.FALSE, Boolean.FALSE};
                        String pk = "serviceid";
                        Object pkValue = (Integer) service.get(0)[0];
                        int result = genericClassService.updateRecordSQLSchemaStyle(Services.class, columns, columnValues, pk, pkValue, "controlpanel");
                        if (result != 0) {
                            //----------------------PUT YOUR SERVICE CODE HERE --------------------------------------

                            String[] paramss = {"startdate"};
                            Object[] paramsValuess = {new Date()};
                            String[] fieldss = {"stockactivityid", "startdate"};
                            List<Object[]> stocktake = (List<Object[]>) genericClassService.fetchRecord(Stockactivity.class, fieldss, "WHERE startdate=:startdate", paramss, paramsValuess);
                            if (stocktake != null) {
                                for (Object[] stock : stocktake) {
                                    String[] paramsa = {"stockactivityid"};
                                    Object[] paramsValuesa = {stock[0]};
                                    String[] fieldsa = {"cellid.bayrowcellid", "activitycellid"};
                                    List<Object[]> stocktakeactivity = (List<Object[]>) genericClassService.fetchRecord(Activitycell.class, fieldsa, "WHERE stockactivityid=:stockactivityid", paramsa, paramsValuesa);
                                    if (stocktakeactivity != null) {
                                        for (Object[] cellid : stocktakeactivity) {
                                            String[] columnss = {"cellstate"};
                                            Object[] columnValuess = {Boolean.TRUE};
                                            String pks = "bayrowcellid";
                                            Object pkValues = cellid[0];
                                            int results = genericClassService.updateRecordSQLSchemaStyle(Bayrowcell.class, columnss, columnValuess, pks, pkValues, "store");                                            
                                        }
                                    }
                                }
                            }
                            
                            //----------------------PUT YOUR SERVICE CODE HERE --------------------------------------
                            String[] columns1 = {"completed"};
                            Object[] columnValues1 = {Boolean.TRUE};
                            String pk1 = "serviceid";
                            Object pkValue1 = (Integer) service.get(0)[0];
                            int result1 = genericClassService.updateRecordSQLSchemaStyle(Services.class, columns1, columnValues1, pk1, pkValue1, "controlpanel");
                            if (result1 != 0) {

                            }
                        }
                    } catch (Exception e) {
                        String[] columns = {"status", "completed", "interrupted","terminationreason"};
                        Object[] columnValues = {Boolean.FALSE, Boolean.FALSE, Boolean.TRUE,e};
                        String pk = "serviceid";
                        Object pkValue = (Integer) service.get(0)[0];
                        int result = genericClassService.updateRecordSQLSchemaStyle(Services.class, columns, columnValues, pk, pkValue, "controlpanel");

                    } finally {
                        if ((Boolean) service.get(0)[2]) {
                            CronSequenceGenerator generator = new CronSequenceGenerator(cronexpression, TimeZone.getDefault());
                            final Date nextExecutionDate = generator.next(new Date());

                            String[] columns = {"endingtime", "lastruntime", "status", "nextruntime"};
                            Object[] columnValues = {new Date(), new Date(), Boolean.TRUE, nextExecutionDate};
                            String pk = "serviceid";
                            Object pkValue = (Integer) service.get(0)[0];
                            int result = genericClassService.updateRecordSQLSchemaStyle(Services.class, columns, columnValues, pk, pkValue, "controlpanel");

                        } else {
                            String[] columns = {"endingtime", "lastruntime", "status"};
                            Object[] columnValues = {new Date(), new Date(), Boolean.FALSE};
                            String pk = "serviceid";
                            Object pkValue = (Integer) service.get(0)[0];
                            int result = genericClassService.updateRecordSQLSchemaStyle(Services.class, columns, columnValues, pk, pkValue, "controlpanel");
                        }
                    }

                }

            }

        } catch (Exception e) {
            System.out.println("com.iics.web.ProcurementPlanService.activatefacilityfinancialyears():" + e);
        }
    }
}
