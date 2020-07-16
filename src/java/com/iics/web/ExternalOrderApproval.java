/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.domain.Facility;
import com.iics.domain.Facilityunit;
import com.iics.domain.Person;
import com.iics.service.GenericClassService;
import com.iics.store.Cellitems;
import com.iics.store.Facilityorder;
import com.iics.store.Facilityorderitems;
import com.iics.store.Item;
import com.iics.store.Consolidatedorders;
import com.iics.store.Externalfacilityorders;
import com.iics.store.Supplier;
import java.math.BigInteger;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
@RequestMapping("/externalordersapproval")
public class ExternalOrderApproval {

    DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat format = new SimpleDateFormat("dd-MM-yyyy");
    @Autowired
    GenericClassService genericClassService;

    @RequestMapping(value = "/externalorderstables", method = RequestMethod.GET)
    public String ExternalOrdersTables(HttpServletRequest request, Model model) {

        List<Map> externalOrders = new ArrayList<>();

        int internalorders = 0;
        String[] params1 = {"originstore", "ordertype", "submitted"};
        Object[] paramsValues1 = {Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))), "INTERNAL", "SUBMITTED"};
        String where1 = "WHERE originstore=:originstore AND ordertype=:ordertype AND status=:submitted";
        internalorders = genericClassService.fetchRecordCount(Facilityorder.class, where1, params1, paramsValues1);
        model.addAttribute("internalorders", internalorders);

        int externalorders = 0;
        String[] params2 = {"originstore", "ordertype", "submitted"};
        Object[] paramsValues2 = {Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))), "EXTERNAL", "SUBMITTED"};
        String where2 = "WHERE originstore=:originstore AND ordertype=:ordertype AND status=:submitted";
        externalorders = genericClassService.fetchRecordCount(Facilityorder.class, where2, params2, paramsValues2);
        model.addAttribute("externalorders", externalorders);

        String[] params4 = {"originstore", "ordertype", "status"};
        Object[] paramsValues4 = {Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))), "EXTERNAL", "SUBMITTED"};
        String where4 = "WHERE originstore=:originstore AND ordertype=:ordertype AND status=:status";
        String[] fields4 = {"facilityorderid", "originstore", "preparedby", "externalfacilityordersid","facilityorderno"};
        List<Object[]> facilityunitexternalorders = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fields4, where4, params4, paramsValues4);
        if (facilityunitexternalorders != null) {
            Map<String, Object> externalorderRow;
            for (Object[] facilityunitexternalorder : facilityunitexternalorders) {
                externalorderRow = new HashMap<>();

                externalorderRow.put("facilityorderid", facilityunitexternalorder[0]);
                externalorderRow.put("facilityorderno", facilityunitexternalorder[4]);

                String[] params = {"facilityunitid"};
                Object[] paramsValues = {(BigInteger) facilityunitexternalorder[1]};
                String where = "WHERE facilityunitid=:facilityunitid";
                String[] fields = {"facilityunitname", "shortname"};
                List<Object[]> originunit = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields, where, params, paramsValues);
                if (originunit != null) {
                    externalorderRow.put("destinationfacilityunit", originunit.get(0)[0]);
                    externalorderRow.put("shortname", originunit.get(0)[1]);
                }

                String[] params8 = {"personid"};
                Object[] paramsValues8 = {(BigInteger) facilityunitexternalorder[2]};
                String where8 = "WHERE personid=:personid";
                String[] fields8 = {"firstname", "lastname"};
                List<Object[]> personname = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields8, where8, params8, paramsValues8);
                if (personname != null) {
                    externalorderRow.put("personname", personname.get(0)[0] + " " + personname.get(0)[1]);
                }

                String[] params6 = {"externalfacilityordersid"};
                Object[] paramsValues6 = {(Integer) facilityunitexternalorder[3]};
                String where6 = "WHERE externalfacilityordersid=:externalfacilityordersid";
                String[] fields6 = {"supplierid", "neworderno"};
                List<Object[]> externalfacorder = (List<Object[]>) genericClassService.fetchRecord(Externalfacilityorders.class, fields6, where6, params6, paramsValues6);
                if (externalfacorder != null) {
                    for (Object[] ext : externalfacorder) {

                        externalorderRow.put("neworderno", ext[1]);

                        String[] paramsa = {"supplierid"};
                        Object[] paramsValuesa = {(Long) ext[0]};
                        String wherea = "WHERE supplierid=:supplierid";
                        String[] fieldsa = {"supplierid", "suppliername"};
                        List<Object[]> supplier = (List<Object[]>) genericClassService.fetchRecord(Supplier.class, fieldsa, wherea, paramsa, paramsValuesa);
                        if (supplier != null) {
                            externalorderRow.put("supplierid", supplier.get(0)[0]);
                            externalorderRow.put("suppliername", supplier.get(0)[1]);
                        }

                    }
                }

                int externalordersitemscount = 0;
                String[] params9 = {"facilityorderid", "approved"};
                Object[] paramsValues9 = {(Long) facilityunitexternalorder[0], Boolean.FALSE};
                String where9 = "WHERE facilityorderid=:facilityorderid AND approved=:approved";
                externalordersitemscount = genericClassService.fetchRecordCount(Facilityorderitems.class, where9, params9, paramsValues9);

                externalorderRow.put("externalordersitemscount", externalordersitemscount);
                externalorderRow.put("currentDate", formatter.format(new Date()));
                externalOrders.add(externalorderRow);
            }
        }
        model.addAttribute("externalOrders", externalOrders);

        return "inventoryAndSupplies/orders/approveOrConsolidateOrders/approveOrders/externalOrders/approveExtOrders/views/unapprovedexternalorderstable";

    }

    @RequestMapping(value = "/viewExternalOrderItems", method = RequestMethod.GET)
    public String viewExternalOrderItems(HttpServletRequest request, Model model, @ModelAttribute("facilityorderid") Long facilityorderid) {
        List<Map> externalItems = new ArrayList<Map>();

        String[] paramszr = {"facilityorderid", "approved"};
        Object[] paramsValueszr = {facilityorderid, Boolean.FALSE};
        String[] fieldszr = {"itemid.itemid","qtyordered"};
        String wherezr = "WHERE facilityorderid=:facilityorderid AND approved=:approved";
        List<Object[]> extOrderedItems = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fieldszr, wherezr, paramszr, paramsValueszr);
        if (extOrderedItems != null) {
            Map<String, Object> items;
            for (Object[] ext : extOrderedItems) {
                items = new HashMap<>();
                items.put("qtyordered", ext[1]);
                String[] params = {"itemid"};
                Object[] paramsValues = {(Long) ext[0]};
                String where = "WHERE itemid=:itemid";
                String[] fields = {"genericname", "itemstrength"};
                List<Object[]> destinationunit = (List<Object[]>) genericClassService.fetchRecord(Item.class, fields, where, params, paramsValues);
                if (destinationunit != null) {
                    items.put("genericname", destinationunit.get(0)[0]);
                    items.put("itemstrength", destinationunit.get(0)[1]);

                    externalItems.add(items);
                }

            }
            model.addAttribute("externalItems", externalItems);
        }

        return "inventoryAndSupplies/orders/approveOrConsolidateOrders/approveOrders/externalOrders/approveExtOrders/views/externalorderitems";

    }

    @RequestMapping(value = "/verifyexternalfacilityunitorders", method = RequestMethod.GET)
    public String verifyexternalfacilityunitorders(HttpServletRequest request, Model model, @ModelAttribute("facilityorderid") Long facilityorderid) {
        List<Map> itemsFound = new ArrayList<>();
        String externalOrderItemsSize = "";
        model.addAttribute("facilityorderid", facilityorderid);
        String[] params4 = {"facilityorderid", "approved"};
        Object[] paramsValues4 = {Long.parseLong(request.getParameter("facilityorderid")), Boolean.FALSE};
        String where4 = "WHERE facilityorderid=:facilityorderid AND approved=:approved";
        String[] fields4 = {"facilityorderitemsid", "qtyordered", "itemid", "facilityorderid"};
        List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fields4, where4, params4, paramsValues4);
        if (items != null) {
            Map<String, Object> internalordersitemsRow;
            for (Object[] item : items) {
                internalordersitemsRow = new HashMap<>();
                String[] params7 = {"itemid"};
                Object[] paramsValues7 = {(Long) item[2]};
                String[] fields7 = {"genericname", "packsize", "unitcost", "itemstrength"};
                List<Object[]> itemdetalis = (List<Object[]>) genericClassService.fetchRecord(Item.class, fields7, "WHERE itemid=:itemid", params7, paramsValues7);
                if (itemdetalis != null) {

                    internalordersitemsRow.put("genericname", itemdetalis.get(0)[0]);
                    internalordersitemsRow.put("packsize", itemdetalis.get(0)[1]);
                    internalordersitemsRow.put("itemstrength", itemdetalis.get(0)[3]);
                    internalordersitemsRow.put("facilityorderitemsid", item[0]);
                    internalordersitemsRow.put("qtyordered", String.format("%,d", (Long) item[1]));
                    internalordersitemsRow.put("qtyorderednocommas", (Long) item[1]);
                    internalordersitemsRow.put("qtyorderednocommas", item[1]);
                    internalordersitemsRow.put("itemid", item[2]);
                    internalordersitemsRow.put("facilityorderid", item[3]);
                    itemsFound.add(internalordersitemsRow);
                }
            }
        }
        model.addAttribute("externalOrderItems", itemsFound);
        model.addAttribute("externalOrderItemsSize", itemsFound.size());

        try {
            externalOrderItemsSize = new ObjectMapper().writeValueAsString(itemsFound.size());
        } catch (JsonProcessingException ex) {
            Logger.getLogger(ExternalOrderApproval.class.getName()).log(Level.SEVERE, null, ex);
        }

        model.addAttribute("externalOrderItemsSizes", externalOrderItemsSize);

        return "inventoryAndSupplies/orders/approveOrConsolidateOrders/approveOrders/externalOrders/approveExtOrders/views/approveexternalorderitems";

    }

    @RequestMapping(value = "/transferOrderToSupplier", method = RequestMethod.GET)
    public String TransferOrderToSupplier(HttpServletRequest request, Model model) {

        return "inventoryAndSupplies/orders/approveOrConsolidateOrders/approveOrders/externalOrders/transferExtOrders/views/transferredorderitems";

    }

    @RequestMapping(value = "/saveNewOrderValue")
    public @ResponseBody
    String saveNewOrderValue(HttpServletRequest request, Model model, @ModelAttribute("newordervalue") String qtyapproved, @ModelAttribute("facilityorderitemsid") BigInteger facilityorderitemsid) {
        System.out.println("---------------------------meeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
        if (request.getSession().getAttribute("sessionActiveLoginFacility") != null) {
            Object updatedbynamed = request.getSession().getAttribute("person_id");
            try {
                String[] columnsr = {"qtyapproved"};
                Object[] columnValuesr = {Long.parseLong(qtyapproved)};
                String pkr = "facilityorderitemsid";
                Object pkValuer = facilityorderitemsid;
                genericClassService.updateRecordSQLSchemaStyle(Facilityorderitems.class, columnsr, columnValuesr, pkr, pkValuer, "store");

                return "updated";
            } catch (Exception e) {
                System.out.println(e);
                return "failed";
            }
        }
        return "refresh";
    }

    @RequestMapping(value = "/approveorunapproveextfacilityunitorderitems.htm")
    public @ResponseBody
    String approveorunapproveextfacilityunitorderitems(HttpServletRequest request
    ) {
        String results = "";

        String[] params4 = {};
        Object[] paramsValues4 = {};
        String[] fields4 = {"isactive", "orderstatus"};
        String where4 = "";
        List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Externalfacilityorders.class, fields4, where4, params4, paramsValues4);
        if (items != null) {
            Boolean statusx = (Boolean) items.get(0)[0];
            if (statusx == true) {
                if ("approve".equals(request.getParameter("type"))) {
                    String[] columns = {"approved", "approvedby", "dateapproved"};
                    Object[] columnValues = {Boolean.TRUE, (Long) request.getSession().getAttribute("person_id"), new Date()};
                    String pk = "facilityorderitemsid";
                    Object pkValue = Long.parseLong(request.getParameter("facilityorderitemsid"));
                    int result = genericClassService.updateRecordSQLSchemaStyle(Facilityorderitems.class, columns, columnValues, pk, pkValue, "store");
                    if (result != 0) {
                        results = "success";
                    }

                } else {
                    String[] columns = {"approved", "approvedby", "dateapproved"};
                    Object[] columnValues = {Boolean.FALSE, (Long) request.getSession().getAttribute("person_id"), new Date()};
                    String pk = "facilityorderitemsid";
                    Object pkValue = Long.parseLong(request.getParameter("facilityorderitemsid"));
                    int result = genericClassService.updateRecordSQLSchemaStyle(Facilityorderitems.class, columns, columnValues, pk, pkValue, "store");
                    if (result != 0) {
                        results = "success";
                    }
                }
                results = "success";
            } else {
                String red = "red";
                results = "<font color=" + red + "><b>Facility Order NOT Active, Cannot Add Item To The Order.</b></font>";
            }

        }

        return results;
    }

    @RequestMapping(value = "/approveorunapproveextfacilityunitorderitem.htm")
    public @ResponseBody
    String approveorunapproveextfacilityunitorderitem(HttpServletRequest request) {
        String results = "";

        String[] params4 = {};
        Object[] paramsValues4 = {};
        String[] fields4 = {"isactive", "orderstatus"};
        String where4 = "";
        List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Externalfacilityorders.class, fields4, where4, params4, paramsValues4);
        if (items != null) {
            Boolean statusx = (Boolean) items.get(0)[0];
            if (statusx == true) {
                if ("approve".equals(request.getParameter("type"))) {
                    String[] columns = {"approved", "approvedby", "dateapproved"};
                    Object[] columnValues = {Boolean.TRUE, (Long) request.getSession().getAttribute("person_id"), new Date()};
                    String pk = "facilityorderitemsid";
                    Object pkValue = Long.parseLong(request.getParameter("facilityorderitemsid"));
                    int result = genericClassService.updateRecordSQLSchemaStyle(Facilityorderitems.class, columns, columnValues, pk, pkValue, "store");
                    if (result != 0) {
                        results = "success";
                    }

                    String[] columnse = {"status", "approved"};
                    Object[] columnValuese = {"SENT", Boolean.FALSE};
                    String pke = "facilityorderid";
                    Object pkValuee = Long.parseLong(request.getParameter("facilityorderid"));
                    int resulte = genericClassService.updateRecordSQLSchemaStyle(Facilityorder.class, columnse, columnValuese, pke, pkValuee, "store");
                    if (resulte != 0) {
                        results = "success";
                    }

                } else {
                    String[] columns = {"approved", "approvedby", "dateapproved"};
                    Object[] columnValues = {Boolean.FALSE, (Long) request.getSession().getAttribute("person_id"), new Date()};
                    String pk = "facilityorderitemsid";
                    Object pkValue = Long.parseLong(request.getParameter("facilityorderitemsid"));
                    int result = genericClassService.updateRecordSQLSchemaStyle(Facilityorderitems.class, columns, columnValues, pk, pkValue, "store");
                    if (result != 0) {
                        results = "success";
                    }

                    String[] columnsf = {"status", "approved"};
                    Object[] columnValuesf = {"SUBMITTED", Boolean.FALSE};
                    String pkf = "facilityorderid";
                    Object pkValuef = Long.parseLong(request.getParameter("facilityorderid"));
                    int resultf = genericClassService.updateRecordSQLSchemaStyle(Facilityorder.class, columnsf, columnValuesf, pkf, pkValuef, "store");
                    if (resultf != 0) {
                        results = "success";
                    }
                }
                results = "success";
            } else {
                String red = "red";
                results = "<font color=" + red + "><b>Facility Order NOT Active, Cannot Add Item To The Order.</b></font>";
            }

        }

        return results;
    }

    private String generateFacilityOrderNumbers(String shortname) {
        String name = shortname + "/";
        SimpleDateFormat f = new SimpleDateFormat("MM");
        String pattern = name + f.format(new Date()) + "/%";
        String facilityNumber = "";

        String[] params = {"staffno"};
        Object[] paramsValues = {pattern};
        String[] fields = {"staffno"};
        String where = "WHERE staffno LIKE :staffno ORDER BY staffno DESC LIMIT 1";
        List<String> lastFacilityOrderno = (List<String>) genericClassService.fetchRecord(Facility.class, fields, where, params, paramsValues);
        if (lastFacilityOrderno == null) {
            facilityNumber = name + f.format(new Date()) + "/0001";
            return facilityNumber;
        } else {
            try {
                int lastNo = Integer.parseInt(lastFacilityOrderno.get(0).split("\\/")[2]);
                String newNo = String.valueOf(lastNo + 1);
                switch (newNo.length()) {
                    case 1:
                        facilityNumber = name + f.format(new Date()) + "/00" + newNo;
                        break;
                    case 2:
                        facilityNumber = name + f.format(new Date()) + "/0" + newNo;
                        break;
                    default:
                        facilityNumber = name + f.format(new Date()) + "/" + newNo;
                        break;
                }
            } catch (Exception e) {
                System.out.println(e);
            }
        }
        return facilityNumber;
    }

    @RequestMapping(value = "/viewExternalSupplierDetails", method = RequestMethod.GET)
    public String viewExternalSupplierDetails(HttpServletRequest request, Model model, @ModelAttribute("supplierid") Long supplierid) {

        String[] paramszr = {"supplierid", "active"};
        Object[] paramsValueszr = {supplierid, Boolean.TRUE};
        String[] fieldszr = {"supplierid", "suppliername", "suppliercode", "officetel", "emailaddress", "fax", "postaladdress"};
        String wherezr = "WHERE supplierid=:supplierid AND active=:active";

        List<Object[]> extOrderedsuppliers = (List<Object[]>) genericClassService.fetchRecord(Supplier.class, fieldszr, wherezr, paramszr, paramsValueszr);
        if (extOrderedsuppliers != null) {

            model.addAttribute("supplierid", extOrderedsuppliers.get(0)[0]);
            model.addAttribute("suppliername", extOrderedsuppliers.get(0)[1]);
            model.addAttribute("suppliercode", extOrderedsuppliers.get(0)[2]);
            model.addAttribute("officetel", extOrderedsuppliers.get(0)[3]);
            model.addAttribute("emailaddress", extOrderedsuppliers.get(0)[4]);
            model.addAttribute("fax", extOrderedsuppliers.get(0)[5]);
            model.addAttribute("postaladdress", extOrderedsuppliers.get(0)[6]);


        }
        

        return "inventoryAndSupplies/orders/approveOrConsolidateOrders/approveOrders/externalOrders/approveExtOrders/views/externalorderssupplier";

    }

}
