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
import com.iics.store.Facilityprocurementplan;
import com.iics.store.Facilityunitfinancialyear;
import com.iics.store.Facilityunitprocurementplan;
import com.iics.store.Item;
import com.iics.store.Itemcategories;
import com.iics.store.Itempackage;
import com.iics.store.Orderissuance;
import com.iics.store.Orderperiod;
import com.iics.store.Prescriptionissuance;
import com.iics.store.Stock;
import java.io.IOException;
import java.math.BigInteger;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author IICS
 */
@Controller
@RequestMapping("/facilityprocurementplanmanagement")
public class FacilityProcurementPlan {

    NumberFormat decimalFormat = NumberFormat.getInstance();
    DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    @Autowired
    GenericClassService genericClassService;

    @RequestMapping(value = "/facilityprocurementplanhome.htm", method = RequestMethod.GET)
    public String FacilityProcurementPlanHome(Model model, HttpServletRequest request) {
        List<Map> financialyrslists = new ArrayList<>();
        String[] params = {"facilityid"};
        Object[] paramsValues = {Long.parseLong(String.valueOf((int) request.getSession().getAttribute("sessionActiveLoginFacility")))};
        String[] fields = {"facilityfinancialyearid", "startyear", "endyear", "isthecurrent", "istopdownapproach", "financialyearstartdate", "financialyearenddate", "procuringopendate", "procuringclosedate", "approvalopendate", "approvalclosedate"};
        List<Object[]> financialyrs = (List<Object[]>) genericClassService.fetchRecord(Facilityfinancialyear.class, fields, "WHERE facilityid=:facilityid ORDER BY r.startyear DESC", params, paramsValues);
        if (financialyrs != null) {
            Map<String, Object> financialyrsRow;
            for (Object[] fnyr : financialyrs) {
                financialyrsRow = new HashMap<>();
                financialyrsRow.put("facilityfinancialyearid", (Long) fnyr[0]);
                financialyrsRow.put("startyear", (int) fnyr[1]);
                financialyrsRow.put("endyear", (int) fnyr[2]);
                financialyrsRow.put("isthecurrent", (Boolean) fnyr[3]);

                if (fnyr[5] != null) {
                    financialyrsRow.put("financialyearstartdate", formatter.format((Date) fnyr[5]));
                } else {
                    financialyrsRow.put("financialyearstartdate", "NO DATE");
                }
                if (fnyr[6] != null) {
                    financialyrsRow.put("financialyearenddate", formatter.format((Date) fnyr[6]));
                } else {
                    financialyrsRow.put("financialyearenddate", "NO DATE");
                }
                if (fnyr[7] != null) {
                    financialyrsRow.put("procuringopendate", formatter.format((Date) fnyr[7]));
                } else {
                    financialyrsRow.put("procuringopendate", "NO DATE");
                }
                if (fnyr[8] != null) {
                    financialyrsRow.put("procuringclosedate", formatter.format((Date) fnyr[8]));
                } else {
                    financialyrsRow.put("procuringclosedate", "NO DATE");
                }
                if (fnyr[9] != null) {
                    financialyrsRow.put("approvalopendate", formatter.format((Date) fnyr[9]));
                } else {
                    financialyrsRow.put("approvalopendate", "NO DATE");
                }
                if (fnyr[10] != null) {
                    financialyrsRow.put("approvalclosedate", formatter.format((Date) fnyr[10]));
                } else {
                    financialyrsRow.put("approvalclosedate", "NO DATE");
                }
                if ((Boolean) fnyr[4]) {
                    financialyrsRow.put("approach", "Top Down");
                } else {
                    financialyrsRow.put("approach", "Bottom Up");
                }

                int financialyprocurementplansRowcount = 0;
                String[] params6 = {"facilityfinancialyearid", "approved"};
                Object[] paramsValues6 = {(Long) fnyr[0], Boolean.TRUE};
                String where6 = "WHERE facilityfinancialyearid=:facilityfinancialyearid AND approved=:approved";
                financialyprocurementplansRowcount = genericClassService.fetchRecordCount(Orderperiod.class, where6, params6, paramsValues6);
                financialyrsRow.put("financialyprocurementplansRowcount", financialyprocurementplansRowcount);
                financialyrslists.add(financialyrsRow);
            }
        }
        model.addAttribute("financialyrs", financialyrslists);
        return "controlPanel/localSettingsPanel/facilityProcurementPlan/facilityProcurementPlanHome";
    }

    @RequestMapping(value = "/facilityprocuredorunprocuredprocurementplans.htm", method = RequestMethod.GET)
    public String facilityprocuredorunprocuredprocurementplans(Model model, HttpServletRequest request) {
        List<Map> facilityprocplans = new ArrayList<>();
        try {
            String[] params = {"facilityfinancialyearid", "approved"};
            Object[] paramsValues = {Long.parseLong(request.getParameter("facilityfinancialyearid")), Boolean.TRUE};
            String[] fields = {"orderperiodid", "orderperiodname", "startdate", "enddate", "setascurrent", "approved"};
            List<Object[]> orderperiod = (List<Object[]>) genericClassService.fetchRecord(Orderperiod.class, fields, "WHERE facilityfinancialyearid=:facilityfinancialyearid AND approved=:approved", params, paramsValues);
            if (orderperiod != null) {
                Map<String, Object> facilityprocurementplansRow;
                for (Object[] orderperiodtype : orderperiod) {
                    facilityprocurementplansRow = new HashMap<>();
                    facilityprocurementplansRow.put("orderperiodid", (int) orderperiodtype[0]);
                    facilityprocurementplansRow.put("orderperiodname", (String) orderperiodtype[1]);
                    facilityprocurementplansRow.put("startdate", formatter.format((Date) orderperiodtype[2]));
                    facilityprocurementplansRow.put("enddate", formatter.format((Date) orderperiodtype[3]));
                    facilityprocurementplansRow.put("setascurrent", (Boolean) orderperiodtype[4]);
                    facilityprocurementplansRow.put("approved", (Boolean) orderperiodtype[5]);
                    facilityprocplans.add(facilityprocurementplansRow);

                }
            }
        } catch (NumberFormatException e) {
        }

        model.addAttribute("facilityprocplans", facilityprocplans);
        return "controlPanel/localSettingsPanel/facilityProcurementPlan/views/facilityProcurementPlans";
    }

    @RequestMapping(value = "/removefacilityprocurementplan.htm")
    public @ResponseBody
    String removefacilityprocurementplan(HttpServletRequest request) {
        String response = "";
        String[] columns = {"approved"};
        Object[] columnValues = {false};
        String pk = "orderperiodid";
        Object pkValue = Integer.parseInt(request.getParameter("orderperiodid"));

        int result = genericClassService.updateRecordSQLSchemaStyle(Orderperiod.class, columns, columnValues, pk, pkValue, "store");
        if (result != 0) {
            response = "success";
        }
        return response;
    }

    @RequestMapping(value = "/composedfacilityprocurementplan.htm", method = RequestMethod.GET)
    public String composedfacilityprocurementplan(Model model, HttpServletRequest request) {

        String[] params = {"facilityid", "proccessstage"};
        Object[] paramsValues = {Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacility"))), "consolidated"};
        String[] fields = {"facilityfinancialyearid", "startyear", "endyear", "orderperiodtype", "istopdownapproach"};
        List<Object[]> facilityfinancialyear = (List<Object[]>) genericClassService.fetchRecord(Facilityfinancialyear.class, fields, "WHERE facilityid=:facilityid AND proccessstage=:proccessstage", params, paramsValues);
        if (facilityfinancialyear != null) {

            model.addAttribute("istopdownapproach", facilityfinancialyear.get(0)[4]);

            model.addAttribute("facilityfinancialyearid", facilityfinancialyear.get(0)[0]);
            model.addAttribute("facilityfinancialyear", facilityfinancialyear.get(0)[1] + "-" + facilityfinancialyear.get(0)[2]);

            String[] params1 = {"facilityfinancialyearid", "procured"};
            Object[] paramsValues1 = {(Long) facilityfinancialyear.get(0)[0], Boolean.TRUE};
            String[] fields1 = {"orderperiodid", "orderperiodname", "startdate", "enddate"};
            List<Object[]> orderperiod = (List<Object[]>) genericClassService.fetchRecord(Orderperiod.class, fields1, "WHERE facilityfinancialyearid=:facilityfinancialyearid AND procured=:procured", params1, paramsValues1);
            if (orderperiod != null) {
                model.addAttribute("procured", true);
                int facilityprocurementplansitemsRowcount = 0;
                String[] params6 = {"orderperiodid"};
                Object[] paramsValues6 = {(int) orderperiod.get(0)[0]};
                String where6 = "WHERE orderperiodid=:orderperiodid";
                facilityprocurementplansitemsRowcount = genericClassService.fetchRecordCount(Facilityprocurementplan.class, where6, params6, paramsValues6);

                model.addAttribute("facilityprocurementplansitemsRowcount", facilityprocurementplansitemsRowcount);

                model.addAttribute("orderperiodid", orderperiod.get(0)[0]);

                model.addAttribute("orderperiodname", orderperiod.get(0)[1]);
                model.addAttribute("startdate", formatter.format((Date) orderperiod.get(0)[2]));
                model.addAttribute("enddate", formatter.format((Date) orderperiod.get(0)[3]));
                model.addAttribute("orderperiodtype", facilityfinancialyear.get(0)[3]);
                model.addAttribute("orderperiodid", (int) orderperiod.get(0)[0]);

                double totalcost = 0;

                String[] params2 = {"orderperiodid"};
                Object[] paramsValues2 = {orderperiod.get(0)[0]};
                String[] fields2 = {"itemid.itemid", "pack", "averageannualconsumption", "unitcost"};
                List<Object[]> facilityprocurementitems = (List<Object[]>) genericClassService.fetchRecord(Facilityprocurementplan.class, fields2, "WHERE orderperiodid=:orderperiodid", params2, paramsValues2);
                if (facilityprocurementitems != null) {
                    for (Object[] facilityprocurementitem : facilityprocurementitems) {
                        totalcost = totalcost + ((((Double) facilityprocurementitem[2])) / ((Integer) facilityprocurementitem[1])) * (((Double) facilityprocurementitem[3]));
                    }
                }
                model.addAttribute("totalcost", String.format("%,.2f", totalcost) + " " + "/=");
            } else {
                model.addAttribute("procured", false);
            }
        } else {
            model.addAttribute("procured", false);
        }

        return "controlPanel/localSettingsPanel/facilityProcurementPlan/views/composedFacilityProcurementplan";
    }

    @RequestMapping(value = "/facilityprocuredprocuredprocurementplansitemsview.htm", method = RequestMethod.GET)
    public String FacilityProcuredProcuredProcurementPlansPtemsView(Model model, HttpServletRequest request) {
        List<Map> facilityprocplansitems = new ArrayList<>();
        int approvedItems = 0;
        double totalcost = 0;
        String[] params2 = {"orderperiodid"};
        Object[] paramsValues2 = {Integer.parseInt(request.getParameter("orderperiodid"))};
        String[] fields2 = {"itemid.itemid", "averagemonthconsumption", "averageannualconsumption", "averagequarterconsumption", "facilityprocurementplanid", "approved", "pack", "unitcost"};
        List<Object[]> facilityprocurementitems = (List<Object[]>) genericClassService.fetchRecord(Facilityprocurementplan.class, fields2, "WHERE orderperiodid=:orderperiodid", params2, paramsValues2);
        if (facilityprocurementitems != null) {
            Map<String, Object> facilityprocurementplansitemsRow;
            for (Object[] facilityprocurement : facilityprocurementitems) {

                facilityprocurementplansitemsRow = new HashMap<>();

                String[] params1 = {"itempackageid"};
                Object[] paramsValues1 = {facilityprocurement[0]};
                String[] fields1 = {"packagename", "packagequantity"};
                List<Object[]> facilityprocurementitems1 = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields1, "WHERE itempackageid=:itempackageid", params1, paramsValues1);
                if (facilityprocurementitems1 != null) {
                    if (facilityprocurement[5] != null && (Boolean) facilityprocurement[5] == true) {
                        approvedItems = approvedItems + 1;
                    } else {
                        facilityprocurementplansitemsRow.put("averagemonthlyconsumption", ((Double) facilityprocurement[1]).intValue());
                        if ("Quarterly".equals(request.getParameter("orderperiodtype"))) {
                            facilityprocurementplansitemsRow.put("averagequarterconsumption", ((Double) facilityprocurement[3]).intValue());
                            facilityprocurementplansitemsRow.put("cost", String.format("%,.2f", ((((Double) facilityprocurement[3])) / ((Integer) facilityprocurement[6])) * (((Double) facilityprocurement[7]))) + " " + "/=");
                            totalcost = totalcost + (((((Double) facilityprocurement[3])) / ((Integer) facilityprocurement[6])) * (((Double) facilityprocurement[7])));
                        } else {
                            facilityprocurementplansitemsRow.put("cost", String.format("%,.2f", ((((Double) facilityprocurement[2])) / ((Integer) facilityprocurement[6])) * (((Double) facilityprocurement[7]))) + " " + "/=");
                            facilityprocurementplansitemsRow.put("averageannualcomsumption", ((Double) facilityprocurement[2]).intValue());
                            totalcost = totalcost + (((((Double) facilityprocurement[2])) / ((Integer) facilityprocurement[6])) * (((Double) facilityprocurement[7])));
                        }

                        facilityprocurementplansitemsRow.put("itemid", (Long) facilityprocurement[0]);
                        facilityprocurementplansitemsRow.put("packsize", facilityprocurementitems1.get(0)[1]);
                        facilityprocurementplansitemsRow.put("genericname", facilityprocurementitems1.get(0)[0]);

                        facilityprocurementplansitemsRow.put("facilityprocurementplanid", (Long) facilityprocurement[4]);

                        int facilityunitscount = 0;
                        String[] params3 = {"proccessingstage", "orderperiodid", "facilityfinancialyearid"};
                        Object[] paramsValues3 = {"approved", Integer.parseInt(request.getParameter("orderperiodid")), Long.parseLong(request.getParameter("facilityfinancialyearid"))};
                        String[] fields3 = {"facilityunitfinancialyearid"};
                        List<Integer> facilityprocurementitems3 = (List<Integer>) genericClassService.fetchRecord(Facilityunitfinancialyear.class, fields3, "WHERE proccessingstage=:proccessingstage AND orderperiodid=:orderperiodid AND facilityfinancialyearid=:facilityfinancialyearid", params3, paramsValues3);
                        if (facilityprocurementitems3 != null) {
                            for (Integer facilityprocurementit : facilityprocurementitems3) {
                                String[] params = {"facilityunitfinancialyearid", "itemid", "approved"};
                                Object[] paramsValues = {facilityprocurementit, (Long) facilityprocurement[0], Boolean.TRUE};
                                String[] fields = {"facilityunitprocurementplanid"};
                                List<Integer> facilityprocurementtm = (List<Integer>) genericClassService.fetchRecord(Facilityunitprocurementplan.class, fields, "WHERE facilityunitfinancialyearid=:facilityunitfinancialyearid AND itemid=:itemid AND approved=:approved", params, paramsValues);
                                if (facilityprocurementtm != null) {
                                    facilityunitscount = facilityunitscount + 1;
                                }
                            }
                        }

                        facilityprocurementplansitemsRow.put("facilityunitscount", facilityunitscount);
                        facilityprocplansitems.add(facilityprocurementplansitemsRow);
                    }

                }
            }
        }
        model.addAttribute("facilityprocplansitems", facilityprocplansitems);
        model.addAttribute("orderperiodtype", request.getParameter("orderperiodtype"));
        model.addAttribute("facilityfinancialyearid", request.getParameter("facilityfinancialyearid"));
        model.addAttribute("orderperiodid", request.getParameter("orderperiodid"));
        model.addAttribute("approvedItems", approvedItems);
        model.addAttribute("totalcost", String.format("%,.2f", totalcost) + " " + "/=");
        model.addAttribute("istopdownapproach", request.getParameter("istopdownapproach"));
        return "controlPanel/localSettingsPanel/facilityProcurementPlan/forms/items";
    }

    @RequestMapping(value = "/facilityunitsitemvaluesview.htm", method = RequestMethod.GET)
    public String FacilityUnitsItemValuesView(Model model, HttpServletRequest request) {

        List<Map> facilityunts = new ArrayList<>();

        String[] params3 = {"proccessingstage", "orderperiodid", "facilityfinancialyearid"};
        Object[] paramsValues3 = {"approved", Integer.parseInt(request.getParameter("orderperiodid")), Long.parseLong(request.getParameter("facilityfinancialyearid"))};
        String[] fields3 = {"facilityunitfinancialyearid", "facilityunitid"};
        List<Object[]> facilityprocurementitems3 = (List<Object[]>) genericClassService.fetchRecord(Facilityunitfinancialyear.class, fields3, "WHERE proccessingstage=:proccessingstage AND orderperiodid=:orderperiodid AND facilityfinancialyearid=:facilityfinancialyearid", params3, paramsValues3);
        if (facilityprocurementitems3 != null) {
            Map<String, Object> facilityunitsRow;
            for (Object[] facilityprocurementit : facilityprocurementitems3) {
                facilityunitsRow = new HashMap<>();
                String[] params = {"facilityunitfinancialyearid", "itemid", "approved"};
                Object[] paramsValues = {(int) facilityprocurementit[0], Long.parseLong(request.getParameter("itemid")), Boolean.TRUE};
                String[] fields = {"facilityunitprocurementplanid", "averagemonthlyconsumption", "averageannualcomsumption", "averagequarterconsumption"};
                List<Object[]> facilityprocurementtm = (List<Object[]>) genericClassService.fetchRecord(Facilityunitprocurementplan.class, fields, "WHERE facilityunitfinancialyearid=:facilityunitfinancialyearid AND itemid=:itemid AND approved=:approved", params, paramsValues);
                if (facilityprocurementtm != null) {
                    String[] params1 = {"facilityunitid"};
                    Object[] paramsValues1 = {(Long) facilityprocurementit[1]};
                    String[] fields1 = {"facilityunitname", "shortname"};
                    List<Object[]> facilityunitdetails = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields1, "WHERE facilityunitid=:facilityunitid", params1, paramsValues1);
                    if (facilityunitdetails != null) {
                        facilityunitsRow.put("facilityunitfinancialyearid", (int) facilityprocurementit[0]);
                        facilityunitsRow.put("facilityunitname", facilityunitdetails.get(0)[0]);
                        facilityunitsRow.put("shortname", facilityunitdetails.get(0)[1]);
                        if ("Quarterly".equals(request.getParameter("orderperiodtype"))) {
                            facilityunitsRow.put("averagequarterconsumption", ((Double) facilityprocurementtm.get(0)[3]).intValue());
                        } else {
                            facilityunitsRow.put("averageannualcomsumption", ((Double) facilityprocurementtm.get(0)[2]).intValue());
                        }
                        facilityunitsRow.put("averagemonthlyconsumption", ((Double) facilityprocurementtm.get(0)[1]).intValue());
                        facilityunitsRow.put("facilityunitprocurementplanid", facilityprocurementtm.get(0)[0]);
                        facilityunitsRow.put("facilityunitfinancialyearid", (int) facilityprocurementit[0]);
                        facilityunts.add(facilityunitsRow);
                    }
                }
            }
        }
        model.addAttribute("genericname", request.getParameter("genericname"));
        model.addAttribute("facilityunts", facilityunts);
        model.addAttribute("orderperiodtype", request.getParameter("orderperiodtype"));
        model.addAttribute("orderperiodid", Integer.parseInt(request.getParameter("orderperiodid")));
        model.addAttribute("facilityfinancialyearid", request.getParameter("facilityfinancialyearid"));
        model.addAttribute("itemid", request.getParameter("itemid"));
        model.addAttribute("act", request.getParameter("act"));
        return "controlPanel/localSettingsPanel/facilityProcurementPlan/views/facilityunitsitemvalues";
    }

    @RequestMapping(value = "/rejectfacilityorunitprocurementplanitems.htm")
    public @ResponseBody
    String rejectfacilityorunitprocurementplanitems(HttpServletRequest request) {
        String results = "";
        try {
            if ("unit".equals(request.getParameter("type"))) {
                String[] columns = {"approved", "status", "lastupdatedby", "lastupdated"};
                Object[] columnValues = {false, "reject", (Long) request.getSession().getAttribute("person_id"), new Date()};
                String pk = "facilityunitprocurementplanid";
                Object pkValue = Integer.parseInt(request.getParameter("facilityunitprocurementplanid"));
                int result = genericClassService.updateRecordSQLSchemaStyle(Facilityunitprocurementplan.class, columns, columnValues, pk, pkValue, "store");
                if (result != 0) {
                    results = "success";
                }
            } else if ("updateunit".equals(request.getParameter("type"))) {
                List<Map> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("values"), List.class);
                for (Map item1 : item) {
                    Map<String, Object> map = (HashMap) item1;
                    if ("Quarterly".equals(request.getParameter("orderperiodtype"))) {
                        String[] columns = {"averagemonthlyconsumption", "averagequarterconsumption", "status", "lastupdatedby", "lastupdated"};
                        Object[] columnValues = {Double.parseDouble((String) map.get("monthly")), Double.parseDouble((String) map.get("quarter")), "update", (Long) request.getSession().getAttribute("person_id"), new Date()};
                        String pk = "facilityunitprocurementplanid";
                        Object pkValue = Integer.parseInt((String) map.get("facilityunitprocurementplanid"));
                        int result = genericClassService.updateRecordSQLSchemaStyle(Facilityunitprocurementplan.class, columns, columnValues, pk, pkValue, "store");

                    } else {
                        String[] columns = {"averagemonthlyconsumption", "averageannualcomsumption", "status", "lastupdatedby", "lastupdated"};
                        Object[] columnValues = {Double.parseDouble((String) map.get("monthly")), Double.parseDouble((String) map.get("annual")), "update", (Long) request.getSession().getAttribute("person_id"), new Date()};
                        String pk = "facilityunitprocurementplanid";
                        Object pkValue = Integer.parseInt((String) map.get("facilityunitprocurementplanid"));
                        int result = genericClassService.updateRecordSQLSchemaStyle(Facilityunitprocurementplan.class, columns, columnValues, pk, pkValue, "store");

                    }

                }
            } else if ("rejectfacility".equals(request.getParameter("type"))) {
                String[] columns = {"setascurrent", "procured", "submitted", "submitcomment"};
                Object[] columnValues = {Boolean.FALSE, Boolean.TRUE, Boolean.FALSE, request.getParameter("reason")};
                String pk = "orderperiodid";
                Object pkValue = Integer.parseInt(request.getParameter("orderperiodid"));
                int result = genericClassService.updateRecordSQLSchemaStyle(Orderperiod.class, columns, columnValues, pk, pkValue, "store");

            }
        } catch (IOException e) {
        }

        return results;
    }

    @RequestMapping(value = "/saveupdatedfinancialyear.htm")
    public @ResponseBody
    String SaveUpdatedFinancialYear(HttpServletRequest request) {
        String results = "";
        try {
            String[] columns = {"activationdate", "lastupdated", "lastupdatedby"};
            Object[] columnValues = {formatter.parse((request.getParameter("updateactivationdate")).replaceAll("/", "-")), new Date(), (Long) request.getSession().getAttribute("person_id")};
            String pk = "facilityfinancialyearid";
            Object pkValue = Long.parseLong(request.getParameter("facilityfinancialyearid"));
            int result = genericClassService.updateRecordSQLSchemaStyle(Facilityfinancialyear.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                results = "success";
            }
        } catch (NumberFormatException | ParseException e) {
        }

        return results;
    }

    @RequestMapping(value = "/facilityprocuredprocurementplans.htm", method = RequestMethod.GET)
    public String FacilityProcuredProcurementPlans(Model model, HttpServletRequest request) {
        List<Map> facilityfinancialyears = new ArrayList<>();
        String[] params = {"facilityid"};
        Object[] paramsValues = {Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacility")))};
        String[] fields = {"facilityfinancialyearid", "startyear", "endyear", "orderperiodtype"};
        List<Object[]> facilityfinancialyear = (List<Object[]>) genericClassService.fetchRecord(Facilityfinancialyear.class, fields, "WHERE facilityid=:facilityid", params, paramsValues);
        if (facilityfinancialyear != null) {
            Map<String, Object> facilityfinancialyearsRow;
            for (Object[] facilityfinancial : facilityfinancialyear) {
                facilityfinancialyearsRow = new HashMap<>();
                String[] params1 = {"facilityfinancialyearid", "procured", "submitted", "approved"};
                Object[] paramsValues1 = {(Long) facilityfinancial[0], Boolean.TRUE, Boolean.TRUE, Boolean.TRUE};
                String[] fields1 = {"orderperiodid", "orderperiodname"};
                List<Object[]> facilityorderperiod = (List<Object[]>) genericClassService.fetchRecord(Orderperiod.class, fields1, "WHERE facilityfinancialyearid=:facilityfinancialyearid AND procured=:procured AND submitted=:submitted AND approved=:approved", params1, paramsValues1);
                if (facilityorderperiod != null) {
                    facilityfinancialyearsRow.put("facilityfinancialyearid", (Long) facilityfinancial[0]);
                    facilityfinancialyearsRow.put("procurementscount", facilityorderperiod.size());
                    facilityfinancialyearsRow.put("financialyear", (int) facilityfinancial[1] + "-" + (int) facilityfinancial[2]);
                    facilityfinancialyearsRow.put("orderperiodtype", (String) facilityfinancial[3]);
                    facilityfinancialyears.add(facilityfinancialyearsRow);
                }
            }
        }
        model.addAttribute("facilityfinancialyears", facilityfinancialyears);
        return "controlPanel/localSettingsPanel/facilityProcurementPlan/views/FacilityProcuredPlans";
    }

    @RequestMapping(value = "/facilityprocuredprocurementplansview.htm", method = RequestMethod.GET)
    public String procuredprocurementplansview(Model model, HttpServletRequest request) {
        List<Map> facilityfinancialyearplans = new ArrayList<>();
        String[] params1 = {"facilityfinancialyearid", "procured", "submitted", "approved"};
        Object[] paramsValues1 = {Long.parseLong(request.getParameter("facilityfinancialyearid")), Boolean.TRUE, Boolean.TRUE, Boolean.TRUE};
        String[] fields1 = {"orderperiodid", "orderperiodname", "startdate", "enddate"};
        List<Object[]> facilityorderperiod = (List<Object[]>) genericClassService.fetchRecord(Orderperiod.class, fields1, "WHERE facilityfinancialyearid=:facilityfinancialyearid AND procured=:procured AND submitted=:submitted AND approved=:approved", params1, paramsValues1);
        if (facilityorderperiod != null) {
            Map<String, Object> facilityprocurementsRow;
            for (Object[] facilityorder : facilityorderperiod) {
                facilityprocurementsRow = new HashMap<>();
                String[] params = {"orderperiodid"};
                Object[] paramsValues = {(int) facilityorder[0]};
                String[] fields = {"itemid", "facilityprocurementplanid"};
                List<Object[]> itemcount = (List<Object[]>) genericClassService.fetchRecord(Facilityprocurementplan.class, fields, "WHERE orderperiodid=:orderperiodid", params, paramsValues);
                if (itemcount != null) {
                    facilityprocurementsRow.put("orderperiodid", (int) facilityorder[0]);
                    facilityprocurementsRow.put("orderperiodname", (String) facilityorder[1]);
                    facilityprocurementsRow.put("startdate", formatter.format((Date) facilityorder[2]));
                    facilityprocurementsRow.put("enddate", formatter.format((Date) facilityorder[3]));
                    facilityprocurementsRow.put("itemcount", itemcount.size());
                    facilityfinancialyearplans.add(facilityprocurementsRow);

                }
            }
        }
        model.addAttribute("facilityfinancialyearplans", facilityfinancialyearplans);
        model.addAttribute("orderperiodtype", request.getParameter("orderperiodtype"));
        return "controlPanel/localSettingsPanel/facilityProcurementPlan/views/procurementPlans";
    }

    @RequestMapping(value = "/facilityproczprocurementplanitemsview.htm", method = RequestMethod.GET)
    public String facilityproczprocurementplanitemsview(Model model, HttpServletRequest request) {
        List<Map> items = new ArrayList<>();

        String[] params = {"orderperiodid"};
        Object[] paramsValues = {Integer.parseInt(request.getParameter("orderperiodid"))};
        String[] fields = {"itemid.itemid", "facilityprocurementplanid", "averagemonthconsumption", "averageannualconsumption", "averagequarterconsumption"};
        List<Object[]> facilityitems = (List<Object[]>) genericClassService.fetchRecord(Facilityprocurementplan.class, fields, "WHERE orderperiodid=:orderperiodid", params, paramsValues);
        if (facilityitems != null) {
            Map<String, Object> facilityItemsRow;
            for (Object[] facilityitem : facilityitems) {
                facilityItemsRow = new HashMap<>();
                String[] params1 = {"itempackageid"};
                Object[] paramsValues1 = {facilityitem[0]};
                String[] fields1 = {"packagename", "packagequantity"};
                List<Object[]> itemdetails = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields1, "WHERE itempackageid=:itempackageid", params1, paramsValues1);
                if (itemdetails != null) {
                    facilityItemsRow.put("genericname", itemdetails.get(0)[0]);
                    facilityItemsRow.put("packsize", itemdetails.get(0)[1]);
                    facilityItemsRow.put("unitcost", 0);
                    facilityItemsRow.put("averagemonthconsumption", ((Double) facilityitem[2]).intValue());
                    if ("Quarterly".equals(request.getParameter("orderperiodtype"))) {
                        facilityItemsRow.put("averagequarterconsumption", ((Double) facilityitem[4]).intValue());
                        facilityItemsRow.put("cost", 0);
                    } else {
                        facilityItemsRow.put("averageannualconsumption", ((Double) facilityitem[3]).intValue());
                        facilityItemsRow.put("cost", 0);
                    }
                    items.add(facilityItemsRow);
                }
            }
        }
        model.addAttribute("items", items);
        model.addAttribute("orderperiodtype", request.getParameter("orderperiodtype"));
        return "controlPanel/localSettingsPanel/facilityProcurementPlan/views/items";
    }

    @RequestMapping(value = "/getlastaddedfinancialyear.htm")
    public @ResponseBody
    String getlastaddedfinancialyear(HttpServletRequest request) {
        String response = "0";
        String[] params = {};
        Object[] paramsValues = {};
        String[] fields = {"facilityfinancialyearid", "endyear"};
        String where = "ORDER BY facilityfinancialyearid DESC LIMIT 1";
        List<Object[]> endyear = (List<Object[]>) genericClassService.fetchRecord(Facilityfinancialyear.class, fields, where, params, paramsValues);
        if (endyear != null) {

            response = String.valueOf((int) endyear.get(0)[1]);
        } else {
            response = "0";
        }
        return response;
    }

    @RequestMapping(value = "/consolidatefacilityunitsprocurementplans.htm", method = RequestMethod.GET)
    public String consolidatefacilityunitsprocurementplans(Model model, HttpServletRequest request) {
        List<Map> unitsFound = new ArrayList<>();
        String[] params = {"orderperiodid", "facilityfinancialyearid", "proccessingstage"};
        Object[] paramsValues = {Integer.parseInt(request.getParameter("orderperiodid")), Long.parseLong(request.getParameter("facilityfinancialyearid")), "approved"};
        String[] fields = {"facilityunitfinancialyearid", "facilityunitid", "consolidated"};
        List<Object[]> units = (List<Object[]>) genericClassService.fetchRecord(Facilityunitfinancialyear.class, fields, "WHERE orderperiodid=:orderperiodid AND facilityfinancialyearid=:facilityfinancialyearid AND proccessingstage=:proccessingstage", params, paramsValues);
        if (units != null) {
            Map<String, Object> facilityUnitsRow;
            for (Object[] unit : units) {
                facilityUnitsRow = new HashMap<>();
                String[] params1 = {"facilityunitid"};
                Object[] paramsValues1 = {(Long) unit[1]};
                String[] fields1 = {"facilityunitname", "shortname"};
                List<Object[]> facilityunit = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields1, "WHERE facilityunitid=:facilityunitid", params1, paramsValues1);
                if (facilityunit != null) {
                    facilityUnitsRow.put("facilityunitname", facilityunit.get(0)[0]);
                    facilityUnitsRow.put("shortname", facilityunit.get(0)[1]);
                }
                if (unit[2] != null && (Boolean) unit[2] == true) {
                    facilityUnitsRow.put("consolidated", true);
                } else {
                    facilityUnitsRow.put("consolidated", false);
                }
                facilityUnitsRow.put("facilityunitfinancialyearid", (Integer) unit[0]);
                String[] params3 = {"facilityunitfinancialyearid", "approved"};
                Object[] paramsValues3 = {(Integer) unit[0], Boolean.TRUE};
                String[] fields3 = {"facilityunitprocurementplanid"};
                List<Integer> facilityprocurementitems = (List<Integer>) genericClassService.fetchRecord(Facilityunitprocurementplan.class, fields3, "WHERE facilityunitfinancialyearid=:facilityunitfinancialyearid AND approved=:approved", params3, paramsValues3);
                if (facilityprocurementitems != null) {
                    facilityUnitsRow.put("facilityprocurementitemsCount", facilityprocurementitems.size());
                }
                unitsFound.add(facilityUnitsRow);
            }
        }
        model.addAttribute("unitsFound", unitsFound);
        model.addAttribute("orderperiodid", request.getParameter("orderperiodid"));
        model.addAttribute("orderperiodtype", request.getParameter("orderperiodtype"));
        return "controlPanel/localSettingsPanel/facilityProcurementPlan/forms/ConsolidateUnits";
    }

    @RequestMapping(value = "/edititemdetails.htm", method = RequestMethod.GET)
    public String edititemdetails(Model model, HttpServletRequest request) {
        model.addAttribute("facilityfinancialyearid", request.getParameter("facilityfinancialyearid"));
        model.addAttribute("itemid", request.getParameter("itemid"));
        model.addAttribute("orderperiodid", request.getParameter("orderperiodid"));
        model.addAttribute("genericname", request.getParameter("genericname"));
        model.addAttribute("orderperiodtype", request.getParameter("orderperiodtype"));

        model.addAttribute("istopdownapproach", request.getParameter("istopdownapproach"));

        model.addAttribute("averagemonthlyconsumption", request.getParameter("averagemonthlyconsumption"));
        if ("Quarterly".equals(request.getParameter("orderperiodtype"))) {
            model.addAttribute("averagequarterconsumption", Integer.parseInt(request.getParameter("averagemonthlyconsumption")) * 3);
        } else {
            model.addAttribute("averageannualcomsumption", Integer.parseInt(request.getParameter("averagemonthlyconsumption")) * 12);
        }
        model.addAttribute("facilityprocurementplanid", request.getParameter("facilityprocurementplanid"));
        return "controlPanel/localSettingsPanel/facilityProcurementPlan/forms/editItem";
    }

    @RequestMapping(value = "/saveupdatefacilityunitprocurementplanitemvalue.htm")
    public @ResponseBody
    String saveupdatefacilityunitprocurementplanitemvalue(HttpServletRequest request) {
        String response = "";
        if ("Quarterly".equals(request.getParameter("ordertype"))) {
            String[] columns = {"averagequarterconsumption", "averagemonthconsumption"};
            Object[] columnValues = {Double.parseDouble(request.getParameter("othervalue")), Double.parseDouble(request.getParameter("monthlyneed"))};
            String pk = "facilityprocurementplanid";
            Object pkValue = Long.parseLong(request.getParameter("facilityprocurementplanid"));
            int result = genericClassService.updateRecordSQLSchemaStyle(Facilityprocurementplan.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                response = "success";
            }
        } else {
            String[] columns = {"averageannualconsumption", "averagemonthconsumption"};
            Object[] columnValues = {Double.parseDouble(request.getParameter("othervalue")), Double.parseDouble(request.getParameter("monthlyneed"))};
            String pk = "facilityprocurementplanid";
            Object pkValue = Long.parseLong(request.getParameter("facilityprocurementplanid"));
            int result = genericClassService.updateRecordSQLSchemaStyle(Facilityprocurementplan.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                response = "success";
            }
        }
        return response;
    }

    @RequestMapping(value = "/consolidate.htm")
    public @ResponseBody
    String consolidate(HttpServletRequest request) {
        String response = "";
        try {
            List<String> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("unitsConsolidate"), List.class);
            for (String item1 : item) {
                String[] params = {"approved", "facilityunitfinancialyearid"};
                Object[] paramsValues = {Boolean.TRUE, Long.parseLong(item1)};
                String[] fields = {"itemid", "averagemonthlyconsumption", "averagequarterconsumption", "averageannualcomsumption"};
                List<Object[]> unitItems = (List<Object[]>) genericClassService.fetchRecord(Facilityunitprocurementplan.class, fields, "WHERE approved=:approved AND facilityunitfinancialyearid=:facilityunitfinancialyearid", params, paramsValues);
                if (unitItems != null) {
                    for (Object[] itemn : unitItems) {
                        String[] params1 = {"itemid", "orderperiodid"};
                        Object[] paramsValues1 = {(Long) itemn[0], Integer.parseInt(request.getParameter("orderperiodid"))};
                        String[] fields1 = {"facilityprocurementplanid", "averagemonthconsumption", "averageannualconsumption", "averagequarterconsumption"};
                        List<Object[]> totalitemvale = (List<Object[]>) genericClassService.fetchRecord(Facilityprocurementplan.class, fields1, "WHERE itemid=:itemid AND orderperiodid=:orderperiodid", params1, paramsValues1);
                        if (totalitemvale != null) {
                            if ("Quarterly".equals(request.getParameter("orderperiodtype"))) {
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
                            facilityprocurementplan.setAddedby(BigInteger.valueOf((Long) request.getSession().getAttribute("person_id")));
                            facilityprocurementplan.setDateadded(new Date());
                            facilityprocurementplan.setAveragemonthconsumption((Double) itemn[1]);
                            if ("Quarterly".equals(request.getParameter("orderperiodtype"))) {
                                facilityprocurementplan.setAveragequarterconsumption((Double) itemn[2]);
                            } else {
                                facilityprocurementplan.setAverageannualconsumption((Double) itemn[3]);
                            }
                            facilityprocurementplan.setItemid(new Item((Long) itemn[0]));
                            facilityprocurementplan.setOrderperiodid(new Orderperiod(Integer.parseInt(request.getParameter("orderperiodid"))));
                            genericClassService.saveOrUpdateRecordLoadObject(facilityprocurementplan);
                        }
                    }

                    String[] columns = {"consolidated"};
                    Object[] columnValues = {true};
                    String pk = "facilityunitfinancialyearid";
                    Object pkValue = Long.parseLong(item1);
                    int result = genericClassService.updateRecordSQLSchemaStyle(Facilityunitfinancialyear.class, columns, columnValues, pk, pkValue, "store");
                    if (result != 0) {
                        response = "success";
                    }
                }
            }
        } catch (IOException e) {
        }

        return response;
    }

    @RequestMapping(value = "/savenewprocurementplan.htm")
    public @ResponseBody
    String SaveNewProcurementPlan(HttpServletRequest request) {
        String str_date = "01-july-" + request.getParameter("startyear");
        DateFormat formatter2;
        Date date;
        formatter2 = new SimpleDateFormat("dd-MMM-yy");
        String results = "";
        Facilityfinancialyear financialyear = new Facilityfinancialyear();
        try {
            financialyear.setEndyear(Integer.parseInt(request.getParameter("endyear")));
            financialyear.setFinancialyearstartdate(formatter.parse("01-" + request.getParameter("startmonth") + "-" + request.getParameter("startyear")));
            financialyear.setFinancialyearenddate(formatter.parse(request.getParameter("lastdayofmonth") + "-" + request.getParameter("endmonth") + "-" + request.getParameter("endyear")));
            financialyear.setStartyear(Integer.parseInt(request.getParameter("startyear")));
            financialyear.setStatus(Boolean.valueOf(request.getParameter("status")));
            financialyear.setAddedby(BigInteger.valueOf((Long) request.getSession().getAttribute("person_id")));
            financialyear.setDateadded(new Date());
            financialyear.setProccessstage("CREATED");
            financialyear.setIstopdownapproach(Boolean.valueOf(request.getParameter("approach")));
            financialyear.setProcuringopendate(formatter.parse(request.getParameter("procuringstartdate").replaceAll("/", "-")));
            financialyear.setProcuringclosedate(formatter.parse(request.getParameter("procuringenddate").replaceAll("/", "-")));
            financialyear.setApprovalopendate(formatter.parse(request.getParameter("approvalstartdate").replaceAll("/", "-")));
            financialyear.setApprovalclosedate(formatter.parse(request.getParameter("approvalenddate").replaceAll("/", "-")));
            financialyear.setOrderperiodtype(request.getParameter("orderperiod"));
            financialyear.setFacilityid(BigInteger.valueOf(((Integer) request.getSession().getAttribute("sessionActiveLoginFacility"))));
            financialyear.setStatus(Boolean.FALSE);
            financialyear.setIsthecurrent(Boolean.FALSE);
            Object save = genericClassService.saveOrUpdateRecordLoadObject(financialyear);
            if (save != null) {
                if ("Quarterly".equals(request.getParameter("orderperiod"))) {
                    String[] params = {"orderperiodtype", "facilityfinancialyearid"};
                    Object[] paramsValues = {"Quarterly", financialyear.getFacilityfinancialyearid()};
                    String[] fields = {"orderperiodid"};
                    List<Integer> quarter = (List<Integer>) genericClassService.fetchRecord(Orderperiod.class, fields, "WHERE orderperiodtype=:orderperiodtype AND facilityfinancialyearid=:facilityfinancialyearid", params, paramsValues);
                    if (quarter == null) {
                        date = formatter2.parse(str_date);
                        for (int i = 1; i <= 4; i++) {
                            Orderperiod orderperiod = new Orderperiod();
                            orderperiod.setAddedby(BigInteger.valueOf((Long) request.getSession().getAttribute("person_id")));
                            orderperiod.setDateadded(new Date());
                            orderperiod.setStartdate(formatter2.parse(formatter2.format(date)));
                            orderperiod.setEnddate(formatter2.parse(formatter2.format(getFinancialQuarterEndDate(date))));
                            orderperiod.setOrderperiodtype("Quarterly");
                            orderperiod.setFacilityfinancialyearid(financialyear);
                            orderperiod.setOrderperiodname("Quarter" + " " + i);
                            orderperiod.setApproved(Boolean.TRUE);
                            orderperiod.setProcured(Boolean.FALSE);
                            orderperiod.setSetascurrent(Boolean.FALSE);

                            genericClassService.saveOrUpdateRecordLoadObject(orderperiod);
                            date = addDays(getFinancialQuarterEndDate(date), 1);
                        }
                    }
                } else if ("Annually".equals(request.getParameter("orderperiod"))) {
                    Orderperiod orderperiod = new Orderperiod();
                    orderperiod.setAddedby(BigInteger.valueOf((Long) request.getSession().getAttribute("person_id")));
                    orderperiod.setDateadded(new Date());
                    orderperiod.setFacilityfinancialyearid(financialyear);
                    orderperiod.setOrderperiodname(request.getParameter("startyear") + "-" + request.getParameter("endyear"));
                    orderperiod.setOrderperiodtype("Annually");
                    orderperiod.setApproved(Boolean.TRUE);
                    orderperiod.setSetascurrent(Boolean.FALSE);
                    orderperiod.setProcured(Boolean.FALSE);
                    orderperiod.setStartdate(formatter.parse("01-" + request.getParameter("startmonth") + "-" + request.getParameter("startyear")));
                    orderperiod.setEnddate(formatter.parse(request.getParameter("lastdayofmonth") + "-" + request.getParameter("endmonth") + "-" + request.getParameter("endyear")));
                    orderperiod.setSetascurrent(Boolean.FALSE);

                    genericClassService.saveOrUpdateRecordLoadObject(orderperiod);
                }
            }
        } catch (ParseException ex) {
            Logger.getLogger(ProcurementPlanManagement.class.getName()).log(Level.SEVERE, null, ex);
        }
        return results;
    }

    public Date getFinancialQuarterEndDate(Date date) {
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        int factor = 0;
        int month = calendar.get(Calendar.MONTH);
        if (month == Calendar.JANUARY
                || month == Calendar.APRIL
                || month == Calendar.JULY
                || month == Calendar.OCTOBER) {
            factor = 2;
        } else if (month == Calendar.FEBRUARY
                || month == Calendar.MAY
                || month == Calendar.AUGUST
                || month == Calendar.NOVEMBER) {
            factor = 1;
        } else {
            factor = 0;
        }

        calendar.add(Calendar.MONTH, factor);
        calendar.set(Calendar.DATE, calendar.getActualMaximum(Calendar.DATE));
        return calendar.getTime();
    }

    public Date addDays(Date date, int days) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.DATE, days);
        return cal.getTime();
    }

    @RequestMapping(value = "/approvefacilityconsolidatedprocurementplanitems.htm")
    public @ResponseBody
    String approvefacilityconsolidatedprocurementplanitems(HttpServletRequest request) {
        String results = "";
        if ("approve".equals(request.getParameter("type"))) {
            String[] columns = {"approved", "approvedby", "dateapproved"};
            Object[] columnValues = {true, (Long) request.getSession().getAttribute("person_id"), new Date()};
            String pk = "facilityprocurementplanid";
            Object pkValue = Long.parseLong(request.getParameter("facilityprocurementplanid"));

            int result = genericClassService.updateRecordSQLSchemaStyle(Facilityprocurementplan.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                results = "success";
            }
        } else {
            String[] columns = {"approved", "approvedby", "dateapproved"};
            Object[] columnValues = {false, (Long) request.getSession().getAttribute("person_id"), new Date()};
            String pk = "facilityprocurementplanid";
            Object pkValue = Long.parseLong(request.getParameter("facilityprocurementplanid"));

            int result = genericClassService.updateRecordSQLSchemaStyle(Facilityprocurementplan.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                results = "success";
            }
        }
        return results;
    }

    @RequestMapping(value = "/approvedprocurementplanitems.htm", method = RequestMethod.GET)
    public String approvedprocurementplanitems(Model model, HttpServletRequest request) {
        List<Map> approveditems = new ArrayList<>();
        String[] params2 = {"orderperiodid", "approved"};
        Object[] paramsValues2 = {Integer.parseInt(request.getParameter("orderperiodid")), Boolean.TRUE};
        String[] fields2 = {"itemid.itemid", "averagemonthconsumption", "averageannualconsumption", "averagequarterconsumption", "facilityprocurementplanid", "approved", "pack", "unitcost"};
        List<Object[]> facilityprocurementitems = (List<Object[]>) genericClassService.fetchRecord(Facilityprocurementplan.class, fields2, "WHERE orderperiodid=:orderperiodid AND approved=:approved", params2, paramsValues2);
        if (facilityprocurementitems != null) {
            Map<String, Object> facilityprocurementplansitemsRow;
            for (Object[] facilityprocurement : facilityprocurementitems) {
                facilityprocurementplansitemsRow = new HashMap<>();
                String[] params1 = {"itempackageid"};
                Object[] paramsValues1 = {facilityprocurement[0]};
                String[] fields1 = {"packagename", "packagequantity"};
                List<Object[]> facilityprocurementitems1 = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields1, "WHERE itempackageid=:itempackageid", params1, paramsValues1);
                if (facilityprocurementitems1 != null) {

                    facilityprocurementplansitemsRow.put("averagemonthlyconsumption", ((Double) facilityprocurement[1]).intValue());
                    if ("Quarterly".equals(request.getParameter("orderperiodtype"))) {
                        facilityprocurementplansitemsRow.put("averagequarterconsumption", ((Double) facilityprocurement[3]).intValue());
                        facilityprocurementplansitemsRow.put("unitcost", String.format("%,.2f", (((Double) facilityprocurement[3]) / ((Integer) facilityprocurement[6])) * ((Double) facilityprocurement[7])));
                    } else {

                        facilityprocurementplansitemsRow.put("unitcost", String.format("%,.2f", (((Double) facilityprocurement[2]) / ((Integer) facilityprocurement[6])) * ((Double) facilityprocurement[7])));
                        facilityprocurementplansitemsRow.put("averageannualcomsumption", ((Double) facilityprocurement[2]).intValue());
                    }
                    facilityprocurementplansitemsRow.put("itemid", (Long) facilityprocurement[0]);
                    facilityprocurementplansitemsRow.put("packsize", facilityprocurementitems1.get(0)[1]);
                    facilityprocurementplansitemsRow.put("genericname", facilityprocurementitems1.get(0)[0]);

                    facilityprocurementplansitemsRow.put("facilityprocurementplanid", (Long) facilityprocurement[4]);

                    int facilityunitscount = 0;
                    String[] params3 = {"proccessingstage", "orderperiodid", "facilityfinancialyearid"};
                    Object[] paramsValues3 = {"approved", Integer.parseInt(request.getParameter("orderperiodid")), Long.parseLong(request.getParameter("facilityfinancialyearid"))};
                    String[] fields3 = {"facilityunitfinancialyearid"};
                    List<Integer> facilityprocurementitems3 = (List<Integer>) genericClassService.fetchRecord(Facilityunitfinancialyear.class, fields3, "WHERE proccessingstage=:proccessingstage AND orderperiodid=:orderperiodid AND facilityfinancialyearid=:facilityfinancialyearid", params3, paramsValues3);
                    if (facilityprocurementitems3 != null) {
                        for (Integer facilityprocurementit : facilityprocurementitems3) {
                            String[] params = {"facilityunitfinancialyearid", "itemid", "approved"};
                            Object[] paramsValues = {facilityprocurementit, (Long) facilityprocurement[0], Boolean.TRUE};
                            String[] fields = {"facilityunitprocurementplanid"};
                            List<Integer> facilityprocurementtm = (List<Integer>) genericClassService.fetchRecord(Facilityunitprocurementplan.class, fields, "WHERE facilityunitfinancialyearid=:facilityunitfinancialyearid AND itemid=:itemid AND approved=:approved", params, paramsValues);
                            if (facilityprocurementtm != null) {
                                facilityunitscount = facilityunitscount + 1;
                            }
                        }
                    }

                    facilityprocurementplansitemsRow.put("facilityunitscount", facilityunitscount);
                    approveditems.add(facilityprocurementplansitemsRow);
                }
            }
        }
        model.addAttribute("approveditems", approveditems);
        model.addAttribute("orderperiodtype", request.getParameter("orderperiodtype"));
        model.addAttribute("orderperiodid", request.getParameter("orderperiodid"));
        model.addAttribute("facilityfinancialyearid", request.getParameter("facilityfinancialyearid"));

        model.addAttribute("istopdownapproach", request.getParameter("istopdownapproach"));
        return "controlPanel/localSettingsPanel/facilityProcurementPlan/forms/approvedItems";
    }

    @RequestMapping(value = "/saveapprovedfacilityprocurementplan.htm")
    public @ResponseBody
    String saveapprovedfacilityprocurementplan(HttpServletRequest request) {
        String results = "";
        String[] params2 = {"orderperiodid", "approved"};
        Object[] paramsValues2 = {Integer.parseInt(request.getParameter("orderperiodid")), Boolean.TRUE};
        String[] fields2 = {"itemid", "facilityprocurementplanid"};
        List<Object[]> facilityprocurementitems = (List<Object[]>) genericClassService.fetchRecord(Facilityprocurementplan.class, fields2, "WHERE orderperiodid=:orderperiodid AND approved=:approved", params2, paramsValues2);
        if (facilityprocurementitems != null) {
            String[] columns = {"submitted", "procured", "setascurrent", "isactive"};
            Object[] columnValues = {true, true, false, true};
            String pk = "orderperiodid";
            Object pkValue = Integer.parseInt(request.getParameter("orderperiodid"));
            int result = genericClassService.updateRecordSQLSchemaStyle(Orderperiod.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                String[] columns1 = {"proccessstage"};
                Object[] columnValues1 = {"COMPLETED"};
                String pk1 = "facilityfinancialyearid";
                Object pkValue1 = Long.parseLong(request.getParameter("financialyearid"));
                int result1 = genericClassService.updateRecordSQLSchemaStyle(Facilityfinancialyear.class, columns1, columnValues1, pk1, pkValue1, "store");
            }

        } else {
            results = "noitems";
        }
        return results;
    }

    @RequestMapping(value = "/updatefacilityfinancialyeardates.htm")
    public @ResponseBody
    String updatefacilityfinancialyeardates(HttpServletRequest request) {
        String results = "";
        try {
            if ("procuringopen".equals(request.getParameter("type"))) {
                String[] columns = {"procuringopendate"};
                Object[] columnValues = {formatter.parse(request.getParameter("startdate").replaceAll("/", "-"))};
                String pk = "facilityfinancialyearid";
                Object pkValue = Long.parseLong(request.getParameter("facilityfinancialyearid"));

                int result = genericClassService.updateRecordSQLSchemaStyle(Facilityfinancialyear.class, columns, columnValues, pk, pkValue, "store");
                if (result != 0) {
                    String[] params2 = {"facilityfinancialyearid"};
                    Object[] paramsValues2 = {Long.parseLong(request.getParameter("facilityfinancialyearid"))};
                    String[] fields2 = {"orderperiodid", "orderperiodname"};
                    List<Object[]> facilityprocurement = (List<Object[]>) genericClassService.fetchRecord(Orderperiod.class, fields2, "WHERE facilityfinancialyearid=:facilityfinancialyearid", params2, paramsValues2);
                    if (facilityprocurement == null) {

                        String[] params3 = {"facilityfinancialyearid"};
                        Object[] paramsValues3 = {Long.parseLong(request.getParameter("facilityfinancialyearid"))};
                        String[] fields3 = {"financialyearstartdate", "financialyearenddate", "startyear", "endyear"};
                        List<Object[]> facilityfinancialyear = (List<Object[]>) genericClassService.fetchRecord(Facilityfinancialyear.class, fields3, "WHERE facilityfinancialyearid=:facilityfinancialyearid", params3, paramsValues3);
                        if (facilityfinancialyear != null) {
                            Orderperiod orderperiod = new Orderperiod();
                            orderperiod.setAddedby(BigInteger.valueOf((Long) request.getSession().getAttribute("person_id")));
                            orderperiod.setDateadded(new Date());
                            orderperiod.setFacilityfinancialyearid(new Facilityfinancialyear(Long.parseLong(request.getParameter("facilityfinancialyearid"))));
                            orderperiod.setOrderperiodname(facilityfinancialyear.get(0)[2] + "-" + facilityfinancialyear.get(0)[3]);
                            orderperiod.setOrderperiodtype("Annually");
                            orderperiod.setApproved(Boolean.TRUE);
                            orderperiod.setSetascurrent(Boolean.FALSE);
                            orderperiod.setProcured(Boolean.FALSE);
                            orderperiod.setStartdate((Date) facilityfinancialyear.get(0)[0]);
                            orderperiod.setEnddate((Date) facilityfinancialyear.get(0)[1]);
                            orderperiod.setSetascurrent(Boolean.FALSE);

                            genericClassService.saveOrUpdateRecordLoadObject(orderperiod);
                        }
                    }
                    ///////////////////////////////////
                }
            } else if ("procuringclose".equals(request.getParameter("type"))) {
                String[] columns = {"procuringclosedate"};
                Object[] columnValues = {formatter.parse(request.getParameter("closedate").replaceAll("/", "-"))};
                String pk = "facilityfinancialyearid";
                Object pkValue = Long.parseLong(request.getParameter("facilityfinancialyearid"));

                int result = genericClassService.updateRecordSQLSchemaStyle(Facilityfinancialyear.class, columns, columnValues, pk, pkValue, "store");
                if (result != 0) {

                    String[] params2 = {"facilityfinancialyearid"};
                    Object[] paramsValues2 = {Long.parseLong(request.getParameter("facilityfinancialyearid"))};
                    String[] fields2 = {"orderperiodid", "orderperiodname"};
                    List<Object[]> facilityprocurement = (List<Object[]>) genericClassService.fetchRecord(Orderperiod.class, fields2, "WHERE facilityfinancialyearid=:facilityfinancialyearid", params2, paramsValues2);
                    if (facilityprocurement == null) {
                        String[] params3 = {"facilityfinancialyearid"};
                        Object[] paramsValues3 = {Long.parseLong(request.getParameter("facilityfinancialyearid"))};
                        String[] fields3 = {"financialyearstartdate", "financialyearenddate", "startyear", "endyear"};
                        List<Object[]> facilityfinancialyear = (List<Object[]>) genericClassService.fetchRecord(Facilityfinancialyear.class, fields3, "WHERE facilityfinancialyearid=:facilityfinancialyearid", params3, paramsValues3);
                        if (facilityfinancialyear != null) {
                            Orderperiod orderperiod = new Orderperiod();
                            orderperiod.setAddedby(BigInteger.valueOf((Long) request.getSession().getAttribute("person_id")));
                            orderperiod.setDateadded(new Date());
                            orderperiod.setFacilityfinancialyearid(new Facilityfinancialyear(Long.parseLong(request.getParameter("facilityfinancialyearid"))));
                            orderperiod.setOrderperiodname(facilityfinancialyear.get(0)[2] + "-" + facilityfinancialyear.get(0)[3]);
                            orderperiod.setOrderperiodtype("Annually");
                            orderperiod.setApproved(Boolean.TRUE);
                            orderperiod.setSetascurrent(Boolean.FALSE);
                            orderperiod.setProcured(Boolean.FALSE);
                            orderperiod.setStartdate((Date) facilityfinancialyear.get(0)[0]);
                            orderperiod.setEnddate((Date) facilityfinancialyear.get(0)[1]);
                            orderperiod.setSetascurrent(Boolean.FALSE);

                            genericClassService.saveOrUpdateRecordLoadObject(orderperiod);
                        }
                    }
                }
            } else if ("approvalstartdate".equals(request.getParameter("type"))) {
                String[] columns = {"approvalopendate"};
                Object[] columnValues = {formatter.parse(request.getParameter("startdate").replaceAll("/", "-"))};
                String pk = "facilityfinancialyearid";
                Object pkValue = Long.parseLong(request.getParameter("facilityfinancialyearid"));

                int result = genericClassService.updateRecordSQLSchemaStyle(Facilityfinancialyear.class, columns, columnValues, pk, pkValue, "store");
                if (result != 0) {
                    results = "success";
                }
            } else if ("approvalenddate".equals(request.getParameter("type"))) {
                String[] columns = {"approvalclosedate"};
                Object[] columnValues = {formatter.parse(request.getParameter("enddate").replaceAll("/", "-"))};
                String pk = "facilityfinancialyearid";
                Object pkValue = Long.parseLong(request.getParameter("facilityfinancialyearid"));

                int result = genericClassService.updateRecordSQLSchemaStyle(Facilityfinancialyear.class, columns, columnValues, pk, pkValue, "store");
                if (result != 0) {
                    results = "success";
                }
            } else if ("approach".equals(request.getParameter("type"))) {
                Boolean istopdownapproach;
                if ("top".equals(request.getParameter("approach"))) {
                    istopdownapproach = true;
                } else {
                    istopdownapproach = false;
                }
                String[] columns = {"istopdownapproach"};
                Object[] columnValues = {istopdownapproach};
                String pk = "facilityfinancialyearid";
                Object pkValue = Long.parseLong(request.getParameter("facilityfinancialyearid"));

                int result = genericClassService.updateRecordSQLSchemaStyle(Facilityfinancialyear.class, columns, columnValues, pk, pkValue, "store");
                if (result != 0) {
                    results = "success";
                }
            }

        } catch (NumberFormatException | ParseException e) {
        }

        return results;
    }

    @RequestMapping(value = "/consolidatedfacilityunitsprocurementplanitems.htm", method = RequestMethod.GET)
    public String consolidatedfacilityunitsprocurementplanitems(Model model, HttpServletRequest request) {
        List<Map> itemsFound = new ArrayList<>();

        String[] params = {"approved", "facilityunitfinancialyearid"};
        Object[] paramsValues = {Boolean.TRUE, Integer.parseInt(request.getParameter("facilityunitfinancialyearid"))};
        String[] fields = {"facilityunitprocurementplanid", "averagemonthlyconsumption", "averagequarterconsumption", "averageannualcomsumption", "itemid"};
        List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Facilityunitprocurementplan.class, fields, "WHERE approved=:approved AND facilityunitfinancialyearid=:facilityunitfinancialyearid", params, paramsValues);
        if (items != null) {
            Map<String, Object> itemRow;
            for (Object[] item : items) {
                itemRow = new HashMap<>();
                itemRow.put("facilityunitprocurementplanid", item[0]);
                itemRow.put("averagemonthlyconsumption", String.format("%,d", ((Double) item[1]).intValue()));
                if ("Annually".equals(request.getParameter("orderperiodtype"))) {
                    itemRow.put("averageannualcomsumption", String.format("%,d", ((Double) item[3]).intValue()));
                } else {
                    itemRow.put("averagequarterconsumption", String.format("%,d", ((Double) item[2]).intValue()));
                }

                String[] params2 = {"itempackageid"};
                Object[] paramsValues2 = {(Long) item[4]};
                String[] fields2 = {"packagename", "itemstrength"};
                List<Object[]> itemdetails = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields2, "WHERE itempackgeid=:itempackgeid", params2, paramsValues2);
                if (itemdetails != null) {
                    itemRow.put("genericname", itemdetails.get(0)[0]);
                }
                itemsFound.add(itemRow);
            }
        }
        model.addAttribute("itemsFound", itemsFound);
        model.addAttribute("orderperiodtype", request.getParameter("orderperiodtype"));
        return "controlPanel/localSettingsPanel/facilityProcurementPlan/views/facilityUnitItems";
    }

    @RequestMapping(value = "/topdowncomposeprocurementplan.htm", method = RequestMethod.GET)
    public String topdowncomposeprocurementplan(Model model, HttpServletRequest request) {
        List<Map> procurementplansFound = new ArrayList<>();
        String[] params = {"isthecurrent", "istopdownapproach", "proccessstage", "facilityid"};
        Object[] paramsValues = {Boolean.TRUE, Boolean.TRUE, "CREATED", Long.parseLong(String.valueOf((int) request.getSession().getAttribute("sessionActiveLoginFacility")))};
        String[] fields = {"facilityfinancialyearid", "startyear", "endyear", "orderperiodtype"};
        List<Object[]> facilityfinancialyear = (List<Object[]>) genericClassService.fetchRecord(Facilityfinancialyear.class, fields, "WHERE isthecurrent=:isthecurrent AND istopdownapproach=:istopdownapproach AND proccessstage=:proccessstage AND facilityid=:facilityid", params, paramsValues);
        if (facilityfinancialyear != null) {
            String[] params2 = {"setascurrent", "facilityfinancialyearid"};
            Object[] paramsValues2 = {Boolean.TRUE, facilityfinancialyear.get(0)[0]};
            String[] fields2 = {"orderperiodid", "orderperiodname", "startdate", "enddate"};
            List<Object[]> orderperiod = (List<Object[]>) genericClassService.fetchRecord(Orderperiod.class, fields2, "WHERE setascurrent=:setascurrent AND facilityfinancialyearid=:facilityfinancialyearid", params2, paramsValues2);
            if (orderperiod != null) {
                Map<String, Object> fanincialyrRow;
                int financialyprocurementplansItemsRowcount = 0;
                String[] params6 = {"orderperiodid"};
                Object[] paramsValues6 = {orderperiod.get(0)[0]};
                String where6 = "WHERE orderperiodid=:orderperiodid";
                financialyprocurementplansItemsRowcount = genericClassService.fetchRecordCount(Facilityprocurementplan.class, where6, params6, paramsValues6);
                fanincialyrRow = new HashMap<>();
                fanincialyrRow.put("facilityfinancialyearid", facilityfinancialyear.get(0)[0]);
                fanincialyrRow.put("procurementplan", facilityfinancialyear.get(0)[1] + "-" + facilityfinancialyear.get(0)[2]);
                fanincialyrRow.put("orderperiodname", orderperiod.get(0)[1]);
                fanincialyrRow.put("startdate", formatter.format((Date) orderperiod.get(0)[2]));
                fanincialyrRow.put("enddate", formatter.format((Date) orderperiod.get(0)[3]));
                fanincialyrRow.put("orderperiodid", orderperiod.get(0)[0]);
                fanincialyrRow.put("orderperiodtype", facilityfinancialyear.get(0)[3]);
                fanincialyrRow.put("financialyprocurementplansItemsRowcount", financialyprocurementplansItemsRowcount);
                procurementplansFound.add(fanincialyrRow);
            }
        }
        model.addAttribute("procurementplansFound", procurementplansFound);
        return "controlPanel/localSettingsPanel/facilityProcurementPlan/topDownApproach/views/composeProcurementplan";
    }

    @RequestMapping(value = "/additemsprocurementform.htm", method = RequestMethod.GET)
    public String additemsprocurementform(Model model, HttpServletRequest request) {
        List<Map> ItemsFound = new ArrayList<>();
        Set<Long> addeditems = new HashSet<>();

        String[] params2 = {"orderperiodid"};
        Object[] paramsValues2 = {Integer.parseInt(request.getParameter("orderperiodid"))};
        String[] fields2 = {"facilityprocurementplanid", "itemid.itemid"};
        List<Object[]> itemid = (List<Object[]>) genericClassService.fetchRecord(Facilityprocurementplan.class, fields2, "WHERE orderperiodid=:orderperiodid", params2, paramsValues2);
        if (itemid != null) {
            for (Object[] item : itemid) {
                addeditems.add((Long) item[1]);
            }
        }
        String result_view = "";
        if ("a".equals(request.getParameter("act"))) {
            int financialyprocurementplansItemsRowcount = 0;
            String[] params6 = {"orderperiodid"};
            Object[] paramsValues6 = {Integer.parseInt(request.getParameter("orderperiodid"))};
            String where6 = "WHERE orderperiodid=:orderperiodid";
            financialyprocurementplansItemsRowcount = genericClassService.fetchRecordCount(Facilityprocurementplan.class, where6, params6, paramsValues6);

            model.addAttribute("financialyprocurementplansItemsRowcount", financialyprocurementplansItemsRowcount);
            model.addAttribute("orderperiodid", request.getParameter("orderperiodid"));

            String[] params = {"orderperiodid"};
            Object[] paramsValues = {Integer.parseInt(request.getParameter("orderperiodid"))};
            String[] fields = {"orderperiodtype"};
            List<String> ordertype = (List<String>) genericClassService.fetchRecord(Orderperiod.class, fields, "WHERE orderperiodid=:orderperiodid", params, paramsValues);
            if (ordertype != null) {
                model.addAttribute("ordertype", ordertype.get(0));
            }
            result_view = "controlPanel/localSettingsPanel/facilityProcurementPlan/topDownApproach/forms/addItems";

        } else {

            String[] params = {"name","value", "isactive"};
            Object[] paramsValues = {request.getParameter("searchvalue").trim().toLowerCase() + "%","%"+ request.getParameter("searchvalue").trim().toLowerCase() + "%", Boolean.TRUE};
            String[] fields = {"itempackageid", "packagename", "categoryname"};
            List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields, "WHERE isactive=:isactive AND (LOWER(packagename) LIKE :name OR LOWER(packagename) LIKE :value) ORDER BY packagename", params, paramsValues);
            if (items != null) {
                Map<String, Object> itemsRow;
                for (Object[] itemdet : items) {
                    itemsRow = new HashMap<>();
                    if (!addeditems.isEmpty() && addeditems.contains(((BigInteger) itemdet[0]).longValue())) {

                    } else {
                        itemsRow.put("itemid", itemdet[0]);
                        itemsRow.put("itemname", itemdet[1]);
                        itemsRow.put("cat", itemdet[2]);
                        ItemsFound.add(itemsRow);
                    }
                }
            }
            model.addAttribute("items", ItemsFound);
            model.addAttribute("ordertype", request.getParameter("ordertype"));
            model.addAttribute("orderperiodid", request.getParameter("orderperiodid"));
            result_view = "controlPanel/localSettingsPanel/facilityProcurementPlan/topDownApproach/forms/searchitemsResult";
        }
        return result_view;
    }

    @RequestMapping(value = "/saveprocurementplnitem.htm")
    public @ResponseBody
    String saveprocurementplnitem(HttpServletRequest request) {
        String results = "";
        Facilityprocurementplan facilityprocurementplan = new Facilityprocurementplan();
        facilityprocurementplan.setAddedby(BigInteger.valueOf((Long) request.getSession().getAttribute("person_id")));
        facilityprocurementplan.setApproved(Boolean.FALSE);
        facilityprocurementplan.setDateadded(new Date());
        facilityprocurementplan.setItemid(new Item(Long.parseLong(request.getParameter("itemid"))));
        facilityprocurementplan.setAveragemonthconsumption(Double.valueOf(request.getParameter("monthlyneed")));
        facilityprocurementplan.setOrderperiodid(new Orderperiod(Integer.parseInt(request.getParameter("orderperiod"))));
        if ("Quarterly".equals(request.getParameter("ordertype"))) {
            facilityprocurementplan.setAveragequarterconsumption(Double.valueOf(request.getParameter("ordertypeneed")));
        } else {
            facilityprocurementplan.setAverageannualconsumption(Double.valueOf(request.getParameter("ordertypeneed")));
        }
        genericClassService.saveOrUpdateRecordLoadObject(facilityprocurementplan);
        results = String.valueOf(facilityprocurementplan.getFacilityprocurementplanid());
        return results;
    }

    @RequestMapping(value = "/removetodaysprocurementaddeditems.htm")
    public @ResponseBody
    String removetodaysprocurementaddeditems(HttpServletRequest request) {
        String results = "";
        if ("all".equals(request.getParameter("type"))) {
            String[] params1 = {"orderperiodid", "dateadded"};
            Object[] paramsValues1 = {Integer.parseInt(request.getParameter("orderperiodid")), new Date()};
            String[] fields1 = {"facilityprocurementplanid"};
            List<Long> items = (List<Long>) genericClassService.fetchRecord(Facilityprocurementplan.class, fields1, "WHERE orderperiodid=:orderperiodid AND dateadded=:dateadded", params1, paramsValues1);
            if (items != null) {
                for (Long facilityprocurementplanid : items) {
                    String[] columns = {"facilityprocurementplanid"};
                    Object[] columnValues = {facilityprocurementplanid};
                    int result = genericClassService.deleteRecordByByColumns("store.facilityprocurementplan", columns, columnValues);
                    if (result != 0) {
                        results = "success";
                    }
                }
            } else {
                results = "close";
            }
        } else if ("one".equals(request.getParameter("type"))) {
            String[] params1 = {"orderperiodid", "itemid"};
            Object[] paramsValues1 = {Integer.parseInt(request.getParameter("orderperiodid")), Long.parseLong(request.getParameter("itemid"))};
            String[] fields1 = {"facilityprocurementplanid"};
            List<Long> facilityprocurementplanid = (List<Long>) genericClassService.fetchRecord(Facilityprocurementplan.class, fields1, "WHERE orderperiodid=:orderperiodid AND itemid=:itemid", params1, paramsValues1);
            if (facilityprocurementplanid != null) {
                String[] columns = {"facilityprocurementplanid"};
                Object[] columnValues = {facilityprocurementplanid.get(0)};
                int result = genericClassService.deleteRecordByByColumns("store.facilityprocurementplan", columns, columnValues);
                if (result != 0) {
                    String[] params = {"orderperiodid"};
                    Object[] paramsValues = {Integer.parseInt(request.getParameter("orderperiodid"))};
                    String[] fields = {"facilityunitfinancialyearid"};
                    List<Integer> facilityunitfinancialyearid = (List<Integer>) genericClassService.fetchRecord(Facilityunitfinancialyear.class, fields, "WHERE orderperiodid=:orderperiodid", params, paramsValues);
                    if (facilityunitfinancialyearid != null) {
                        for (Integer facilityunitfinancialyear : facilityunitfinancialyearid) {
                            String[] params2 = {"facilityunitfinancialyearid", "itemid"};
                            Object[] paramsValues2 = {facilityunitfinancialyear, Long.parseLong(request.getParameter("itemid"))};
                            String[] fields2 = {"facilityunitprocurementplanid"};
                            List<Integer> facilityunitprocurementplanid = (List<Integer>) genericClassService.fetchRecord(Facilityunitprocurementplan.class, fields2, "WHERE facilityunitfinancialyearid=:facilityunitfinancialyearid AND itemid=:itemid", params2, paramsValues2);
                            if (facilityunitprocurementplanid != null) {
                                String[] columns1 = {"facilityunitprocurementplanid"};
                                Object[] columnValues1 = {facilityunitprocurementplanid.get(0)};
                                int result1 = genericClassService.deleteRecordByByColumns("store.facilityunitprocurementplan", columns1, columnValues1);
                                results = "success";
                            }
                        }
                    }
                }
            }
        } else if ("removewithpk".equals(request.getParameter("type"))) {
            String[] columns = {"facilityprocurementplanid"};
            Object[] columnValues = {Long.parseLong(request.getParameter("facilityprocurementplanid"))};
            int result = genericClassService.deleteRecordByByColumns("store.facilityprocurementplan", columns, columnValues);
            if (result != 0) {
                String[] params = {"orderperiodid"};
                Object[] paramsValues = {Integer.parseInt(request.getParameter("orderperiodid"))};
                String[] fields = {"facilityunitfinancialyearid"};
                List<Integer> facilityunitfinancialyearid = (List<Integer>) genericClassService.fetchRecord(Facilityunitfinancialyear.class, fields, "WHERE orderperiodid=:orderperiodid", params, paramsValues);
                if (facilityunitfinancialyearid != null) {
                    for (Integer facilityunitfinancialyear : facilityunitfinancialyearid) {
                        String[] params2 = {"facilityunitfinancialyearid", "itemid"};
                        Object[] paramsValues2 = {facilityunitfinancialyear, Long.parseLong(request.getParameter("itemid"))};
                        String[] fields2 = {"facilityunitprocurementplanid"};
                        List<Integer> facilityunitprocurementplanid = (List<Integer>) genericClassService.fetchRecord(Facilityunitprocurementplan.class, fields2, "WHERE facilityunitfinancialyearid=:facilityunitfinancialyearid AND itemid=:itemid", params2, paramsValues2);
                        if (facilityunitprocurementplanid != null) {
                            String[] columns1 = {"facilityunitprocurementplanid"};
                            Object[] columnValues1 = {facilityunitprocurementplanid.get(0)};
                            int result1 = genericClassService.deleteRecordByByColumns("store.facilityunitprocurementplan", columns1, columnValues1);
                            results = "success";
                        }
                    }
                }
            }
        }

        return results;
    }

    @RequestMapping(value = "/updatetopdownprocurementaddeditems.htm")
    public @ResponseBody
    String updatetopdownprocurementaddeditems(HttpServletRequest request) {
        String results = "";
        if ("without".equals(request.getParameter("type"))) {
            String[] params1 = {"orderperiodid", "itemid"};
            Object[] paramsValues1 = {Integer.parseInt(request.getParameter("orderperiodid")), Long.parseLong(request.getParameter("itemid"))};
            String[] fields1 = {"facilityprocurementplanid"};
            List<Long> facilityprocurementplanid = (List<Long>) genericClassService.fetchRecord(Facilityprocurementplan.class, fields1, "WHERE orderperiodid=:orderperiodid AND itemid=:itemid", params1, paramsValues1);
            if (facilityprocurementplanid != null) {
                if ("Quarterly".equals(request.getParameter("ordertype"))) {
                    String[] columns = {"averagemonthconsumption", "averagequarterconsumption"};
                    Object[] columnValues = {Double.valueOf(request.getParameter("editmonthlyneed")), Double.valueOf(request.getParameter("editannuallneed"))};
                    String pk = "facilityprocurementplanid";
                    Object pkValue = facilityprocurementplanid.get(0);

                    int result = genericClassService.updateRecordSQLSchemaStyle(Facilityprocurementplan.class, columns, columnValues, pk, pkValue, "store");
                    if (result != 0) {
                        results = "success";
                    }
                } else {
                    String[] columns = {"averagemonthconsumption", "averageannualconsumption"};
                    Object[] columnValues = {Double.valueOf(request.getParameter("editmonthlyneed")), Double.valueOf(request.getParameter("editannuallneed"))};
                    String pk = "facilityprocurementplanid";
                    Object pkValue = facilityprocurementplanid.get(0);

                    int result = genericClassService.updateRecordSQLSchemaStyle(Facilityprocurementplan.class, columns, columnValues, pk, pkValue, "store");
                    if (result != 0) {
                        results = "success";
                    }
                }
            }
        } else {
            if ("Quarterly".equals(request.getParameter("orderperiodtype"))) {
                String[] columns = {"averagemonthconsumption", "averagequarterconsumption"};
                Object[] columnValues = {Double.valueOf(request.getParameter("editmonthlyneed")), Double.valueOf(request.getParameter("editannuallneed"))};
                String pk = "facilityprocurementplanid";
                Object pkValue = Long.parseLong(request.getParameter("facilityprocurementplanid"));

                int result = genericClassService.updateRecordSQLSchemaStyle(Facilityprocurementplan.class, columns, columnValues, pk, pkValue, "store");
                if (result != 0) {
                    results = "success";
                }
            } else {
                String[] columns = {"averagemonthconsumption", "averageannualconsumption"};
                Object[] columnValues = {Double.valueOf(request.getParameter("editmonthlyneed")), Double.valueOf(request.getParameter("editannuallneed"))};
                String pk = "facilityprocurementplanid";
                Object pkValue = Long.parseLong(request.getParameter("facilityprocurementplanid"));

                int result = genericClassService.updateRecordSQLSchemaStyle(Facilityprocurementplan.class, columns, columnValues, pk, pkValue, "store");
                if (result != 0) {
                    results = "success";
                }
            }

        }

        return results;
    }

    @RequestMapping(value = "/topdowncomposedprocurementplanitem.htm")
    public String topdowncomposedprocurementplanitem(Model model, HttpServletRequest request) {
        List<Map> ItemsFound = new ArrayList<>();
        String[] params1 = {"orderperiodid"};
        Object[] paramsValues1 = {Integer.parseInt(request.getParameter("orderperiodid"))};
        String[] fields1 = {"facilityprocurementplanid", "averagemonthconsumption", "averageannualconsumption", "averagequarterconsumption", "itemid.itemid"};
        List<Object[]> facilityprocurementplan = (List<Object[]>) genericClassService.fetchRecord(Facilityprocurementplan.class, fields1, "WHERE orderperiodid=:orderperiodid", params1, paramsValues1);
        if (facilityprocurementplan != null) {
            Map<String, Object> itemsRow;
            for (Object[] facilityprocurement : facilityprocurementplan) {
                itemsRow = new HashMap<>();
                String[] params = {"itempackageid"};
                Object[] paramsValues = {facilityprocurement[4]};
                String[] fields = {"packagename"};
                List<String> items = (List<String>) genericClassService.fetchRecord(Itempackage.class, fields, "WHERE itempackageid=:itempackageid", params, paramsValues);
                if (items != null) {
                    itemsRow.put("genericname", items.get(0));
                    itemsRow.put("itemid", facilityprocurement[4]);
                }
                itemsRow.put("facilityprocurementplanid", facilityprocurement[0]);
                itemsRow.put("averagemonthconsumption", String.format("%,d", ((Double) facilityprocurement[1]).intValue()));
                if ("Quarterly".equals(request.getParameter("orderperiodtype"))) {
                    itemsRow.put("averagequarterorAnnuallyconsumption", String.format("%,d", ((Double) facilityprocurement[3]).intValue()));
                } else {
                    itemsRow.put("averagequarterorAnnuallyconsumption", String.format("%,d", ((Double) facilityprocurement[2]).intValue()));
                }
                ItemsFound.add(itemsRow);
            }
        }
        model.addAttribute("ItemsFound", ItemsFound);
        model.addAttribute("orderperiodtype", request.getParameter("orderperiodtype"));
        model.addAttribute("orderperiodid", request.getParameter("orderperiodid"));
        model.addAttribute("act", request.getParameter("act"));
        return "controlPanel/localSettingsPanel/facilityProcurementPlan/topDownApproach/views/items";
    }

    @RequestMapping(value = "/removeallprocurementaddeditems.htm")
    public @ResponseBody
    String removeallprocurementaddeditems(HttpServletRequest request) {
        String results = "";
        String[] params1 = {"orderperiodid"};
        Object[] paramsValues1 = {Integer.parseInt(request.getParameter("orderperiodid"))};
        String[] fields1 = {"facilityprocurementplanid"};
        List<Long> items = (List<Long>) genericClassService.fetchRecord(Facilityprocurementplan.class, fields1, "WHERE orderperiodid=:orderperiodid", params1, paramsValues1);
        if (items != null) {
            for (Long facilityprocurementplanid : items) {
                String[] columns = {"facilityprocurementplanid"};
                Object[] columnValues = {facilityprocurementplanid};
                int result = genericClassService.deleteRecordByByColumns("store.facilityprocurementplan", columns, columnValues);
                if (result != 0) {
                    results = "success";
                }
            }
        } else {
            results = "close";
        }
        return results;
    }

    @RequestMapping(value = "/viewconsolidatedfacilityitems.htm")
    public String viewconsolidatedfacilityitems(Model model, HttpServletRequest request) {
        List<Map> ItemsFound = new ArrayList<>();

        String[] params1 = {"orderperiodid"};
        Object[] paramsValues1 = {Integer.parseInt(request.getParameter("orderperiodid"))};
        String[] fields1 = {"facilityprocurementplanid", "averagemonthconsumption", "averageannualconsumption", "averagequarterconsumption", "itemid.itemid"};
        List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Facilityprocurementplan.class, fields1, "WHERE orderperiodid=:orderperiodid", params1, paramsValues1);
        if (items != null) {
            Map<String, Object> itemsRow;
            for (Object[] item : items) {
                itemsRow = new HashMap<>();
                String[] params = {"itempackageid"};
                Object[] paramsValues = {item[4]};
                String[] fields = {"packagename"};
                List<String> itemdetails = (List<String>) genericClassService.fetchRecord(Itempackage.class, fields, "WHERE itempackageid=:itempackageid", params, paramsValues);
                if (itemdetails != null) {
                    itemsRow.put("genericname", itemdetails.get(0));
                }
                itemsRow.put("facilityprocurementplanid", item[0]);
                itemsRow.put("averagemonthconsumption", String.format("%,d", ((Double) item[1]).intValue()));
                if ("Quarterly".equals(request.getParameter("orderperiodtype"))) {
                    itemsRow.put("averagequarterorannualconsumption", String.format("%,d", ((Double) item[3]).intValue()));
                } else {
                    itemsRow.put("averagequarterorannualconsumption", String.format("%,d", ((Double) item[2]).intValue()));
                }
                ItemsFound.add(itemsRow);
            }
        }
        model.addAttribute("ItemsFound", ItemsFound);
        model.addAttribute("orderperiodtype", request.getParameter("orderperiodtype"));
        return "controlPanel/localSettingsPanel/facilityProcurementPlan/views/consolidatedItems";
    }

    @RequestMapping(value = "/getitemconsumptionaveragefrompreviousfinancialyears.htm")
    public String ItemConsumptionAverageFromFinancialYears(Model model, HttpServletRequest request) {
        String results_view = "";

        if ("b".equals(request.getParameter("act"))) {
            List<Map> UnitsFound = new ArrayList<>();
            String[] params1 = {"facilityid", "active"};
            Object[] paramsValues1 = {(Integer) request.getSession().getAttribute("sessionActiveLoginFacility"), Boolean.TRUE};
            String[] fields1 = {"facilityunitid", "facilityunitname"};
            List<Object[]> units = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields1, "WHERE facilityid=:facilityid AND active=:active", params1, paramsValues1);
            if (units != null) {
                Map<String, Object> unitsRow;
                for (Object[] unit : units) {
                    unitsRow = new HashMap<>();
                    unitsRow.put("facilityunitid", unit[0]);
                    unitsRow.put("facilityunitname", unit[1]);
                    UnitsFound.add(unitsRow);

                }
            }
            model.addAttribute("UnitsFound", UnitsFound);
            model.addAttribute("ordertype", request.getParameter("ordertype"));
            model.addAttribute("itemid", request.getParameter("itemid"));
            results_view = "controlPanel/localSettingsPanel/facilityProcurementPlan/topDownApproach/forms/itemQuantity";
        } else {
            Set<Integer> financialyears = new HashSet<>();
            List<Map> ItemsFound = new ArrayList<>();
            int totalprocurement = 0;
            int totalstockissuedout = 0;
            int averageprocurement = 0;
            String[] params1 = {"itemid", "approved", "orderperiodid"};
            Object[] paramsValues1 = {Long.parseLong(request.getParameter("itemid")), Boolean.TRUE, Integer.parseInt(request.getParameter("orderperiodid"))};
            String[] fields1 = {"facilityprocurementplanid", "averagemonthconsumption", "averageannualconsumption", "averagequarterconsumption", "orderperiodid"};
            List<Object[]> qtyprocured = (List<Object[]>) genericClassService.fetchRecord(Facilityprocurementplan.class, fields1, "WHERE itemid=:itemid AND approved=:approved AND orderperiodid !=:orderperiodid ORDER BY facilityprocurementplanid DESC LIMIT 3", params1, paramsValues1);
            if (qtyprocured != null) {
                Map<String, Object> itemsRow;
                for (Object[] procqty : qtyprocured) {

                    itemsRow = new HashMap<>();
                    int financialyearstocreceivedcount = 0;
                    int stockissuedout = 0;
                    String[] params3 = {"orderperiodid"};
                    Object[] paramsValues3 = {procqty[4]};
                    String[] fields3 = {"startdate", "enddate", "facilityfinancialyearid", "orderperiodname"};
                    List<Object[]> procureddates = (List<Object[]>) genericClassService.fetchRecord(Orderperiod.class, fields3, "WHERE orderperiodid=:orderperiodid", params3, paramsValues3);
                    if (procureddates != null) {
                        String[] paramsp = {"facilityfinancialyearid"};
                        Object[] paramsValuesp = {procureddates.get(0)[2]};
                        String[] fieldsp = {"startyear", "endyear", "orderperiodtype"};
                        List<Object[]> fnyrs = (List<Object[]>) genericClassService.fetchRecord(Facilityfinancialyear.class, fieldsp, "WHERE facilityfinancialyearid=:facilityfinancialyearid", paramsp, paramsValuesp);
                        if (fnyrs != null) {
                            if ("Quarterly".equals((String) fnyrs.get(0)[2])) {
                                totalprocurement = totalprocurement + ((Double) procqty[3]).intValue();
                                itemsRow.put("type", "Quarter Plan");
                                itemsRow.put("averageconsumption", String.format("%,d", ((Double) procqty[3]).intValue()));
                                itemsRow.put("financialyear", fnyrs.get(0)[0] + "/" + fnyrs.get(0)[1] + " " + (procureddates.get(0)[3]));
                            } else {
                                totalprocurement = totalprocurement + ((Double) procqty[2]).intValue();
                                itemsRow.put("type", "Annual Plan");
                                itemsRow.put("averageconsumption", String.format("%,d", ((Double) procqty[2]).intValue()));
                                itemsRow.put("financialyear", fnyrs.get(0)[0] + "/" + fnyrs.get(0)[1] + "(Annual)");
                            }
                            financialyears.add((Integer) procqty[4]);
                            String[] params = {"itemid", "startdate", "enddate", "facilityunitid"};
                            Object[] paramsValues = {Long.parseLong(request.getParameter("itemid")), procureddates.get(0)[0], procureddates.get(0)[1], BigInteger.valueOf(Long.valueOf(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))))};
                            String[] fields = {"stockid", "quantityrecieved"};
                            List<Object[]> itemstock = (List<Object[]>) genericClassService.fetchRecord(Stock.class, fields, "WHERE r.itemid.itemid=:itemid AND daterecieved>=:startdate AND daterecieved<=:enddate AND facilityunitid=:facilityunitid", params, paramsValues);
                            if (itemstock != null) {
                                for (Object[] itemstocks : itemstock) {
                                    financialyearstocreceivedcount = financialyearstocreceivedcount + ((int) itemstocks[1]);

                                    String[] params5 = {"stockid"};
                                    Object[] paramsValues5 = {itemstocks[0]};
                                    String[] fields5 = {"quantityissued"};
                                    List<Integer> ordereditems = (List<Integer>) genericClassService.fetchRecord(Orderissuance.class, fields5, "WHERE stockid=:stockid", params5, paramsValues5);
                                    if (ordereditems != null) {
                                        stockissuedout = stockissuedout + ordereditems.get(0);
                                    }
                                    String[] params6 = {"stockid"};
                                    Object[] paramsValues6 = {itemstocks[0]};
                                    String[] fields6 = {"quantityissued"};
                                    List<Integer> prescribedissued = (List<Integer>) genericClassService.fetchRecord(Prescriptionissuance.class, fields6, "WHERE stockid=:stockid", params6, paramsValues6);
                                    if (prescribedissued != null) {
                                        stockissuedout = stockissuedout + prescribedissued.get(0);
                                    }
                                }

                            }
                        }
                    }
                    itemsRow.put("stockissuedout", stockissuedout);
                    totalstockissuedout = totalstockissuedout + stockissuedout;
                    ItemsFound.add(itemsRow);
                }
                averageprocurement = totalprocurement / qtyprocured.size();
            }
            model.addAttribute("averagetotalprocurement", averageprocurement);
            if ("Quarterly".equals(request.getParameter("ordertype"))) {
                double d = averageprocurement / 3;
                DecimalFormat f = new DecimalFormat("##");
                model.addAttribute("monthprocurement", Integer.parseInt(f.format(d)));
            } else {
                double d = averageprocurement / 12;
                DecimalFormat fd = new DecimalFormat("##");
                model.addAttribute("monthprocurement", String.format("%,d", Integer.parseInt(fd.format(d))));
            }
            model.addAttribute("ItemsFound", ItemsFound);
            model.addAttribute("size", (ItemsFound.size() * 2));
            try {
                model.addAttribute("financialyearset", new ObjectMapper().writeValueAsString(financialyears));
            } catch (JsonProcessingException ex) {
                Logger.getLogger(FacilityProcurementPlan.class.getName()).log(Level.SEVERE, null, ex);
            }
            model.addAttribute("itemid", request.getParameter("itemid"));
            results_view = "controlPanel/localSettingsPanel/facilityProcurementPlan/topDownApproach/forms/itemQuantityStatistics";
        }

        model.addAttribute("ordertype", request.getParameter("ordertype"));
        model.addAttribute("orderperiodid", request.getParameter("orderperiodid"));
        return results_view;
    }

    @RequestMapping(value = "/getitemconsumptionaveragefrompreviouscount.htm")
    public @ResponseBody
    String getitemconsumptionaveragefrompreviouscount(HttpServletRequest request) {
        String results = "";
        String[] params1 = {"itemid", "approved", "orderperiodid"};
        Object[] paramsValues1 = {Long.parseLong(request.getParameter("itemid")), Boolean.TRUE, Integer.parseInt(request.getParameter("orderperiodid"))};
        String[] fields1 = {"facilityprocurementplanid"};
        List<Long> fnyr = (List<Long>) genericClassService.fetchRecord(Facilityprocurementplan.class, fields1, "WHERE itemid=:itemid AND approved=:approved AND orderperiodid !=:orderperiodid", params1, paramsValues1);
        if (fnyr != null) {
            results = "procured";
        } else {
            results = "unproc";
        }
        return results;
    }

    @RequestMapping(value = "/facilityunits.htm")
    public String facilityunits(Model model, HttpServletRequest request) {
        List<Map> UnitsFound = new ArrayList<>();
        List<Map> keysFound = new ArrayList<>();
        String[] params1 = {"facilityid", "active"};
        Object[] paramsValues1 = {(Integer) request.getSession().getAttribute("sessionActiveLoginFacility"), Boolean.TRUE};
        String[] fields1 = {"facilityunitid", "facilityunitname"};
        List<Object[]> facilityunits = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields1, "WHERE facilityid=:facilityid AND active=:active", params1, paramsValues1);
        if (facilityunits != null) {
            Map<String, Object> unitsRow;
            for (Object[] facilityunit : facilityunits) {
                unitsRow = new HashMap<>();
                unitsRow.put("facilityunitid", facilityunit[0]);
                unitsRow.put("facilityunitname", facilityunit[1]);
                UnitsFound.add(unitsRow);
            }
        }
        model.addAttribute("UnitsFound", UnitsFound);
        int size = Integer.parseInt(request.getParameter("size"));
        Map<String, Object> keysRow;
        for (int i = 1; i <= size; i++) {
            keysRow = new HashMap<>();
            keysRow.put("key", "tablerow" + i);
            keysFound.add(keysRow);
        }
        model.addAttribute("keysFound", keysFound);
        return "controlPanel/localSettingsPanel/facilityProcurementPlan/topDownApproach/views/units";
    }

    @RequestMapping(value = "/getunitsitemconsumptionaverage.htm")
    public @ResponseBody
    String getunitsitemconsumptionaverage(HttpServletRequest request) {
        String results = "";
        List<Map> UnitsItemsFound = new ArrayList<>();
        try {
            List<Integer> orderperiods = (ArrayList) new ObjectMapper().readValue(request.getParameter("financialyrs"), List.class);
            if (orderperiods != null) {
                Map<String, Object> itemsRow;
                for (Integer orderperiodid : orderperiods) {
                    itemsRow = new HashMap<>();
                    System.out.println("" + orderperiodid);
                    itemsRow.put("orderperiodid", orderperiodid);
                    String[] params1 = {"orderperiodid", "facilityunitid"};
                    Object[] paramsValues1 = {orderperiodid, Long.parseLong(request.getParameter("facilityunitid"))};
                    String[] fields1 = {"facilityunitfinancialyearid"};
                    List<Integer> facilityunitfinancialyearid = (List<Integer>) genericClassService.fetchRecord(Facilityunitfinancialyear.class, fields1, "WHERE orderperiodid=:orderperiodid AND facilityunitid=:facilityunitid", params1, paramsValues1);
                    if (facilityunitfinancialyearid != null) {
                        String[] params = {"itemid", "facilityunitfinancialyearid", "approved"};
                        Object[] paramsValues = {Long.parseLong(request.getParameter("itemid")), facilityunitfinancialyearid.get(0), Boolean.TRUE};
                        String[] fields = {"averagemonthlyconsumption", "averageannualcomsumption", "averagequarterconsumption"};
                        List<Object[]> qtyprocured = (List<Object[]>) genericClassService.fetchRecord(Facilityunitprocurementplan.class, fields, "WHERE itemid=:itemid AND facilityunitfinancialyearid=:facilityunitfinancialyearid AND approved=:approved", params, paramsValues);
                        if (qtyprocured != null) {

                            if (qtyprocured.get(0)[1] == null) {
                                itemsRow.put("procured", ((Double) qtyprocured.get(0)[2]).intValue());
                            } else {
                                itemsRow.put("procured", ((Double) qtyprocured.get(0)[1]).intValue());
                            }
                            itemsRow.put("consumed", 0);

                        } else {
                            itemsRow.put("procured", 0);
                        }
                    } else {
                        itemsRow.put("procured", 0);
                        itemsRow.put("consumed", 0);
                    }
                    UnitsItemsFound.add(itemsRow);
                }
            }
            results = new ObjectMapper().writeValueAsString(UnitsItemsFound);
        } catch (IOException e) {
        }

        return results;
    }

    @RequestMapping(value = "/savefacilityunititemaddedprocurementtopdown.htm")
    public @ResponseBody
    String savefacilityunititemaddedprocurementtopdown(HttpServletRequest request) {
        String results = "";
        String[] params1 = {"orderperiodid", "facilityunitid"};
        Object[] paramsValues1 = {Integer.parseInt(request.getParameter("orderperiodid")), Long.parseLong(request.getParameter("facilityunitid"))};
        String[] fields1 = {"facilityunitfinancialyearid"};
        List<Integer> facilityunitfinancialyearid = (List<Integer>) genericClassService.fetchRecord(Facilityunitfinancialyear.class, fields1, "WHERE orderperiodid=:orderperiodid AND facilityunitid=:facilityunitid", params1, paramsValues1);
        if (facilityunitfinancialyearid != null) {
            Facilityunitprocurementplan facilityunitprocurementplan = new Facilityunitprocurementplan();
            facilityunitprocurementplan.setAddedby(BigInteger.valueOf((Long) request.getSession().getAttribute("person_id")));
            facilityunitprocurementplan.setApproved(Boolean.TRUE);
            facilityunitprocurementplan.setDateadded(new Date());
            facilityunitprocurementplan.setFacilityunitfinancialyearid(new Facilityunitfinancialyear(facilityunitfinancialyearid.get(0)));
            facilityunitprocurementplan.setAveragemonthlyconsumption(Double.parseDouble(request.getParameter("monthlyneed")));
            if ("Quarterly".equals(request.getParameter("orderperiodtype"))) {
                facilityunitprocurementplan.setAveragequarterconsumption(Double.parseDouble(request.getParameter("annualorquarter")));
            } else {
                facilityunitprocurementplan.setAverageannualcomsumption(Double.parseDouble(request.getParameter("annualorquarter")));
            }
            facilityunitprocurementplan.setItemid(new Item(Long.parseLong(request.getParameter("itemid"))));

            genericClassService.saveOrUpdateRecordLoadObject(facilityunitprocurementplan);
        } else {
            Facilityunitfinancialyear facilityunitfinancialyear = new Facilityunitfinancialyear();
            facilityunitfinancialyear.setAddedby(BigInteger.valueOf((Long) request.getSession().getAttribute("person_id")));
            facilityunitfinancialyear.setConsolidated(Boolean.FALSE);
            facilityunitfinancialyear.setDateadded(new Date());
            facilityunitfinancialyear.setOrderperiodid(new Orderperiod(Integer.parseInt(request.getParameter("orderperiodid"))));
            facilityunitfinancialyear.setFacilityunitid(BigInteger.valueOf(Long.parseLong(request.getParameter("facilityunitid"))));
            facilityunitfinancialyear.setProccessingstage("approved");
            facilityunitfinancialyear.setConsolidated(Boolean.TRUE);
            String[] params = {"orderperiodid"};
            Object[] paramsValues = {Integer.parseInt(request.getParameter("orderperiodid"))};
            String[] fields = {"facilityfinancialyearid"};
            List<Long> facilityfinancialyearid = (List<Long>) genericClassService.fetchRecord(Orderperiod.class, fields, "WHERE orderperiodid=:orderperiodid", params, paramsValues);
            if (facilityfinancialyearid != null) {
                facilityunitfinancialyear.setFacilityfinancialyearid(new Facilityfinancialyear(facilityfinancialyearid.get(0)));
            }
            String[] params2 = {"facilityunitid"};
            Object[] paramsValues2 = {Long.parseLong(request.getParameter("facilityunitid"))};
            String[] fields2 = {"shortname"};
            List<String> facilityunitlabel = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fields2, "WHERE facilityunitid=:facilityunitid", params2, paramsValues2);
            if (facilityunitlabel != null) {
                facilityunitfinancialyear.setFacilityunitlabel(facilityunitlabel.get(0));
            }
            Object save = genericClassService.saveOrUpdateRecordLoadObject(facilityunitfinancialyear);
            if (save != null) {
                Facilityunitprocurementplan facilityunitprocurementplan = new Facilityunitprocurementplan();
                facilityunitprocurementplan.setAddedby(BigInteger.valueOf((Long) request.getSession().getAttribute("person_id")));
                facilityunitprocurementplan.setApproved(Boolean.TRUE);
                facilityunitprocurementplan.setDateadded(new Date());
                facilityunitprocurementplan.setFacilityunitfinancialyearid(facilityunitfinancialyear);
                facilityunitprocurementplan.setAveragemonthlyconsumption(Double.parseDouble(request.getParameter("monthlyneed")));
                if ("Quarterly".equals(request.getParameter("orderperiodtype"))) {
                    facilityunitprocurementplan.setAveragequarterconsumption(Double.parseDouble(request.getParameter("annualorquarter")));
                } else {
                    facilityunitprocurementplan.setAverageannualcomsumption(Double.parseDouble(request.getParameter("annualorquarter")));
                }
                facilityunitprocurementplan.setItemid(new Item(Long.parseLong(request.getParameter("itemid"))));

                genericClassService.saveOrUpdateRecordLoadObject(facilityunitprocurementplan);

            }
        }
        return results;
    }

    @RequestMapping(value = "/managefacilityfinancialyear.htm")
    public String managefacilityfinancialyear(Model model, HttpServletRequest request) {

        String[] params = {"facilityfinancialyearid"};
        Object[] paramsValues = {Long.parseLong(request.getParameter("facilityfinancialyearid"))};
        String[] fields = {"financialyearstartdate", "financialyearenddate", "procuringopendate", "procuringclosedate", "approvalopendate", "approvalclosedate", "istopdownapproach"};
        List<Object[]> financialyrs = (List<Object[]>) genericClassService.fetchRecord(Facilityfinancialyear.class, fields, "WHERE facilityfinancialyearid=:facilityfinancialyearid", params, paramsValues);
        if (financialyrs != null) {
            if (financialyrs.get(0)[0] != null) {
                model.addAttribute("financialyearstartdate", formatter.format((Date) financialyrs.get(0)[0]));
            } else {
                model.addAttribute("financialyearstartdate", "NO DATE");
            }
            if (financialyrs.get(0)[1] != null) {
                model.addAttribute("financialyearenddate", formatter.format((Date) financialyrs.get(0)[1]));
            } else {
                model.addAttribute("financialyearenddate", "NO DATE");
            }
            if (financialyrs.get(0)[2] != null) {
                model.addAttribute("procuringopendate", formatter.format((Date) financialyrs.get(0)[2]));
            } else {
                model.addAttribute("procuringopendate", "NO DATE");
            }
            if (financialyrs.get(0)[3] != null) {
                model.addAttribute("procuringclosedate", formatter.format((Date) financialyrs.get(0)[3]));
            } else {
                model.addAttribute("procuringclosedate", "NO DATE");
            }
            if (financialyrs.get(0)[4] != null) {
                model.addAttribute("approvalopendate", formatter.format((Date) financialyrs.get(0)[4]));
            } else {
                model.addAttribute("approvalopendate", "NO DATE");
            }
            if (financialyrs.get(0)[5] != null) {
                model.addAttribute("approvalclosedate", formatter.format((Date) financialyrs.get(0)[5]));
            } else {
                model.addAttribute("approvalclosedate", "NO DATE");
            }

            if ((Boolean) financialyrs.get(0)[6]) {
                model.addAttribute("istopdownapproach", "Top Down");
                model.addAttribute("istopdownapproachs", "Top");
            } else {
                model.addAttribute("istopdownapproach", "Bottom Up");
                model.addAttribute("istopdownapproachs", "Down");
            }
        }
        model.addAttribute("facilityfinancialyearid", request.getParameter("facilityfinancialyearid"));
        return "controlPanel/localSettingsPanel/facilityProcurementPlan/views/manageFinancialYear";
    }
}
