/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.iics.controlpanel.Autoactivityrunsetting;
import com.iics.controlpanel.Services;
import com.iics.domain.Ctrycurrency;
import com.iics.service.GenericClassService;
import com.iics.store.Activitycell;
import com.iics.store.Bayrowcell;
import com.iics.store.Shelflog;
import com.iics.store.Stockactivity;
import com.iics.store.Unitstoragezones;
import static com.iics.web.ManageCurrenciesService.logger;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TimeZone;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.support.CronSequenceGenerator;
import org.springframework.stereotype.Component;

/**
 *
 * @author user
 */
@Component("GetcellstolockwithLimitService")
public class GetcellstolockwithLimitService implements Runnable {

    protected static Log logger = LogFactory.getLog("controller");
    DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat formatterx = new SimpleDateFormat("yyyy-MM-dd");
    String cronexpression = "";
    String componentname = "GetcellstolockwithLimitService";
    @Autowired
    GenericClassService genericClassService;

    @Override
    public void run() {
        GetcellstolockwithLimitService();
    }

    private void GetcellstolockwithLimitService() {
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
                            ///////////////////////-------------START-------------------/////////////////////
                            System.out.println("--------LOCKING----CELLS---------");
                            List<Map> typeCellObjList = new ArrayList<>();
                            Map<String, Object> typeCellObjMap;
                            Set<Integer> cells2lock = new HashSet<>();
                            String[] paramsx = {"out", "tra"};
                            Object[] paramsValuesx = {"OUT", "TRA"};
                            String[] fieldsx = {"r.cellid.bayrowcellid", "count(r.cellid.bayrowcellid)"};
                            String wherex = "WHERE (CAST(datelogged AS DATE)=DATE 'now') AND (logtype=:out OR logtype=:tra) GROUP BY r.cellid.bayrowcellid";
                            List<Object[]> typeCellObj = (List<Object[]>) genericClassService.fetchRecordFunction(Shelflog.class, fieldsx, wherex, paramsx, paramsValuesx, 0, 0);
                            if (typeCellObj != null) {
                                for (Object[] n : typeCellObj) {
                                    typeCellObjMap = new HashMap();
                                    typeCellObjMap.put("cellid", n[0]);
                                    typeCellObjMap.put("transCount", n[1]);
                                    typeCellObjList.add(typeCellObjMap);
                                }
                            }
                            String msg = "";
                            BigInteger facUnitid = null;
                            if (!typeCellObjList.isEmpty()) {
                                for (Map x : typeCellObjList) {
                                    int cellID = Integer.parseInt(x.get("cellid").toString());
                                    int itemcount = Integer.parseInt(x.get("transCount").toString());
                                    String[] params3 = {"bayrowcellid", "cellstate"};
                                    Object[] paramsValues3 = {cellID, Boolean.FALSE};
                                    String[] fields3 = {"bayrowcellid", "celllabel", "celltranslimit", "cellstate", "facilityunitid"};
                                    String where3 = "WHERE bayrowcellid=:bayrowcellid AND cellstate=:cellstate ";
                                    List<Object[]> spacetypeObj = (List<Object[]>) genericClassService.fetchRecord(Unitstoragezones.class, fields3, where3, params3, paramsValues3);
                                    if (spacetypeObj != null) {
                                        for (Object[] n : spacetypeObj) {
                                            System.out.println("~~~~~~~~~~~~" + n[0] + "~~~~~~~~~~~~~" + n[1] + "~~~~~~~~~~~" + n[2] + "~~~~~~~" + n[3] + "~~~~~~" + n[4]);
                                            int celltrLmt = Integer.parseInt(n[2].toString());
                                            if (itemcount >= celltrLmt) {
                                                facUnitid = BigInteger.valueOf(Long.parseLong(n[4].toString()));
                                                if (!cells2lock.contains((int) n[0])) {
                                                    cells2lock.add((int) n[0]);
                                                }
                                                String[] columnslev = {"cellstate"};
                                                Object[] columnValueslev = {Boolean.TRUE};
                                                String levelPrimaryKey = "bayrowcellid";
                                                Object levelPkValue = cellID;
                                                genericClassService.updateRecordSQLSchemaStyle(Bayrowcell.class, columnslev, columnValueslev, levelPrimaryKey, levelPkValue, "store");

                                            }
                                        }
                                    }
                                }
                            }

                            if (!cells2lock.isEmpty() && facUnitid != null) {
                                System.out.println("~~~~~~~~~~~~SET DATA~~~~~~~~~~~~~" + cells2lock);
                                System.out.println("~~~~~~~~~~~~FAC ID~~~~~~~~~~~~~" + facUnitid);
                                try {
                                    Stockactivity stockactive = new Stockactivity();
                                    String activeName = "AUTO-[" + formatterx.format(new Date()) + "]";
                                    stockactive.setActivityname(activeName);

                                    String start = formatterx.format(new Date());
                                    String end = formatterx.format(new Date());

                                    Calendar cal_Start = Calendar.getInstance();
                                    cal_Start.setTime(formatterx.parse(start));
                                    cal_Start.add(Calendar.DATE, 1);
                                    start = formatterx.format(cal_Start.getTime());

                                    Calendar cal_End = Calendar.getInstance();
                                    cal_End.setTime(formatterx.parse(end));
                                    cal_End.add(Calendar.DATE, 1);
                                    end = formatterx.format(cal_End.getTime());

                                    String today = formatterx.format(new Date());
                                    stockactive.setStartdate(formatterx.parse(start));
                                    stockactive.setEnddate(formatterx.parse(end));
                                    stockactive.setDateadded(formatterx.parse(today));
                                    stockactive.setFacilityunitid(facUnitid);
                                    stockactive.setDateupdated(formatterx.parse(today));
                                    Object saved = genericClassService.saveOrUpdateRecordLoadObject(stockactive);
                                    if (saved != null) {
                                        long stockactiveID = stockactive.getStockactivityid();
                                        String today2 = formatterx.format(new Date());
                                        for (Integer x : cells2lock) {
                                            Activitycell savelockedcells = new Activitycell();
                                            savelockedcells.setCellid(new Bayrowcell(x));
                                            savelockedcells.setDateadded(formatterx.parse(today2));
                                            savelockedcells.setStockactivityid(new Stockactivity(stockactiveID));
                                            savelockedcells.setActivitystatus("PENDING");
                                            savelockedcells.setDateupdated(formatterx.parse(today2));
                                            genericClassService.saveOrUpdateRecordLoadObject(savelockedcells);
                                        }
                                    }
                                } catch (ParseException ex) {
                                    System.out.println(ex);
                                }
                            }
                            ////////////////////-------------END-------------------/////////////////////
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

        }
    }
}
