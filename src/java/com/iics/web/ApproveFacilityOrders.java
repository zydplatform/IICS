/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.iics.domain.Facilityunit;
import com.iics.domain.Person;
import com.iics.service.GenericClassService;
import com.iics.store.Facilityorder;
import com.iics.store.Facilityorderitems;
import com.iics.store.Itempackage;
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
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author HP
 */
@Controller
@RequestMapping("/approvefacilityorders")
public class ApproveFacilityOrders {

    DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    @Autowired
    GenericClassService genericClassService;
    private SimpleDateFormat formatterwithtime = new SimpleDateFormat("yyyy-MM-dd hh:mm aa");
    private Date serverDate = new Date();

    @RequestMapping(value = "/approvefacilityinternalorders.htm", method = RequestMethod.GET)
    public String localaccessrightsmanagementhome(Model model, HttpServletRequest request) {
        List<Map> facilityinternalordersList = new ArrayList<>();
        Set<Long> facilityunitset = new HashSet<>();

        String[] params4 = {"facilityid"};
        Object[] paramsValues4 = {request.getSession().getAttribute("sessionActiveLoginFacility")};
        String[] fields4 = {"facilityunitid"};
        List<Long> facilityunits = (List<Long>) genericClassService.fetchRecord(Facilityunit.class, fields4, "WHERE facilityid=:facilityid", params4, paramsValues4);
        if (facilityunits != null) {
            for (Long facilityunit : facilityunits) {
                facilityunitset.add(facilityunit);
            }
        }
        String[] params = {"ordertype", "status"};
        Object[] paramsValues = {"INTERNAL", "SUBMITTED"};
        String[] fields = {"facilityorderid", "originstore", "destinationstore", "isemergency", "preparedby", "dateprepared", "dateneeded", "facilityorderno"};
        List<Object[]> internalorders = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fields, "WHERE ordertype=:ordertype AND status=:status ORDER BY facilityorderid ASC", params, paramsValues);
        if (internalorders != null) {
            Map<String, Object> internalOrdersRow;
            for (Object[] internalorder : internalorders) {
                internalOrdersRow = new HashMap<>();
                if (!facilityunitset.isEmpty()) {
                    if (facilityunitset.contains(((BigInteger) internalorder[1]).longValue()) || facilityunitset.contains(((BigInteger) internalorder[2]).longValue())) {
                        internalOrdersRow.put("facilityorderid", internalorder[0]);
                        internalOrdersRow.put("isemergency", internalorder[3]);
                        internalOrdersRow.put("dateprepared", formatter.format((Date) internalorder[5]));
                        internalOrdersRow.put("dateneeded", formatter.format((Date) internalorder[6]));
                        internalOrdersRow.put("facilityorderno", internalorder[7]);

                        int internalorderitemscount = 0;
                        String[] paramsc = {"facilityorderid"};
                        Object[] paramsValuesc = {internalorder[0]};
                        String where = "WHERE facilityorderid=:facilityorderid";
                        internalorderitemscount = genericClassService.fetchRecordCount(Facilityorderitems.class, where, paramsc, paramsValuesc);

                        String[] params3 = {"personid"};
                        Object[] paramsValues3 = {internalorder[4]};
                        String[] fields3 = {"firstname", "lastname", "othernames"};
                        List<Object[]> createdby = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields3, "WHERE personid=:personid", params3, paramsValues3);
                        if (createdby != null) {
                            internalOrdersRow.put("createdby", createdby.get(0)[0] + " " + createdby.get(0)[1] + " " + createdby.get(0)[2]);
                        }
                        internalOrdersRow.put("itemscount", internalorderitemscount);

                        String[] params1 = {"facilityunitid"};
                        Object[] paramsValues1 = {internalorder[1]};
                        String[] fields1 = {"facilityunitname", "shortname"};
                        List<Object[]> orderingstore = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields1, "WHERE facilityunitid=:facilityunitid", params1, paramsValues1);
                        internalOrdersRow.put("orderingstore", orderingstore.get(0)[0]);

                        String[] params8 = {"facilityunitid"};
                        Object[] paramsValues8 = {internalorder[2]};
                        String[] fields8 = {"facilityunitname", "shortname"};
                        String where8 = "WHERE facilityunitid=:facilityunitid";
                        List<Object[]> destinationstore = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields8, where8, params8, paramsValues8);
                        internalOrdersRow.put("destinationstore", destinationstore.get(0)[0]);

                        facilityinternalordersList.add(internalOrdersRow);
                    }
                }

            }
        }
        model.addAttribute("facilityinternalordersList", facilityinternalordersList);
        model.addAttribute("internalorders", facilityinternalordersList.size());

        return "inventoryAndSupplies/approveFacilityOrders/internalOrders/internalOrders";
    }

    @RequestMapping(value = "/approvedfacilityinternalorders.htm", method = RequestMethod.GET)
    public String approvedfacilityinternalorders(Model model, HttpServletRequest request) {
        List<Map> facilityinternalordersList = new ArrayList<>();
        Set<Long> facilityunitset = new HashSet<>();
        String[] params9 = {"facilityid"};
        Object[] paramsValues9 = {request.getSession().getAttribute("sessionActiveLoginFacility")};
        String[] fields9 = {"facilityunitid"};
        List<Long> facilityunits = (List<Long>) genericClassService.fetchRecord(Facilityunit.class, fields9, "WHERE facilityid=:facilityid", params9, paramsValues9);
        if (facilityunits != null) {
            for (Long facilityunit : facilityunits) {
                facilityunitset.add(facilityunit);
            }
        }
        String[] params = {"ordertype", "approved"};
        Object[] paramsValues = {"INTERNAL", Boolean.TRUE};
        String[] fields = {"facilityorderid", "originstore", "destinationstore", "preparedby", "dateprepared", "facilityorderno", "dateapproved", "approvedby"};
        List<Object[]> internalorders = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fields, "WHERE ordertype=:ordertype AND approved=:approved ORDER BY dateapproved", params, paramsValues);
        if (internalorders != null) {
            Map<String, Object> internalOrdersRow;
            for (Object[] internalorder : internalorders) {
                internalOrdersRow = new HashMap<>();
                if (!facilityunitset.isEmpty()) {
                    if (facilityunitset.contains(((BigInteger) internalorder[1]).longValue()) || facilityunitset.contains(((BigInteger) internalorder[2]).longValue())) {
                        internalOrdersRow.put("facilityorderid", internalorder[0]);
                        internalOrdersRow.put("dateprepared", formatter.format((Date) internalorder[4]));
                        internalOrdersRow.put("facilityorderno", internalorder[5]);

                        String[] params1 = {"facilityunitid"};
                        Object[] paramsValues1 = {internalorder[1]};
                        String[] fields1 = {"facilityunitname", "shortname"};
                        List<Object[]> orderingstore = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields1, "WHERE facilityunitid=:facilityunitid", params1, paramsValues1);
                        internalOrdersRow.put("orderingstore", orderingstore.get(0)[0]);

                        String[] params8 = {"facilityunitid"};
                        Object[] paramsValues8 = {internalorder[2]};
                        String[] fields8 = {"facilityunitname", "shortname"};
                        String where8 = "WHERE facilityunitid=:facilityunitid";
                        List<Object[]> destinationstore = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields8, where8, params8, paramsValues8);
                        internalOrdersRow.put("destinationstore", destinationstore.get(0)[0]);

                        int internalorderitemscount = 0;
                        String[] paramsc = {"facilityorderid", "approved"};
                        Object[] paramsValuesc = {internalorder[0], Boolean.TRUE};
                        String where = "WHERE facilityorderid=:facilityorderid AND approved=:approved";
                        internalorderitemscount = genericClassService.fetchRecordCount(Facilityorderitems.class, where, paramsc, paramsValuesc);

                        String[] params3 = {"personid"};
                        Object[] paramsValues3 = {internalorder[3]};
                        String[] fields3 = {"firstname", "lastname", "othernames"};
                        List<Object[]> createdby = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields3, "WHERE personid=:personid", params3, paramsValues3);
                        if (createdby != null) {
                            internalOrdersRow.put("createdby", createdby.get(0)[0] + " " + createdby.get(0)[1] + " " + createdby.get(0)[2]);
                        }
                        internalOrdersRow.put("itemscount", internalorderitemscount);
                        internalOrdersRow.put("dateapproved", formatter.format((Date) internalorder[6]));
                        String[] params4 = {"personid"};
                        Object[] paramsValues4 = {internalorder[7]};
                        String[] fields4 = {"firstname", "lastname", "othernames"};
                        List<Object[]> approvedby = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields4, "WHERE personid=:personid", params4, paramsValues4);
                        if (approvedby != null) {
                            internalOrdersRow.put("approvedby", approvedby.get(0)[0] + " " + approvedby.get(0)[1] + " " + approvedby.get(0)[2]);
                        }
                        facilityinternalordersList.add(internalOrdersRow);
                    }
                }
            }
        }
        model.addAttribute("facilityinternalordersList", facilityinternalordersList);
        model.addAttribute("internalorders", facilityinternalordersList.size());
        return "inventoryAndSupplies/approveFacilityOrders/internalOrders/views/approvedOrders";
    }

    @RequestMapping(value = "/filterfacilityapprovedorders.htm", method = RequestMethod.GET)
    public String filterfacilityapprovedorders(Model model, HttpServletRequest request) {
        List<Map> facilityunitsList = new ArrayList<>();

        String[] params = {"facilityid", "active"};
        Object[] paramsValues = {request.getSession().getAttribute("sessionActiveLoginFacility"), Boolean.TRUE};
        String[] fields = {"facilityunitid", "facilityunitname"};
        List<Object[]> facilityunits = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields, "WHERE facilityid=:facilityid AND active=:active", params, paramsValues);
        if (facilityunits != null) {
            Map<String, Object> facilityunitsRow;
            for (Object[] facilityunit : facilityunits) {
                facilityunitsRow = new HashMap<>();

                facilityunitsRow.put("facilityunitid", facilityunit[0]);
                facilityunitsRow.put("facilityunitname", facilityunit[1]);
                facilityunitsList.add(facilityunitsRow);
            }
        }
        model.addAttribute("facilityunitsList", facilityunitsList);
        model.addAttribute("serverdate", formatterwithtime.format(serverDate));
        return "inventoryAndSupplies/approveFacilityOrders/internalOrders/forms/filterOrdersBy";
    }

    @RequestMapping(value = "/viewfacilityapproveorderitems.htm", method = RequestMethod.GET)
    public String viewfacilityapproveorderitems(Model model, HttpServletRequest request) {
        List<Map> facilityorderitemsList = new ArrayList<>();
        int approved=0;
        int unapproved=0;
        String[] params4 = {"facilityorderid"};
        Object[] paramsValues4 = {Long.parseLong(request.getParameter("facilityorderid"))};
        String[] fields4 = {"originstore", "destinationstore"};
        List<Object[]> originstore = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fields4, "WHERE facilityorderid=:facilityorderid", params4, paramsValues4);

        String[] params = {"facilityorderid"};
        Object[] paramsValues = {Long.parseLong(request.getParameter("facilityorderid"))};
        String[] fields = {"facilityorderitemsid", "qtyordered", "itemid.itemid", "qtyapproved", "approved"};
        List<Object[]> facilityinternalorderitems = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fields, "WHERE facilityorderid=:facilityorderid ORDER BY facilityorderitemsid ASC", params, paramsValues);
        if (facilityinternalorderitems != null) {
            Map<String, Object> facilityorderitemsRow;
            for (Object[] facilityinternalorderitem : facilityinternalorderitems) {
                facilityorderitemsRow = new HashMap<>();

                facilityorderitemsRow.put("facilityorderitemsid", facilityinternalorderitem[0]);
                facilityorderitemsRow.put("qtyordered", facilityinternalorderitem[1]);
                facilityorderitemsRow.put("qtyonorder", String.format("%,d", Integer.valueOf(String.valueOf(((BigInteger) facilityinternalorderitem[1]).longValue()))));
                facilityorderitemsRow.put("stockbalance", String.format("%,d", facilityunitstockbalance(facilityinternalorderitem[2], originstore.get(0)[0])));

                facilityorderitemsRow.put("approved", facilityinternalorderitem[4]);
                if ((Boolean) facilityinternalorderitem[4]) {
                    approved=approved+1;
                    facilityorderitemsRow.put("qtyapproved", facilityinternalorderitem[3]);
                    facilityorderitemsRow.put("qtyapprove", String.format("%,d", Integer.valueOf(String.valueOf(((BigInteger) facilityinternalorderitem[3]).longValue()))));

                } else {
                    unapproved+=1;
                    facilityorderitemsRow.put("qtyapproved", 0);
                    facilityorderitemsRow.put("qtyapprove", 0);
                }
                String[] params1 = {"itempackageid"};
                Object[] paramsValues1 = {facilityinternalorderitem[2]};
                String[] fields1 = {"packagename"};
                List<String> itemname = (List<String>) genericClassService.fetchRecord(Itempackage.class, fields1, "WHERE itempackageid=:itempackageid", params1, paramsValues1);
                if (itemname != null) {
                    facilityorderitemsRow.put("itemname", itemname.get(0));
                }
                facilityorderitemsList.add(facilityorderitemsRow);

            }
        }
        model.addAttribute("approved", approved);
        model.addAttribute("unapproved", unapproved);
        model.addAttribute("facilityorderitemsList", facilityorderitemsList);
        model.addAttribute("size", facilityorderitemsList.size());
        model.addAttribute("facilityorderid", request.getParameter("facilityorderid"));

        return "inventoryAndSupplies/approveFacilityOrders/internalOrders/forms/approveOderItems";
    }

    private Integer facilityunitstockbalance(Object itemid, Object facilityunitid) {
        String[] paramsCellitem = {"itemid", "facilityunitid"};
        Object[] paramsValuesCellitem = {itemid, facilityunitid};
        String whereCellitem = "WHERE itemid=:itemid AND facilityunitid=:facilityunitid";
        String[] fieldsCellitem = {"stockid", "quantityrecieved", "expirydate", "stockissued"};
        List<Object[]> objCellitem = (List<Object[]>) genericClassService.fetchRecord(com.iics.store.Stock.class, fieldsCellitem, whereCellitem, paramsCellitem, paramsValuesCellitem);
        int stockBalance = 0;
        //NEED THIS
        if (objCellitem != null) {
            for (Object[] cellitem : objCellitem) {
                if (cellitem[1] != null) {
                    if ((Integer) cellitem[1] > 0) {
                        stockBalance = stockBalance + (((int) cellitem[1]) - ((Integer) cellitem[3]));
                    }
                }
            }
        }

        return stockBalance;
    }

    @RequestMapping(value = "/approvedfalityorderitem.htm")
    public @ResponseBody
    String approvedfalityorderitem(HttpServletRequest request) {
        String results = "";
        if ("approved".equals(request.getParameter("type"))) {
            String[] columns = {"approved", "dateapproved"};
            Object[] columnValues = {Boolean.TRUE, new Date()};
            String pk = "facilityorderitemsid";
            Object pkValue = Long.parseLong(request.getParameter("facilityorderitemsid"));
            int result = genericClassService.updateRecordSQLSchemaStyle(Facilityorderitems.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                results = "success";
            }
        } else if ("submitted".equals(request.getParameter("type"))) {
            String[] columns = {"status", "approved", "approvedby", "dateapproved"};
            Object[] columnValues = {"SENT", Boolean.TRUE, (Long) request.getSession().getAttribute("person_id"), new Date()};
            String pk = "facilityorderid";
            Object pkValue = Long.parseLong(request.getParameter("facilityorderid"));
            int result = genericClassService.updateRecordSQLSchemaStyle(Facilityorder.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                results = "success";
            }
        }
        if ("unapproved".equals(request.getParameter("type"))) {
            String[] columns = {"approved"};
            Object[] columnValues = {Boolean.FALSE};
            String pk = "facilityorderitemsid";
            Object pkValue = Long.parseLong(request.getParameter("facilityorderitemsid"));
            int result = genericClassService.updateRecordSQLSchemaStyle(Facilityorderitems.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                results = "success";
            }
        }

        return results;

    }

    @RequestMapping(value = "/viewLstApprovedOrderItems.htm", method = RequestMethod.GET)
    public String viewLstApprovedOrderItems(Model model, HttpServletRequest request) {
        List<Map> facilityorderitemsList = new ArrayList<>();
        String[] params = {"facilityorderid", "approved"};
        Object[] paramsValues = {Long.parseLong(request.getParameter("facilityorderid")), Boolean.TRUE};
        String[] fields = {"facilityorderitemsid", "qtyordered", "itemid.itemid", "qtyapproved"};
        List<Object[]> facilityinternalorderitems = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fields, "WHERE facilityorderid=:facilityorderid AND approved=:approved", params, paramsValues);
        if (facilityinternalorderitems != null) {
            Map<String, Object> facilityorderitemsRow;
            for (Object[] facilityinternalorderitem : facilityinternalorderitems) {
                facilityorderitemsRow = new HashMap<>();

                facilityorderitemsRow.put("facilityorderitemsid", facilityinternalorderitem[0]);
                facilityorderitemsRow.put("qtyordered", facilityinternalorderitem[1]);
                facilityorderitemsRow.put("qtyonorder", String.format("%,d", Integer.valueOf(String.valueOf(((BigInteger) facilityinternalorderitem[1]).longValue()))));
                facilityorderitemsRow.put("qtyapproved", String.format("%,d", Integer.valueOf(String.valueOf(((BigInteger) facilityinternalorderitem[3]).longValue()))));

                String[] params1 = {"itempackageid"};
                Object[] paramsValues1 = {facilityinternalorderitem[2]};
                String[] fields1 = {"packagename"};
                List<String> itemname = (List<String>) genericClassService.fetchRecord(Itempackage.class, fields1, "WHERE itempackageid=:itempackageid", params1, paramsValues1);
                if (itemname != null) {
                    facilityorderitemsRow.put("itemname", itemname.get(0));

                }
                facilityorderitemsList.add(facilityorderitemsRow);

            }
        }
        model.addAttribute("facilityorderitemsList", facilityorderitemsList);
        return "inventoryAndSupplies/approveFacilityOrders/internalOrders/views/approvedOrderItems";
    }

    @RequestMapping(value = "/printapprovedorderitemspno.htm")
    public @ResponseBody
    String printapprovedorderitemspno(HttpServletRequest request) {
        String results = "";
        String[] params = {"facilityorderid", "approved"};
        Object[] paramsValues = {Long.parseLong(request.getParameter("facilityorderid")), Boolean.TRUE};
        String[] fields = {"facilityorderitemsid", "qtyordered"};
        List<Object[]> facilityinternalorderitems = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fields, "WHERE facilityorderid=:facilityorderid AND approved=:approved", params, paramsValues);
        if (facilityinternalorderitems != null) {
            results = String.valueOf(facilityinternalorderitems.size());
        } else {
            results = "zero";
        }
        return results;
    }

    @RequestMapping(value = "/viewapprovedorderitemspno.htm", method = RequestMethod.GET)
    public String viewapprovedorderitemspno(Model model, HttpServletRequest request) {
        List<Map> facilityorderitemsList = new ArrayList<>();

        String[] params4 = {"facilityorderid"};
        Object[] paramsValues4 = {Long.parseLong(request.getParameter("facilityorderid"))};
        String[] fields4 = {"originstore", "destinationstore"};
        List<Object[]> originstore = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fields4, "WHERE facilityorderid=:facilityorderid", params4, paramsValues4);

        String[] params = {"facilityorderid", "approved"};
        Object[] paramsValues = {Long.parseLong(request.getParameter("facilityorderid")), Boolean.TRUE};
        String[] fields = {"facilityorderitemsid", "qtyordered", "itemid.itemid"};
        List<Object[]> facilityinternalorderitems = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fields, "WHERE facilityorderid=:facilityorderid AND approved=:approved", params, paramsValues);
        if (facilityinternalorderitems != null) {
            Map<String, Object> facilityorderitemsRow;
            for (Object[] facilityinternalorderitem : facilityinternalorderitems) {
                facilityorderitemsRow = new HashMap<>();

                String[] params1 = {"itempackageid"};
                Object[] paramsValues1 = {facilityinternalorderitem[2]};
                String[] fields1 = {"packagename"};
                List<String> itemname = (List<String>) genericClassService.fetchRecord(Itempackage.class, fields1, "WHERE itempackageid=:itempackageid", params1, paramsValues1);
                if (itemname != null) {
                    facilityorderitemsRow.put("facilityorderitemsid", facilityinternalorderitem[0]);
                    facilityorderitemsRow.put("qtyordered", facilityinternalorderitem[1]);
                    facilityorderitemsRow.put("packagename", itemname.get(0));
                    facilityorderitemsRow.put("stockbalance", String.format("%,d", facilityunitstockbalance(facilityinternalorderitem[2], originstore.get(0)[0])));

                    facilityorderitemsList.add(facilityorderitemsRow);
                }

            }
        }
        model.addAttribute("facilityorderitemsList", facilityorderitemsList);
        model.addAttribute("facilityorderid", request.getParameter("facilityorderid"));
        return "inventoryAndSupplies/approveFacilityOrders/internalOrders/views/approvedItems";
    }

    @RequestMapping(value = "/filterfacilityapprovedorderitems.htm")
    public String filterfacilityapprovedorderitems(HttpServletRequest request, Model model) {
        List<Map> facilityinternalordersList = new ArrayList<>();
        try {
            if (Integer.parseInt(request.getParameter("startdatesize")) != 0 && Integer.parseInt(request.getParameter("enddatesize")) != 0 && Integer.parseInt(request.getParameter("facilityunitsize")) != 0) {
                String[] params = {"ordertype", "approved", "originstore", "destinationstore", "startdate", "enddate"};
                Object[] paramsValues = {"INTERNAL", Boolean.TRUE, BigInteger.valueOf(Long.parseLong(request.getParameter("facilityunit"))), BigInteger.valueOf(Long.parseLong(request.getParameter("facilityunit"))), formatter.parse(request.getParameter("startdate").replaceAll("/", "-")), formatter.parse(request.getParameter("enddate").replaceAll("/", "-"))};
                String[] fields = {"facilityorderid", "originstore", "destinationstore", "preparedby", "dateprepared", "facilityorderno", "dateapproved", "approvedby"};
                List<Object[]> internalorders = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fields, "WHERE ordertype=:ordertype AND approved=:approved AND (originstore=:originstore OR destinationstore=:destinationstore) AND dateapproved>=:startdate AND dateapproved<=:enddate ORDER BY dateapproved", params, paramsValues);
                if (internalorders != null) {
                    Map<String, Object> internalOrdersRow;
                    for (Object[] internalorder : internalorders) {
                        internalOrdersRow = new HashMap<>();
                        internalOrdersRow.put("facilityorderid", internalorder[0]);
                        internalOrdersRow.put("dateprepared", formatter.format((Date) internalorder[4]));
                        internalOrdersRow.put("facilityorderno", internalorder[5]);

                        String[] params1 = {"facilityunitid"};
                        Object[] paramsValues1 = {internalorder[1]};
                        String[] fields1 = {"facilityunitname", "shortname"};
                        List<Object[]> orderingstore = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields1, "WHERE facilityunitid=:facilityunitid", params1, paramsValues1);
                        internalOrdersRow.put("orderingstore", orderingstore.get(0)[0]);

                        String[] params8 = {"facilityunitid"};
                        Object[] paramsValues8 = {internalorder[2]};
                        String[] fields8 = {"facilityunitname", "shortname"};
                        String where8 = "WHERE facilityunitid=:facilityunitid";
                        List<Object[]> destinationstore = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields8, where8, params8, paramsValues8);
                        internalOrdersRow.put("destinationstore", destinationstore.get(0)[0]);

                        int internalorderitemscount = 0;
                        String[] paramsc = {"facilityorderid", "approved"};
                        Object[] paramsValuesc = {internalorder[0], Boolean.TRUE};
                        String where = "WHERE facilityorderid=:facilityorderid AND approved=:approved";
                        internalorderitemscount = genericClassService.fetchRecordCount(Facilityorderitems.class, where, paramsc, paramsValuesc);

                        String[] params3 = {"personid"};
                        Object[] paramsValues3 = {internalorder[3]};
                        String[] fields3 = {"firstname", "lastname", "othernames"};
                        List<Object[]> createdby = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields3, "WHERE personid=:personid", params3, paramsValues3);
                        if (createdby != null) {
                            internalOrdersRow.put("createdby", createdby.get(0)[0] + " " + createdby.get(0)[1] + " " + createdby.get(0)[2]);
                        }
                        internalOrdersRow.put("itemscount", internalorderitemscount);
                        internalOrdersRow.put("dateapproved", formatter.format((Date) internalorder[6]));
                        String[] params4 = {"personid"};
                        Object[] paramsValues4 = {internalorder[7]};
                        String[] fields4 = {"firstname", "lastname", "othernames"};
                        List<Object[]> approvedby = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields4, "WHERE personid=:personid", params4, paramsValues4);
                        if (approvedby != null) {
                            internalOrdersRow.put("approvedby", approvedby.get(0)[0] + " " + approvedby.get(0)[1] + " " + approvedby.get(0)[2]);
                        }
                        facilityinternalordersList.add(internalOrdersRow);
                    }
                }

            }
            if (Integer.parseInt(request.getParameter("startdatesize")) != 0 && Integer.parseInt(request.getParameter("enddatesize")) == 0 && Integer.parseInt(request.getParameter("facilityunitsize")) == 0) {
                Set<Long> facilityunitset = new HashSet<>();
                String[] params9 = {"facilityid"};
                Object[] paramsValues9 = {request.getSession().getAttribute("sessionActiveLoginFacility")};
                String[] fields9 = {"facilityunitid"};
                List<Long> facilityunits = (List<Long>) genericClassService.fetchRecord(Facilityunit.class, fields9, "WHERE facilityid=:facilityid", params9, paramsValues9);
                if (facilityunits != null) {
                    for (Long facilityunit : facilityunits) {
                        facilityunitset.add(facilityunit);
                    }
                }
                String[] params = {"ordertype", "approved", "startdate"};
                Object[] paramsValues = {"INTERNAL", Boolean.TRUE, formatter.parse(request.getParameter("startdate").replaceAll("/", "-"))};
                String[] fields = {"facilityorderid", "originstore", "destinationstore", "preparedby", "dateprepared", "facilityorderno", "dateapproved", "approvedby"};
                List<Object[]> internalorders = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fields, "WHERE ordertype=:ordertype AND approved=:approved AND dateapproved>=:startdate ORDER BY dateapproved", params, paramsValues);
                if (internalorders != null) {
                    Map<String, Object> internalOrdersRow;
                    for (Object[] internalorder : internalorders) {
                        internalOrdersRow = new HashMap<>();
                        if (!facilityunitset.isEmpty()) {
                            if (facilityunitset.contains(((BigInteger) internalorder[1]).longValue()) || facilityunitset.contains(((BigInteger) internalorder[2]).longValue())) {
                                internalOrdersRow.put("facilityorderid", internalorder[0]);
                                internalOrdersRow.put("dateprepared", formatter.format((Date) internalorder[4]));
                                internalOrdersRow.put("facilityorderno", internalorder[5]);

                                String[] params1 = {"facilityunitid"};
                                Object[] paramsValues1 = {internalorder[1]};
                                String[] fields1 = {"facilityunitname", "shortname"};
                                List<Object[]> orderingstore = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields1, "WHERE facilityunitid=:facilityunitid", params1, paramsValues1);
                                internalOrdersRow.put("orderingstore", orderingstore.get(0)[0]);

                                String[] params8 = {"facilityunitid"};
                                Object[] paramsValues8 = {internalorder[2]};
                                String[] fields8 = {"facilityunitname", "shortname"};
                                String where8 = "WHERE facilityunitid=:facilityunitid";
                                List<Object[]> destinationstore = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields8, where8, params8, paramsValues8);
                                internalOrdersRow.put("destinationstore", destinationstore.get(0)[0]);

                                int internalorderitemscount = 0;
                                String[] paramsc = {"facilityorderid", "approved"};
                                Object[] paramsValuesc = {internalorder[0], Boolean.TRUE};
                                String where = "WHERE facilityorderid=:facilityorderid AND approved=:approved";
                                internalorderitemscount = genericClassService.fetchRecordCount(Facilityorderitems.class, where, paramsc, paramsValuesc);

                                String[] params3 = {"personid"};
                                Object[] paramsValues3 = {internalorder[3]};
                                String[] fields3 = {"firstname", "lastname", "othernames"};
                                List<Object[]> createdby = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields3, "WHERE personid=:personid", params3, paramsValues3);
                                if (createdby != null) {
                                    internalOrdersRow.put("createdby", createdby.get(0)[0] + " " + createdby.get(0)[1] + " " + createdby.get(0)[2]);
                                }
                                internalOrdersRow.put("itemscount", internalorderitemscount);
                                internalOrdersRow.put("dateapproved", formatter.format((Date) internalorder[6]));
                                String[] params4 = {"personid"};
                                Object[] paramsValues4 = {internalorder[7]};
                                String[] fields4 = {"firstname", "lastname", "othernames"};
                                List<Object[]> approvedby = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields4, "WHERE personid=:personid", params4, paramsValues4);
                                if (approvedby != null) {
                                    internalOrdersRow.put("approvedby", approvedby.get(0)[0] + " " + approvedby.get(0)[1] + " " + approvedby.get(0)[2]);
                                }
                                facilityinternalordersList.add(internalOrdersRow);
                            }
                        }

                    }
                }
            }
            if (Integer.parseInt(request.getParameter("startdatesize")) != 0 && Integer.parseInt(request.getParameter("enddatesize")) != 0 && Integer.parseInt(request.getParameter("facilityunitsize")) == 0) {
                Set<Long> facilityunitset = new HashSet<>();
                String[] params9 = {"facilityid"};
                Object[] paramsValues9 = {request.getSession().getAttribute("sessionActiveLoginFacility")};
                String[] fields9 = {"facilityunitid"};
                List<Long> facilityunits = (List<Long>) genericClassService.fetchRecord(Facilityunit.class, fields9, "WHERE facilityid=:facilityid", params9, paramsValues9);
                if (facilityunits != null) {
                    for (Long facilityunit : facilityunits) {
                        facilityunitset.add(facilityunit);
                    }
                }
                String[] params = {"ordertype", "approved", "startdate", "enddate"};
                Object[] paramsValues = {"INTERNAL", Boolean.TRUE, formatter.parse(request.getParameter("startdate").replaceAll("/", "-")), formatter.parse(request.getParameter("enddate").replaceAll("/", "-"))};
                String[] fields = {"facilityorderid", "originstore", "destinationstore", "preparedby", "dateprepared", "facilityorderno", "dateapproved", "approvedby"};
                List<Object[]> internalorders = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fields, "WHERE ordertype=:ordertype AND approved=:approved AND dateapproved>=:startdate AND dateapproved<=:enddate ORDER BY dateapproved", params, paramsValues);
                if (internalorders != null) {
                    Map<String, Object> internalOrdersRow;
                    for (Object[] internalorder : internalorders) {
                        internalOrdersRow = new HashMap<>();
                        if (!facilityunitset.isEmpty()) {
                            if (facilityunitset.contains(((BigInteger) internalorder[1]).longValue()) || facilityunitset.contains(((BigInteger) internalorder[2]).longValue())) {
                                internalOrdersRow.put("facilityorderid", internalorder[0]);
                                internalOrdersRow.put("dateprepared", formatter.format((Date) internalorder[4]));
                                internalOrdersRow.put("facilityorderno", internalorder[5]);

                                String[] params1 = {"facilityunitid"};
                                Object[] paramsValues1 = {internalorder[1]};
                                String[] fields1 = {"facilityunitname", "shortname"};
                                List<Object[]> orderingstore = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields1, "WHERE facilityunitid=:facilityunitid", params1, paramsValues1);
                                internalOrdersRow.put("orderingstore", orderingstore.get(0)[0]);

                                String[] params8 = {"facilityunitid"};
                                Object[] paramsValues8 = {internalorder[2]};
                                String[] fields8 = {"facilityunitname", "shortname"};
                                String where8 = "WHERE facilityunitid=:facilityunitid";
                                List<Object[]> destinationstore = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields8, where8, params8, paramsValues8);
                                internalOrdersRow.put("destinationstore", destinationstore.get(0)[0]);

                                int internalorderitemscount = 0;
                                String[] paramsc = {"facilityorderid", "approved"};
                                Object[] paramsValuesc = {internalorder[0], Boolean.TRUE};
                                String where = "WHERE facilityorderid=:facilityorderid AND approved=:approved";
                                internalorderitemscount = genericClassService.fetchRecordCount(Facilityorderitems.class, where, paramsc, paramsValuesc);

                                String[] params3 = {"personid"};
                                Object[] paramsValues3 = {internalorder[3]};
                                String[] fields3 = {"firstname", "lastname", "othernames"};
                                List<Object[]> createdby = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields3, "WHERE personid=:personid", params3, paramsValues3);
                                if (createdby != null) {
                                    internalOrdersRow.put("createdby", createdby.get(0)[0] + " " + createdby.get(0)[1] + " " + createdby.get(0)[2]);
                                }
                                internalOrdersRow.put("itemscount", internalorderitemscount);
                                internalOrdersRow.put("dateapproved", formatter.format((Date) internalorder[6]));
                                String[] params4 = {"personid"};
                                Object[] paramsValues4 = {internalorder[7]};
                                String[] fields4 = {"firstname", "lastname", "othernames"};
                                List<Object[]> approvedby = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields4, "WHERE personid=:personid", params4, paramsValues4);
                                if (approvedby != null) {
                                    internalOrdersRow.put("approvedby", approvedby.get(0)[0] + " " + approvedby.get(0)[1] + " " + approvedby.get(0)[2]);
                                }
                                facilityinternalordersList.add(internalOrdersRow);
                            }
                        }

                    }
                }
            }
            if (Integer.parseInt(request.getParameter("startdatesize")) == 0 && Integer.parseInt(request.getParameter("enddatesize")) == 0 && Integer.parseInt(request.getParameter("facilityunitsize")) != 0) {
                String[] params = {"ordertype", "approved", "originstore", "destinationstore"};
                Object[] paramsValues = {"INTERNAL", Boolean.TRUE, BigInteger.valueOf(Long.parseLong(request.getParameter("facilityunit"))), BigInteger.valueOf(Long.parseLong(request.getParameter("facilityunit")))};
                String[] fields = {"facilityorderid", "originstore", "destinationstore", "preparedby", "dateprepared", "facilityorderno", "dateapproved", "approvedby"};
                List<Object[]> internalorders = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fields, "WHERE ordertype=:ordertype AND approved=:approved AND (originstore=:originstore OR destinationstore=:destinationstore) ORDER BY dateapproved", params, paramsValues);
                if (internalorders != null) {
                    Map<String, Object> internalOrdersRow;
                    for (Object[] internalorder : internalorders) {
                        internalOrdersRow = new HashMap<>();
                        internalOrdersRow.put("facilityorderid", internalorder[0]);
                        internalOrdersRow.put("dateprepared", formatter.format((Date) internalorder[4]));
                        internalOrdersRow.put("facilityorderno", internalorder[5]);

                        String[] params1 = {"facilityunitid"};
                        Object[] paramsValues1 = {internalorder[1]};
                        String[] fields1 = {"facilityunitname", "shortname"};
                        List<Object[]> orderingstore = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields1, "WHERE facilityunitid=:facilityunitid", params1, paramsValues1);
                        internalOrdersRow.put("orderingstore", orderingstore.get(0)[0]);

                        String[] params8 = {"facilityunitid"};
                        Object[] paramsValues8 = {internalorder[2]};
                        String[] fields8 = {"facilityunitname", "shortname"};
                        String where8 = "WHERE facilityunitid=:facilityunitid";
                        List<Object[]> destinationstore = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields8, where8, params8, paramsValues8);
                        internalOrdersRow.put("destinationstore", destinationstore.get(0)[0]);

                        int internalorderitemscount = 0;
                        String[] paramsc = {"facilityorderid", "approved"};
                        Object[] paramsValuesc = {internalorder[0], Boolean.TRUE};
                        String where = "WHERE facilityorderid=:facilityorderid AND approved=:approved";
                        internalorderitemscount = genericClassService.fetchRecordCount(Facilityorderitems.class, where, paramsc, paramsValuesc);

                        String[] params3 = {"personid"};
                        Object[] paramsValues3 = {internalorder[3]};
                        String[] fields3 = {"firstname", "lastname", "othernames"};
                        List<Object[]> createdby = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields3, "WHERE personid=:personid", params3, paramsValues3);
                        if (createdby != null) {
                            internalOrdersRow.put("createdby", createdby.get(0)[0] + " " + createdby.get(0)[1] + " " + createdby.get(0)[2]);
                        }
                        internalOrdersRow.put("itemscount", internalorderitemscount);
                        internalOrdersRow.put("dateapproved", formatter.format((Date) internalorder[6]));
                        String[] params4 = {"personid"};
                        Object[] paramsValues4 = {internalorder[7]};
                        String[] fields4 = {"firstname", "lastname", "othernames"};
                        List<Object[]> approvedby = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields4, "WHERE personid=:personid", params4, paramsValues4);
                        if (approvedby != null) {
                            internalOrdersRow.put("approvedby", approvedby.get(0)[0] + " " + approvedby.get(0)[1] + " " + approvedby.get(0)[2]);
                        }
                        facilityinternalordersList.add(internalOrdersRow);
                    }
                }

            }
            if (Integer.parseInt(request.getParameter("startdatesize")) == 0 && Integer.parseInt(request.getParameter("enddatesize")) != 0 && Integer.parseInt(request.getParameter("facilityunitsize")) != 0) {
                String[] params = {"ordertype", "approved", "originstore", "destinationstore", "enddate"};
                Object[] paramsValues = {"INTERNAL", Boolean.TRUE, BigInteger.valueOf(Long.parseLong(request.getParameter("facilityunit"))), BigInteger.valueOf(Long.parseLong(request.getParameter("facilityunit"))), formatter.parse(request.getParameter("enddate").replaceAll("/", "-"))};
                String[] fields = {"facilityorderid", "originstore", "destinationstore", "preparedby", "dateprepared", "facilityorderno", "dateapproved", "approvedby"};
                List<Object[]> internalorders = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fields, "WHERE ordertype=:ordertype AND approved=:approved AND (originstore=:originstore OR destinationstore=:destinationstore) AND dateapproved<=:enddate ORDER BY dateapproved", params, paramsValues);
                if (internalorders != null) {
                    Map<String, Object> internalOrdersRow;
                    for (Object[] internalorder : internalorders) {
                        internalOrdersRow = new HashMap<>();
                        internalOrdersRow.put("facilityorderid", internalorder[0]);
                        internalOrdersRow.put("dateprepared", formatter.format((Date) internalorder[4]));
                        internalOrdersRow.put("facilityorderno", internalorder[5]);

                        String[] params1 = {"facilityunitid"};
                        Object[] paramsValues1 = {internalorder[1]};
                        String[] fields1 = {"facilityunitname", "shortname"};
                        List<Object[]> orderingstore = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields1, "WHERE facilityunitid=:facilityunitid", params1, paramsValues1);
                        internalOrdersRow.put("orderingstore", orderingstore.get(0)[0]);

                        String[] params8 = {"facilityunitid"};
                        Object[] paramsValues8 = {internalorder[2]};
                        String[] fields8 = {"facilityunitname", "shortname"};
                        String where8 = "WHERE facilityunitid=:facilityunitid";
                        List<Object[]> destinationstore = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields8, where8, params8, paramsValues8);
                        internalOrdersRow.put("destinationstore", destinationstore.get(0)[0]);

                        int internalorderitemscount = 0;
                        String[] paramsc = {"facilityorderid", "approved"};
                        Object[] paramsValuesc = {internalorder[0], Boolean.TRUE};
                        String where = "WHERE facilityorderid=:facilityorderid AND approved=:approved";
                        internalorderitemscount = genericClassService.fetchRecordCount(Facilityorderitems.class, where, paramsc, paramsValuesc);

                        String[] params3 = {"personid"};
                        Object[] paramsValues3 = {internalorder[3]};
                        String[] fields3 = {"firstname", "lastname", "othernames"};
                        List<Object[]> createdby = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields3, "WHERE personid=:personid", params3, paramsValues3);
                        if (createdby != null) {
                            internalOrdersRow.put("createdby", createdby.get(0)[0] + " " + createdby.get(0)[1] + " " + createdby.get(0)[2]);
                        }
                        internalOrdersRow.put("itemscount", internalorderitemscount);
                        internalOrdersRow.put("dateapproved", formatter.format((Date) internalorder[6]));
                        String[] params4 = {"personid"};
                        Object[] paramsValues4 = {internalorder[7]};
                        String[] fields4 = {"firstname", "lastname", "othernames"};
                        List<Object[]> approvedby = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields4, "WHERE personid=:personid", params4, paramsValues4);
                        if (approvedby != null) {
                            internalOrdersRow.put("approvedby", approvedby.get(0)[0] + " " + approvedby.get(0)[1] + " " + approvedby.get(0)[2]);
                        }
                        facilityinternalordersList.add(internalOrdersRow);
                    }
                }
            }
            if (Integer.parseInt(request.getParameter("startdatesize")) == 0 && Integer.parseInt(request.getParameter("enddatesize")) != 0 && Integer.parseInt(request.getParameter("facilityunitsize")) == 0) {
                Set<Long> facilityunitset = new HashSet<>();
                String[] params9 = {"facilityid"};
                Object[] paramsValues9 = {request.getSession().getAttribute("sessionActiveLoginFacility")};
                String[] fields9 = {"facilityunitid"};
                List<Long> facilityunits = (List<Long>) genericClassService.fetchRecord(Facilityunit.class, fields9, "WHERE facilityid=:facilityid", params9, paramsValues9);
                if (facilityunits != null) {
                    for (Long facilityunit : facilityunits) {
                        facilityunitset.add(facilityunit);
                    }
                }
                String[] params = {"ordertype", "approved", "enddate"};
                Object[] paramsValues = {"INTERNAL", Boolean.TRUE, formatter.parse(request.getParameter("enddate").replaceAll("/", "-"))};
                String[] fields = {"facilityorderid", "originstore", "destinationstore", "preparedby", "dateprepared", "facilityorderno", "dateapproved", "approvedby"};
                List<Object[]> internalorders = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fields, "WHERE ordertype=:ordertype AND approved=:approved AND dateapproved<=:enddate ORDER BY dateapproved", params, paramsValues);
                if (internalorders != null) {
                    Map<String, Object> internalOrdersRow;
                    for (Object[] internalorder : internalorders) {
                        internalOrdersRow = new HashMap<>();
                        if (!facilityunitset.isEmpty()) {
                            if (facilityunitset.contains(((BigInteger) internalorder[1]).longValue()) || facilityunitset.contains(((BigInteger) internalorder[2]).longValue())) {
                                internalOrdersRow.put("facilityorderid", internalorder[0]);
                                internalOrdersRow.put("dateprepared", formatter.format((Date) internalorder[4]));
                                internalOrdersRow.put("facilityorderno", internalorder[5]);

                                String[] params1 = {"facilityunitid"};
                                Object[] paramsValues1 = {internalorder[1]};
                                String[] fields1 = {"facilityunitname", "shortname"};
                                List<Object[]> orderingstore = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields1, "WHERE facilityunitid=:facilityunitid", params1, paramsValues1);
                                internalOrdersRow.put("orderingstore", orderingstore.get(0)[0]);

                                String[] params8 = {"facilityunitid"};
                                Object[] paramsValues8 = {internalorder[2]};
                                String[] fields8 = {"facilityunitname", "shortname"};
                                String where8 = "WHERE facilityunitid=:facilityunitid";
                                List<Object[]> destinationstore = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields8, where8, params8, paramsValues8);
                                internalOrdersRow.put("destinationstore", destinationstore.get(0)[0]);

                                int internalorderitemscount = 0;
                                String[] paramsc = {"facilityorderid", "approved"};
                                Object[] paramsValuesc = {internalorder[0], Boolean.TRUE};
                                String where = "WHERE facilityorderid=:facilityorderid AND approved=:approved";
                                internalorderitemscount = genericClassService.fetchRecordCount(Facilityorderitems.class, where, paramsc, paramsValuesc);

                                String[] params3 = {"personid"};
                                Object[] paramsValues3 = {internalorder[3]};
                                String[] fields3 = {"firstname", "lastname", "othernames"};
                                List<Object[]> createdby = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields3, "WHERE personid=:personid", params3, paramsValues3);
                                if (createdby != null) {
                                    internalOrdersRow.put("createdby", createdby.get(0)[0] + " " + createdby.get(0)[1] + " " + createdby.get(0)[2]);
                                }
                                internalOrdersRow.put("itemscount", internalorderitemscount);
                                internalOrdersRow.put("dateapproved", formatter.format((Date) internalorder[6]));
                                String[] params4 = {"personid"};
                                Object[] paramsValues4 = {internalorder[7]};
                                String[] fields4 = {"firstname", "lastname", "othernames"};
                                List<Object[]> approvedby = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields4, "WHERE personid=:personid", params4, paramsValues4);
                                if (approvedby != null) {
                                    internalOrdersRow.put("approvedby", approvedby.get(0)[0] + " " + approvedby.get(0)[1] + " " + approvedby.get(0)[2]);
                                }
                                facilityinternalordersList.add(internalOrdersRow);
                            }
                        }

                    }
                }
            }
            if (Integer.parseInt(request.getParameter("startdatesize")) != 0 && Integer.parseInt(request.getParameter("enddatesize")) == 0 && Integer.parseInt(request.getParameter("facilityunitsize")) != 0) {
                String[] params = {"ordertype", "approved", "originstore", "destinationstore", "startdate"};
                Object[] paramsValues = {"INTERNAL", Boolean.TRUE, BigInteger.valueOf(Long.parseLong(request.getParameter("facilityunit"))), BigInteger.valueOf(Long.parseLong(request.getParameter("facilityunit"))), formatter.parse(request.getParameter("startdate").replaceAll("/", "-"))};
                String[] fields = {"facilityorderid", "originstore", "destinationstore", "preparedby", "dateprepared", "facilityorderno", "dateapproved", "approvedby"};
                List<Object[]> internalorders = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fields, "WHERE ordertype=:ordertype AND approved=:approved AND (originstore=:originstore OR destinationstore=:destinationstore) AND dateapproved>=:startdate ORDER BY dateapproved", params, paramsValues);
                if (internalorders != null) {
                    Map<String, Object> internalOrdersRow;
                    for (Object[] internalorder : internalorders) {
                        internalOrdersRow = new HashMap<>();
                        internalOrdersRow.put("facilityorderid", internalorder[0]);
                        internalOrdersRow.put("dateprepared", formatter.format((Date) internalorder[4]));
                        internalOrdersRow.put("facilityorderno", internalorder[5]);

                        String[] params1 = {"facilityunitid"};
                        Object[] paramsValues1 = {internalorder[1]};
                        String[] fields1 = {"facilityunitname", "shortname"};
                        List<Object[]> orderingstore = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields1, "WHERE facilityunitid=:facilityunitid", params1, paramsValues1);
                        internalOrdersRow.put("orderingstore", orderingstore.get(0)[0]);

                        String[] params8 = {"facilityunitid"};
                        Object[] paramsValues8 = {internalorder[2]};
                        String[] fields8 = {"facilityunitname", "shortname"};
                        String where8 = "WHERE facilityunitid=:facilityunitid";
                        List<Object[]> destinationstore = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields8, where8, params8, paramsValues8);
                        internalOrdersRow.put("destinationstore", destinationstore.get(0)[0]);

                        int internalorderitemscount = 0;
                        String[] paramsc = {"facilityorderid", "approved"};
                        Object[] paramsValuesc = {internalorder[0], Boolean.TRUE};
                        String where = "WHERE facilityorderid=:facilityorderid AND approved=:approved";
                        internalorderitemscount = genericClassService.fetchRecordCount(Facilityorderitems.class, where, paramsc, paramsValuesc);

                        String[] params3 = {"personid"};
                        Object[] paramsValues3 = {internalorder[3]};
                        String[] fields3 = {"firstname", "lastname", "othernames"};
                        List<Object[]> createdby = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields3, "WHERE personid=:personid", params3, paramsValues3);
                        if (createdby != null) {
                            internalOrdersRow.put("createdby", createdby.get(0)[0] + " " + createdby.get(0)[1] + " " + createdby.get(0)[2]);
                        }
                        internalOrdersRow.put("itemscount", internalorderitemscount);
                        internalOrdersRow.put("dateapproved", formatter.format((Date) internalorder[6]));
                        String[] params4 = {"personid"};
                        Object[] paramsValues4 = {internalorder[7]};
                        String[] fields4 = {"firstname", "lastname", "othernames"};
                        List<Object[]> approvedby = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields4, "WHERE personid=:personid", params4, paramsValues4);
                        if (approvedby != null) {
                            internalOrdersRow.put("approvedby", approvedby.get(0)[0] + " " + approvedby.get(0)[1] + " " + approvedby.get(0)[2]);
                        }
                        facilityinternalordersList.add(internalOrdersRow);
                    }
                }
            }

        } catch (Exception e) {
            System.out.println(":::::::::::::::::::::::::::::::Error::" + e);
        }

        model.addAttribute("facilityinternalordersList", facilityinternalordersList);
        model.addAttribute("internalorders", facilityinternalordersList.size());
        return "inventoryAndSupplies/approveFacilityOrders/internalOrders/views/approvedOrders";
    }

    @RequestMapping(value = "/unapproveFacilityOrderItem.htm")
    public @ResponseBody
    String unapproveFacilityOrderItem(HttpServletRequest request) {
        String results = "";
        try {
            String[] columns = {"approved"};
            Object[] columnValues = {Boolean.FALSE};
            String pk = "facilityorderitemsid";
            Object pkValue = Long.parseLong(request.getParameter("facilityorderitemsid"));
            genericClassService.updateRecordSQLSchemaStyle(Facilityorderitems.class, columns, columnValues, pk, pkValue, "store");
        } catch (Exception ex) {

            System.out.println(ex);
        }
        return results;
    }

    @RequestMapping(value = "/viewItemsOnOrders.htm")
    public String viewItemsOnOrders(HttpServletRequest request, Model model) {
        List<Map> internalordersItems = new ArrayList<>();

        if ("a".equals(request.getParameter("act"))) {
            String[] params = {"facilityorderid"};
            Object[] paramsValues = {Long.parseLong(request.getParameter("facilityorderid"))};
            String[] fields = {"facilityorderitemsid", "itemid.itemid", "qtyordered", "qtyapproved"};
            List<Object[]> orderItems = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fields, "WHERE facilityorderid=:facilityorderid", params, paramsValues);
            if (orderItems != null) {
                Map<String, Object> orderItemsRow;
                for (Object[] orderItem : orderItems) {
                    orderItemsRow = new HashMap<>();

                    String[] params8 = {"itemid"};
                    Object[] paramsValues8 = {orderItem[1]};
                    String[] fields8 = {"packagename"};
                    String where8 = "WHERE itempackageid=:itemid";
                    List<String> packagename = (List<String>) genericClassService.fetchRecord(Itempackage.class, fields8, where8, params8, paramsValues8);
                    if (packagename != null) {
                        orderItemsRow.put("packagename", packagename.get(0));
                        orderItemsRow.put("qtyordered", String.format("%,d", ((BigInteger) orderItem[2]).longValue()));
                        orderItemsRow.put("qtyapproved", String.format("%,d", ((BigInteger) orderItem[3]).longValue()));
                        internalordersItems.add(orderItemsRow);
                    }
                }
            }
        } else {
            String[] params = {"facilityorderid", "approved"};
            Object[] paramsValues = {Long.parseLong(request.getParameter("facilityorderid")), Boolean.TRUE};
            String[] fields = {"facilityorderitemsid", "itemid.itemid", "qtyordered", "qtyapproved"};
            List<Object[]> orderItems = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fields, "WHERE facilityorderid=:facilityorderid AND approved=:approved", params, paramsValues);
            if (orderItems != null) {
                Map<String, Object> orderItemsRow;
                for (Object[] orderItem : orderItems) {
                    orderItemsRow = new HashMap<>();

                    String[] params8 = {"itemid"};
                    Object[] paramsValues8 = {orderItem[1]};
                    String[] fields8 = {"packagename"};
                    String where8 = "WHERE itempackageid=:itemid";
                    List<String> packagename = (List<String>) genericClassService.fetchRecord(Itempackage.class, fields8, where8, params8, paramsValues8);
                    if (packagename != null) {
                        orderItemsRow.put("packagename", packagename.get(0));
                        orderItemsRow.put("qtyordered", String.format("%,d", ((BigInteger) orderItem[2]).longValue()));
                        orderItemsRow.put("qtyapproved", String.format("%,d", ((BigInteger) orderItem[3]).longValue()));
                        internalordersItems.add(orderItemsRow);
                    }
                }
            }
        }

        model.addAttribute("internalordersItems", internalordersItems);
        model.addAttribute("act", request.getParameter("act"));
        return "inventoryAndSupplies/approveFacilityOrders/internalOrders/views/items";
    }
    //
    @RequestMapping(value = "/viewrejectedorderitems.htm")
    public String viewRejectedOrderItems(HttpServletRequest request, Model model) {
        List<Map> rejectedOrdersItems = new ArrayList<>();  
        try {
            String facilityOrderId = request.getParameter("facilityorderid");
            String facilityOrderNo = request.getParameter("facilityorderno");
            String orderStatus = request.getParameter("orderstatus");
            
            String[] fields = {"facilityorderitemsid", "itemid.itemid", "qtyordered", "qtyapproved"};
            String [] params = new String [] { "facilityorderid" };
            Object[] paramsValues = new Object [] { Long.parseLong(request.getParameter("facilityorderid")) };
            String where = "WHERE facilityorderid=:facilityorderid AND approved=false";
            List<Object[]> rejectedItems = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fields, where, params, paramsValues);               
            if (rejectedItems != null) {
                Map<String, Object> rejectedOrdersItem;
                for (Object[] rejectedItem : rejectedItems) {
                    rejectedOrdersItem = new HashMap<>();
                    params = new String[] {"itemid"};
                    paramsValues = new Object[] {rejectedItem[1]};
                    fields = new String[] {"packagename"};
                    where = "WHERE itempackageid=:itemid";
                    List<String> packagename = (List<String>) genericClassService.fetchRecord(Itempackage.class, fields, where, params, paramsValues);
                    if (packagename != null) {
                        rejectedOrdersItem.put("facilityorderitemsid", rejectedItem[0]);
                        rejectedOrdersItem.put("packagename", packagename.get(0));
                        rejectedOrdersItem.put("qtyordered", String.format("%,d", ((BigInteger) rejectedItem[2]).longValue()));
                        rejectedOrdersItem.put("qtyapproved", String.format("%,d", ((BigInteger) rejectedItem[3]).longValue()));
                        rejectedOrdersItems.add(rejectedOrdersItem);
                    }                
                }
            } 
            model.addAttribute("internalordersItems", rejectedOrdersItems);
            model.addAttribute("facilityorderid", facilityOrderId);
            model.addAttribute("facilityorderno", facilityOrderNo);
            model.addAttribute("orderstatus", orderStatus);
        } catch(Exception ex){
            System.out.println(ex);
        }
        return "inventoryAndSupplies/approveFacilityOrders/internalOrders/views/rejectedOrderItems";
    }
    //
    @RequestMapping(value = "/unitapprovedorders.htm")
    public String unitapprovedorders(HttpServletRequest request, Model model) {
        List<Map> facilityinternalordersList = new ArrayList<>();

        String[] params = {"ordertype", "approved", "originstore"};
        Object[] paramsValues = {"INTERNAL", Boolean.TRUE, request.getSession().getAttribute("sessionActiveLoginFacilityUnit")};
        String[] fields = {"facilityorderid", "originstore", "destinationstore", "preparedby", "dateprepared", "facilityorderno", "dateapproved", "approvedby"};
        List<Object[]> internalorders = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fields, "WHERE ordertype=:ordertype AND approved=:approved AND originstore=:originstore ORDER BY dateapproved", params, paramsValues);
        if (internalorders != null) {
            Map<String, Object> internalOrdersRow;
            for (Object[] internalorder : internalorders) {
                internalOrdersRow = new HashMap<>();
                internalOrdersRow.put("facilityorderid", internalorder[0]);
                internalOrdersRow.put("dateprepared", formatter.format((Date) internalorder[4]));
                internalOrdersRow.put("facilityorderno", internalorder[5]);

                String[] params8 = {"facilityunitid"};
                Object[] paramsValues8 = {internalorder[2]};
                String[] fields8 = {"facilityunitname", "shortname"};
                String where8 = "WHERE facilityunitid=:facilityunitid";
                List<Object[]> destinationstore = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields8, where8, params8, paramsValues8);
                internalOrdersRow.put("destinationstore", destinationstore.get(0)[0]);

                int internalorderitemscount = 0;
                String[] paramsc = {"facilityorderid", "approved"};
                Object[] paramsValuesc = {internalorder[0], Boolean.TRUE};
                String where = "WHERE facilityorderid=:facilityorderid AND approved=:approved";
                internalorderitemscount = genericClassService.fetchRecordCount(Facilityorderitems.class, where, paramsc, paramsValuesc);

                String[] params3 = {"personid"};
                Object[] paramsValues3 = {internalorder[3]};
                String[] fields3 = {"firstname", "lastname", "othernames"};
                List<Object[]> createdby = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields3, "WHERE personid=:personid", params3, paramsValues3);
                if (createdby != null) {
                    internalOrdersRow.put("createdby", createdby.get(0)[0] + " " + createdby.get(0)[1] + " " + createdby.get(0)[2]);
                }
                internalOrdersRow.put("itemscount", internalorderitemscount);
                internalOrdersRow.put("dateapproved", formatter.format((Date) internalorder[6]));
                String[] params4 = {"personid"};
                Object[] paramsValues4 = {internalorder[7]};
                String[] fields4 = {"firstname", "lastname", "othernames"};
                List<Object[]> approvedby = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields4, "WHERE personid=:personid", params4, paramsValues4);
                if (approvedby != null) {
                    internalOrdersRow.put("approvedby", approvedby.get(0)[0] + " " + approvedby.get(0)[1] + " " + approvedby.get(0)[2]);
                }
                facilityinternalordersList.add(internalOrdersRow);
            }
        }
        model.addAttribute("facilityinternalordersList", facilityinternalordersList);
        model.addAttribute("internalorders", facilityinternalordersList.size());
        return "inventoryAndSupplies/orders/approveOrConsolidateOrders/approveOrders/internalOrders/views/approvedOrders";
    }
    //
    @RequestMapping(value="/rejectedorders", method=RequestMethod.GET)
    public ModelAndView rejectedOrders(HttpServletRequest request){
        Map<String, Object> model = new HashMap<>();
        List<Map<String, Object>> rejectedOrders = new ArrayList<>();
        try {
            String[] params = {"ordertype", "approved", "originstore"};
            Object[] paramsValues = {"INTERNAL", Boolean.TRUE, request.getSession().getAttribute("sessionActiveLoginFacilityUnit")};
            String[] fields = {"facilityorderid", "originstore", "destinationstore", "preparedby", "dateprepared", "facilityorderno", "dateapproved", "approvedby", "status"};
            String where = "WHERE ordertype=:ordertype AND approved=:approved AND originstore=:originstore AND DATE_PART('YEAR', dateapproved) = DATE_PART('YEAR', NOW()) ORDER BY dateapproved";
            List<Object[]> internalOrders = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fields, where, params, paramsValues);
            if(internalOrders != null){
                Map<String, Object> rejectedOrder;
                for(Object[] internalOrder : internalOrders){
                    rejectedOrder = new HashMap<>();
                    params = new String [] { "facilityorderid" };
                    paramsValues = new Object [] { internalOrder[0] };
                    where = "WHERE facilityorderid=:facilityorderid AND approved=false";
                    int itemsCount = genericClassService.fetchRecordCount(Facilityorderitems.class, where, params, paramsValues);                    
                    if(itemsCount <= 0){
                        continue;
                    }
                    rejectedOrder.put("facilityorderid", internalOrder[0]);
                    rejectedOrder.put("dateprepared", formatter.format((Date) internalOrder[4]));
                    rejectedOrder.put("facilityorderno", internalOrder[5]);

                    String[] params8 = {"facilityunitid"};
                    Object[] paramsValues8 = {internalOrder[2]};
                    String[] fields8 = {"facilityunitname", "shortname"};
                    String where8 = "WHERE facilityunitid=:facilityunitid";
                    List<Object[]> destinationstore = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields8, where8, params8, paramsValues8);
                    rejectedOrder.put("destinationstore", destinationstore.get(0)[0]);                    

                    String[] params3 = {"personid"};
                    Object[] paramsValues3 = {internalOrder[3]};
                    String[] fields3 = {"firstname", "lastname", "othernames"};
                    List<Object[]> createdby = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields3, "WHERE personid=:personid", params3, paramsValues3);
                    if (createdby != null) {
                        rejectedOrder.put("createdby", createdby.get(0)[0] + " " + createdby.get(0)[1] + " " + createdby.get(0)[2]);
                    }
                    rejectedOrder.put("itemscount", itemsCount);
                    rejectedOrder.put("dateapproved", formatter.format((Date) internalOrder[6]));
                    String[] params4 = {"personid"};
                    Object[] paramsValues4 = {internalOrder[7]};
                    String[] fields4 = {"firstname", "lastname", "othernames"};
                    List<Object[]> approvedby = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields4, "WHERE personid=:personid", params4, paramsValues4);
                    if (approvedby != null) {
                        rejectedOrder.put("approvedby", approvedby.get(0)[0] + " " + approvedby.get(0)[1] + " " + approvedby.get(0)[2]);
                    }
                    rejectedOrder.put("status", internalOrder[8]);
                    rejectedOrders.add(rejectedOrder);
                }
            }
            model.put("rejectedorders", rejectedOrders);
            model.put("rejectedorderscount", rejectedOrders.size());
        } catch(Exception ex){
            System.out.println(ex);
        }
        return new ModelAndView("inventoryAndSupplies/orders/approveOrConsolidateOrders/approveOrders/internalOrders/views/rejectedOrders", model);
    }
    //
    @RequestMapping(value = "/filterfacilityunitapprovedorderitems.htm")
    public String filterfacilityunitapprovedorderitems(HttpServletRequest request, Model model) {
        String results = "";
        List<Map> facilityinternalordersList = new ArrayList<>();
        try {
            if (Integer.parseInt(request.getParameter("startdatesize")) != 0 && Integer.parseInt(request.getParameter("enddatesize")) != 0 && Integer.parseInt(request.getParameter("facilityunitsize")) != 0) {
                String[] params = {"ordertype", "approved", "destinationstore", "startdate", "enddate", "originstore"};
                Object[] paramsValues = {"INTERNAL", Boolean.TRUE, BigInteger.valueOf(Long.parseLong(request.getParameter("facilityunit"))), formatter.parse(request.getParameter("startdate").replaceAll("/", "-")), formatter.parse(request.getParameter("enddate").replaceAll("/", "-")), request.getSession().getAttribute("sessionActiveLoginFacilityUnit")};
                String[] fields = {"facilityorderid", "originstore", "destinationstore", "preparedby", "dateprepared", "facilityorderno", "dateapproved", "approvedby"};
                List<Object[]> internalorders = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fields, "WHERE ordertype=:ordertype AND approved=:approved AND destinationstore=:destinationstore AND dateapproved>=:startdate AND dateapproved<=:enddate AND originstore=:originstore ORDER BY dateapproved", params, paramsValues);
                if (internalorders != null) {
                    Map<String, Object> internalOrdersRow;
                    for (Object[] internalorder : internalorders) {
                        internalOrdersRow = new HashMap<>();
                        internalOrdersRow.put("facilityorderid", internalorder[0]);
                        internalOrdersRow.put("dateprepared", formatter.format((Date) internalorder[4]));
                        internalOrdersRow.put("facilityorderno", internalorder[5]);

                        String[] params8 = {"facilityunitid"};
                        Object[] paramsValues8 = {internalorder[2]};
                        String[] fields8 = {"facilityunitname", "shortname"};
                        String where8 = "WHERE facilityunitid=:facilityunitid";
                        List<Object[]> destinationstore = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields8, where8, params8, paramsValues8);
                        internalOrdersRow.put("destinationstore", destinationstore.get(0)[0]);

                        int internalorderitemscount = 0;
                        String[] paramsc = {"facilityorderid", "approved"};
                        Object[] paramsValuesc = {internalorder[0], Boolean.TRUE};
                        String where = "WHERE facilityorderid=:facilityorderid AND approved=:approved";
                        internalorderitemscount = genericClassService.fetchRecordCount(Facilityorderitems.class, where, paramsc, paramsValuesc);

                        String[] params3 = {"personid"};
                        Object[] paramsValues3 = {internalorder[3]};
                        String[] fields3 = {"firstname", "lastname", "othernames"};
                        List<Object[]> createdby = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields3, "WHERE personid=:personid", params3, paramsValues3);
                        if (createdby != null) {
                            internalOrdersRow.put("createdby", createdby.get(0)[0] + " " + createdby.get(0)[1] + " " + createdby.get(0)[2]);
                        }
                        internalOrdersRow.put("itemscount", internalorderitemscount);
                        internalOrdersRow.put("dateapproved", formatter.format((Date) internalorder[6]));
                        String[] params4 = {"personid"};
                        Object[] paramsValues4 = {internalorder[7]};
                        String[] fields4 = {"firstname", "lastname", "othernames"};
                        List<Object[]> approvedby = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields4, "WHERE personid=:personid", params4, paramsValues4);
                        if (approvedby != null) {
                            internalOrdersRow.put("approvedby", approvedby.get(0)[0] + " " + approvedby.get(0)[1] + " " + approvedby.get(0)[2]);
                        }
                        facilityinternalordersList.add(internalOrdersRow);
                    }
                }

            }
            if (Integer.parseInt(request.getParameter("startdatesize")) != 0 && Integer.parseInt(request.getParameter("enddatesize")) == 0 && Integer.parseInt(request.getParameter("facilityunitsize")) == 0) {

                String[] params = {"ordertype", "approved", "startdate", "originstore"};
                Object[] paramsValues = {"INTERNAL", Boolean.TRUE, formatter.parse(request.getParameter("startdate").replaceAll("/", "-")), request.getSession().getAttribute("sessionActiveLoginFacilityUnit")};
                String[] fields = {"facilityorderid", "originstore", "destinationstore", "preparedby", "dateprepared", "facilityorderno", "dateapproved", "approvedby"};
                List<Object[]> internalorders = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fields, "WHERE ordertype=:ordertype AND approved=:approved AND dateapproved>=:startdate AND originstore=:originstore ORDER BY dateapproved", params, paramsValues);
                if (internalorders != null) {
                    Map<String, Object> internalOrdersRow;
                    for (Object[] internalorder : internalorders) {
                        internalOrdersRow = new HashMap<>();
                        internalOrdersRow.put("facilityorderid", internalorder[0]);
                        internalOrdersRow.put("dateprepared", formatter.format((Date) internalorder[4]));
                        internalOrdersRow.put("facilityorderno", internalorder[5]);

                        String[] params8 = {"facilityunitid"};
                        Object[] paramsValues8 = {internalorder[2]};
                        String[] fields8 = {"facilityunitname", "shortname"};
                        String where8 = "WHERE facilityunitid=:facilityunitid";
                        List<Object[]> destinationstore = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields8, where8, params8, paramsValues8);
                        internalOrdersRow.put("destinationstore", destinationstore.get(0)[0]);

                        int internalorderitemscount = 0;
                        String[] paramsc = {"facilityorderid", "approved"};
                        Object[] paramsValuesc = {internalorder[0], Boolean.TRUE};
                        String where = "WHERE facilityorderid=:facilityorderid AND approved=:approved";
                        internalorderitemscount = genericClassService.fetchRecordCount(Facilityorderitems.class, where, paramsc, paramsValuesc);

                        String[] params3 = {"personid"};
                        Object[] paramsValues3 = {internalorder[3]};
                        String[] fields3 = {"firstname", "lastname", "othernames"};
                        List<Object[]> createdby = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields3, "WHERE personid=:personid", params3, paramsValues3);
                        if (createdby != null) {
                            internalOrdersRow.put("createdby", createdby.get(0)[0] + " " + createdby.get(0)[1] + " " + createdby.get(0)[2]);
                        }
                        internalOrdersRow.put("itemscount", internalorderitemscount);
                        internalOrdersRow.put("dateapproved", formatter.format((Date) internalorder[6]));
                        String[] params4 = {"personid"};
                        Object[] paramsValues4 = {internalorder[7]};
                        String[] fields4 = {"firstname", "lastname", "othernames"};
                        List<Object[]> approvedby = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields4, "WHERE personid=:personid", params4, paramsValues4);
                        if (approvedby != null) {
                            internalOrdersRow.put("approvedby", approvedby.get(0)[0] + " " + approvedby.get(0)[1] + " " + approvedby.get(0)[2]);
                        }
                        facilityinternalordersList.add(internalOrdersRow);

                    }
                }
            }
            if (Integer.parseInt(request.getParameter("startdatesize")) != 0 && Integer.parseInt(request.getParameter("enddatesize")) != 0 && Integer.parseInt(request.getParameter("facilityunitsize")) == 0) {

                String[] params = {"ordertype", "approved", "startdate", "enddate", "originstore"};
                Object[] paramsValues = {"INTERNAL", Boolean.TRUE, formatter.parse(request.getParameter("startdate").replaceAll("/", "-")), formatter.parse(request.getParameter("enddate").replaceAll("/", "-")), request.getSession().getAttribute("sessionActiveLoginFacilityUnit")};
                String[] fields = {"facilityorderid", "originstore", "destinationstore", "preparedby", "dateprepared", "facilityorderno", "dateapproved", "approvedby"};
                List<Object[]> internalorders = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fields, "WHERE ordertype=:ordertype AND approved=:approved AND dateapproved>=:startdate AND dateapproved<=:enddate AND originstore=:originstore ORDER BY dateapproved", params, paramsValues);
                if (internalorders != null) {
                    Map<String, Object> internalOrdersRow;
                    for (Object[] internalorder : internalorders) {
                        internalOrdersRow = new HashMap<>();
                        internalOrdersRow.put("facilityorderid", internalorder[0]);
                        internalOrdersRow.put("dateprepared", formatter.format((Date) internalorder[4]));
                        internalOrdersRow.put("facilityorderno", internalorder[5]);

                        String[] params8 = {"facilityunitid"};
                        Object[] paramsValues8 = {internalorder[2]};
                        String[] fields8 = {"facilityunitname", "shortname"};
                        String where8 = "WHERE facilityunitid=:facilityunitid";
                        List<Object[]> destinationstore = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields8, where8, params8, paramsValues8);
                        internalOrdersRow.put("destinationstore", destinationstore.get(0)[0]);

                        int internalorderitemscount = 0;
                        String[] paramsc = {"facilityorderid", "approved"};
                        Object[] paramsValuesc = {internalorder[0], Boolean.TRUE};
                        String where = "WHERE facilityorderid=:facilityorderid AND approved=:approved";
                        internalorderitemscount = genericClassService.fetchRecordCount(Facilityorderitems.class, where, paramsc, paramsValuesc);

                        String[] params3 = {"personid"};
                        Object[] paramsValues3 = {internalorder[3]};
                        String[] fields3 = {"firstname", "lastname", "othernames"};
                        List<Object[]> createdby = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields3, "WHERE personid=:personid", params3, paramsValues3);
                        if (createdby != null) {
                            internalOrdersRow.put("createdby", createdby.get(0)[0] + " " + createdby.get(0)[1] + " " + createdby.get(0)[2]);
                        }
                        internalOrdersRow.put("itemscount", internalorderitemscount);
                        internalOrdersRow.put("dateapproved", formatter.format((Date) internalorder[6]));
                        String[] params4 = {"personid"};
                        Object[] paramsValues4 = {internalorder[7]};
                        String[] fields4 = {"firstname", "lastname", "othernames"};
                        List<Object[]> approvedby = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields4, "WHERE personid=:personid", params4, paramsValues4);
                        if (approvedby != null) {
                            internalOrdersRow.put("approvedby", approvedby.get(0)[0] + " " + approvedby.get(0)[1] + " " + approvedby.get(0)[2]);
                        }
                        facilityinternalordersList.add(internalOrdersRow);
                    }
                }
            }

            if (Integer.parseInt(request.getParameter("startdatesize")) == 0 && Integer.parseInt(request.getParameter("enddatesize")) == 0 && Integer.parseInt(request.getParameter("facilityunitsize")) != 0) {
                String[] params = {"ordertype", "approved", "destinationstore", "originstore"};
                Object[] paramsValues = {"INTERNAL", Boolean.TRUE, BigInteger.valueOf(Long.parseLong(request.getParameter("facilityunit"))), request.getSession().getAttribute("sessionActiveLoginFacilityUnit")};
                String[] fields = {"facilityorderid", "originstore", "destinationstore", "preparedby", "dateprepared", "facilityorderno", "dateapproved", "approvedby"};
                List<Object[]> internalorders = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fields, "WHERE ordertype=:ordertype AND approved=:approved AND destinationstore=:destinationstore AND originstore=:originstore ORDER BY dateapproved", params, paramsValues);
                if (internalorders != null) {
                    Map<String, Object> internalOrdersRow;
                    for (Object[] internalorder : internalorders) {
                        internalOrdersRow = new HashMap<>();
                        internalOrdersRow.put("facilityorderid", internalorder[0]);
                        internalOrdersRow.put("dateprepared", formatter.format((Date) internalorder[4]));
                        internalOrdersRow.put("facilityorderno", internalorder[5]);

                        String[] params8 = {"facilityunitid"};
                        Object[] paramsValues8 = {internalorder[2]};
                        String[] fields8 = {"facilityunitname", "shortname"};
                        String where8 = "WHERE facilityunitid=:facilityunitid";
                        List<Object[]> destinationstore = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields8, where8, params8, paramsValues8);
                        internalOrdersRow.put("destinationstore", destinationstore.get(0)[0]);

                        int internalorderitemscount = 0;
                        String[] paramsc = {"facilityorderid", "approved"};
                        Object[] paramsValuesc = {internalorder[0], Boolean.TRUE};
                        String where = "WHERE facilityorderid=:facilityorderid AND approved=:approved";
                        internalorderitemscount = genericClassService.fetchRecordCount(Facilityorderitems.class, where, paramsc, paramsValuesc);

                        String[] params3 = {"personid"};
                        Object[] paramsValues3 = {internalorder[3]};
                        String[] fields3 = {"firstname", "lastname", "othernames"};
                        List<Object[]> createdby = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields3, "WHERE personid=:personid", params3, paramsValues3);
                        if (createdby != null) {
                            internalOrdersRow.put("createdby", createdby.get(0)[0] + " " + createdby.get(0)[1] + " " + createdby.get(0)[2]);
                        }
                        internalOrdersRow.put("itemscount", internalorderitemscount);
                        internalOrdersRow.put("dateapproved", formatter.format((Date) internalorder[6]));
                        String[] params4 = {"personid"};
                        Object[] paramsValues4 = {internalorder[7]};
                        String[] fields4 = {"firstname", "lastname", "othernames"};
                        List<Object[]> approvedby = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields4, "WHERE personid=:personid", params4, paramsValues4);
                        if (approvedby != null) {
                            internalOrdersRow.put("approvedby", approvedby.get(0)[0] + " " + approvedby.get(0)[1] + " " + approvedby.get(0)[2]);
                        }
                        facilityinternalordersList.add(internalOrdersRow);
                    }
                }

            }
            if (Integer.parseInt(request.getParameter("startdatesize")) == 0 && Integer.parseInt(request.getParameter("enddatesize")) != 0 && Integer.parseInt(request.getParameter("facilityunitsize")) != 0) {
                String[] params = {"ordertype", "approved", "originstore", "destinationstore", "enddate"};
                Object[] paramsValues = {"INTERNAL", Boolean.TRUE, request.getSession().getAttribute("sessionActiveLoginFacilityUnit"), BigInteger.valueOf(Long.parseLong(request.getParameter("facilityunit"))), formatter.parse(request.getParameter("enddate").replaceAll("/", "-"))};
                String[] fields = {"facilityorderid", "originstore", "destinationstore", "preparedby", "dateprepared", "facilityorderno", "dateapproved", "approvedby"};
                List<Object[]> internalorders = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fields, "WHERE ordertype=:ordertype AND approved=:approved AND originstore=:originstore AND destinationstore=:destinationstore AND dateapproved<=:enddate ORDER BY dateapproved", params, paramsValues);
                if (internalorders != null) {
                    Map<String, Object> internalOrdersRow;
                    for (Object[] internalorder : internalorders) {
                        internalOrdersRow = new HashMap<>();
                        internalOrdersRow.put("facilityorderid", internalorder[0]);
                        internalOrdersRow.put("dateprepared", formatter.format((Date) internalorder[4]));
                        internalOrdersRow.put("facilityorderno", internalorder[5]);

                        String[] params8 = {"facilityunitid"};
                        Object[] paramsValues8 = {internalorder[2]};
                        String[] fields8 = {"facilityunitname", "shortname"};
                        String where8 = "WHERE facilityunitid=:facilityunitid";
                        List<Object[]> destinationstore = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields8, where8, params8, paramsValues8);
                        internalOrdersRow.put("destinationstore", destinationstore.get(0)[0]);

                        int internalorderitemscount = 0;
                        String[] paramsc = {"facilityorderid", "approved"};
                        Object[] paramsValuesc = {internalorder[0], Boolean.TRUE};
                        String where = "WHERE facilityorderid=:facilityorderid AND approved=:approved";
                        internalorderitemscount = genericClassService.fetchRecordCount(Facilityorderitems.class, where, paramsc, paramsValuesc);

                        String[] params3 = {"personid"};
                        Object[] paramsValues3 = {internalorder[3]};
                        String[] fields3 = {"firstname", "lastname", "othernames"};
                        List<Object[]> createdby = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields3, "WHERE personid=:personid", params3, paramsValues3);
                        if (createdby != null) {
                            internalOrdersRow.put("createdby", createdby.get(0)[0] + " " + createdby.get(0)[1] + " " + createdby.get(0)[2]);
                        }
                        internalOrdersRow.put("itemscount", internalorderitemscount);
                        internalOrdersRow.put("dateapproved", formatter.format((Date) internalorder[6]));
                        String[] params4 = {"personid"};
                        Object[] paramsValues4 = {internalorder[7]};
                        String[] fields4 = {"firstname", "lastname", "othernames"};
                        List<Object[]> approvedby = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields4, "WHERE personid=:personid", params4, paramsValues4);
                        if (approvedby != null) {
                            internalOrdersRow.put("approvedby", approvedby.get(0)[0] + " " + approvedby.get(0)[1] + " " + approvedby.get(0)[2]);
                        }
                        facilityinternalordersList.add(internalOrdersRow);
                    }
                }
            }
            if (Integer.parseInt(request.getParameter("startdatesize")) == 0 && Integer.parseInt(request.getParameter("enddatesize")) != 0 && Integer.parseInt(request.getParameter("facilityunitsize")) == 0) {

                String[] params = {"ordertype", "approved", "enddate", "originstore"};
                Object[] paramsValues = {"INTERNAL", Boolean.TRUE, formatter.parse(request.getParameter("enddate").replaceAll("/", "-")), request.getSession().getAttribute("sessionActiveLoginFacilityUnit")};
                String[] fields = {"facilityorderid", "originstore", "destinationstore", "preparedby", "dateprepared", "facilityorderno", "dateapproved", "approvedby"};
                List<Object[]> internalorders = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fields, "WHERE ordertype=:ordertype AND approved=:approved AND dateapproved<=:enddate AND originstore=:originstore ORDER BY dateapproved", params, paramsValues);
                if (internalorders != null) {
                    Map<String, Object> internalOrdersRow;
                    for (Object[] internalorder : internalorders) {
                        internalOrdersRow = new HashMap<>();
                        internalOrdersRow.put("facilityorderid", internalorder[0]);
                        internalOrdersRow.put("dateprepared", formatter.format((Date) internalorder[4]));
                        internalOrdersRow.put("facilityorderno", internalorder[5]);

                        String[] params8 = {"facilityunitid"};
                        Object[] paramsValues8 = {internalorder[2]};
                        String[] fields8 = {"facilityunitname", "shortname"};
                        String where8 = "WHERE facilityunitid=:facilityunitid";
                        List<Object[]> destinationstore = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields8, where8, params8, paramsValues8);
                        internalOrdersRow.put("destinationstore", destinationstore.get(0)[0]);

                        int internalorderitemscount = 0;
                        String[] paramsc = {"facilityorderid", "approved"};
                        Object[] paramsValuesc = {internalorder[0], Boolean.TRUE};
                        String where = "WHERE facilityorderid=:facilityorderid AND approved=:approved";
                        internalorderitemscount = genericClassService.fetchRecordCount(Facilityorderitems.class, where, paramsc, paramsValuesc);

                        String[] params3 = {"personid"};
                        Object[] paramsValues3 = {internalorder[3]};
                        String[] fields3 = {"firstname", "lastname", "othernames"};
                        List<Object[]> createdby = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields3, "WHERE personid=:personid", params3, paramsValues3);
                        if (createdby != null) {
                            internalOrdersRow.put("createdby", createdby.get(0)[0] + " " + createdby.get(0)[1] + " " + createdby.get(0)[2]);
                        }
                        internalOrdersRow.put("itemscount", internalorderitemscount);
                        internalOrdersRow.put("dateapproved", formatter.format((Date) internalorder[6]));
                        String[] params4 = {"personid"};
                        Object[] paramsValues4 = {internalorder[7]};
                        String[] fields4 = {"firstname", "lastname", "othernames"};
                        List<Object[]> approvedby = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields4, "WHERE personid=:personid", params4, paramsValues4);
                        if (approvedby != null) {
                            internalOrdersRow.put("approvedby", approvedby.get(0)[0] + " " + approvedby.get(0)[1] + " " + approvedby.get(0)[2]);
                        }
                        facilityinternalordersList.add(internalOrdersRow);
                    }
                }
            }
            if (Integer.parseInt(request.getParameter("startdatesize")) != 0 && Integer.parseInt(request.getParameter("enddatesize")) == 0 && Integer.parseInt(request.getParameter("facilityunitsize")) != 0) {
                String[] params = {"ordertype", "approved", "originstore", "destinationstore", "startdate"};
                Object[] paramsValues = {"INTERNAL", Boolean.TRUE, request.getSession().getAttribute("sessionActiveLoginFacilityUnit"), BigInteger.valueOf(Long.parseLong(request.getParameter("facilityunit"))), formatter.parse(request.getParameter("startdate").replaceAll("/", "-"))};
                String[] fields = {"facilityorderid", "originstore", "destinationstore", "preparedby", "dateprepared", "facilityorderno", "dateapproved", "approvedby"};
                List<Object[]> internalorders = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fields, "WHERE ordertype=:ordertype AND approved=:approved AND originstore=:originstore AND destinationstore=:destinationstore AND dateapproved>=:startdate ORDER BY dateapproved", params, paramsValues);
                if (internalorders != null) {
                    Map<String, Object> internalOrdersRow;
                    for (Object[] internalorder : internalorders) {
                        internalOrdersRow = new HashMap<>();
                        internalOrdersRow.put("facilityorderid", internalorder[0]);
                        internalOrdersRow.put("dateprepared", formatter.format((Date) internalorder[4]));
                        internalOrdersRow.put("facilityorderno", internalorder[5]);

                        String[] params8 = {"facilityunitid"};
                        Object[] paramsValues8 = {internalorder[2]};
                        String[] fields8 = {"facilityunitname", "shortname"};
                        String where8 = "WHERE facilityunitid=:facilityunitid";
                        List<Object[]> destinationstore = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields8, where8, params8, paramsValues8);
                        internalOrdersRow.put("destinationstore", destinationstore.get(0)[0]);

                        int internalorderitemscount = 0;
                        String[] paramsc = {"facilityorderid", "approved"};
                        Object[] paramsValuesc = {internalorder[0], Boolean.TRUE};
                        String where = "WHERE facilityorderid=:facilityorderid AND approved=:approved";
                        internalorderitemscount = genericClassService.fetchRecordCount(Facilityorderitems.class, where, paramsc, paramsValuesc);

                        String[] params3 = {"personid"};
                        Object[] paramsValues3 = {internalorder[3]};
                        String[] fields3 = {"firstname", "lastname", "othernames"};
                        List<Object[]> createdby = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields3, "WHERE personid=:personid", params3, paramsValues3);
                        if (createdby != null) {
                            internalOrdersRow.put("createdby", createdby.get(0)[0] + " " + createdby.get(0)[1] + " " + createdby.get(0)[2]);
                        }
                        internalOrdersRow.put("itemscount", internalorderitemscount);
                        internalOrdersRow.put("dateapproved", formatter.format((Date) internalorder[6]));
                        String[] params4 = {"personid"};
                        Object[] paramsValues4 = {internalorder[7]};
                        String[] fields4 = {"firstname", "lastname", "othernames"};
                        List<Object[]> approvedby = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields4, "WHERE personid=:personid", params4, paramsValues4);
                        if (approvedby != null) {
                            internalOrdersRow.put("approvedby", approvedby.get(0)[0] + " " + approvedby.get(0)[1] + " " + approvedby.get(0)[2]);
                        }
                        facilityinternalordersList.add(internalOrdersRow);
                    }
                }
            }

        } catch (Exception e) {
            System.out.println(":::::::::::::::::::::::::::::::Error::" + e);
        }

        model.addAttribute("facilityinternalordersList", facilityinternalordersList);
        model.addAttribute("internalorders", facilityinternalordersList.size());
        return "inventoryAndSupplies/orders/approveOrConsolidateOrders/approveOrders/internalOrders/views/approvedOrders";
    }

    @RequestMapping(value = "/filterfacilityunitapprovedorders.htm", method = RequestMethod.GET)
    public String filterfacilityunitapprovedorders(Model model, HttpServletRequest request) {
        List<Map> facilityunitsList = new ArrayList<>();

        String[] params = {"facilityid", "active"};
        Object[] paramsValues = {request.getSession().getAttribute("sessionActiveLoginFacility"), Boolean.TRUE};
        String[] fields = {"facilityunitid", "facilityunitname"};
        List<Object[]> facilityunits = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields, "WHERE facilityid=:facilityid AND active=:active", params, paramsValues);
        if (facilityunits != null) {
            Map<String, Object> facilityunitsRow;
            for (Object[] facilityunit : facilityunits) {
                facilityunitsRow = new HashMap<>();
                if (((Long) facilityunit[0]).intValue() != (int) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")) {
                    facilityunitsRow.put("facilityunitid", facilityunit[0]);
                    facilityunitsRow.put("facilityunitname", facilityunit[1]);
                    facilityunitsList.add(facilityunitsRow);
                }
            }
        }
        model.addAttribute("facilityunitsList", facilityunitsList);
        model.addAttribute("serverdate", formatterwithtime.format(serverDate));
        return "inventoryAndSupplies/approveFacilityOrders/internalOrders/forms/filterOrdersBy";
    }
}
