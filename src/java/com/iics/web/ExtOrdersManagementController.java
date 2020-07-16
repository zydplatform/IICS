/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import com.iics.domain.*;
import com.iics.service.GenericClassService;
import com.iics.store.Externalfacilityorders;
import com.iics.store.Facilityorder;
import com.iics.store.Facilityorderitems;
import com.iics.store.Item;
import com.iics.store.Itempackage;
import com.iics.store.Itemcategories;
import com.iics.store.Orderperiod;
import com.iics.store.Supplier;
import com.iics.store.Supplieritemcategories;
import java.math.BigInteger;
import java.security.Principal;
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
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author samuelwam <samuelwam@gmail.com>
 */
@Controller
@RequestMapping("/extordersmanagement")
public class ExtOrdersManagementController {

    public static String sys_info = null;
    protected static Log logger = LogFactory.getLog("controller");
    DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    @Autowired
    GenericClassService genericClassService;
    private SimpleDateFormat formatterwithtime = new SimpleDateFormat("yyyy-MM-dd hh:mm aa");
    private Date serverDate = new Date();
    /**
     *
     * @param principal
     * @return
     */
    @RequestMapping("/extOrderProcessing.htm")
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView extOrderProcessing(Principal principal, HttpServletRequest request,
            @RequestParam("act") String activity, @RequestParam("i") long id, @RequestParam("d") long id2,
            @RequestParam("b") String strVal, @RequestParam("c") String strVal2,
            @RequestParam("ofst") int offset, @RequestParam("maxR") int maxResults,
            @RequestParam("sStr") String searchPhrase) {
        if (principal == null) {
            return new ModelAndView("refresh");
        }
        Map<String, Object> model = new HashMap<String, Object>();
        model.put("onErrorReturnURL", "ajaxSubmitData('extordersmanagement/extOrderProcessing.htm', 'workpane', 'act=a&i=0&b=a&c=c&d=0&ofst=1&maxR=100&sStr=', 'GET');");
        try {
            model.put("act", activity);
            model.put("b", strVal);
            model.put("i", id);
            model.put("c", strVal2);
            model.put("d", id2);
            model.put("ofst", offset);
            model.put("maxR", maxResults);
            model.put("sStr", searchPhrase);

            request.getSession().setAttribute("sessPagingOffSet", offset);
            request.getSession().setAttribute("sessPagingMaxResults", maxResults);
            request.getSession().setAttribute("vsearch", searchPhrase);

            String[] orderFields = {"facilityorderid", "ordertype", "facilityorderno", "dateprepared", "dateneeded"};

            List<Facilityorder> orderList = new ArrayList<Facilityorder>();
            List<Object[]> orderListArr = new ArrayList<Object[]>();

            logger.info("xxx------------xxxxxxxx" + activity);
            if (activity.equals("a")) {
                String[] params = {};
                Object[] paramsValues = {};
                List<Object[]> ordListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, orderFields, "ORDER BY r.dateneeded ASC", params, paramsValues);
                if (ordListArr != null) {
                    logger.info("ordListArr ::::::::: " + ordListArr.size());
                    model.put("size", ordListArr.size());
                }
                model.put("extOrderList", ordListArr);
                model.put("facilityType", "Facility Orders");
                model.put("serverdate", formatterwithtime.format(serverDate));
                return new ModelAndView("inventoryAndSupplies/orders/processOrder/External/processOrderMainPane", "model", model);
            }

            return new ModelAndView("inventoryAndSupplies/orders/processOrder/External/response", "model", model);

        } catch (Exception e) {
            e.printStackTrace();
        }
        model.put("success", "<span class='text6'>Contact System Administrator :: Page Not Found!</span>");
        return new ModelAndView("response", "model", model);
    }

    @RequestMapping(value = "/manageFacilityExternalOrders", method = RequestMethod.GET)
    public String ManageFacilityExternalOrders(HttpServletRequest request, Model model) {
        String facilityNumber = "";
        List<Map> ordersFound = new ArrayList<>();

        facilityNumber = generateFacilityOrderNumbers();

        System.out.println("------------------------facilityNumber" + facilityNumber);
        model.addAttribute("facilityNumber", facilityNumber);

        String[] params4 = {"orderstatus"};
        Object[] paramsValues4 = {"NOT APPROVED"};
        String where4 = "WHERE orderstatus=:orderstatus";
        String[] fields4 = {"externalfacilityordersid", "neworderno", "approvalstartdate", "approvalenddate", "orderingstart", "orderingenddate", "isactive"};
        List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Externalfacilityorders.class, fields4, where4, params4, paramsValues4);
        if (items != null) {
            Map<String, Object> externalfacilityorders;
            for (Object[] objexternalfacilityorders : items) {

                externalfacilityorders = new HashMap<>();

                externalfacilityorders.put("externalfacilityordersid", objexternalfacilityorders[0]);
                externalfacilityorders.put("neworderno", objexternalfacilityorders[1]);
                externalfacilityorders.put("approvalstartdate", new SimpleDateFormat("dd-MM-yyyy").format((Date) objexternalfacilityorders[2]));
                externalfacilityorders.put("approvalenddate", new SimpleDateFormat("dd-MM-yyyy").format((Date) objexternalfacilityorders[3]));
                externalfacilityorders.put("orderingstart", new SimpleDateFormat("dd-MM-yyyy").format((Date) objexternalfacilityorders[4]));
                externalfacilityorders.put("orderingenddate", new SimpleDateFormat("dd-MM-yyyy").format((Date) objexternalfacilityorders[5]));
                //externalfacilityorders.put("isactive", items.get(0)[6]);
                externalfacilityorders.put("currentDate", formatter.format(new Date()));

                Date orderStartdate = null, orderEndDate = null, currentdate = null;
                try {
                    orderStartdate = formatter.parse(formatter.format((Date) objexternalfacilityorders[4]));
                    orderEndDate = formatter.parse(formatter.format((Date) objexternalfacilityorders[5]));
                    currentdate = formatter.parse(formatter.format(new Date()));
                } catch (ParseException ex) {
                    System.out.println(ex);
                }

                Calendar startdate1 = Calendar.getInstance();
                Calendar enDdate1 = Calendar.getInstance();
                Calendar currentdate1 = Calendar.getInstance();

                startdate1.setTime(orderStartdate);
                enDdate1.setTime(orderEndDate);
                currentdate1.setTime(currentdate);

                if (currentdate1.after(enDdate1)) {

                    externalfacilityorders.put("status", "after");

                } else if (currentdate1.before(startdate1)) {

                    externalfacilityorders.put("status", "before");
                } else {

                    externalfacilityorders.put("status", "now");
                }
                System.out.println("--------------------message" + externalfacilityorders);
                ordersFound.add(externalfacilityorders);
            }
        }
        model.addAttribute("externalFacOrders", ordersFound);

        return "controlPanel/localSettingsPanel/manageexternalorders/facilityExternalOrdersHome";

    }

    @RequestMapping(value = "/addFacilityExternalOrders", method = RequestMethod.GET)
    public String addFacilityExternalOrders(HttpServletRequest request, Model model) {

        return "controlPanel/localSettingsPanel/manageexternalorders/forms/addfacilityexternalorder";

    }

    @RequestMapping(value = "/viewFacilityExternalOrders", method = RequestMethod.GET)
    public String ViewFacilityExternalOrders(HttpServletRequest request, Model model) {

        return "controlPanel/localSettingsPanel/manageexternalorders/views/viewfacilityextorders";

    }

    @RequestMapping(value = "/approveFacilityExternalOrders", method = RequestMethod.GET)
    public String ApproveFacilityExternalOrders(HttpServletRequest request, Model model) {
        List<Map> ordersFound = new ArrayList<>();

        String[] params = {"orderstatus"};
        Object[] paramsValues = {"NOT APPROVED"};
        String where = "WHERE orderstatus=:orderstatus";
        String[] fields = {"externalfacilityordersid", "neworderno", "approvalstartdate", "approvalenddate", "orderingstart", "orderingenddate", "isactive"};
        List<Object[]> item = (List<Object[]>) genericClassService.fetchRecord(Externalfacilityorders.class, fields, where, params, paramsValues);
        if (item != null) {
            Map<String, Object> externalfacilityorders;
            for (Object[] items : item) {

                externalfacilityorders = new HashMap<>();

                externalfacilityorders.put("externalfacilityordersid", items[0]);
                externalfacilityorders.put("neworderno", items[1]);
                externalfacilityorders.put("approvalstartdate", formatter.format((Date) items[2]));
                externalfacilityorders.put("approvalenddate", formatter.format((Date) items[3]));
                externalfacilityorders.put("orderingstart", formatter.format((Date) items[4]));
                externalfacilityorders.put("orderingenddate", formatter.format((Date) items[5]));
                externalfacilityorders.put("isactive", items[6]);
                externalfacilityorders.put("currentDate", formatter.format(new Date()));

                int externalfacordersitemscount = 0;
                String[] params9 = {"approved", "isconsolidated"};
                Object[] paramsValues9 = {Boolean.TRUE, Boolean.FALSE};
                String where9 = "WHERE approved=:approved AND isconsolidated=:isconsolidated";
                externalfacordersitemscount = genericClassService.fetchRecordCount(Facilityorderitems.class, where9, params9, paramsValues9);
                externalfacilityorders.put("externalfacordersitemscount", externalfacordersitemscount);

                Date startdate = null, enDdate = null, currentdate = null;
                try {
                    startdate = formatter.parse(formatter.format((Date) items[2]));
                    enDdate = formatter.parse(formatter.format((Date) items[3]));
                    currentdate = formatter.parse(formatter.format(new Date()));
                } catch (ParseException ex) {
                    System.out.println(ex);
                }

                Calendar startdate1 = Calendar.getInstance();
                Calendar enDdate1 = Calendar.getInstance();
                Calendar currentdate1 = Calendar.getInstance();

                startdate1.setTime(startdate);
                enDdate1.setTime(enDdate);
                currentdate1.setTime(currentdate);

                if (currentdate1.after(enDdate1)) {

                    externalfacilityorders.put("message", "PAST DATE");

                } else if (currentdate1.before(startdate1)) {

                    externalfacilityorders.put("message", "NOT REACHED");
                } else {

                    externalfacilityorders.put("message", "TABLE VISIBLE");
                }
                System.out.println("---------------------------------message" + externalfacilityorders);
                ordersFound.add(externalfacilityorders);
            }
        }
        model.addAttribute("externalFacilityOrders", ordersFound);
        return "controlPanel/localSettingsPanel/manageexternalorders/views/approveexternalfacorders";
    }

    @RequestMapping(value = "/approveFacilityExternalOrderItems", method = RequestMethod.GET)

    public String ApproveFacilityExternalOrderItems(HttpServletRequest request, Model model, @ModelAttribute("externalfacilityordersid") int externalfacilityordersid, @ModelAttribute("neworderno") String neworderno) {

        String externalOrderItemsSize = "";
        Set<String> facilityexternalorders = new HashSet<>();
        List<Map> itemsFound = new ArrayList<>();
        List<Map> ordersFound = new ArrayList<>();

        model.addAttribute("externalfacilityordersid", externalfacilityordersid);
        model.addAttribute("neworderno", neworderno);

        String[] params = {"orderstatus", "externalfacilityordersid"};
        Object[] paramsValues = {"NOT APPROVED", externalfacilityordersid};
        String where = "WHERE orderstatus=:orderstatus AND externalfacilityordersid=:externalfacilityordersid";
        String[] fields = {"externalfacilityordersid", "neworderno", "approvalstartdate", "approvalenddate", "orderingstart", "orderingenddate", "isactive"};
        List<Object[]> extitem = (List<Object[]>) genericClassService.fetchRecord(Externalfacilityorders.class, fields, where, params, paramsValues);
        System.out.println("-------------------------------------itemidppppppppppppppppppppppppppplife" + extitem);
        if (extitem != null) {

            Map<String, Object> internalordersitemsRow;
            for (Object[] extitems : extitem) {

                String[] params4 = {"approved", "isconsolidated"};
                Object[] paramsValues4 = {Boolean.TRUE, Boolean.FALSE};
                String where4 = "WHERE approved=:approved AND isconsolidated=:isconsolidated";
                String[] fields4 = {"facilityorderitemsid", "qtyordered", "itemid", "facilityorderid", "qtyapproved"};
                List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fields4, where4, params4, paramsValues4);
                System.out.println("-------------------------------------itemidppppppppppppppppppppppppppp" + items);
                if (items != null) {
                    for (Object[] item : items) {
                        internalordersitemsRow = new HashMap<>();

                        int externalOrdersFacUnitcount = 0;
                        String[] paramsE = {"facilityorderid"};
                        Object[] paramsValuesE = {(Long) item[3]};
                        String whereE = "WHERE facilityorderid=:facilityorderid";
                        externalOrdersFacUnitcount = genericClassService.fetchRecordCount(Facilityorder.class, whereE, paramsE, paramsValuesE);
                        internalordersitemsRow.put("externalOrdersFacUnitcount", externalOrdersFacUnitcount);

                        System.out.println("-------------------------------------itemid" + (Long) item[2]);

                        String[] params7 = {"itemid"};
                        Object[] paramsValues7 = {(Long) item[2]};
                        String[] fields7 = {"genericname", "packsize", "unitcost", "itemstrength"};
                        List<Object[]> itemdetalis = (List<Object[]>) genericClassService.fetchRecord(Item.class, fields7, "WHERE itemid=:itemid", params7, paramsValues7);

                        if (itemdetalis != null) {

                            internalordersitemsRow.put("externalfacilityordersid", extitem.get(0)[0]);
                            internalordersitemsRow.put("neworderno", extitem.get(0)[1]);
                            internalordersitemsRow.put("orderingstart", extitem.get(0)[4]);
                            internalordersitemsRow.put("orderingenddate", extitem.get(0)[5]);

                            internalordersitemsRow.put("genericname", itemdetalis.get(0)[0]);
                            internalordersitemsRow.put("packsize", itemdetalis.get(0)[1]);
                            internalordersitemsRow.put("itemstrength", itemdetalis.get(0)[3]);
                            internalordersitemsRow.put("facilityorderitemsid", item[0]);
                            internalordersitemsRow.put("qtyordered", String.format("%,d", (Long) item[1]));
                            internalordersitemsRow.put("qtyapproved", String.format("%,d", (Long) item[4]));
                            internalordersitemsRow.put("qtyorderednocommas", item[1]);
                            internalordersitemsRow.put("itemid", item[2]);
                            internalordersitemsRow.put("facilityorderid", item[3]);

                            internalordersitemsRow.put("currentDate", formatter.format(new Date()));
                            itemsFound.add(internalordersitemsRow);
                            System.out.println("-------------------------------------itemsFound" + itemsFound);
                        }
                    }
                }
            }
        }
        model.addAttribute("externalOrderItems", itemsFound);
        model.addAttribute("externalOrderItemsSize", itemsFound.size());

        try {
            externalOrderItemsSize = new ObjectMapper().writeValueAsString(itemsFound.size());
        } catch (JsonProcessingException ex) {
            Logger.getLogger(ExtOrdersManagementController.class.getName()).log(Level.SEVERE, null, ex);
        }

        model.addAttribute("externalOrderItemsSizes", externalOrderItemsSize);

        System.out.println("-----------------------------------------------------externalOrderItemsSize" + externalOrderItemsSize);

        return "controlPanel/localSettingsPanel/manageexternalorders/views/approveExternalOrderItems";

    }

    private String generateFacilityOrderNumbers() {
        SimpleDateFormat f = new SimpleDateFormat("MMyy");

        String facilityNumber = "";

        java.util.Date date = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        int month = cal.get(Calendar.MONTH);

        if ((month + 1) >= 7 && (month + 1) <= 9) {
            facilityNumber = "Q1/" + f.format(new Date()) + "/01";
            System.out.println("------------------------FIRST QUATER" + facilityNumber);

            String[] params = {"neworderno"};
            Object[] paramsValues = {facilityNumber};
            String[] fields = {"neworderno"};
            String where = "WHERE neworderno LIKE :neworderno ORDER BY neworderno DESC LIMIT 1";
            List<String> lastFacilityOrderno = (List<String>) genericClassService.fetchRecord(Externalfacilityorders.class, fields, where, params, paramsValues);
            if (lastFacilityOrderno == null) {
                facilityNumber = "Q1/" + f.format(new Date()) + "/01";
                return facilityNumber;
            } else {
                try {
                    int lastNo = Integer.parseInt(lastFacilityOrderno.get(0).split("\\/")[1]);
                    String newNo = String.valueOf(lastNo + 1);
                    switch (newNo.length()) {
                        case 1:
                            facilityNumber = "Q1/" + f.format(new Date()) + "/0" + newNo;
                            break;
                        default:
                            facilityNumber = "Q1/" + f.format(new Date()) + "/" + newNo;
                            break;
                    }
                } catch (Exception e) {
                    System.out.println(e);
                }
                System.out.println("------------------------FIRST QUATER1111111111" + facilityNumber);

            }
        } else if ((month + 1) >= 10 && (month + 1) <= 12) {
            facilityNumber = "Q2/" + f.format(new Date()) + "/01";
            String[] params = {"neworderno"};
            Object[] paramsValues = {facilityNumber};
            String[] fields = {"neworderno"};
            String where = "WHERE neworderno LIKE :neworderno ORDER BY neworderno DESC LIMIT 1";
            List<String> lastFacilityOrderno = (List<String>) genericClassService.fetchRecord(Externalfacilityorders.class, fields, where, params, paramsValues);
            if (lastFacilityOrderno == null) {
                facilityNumber = "Q2/" + f.format(new Date()) + "/01";
                return facilityNumber;
            } else {
                try {
                    int lastNo = Integer.parseInt(lastFacilityOrderno.get(0).split("\\/")[1]);
                    String newNo = String.valueOf(lastNo + 1);
                    switch (newNo.length()) {
                        case 1:
                            facilityNumber = "Q2/" + f.format(new Date()) + "/0" + newNo;
                            break;
                        default:
                            facilityNumber = "Q2/" + f.format(new Date()) + "/" + newNo;
                            break;
                    }
                } catch (Exception e) {
                    System.out.println(e);
                }
            }
        } else if ((month + 1) >= 1 && (month + 1) <= 3) {
            facilityNumber = "Q3/" + f.format(new Date()) + "/01";

            String[] params = {"neworderno"};
            Object[] paramsValues = {facilityNumber};
            String[] fields = {"neworderno"};
            String where = "WHERE neworderno LIKE :neworderno ORDER BY neworderno DESC LIMIT 1";
            List<String> lastFacilityOrderno = (List<String>) genericClassService.fetchRecord(Externalfacilityorders.class, fields, where, params, paramsValues);
            if (lastFacilityOrderno == null) {
                facilityNumber = "Q3/" + f.format(new Date()) + "/01";
                return facilityNumber;
            } else {
                try {
                    int lastNo = Integer.parseInt(lastFacilityOrderno.get(0).split("\\/")[1]);
                    String newNo = String.valueOf(lastNo + 1);
                    switch (newNo.length()) {
                        case 1:
                            facilityNumber = "Q3/" + f.format(new Date()) + "/0" + newNo;
                            break;
                        default:
                            facilityNumber = "Q3/" + f.format(new Date()) + "/" + newNo;
                            break;
                    }
                } catch (Exception e) {
                    System.out.println(e);
                }
            }
        } else {
            facilityNumber = "Q4/" + f.format(new Date()) + "/01";

            String[] params = {"neworderno"};
            Object[] paramsValues = {facilityNumber};
            String[] fields = {"neworderno"};
            String where = "WHERE neworderno LIKE :neworderno ORDER BY neworderno DESC LIMIT 1";
            List<String> lastFacilityOrderno = (List<String>) genericClassService.fetchRecord(Externalfacilityorders.class, fields, where, params, paramsValues);
            if (lastFacilityOrderno == null) {
                facilityNumber = "Q4/" + f.format(new Date()) + "/01";
                return facilityNumber;
            } else {
                try {
                    int lastNo = Integer.parseInt(lastFacilityOrderno.get(0).split("\\/")[1]);
                    String newNo = String.valueOf(lastNo + 1);
                    switch (newNo.length()) {
                        case 1:
                            facilityNumber = "Q4/" + f.format(new Date()) + "/0" + newNo;
                            break;
                        default:
                            facilityNumber = "Q4/" + f.format(new Date()) + "/" + newNo;
                            break;
                    }
                } catch (Exception e) {
                    System.out.println(e);
                }
            }
        }

        return facilityNumber;
    }
//
//    @RequestMapping(value = "/viewFacExternalOrderItems", method = RequestMethod.GET)
//    public String viewFacExternalOrderItems(HttpServletRequest request, Model model, @ModelAttribute("externalfacilityordersid") int externalfacilityordersid) {
//        List<Map> externalItems = new ArrayList<>();
//        String[] params = {"orderstatus", "externalfacilityordersid"};
//        Object[] paramsValues = {"NOT APPROVED", externalfacilityordersid};
//        String where = "WHERE orderstatus=:orderstatus AND externalfacilityordersid=:externalfacilityordersid";
//        String[] fields = {"externalfacilityordersid", "neworderno", "approvalstartdate", "approvalenddate", "orderingstart", "orderingenddate", "isactive"};
//        List<Object[]> extitem = (List<Object[]>) genericClassService.fetchRecord(Externalfacilityorders.class, fields, where, params, paramsValues);
//        System.out.println("-------------------------------------itemidppppppppppppppppppppppppppplife" + extitem);
//        if (extitem != null) {
//
//            Map<String, Object> internalordersitemsRow;
//            for (Object[] extitems : extitem) {
//
//                String[] params4 = {"approved", "isconsolidated"};
//                Object[] paramsValues4 = {Boolean.TRUE, Boolean.FALSE};
//                String where4 = "WHERE approved=:approved AND isconsolidated=:isconsolidated";
//                String[] fields4 = {"facilityorderitemsid", "qtyordered", "itemid", "facilityorderid", "qtyapproved"};
//                List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fields4, where4, params4, paramsValues4);
//                System.out.println("-------------------------------------itemidppppppppppppppppppppppppppp" + items);
//                if (items != null) {
//                    for (Object[] item : items) {
//                        internalordersitemsRow = new HashMap<>();
//
//                        int externalOrdersFacUnitcount = 0;
//                        String[] paramsE = {"facilityorderid"};
//                        Object[] paramsValuesE = {(Long) item[3]};
//                        String whereE = "WHERE facilityorderid=:facilityorderid";
//                        externalOrdersFacUnitcount = genericClassService.fetchRecordCount(Facilityorder.class, whereE, paramsE, paramsValuesE);
//                        internalordersitemsRow.put("externalOrdersFacUnitcount", externalOrdersFacUnitcount);
//
//                        System.out.println("-------------------------------------itemid" + (Long) item[2]);
//                        String[] params7 = {"itempackageid"};
//                        Object[] paramsValues7 = {(Long) item[2]};
//                        String[] fields7 = {"packagename", "packagequantity", "unitcost", "itemstrength"};
//                        List<Object[]> itemdetalis = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields7, "WHERE itempackageid=:itempackageid", params7, paramsValues7);
//                        if (itemdetalis != null) {
//
//                            internalordersitemsRow.put("externalfacilityordersid", extitem.get(0)[0]);
//                            internalordersitemsRow.put("neworderno", extitem.get(0)[1]);
//                            internalordersitemsRow.put("orderingstart", extitem.get(0)[4]);
//                            internalordersitemsRow.put("orderingenddate", extitem.get(0)[5]);
//
//                            internalordersitemsRow.put("genericname", itemdetalis.get(0)[0]);
//                            internalordersitemsRow.put("packsize", itemdetalis.get(0)[1]);
//                            internalordersitemsRow.put("itemstrength", itemdetalis.get(0)[3]);
//                            internalordersitemsRow.put("facilityorderitemsid", item[0]);
//                            internalordersitemsRow.put("qtyordered", String.format("%,d", (Long) item[1]));
//                            internalordersitemsRow.put("qtyapproved", String.format("%,d", (Long) item[4]));
//                            internalordersitemsRow.put("qtyorderednocommas", item[1]);
//                            internalordersitemsRow.put("itemid", item[2]);
//                            internalordersitemsRow.put("facilityorderid", item[3]);
//
//                            internalordersitemsRow.put("currentDate", formatter.format(new Date()));
//                            externalItems.add(internalordersitemsRow);
//                        }
//                    }
//                }
//            }
//        }
//        model.addAttribute("externalFacOrderItems", externalItems);
//
//        return "controlPanel/localSettingsPanel/manageexternalorders/views/facorderitems";
//
//    }

    @RequestMapping(value = "/viewFacExternalUnits", method = RequestMethod.GET)
    public String viewFacExternalUnits(HttpServletRequest request, Model model, @ModelAttribute("facilityorderitemsid") Long facilityorderitemsid) {
        List<Map> externalItems = new ArrayList<>();

        String[] paramszr = {"facilityorderitemsid"};
        Object[] paramsValueszr = {facilityorderitemsid};
        String[] fieldszr = {"facilityorderid", "itemid", "qtyordered"};
        String wherezr = "WHERE facilityorderitemsid=:facilityorderitemsid";
        List<Object[]> extOrderedItems = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fieldszr, wherezr, paramszr, paramsValueszr);
        if (extOrderedItems != null) {
            Map<String, Object> items;
            for (Object[] item : extOrderedItems) {
                items = new HashMap<>();
                items.put("qtyordered", item[2]);

                String[] params4 = {"facilityorderid"};
                Object[] paramsValues4 = {(Long) item[0]};
                String where4 = "WHERE facilityorderid=:facilityorderid";
                String[] fields4 = {"originstore"};
                List<Long> facilityexternalorders = (List<Long>) genericClassService.fetchRecord(Facilityorder.class, fields4, where4, params4, paramsValues4);
                if (facilityexternalorders != null) {
                    for (Long facilityexternalorder : facilityexternalorders) {
                        String[] params = {"facilityunitid"};
                        Object[] paramsValues = {(Long) facilityexternalorder};
                        String where = "WHERE facilityunitid=:facilityunitid";
                        String[] fields = {"facilityunitname", "shortname"};
                        List<Object[]> destinationunit = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields, where, params, paramsValues);
                        if (destinationunit != null) {
                            items.put("facilityunitname", destinationunit.get(0)[0]);
                            items.put("shortname", destinationunit.get(0)[1]);
                        }
                    }
                }

                String[] params = {"itempackageid"};
                Object[] paramsValues = {(Long) item[1]};
                String where = "WHERE itempackageid=:itempackageid";
                String[] fields = {"packagename", "itemstrength"};
                List<Object[]> destinationunit = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields, where, params, paramsValues);
                if (destinationunit != null) {
                    items.put("genericname", destinationunit.get(0)[0]);
                    items.put("itemstrength", destinationunit.get(0)[1]);
                }

                externalItems.add(items);
                model.addAttribute("externalFacOrderUnits", externalItems);

            }
        }

        return "controlPanel/localSettingsPanel/manageexternalorders/views/orderunits";

    }

    @RequestMapping(value = "/savenewfacilityorder.htm")
    public @ResponseBody
    String savenewfacilityorder(HttpServletRequest request) {
        DateFormat formatter2;
        Date date;
        formatter2 = new SimpleDateFormat("dd-MMM-yy");
        String results = "";
        int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
        Externalfacilityorders facilityorder = new Externalfacilityorders();
        try {

            facilityorder.setNeworderno(request.getParameter("newfacilityorderno"));
            facilityorder.setOrderingstart(formatter.parse(request.getParameter("orderingstartdate").replaceAll("/", "-")));
            facilityorder.setOrderingenddate(formatter.parse(request.getParameter("orderingenddate").replaceAll("/", "-")));
            facilityorder.setApprovalstartdate(formatter.parse(request.getParameter("approvalstartdate").replaceAll("/", "-")));
            facilityorder.setApprovalenddate(formatter.parse(request.getParameter("approvalenddate").replaceAll("/", "-")));
            facilityorder.setOrderstatus("NOT APPROVED");
            facilityorder.setFacilityid(facilityid);
            facilityorder.setIsactive(Boolean.FALSE);
            facilityorder.setSupplierid(Long.parseLong(request.getParameter("supplier")));

            Object save = genericClassService.saveOrUpdateRecordLoadObject(facilityorder);
            if (save != null) {
                results = "saved";
            }
        } catch (ParseException ex) {
            results = "failed";
            System.out.println(ex);
        }
        return results;
    }

    @RequestMapping(value = "/saveNewOrderValue", method = RequestMethod.POST)
    public @ResponseBody
    String saveNewOrderValue(HttpServletRequest request, Model model) {
        String results = "";
        if (request.getSession().getAttribute("sessionActiveLoginFacility") != null) {
            int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
            Object updatedbynamed = request.getSession().getAttribute("person_id");
            try {
                String[] columnsr = {"isconsolidated"};
                Object[] columnValuesr = {true};
                String pkr = "facilityorderitemsid";
                Object pkValuer = Long.parseLong(request.getParameter("facilityorderitemsid"));
                Object result = genericClassService.updateRecordSQLSchemaStyle(Facilityorderitems.class, columnsr, columnValuesr, pkr, pkValuer, "store");
                if (result != null) {
                    results = "success";
                } else {
                    results = "failed";
                }
            } catch (Exception e) {
                System.out.println(e);
            }
        }
        return results;
    }

    @RequestMapping(value = "/facilityorderdates.htm")
    public @ResponseBody
    String facilityorderdates(HttpServletRequest request) {
        String results = "";
        Date today = new Date();
        String[] params = {"externalfacilityordersid"};
        Object[] paramsValues = {Integer.parseInt(request.getParameter("externalfacilityordersid"))};
        String[] fields = {"orderstatus", "orderingstart", "orderingenddate", "approvalstartdate", "approvalenddate"};
        List<Object[]> orderdates = (List<Object[]>) genericClassService.fetchRecord(Externalfacilityorders.class, fields, "WHERE externalfacilityordersid=:externalfacilityordersid", params, paramsValues);
        if (orderdates != null) {
            if ("fnancilayr".equals(request.getParameter("type"))) {
                if (today.getTime() >= ((Date) orderdates.get(0)[1]).getTime() || ((Date) orderdates.get(0)[2]).getTime() <= today.getTime()) {
                    results = "started";
                } else {
                    results = "notstarted";
                }
            } else {
                results = "notstarted";
            }
        }

        return results;
    }

    @RequestMapping(value = "/updatefacilityorderdates.htm")
    public @ResponseBody
    String updatefacilityorderdates(HttpServletRequest request) {
        String results = "";
        try {
            String[] columns = {"orderingstart", "orderingenddate", "approvalstartdate", "approvalenddate"};
            Object[] columnValues = {formatter.parse(request.getParameter("orderingstartdate")), formatter.parse(request.getParameter("orderingenddate")), formatter.parse(request.getParameter("approvalstartdate")), formatter.parse(request.getParameter("approvalenddate"))};
            String pk = "externalfacilityordersid";
            Object pkValue = Integer.parseInt(request.getParameter("externalfacilityordersid"));

            int result = genericClassService.updateRecordSQLSchemaStyle(Externalfacilityorders.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                results = "success";
            }
        } catch (NumberFormatException | ParseException e) {

        }

        return results;
    }

    @RequestMapping(value = "/addnewfacilityexternalorder", method = RequestMethod.GET)
    public String addnewfacilityexternalorder(HttpServletRequest request, Model model) {
        String facilityNumber = "";
        List<Map> externalSuppliers = new ArrayList<>();
        facilityNumber = generateFacilityOrderNumbers();

        System.out.println("------------------------facilityNumber" + facilityNumber);

        model.addAttribute("facilityNumber", facilityNumber);
        String[] params = {};
        Object[] paramsValues = {};
        String[] fields = {"supplierid", "suppliername"};
        List<Object[]> suppliers = (List<Object[]>) genericClassService.fetchRecord(Supplier.class, fields, "", params, paramsValues);
        if (suppliers != null) {
            Map<String, Object> suppliersRow;
            for (Object[] supplier : suppliers) {
                suppliersRow = new HashMap<>();
                suppliersRow.put("supplierid", supplier[0]);
                suppliersRow.put("suppliername", supplier[1]);
                externalSuppliers.add(suppliersRow);
            }
        }
        model.addAttribute("externalSuppliers", externalSuppliers);
        model.addAttribute("serverdate", formatterwithtime.format(serverDate));
        return "controlPanel/localSettingsPanel/manageexternalorders/forms/addExternalOrders";
    }

    @RequestMapping(value = "/placeexternalordershome.htm", method = RequestMethod.GET)
    public String placeexternalordershome(Model model, HttpServletRequest request) {
        List<Map> suppliersFound = new ArrayList<>();
        String[] params6 = {"facilityunitid"};
        Object[] paramsValues6 = {Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))};
        String[] fields6 = {"facilityunitname"};
        List<String> facilityunitlog = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fields6, "WHERE facilityunitid=:facilityunitid", params6, paramsValues6);
        if (facilityunitlog != null) {
            model.addAttribute("loggedinfacilityunitname", facilityunitlog.get(0));
        }

        String[] params4 = {"orderstatus"};
        Object[] paramsValues4 = {"ACTIVE"};
        String where4 = "WHERE orderstatus=:orderstatus";
        String[] fields4 = {"externalfacilityordersid", "neworderno", "supplierid", "orderingstart", "orderingenddate"};
        List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Externalfacilityorders.class, fields4, where4, params4, paramsValues4);
        if (items != null) {
            Map<String, Object> supplierRow;
            for (Object[] objexternalfacilityorders : items) {
                supplierRow = new HashMap<>();

                String[] paramsk = {"externalfacilityordersid"};
                Object[] paramsValuesk = {objexternalfacilityorders[0]};
                String[] fieldsk = {"facilityorderid", "dateprepared"};
                String wherek = "WHERE externalfacilityordersid=:externalfacilityordersid";
                List<Object[]> supplierItems = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fieldsk, wherek, paramsk, paramsValuesk);
                if (supplierItems == null) {

                    supplierRow.put("externalfacilityordersid", objexternalfacilityorders[0]);
                    supplierRow.put("neworderno", objexternalfacilityorders[1]);
                    supplierRow.put("supplierid", objexternalfacilityorders[2]);

                    String[] params = {"supplierid"};
                    Object[] paramsValues = {objexternalfacilityorders[2]};
                    String[] fields = {"suppliername"};
                    List<String> supplier = (List<String>) genericClassService.fetchRecord(Supplier.class, fields, "WHERE supplierid=:supplierid", params, paramsValues);
                    if (supplier != null) {
                        supplierRow.put("suppliername", supplier.get(0));
                    }
                    suppliersFound.add(supplierRow);
                }
            }
        } else {
            model.addAttribute("act", "a");
        }

        model.addAttribute("ordersFound", suppliersFound);
        model.addAttribute("size", suppliersFound.size());
        model.addAttribute("serverdate", formatterwithtime.format(serverDate));
        return "inventoryAndSupplies/orders/placeOrders/externalOrder/forms/newOrder";
    }

    @RequestMapping(value = "/additemtoorder.htm", method = RequestMethod.GET)
    public String additemtoorder(Model model, HttpServletRequest request) {
        model.addAttribute("externalfacilityordersid", request.getParameter("externalfacilityordersid"));
        model.addAttribute("ordernumber", request.getParameter("facilityOrderNumber"));
        model.addAttribute("facilityordersuppliername", request.getParameter("facilityordersuppliername"));
        model.addAttribute("supplierid", request.getParameter("supplierid"));
        return "inventoryAndSupplies/orders/placeOrders/externalOrder/forms/addItems";
    }

    @RequestMapping(value = "/searchitems.htm", method = RequestMethod.GET)
    public String searchitems(Model model, HttpServletRequest request) {
        List<Map> itemsFound = new ArrayList<>();
        try {
            Set<Long> items = new HashSet<>();
            List<Integer> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("itemSet"), List.class);
            if (!item.isEmpty()) {
                for (Integer itemz : item) {
                    items.add(Long.parseLong(String.valueOf(itemz)));
                }
            }
            String[] params = {"value", "name", "isactive", "supplierid"};
            Object[] paramsValues = {request.getParameter("searchValue").trim().toLowerCase() + "%", "%" + request.getParameter("searchValue").trim().toLowerCase() + "%", Boolean.TRUE, BigInteger.valueOf(Long.valueOf(request.getParameter("supplierid")))};
            String[] fields = {"itemid", "packagename", "categoryname"};
            String where = "WHERE isactive=:isactive AND supplierid=:supplierid AND (LOWER(genericname) LIKE :name OR LOWER(genericname) LIKE :value) ORDER BY packagename";
            List<Object[]> supplierItems = (List<Object[]>) genericClassService.fetchRecord(Supplieritemcategories.class, fields, where, params, paramsValues);
            if (supplierItems != null) {
                Map<String, Object> itemsRow;
                for (Object[] supplierItem : supplierItems) {
                    itemsRow = new HashMap<>();
                    if (items.isEmpty() || !items.contains(((BigInteger) supplierItem[0]).longValue())) {
                        itemsRow.put("itemid", supplierItem[0]);
                        itemsRow.put("genericname", supplierItem[1]);
                        itemsRow.put("categoryname", supplierItem[2]);
                        itemsFound.add(itemsRow);
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("::::::::::::::::::::::::::" + e);
        }

        model.addAttribute("itemsFound", itemsFound);
        model.addAttribute("name", request.getParameter("searchValue"));
        return "inventoryAndSupplies/orders/placeOrders/externalOrder/forms/searchResults";
    }

    @RequestMapping(value = "/submitorpauseexternalorder.htm")
    public @ResponseBody
    String submitorpauseexternalorder(HttpServletRequest request) {
        String results = "";
        try {
            Facilityorder facilityorder = new Facilityorder();
            facilityorder.setFacilityorderno(generatefacilityorderno("00" + request.getSession().getAttribute("sessionActiveLoginFacilityUnit"), request.getSession().getAttribute("sessionActiveLoginFacilityUnit")));
            facilityorder.setApproved(Boolean.FALSE);
            facilityorder.setDateprepared(new Date());
            facilityorder.setOrdertype("EXTERNAL");
            facilityorder.setOriginstore(BigInteger.valueOf(((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")).longValue()));
            facilityorder.setIsemergency(Boolean.FALSE);
            facilityorder.setPreparedby(BigInteger.valueOf((Long) request.getSession().getAttribute("sessionActiveLoginStaffid")));
            facilityorder.setExternalfacilityordersid(Integer.parseInt(request.getParameter("externalfacilityordersid")));
            if ("submit".equals(request.getParameter("type"))) {
                facilityorder.setStatus("SUBMITTED");
            } else {
                facilityorder.setStatus("PAUSED");
            }
            Object save = genericClassService.saveOrUpdateRecordLoadObject(facilityorder);
            if (save != null) {
                List<Map> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("items"), List.class);
                for (Map item1 : item) {
                    Map<String, Object> map = (HashMap) item1;
                    Facilityorderitems facilityorderitems = new Facilityorderitems();
                    facilityorderitems.setApproved(Boolean.FALSE);
                    facilityorderitems.setFacilityorderid(facilityorder);
                    facilityorderitems.setQtyordered(BigInteger.valueOf(Long.parseLong((String) map.get("qty"))));
                    facilityorderitems.setItemid(new Item(((Integer) map.get("itemid")).longValue()));
                    genericClassService.saveOrUpdateRecordLoadObject(facilityorderitems);
                }
            }

        } catch (Exception e) {

        }
        return results;
    }

    private String generatefacilityorderno(String facilityunit, Object originstoreid) {
        String name = facilityunit + "/";
        SimpleDateFormat f = new SimpleDateFormat("yyMM");
        String pattern = name + f.format(new Date()) + "/%";
        String facilityorderno = "";
        String facilityNumber = "";
        String[] params = {"originstore", "facilityorderno"};
        Object[] paramsValues = {originstoreid, pattern};
        String[] fields = {"facilityorderno"};
        String where = "WHERE originstore=:originstore AND facilityorderno LIKE :facilityorderno ORDER BY facilityorderno DESC LIMIT 1";
        List<String> lastFacilityorderno = (List<String>) genericClassService.fetchRecord(Facilityorder.class, fields, where, params, paramsValues);
        if (lastFacilityorderno == null) {
            facilityorderno = name + f.format(new Date()) + "/0001";
            return facilityorderno;
        } else {
            facilityNumber = "Q4/" + f.format(new Date()) + "/01";

            String[] params1 = {"neworderno"};
            Object[] paramsValues1 = {facilityNumber};
            String[] fields1 = {"neworderno"};
            String where1 = "WHERE neworderno LIKE :neworderno ORDER BY neworderno DESC LIMIT 1";
            List<String> lastFacilityOrderno = (List<String>) genericClassService.fetchRecord(Externalfacilityorders.class, fields1, where1, params1, paramsValues1);
            if (lastFacilityOrderno == null) {
                facilityNumber = "Q4/" + f.format(new Date()) + "/01";
                return facilityNumber;
            } else {
                try {
                    int lastNo = Integer.parseInt(lastFacilityOrderno.get(0).split("\\/")[1]);
                    String newNo = String.valueOf(lastNo + 1);
                    switch (newNo.length()) {
                        case 1:
                            facilityNumber = "Q4/" + f.format(new Date()) + "/0" + newNo;
                            break;
                        default:
                            facilityNumber = "Q4/" + f.format(new Date()) + "/" + newNo;
                            break;
                    }
                } catch (Exception e) {
                    System.out.println(e);
                }
            }
        }

        return facilityNumber;
    }

//    @RequestMapping(value = "/viewFacExternalOrderItems", method = RequestMethod.GET)
//    public String viewFacExternalOrderItems(HttpServletRequest request, Model model, @ModelAttribute("externalfacilityordersid") int externalfacilityordersid) {
//        List<Map> externalItems = new ArrayList<>();
//        String[] params = {"orderstatus", "externalfacilityordersid"};
//        Object[] paramsValues = {"NOT APPROVED", externalfacilityordersid};
//        String where = "WHERE orderstatus=:orderstatus AND externalfacilityordersid=:externalfacilityordersid";
//        String[] fields = {"externalfacilityordersid", "neworderno", "approvalstartdate", "approvalenddate", "orderingstart", "orderingenddate", "isactive"};
//        List<Object[]> extitem = (List<Object[]>) genericClassService.fetchRecord(Externalfacilityorders.class, fields, where, params, paramsValues);
//        System.out.println("-------------------------------------itemidppppppppppppppppppppppppppplife" + extitem);
//        if (extitem != null) {
//
//            Map<String, Object> internalordersitemsRow;
//            for (Object[] extitems : extitem) {
//
//                String[] params4 = {"approved", "isconsolidated"};
//                Object[] paramsValues4 = {Boolean.TRUE, Boolean.FALSE};
//                String where4 = "WHERE approved=:approved AND isconsolidated=:isconsolidated";
//                String[] fields4 = {"facilityorderitemsid", "qtyordered", "itemid", "facilityorderid", "qtyapproved"};
//                List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fields4, where4, params4, paramsValues4);
//                System.out.println("-------------------------------------itemidppppppppppppppppppppppppppp" + items);
//                if (items != null) {
//                    for (Object[] item : items) {
//                        internalordersitemsRow = new HashMap<>();
//
//                        int externalOrdersFacUnitcount = 0;
//                        String[] paramsE = {"facilityorderid"};
//                        Object[] paramsValuesE = {(Long) item[3]};
//                        String whereE = "WHERE facilityorderid=:facilityorderid";
//                        externalOrdersFacUnitcount = genericClassService.fetchRecordCount(Facilityorder.class, whereE, paramsE, paramsValuesE);
//                        internalordersitemsRow.put("externalOrdersFacUnitcount", externalOrdersFacUnitcount);
//
//                        System.out.println("-------------------------------------itemid" + (Long) item[2]);
//                        String[] params7 = {"itemid"};
//                        Object[] paramsValues7 = {(Long) item[2]};
//                        String[] fields7 = {"genericname", "packsize", "unitcost", "itemstrength"};
//                        List<Object[]> itemdetalis = (List<Object[]>) genericClassService.fetchRecord(Item.class, fields7, "WHERE itemid=:itemid", params7, paramsValues7);
//                        if (itemdetalis != null) {
//
//                            internalordersitemsRow.put("externalfacilityordersid", extitem.get(0)[0]);
//                            internalordersitemsRow.put("neworderno", extitem.get(0)[1]);
//                            internalordersitemsRow.put("orderingstart", extitem.get(0)[4]);
//                            internalordersitemsRow.put("orderingenddate", extitem.get(0)[5]);
//
//                            internalordersitemsRow.put("genericname", itemdetalis.get(0)[0]);
//                            internalordersitemsRow.put("packsize", itemdetalis.get(0)[1]);
//                            internalordersitemsRow.put("itemstrength", itemdetalis.get(0)[3]);
//                            internalordersitemsRow.put("facilityorderitemsid", item[0]);
//                            internalordersitemsRow.put("qtyordered", String.format("%,d", (Long) item[1]));
//                            internalordersitemsRow.put("qtyapproved", String.format("%,d", (Long) item[4]));
//                            internalordersitemsRow.put("qtyorderednocommas", item[1]);
//                            internalordersitemsRow.put("itemid", item[2]);
//                            internalordersitemsRow.put("facilityorderid", item[3]);
//
//                            internalordersitemsRow.put("currentDate", formatter.format(new Date()));
//                            externalItems.add(internalordersitemsRow);
//                        }
//                    }
//                }
//            }
//        }
//        model.addAttribute("externalFacOrderItems", externalItems);
//
//        return "controlPanel/localSettingsPanel/manageexternalorders/views/facorderitems";
//
//    }
//
//    @RequestMapping(value = "/viewFacExternalUnits", method = RequestMethod.GET)
//    public String viewFacExternalUnits(HttpServletRequest request, Model model, @ModelAttribute("facilityorderitemsid") Long facilityorderitemsid) {
//        List<Map> externalItems = new ArrayList<>();
//
//        String[] paramszr = {"facilityorderitemsid"};
//        Object[] paramsValueszr = {facilityorderitemsid};
//        String[] fieldszr = {"facilityorderid", "itemid", "qtyordered"};
//        String wherezr = "WHERE facilityorderitemsid=:facilityorderitemsid";
//        List<Object[]> extOrderedItems = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fieldszr, wherezr, paramszr, paramsValueszr);
//        if (extOrderedItems != null) {
//            Map<String, Object> items;
//            for (Object[] item : extOrderedItems) {
//                items = new HashMap<>();
//                items.put("qtyordered", item[2]);
//
//                String[] params4 = {"facilityorderid"};
//                Object[] paramsValues4 = {(Long) item[0]};
//                String where4 = "WHERE facilityorderid=:facilityorderid";
//                String[] fields4 = {"originstore"};
//                List<Long> facilityexternalorders = (List<Long>) genericClassService.fetchRecord(Facilityorder.class, fields4, where4, params4, paramsValues4);
//                if (facilityexternalorders != null) {
//                    for (Long facilityexternalorder : facilityexternalorders) {
//                        String[] params = {"facilityunitid"};
//                        Object[] paramsValues = {(Long) facilityexternalorder};
//                        String where = "WHERE facilityunitid=:facilityunitid";
//                        String[] fields = {"facilityunitname", "shortname"};
//                        List<Object[]> destinationunit = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields, where, params, paramsValues);
//                        if (destinationunit != null) {
//                            items.put("facilityunitname", destinationunit.get(0)[0]);
//                            items.put("shortname", destinationunit.get(0)[1]);
//                        }
//                    }
//                }
//
//                String[] params = {"itemid"};
//                Object[] paramsValues = {(Long) item[1]};
//                String where = "WHERE itemid=:itemid";
//                String[] fields = {"genericname", "itemstrength"};
//                List<Object[]> destinationunit = (List<Object[]>) genericClassService.fetchRecord(Item.class, fields, where, params, paramsValues);
//                if (destinationunit != null) {
//                    items.put("genericname", destinationunit.get(0)[0]);
//                    items.put("itemstrength", destinationunit.get(0)[1]);
//                }
//
//                externalItems.add(items);
//                model.addAttribute("externalFacOrderUnits", externalItems);
//
//            }
//        }
//
//        return "controlPanel/localSettingsPanel/manageexternalorders/views/orderunits";
//
//    }
//
//    @RequestMapping(value = "/savenewfacilityorder.htm")
//    public @ResponseBody
//    String savenewfacilityorder(HttpServletRequest request) {
//        DateFormat formatter2;
//        Date date;
//        formatter2 = new SimpleDateFormat("dd-MMM-yy");
//        String results = "";
//        int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
//        Externalfacilityorders facilityorder = new Externalfacilityorders();
//        try {
//
//            facilityorder.setNeworderno(request.getParameter("newfacilityorderno").replaceAll("/", "-"));
//            facilityorder.setOrderingstart(formatter.parse(request.getParameter("orderingstartdate").replaceAll("/", "-")));
//            facilityorder.setOrderingenddate(formatter.parse(request.getParameter("orderingenddate").replaceAll("/", "-")));
//            facilityorder.setApprovalstartdate(formatter.parse(request.getParameter("approvalstartdate").replaceAll("/", "-")));
//            facilityorder.setApprovalenddate(formatter.parse(request.getParameter("approvalenddate").replaceAll("/", "-")));
//            facilityorder.setOrderstatus("NOT APPROVED");
//            facilityorder.setFacilityid(facilityid);
//            facilityorder.setIsactive(Boolean.TRUE);
//            Object save = genericClassService.saveOrUpdateRecordLoadObject(facilityorder);
//            if (save != null) {
//                results = "saved";
//            }
//        } catch (Exception ex) {
//            results = "failed";
//            System.out.println(ex);
//        }
//        return results;
//    }
//
//    @RequestMapping(value = "/saveNewOrderValue", method = RequestMethod.POST)
//    public @ResponseBody
//    String saveNewOrderValue(HttpServletRequest request, Model model) {
//        String results = "";
//        if (request.getSession().getAttribute("sessionActiveLoginFacility") != null) {
//            int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
//            Object updatedbynamed = request.getSession().getAttribute("person_id");
//            try {
//<<<<<<< HEAD
//                String[] columnsr = {"isconsolidated"};
//                Object[] columnValuesr = {true};
//                String pkr = "facilityorderitemsid";
//                Object pkValuer = Long.parseLong(request.getParameter("facilityorderitemsid"));
//                Object result = genericClassService.updateRecordSQLSchemaStyle(Facilityorderitems.class, columnsr, columnValuesr, pkr, pkValuer, "store");
//                if (result != null) {
//                    results = "success";
//                } else {
//                    results = "failed";
//=======
//                int lastNo = Integer.parseInt(lastFacilityorderno.get(0).split("\\/")[2]);
//                String newNo = String.valueOf(lastNo + 1);
//                switch (newNo.length()) {
//                    case 1:
//                        facilityorderno = name + f.format(new Date()) + "/000" + newNo;
//                        break;
//                    case 2:
//                        facilityorderno = name + f.format(new Date()) + "/00" + newNo;
//                        break;
//                    case 3:
//                        facilityorderno = name + f.format(new Date()) + "/0" + newNo;
//                        break;
//                    default:
//                        facilityorderno = name + f.format(new Date()) + "/" + newNo;
//                        break;
//>>>>>>> ffab975d4b4fbfa3d1d3936b623f343c9b0a07d9
//                }
//            } catch (Exception e) {
//                System.out.println(e);
//            }
//        }
//<<<<<<< HEAD
//        return results;
//    }
    @RequestMapping(value = "/approveorunapproveextfacilityorderitems.htm")
    public @ResponseBody
    String approveorunapproveextfacilityorderitem(HttpServletRequest request) {
        String results = "";
        System.out.println("--------------------------------1");
        if ("approve".equals(request.getParameter("type"))) {
            System.out.println();
            String[] columns = {"orderstatus", "approvedby", "dateapproved"};
            Object[] columnValues = {"APPROVED", (Long) request.getSession().getAttribute("person_id"), new Date()};
            String pk = "externalfacilityordersid";
            Object pkValue = Integer.parseInt(request.getParameter("externalfacilityordersid"));
            int result = genericClassService.updateRecordSQLSchemaStyle(Externalfacilityorders.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                results = "success";
                System.out.println("--------------------------------2");
            }
            System.out.println("--------------------------------3");
            String[] columns1 = {"externalfacilityordersid", "approved", "approvedby"};
            Object[] columnValues1 = {Integer.parseInt(request.getParameter("externalfacilityordersid")), Boolean.TRUE, (Long) request.getSession().getAttribute("person_id")};
            String pk1 = "facilityorderid";
            Object pkValue1 = Long.parseLong(request.getParameter("facilityorderid"));
            int result1 = genericClassService.updateRecordSQLSchemaStyle(Facilityorder.class, columns1, columnValues1, pk1, pkValue1, "store");
            if (result1 != 0) {
                results = "success";
            }
            System.out.println("--------------------------------4");
        } else {
            System.out.println();
            String[] columns = {"orderstatus", "approvedby", "dateapproved"};
            Object[] columnValues = {"NOT APPROVED", (Long) request.getSession().getAttribute("person_id"), new Date()};
            String pk = "externalfacilityordersid";
            Object pkValue = Integer.parseInt(request.getParameter("externalfacilityordersid"));
            int result = genericClassService.updateRecordSQLSchemaStyle(Externalfacilityorders.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                results = "success";
            }
            System.out.println("--------------------------------5");
            String[] columns1 = {"externalfacilityordersid", "approved", "approvedby"};
            Object[] columnValues1 = {Integer.parseInt(request.getParameter("externalfacilityordersid")), Boolean.FALSE, (Long) request.getSession().getAttribute("person_id")};
            String pk1 = "facilityorderid";
            Object pkValue1 = Long.parseLong(request.getParameter("facilityorderid"));
            int result1 = genericClassService.updateRecordSQLSchemaStyle(Facilityorder.class, columns1, columnValues1, pk1, pkValue1, "store");
            if (result1 != 0) {
                results = "success";
            }
            System.out.println("-----------------------------6");
        }
        return results;
    }

    @RequestMapping(value = "/updateOrderDates", method = RequestMethod.GET)
    public String updateOrderDate(HttpServletRequest request, Model model, @ModelAttribute("externalfacilityordersid") int externalfacilityordersid, @ModelAttribute("orderingstart") String orderingstart, @ModelAttribute("orderingenddate") String orderingenddate, @ModelAttribute("approvalstartdate") String approvalstartdate, @ModelAttribute("approvalenddate") String approvalenddate) {

        model.addAttribute("externalfacilityordersid", externalfacilityordersid);
        model.addAttribute("orderingstart", orderingstart);
        model.addAttribute("orderingenddate", orderingenddate);
        model.addAttribute("approvalstartdate", approvalstartdate);
        model.addAttribute("approvalenddate", approvalenddate);

        return "controlPanel/localSettingsPanel/manageexternalorders/forms/updateOrderDates";
    }

    @RequestMapping(value = "/externalordersview.htm", method = RequestMethod.GET)
    public String externalordersview(Model model, HttpServletRequest request) {
        List<Map> ordersFound = new ArrayList<>();
        if ("a".equals(request.getParameter("act"))) {
            String[] params1 = {"originstore", "ordertype", "paused", "submitted"};
            Object[] paramsValues1 = {Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))), "EXTERNAL", "PAUSED", "SUBMITTED"};
            String where1 = "WHERE originstore=:originstore AND ordertype=:ordertype AND (status=:paused OR status=:submitted)";
            String[] fields1 = {"facilityorderid", "status", "facilityorderno", "preparedby", "externalfacilityordersid"};
            List<Object[]> externalordersincomplete = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fields1, where1, params1, paramsValues1);
            if (externalordersincomplete != null) {
                Map<String, Object> ordersRow;
                for (Object[] externalorder : externalordersincomplete) {
                    ordersRow = new HashMap<>();

                    ordersRow.put("facilityorderid", externalorder[0]);
                    ordersRow.put("status", externalorder[1]);

                    String[] params = {"externalfacilityordersid"};
                    Object[] paramsValues = {externalorder[4]};
                    String[] fields = {"neworderno", "supplierid"};
                    String where = "WHERE externalfacilityordersid=:externalfacilityordersid";
                    List<Object[]> facilityorderno = (List<Object[]>) genericClassService.fetchRecord(Externalfacilityorders.class, fields, where, params, paramsValues);
                    if (facilityorderno != null) {
                        ordersRow.put("neworderno", facilityorderno.get(0)[0]);

                        String[] params5 = {"supplierid"};
                        Object[] paramsValues5 = {facilityorderno.get(0)[1]};
                        String[] fields5 = {"suppliername"};
                        String where5 = "WHERE supplierid=:supplierid";
                        List<String> facilityordersupplier = (List<String>) genericClassService.fetchRecord(Supplier.class, fields5, where5, params5, paramsValues5);
                        if (facilityordersupplier != null) {
                            ordersRow.put("facilityordersuppliername", facilityordersupplier.get(0));
                        }
                    }

                    String[] params2 = {"personid"};
                    Object[] paramsValues2 = {externalorder[3]};
                    String[] fields2 = {"firstname", "othernames", "lastname"};
                    String where2 = "WHERE personid=:personid";
                    List<Object[]> facilityorderpersons = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields2, where2, params2, paramsValues2);
                    if (facilityorderpersons != null) {
                        ordersRow.put("name", facilityorderpersons.get(0)[0] + " " + facilityorderpersons.get(0)[1] + " " + facilityorderpersons.get(0)[2]);
                    }
                    int externalorderscomplete = 0;
                    String[] params3 = {"facilityorderid"};
                    Object[] paramsValues3 = {externalorder[0]};
                    String where3 = "WHERE facilityorderid=:facilityorderid";
                    externalorderscomplete = genericClassService.fetchRecordCount(Facilityorderitems.class, where3, params3, paramsValues3);

                    ordersRow.put("externalorderscomplete", externalorderscomplete);

                    ordersFound.add(ordersRow);
                }

            }
        }
        model.addAttribute("act", request.getParameter("act"));
        model.addAttribute("ordersFound", ordersFound);
        return "inventoryAndSupplies/orders/placeOrders/externalOrder/viewOrManageOrders/views/externalOrders";
    }

    @RequestMapping(value = "/facilityunitexternalorderitems.htm", method = RequestMethod.GET)
    public String facilityunitexternalorderitems(Model model, HttpServletRequest request) {
        List<Map> orderItemsFound = new ArrayList<>();
        String[] params1 = {"facilityorderid"};
        Object[] paramsValues1 = {Long.parseLong(request.getParameter("facilityorderid"))};
        String where1 = "WHERE facilityorderid=:facilityorderid";
        String[] fields1 = {"facilityorderitemsid", "qtyordered", "itemid"};
        List<Object[]> externalordersitems = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fields1, where1, params1, paramsValues1);
        if (externalordersitems != null) {
            Map<String, Object> itemsRow;
            for (Object[] externalordersitem : externalordersitems) {
                itemsRow = new HashMap<>();
                String[] params2 = {"itemid"};
                Object[] paramsValues2 = {externalordersitem[2]};
                String[] fields2 = {"fullname"};
                String where2 = "WHERE itemid=:itemid";
                List<String> facilityorderitems = (List<String>) genericClassService.fetchRecord(Itemcategories.class, fields2, where2, params2, paramsValues2);
                if (facilityorderitems != null) {
                    itemsRow.put("fullname", facilityorderitems.get(0));
                    itemsRow.put("quantityordered", externalordersitem[1]);
                    itemsRow.put("qtyordered", String.format("%,d", externalordersitem[1]));
                    itemsRow.put("facilityorderitemsid", externalordersitem[0]);
                    orderItemsFound.add(itemsRow);
                }
            }
        }
        model.addAttribute("orderItemsFound", orderItemsFound);
        model.addAttribute("status", request.getParameter("status"));
        model.addAttribute("facilityorderid", request.getParameter("facilityorderid"));
        return "inventoryAndSupplies/orders/placeOrders/externalOrder/viewOrManageOrders/forms/orderItems";
    }

    @RequestMapping(value = "/recallsubmittedExternalorder.htm")
    public @ResponseBody
    String recallsubmittedExternalorder(HttpServletRequest request) {
        String results = "";
        String[] columns = {"status"};
        Object[] columnValues = {"PAUSED"};
        String pk = "facilityorderid";
        Object pkValue = Long.parseLong(request.getParameter("facilityorderid"));
        int result = genericClassService.updateRecordSQLSchemaStyle(Facilityorder.class, columns, columnValues, pk, pkValue, "store");
        if (result != 0) {
            results = "success";
        }
        return results;
    }

    @RequestMapping(value = "/submitexternalorderforapproval.htm")
    public @ResponseBody
    String submitexternalorderforapproval(HttpServletRequest request) {
        String results = "";
        String[] columns = {"status"};
        Object[] columnValues = {"SUBMITTED"};
        String pk = "facilityorderid";
        Object pkValue = Long.parseLong(request.getParameter("facilityorderid"));
        int result = genericClassService.updateRecordSQLSchemaStyle(Facilityorder.class, columns, columnValues, pk, pkValue, "store");
        if (result != 0) {
            results = "success";
        }
        return results;
    }
}
