/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.domain.Facilityunit;
import com.iics.service.GenericClassService;
import com.iics.store.Facilityfinancialyear;
import com.iics.store.Facilityunitfinancialyear;
import com.iics.store.Facilityunitprocurementplan;
import com.iics.store.Item;
import com.iics.store.Itemcategories;
import com.iics.store.Itempackage;
import com.iics.store.Orderperiod;
import java.io.IOException;
import java.math.BigInteger;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author RESEARCH
 */
@Controller
@RequestMapping("/procurementplanmanagement")
public class ProcurementPlanManagement {

    DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    @Autowired
    GenericClassService genericClassService;

// Has to be approved
    @RequestMapping(value = "/procurementplanmanagement.htm", method = RequestMethod.GET)
    public String ProcurementPlanManagement(Model model, HttpServletRequest request) {
        List<Map> procurementplanlist = new ArrayList<>();
        String[] params = {"facilityid"};
        Object[] paramsValues = {Long.parseLong(String.valueOf((int) request.getSession().getAttribute("sessionActiveLoginFacility")))};
        String[] fields = {"facilityfinancialyearid", "startyear", "endyear"};
        List<Object[]> financialyrs = (List<Object[]>) genericClassService.fetchRecord(Facilityfinancialyear.class, fields, "WHERE facilityid=:facilityid", params, paramsValues);
        if (financialyrs != null) {
            Map<String, Object> procurementplanRow;
            for (Object[] fyr : financialyrs) {
                procurementplanRow = new HashMap<>();
                int financialyrprocurementsRowcount = 0;
                String[] params6 = {"proccessingstage", "facilityunitid", "facilityfinancialyearid"};
                Object[] paramsValues6 = {"approved", Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))), (Long) fyr[0]};
                String where6 = "WHERE proccessingstage=:proccessingstage AND facilityunitid=:facilityunitid AND facilityfinancialyearid=:facilityfinancialyearid";
                financialyrprocurementsRowcount = genericClassService.fetchRecordCount(Facilityunitfinancialyear.class, where6, params6, paramsValues6);
                if (financialyrprocurementsRowcount != 0) {
                    procurementplanRow.put("facilityfinancialyearid", (Long) fyr[0]);
                    procurementplanRow.put("procurementplan", (int) fyr[1] + "-" + (int) fyr[2]);
                    procurementplanRow.put("financialyrprocurementsRowcount", financialyrprocurementsRowcount);
                    procurementplanlist.add(procurementplanRow);
                }
            }
        }
        model.addAttribute("procurementplanlist", procurementplanlist);
        return "controlPanel/localSettingsPanel/procurementplan/procurementplanHome";
    }

    @RequestMapping(value = "/unprocuredfinancialyearperiods.htm", method = RequestMethod.GET)
    public String unprocuredfinancialyearperiods(Model model, HttpServletRequest request) {
        List<Map> financialyr = new ArrayList<>();
        String results_view = "";
        String[] params1 = {"facilityid", "isthecurrent","istopdownapproach"};
        Object[] paramsValues1 = {Long.parseLong(String.valueOf((int) request.getSession().getAttribute("sessionActiveLoginFacility"))), Boolean.TRUE,Boolean.FALSE};
        String[] fields1 = {"facilityfinancialyearid", "startyear", "endyear"};
        List<Object[]> fnyr = (List<Object[]>) genericClassService.fetchRecord(Facilityfinancialyear.class, fields1, "WHERE facilityid=:facilityid AND isthecurrent=:isthecurrent AND istopdownapproach=:istopdownapproach", params1, paramsValues1);
        if (fnyr != null) {
            Map<String, Object> procurementplanRow;
            for (Object[] fyr : fnyr) {
                procurementplanRow = new HashMap<>();
                procurementplanRow.put("facilityfinancialyearid", (Long) fyr[0]);
                procurementplanRow.put("procurementplan", (int) fyr[1] + "-" + (int) fyr[2]);

                financialyr.add(procurementplanRow);
            }
        }
        model.addAttribute("financialyr", financialyr);
        model.addAttribute("size", financialyr.size());
        if ("a".equals(request.getParameter("act"))) {
            results_view = "controlPanel/localSettingsPanel/procurementplan/views/unProcuredFinancialPeriods";
        } else {
            results_view = "controlPanel/localSettingsPanel/procurementplan/verifyProcurementPlan/views/verifyProcurementPlanHome";
        }
        return results_view;
    }

    @RequestMapping(value = "/unprocuredfinancialyearperiodstable.htm", method = RequestMethod.GET)
    public String unprocuredfinancialyearperiodstable(Model model, HttpServletRequest request) {
        List<Map> financialyr = new ArrayList<>();
        String[] params2 = {"facilityfinancialyearid", "proccessingstage", "facilityunitid"};
        Object[] paramsValues2 = {Long.parseLong(request.getParameter("selectprocurementfacilityyr")), "created", Long.parseLong(String.valueOf((int) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))};
        String[] fields2 = {"addedby", "orderperiodid", "facilityunitfinancialyearid", "facilityunitlabel"};
        List<Object[]> fnyr2 = (List<Object[]>) genericClassService.fetchRecord(Facilityunitfinancialyear.class, fields2, "WHERE facilityfinancialyearid=:facilityfinancialyearid AND proccessingstage=:proccessingstage AND facilityunitid=:facilityunitid", params2, paramsValues2);
        if (fnyr2 != null) {
            Map<String, Object> procurementplanRow;
            for (Object[] proc : fnyr2) {
                procurementplanRow = new HashMap<>();
                String[] params1 = {"orderperiodid"};
                Object[] paramsValues1 = {(int) proc[1]};
                String[] fields1 = {"orderperiodname", "startdate", "enddate", "orderperiodtype"};
                List<Object[]> fnyr = (List<Object[]>) genericClassService.fetchRecord(Orderperiod.class, fields1, "WHERE orderperiodid=:orderperiodid", params1, paramsValues1);
                if (fnyr != null) {
                    Object[] procurement = fnyr.get(0);
                    procurementplanRow.put("facilityunitfinancialyearid", (int) proc[2]);
                    procurementplanRow.put("facilityunitlabel", (String) proc[3] + "-" + (String) procurement[0]);
                    procurementplanRow.put("startdate", (Date) procurement[1]);
                    procurementplanRow.put("enddate", (Date) procurement[2]);
                    procurementplanRow.put("orderperiodtype", (String) procurement[3]);
                    financialyr.add(procurementplanRow);
                }
            }
        }
        model.addAttribute("unprocuredfinancialyrs", financialyr);
        model.addAttribute("size", financialyr.size());
        model.addAttribute("facilityfinancialyearid", request.getParameter("selectprocurementfacilityyr"));
        return "controlPanel/localSettingsPanel/procurementplan/views/unProcuredFinancialPeriodsTable";
    }

    @RequestMapping(value = "/generatefacilityunitprocurementplan.htm")
    public @ResponseBody
    String generatefacilityunitprocurementplan(Model model, HttpServletRequest request) {
        String results = "";

        String[] paramst = {"facilityfinancialyearid", "facilityunitid"};
        Object[] paramsValuest = {Long.parseLong(request.getParameter("financialyear")), Long.parseLong(String.valueOf((int) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))};
        String[] fieldst = {"facilityunitfinancialyearid"};
        List<Integer> fnyrt = (List<Integer>) genericClassService.fetchRecord(Facilityunitfinancialyear.class, fieldst, "WHERE facilityfinancialyearid=:facilityfinancialyearid AND facilityunitid=:facilityunitid", paramst, paramsValuest);
        if (fnyrt == null) {
            String[] params1 = {"facilityfinancialyearid"};
            Object[] paramsValues1 = {Long.parseLong(request.getParameter("financialyear"))};
            String[] fields1 = {"orderperiodtype"};
            List<String> fnyr = (List<String>) genericClassService.fetchRecord(Facilityfinancialyear.class, fields1, "WHERE facilityfinancialyearid=:facilityfinancialyearid", params1, paramsValues1);
            if (fnyr != null) {
                if ("Quarterly".equals(fnyr.get(0))) {
                    String[] params2 = {"facilityfinancialyearid"};
                    Object[] paramsValues2 = {Long.parseLong(request.getParameter("financialyear"))};
                    String[] fields2 = {"orderperiodid", "orderperiodname"};
                    List<Object[]> fnyr2 = (List<Object[]>) genericClassService.fetchRecord(Orderperiod.class, fields2, "WHERE facilityfinancialyearid=:facilityfinancialyearid", params2, paramsValues2);
                    if (fnyr2 != null) {
                        for (Object[] fny : fnyr2) {
                            String[] params5 = {"facilityunitid"};
                            Object[] paramsValues5 = {Long.parseLong(String.valueOf((int) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))};
                            String[] fields5 = {"shortname"};
                            List<String> fnyr5 = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fields5, "WHERE facilityunitid=:facilityunitid", params5, paramsValues5);
                            Facilityunitfinancialyear facilityunitfinancialyear = new Facilityunitfinancialyear();
                            facilityunitfinancialyear.setAddedby(BigInteger.valueOf((Long) request.getSession().getAttribute("person_id")));
                            facilityunitfinancialyear.setDateadded(new Date());
                            facilityunitfinancialyear.setConsolidated(Boolean.FALSE);
                            facilityunitfinancialyear.setFacilityfinancialyearid(new Facilityfinancialyear(Long.parseLong(request.getParameter("financialyear"))));
                            facilityunitfinancialyear.setOrderperiodid(new Orderperiod((Integer) fny[0]));
                            facilityunitfinancialyear.setFacilityunitid(BigInteger.valueOf(Long.parseLong(String.valueOf((int) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))));
                            facilityunitfinancialyear.setFacilityunitlabel(fnyr5.get(0));
                            facilityunitfinancialyear.setProccessingstage("created");
                            genericClassService.saveOrUpdateRecordLoadObject(facilityunitfinancialyear);
                        }
                    }
                } else if ("Annually".equals(fnyr.get(0))) {
                    String[] params2 = {"facilityfinancialyearid"};
                    Object[] paramsValues2 = {Long.parseLong(request.getParameter("financialyear"))};
                    String[] fields2 = {"orderperiodid", "orderperiodname"};
                    List<Object[]> fnyr2 = (List<Object[]>) genericClassService.fetchRecord(Orderperiod.class, fields2, "WHERE facilityfinancialyearid=:facilityfinancialyearid", params2, paramsValues2);
                    if (fnyr2 != null) {
                        String[] params5 = {"facilityunitid"};
                        Object[] paramsValues5 = {Long.parseLong(String.valueOf((int) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))};
                        String[] fields5 = {"shortname"};
                        List<String> fnyr5 = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fields5, "WHERE facilityunitid=:facilityunitid", params5, paramsValues5);
                        Facilityunitfinancialyear facilityunitfinancialyear = new Facilityunitfinancialyear();
                        facilityunitfinancialyear.setAddedby(BigInteger.valueOf((Long) request.getSession().getAttribute("person_id")));
                        facilityunitfinancialyear.setDateadded(new Date());
                        facilityunitfinancialyear.setFacilityfinancialyearid(new Facilityfinancialyear(Long.parseLong(request.getParameter("financialyear"))));

                        facilityunitfinancialyear.setOrderperiodid(new Orderperiod((Integer) fnyr2.get(0)[0]));
                        facilityunitfinancialyear.setFacilityunitid(BigInteger.valueOf(Long.parseLong(String.valueOf((int) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))));
                        facilityunitfinancialyear.setFacilityunitlabel(fnyr5.get(0));
                        facilityunitfinancialyear.setProccessingstage("created");
                        facilityunitfinancialyear.setConsolidated(Boolean.FALSE);
                        genericClassService.saveOrUpdateRecordLoadObject(facilityunitfinancialyear);
                    }
                } else {

                }
            }
        } else {
            results = "created";
        }

        return results;
    }

    @RequestMapping(value = "/searchItems", method = RequestMethod.GET)
    public String searchItems(HttpServletRequest request, Model model, @ModelAttribute("name") String searchValue) {
        List<Map> itemsFound = new ArrayList<>();
        Set<Long> itemsid = new HashSet<>();
        if ("withid".equals(request.getParameter("type"))) {
            try {
                List<String> itemz = (ArrayList) new ObjectMapper().readValue(request.getParameter("itemsonprocurement"), List.class);
                for (String item : itemz) {
                    itemsid.add(Long.parseLong(item));
                }
                String[] params = {"value", "name", "isactive"};
                Object[] paramsValues = {searchValue.trim().toLowerCase() + "%", "%" + searchValue.trim().toLowerCase() + "%", Boolean.TRUE};
                String[] fields = {"itempackageid", "packagename", "categoryname"};
                String where = "WHERE isactive=:isactive AND (LOWER(packagename) LIKE :name OR LOWER(categoryname) LIKE :value OR LOWER(classificationname) LIKE :value OR LOWER(itemcode) LIKE :value) ORDER BY genericname";
                List<Object[]> classficationList = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields, where, params, paramsValues);
                if (classficationList != null) {
                    Map<String, Object> classification;
                    for (Object[] object : classficationList) {
                        classification = new HashMap<>();
                        if (!itemsid.contains(((BigInteger) object[0]).longValue())) {
                            classification.put("id", object[0]);
                            classification.put("name", object[1]);
                            classification.put("cat", object[2]);
                            itemsFound.add(classification);
                        }
                    }
                }
            } catch (IOException e) {
            }
        } else {
            String[] params = {"value", "name", "isactive"};
            Object[] paramsValues = {searchValue.trim().toLowerCase() + "%", "%" + searchValue.trim().toLowerCase() + "%", Boolean.TRUE};
            String[] fields = {"itempackageid", "packagename", "categoryname"};
            String where = "WHERE isactive=:isactive AND (LOWER(packagename) LIKE :name OR LOWER(categoryname) LIKE :value OR LOWER(classificationname) LIKE :value OR LOWER(itemcode) LIKE :value) ORDER BY genericname";
            List<Object[]> classficationList = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields, where, params, paramsValues);
            if (classficationList != null) {
                Map<String, Object> classification;
                for (Object[] object : classficationList) {
                    classification = new HashMap<>();
                    classification.put("id", object[0]);
                    classification.put("name", object[1]);
                    classification.put("cat", object[2]);
                    itemsFound.add(classification);
                }
            }
        }

        model.addAttribute("name", searchValue);
        model.addAttribute("items", itemsFound);
        model.addAttribute("itemsonprocurement", request.getParameter("itemsonprocurement"));
        return "controlPanel/localSettingsPanel/procurementplan/views/itemsSearchResults";
    }

    @RequestMapping(value = "/unapprovedfacilityunitprocurementplans.htm", method = RequestMethod.GET)
    public String unapprovedfacilityunitprocurementplans(HttpServletRequest request, Model model) {
        List<Map> procurementPlansFound = new ArrayList<>();
        String[] params2 = {"facilityfinancialyearid", "submitted", "partial","facilityunitid"};
        Object[] paramsValues2 = {Long.parseLong(request.getParameter("selectprocurementfacilityyr")), "submitted", "partial",Long.parseLong(String.valueOf((int) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))};
        String[] fields2 = {"addedby", "orderperiodid", "facilityunitfinancialyearid", "facilityunitlabel"};
        List<Object[]> fnyr2 = (List<Object[]>) genericClassService.fetchRecord(Facilityunitfinancialyear.class, fields2, "WHERE facilityfinancialyearid=:facilityfinancialyearid AND (proccessingstage=:submitted OR proccessingstage=:partial) AND facilityunitid=:facilityunitid", params2, paramsValues2);
        if (fnyr2 != null) {
            Map<String, Object> procurementplanRow;
            for (Object[] proc : fnyr2) {
                procurementplanRow = new HashMap<>();
                String[] params1 = {"orderperiodid"};
                Object[] paramsValues1 = {(int) proc[1]};
                String[] fields1 = {"orderperiodname", "startdate", "enddate", "orderperiodtype"};
                List<Object[]> fnyr = (List<Object[]>) genericClassService.fetchRecord(Orderperiod.class, fields1, "WHERE orderperiodid=:orderperiodid", params1, paramsValues1);
                if (fnyr != null) {
                    Object[] procurement = fnyr.get(0);
                    procurementplanRow.put("facilityunitfinancialyearid", (int) proc[2]);
                    procurementplanRow.put("facilityunitlabel", (String) proc[3] + "-" + (String) procurement[0]);
                    procurementplanRow.put("startdate", (Date) procurement[1]);
                    procurementplanRow.put("enddate", (Date) procurement[2]);
                    procurementplanRow.put("orderperiodtype", (String) procurement[3]);
                    int financialyritemsRowcount = 0;
                    String[] params6 = {"facilityunitfinancialyearid"};
                    Object[] paramsValues6 = {(int) proc[2]};
                    String where6 = "WHERE facilityunitfinancialyearid=:facilityunitfinancialyearid";
                    financialyritemsRowcount = genericClassService.fetchRecordCount(Facilityunitprocurementplan.class, where6, params6, paramsValues6);
                    procurementplanRow.put("financialyritemsRowcount", financialyritemsRowcount);
                    procurementPlansFound.add(procurementplanRow);
                }
            }
        }
        model.addAttribute("unprocuredfinancialyrs", procurementPlansFound);
        model.addAttribute("size", procurementPlansFound.size());
        model.addAttribute("facilityfinancialyearid", request.getParameter("selectprocurementfacilityyr"));
        return "controlPanel/localSettingsPanel/procurementplan/verifyProcurementPlan/views/unVerifiedProcurementPlan";
    }

    @RequestMapping(value = "/approveunapprovedfacilityunitprocurementplan.htm")
    public @ResponseBody
    String approveunapprovedfacilityunitprocurementplan(Model model, HttpServletRequest request) {
        String results = "";
        if ("approve".equals(request.getParameter("type"))) {
            String[] columns = {"proccessingstage", "lastupdatedby", "lastupdated"};
            Object[] columnValues = {"approved", (Long) request.getSession().getAttribute("person_id"), new Date()};
            String pk = "facilityunitfinancialyearid";
            Object pkValue = Integer.parseInt(request.getParameter("facilityunitfinancialyearid"));
            int result = genericClassService.updateRecordSQLSchemaStyle(Facilityunitfinancialyear.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                results = "success";
            }
        } else if ("reject".equals(request.getParameter("type"))) {
            String[] columns = {"proccessingstage", "approvalcomment", "lastupdatedby", "lastupdated"};
            Object[] columnValues = {"rejected", request.getParameter("reason"), (Long) request.getSession().getAttribute("person_id"), new Date()};
            String pk = "facilityunitfinancialyearid";
            Object pkValue = Integer.parseInt(request.getParameter("facilityunitfinancialyearid"));
            int result = genericClassService.updateRecordSQLSchemaStyle(Facilityunitfinancialyear.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                results = "success";
            }
        } else if ("partial".equals(request.getParameter("type"))) {
            String[] columns = {"proccessingstage", "lastupdatedby", "lastupdated"};
            Object[] columnValues = {"partial", (Long) request.getSession().getAttribute("person_id"), new Date()};
            String pk = "facilityunitfinancialyearid";
            Object pkValue = Integer.parseInt(request.getParameter("facilityunitfinancialyearid"));
            int result = genericClassService.updateRecordSQLSchemaStyle(Facilityunitfinancialyear.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                results = "success";
            }
        }

        return results;
    }

    @RequestMapping(value = "/getitemconsumptionaveragefrompreviousfinancialyears.htm")
    public String ItemConsumptionAverageFromFinancialYears(Model model, HttpServletRequest request) {
        String results_view = "";
        int itemscount = 0;
        int itemstotal = 0;
        String[] params1 = {"itemid", "approved"};
        Object[] paramsValues1 = {Long.parseLong(request.getParameter("itemid")), Boolean.TRUE};
        String[] fields1 = {"facilityunitfinancialyearid", "averagemonthlyconsumption"};
        List<Object[]> fnyr = (List<Object[]>) genericClassService.fetchRecord(Facilityunitprocurementplan.class, fields1, "WHERE itemid=:itemid AND approved=:approved", params1, paramsValues1);
        if (fnyr != null) {
            for (Object[] fny : fnyr) {
                String[] params2 = {"facilityunitfinancialyearid", "proccessingstage", "facilityunitid"};
                Object[] paramsValues2 = {(int) fny[0], "approved", Long.parseLong(String.valueOf((int) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))};
                String[] fields2 = {"orderperiodid", "dateadded"};
                List<Object[]> fnyr2 = (List<Object[]>) genericClassService.fetchRecord(Facilityunitfinancialyear.class, fields2, "WHERE facilityunitfinancialyearid=:facilityunitfinancialyearid AND proccessingstage=:proccessingstage AND facilityunitid=:facilityunitid", params2, paramsValues2);
                if (fnyr2 != null) {
                    itemstotal = itemstotal + ((Double) fny[1]).intValue();
                    itemscount = itemscount + 1;
                }
            }
        }
        if (itemstotal != 0 && itemscount != 0) {
            model.addAttribute("monthly", itemstotal / itemscount);
            if ("Quarterly".equals(request.getParameter("orderperiodtyp"))) {
                model.addAttribute("quarterly", (itemstotal / itemscount) * 3);
            } else {
                model.addAttribute("monthorannual", (itemstotal / itemscount) * 12);
            }
        } else {
            model.addAttribute("monthly", 0);
            if ("Quarterly".equals(request.getParameter("orderperiodtyp"))) {
                model.addAttribute("quarterly", 0);
            } else {
                model.addAttribute("monthorannual", 0);
            }
        }

        model.addAttribute("itemname", request.getParameter("itemName"));
        model.addAttribute("itemid", request.getParameter("itemid"));
        model.addAttribute("ordertypeperiod", request.getParameter("orderperiodtyp"));
        if ("b".equals(request.getParameter("act"))) {
            results_view = "controlPanel/localSettingsPanel/procurementplan/pausedProcurementPlans/forms/itemForm";
        } else {
            results_view = "controlPanel/localSettingsPanel/procurementplan/forms/itemForm";
        }
        return results_view;
    }

    @RequestMapping(value = "/pausedsearchItems", method = RequestMethod.GET)
    public String pausedsearchItems(HttpServletRequest request, Model model, @ModelAttribute("name") String searchValue) {
        List<Map> itemsFound = new ArrayList<>();
        Set<Integer> itemsid = new HashSet<>();
        try {
            List<Integer> itemz = (ArrayList) new ObjectMapper().readValue(request.getParameter("itemsonprocurement"), List.class);
            for (Integer item : itemz) {
                itemsid.add(item);
            }
            String[] params = {"value", "name", "isactive"};
            Object[] paramsValues = {searchValue.trim().toLowerCase() + "%", "%" + searchValue.trim().toLowerCase() + "%", Boolean.TRUE};
            String[] fields = {"itempackageid", "packagename", "categoryname"};
            String where = "WHERE isactive=:isactive AND (LOWER(packagename) LIKE :name OR LOWER(categoryname) LIKE :value OR LOWER(classificationname) LIKE :value OR LOWER(itemcode) LIKE :value) ORDER BY genericname";
            List<Object[]> classficationList = (List<Object[]>) genericClassService.fetchRecord(Itemcategories.class, fields, where, params, paramsValues);
            if (classficationList != null) {
                Map<String, Object> classification;
                for (Object[] object : classficationList) {
                    classification = new HashMap<>();
                    if (!itemsid.contains(((BigInteger) object[0]).intValue())) {
                        classification.put("id", object[0]);
                        classification.put("name", object[1]);
                        classification.put("cat", object[2]);
                        itemsFound.add(classification);
                    }
                }
            }
        } catch (IOException e) {
        }
        model.addAttribute("items", itemsFound);
        return "controlPanel/localSettingsPanel/procurementplan/pausedProcurementPlans/forms/itemSearchResult";
    }

    @RequestMapping(value = "/verifyfacilityunitprocurementplanitemsview.htm", method = RequestMethod.GET)
    public String verifyfacilityunitprocurementplanitemsview(HttpServletRequest request, Model model) {
        List<Map> procurementPlansFound = new ArrayList<>();
        int approvecItemsCount = 0;
        String[] params = {"facilityunitfinancialyearid"};
        Object[] paramsValues = {Integer.parseInt(request.getParameter("facilityunitfinancialyearid"))};
        String[] fields = {"facilityunitprocurementplanid", "averagemonthlyconsumption", "averagequarterconsumption", "averageannualcomsumption", "itemid", "approved", "approvalcomment", "status"};
        String where = "WHERE facilityunitfinancialyearid=:facilityunitfinancialyearid";
        List<Object[]> facilityunitprocurementplanitems = (List<Object[]>) genericClassService.fetchRecord(Facilityunitprocurementplan.class, fields, where, params, paramsValues);
        if (facilityunitprocurementplanitems != null) {
            Map<String, Object> procrementitems;
            for (Object[] facilityunitprocurementplan : facilityunitprocurementplanitems) {
                procrementitems = new HashMap<>();
                String[] params1 = {"itempackageid"};
                Object[] paramsValues1 = {(Long) facilityunitprocurementplan[4]};
                String[] fields1 = {"packagename", "packagequantity"};
                List<Object[]> fnyritems = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields1, "WHERE itempackageid=:itempackageid", params1, paramsValues1);
                if (fnyritems != null) {
                    if ((Boolean) facilityunitprocurementplan[5] == true) {
                        approvecItemsCount = approvecItemsCount + 1;
                    } else {
                        procrementitems.put("facilityunitprocurementplanid", (int) facilityunitprocurementplan[0]);
                        procrementitems.put("averagemonthlyconsumption", ((Double) facilityunitprocurementplan[1]).intValue());
                        if ("Quarterly".equals(request.getParameter("type"))) {
                            procrementitems.put("averagequarterconsumption", ((Double) facilityunitprocurementplan[2]).intValue());
                        } else {
                            procrementitems.put("averageannualcomsumption", ((Double) facilityunitprocurementplan[3]).intValue());
                        }
                        procrementitems.put("approved", (Boolean) facilityunitprocurementplan[5]);
                        procrementitems.put("approvalcomment", (String) facilityunitprocurementplan[6]);
                        procrementitems.put("status", (String) facilityunitprocurementplan[7]);
                        procrementitems.put("genericname", fnyritems.get(0)[0]);
                        procrementitems.put("packsize", fnyritems.get(0)[1]);
                        procrementitems.put("itemid", (Long) facilityunitprocurementplan[4]);
                        procurementPlansFound.add(procrementitems);
                    }
                }

            }
        }
        model.addAttribute("type", request.getParameter("type"));
        model.addAttribute("procurementPlansItemsFound", procurementPlansFound);
        model.addAttribute("approvecItemsCount", approvecItemsCount);
        return "controlPanel/localSettingsPanel/procurementplan/verifyProcurementPlan/forms/itemsFormEdit";
    }

    @RequestMapping(value = "/viewprocuredfinancialyeardetails.htm", method = RequestMethod.GET)
    public String viewprocuredfinancialyeardetails(HttpServletRequest request, Model model) {
        List<Map> procurementPlansFound = new ArrayList<>();

        String[] params = {"facilityfinancialyearid", "facilityunitid", "proccessingstage"};
        Object[] paramsValues = {Long.parseLong(request.getParameter("financialyearid")), Long.parseLong(String.valueOf((int) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))), "approved"};
        String[] fields = {"facilityunitfinancialyearid", "orderperiodid", "facilityunitlabel"};
        String where = "WHERE facilityfinancialyearid=:facilityfinancialyearid AND facilityunitid=:facilityunitid AND proccessingstage=:proccessingstage";
        List<Object[]> facilityunitprocurementplans = (List<Object[]>) genericClassService.fetchRecord(Facilityunitfinancialyear.class, fields, where, params, paramsValues);
        if (facilityunitprocurementplans != null) {
            Map<String, Object> procrementplansRow;
            for (Object[] facilityunitprocurement : facilityunitprocurementplans) {
                procrementplansRow = new HashMap<>();
                String[] params1 = {"orderperiodid"};
                Object[] paramsValues1 = {(int) facilityunitprocurement[1]};
                String[] fields1 = {"orderperiodname", "orderperiodtype", "startdate", "enddate"};
                List<Object[]> fnyrordertype = (List<Object[]>) genericClassService.fetchRecord(Orderperiod.class, fields1, "WHERE orderperiodid=:orderperiodid", params1, paramsValues1);
                if (fnyrordertype != null) {
                    procrementplansRow.put("facilityunitfinancialyearid", (int) facilityunitprocurement[0]);
                    procrementplansRow.put("facilityunitlabel", (String) facilityunitprocurement[2] + "-" + fnyrordertype.get(0)[0]);
                    procrementplansRow.put("startdate", formatter.format((Date) fnyrordertype.get(0)[2]));
                    procrementplansRow.put("enddate", formatter.format((Date) fnyrordertype.get(0)[3]));

                    procrementplansRow.put("orderperiodtype", fnyrordertype.get(0)[1]);

                    int financialyunitritemsRowcount = 0;
                    String[] params6 = {"facilityunitfinancialyearid", "approved"};
                    Object[] paramsValues6 = {(int) facilityunitprocurement[0], Boolean.TRUE};
                    String where6 = "WHERE facilityunitfinancialyearid=:facilityunitfinancialyearid AND approved=:approved";
                    financialyunitritemsRowcount = genericClassService.fetchRecordCount(Facilityunitprocurementplan.class, where6, params6, paramsValues6);
                    procrementplansRow.put("financialyunitritemsRowcount", financialyunitritemsRowcount);
                    procurementPlansFound.add(procrementplansRow);
                }
            }
        }
        model.addAttribute("procurementPlansFound", procurementPlansFound);
        return "controlPanel/localSettingsPanel/procurementplan/views/viewprocuredfinancialyearplans";
    }

    @RequestMapping(value = "/viewfinancialyeardetailsitemsviewtable.htm", method = RequestMethod.GET)
    public String viewfinancialyeardetailsitemsviewtable(HttpServletRequest request, Model model) {
        List<Map> procurementPlansItemsFound = new ArrayList<>();

        String[] params = {"facilityunitfinancialyearid", "approved"};
        Object[] paramsValues = {Integer.parseInt(request.getParameter("facilityunitfinancialyearid")), Boolean.TRUE};
        String[] fields = {"itemid", "averagemonthlyconsumption", "averageannualcomsumption", "averagequarterconsumption"};
        String where = "WHERE facilityunitfinancialyearid=:facilityunitfinancialyearid AND approved=:approved";
        List<Object[]> facilityunitprocurementplansitems = (List<Object[]>) genericClassService.fetchRecord(Facilityunitprocurementplan.class, fields, where, params, paramsValues);
        if (facilityunitprocurementplansitems != null) {
            Map<String, Object> procrementplanItemsRow;
            for (Object[] itemid : facilityunitprocurementplansitems) {
                procrementplanItemsRow = new HashMap<>();
                String[] params1 = {"itempackageid"};
                Object[] paramsValues1 = {(Long) itemid[0]};
                String[] fields1 = {"packagename", "packagequantity"};
                List<Object[]> itemdetails = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields1, "WHERE itempackageid=:itempackageid", params1, paramsValues1);
                if (itemdetails != null) {
                    procrementplanItemsRow.put("genericname", (String) itemdetails.get(0)[0]);
                    procrementplanItemsRow.put("packsize", (int) itemdetails.get(0)[1]);
                    procrementplanItemsRow.put("amc", String.format("%,.0f", (double) itemid[1]));
                    if ("Quarterly".equals(request.getParameter("orderperiodtype"))) {
                        procrementplanItemsRow.put("aqc", String.format("%,.0f", (double) itemid[3]));
                    } else {
                        procrementplanItemsRow.put("aac", String.format("%,.0f", (double) itemid[2]));
                    }
                    procurementPlansItemsFound.add(procrementplanItemsRow);
                }
            }
        }
        model.addAttribute("procurementPlansItemsFound", procurementPlansItemsFound);
        model.addAttribute("orderperiodtype", request.getParameter("orderperiodtype"));
        return "controlPanel/localSettingsPanel/procurementplan/views/items";
    }


    // Has to be approved
    @RequestMapping(value = "/getpastfinancialyearstoimportfrom.htm")
    public @ResponseBody
    String getpastfinancialyearstoimportfrom(HttpServletRequest request) {
        List<Map> financialyrssFound = new ArrayList<>();
        String results = "";
        try {
            if ("getfinancialyrs".equals(request.getParameter("type"))) {
                String[] params2 = {"facilityid"};
                Object[] paramsValues2 = {Long.parseLong(String.valueOf((int) request.getSession().getAttribute("sessionActiveLoginFacility")))};
                String[] fields2 = {"facilityfinancialyearid", "startyear", "endyear"};
                List<Object[]> fnyr2 = (List<Object[]>) genericClassService.fetchRecord(Facilityfinancialyear.class, fields2, "WHERE facilityid=:facilityid", params2, paramsValues2);
                if (fnyr2 != null) {
                    Map<String, Object> financialyearRow;
                    for (Object[] fnyr : fnyr2) {
                        financialyearRow = new HashMap<>();
                        String[] params = {"facilityunitid", "facilityfinancialyearid", "proccessingstage"};
                        Object[] paramsValues = {Long.parseLong(String.valueOf((int) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))), (Long) fnyr[0], "approved"};
                        String[] fields = {"dateadded", "addedby"};
                        List<Object[]> procurementplans = (List<Object[]>) genericClassService.fetchRecord(Facilityunitfinancialyear.class, fields, "WHERE facilityunitid=:facilityunitid AND facilityfinancialyearid=:facilityfinancialyearid AND proccessingstage=:proccessingstage", params, paramsValues);
                        if (procurementplans != null) {
                            financialyearRow.put("facilityfinancialyearid", (Long) fnyr[0]);
                            financialyearRow.put("financialyear", (int) fnyr[1] + "-" + (int) fnyr[2]);
                            financialyrssFound.add(financialyearRow);
                        }
                    }
                }

                results = new ObjectMapper().writeValueAsString(financialyrssFound);

            } else {
                List<Map> facilityunitprocuredprocurementplans = new ArrayList<>();

                String[] params = {"facilityfinancialyearid", "proccessingstage"};
                Object[] paramsValues = {Long.parseLong(request.getParameter("facilityfinancialyearid")), "approved"};
                String[] fields = {"facilityunitfinancialyearid", "facilityunitlabel", "orderperiodid"};
                List<Object[]> financialyrs = (List<Object[]>) genericClassService.fetchRecord(Facilityunitfinancialyear.class, fields, "WHERE facilityfinancialyearid=:facilityfinancialyearid AND proccessingstage=:proccessingstage", params, paramsValues);
                if (financialyrs != null) {
                    Map<String, Object> procurementplanRow;
                    for (Object[] fnyrs : financialyrs) {
                        procurementplanRow = new HashMap<>();
                        String[] params1 = {"orderperiodid"};
                        Object[] paramsValues1 = {(int) fnyrs[2]};
                        String[] fields1 = {"orderperiodname", "orderperiodtype"};
                        List<Object[]> items1 = (List<Object[]>) genericClassService.fetchRecord(Orderperiod.class, fields1, "WHERE orderperiodid=:orderperiodid", params1, paramsValues1);
                        if (items1 != null) {
                            procurementplanRow.put("facilityunitfinancialyearid", (int) fnyrs[0]);
                            procurementplanRow.put("facilityunitlabel", (String) fnyrs[1] + "-" + items1.get(0)[0]);
                            procurementplanRow.put("orderperiodtype", items1.get(0)[1]);
                            int financialyunitritemsRowcount = 0;
                            String[] params6 = {"facilityunitfinancialyearid", "approved"};
                            Object[] paramsValues6 = {(int) fnyrs[0], Boolean.TRUE};
                            String where6 = "WHERE facilityunitfinancialyearid=:facilityunitfinancialyearid AND approved=:approved";
                            financialyunitritemsRowcount = genericClassService.fetchRecordCount(Facilityunitprocurementplan.class, where6, params6, paramsValues6);
                            procurementplanRow.put("financialyunitritemsRowcount", financialyunitritemsRowcount);
                            facilityunitprocuredprocurementplans.add(procurementplanRow);
                        }
                    }
                }
                results = new ObjectMapper().writeValueAsString(facilityunitprocuredprocurementplans);
            }
        } catch (JsonProcessingException ex) {
            Logger.getLogger(ProcurementPlanManagement.class.getName()).log(Level.SEVERE, null, ex);
        }
        return results;
    }

    @RequestMapping(value = "/viewfacilityunitprocurementitemstable.htm", method = RequestMethod.GET)
    public String ViewFacilityUnitProcurementItems(HttpServletRequest request, Model model) {
        List<Map> procurementPlansItemsFound = new ArrayList<>();
        if ("Quarterly".equals(request.getParameter("type"))) {
            String[] params = {"facilityunitfinancialyearid", "approved"};
            Object[] paramsValues = {Integer.parseInt(request.getParameter("facilityunitfinancialyearid")), Boolean.TRUE};
            String[] fields = {"itemid", "averagemonthlyconsumption", "averagequarterconsumption"};
            List<Object[]> financialyrs = (List<Object[]>) genericClassService.fetchRecord(Facilityunitprocurementplan.class, fields, "WHERE facilityunitfinancialyearid=:facilityunitfinancialyearid AND approved=:approved", params, paramsValues);
            if (financialyrs != null) {
                Map<String, Object> procurementplanIetmsRow;
                for (Object[] fnyrs : financialyrs) {
                    procurementplanIetmsRow = new HashMap<>();
                    String[] params1 = {"itemid"};
                    Object[] paramsValues1 = {(Long) fnyrs[0]};
                    String[] fields1 = {"genericname", "packsize", "unitcost"};
                    List<Object[]> itemsdetails = (List<Object[]>) genericClassService.fetchRecord(Item.class, fields1, "WHERE itemid=:itemid", params1, paramsValues1);
                    if (itemsdetails != null) {
                        procurementplanIetmsRow.put("averagemonthlyconsumption", ((Double) fnyrs[1]).intValue());
                        procurementplanIetmsRow.put("averagequarterconsumption", ((Double) fnyrs[2]).intValue());
                        procurementplanIetmsRow.put("genericname", itemsdetails.get(0)[0]);
                        procurementplanIetmsRow.put("packsize", itemsdetails.get(0)[1]);
                        procurementplanIetmsRow.put("unitcost", itemsdetails.get(0)[2]);
                        procurementPlansItemsFound.add(procurementplanIetmsRow);
                    }
                }
            }
        }
        model.addAttribute("orderperiodtype", request.getParameter("type"));
        model.addAttribute("items", procurementPlansItemsFound);
        return "controlPanel/localSettingsPanel/procurementplan/views/facilityUnitProcurementItems";
    }

    @RequestMapping(value = "/editandimportfacilityunitprocurementplanitems.htm", method = RequestMethod.GET)
    public String editandimportfacilityunitprocurementplanitems(HttpServletRequest request, Model model) {
        List<Map> procurementPlansItemsFound = new ArrayList<>();
        try {
            String[] params = {"facilityunitfinancialyearid"};
            Object[] paramsValues = {Integer.parseInt(request.getParameter("importtofacilityunitfinancialyearid"))};
            String[] fields = {"orderperiodid"};
            List<Integer> orderperiodid = (List<Integer>) genericClassService.fetchRecord(Facilityunitfinancialyear.class, fields, "WHERE facilityunitfinancialyearid=:facilityunitfinancialyearid", params, paramsValues);
            if (orderperiodid != null) {
                String[] params1 = {"orderperiodid"};
                Object[] paramsValues1 = {orderperiodid.get(0)};
                String[] fields1 = {"orderperiodtype"};
                List<String> orderperiodtype = (List<String>) genericClassService.fetchRecord(Orderperiod.class, fields1, "WHERE orderperiodid=:orderperiodid", params1, paramsValues1);
                if (orderperiodtype != null) {
                    model.addAttribute("importtoOrderperiod", orderperiodtype.get(0));
                    List<String> itemz = (ArrayList) new ObjectMapper().readValue(request.getParameter("values"), List.class);
                    String[] params2 = {"facilityunitfinancialyearid", "approved"};
                    Object[] paramsValues2 = {Integer.parseInt(itemz.get(0)), Boolean.TRUE};
                    String[] fields2 = {"itemid", "averagemonthlyconsumption", "averagequarterconsumption", "averageannualcomsumption"};
                    List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Facilityunitprocurementplan.class, fields2, "WHERE facilityunitfinancialyearid=:facilityunitfinancialyearid AND approved=:approved", params2, paramsValues2);
                    if (items != null) {
                        Map<String, Object> procurementplanIetmsRow;
                        for (Object[] itm : items) {
                            procurementplanIetmsRow = new HashMap<>();
                            String[] params3 = {"itempackageid"};
                            Object[] paramsValues3 = {(Long) itm[0]};
                            String[] fields3 = {"packagename", "packagequantity", "unitcost"};
                            List<Object[]> itemsdetails = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields3, "WHERE itempackageid=:itempackageid", params3, paramsValues3);
                            if (itemsdetails != null) {
                                procurementplanIetmsRow.put("averagemonthlyconsumption", ((Double) itm[1]).intValue());
                                procurementplanIetmsRow.put("genericname", itemsdetails.get(0)[0]);
                                procurementplanIetmsRow.put("packsize", itemsdetails.get(0)[1]);
                                procurementplanIetmsRow.put("unitcost", itemsdetails.get(0)[2]);
                                procurementplanIetmsRow.put("itemid", (Long) itm[0]);
                                if ("Quarterly".equals(orderperiodtype.get(0)) && "Quarterly".equals(request.getParameter("orderperiodtype"))) {
                                    procurementplanIetmsRow.put("averagequarterconsumption", ((Double) itm[2]).intValue());
                                } else if ("Annually".equals(orderperiodtype.get(0)) && "Quarterly".equals(request.getParameter("orderperiodtype"))) {
                                    procurementplanIetmsRow.put("averageannualcomsumption", (((Double) itm[2]) / 3) * 12);
                                } else if ("Monthly".equals(orderperiodtype.get(0)) && "Quarterly".equals(request.getParameter("orderperiodtype"))) {
                                    procurementplanIetmsRow.put("averageannualcomsumption", (((Double) itm[2]) / 3) * 12);
                                } else if ("Monthly".equals(orderperiodtype.get(0)) && "Monthly".equals(request.getParameter("orderperiodtype"))) {
                                    procurementplanIetmsRow.put("averageannualcomsumption", ((Double) itm[1]) * 12);
                                } else if ("Quarterly".equals(orderperiodtype.get(0)) && "Monthly".equals(request.getParameter("orderperiodtype"))) {
                                    procurementplanIetmsRow.put("averagequarterconsumption", ((Double) itm[1]) * 3);
                                } else if ("Annually".equals(orderperiodtype.get(0)) && "Monthly".equals(request.getParameter("orderperiodtype"))) {
                                    procurementplanIetmsRow.put("averageannualcomsumption", ((Double) itm[1]) * 12);
                                } else if ("Monthly".equals(orderperiodtype.get(0)) && "Annually".equals(request.getParameter("orderperiodtype"))) {
                                    procurementplanIetmsRow.put("averageannualcomsumption", ((Double) itm[3]));
                                } else if ("Quarterly".equals(orderperiodtype.get(0)) && "Annually".equals(request.getParameter("orderperiodtype"))) {
                                    procurementplanIetmsRow.put("averagequarterconsumption", ((Double) itm[3]) / 4);
                                } else if ("Annually".equals(orderperiodtype.get(0)) && "Annually".equals(request.getParameter("orderperiodtype"))) {
                                    procurementplanIetmsRow.put("averageannualcomsumption", ((Double) itm[3]));
                                }
                                procurementPlansItemsFound.add(procurementplanIetmsRow);
                            }
                        }
                    }
                }
            }
        } catch (IOException e) {
        }
        model.addAttribute("items", procurementPlansItemsFound);
        model.addAttribute("importtofacilityunitfnyid", request.getParameter("importtofacilityunitfinancialyearid"));
        return "controlPanel/localSettingsPanel/procurementplan/views/editFinancialYearItemToImport";
    }

    @RequestMapping(value = "/saveandorsubmitprocurementplan.htm")
    public @ResponseBody
    String saveandsubmitprocurementforverification(HttpServletRequest request
    ) {
        String results = "";
        if ("submit".equals(request.getParameter("type"))) {
            List<Map> item;
            try {
                if ("Quarterly".equals(request.getParameter("orderperiodtype"))) {
                    item = (ArrayList) new ObjectMapper().readValue(request.getParameter("values"), List.class);
                    for (Map item1 : item) {
                        Map<String, Object> map = (HashMap) item1;
                        Facilityunitprocurementplan facilityprocurementplan = new Facilityunitprocurementplan();
                        facilityprocurementplan.setAddedby(BigInteger.valueOf((Long) request.getSession().getAttribute("person_id")));
                        facilityprocurementplan.setApproved(Boolean.FALSE);
                        facilityprocurementplan.setDateadded(new Date());
                        facilityprocurementplan.setAveragequarterconsumption(Double.parseDouble((String) map.get("quarter")));
                        facilityprocurementplan.setAveragemonthlyconsumption(Double.parseDouble((String) map.get("monthly")));
                        facilityprocurementplan.setFacilityunitfinancialyearid(new Facilityunitfinancialyear(Integer.parseInt(request.getParameter("procurementid"))));
                        facilityprocurementplan.setItemid(new Item(Long.parseLong((String) map.get("itemid"))));
                        genericClassService.saveOrUpdateRecordLoadObject(facilityprocurementplan);
                    }
                } else {
                    item = (ArrayList) new ObjectMapper().readValue(request.getParameter("values"), List.class);
                    for (Map item1 : item) {
                        Map<String, Object> map = (HashMap) item1;
                        Facilityunitprocurementplan facilityprocurementplan = new Facilityunitprocurementplan();
                        facilityprocurementplan.setAddedby(BigInteger.valueOf((Long) request.getSession().getAttribute("person_id")));
                        facilityprocurementplan.setApproved(Boolean.FALSE);
                        facilityprocurementplan.setDateadded(new Date());
                        facilityprocurementplan.setAverageannualcomsumption(Double.parseDouble((String) map.get("annual")));
                        facilityprocurementplan.setAveragemonthlyconsumption(Double.parseDouble((String) map.get("monthly")));
                        facilityprocurementplan.setFacilityunitfinancialyearid(new Facilityunitfinancialyear(Integer.parseInt(request.getParameter("procurementid"))));
                        facilityprocurementplan.setItemid(new Item(Long.parseLong((String) map.get("itemid"))));
                        genericClassService.saveOrUpdateRecordLoadObject(facilityprocurementplan);
                    }
                }
                String[] columns = {"proccessingstage"};
                Object[] columnValues = {"submitted"};
                String pk = "facilityunitfinancialyearid";
                Object pkValue = Integer.parseInt(request.getParameter("procurementid"));
                int result = genericClassService.updateRecordSQLSchemaStyle(Facilityunitfinancialyear.class, columns, columnValues, pk, pkValue, "store");
                if (result != 0) {
                    results = "success";
                }
            } catch (IOException ex) {
                Logger.getLogger(ProcurementPlanManagement.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if ("paused".equals(request.getParameter("type"))) {
            List<Map> item;
            try {
                if ("Quarterly".equals(request.getParameter("orderperiodtype"))) {
                    item = (ArrayList) new ObjectMapper().readValue(request.getParameter("values"), List.class);
                    for (Map item1 : item) {
                        Map<String, Object> map = (HashMap) item1;
                        Facilityunitprocurementplan facilityprocurementplan = new Facilityunitprocurementplan();
                        facilityprocurementplan.setAddedby(BigInteger.valueOf((Long) request.getSession().getAttribute("person_id")));
                        facilityprocurementplan.setApproved(Boolean.FALSE);
                        facilityprocurementplan.setDateadded(new Date());
                        facilityprocurementplan.setAveragequarterconsumption(Double.parseDouble((String) map.get("quarter")));
                        facilityprocurementplan.setAveragemonthlyconsumption(Double.parseDouble((String) map.get("monthly")));
                        facilityprocurementplan.setFacilityunitfinancialyearid(new Facilityunitfinancialyear(Integer.parseInt(request.getParameter("procurementid"))));
                        facilityprocurementplan.setItemid(new Item(Long.parseLong((String) map.get("itemid"))));
                        genericClassService.saveOrUpdateRecordLoadObject(facilityprocurementplan);
                    }
                } else {
                    item = (ArrayList) new ObjectMapper().readValue(request.getParameter("values"), List.class);
                    for (Map item1 : item) {
                        Map<String, Object> map = (HashMap) item1;
                        Facilityunitprocurementplan facilityprocurementplan = new Facilityunitprocurementplan();
                        facilityprocurementplan.setAddedby(BigInteger.valueOf((Long) request.getSession().getAttribute("person_id")));
                        facilityprocurementplan.setApproved(Boolean.FALSE);
                        facilityprocurementplan.setDateadded(new Date());
                        facilityprocurementplan.setAverageannualcomsumption(Double.parseDouble((String) map.get("annual")));
                        facilityprocurementplan.setAveragemonthlyconsumption(Double.parseDouble((String) map.get("monthly")));
                        facilityprocurementplan.setFacilityunitfinancialyearid(new Facilityunitfinancialyear(Integer.parseInt(request.getParameter("procurementid"))));
                        facilityprocurementplan.setItemid(new Item(Long.parseLong((String) map.get("itemid"))));
                        genericClassService.saveOrUpdateRecordLoadObject(facilityprocurementplan);
                    }
                }
                String[] columns = {"proccessingstage"};
                Object[] columnValues = {"paused"};
                String pk = "facilityunitfinancialyearid";
                Object pkValue = Integer.parseInt(request.getParameter("procurementid"));
                int result = genericClassService.updateRecordSQLSchemaStyle(Facilityunitfinancialyear.class, columns, columnValues, pk, pkValue, "store");
                if (result != 0) {
                    results = "success";
                }
            } catch (IOException ex) {
                Logger.getLogger(ProcurementPlanManagement.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return results;
    }

    @RequestMapping(value = "/pausedprocurementplans.htm", method = RequestMethod.GET)
    public String pausedprocurementplans(Model model, HttpServletRequest request) {
        List<Map> financialyrssFound = new ArrayList<>();

        String[] params2 = {"facilityid", "isthecurrent","istopdownapproach"};
        Object[] paramsValues2 = {Long.parseLong(String.valueOf((int) request.getSession().getAttribute("sessionActiveLoginFacility"))), Boolean.TRUE,Boolean.FALSE};
        String[] fields2 = {"facilityfinancialyearid", "startyear", "endyear"};
        List<Object[]> fnyr2 = (List<Object[]>) genericClassService.fetchRecord(Facilityfinancialyear.class, fields2, "WHERE facilityid=:facilityid AND isthecurrent=:isthecurrent AND istopdownapproach=:istopdownapproach", params2, paramsValues2);
        if (fnyr2 != null) {
            Map<String, Object> financialyearRow;
            for (Object[] fnyr : fnyr2) {
                financialyearRow = new HashMap<>();
                financialyearRow.put("facilityfinancialyearid", (Long) fnyr[0]);
                financialyearRow.put("financialyear", (int) fnyr[1] + "-" + (int) fnyr[2]);
                financialyrssFound.add(financialyearRow);
            }
        }
        model.addAttribute("financialyr", financialyrssFound);
        model.addAttribute("size", financialyrssFound.size());
        return "controlPanel/localSettingsPanel/procurementplan/pausedProcurementPlans/views/pausedProcurementPlan";
    }

    @RequestMapping(value = "/pausedfinancialyearperiodstable.htm", method = RequestMethod.GET)
    public String pausedfinancialyearperiodstable(Model model, HttpServletRequest request) {
        List<Map> financialyrssFound = new ArrayList<>();
        String[] params = {"facilityunitid", "facilityfinancialyearid", "proccessingstage"};
        Object[] paramsValues = {Long.parseLong(String.valueOf((int) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))), Long.parseLong(request.getParameter("pausedprocurementfacilityyr")), "paused"};
        String[] fields = {"facilityunitfinancialyearid", "facilityunitlabel", "orderperiodid"};
        List<Object[]> procurementplans = (List<Object[]>) genericClassService.fetchRecord(Facilityunitfinancialyear.class, fields, "WHERE facilityunitid=:facilityunitid AND facilityfinancialyearid=:facilityfinancialyearid AND proccessingstage=:proccessingstage", params, paramsValues);
        if (procurementplans != null) {
            Map<String, Object> facilityuintprocurementplanRow;
            for (Object[] pln : procurementplans) {
                facilityuintprocurementplanRow = new HashMap<>();
                String[] params1 = {"orderperiodid"};
                Object[] paramsValues1 = {(int) pln[2]};
                String[] fields1 = {"startdate", "enddate", "orderperiodname", "orderperiodtype"};
                List<Object[]> procurementplans1 = (List<Object[]>) genericClassService.fetchRecord(Orderperiod.class, fields1, "WHERE orderperiodid=:orderperiodid", params1, paramsValues1);
                if (procurementplans1 != null) {

                    int financialyritemsRowcount = 0;
                    String[] params3 = {"facilityunitfinancialyearid", "approved"};
                    Object[] paramsValues3 = {(int) pln[0], Boolean.FALSE};
                    String where3 = "WHERE facilityunitfinancialyearid=:facilityunitfinancialyearid AND approved=:approved";
                    financialyritemsRowcount = genericClassService.fetchRecordCount(Facilityunitprocurementplan.class, where3, params3, paramsValues3);
                    if (financialyritemsRowcount != 0) {
                        facilityuintprocurementplanRow.put("facilityunitfinancialyearid", (int) pln[0]);
                        facilityuintprocurementplanRow.put("facilityunitlabel", (String) pln[1] + "-" + procurementplans1.get(0)[2]);
                        facilityuintprocurementplanRow.put("startdate", procurementplans1.get(0)[0]);
                        facilityuintprocurementplanRow.put("enddate", procurementplans1.get(0)[1]);
                        facilityuintprocurementplanRow.put("orderperiodtype", procurementplans1.get(0)[3]);
                        facilityuintprocurementplanRow.put("financialyritemsRowcount", financialyritemsRowcount);
                        financialyrssFound.add(facilityuintprocurementplanRow);
                    } else {
                        String[] columns = {"proccessingstage"};
                        Object[] columnValues = {"created"};
                        String pk = "facilityunitfinancialyearid";
                        Object pkValue = (int) pln[0];
                        int result = genericClassService.updateRecordSQLSchemaStyle(Facilityunitfinancialyear.class, columns, columnValues, pk, pkValue, "store");
                    }

                }
            }
        }
        model.addAttribute("facilityunitprocurementplans", financialyrssFound);
        model.addAttribute("size", financialyrssFound.size());
        model.addAttribute("pausedprocurementfacilityyr", request.getParameter("pausedprocurementfacilityyr"));
        return "controlPanel/localSettingsPanel/procurementplan/pausedProcurementPlans/views/pausedProcurementsPlansTable";
    }

    @RequestMapping(value = "/submitordeletefacilityunitprocurementplan.htm")
    public @ResponseBody
    String submitordeletefacilityunitprocurementplan(HttpServletRequest request) {
        String results = "";
        if ("submit".equals(request.getParameter("type"))) {
            String[] columns = {"proccessingstage"};
            Object[] columnValues = {"submitted"};
            String pk = "facilityunitfinancialyearid";
            Object pkValue = Integer.parseInt(request.getParameter("facilityunitfinancialyearid"));

            int result = genericClassService.updateRecordSQLSchemaStyle(Facilityunitfinancialyear.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                results = "success";
            } else {
                results = "fail";
            }
        } else {
            String[] columns = {"facilityunitfinancialyearid"};
            Object[] columnValues = {Integer.parseInt(request.getParameter("facilityunitfinancialyearid"))};
            int result = genericClassService.deleteRecordByByColumns("store.facilityunitprocurementplan", columns, columnValues);
            if (result != 0) {

                String[] columns1 = {"proccessingstage"};
                Object[] columnValues1 = {"created"};
                String pk1 = "facilityunitfinancialyearid";
                Object pkValue1 = Integer.parseInt(request.getParameter("facilityunitfinancialyearid"));
                int result1 = genericClassService.updateRecordSQLSchemaStyle(Facilityunitfinancialyear.class, columns1, columnValues1, pk1, pkValue1, "store");

            } else {
                results = "fail";
            }
        }
        return results;
    }

    @RequestMapping(value = "/getfacilityunitaddedprocurementplanitems.htm")
    public @ResponseBody
    String getfacilityunitaddedprocurementplanitems(HttpServletRequest request) {
        String results = "";
        Set<Long> itemsid = new HashSet<>();
        try {
            String[] params = {"facilityunitfinancialyearid", "approved"};
            Object[] paramsValues = {Integer.parseInt(request.getParameter("facilityunitfinancialyearid")), Boolean.TRUE};
            String[] fields = {"itemid"};
            List<Long> itemsprocurementplans = (List<Long>) genericClassService.fetchRecord(Facilityunitprocurementplan.class, fields, "WHERE facilityunitfinancialyearid=:facilityunitfinancialyearid AND approved=:approved", params, paramsValues);
            if (itemsprocurementplans != null) {
                for (Long itemsprocurementplan : itemsprocurementplans) {
                    itemsid.add(itemsprocurementplan);
                }
            }
            results = new ObjectMapper().writeValueAsString(itemsid);
        } catch (IOException e) {
        }
        return results;
    }

    @RequestMapping(value = "/pausedfacilityunitprocurementplanitems.htm", method = RequestMethod.GET)
    public String pausedfacilityunitprocurementplanitems(Model model, HttpServletRequest request) {
        List<Map> itemsFound = new ArrayList<>();

        String[] params = {"facilityunitfinancialyearid", "approved"};
        Object[] paramsValues = {Integer.parseInt(request.getParameter("facilityunitfinancialyearid")), Boolean.FALSE};
        String[] fields = {"facilityunitprocurementplanid", "itemid", "averagemonthlyconsumption", "averagequarterconsumption", "averageannualcomsumption"};
        List<Object[]> procurementplansitems = (List<Object[]>) genericClassService.fetchRecord(Facilityunitprocurementplan.class, fields, "WHERE facilityunitfinancialyearid=:facilityunitfinancialyearid AND approved=:approved", params, paramsValues);
        if (procurementplansitems != null) {
            Map<String, Object> facilityuintprocurementplanRow;
            for (Object[] procitems : procurementplansitems) {
                facilityuintprocurementplanRow = new HashMap<>();
                String[] params1 = {"itempackageid"};
                Object[] paramsValues1 = {(Long) procitems[1]};
                String[] fields1 = {"packagename", "packagequantity"};
                List<Object[]> itemsdetails = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields1, "WHERE itempackageid=:itempackageid", params1, paramsValues1);
                if (itemsdetails != null) {
                    facilityuintprocurementplanRow.put("monthqty", ((Double) procitems[2]).intValue());
                    facilityuintprocurementplanRow.put("facilityunitprocurementplanid", (int) procitems[0]);
                    facilityuintprocurementplanRow.put("genericname", itemsdetails.get(0)[0]);
                    facilityuintprocurementplanRow.put("packsize", itemsdetails.get(0)[1]);
                    facilityuintprocurementplanRow.put("itemid", (Long) procitems[1]);
                    if ("Quarterly".equals(request.getParameter("orderperiodtype"))) {
                        facilityuintprocurementplanRow.put("quarterlyqty", ((Double) procitems[3]).intValue());
                    } else {
                        facilityuintprocurementplanRow.put("annualqty", ((Double) procitems[4]).intValue());
                    }
                    itemsFound.add(facilityuintprocurementplanRow);
                }
            }
        }
        model.addAttribute("itemsFound", itemsFound);
        model.addAttribute("orderperiodtype", request.getParameter("orderperiodtype"));
        return "controlPanel/localSettingsPanel/procurementplan/pausedProcurementPlans/forms/items";
    }

    @RequestMapping(value = "/deleteprocurementitems.htm")
    public @ResponseBody
    String deleteprocurementitems(HttpServletRequest request) {
        String results = "";
        String[] columns = {"facilityunitfinancialyearid", "itemid"};
        Object[] columnValues = {Integer.parseInt(request.getParameter("facilityunitfinancialyearid")), Long.parseLong(request.getParameter("itemid"))};
        int result = genericClassService.deleteRecordByByColumns("store.facilityunitprocurementplan", columns, columnValues);
        if (result != 0) {
            results = "success";
        } else {
            results = "fail";
        }
        return results;
    }

    @RequestMapping(value = "/saveprocurementplanupdates.htm")
    public @ResponseBody
    String saveprocurementplanupdates(HttpServletRequest request) {
        String results = "";
        List<Map> item;
        try {
            item = (ArrayList) new ObjectMapper().readValue(request.getParameter("values"), List.class);
            for (Map item1 : item) {
                Map<String, Object> map = (HashMap) item1;
                String[] params1 = {"facilityunitfinancialyearid", "itemid"};
                Object[] paramsValues1 = {Integer.parseInt(request.getParameter("facilityunitfinancialyearid")), Long.parseLong((String) map.get("itemid"))};
                String[] fields1 = {"facilityunitprocurementplanid"};
                List<Integer> fnyritems = (List<Integer>) genericClassService.fetchRecord(Facilityunitprocurementplan.class, fields1, "WHERE facilityunitfinancialyearid=:facilityunitfinancialyearid AND itemid=:itemid", params1, paramsValues1);
                if (fnyritems != null) {
                    if ("Quarterly".equals(request.getParameter("pausedordertype"))) {
                        String[] columns = {"averagemonthlyconsumption", "averagequarterconsumption"};
                        Object[] columnValues = {Double.parseDouble((String) map.get("monthly")), Double.parseDouble((String) map.get("quarter"))};
                        String pk = "facilityunitprocurementplanid";
                        Object pkValue = fnyritems.get(0);
                        int result = genericClassService.updateRecordSQLSchemaStyle(Facilityunitprocurementplan.class, columns, columnValues, pk, pkValue, "store");
                    } else {
                        String[] columns = {"averagemonthlyconsumption", "averageannualcomsumption"};
                        Object[] columnValues = {Double.parseDouble((String) map.get("monthly")), Double.parseDouble((String) map.get("annual"))};
                        String pk = "facilityunitprocurementplanid";
                        Object pkValue = fnyritems.get(0);
                        int result = genericClassService.updateRecordSQLSchemaStyle(Facilityunitprocurementplan.class, columns, columnValues, pk, pkValue, "store");
                    }
                }
            }

        } catch (IOException ex) {
            Logger.getLogger(ProcurementPlanManagement.class.getName()).log(Level.SEVERE, null, ex);
        }
        return results;
    }

    @RequestMapping(value = "/rejectormodifiedfacilityunitprocurementplanitem.htm")
    public @ResponseBody
    String rejectormodifiedfacilityunitprocurementplanitem(HttpServletRequest request) {
        String results = "";
        if ("reject".equals(request.getParameter("type"))) {
            String[] params = {"facilityunitfinancialyearid", "itemid"};
            Object[] paramsValues = {Integer.parseInt(request.getParameter("facilityunitfinancialyearid")), Long.parseLong(request.getParameter("itemid"))};
            String[] fields = {"facilityunitprocurementplanid"};
            List<Integer> procurementplansitems = (List<Integer>) genericClassService.fetchRecord(Facilityunitprocurementplan.class, fields, "WHERE facilityunitfinancialyearid=:facilityunitfinancialyearid AND itemid=:itemid", params, paramsValues);
            if (procurementplansitems != null) {
                String[] columns = {"approved", "lastupdated", "lastupdatedby"};
                Object[] columnValues = {Boolean.FALSE, new Date(), (Long) request.getSession().getAttribute("person_id")};
                String pk = "facilityunitprocurementplanid";
                Object pkValue = procurementplansitems.get(0);
                int result = genericClassService.updateRecordSQLSchemaStyle(Facilityunitprocurementplan.class, columns, columnValues, pk, pkValue, "store");
                if (result != 0) {
                    results = "success";
                }
            }
        } else if ("readd".equals(request.getParameter("type"))) {
            String[] params = {"facilityunitfinancialyearid", "itemid"};
            Object[] paramsValues = {Integer.parseInt(request.getParameter("facilityunitfinancialyearid")), Long.parseLong(request.getParameter("itemid"))};
            String[] fields = {"facilityunitprocurementplanid"};
            List<Integer> procurementplansitems = (List<Integer>) genericClassService.fetchRecord(Facilityunitprocurementplan.class, fields, "WHERE facilityunitfinancialyearid=:facilityunitfinancialyearid AND itemid=:itemid", params, paramsValues);
            if (procurementplansitems != null) {
                String[] columns = {"approved"};
                Object[] columnValues = {Boolean.TRUE};
                String pk = "facilityunitprocurementplanid";
                Object pkValue = procurementplansitems.get(0);
                int result = genericClassService.updateRecordSQLSchemaStyle(Facilityunitprocurementplan.class, columns, columnValues, pk, pkValue, "store");
                if (result != 0) {
                    results = "success";
                }
            }
        } else if ("deactivate".equals(request.getParameter("type"))) {
            String[] columns = {"approved"};
            Object[] columnValues = {Boolean.FALSE};
            String pk = "facilityunitprocurementplanid";
            Object pkValue = Integer.parseInt(request.getParameter("facilityunitprocurementplanid"));
            int result = genericClassService.updateRecordSQLSchemaStyle(Facilityunitprocurementplan.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                results = "success";
            }
        }
        return results;
    }

    @RequestMapping(value = "/saveorupdateorrejectandorpausefacilityunitprocurementplan.htm")
    public @ResponseBody
    String saveorupdateorrejectandorpauseprocurementplan(HttpServletRequest request) {
        String results = "";
        if (null == request.getParameter("type")) {
        } else {
            switch (request.getParameter("type")) {
                case "partial":
                    try {
                        List<Map> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("values"), List.class);

                        for (Map item1 : item) {
                            Map<String, Object> map = (HashMap) item1;
                            String[] params1 = {"facilityunitfinancialyearid", "itemid"};
                            Object[] paramsValues1 = {Integer.parseInt(request.getParameter("procurementid")), Long.parseLong((String) map.get("itemid"))};
                            String[] fields1 = {"facilityunitprocurementplanid"};
                            List<Integer> fnyritems = (List<Integer>) genericClassService.fetchRecord(Facilityunitprocurementplan.class, fields1, "WHERE facilityunitfinancialyearid=:facilityunitfinancialyearid AND itemid=:itemid", params1, paramsValues1);
                            if (fnyritems != null) {
                                if ("Quarterly".equals(request.getParameter("typeperiod"))) {
                                    String[] columns = {"averagemonthlyconsumption", "averagequarterconsumption", "approved", "status", "lastupdated", "lastupdatedby"};
                                    Object[] columnValues = {Double.parseDouble((String) map.get("monthly")), Double.parseDouble((String) map.get("quarter")), Boolean.TRUE, "updated", new Date(), (Long) request.getSession().getAttribute("person_id")};
                                    String pk = "facilityunitprocurementplanid";
                                    Object pkValue = fnyritems.get(0);
                                    int result = genericClassService.updateRecordSQLSchemaStyle(Facilityunitprocurementplan.class, columns, columnValues, pk, pkValue, "store");
                                } else {
                                    String[] columns = {"averagemonthlyconsumption", "averageannualcomsumption", "approved", "status", "lastupdated", "lastupdatedby"};
                                    Object[] columnValues = {Double.parseDouble((String) map.get("monthly")), Double.parseDouble((String) map.get("annual")), Boolean.TRUE, "updated", new Date(), (Long) request.getSession().getAttribute("person_id")};
                                    String pk = "facilityunitprocurementplanid";
                                    Object pkValue = fnyritems.get(0);
                                    int result = genericClassService.updateRecordSQLSchemaStyle(Facilityunitprocurementplan.class, columns, columnValues, pk, pkValue, "store");
                                }

                            }
                        }

                    } catch (IOException ex) {
                        Logger.getLogger(ProcurementPlanManagement.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    String[] columns1 = {"proccessingstage", "lastupdatedby", "lastupdated"};
                    Object[] columnValues1 = {"partial", (Long) request.getSession().getAttribute("person_id"), new Date()};
                    String pk1 = "facilityunitfinancialyearid";
                    Object pkValue1 = Integer.parseInt(request.getParameter("procurementid"));
                    int result1 = genericClassService.updateRecordSQLSchemaStyle(Facilityunitfinancialyear.class, columns1, columnValues1, pk1, pkValue1, "store");
                    break;
                case "approved":
                    try {
                        List<Map> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("values"), List.class);
                        for (Map item1 : item) {
                            Map<String, Object> map = (HashMap) item1;
                            String[] params1 = {"facilityunitfinancialyearid", "itemid"};
                            Object[] paramsValues1 = {Integer.parseInt(request.getParameter("procurementid")), Long.parseLong((String) map.get("itemid"))};
                            String[] fields1 = {"facilityunitprocurementplanid"};
                            List<Integer> fnyritems = (List<Integer>) genericClassService.fetchRecord(Facilityunitprocurementplan.class, fields1, "WHERE facilityunitfinancialyearid=:facilityunitfinancialyearid AND itemid=:itemid", params1, paramsValues1);
                            if (fnyritems != null) {
                                if ("Quarterly".equals(request.getParameter("typeperiod"))) {
                                    String[] columns = {"averagemonthlyconsumption", "averagequarterconsumption", "approved", "status", "lastupdated", "lastupdatedby"};
                                    Object[] columnValues = {Double.parseDouble((String) map.get("monthly")), Double.parseDouble((String) map.get("quarter")), Boolean.TRUE, "updated", new Date(), (Long) request.getSession().getAttribute("person_id")};
                                    String pk = "facilityunitprocurementplanid";
                                    Object pkValue = fnyritems.get(0);
                                    int result = genericClassService.updateRecordSQLSchemaStyle(Facilityunitprocurementplan.class, columns, columnValues, pk, pkValue, "store");
                                } else {
                                    String[] columns = {"averagemonthlyconsumption", "averageannualcomsumption", "approved", "status", "lastupdated", "lastupdatedby"};
                                    Object[] columnValues = {Double.parseDouble((String) map.get("monthly")), Double.parseDouble((String) map.get("annual")), Boolean.TRUE, "updated", new Date(), (Long) request.getSession().getAttribute("person_id")};
                                    String pk = "facilityunitprocurementplanid";
                                    Object pkValue = fnyritems.get(0);
                                    int result = genericClassService.updateRecordSQLSchemaStyle(Facilityunitprocurementplan.class, columns, columnValues, pk, pkValue, "store");
                                }

                            }
                        }
                    } catch (IOException ex) {
                        Logger.getLogger(ProcurementPlanManagement.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    String[] columns4 = {"proccessingstage", "lastupdatedby", "lastupdated"};
                    Object[] columnValues4 = {"approved", (Long) request.getSession().getAttribute("person_id"), new Date()};
                    String pk4 = "facilityunitfinancialyearid";
                    Object pkValue4 = Integer.parseInt(request.getParameter("procurementid"));
                    int result4 = genericClassService.updateRecordSQLSchemaStyle(Facilityunitfinancialyear.class, columns4, columnValues4, pk4, pkValue4, "store");
                    break;
                default:
                    break;
            }
        }
        return results;
    }

    @RequestMapping(value = "/approvedfacilityunitprocurementitems.htm", method = RequestMethod.GET)
    public String approvedfacilityunitprocurementitems(HttpServletRequest request, Model model) {
        List<Map> procurementPlansFound = new ArrayList<>();
        String[] params = {"facilityunitfinancialyearid"};
        Object[] paramsValues = {Integer.parseInt(request.getParameter("facilityunitfinancialyearid"))};
        String[] fields = {"facilityunitprocurementplanid", "averagemonthlyconsumption", "averagequarterconsumption", "averageannualcomsumption", "itemid", "approved", "approvalcomment", "status"};
        String where = "WHERE facilityunitfinancialyearid=:facilityunitfinancialyearid";
        List<Object[]> facilityunitprocurementplanitems = (List<Object[]>) genericClassService.fetchRecord(Facilityunitprocurementplan.class, fields, where, params, paramsValues);
        if (facilityunitprocurementplanitems != null) {
            Map<String, Object> procrementitems;
            for (Object[] facilityunitprocurementplan : facilityunitprocurementplanitems) {
                procrementitems = new HashMap<>();
                String[] params1 = {"itempackageid"};
                Object[] paramsValues1 = {(Long) facilityunitprocurementplan[4]};
                String[] fields1 = {"packagename", "packagequantity"};
                List<Object[]> fnyritems = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields1, "WHERE itempackageid=:itempackageid", params1, paramsValues1);
                if (fnyritems != null) {
                    if ((Boolean) facilityunitprocurementplan[5] == true) {
                        procrementitems.put("facilityunitprocurementplanid", (int) facilityunitprocurementplan[0]);
                        procrementitems.put("averagemonthlyconsumption", ((Double) facilityunitprocurementplan[1]).intValue());
                        if ("Quarterly".equals(request.getParameter("type"))) {
                            procrementitems.put("averagequarterconsumption", ((Double) facilityunitprocurementplan[2]).intValue());
                        } else {
                            procrementitems.put("averageannualcomsumption", ((Double) facilityunitprocurementplan[3]).intValue());
                        }
                        procrementitems.put("approved", (Boolean) facilityunitprocurementplan[5]);
                        procrementitems.put("approvalcomment", (String) facilityunitprocurementplan[6]);
                        procrementitems.put("status", (String) facilityunitprocurementplan[7]);
                        procrementitems.put("genericname", fnyritems.get(0)[0]);
                        procrementitems.put("packsize", fnyritems.get(0)[1]);
                        procrementitems.put("itemid", (Long) facilityunitprocurementplan[4]);
                        procurementPlansFound.add(procrementitems);
                    }
                }

            }
        }
        model.addAttribute("type", request.getParameter("type"));
        model.addAttribute("facilityunitfinancialyearid", request.getParameter("facilityunitfinancialyearid"));
        model.addAttribute("procurementPlansItemsFound", procurementPlansFound);
        return "controlPanel/localSettingsPanel/procurementplan/verifyProcurementPlan/forms/items";
    }

    @RequestMapping(value = "/editfacilityunitprocurementitems.htm", method = RequestMethod.GET)
    public String editfacilityunitprocurementitems(HttpServletRequest request, Model model) {
        model.addAttribute("facilityunitprocurementplanid", request.getParameter("facilityunitprocurementplanid"));
        model.addAttribute("type", request.getParameter("type"));
        model.addAttribute("genericname", request.getParameter("genericname"));
        model.addAttribute("quarterormonth", request.getParameter("quarterormonth"));
        model.addAttribute("averagemonthlyconsumption", request.getParameter("averagemonthlyconsumption"));

        return "controlPanel/localSettingsPanel/procurementplan/verifyProcurementPlan/forms/editItemValues";
    }

    @RequestMapping(value = "/editprocurementunitplan.htm")
    public @ResponseBody
    String editprocurementunitplan(HttpServletRequest request) {
        String results = "";
        if ("Quarterly".equals(request.getParameter("type"))) {
            String[] columns4 = {"averagemonthlyconsumption", "averagequarterconsumption", "lastupdated", "lastupdatedby"};
            Object[] columnValues4 = {Double.parseDouble(request.getParameter("monthly")), Double.parseDouble(request.getParameter("othervalues")), new Date(), (Long) request.getSession().getAttribute("person_id")};
            String pk4 = "facilityunitprocurementplanid";
            Object pkValue4 = Integer.parseInt(request.getParameter("facilityunitprocurementplanid"));
            int result4 = genericClassService.updateRecordSQLSchemaStyle(Facilityunitprocurementplan.class, columns4, columnValues4, pk4, pkValue4, "store");
        } else {
            String[] columns4 = {"averagemonthlyconsumption", "averageannualcomsumption", "lastupdated", "lastupdatedby"};
            Object[] columnValues4 = {Double.parseDouble(request.getParameter("monthly")), Double.parseDouble(request.getParameter("othervalues")), new Date(), (Long) request.getSession().getAttribute("person_id")};
            String pk4 = "facilityunitprocurementplanid";
            Object pkValue4 = Integer.parseInt(request.getParameter("facilityunitprocurementplanid"));
            int result4 = genericClassService.updateRecordSQLSchemaStyle(Facilityunitprocurementplan.class, columns4, columnValues4, pk4, pkValue4, "store");
        }

        return results;
    }
}
