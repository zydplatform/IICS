/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.domain.Countrycurrency;
import com.iics.domain.Ctrycurrency;
import com.iics.domain.Currencyrates;
import com.iics.domain.Worldcountries;
import com.iics.service.GenericClassService;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.net.MalformedURLException;
import java.net.URL;
import java.security.Principal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author SAMINUNU
 */
@Controller
@RequestMapping("/currencysystemsettings")
public class ManageCurrencies {

    protected static Log logger = LogFactory.getLog("controller");
    DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat format = new SimpleDateFormat("dd-MM-yyyy");

    @Autowired
    GenericClassService genericClassService;

    @RequestMapping(value = "/currencypane", method = RequestMethod.GET)
    public final ModelAndView currencyPane(HttpServletRequest request) throws MalformedURLException, IOException {
        Map<String, Object> model = new HashMap<String, Object>();

        //Fetch Currencies
        List<Map> currencyRatesLists = new ArrayList<>();

        String[] paramscurrency = {"currencystatus"};
        Object[] paramsValuescurrency = {Boolean.TRUE};
        String[] fieldscurrency = {"currencyid", "country", "currencyname", "currencyrate", "abbreviation", "dateupdated"};
        String wherecurrency = "WHERE currencystatus=:currencystatus";
        List<Object[]> currencies = (List<Object[]>) genericClassService.fetchRecord(Ctrycurrency.class, fieldscurrency, wherecurrency, paramscurrency, paramsValuescurrency);
        if (currencies != null) {
             Map<String, Object> currates;
            for (Object[] cur : currencies) {
                currates = new HashMap<>();
                
                currates.put("currencyid",(Integer) cur[0]);
                currates.put("country",(String) cur[1]);
                currates.put("currencyname",(String) cur[2]);
                if(cur[3] != null){
                    currates.put("currencyrate",String.format("%,.6f",(Double) cur[3]));
                }else{
                    String red = "red";
                    currates.put("currencyrate","<font color="+red+"><b>No Updated Currency Rates</b></font>");
                }
                
                currates.put("abbreviation",(String) cur[4]);
                currates.put("dateupdated",formatter.format((Date) cur[5]));

                currencyRatesLists.add(currates);

                model.put("currenciesList", currencyRatesLists);
            }
        }
        System.out.println("--------------------------" + currencyRatesLists);
        return new ModelAndView("controlPanel/universalPanel/currencies/currencyPane", "model", model);
    }

    @RequestMapping(value = "/addCurrency", method = RequestMethod.GET)
    public String AddCurrency(HttpServletRequest request, Model model) {

        List<Worldcountries> countries = new ArrayList<>();
        try {
            String[] params = {};
            Object[] paramsValues = {};
            String[] fields = {"worldcountriesid", "countryname", "countrycurrency", "currencyabbrv"};
            String where = "";
            List<Object[]> country = (List<Object[]>) genericClassService.fetchRecord(Worldcountries.class, fields, where, params, paramsValues);
            if (country != null) {
                for (Object[] ctry : country) {
                    Worldcountries Wctrys = new Worldcountries();
                    Wctrys.setWorldcountriesid((Integer) ctry[0]);
                    Wctrys.setCountryname((String) ctry[1]);
                    Wctrys.setCountrycurrency((String) ctry[2]);
                    Wctrys.setCurrencyabbrv((String) ctry[3]);

                    countries.add(Wctrys);
                }
            }
            model.addAttribute("CountriesLists", countries);

        } catch (Exception e) {

        }
        return "controlPanel/universalPanel/currencies/forms/addcurrency";
    }

    @RequestMapping(value = "/savecurrencies", method = RequestMethod.POST)
    public final ModelAndView saveCurrencies(HttpServletRequest request) {
        Map<String, Object> model = new HashMap<String, Object>();

        try {
            //saving currencies
            Ctrycurrency currencyObj = new Ctrycurrency();

            Object addedbyname = request.getSession().getAttribute("person_id");
            Object updatedbyname = request.getSession().getAttribute("person_id");

            String country = request.getParameter("countryname");
            String currencyname = request.getParameter("currencyname");
            String abbreviation = request.getParameter("currencyabbreviation");

            currencyObj.setCountry(country);
            currencyObj.setCurrencyname(currencyname);
            currencyObj.setAbbreviation(abbreviation);
            currencyObj.setCurrencystatus(Boolean.TRUE);
            currencyObj.setDateadded(new Date());
            currencyObj.setDateupdated(new Date());
            currencyObj.setAddedby((Long) addedbyname);
            currencyObj.setUpdatedby((Long) updatedbyname);

            Object save = genericClassService.saveOrUpdateRecordLoadObject(currencyObj);

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return new ModelAndView("controlPanel/universalPanel/currencies/currencyPane", "model", model);
    }

    @RequestMapping(value = "/updatecurrencies", method = RequestMethod.POST)
    public @ResponseBody
    String updateCurrencies(HttpServletRequest request) {
        try {
            //update currencies

            String currencyname = request.getParameter("currencyname");
            String currencyshortname = request.getParameter("currencyshortname");
            Integer countrycurrencyid = Integer.parseInt(request.getParameter("countrycurrencyid"));

            String[] columns = {"countrycurrencyid", "currencyname", "currencyshortname"};
            Object[] columnValues = {countrycurrencyid, currencyname, currencyshortname};
            String pk = "countrycurrencyid";
            Object pkValue = countrycurrencyid;
            genericClassService.updateRecordSQLSchemaStyle(Countrycurrency.class, columns, columnValues, pk, pkValue, "public");

            Integer buyone = Integer.parseInt(request.getParameter("buyone"));
            Integer sellone = Integer.parseInt(request.getParameter("sellone"));
            Integer currencyratesid = Integer.parseInt(request.getParameter("currencyratesid"));
            //String queuetypeid = request.getParameter("queuetypeid");

            String[] columnsrates = {"currencyratesid", "buyone", "sellone"};
            Object[] columnValuesrates = {currencyratesid, buyone, sellone};
            String pkrates = "currencyratesid";
            Object pkValuerates = currencyratesid;
            genericClassService.updateRecordSQLSchemaStyle(Currencyrates.class, columnsrates, columnValuesrates, pkrates, pkValuerates, "public");

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return "";
    }

    /**
     *
     * @param principal
     * @return
     */
//    @RequestMapping("/importForex")
//    @SuppressWarnings("CallToThreadDumpStack")
//    public final ModelAndView importForex(Principal principal, HttpServletRequest request,
//            @RequestParam("act") String activity, @RequestParam("i") long id, @RequestParam("d") long id2,
//            @RequestParam("b") String strVal, @RequestParam("c") String strVal2,
//            @RequestParam("ofst") int offset, @RequestParam("maxR") int maxResults,
//            @RequestParam("sStr") String searchPhrase) {
//        if (principal == null) {
//            return new ModelAndView("refresh");
//        }
//        Map<String, Object> model = new HashMap<String, Object>();
//
//        try {
//            model.put("act", activity);
//            model.put("b", strVal);
//            model.put("i", id);
//            model.put("c", strVal2);
//            model.put("d", id2);
//            model.put("ofst", offset);
//            model.put("maxR", maxResults);
//            model.put("sStr", searchPhrase);
//
//            request.getSession().setAttribute("sessPagingOffSet", offset);
//            request.getSession().setAttribute("sessPagingMaxResults", maxResults);
//            request.getSession().setAttribute("vsearch", searchPhrase);
//
//            String url = "https://openexchangerates.org/api/latest.json?app_id=1bf7d3c4b54f44a282d01b92c663de6f";
//            URL jsonObj = new URL(url);
//            HttpURLConnection conn = (HttpURLConnection) jsonObj.openConnection();
//            conn.setRequestMethod("GET");
//            conn.connect();
//            int responsecode = conn.getResponseCode();
//            boolean webConSuccess = true;
//            if (responsecode != 200) {
//                webConSuccess = false;
//                System.out.println("\n Sending 'GET' request to URL : " + url + " \n RETURN ERROR CODE:" + responsecode);
//                throw new RuntimeException("HttpResponseCode: " + responsecode);
//            } else {
//                BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
//                String inputline;
//                StringBuffer response = new StringBuffer();
//                while ((inputline = in.readLine()) != null) {
//                    response.append(inputline);
//                }
//                in.close();
//                logger.info("Upa Here!!! " + response.toString());
//                JSONObject jobj = new JSONObject(response.toString());
//                logger.info("JSONObject jobj: " + jobj);
//
//                long timestamp = Long.parseLong(jobj.getString("timestamp")); //Example -> in ms
//                Date date = new Date(timestamp);
//                logger.info("TimeStamp: " + jobj.getString("timestamp") + " Date: " + date);
//                String baseCurrency = jobj.getString("base");
//                logger.info("Base Currency: " + baseCurrency);
//                logger.info("Rates: " + jobj.getString("rates"));
//                JSONObject ratesObj = new JSONObject(jobj.getJSONObject("rates").toString());
//                logger.info("Rates:ratesObj " + ratesObj);
//                logger.info("Length " + ratesObj.length());
//
//                List<Ctrycurrency> currencyList = new ArrayList<Ctrycurrency>();
//                String[] curfields = {"currencyid", "country", "currencyname", "abbreviation"};
//                String[] params = {};
//                Object[] paramsValues = {};
//                List<Object[]> curListArr = (List<Object[]>) genericClassService.fetchRecord(Ctrycurrency.class, curfields, "WHERE r.abbreviation IS NOT NULL ORDER BY r.country ASC", params, paramsValues);
//                if (curListArr != null) {
//                    for (Object[] obj : curListArr) {
//                        Ctrycurrency cur = new Ctrycurrency((Integer) obj[0]);
//                        cur.setCountry((String) obj[1]);
//                        cur.setCurrencyname((String) obj[2]);
//                        cur.setAbbreviation((String) obj[3]);
//                        cur.setDateupdated(date);
//                        if (cur.getAbbreviation() != null && !cur.getAbbreviation().isEmpty()) {
//                            cur.setCurrencyrate(ratesObj.getDouble(cur.getAbbreviation()));
//                            currencyList.add(cur);
//                        }
//                    }
//                }
//                if (currencyList != null) {
//                    model.put("size", currencyList.size());
//                }
//                model.put("currencyList", currencyList);
////                request.getSession().setAttribute("currencies", new ObjectMapper().writeValueAsString(currencyList));
//                model.put("jsoncurrencies", new ObjectMapper().writeValueAsString(currencyList));
//
//                model.put("base", baseCurrency);
//                model.put("date", date);
//                return new ModelAndView("controlPanel/universalPanel/currencies/views/currentRates", "model", model);
//
//            }
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        model.put("success", "<span class='text6'>Contact System Administrator :: Page Not Found!</span>");
//        return new ModelAndView("response", "model", model);
//    }

    @RequestMapping(value = "/removecurrency", method = RequestMethod.POST)
    public @ResponseBody
    String removeCurrency(HttpServletRequest request, Model model, @ModelAttribute("currencyid") int currencyid) {
        String results = "";

        String[] columnslev = {"currencystatus"};
        Object[] columnValueslev = {Boolean.FALSE};
        String levelPrimaryKey = "currencyid";
        Object levelPkValue = currencyid;
        int result = genericClassService.updateRecordSQLSchemaStyle(Ctrycurrency.class, columnslev, columnValueslev, levelPrimaryKey, levelPkValue, "public");
        if (result != 0) {
            results = "success";
        }
        return results;
    }

    @RequestMapping(value = "/updatecurrencyrates", method = RequestMethod.GET)
    public @ResponseBody
    String updateCurrencyRates(HttpServletRequest request) {
        String results = "";
        Date date = new Date();
        Ctrycurrency currencyupdatedate = new Ctrycurrency();

        try {
            List<Map> itemz = (ArrayList) new ObjectMapper().readValue(request.getParameter("currencyvalues"), List.class);
            for (Map item : itemz) {
                Map<String, Object> map = (HashMap) item;

                currencyupdatedate.setDateupdated(new Date());

                String[] columnslev = {"currencyrate"};
                Object[] columnValueslev = {Double.parseDouble((String) map.get("currencyrate"))};
                String levelPrimaryKey = "currencyid";
                Object levelPkValue = Integer.parseInt((String) map.get("currencyid"));
                int result = genericClassService.updateRecordSQLSchemaStyle(Ctrycurrency.class, columnslev, columnValueslev, levelPrimaryKey, levelPkValue, "public");
                if (result != 0) {
                    results = "success";
                }
            }

        } catch (IOException e) {
        }

        return results;
    }

    @RequestMapping(value = "/updateallcurrencyrates", method = RequestMethod.POST)
    public @ResponseBody
    String updateAllCurrencyRates(HttpServletRequest request, @ModelAttribute("currencyvalues") String currenciesupdateall) {
        String results = "";
        try {
            ObjectMapper mapper = new ObjectMapper();
            List<Map> updatecurrencies = (ArrayList<Map>) mapper.readValue(currenciesupdateall, List.class);
            //System.out.println("----------**********-----------" + currenciesupdateall);
            for (Map x : updatecurrencies) {
                String currencyratex = String.valueOf(x.get("currencyrate"));
                double currencyrate = Double.parseDouble(currencyratex);
                int currencyid = (int) x.get("currencyid");

                String[] columnslev = {"currencyrate", "dateupdated"};
                Object[] columnValueslev = {currencyrate, new Date()};
                String levelPrimaryKey = "currencyid";
                Object levelPkValue = currencyid;
                Object updatelimit = genericClassService.updateRecordSQLSchemaStyle(Ctrycurrency.class, columnslev, columnValueslev, levelPrimaryKey, levelPkValue, "public");

                if (updatelimit != null) {
                    results = "successly";
                } else {
                    results = "fail";
                }

            }

        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        } catch (IOException ex) {
            System.out.println(ex);
        }
        return results;
    }

}
