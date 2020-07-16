/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.iics.controlpanel.Autoactivityrunsetting;
import com.iics.controlpanel.Services;
import com.iics.service.GenericClassService;
import com.iics.store.Facilityfinancialyear;
import com.iics.store.Facilityprocurementplan;
import com.iics.store.Facilityunitfinancialyear;
import com.iics.store.Facilityunitprocurementplan;
import com.iics.store.Item;
import com.iics.store.Orderperiod;
import com.iics.store.Supplieritem;
import java.text.DateFormat;
import java.text.ParseException;
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
@Component("procurementplanscheduleservice")
public class ProcurementPlanService implements Runnable {

    DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    String cronexpression = "";
    String componentname = "procurementplanscheduleservice";
    @Autowired
    GenericClassService genericClassService;

    @Override
    public void run() {
        activatefacilityfinancialyears();
    }

    private void activatefacilityfinancialyears() {
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

                            consolidatefacilityunitsproc();
                            activatefinancialyear();
                            activatefinancialyearorderperiod();

                            //----------------------PUT YOUR SERVICE CODE HERE --------------------------------------
                            System.out.println("com.iics.web.ProcurementPlanService.activatefinancialyears()");

                            String[] columns1 = {"completed"};
                            Object[] columnValues1 = {Boolean.TRUE};
                            String pk1 = "serviceid";
                            Object pkValue1 = (Integer) service.get(0)[0];
                            int result1 = genericClassService.updateRecordSQLSchemaStyle(Services.class, columns1, columnValues1, pk1, pkValue1, "controlpanel");
                            if (result1 != 0) {

                            }
                        }
                    } catch (Exception e) {
                        String[] columns = {"status", "completed", "interrupted", "terminationreason"};
                        Object[] columnValues = {Boolean.FALSE, Boolean.FALSE, Boolean.TRUE, e};
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

    public void activatefinancialyear() {
        Date today = new Date();
        try {
            String[] params = {};
            Object[] paramsValues = {};
            String[] fields = {"facilityfinancialyearid", "financialyearstartdate", "financialyearenddate", "procuringopendate", "procuringclosedate", "approvalopendate", "approvalclosedate", "orderperiodtype"};
            List<Object[]> financialyrs = (List<Object[]>) genericClassService.fetchRecord(Facilityfinancialyear.class, fields, "", params, paramsValues);
            if (financialyrs != null) {
                for (Object[] financialyr : financialyrs) {
                    if (formatter.parse(formatter.format(today)).getTime() == ((Date) financialyr[1]).getTime()) {
                        String[] columns = {"status"};
                        Object[] columnValues = {true};
                        String pk = "facilityfinancialyearid";
                        Object pkValue = (Long) financialyr[0];
                        int result = genericClassService.updateRecordSQLSchemaStyle(Facilityfinancialyear.class, columns, columnValues, pk, pkValue, "store");
                    } else if (formatter.parse(formatter.format(today)).getTime() == ((Date) financialyr[2]).getTime()) {
                        String[] columns = {"status"};
                        Object[] columnValues = {false};
                        String pk = "facilityfinancialyearid";
                        Object pkValue = (Long) financialyr[0];
                        int result = genericClassService.updateRecordSQLSchemaStyle(Facilityfinancialyear.class, columns, columnValues, pk, pkValue, "store");
                    } else if (formatter.parse(formatter.format(today)).getTime() == ((Date) financialyr[3]).getTime()) {
                        String[] columns = {"isthecurrent"};
                        Object[] columnValues = {true};
                        String pk = "facilityfinancialyearid";
                        Object pkValue = (Long) financialyr[0];
                        int result = genericClassService.updateRecordSQLSchemaStyle(Facilityfinancialyear.class, columns, columnValues, pk, pkValue, "store");
                        if (result != 0) {
                            if ("Annually".equals((String) financialyr[7])) {
                                String[] params1 = {"facilityfinancialyearid"};
                                Object[] paramsValues1 = {(Long) financialyr[0]};
                                String[] fields1 = {"orderperiodid"};
                                List<Integer> financialyrs1 = (List<Integer>) genericClassService.fetchRecord(Orderperiod.class, fields1, "WHERE facilityfinancialyearid=:facilityfinancialyearid", params1, paramsValues1);
                                if (financialyrs1 != null) {
                                    String[] columns1 = {"setascurrent"};
                                    Object[] columnValues1 = {true};
                                    String pk1 = "orderperiodid";
                                    Object pkValue1 = financialyrs1.get(0);
                                    int result1 = genericClassService.updateRecordSQLSchemaStyle(Orderperiod.class, columns1, columnValues1, pk1, pkValue1, "store");

                                }
                            }
                        }
                    } else if (formatter.parse(formatter.format(today)).getTime() == ((Date) financialyr[4]).getTime()) {
                        String[] columns = {"isthecurrent"};
                        Object[] columnValues = {false};
                        String pk = "facilityfinancialyearid";
                        Object pkValue = (Long) financialyr[0];
                        int result = genericClassService.updateRecordSQLSchemaStyle(Facilityfinancialyear.class, columns, columnValues, pk, pkValue, "store");
                        if (result != 0) {
                            if ("Annually".equals((String) financialyr[7])) {
                                String[] params1 = {"facilityfinancialyearid"};
                                Object[] paramsValues1 = {(Long) financialyr[0]};
                                String[] fields1 = {"orderperiodid"};
                                List<Integer> financialyrs1 = (List<Integer>) genericClassService.fetchRecord(Orderperiod.class, fields1, "WHERE facilityfinancialyearid=:facilityfinancialyearid", params1, paramsValues1);
                                if (financialyrs1 != null) {
                                    String[] columns1 = {"setascurrent"};
                                    Object[] columnValues1 = {false};
                                    String pk1 = "orderperiodid";
                                    Object pkValue1 = financialyrs1.get(0);
                                    int result1 = genericClassService.updateRecordSQLSchemaStyle(Orderperiod.class, columns1, columnValues1, pk1, pkValue1, "store");

                                }
                            }
                        }
                    } else if (formatter.parse(formatter.format(today)).getTime() == ((Date) financialyr[5]).getTime()) {

                    } else if (formatter.parse(formatter.format(today)).getTime() == ((Date) financialyr[6]).getTime()) {

                    }
                }
            }
        } catch (ParseException e) {
            System.out.println("com.iics.web.ProcurementPlanActivation.activatefinancialyear()11111");
        }
    }

    public void activatefinancialyearorderperiod() {
        Date today = new Date();
        try {
            String[] params = {"orderperiodtype"};
            Object[] paramsValues = {"Quarterly"};
            String[] fields = {"orderperiodid", "startdate", "enddate"};
            List<Object[]> orderperiod = (List<Object[]>) genericClassService.fetchRecord(Orderperiod.class, fields, "WHERE orderperiodtype=:orderperiodtype", params, paramsValues);
            if (orderperiod != null) {
                for (Object[] orderper : orderperiod) {
                    if (formatter.parse(formatter.format(today)).getTime() == ((Date) orderper[1]).getTime()) {
                        String[] columns1 = {"setascurrent"};
                        Object[] columnValues1 = {true};
                        String pk1 = "orderperiodid";
                        Object pkValue1 = (int) orderper[0];
                        int result1 = genericClassService.updateRecordSQLSchemaStyle(Orderperiod.class, columns1, columnValues1, pk1, pkValue1, "store");
                    } else if (formatter.parse(formatter.format(today)).getTime() == ((Date) orderper[3]).getTime()) {
                        String[] columns1 = {"setascurrent"};
                        Object[] columnValues1 = {false};
                        String pk1 = "orderperiodid";
                        Object pkValue1 = (int) orderper[0];
                        int result1 = genericClassService.updateRecordSQLSchemaStyle(Orderperiod.class, columns1, columnValues1, pk1, pkValue1, "store");
                    }
                }
            }
        } catch (ParseException e) {
            System.out.println("com.iics.web.ProcurementPlanActivation.activatefinancialyear()22222");
        }
    }

    public void consolidatefacilityunitsproc() {
        String response = "";
        Date today = new Date();
        try {
            String[] params = {};
            Object[] paramsValues = {};
            String[] fields = {"facilityfinancialyearid", "procuringclosedate", "orderperiodtype", "istopdownapproach"};
            List<Object[]> financialyrs = (List<Object[]>) genericClassService.fetchRecord(Facilityfinancialyear.class, fields, "", params, paramsValues);
            if (financialyrs != null) {
                for (Object[] financialyr : financialyrs) {
                    if (formatter.parse(formatter.format(today)).getTime() == ((Date) financialyr[1]).getTime()) {
                        if ("Annually".equals((String) financialyr[2])) {
                            if (((Boolean) financialyr[3]) == false) {
                                String[] params1 = {"facilityfinancialyearid", "proccessingstage", "consolidated"};
                                Object[] paramsValues1 = {(Long) financialyr[0], "approved", Boolean.FALSE};
                                String[] fields1 = {"facilityunitfinancialyearid", "orderperiodid"};
                                List<Object[]> facilityunitsproc = (List<Object[]>) genericClassService.fetchRecord(Facilityunitfinancialyear.class, fields1, "WHERE facilityfinancialyearid=:facilityfinancialyearid AND proccessingstage=:proccessingstage AND consolidated=:consolidated", params1, paramsValues1);
                                if (facilityunitsproc != null) {
                                    for (Object[] facilityunits : facilityunitsproc) {
                                        String[] params4 = {"approved", "facilityunitfinancialyearid"};
                                        Object[] paramsValues4 = {Boolean.TRUE, (Integer) facilityunits[0]};
                                        String[] fields4 = {"itemid", "averagemonthlyconsumption", "averagequarterconsumption", "averageannualcomsumption"};
                                        List<Object[]> unitItems = (List<Object[]>) genericClassService.fetchRecord(Facilityunitprocurementplan.class, fields4, "WHERE approved=:approved AND facilityunitfinancialyearid=:facilityunitfinancialyearid", params4, paramsValues4);
                                        if (unitItems != null) {

                                            for (Object[] itemn : unitItems) {
                                                String[] params6 = {"itemid", "orderperiodid"};
                                                Object[] paramsValues6 = {(Long) itemn[0], (Integer) facilityunits[1]};
                                                String[] fields6 = {"facilityprocurementplanid", "averagemonthconsumption", "averageannualconsumption", "averagequarterconsumption"};
                                                List<Object[]> totalitemvale = (List<Object[]>) genericClassService.fetchRecord(Facilityprocurementplan.class, fields6, "WHERE itemid=:itemid AND orderperiodid=:orderperiodid", params6, paramsValues6);
                                                if (totalitemvale != null) {
                                                    if ("Quarterly".equals((String) financialyr[2])) {
                                                        String[] columns = {"averagequarterconsumption", "averagemonthconsumption"};
                                                        Object[] columnValues = {((Double) totalitemvale.get(0)[3]) + ((Double) itemn[2]), ((Double) totalitemvale.get(0)[1]) + ((Double) itemn[1])};
                                                        String pk = "facilityprocurementplanid";
                                                        Object pkValue = totalitemvale.get(0)[0];
                                                        int result = genericClassService.updateRecordSQLSchemaStyle(Facilityprocurementplan.class, columns, columnValues, pk, pkValue, "store");
                                                        if (result != 0) {
                                                            response = "success";
                                                        }
                                                    } else {
                                                        String[] columns = {"averageannualconsumption", "averagemonthconsumption"};
                                                        Object[] columnValues = {((Double) totalitemvale.get(0)[2]) + ((Double) itemn[3]), ((Double) totalitemvale.get(0)[1]) + ((Double) itemn[1])};
                                                        String pk = "facilityprocurementplanid";
                                                        Object pkValue = totalitemvale.get(0)[0];
                                                        int result = genericClassService.updateRecordSQLSchemaStyle(Facilityprocurementplan.class, columns, columnValues, pk, pkValue, "store");
                                                        if (result != 0) {
                                                            response = "success";
                                                        }
                                                    }
                                                } else {
                                                    Facilityprocurementplan facilityprocurementplan = new Facilityprocurementplan();
                                                    facilityprocurementplan.setDateadded(new Date());
                                                    facilityprocurementplan.setAveragemonthconsumption((Double) itemn[1]);
                                                    if ("Quarterly".equals((String) financialyr[2])) {
                                                        facilityprocurementplan.setAveragequarterconsumption((Double) itemn[2]);
                                                    } else {
                                                        facilityprocurementplan.setAverageannualconsumption((Double) itemn[3]);
                                                    }
                                                    facilityprocurementplan.setItemid(new Item((Long) itemn[0]));
                                                    facilityprocurementplan.setOrderperiodid(new Orderperiod((Integer) facilityunits[1]));
                                                    genericClassService.saveOrUpdateRecordLoadObject(facilityprocurementplan);
                                                }
                                            }
                                            String[] columns = {"consolidated"};
                                            Object[] columnValues = {true};
                                            String pk = "facilityunitfinancialyearid";
                                            Object pkValue = (int) facilityunits[0];
                                            int result = genericClassService.updateRecordSQLSchemaStyle(Facilityunitfinancialyear.class, columns, columnValues, pk, pkValue, "store");
                                            if (result != 0) {
                                                response = "success";
                                            }
                                        }
                                    }

                                    String[] params9 = {"orderperiodid"};
                                    Object[] paramsValues9 = {(Integer) facilityunitsproc.get(0)[1]};
                                    String[] fields9 = {"facilityprocurementplanid", "averagemonthconsumption"};
                                    List<Object[]> orderperiod9 = (List<Object[]>) genericClassService.fetchRecord(Facilityprocurementplan.class, fields9, "WHERE orderperiodid=:orderperiodid", params9, paramsValues9);
                                    if (orderperiod9 != null) {
                                        String[] columns = {"proccessstage"};
                                        Object[] columnValues = {"consolidated"};
                                        String pk = "facilityfinancialyearid";
                                        Object pkValue = (Long) financialyr[0];
                                        int result = genericClassService.updateRecordSQLSchemaStyle(Facilityfinancialyear.class, columns, columnValues, pk, pkValue, "store");
                                        String[] columns1 = {"procured"};
                                        Object[] columnValues1 = {Boolean.TRUE};
                                        String pk1 = "orderperiodid";
                                        Object pkValue1 = (Integer) facilityunitsproc.get(0)[1];
                                        int result1 = genericClassService.updateRecordSQLSchemaStyle(Orderperiod.class, columns1, columnValues1, pk1, pkValue1, "store");
                                    }
                                }
                            } else {
                                String[] params9 = {"facilityfinancialyearid", "setascurrent"};
                                Object[] paramsValues9 = {(Long) financialyr[0], Boolean.TRUE};
                                String[] fields9 = {"orderperiodid", "orderperiodtype"};
                                List<Object[]> orderperiod9 = (List<Object[]>) genericClassService.fetchRecord(Orderperiod.class, fields9, "WHERE facilityfinancialyearid=:facilityfinancialyearid AND setascurrent=:setascurrent", params9, paramsValues9);
                                if (orderperiod9 != null) {
                                    for (Object[] orderperiods : orderperiod9) {

                                        String[] columns = {"proccessstage"};
                                        Object[] columnValues = {"consolidated"};
                                        String pk = "facilityfinancialyearid";
                                        Object pkValue = (Long) financialyr[0];
                                        int result = genericClassService.updateRecordSQLSchemaStyle(Facilityfinancialyear.class, columns, columnValues, pk, pkValue, "store");

                                        String[] columns1 = {"procured"};
                                        Object[] columnValues1 = {Boolean.TRUE};
                                        String pk1 = "orderperiodid";
                                        Object pkValue1 = orderperiods[0];
                                        int result1 = genericClassService.updateRecordSQLSchemaStyle(Orderperiod.class, columns1, columnValues1, pk1, pkValue1, "store");

                                        String[] params10 = {"orderperiodid"};
                                        Object[] paramsValues10 = {orderperiods[0]};
                                        String[] fields10 = {"facilityprocurementplanid", "averageannualconsumption", "itemid.itemid"};
                                        List<Object[]> procurementplanitems = (List<Object[]>) genericClassService.fetchRecord(Facilityprocurementplan.class, fields10, "WHERE orderperiodid=:orderperiodid", params10, paramsValues10);
                                        if (procurementplanitems != null) {

                                            for (Object[] procurementplanitem : procurementplanitems) {
                                                String[] params11 = {"itemid"};
                                                Object[] paramsValues11 = {procurementplanitem[2]};
                                                String[] fields11 = {"packsize", "itemcost"};
                                                List<Object[]> supplieritems = (List<Object[]>) genericClassService.fetchRecord(Supplieritem.class, fields11, "WHERE itemid=:itemid", params11, paramsValues11);
                                                if (supplieritems != null) {

                                                    String[] columns5 = {"pack", "unitcost"};
                                                    Object[] columnValues5 = {supplieritems.get(0)[0], supplieritems.get(0)[1]};
                                                    String pk5 = "facilityprocurementplanid";
                                                    Object pkValue5 = (Long) procurementplanitem[0];
                                                    int result5 = genericClassService.updateRecordSQLSchemaStyle(Facilityprocurementplan.class, columns5, columnValues5, pk5, pkValue5, "store");

                                                }
                                            }
                                        }

                                    }
                                }
                            }

                        }
                    }
                }
            }
        } catch (ParseException e) {
            System.out.println("com.iics.web.SyncWorker.consolidatefacilityunitsproc() ererererererer");
        }
    }
}
