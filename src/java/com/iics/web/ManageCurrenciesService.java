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
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.support.CronSequenceGenerator;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

/**
 *
 * @author IICS
 */
//@Service
@Component("managecurrenciesservice")
public class ManageCurrenciesService implements Runnable {

    protected static Log logger = LogFactory.getLog("controller");
    DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    String cronexpression = "";
    String componentname = "managecurrenciesservice";
    @Autowired
    GenericClassService genericClassService;

    @Override
    public void run() {
        getcurrencyupdates();
    }

    private void getcurrencyupdates() {
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

                            String url = "https://openexchangerates.org/api/latest.json?app_id=1bf7d3c4b54f44a282d01b92c663de6f";
                            URL jsonObj = new URL(url);
                            HttpURLConnection conn = (HttpURLConnection) jsonObj.openConnection();
                            conn.setRequestMethod("GET");
                            conn.connect();
                            int responsecode = conn.getResponseCode();
                            boolean webConSuccess = true;
                            if (responsecode != 200) {
                                webConSuccess = false;
                                System.out.println("\n Sending 'GET' request to URL : " + url + " \n RETURN ERROR CODE:" + responsecode);
                                throw new RuntimeException("HttpResponseCode: " + responsecode);
                            } else {
                                BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                                String inputline;
                                StringBuffer response = new StringBuffer();
                                while ((inputline = in.readLine()) != null) {
                                    response.append(inputline);
                                }
                                in.close();
                                logger.info("Upa Here!!! " + response.toString());
                                JSONObject jobj = new JSONObject(response.toString());

                                long timestamp = Long.parseLong(jobj.getString("timestamp")); //Example -> in ms
                                Date date = new Date(timestamp);
                                logger.info("TimeStamp: " + jobj.getString("timestamp") + " Date: " + date);
                                String baseCurrency = jobj.getString("base");
                                logger.info("Base Currency: " + baseCurrency);
                                logger.info("Rates: " + jobj.getString("rates"));
                                JSONObject ratesObj = new JSONObject(jobj.getJSONObject("rates").toString());
                                logger.info("Rates:ratesObj " + ratesObj);
                                logger.info("Length " + ratesObj.length());

                                String[] curfields = {"currencyid", "country", "currencyname", "abbreviation"};
                                String[] params2 = {};
                                Object[] paramsValues2 = {};
                                List<Object[]> curListArr = (List<Object[]>) genericClassService.fetchRecord(Ctrycurrency.class, curfields, "WHERE r.abbreviation IS NOT NULL ORDER BY r.country ASC", params2, paramsValues2);
                                if (curListArr != null) {
                                    for (Object[] obj : curListArr) {
                                        if (obj[3] != null) {
                                            String[] columnslev = {"currencyrate"};
                                            Object[] columnValueslev = {ratesObj.getDouble((String) obj[3])};
                                            String levelPrimaryKey = "currencyid";
                                            Object levelPkValue = (Integer) obj[0];
                                            int result2 = genericClassService.updateRecordSQLSchemaStyle(Ctrycurrency.class, columnslev, columnValueslev, levelPrimaryKey, levelPkValue, "public");

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

        }
    }
}
