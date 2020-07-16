/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.controlpanel.Facilityunitsupplier;
import com.iics.controlpanel.Facilityunitsupplierschedule;
import com.iics.controlpanel.Schedule;
import com.iics.controlpanel.Stafffacilityunit;
import com.iics.domain.Facilityunit;
import com.iics.domain.Facilityunitservice;
import com.iics.domain.Person;
import com.iics.domain.Searchstaff;
import com.iics.domain.Staff;
import com.iics.domain.Systemuser;
import com.iics.service.GenericClassService;
import com.iics.store.Cellitems;
import com.iics.store.Facilitycatalogue;
import com.iics.store.Facilityorder;
import com.iics.store.Facilityorderitems;
import com.iics.store.Facilityunitprocurementplan;
import com.iics.store.Facilityunitstock;
import com.iics.store.Item;
import com.iics.store.Itempackage;
import com.iics.store.Orderissuance;
import com.iics.store.Shelfstock;
import com.iics.store.Stock;
import com.iics.store.Supplieritem;
import com.iics.store.Unitcatalogue;
import com.iics.store.Unitstoragezones;
import com.iics.store.Unservicedorder;
import com.iics.store.Unservicedorderitem;
import com.iics.utils.OsCheck;
import com.iics.utils.ShelfActivityLog;
import com.iics.utils.StockActivityLog;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.pdf.draw.LineSeparator;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigInteger;
import java.text.DateFormat;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
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
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author RESEARCH
 */
@Controller
@RequestMapping("/ordersmanagement")
public class OrdersManagement {

    NumberFormat decimalFormat = NumberFormat.getInstance();
    DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat format = new SimpleDateFormat("dd-MM-yyyy");
    DateFormat formatter2 = new SimpleDateFormat("yyyy-MM-dd");
    @Autowired
    GenericClassService genericClassService;
    private SimpleDateFormat formatterwithtime = new SimpleDateFormat("yyyy-MM-dd hh:mm aa");
    private Date serverDate = new Date();


    @RequestMapping(value = "/ordershomemenu.htm", method = RequestMethod.GET)
    public String OrdersHomeMenu(Model model, HttpServletRequest request) {
        String[] params = {"facilityunitid"};
        Object[] paramsValues = {(Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")};
        String[] fields = {"facilityunitname"};
        List<String> facilityname = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fields, "WHERE facilityunitid=:facilityunitid", params, paramsValues);
        if (facilityname != null) {
            model.addAttribute("loggedinfacilityname", facilityname.get(0));
        }
        return "inventoryAndSupplies/orders/ordersHomeMenu";
    }

    @RequestMapping(value = "/viewormanageorder.htm", method = RequestMethod.GET)
    public String viewormanageorder(Model model, HttpServletRequest request) {

        String[] params6 = {"facilityunitid"};
        Object[] paramsValues6 = {Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))};
        String[] fields6 = {"facilityunitname", "shortname"};
        List<Object[]> facilityunitlog = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields6, "WHERE facilityunitid=:facilityunitid", params6, paramsValues6);
        if (facilityunitlog != null) {
            model.addAttribute("facilityunitname", facilityunitlog.get(0)[0]);
        }
        String[] params = {"originstore", "approved", "ordertype", "status"};
        Object[] paramsValues = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), Boolean.TRUE, "INTERNAL", "DELIVERED"};
        String where = "WHERE originstore=:originstore AND approved=:approved AND ordertype=:ordertype AND status=:status";
        int internalorderscomplete = genericClassService.fetchRecordCount(Facilityorder.class, where, params, paramsValues);
        model.addAttribute("internalorderscomplete", internalorderscomplete);

        String[] params1 = {"originstore", "ordertype", "paused", "submitted", "sent", "serviced", "picked"};
        Object[] paramsValues1 = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), "INTERNAL", "PAUSED", "SUBMITTED", "SENT", "SERVICED", "PICKED"};
        String where1 = "WHERE originstore=:originstore AND ordertype=:ordertype AND (status=:paused OR status=:submitted OR status=:sent OR status=:serviced OR status=:picked)";
        int internalordersincomplete = genericClassService.fetchRecordCount(Facilityorder.class, where1, params1, paramsValues1);
        model.addAttribute("internalordersincomplete", internalordersincomplete);

        model.addAttribute("totalinternalorders", internalordersincomplete + internalorderscomplete);

        String[] params2 = {"originstore", "ordertype", "paused", "submitted"};
        Object[] paramsValues2 = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), "EXTERNAL", "PAUSED", "SUBMITTED"};
        String where2 = "WHERE originstore=:originstore AND ordertype=:ordertype AND (status=:paused OR status=:submitted)";
        int externalordersincomplete = genericClassService.fetchRecordCount(Facilityorder.class, where2, params2, paramsValues2);
        model.addAttribute("externalordersincomplete", externalordersincomplete);

        String[] params5 = {"originstore", "approved", "ordertype", "status"};
        Object[] paramsValues5 = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), Boolean.TRUE, "EXTERNAL", "PICKED"};
        String where5 = "WHERE originstore=:originstore AND approved=:approved AND ordertype=:ordertype AND status=:status";
        int externalorderscomplete = genericClassService.fetchRecordCount(Facilityorder.class, where5, params5, paramsValues5);
        model.addAttribute("externalorderscomplete", externalorderscomplete);

        model.addAttribute("totalexternalorders", externalorderscomplete + externalordersincomplete);
        return "inventoryAndSupplies/orders/placeOrders/internalOrder/viewOrManageOrders/viewOrManageOrder";
    }

    @RequestMapping(value = "/placeordershome.htm", method = RequestMethod.GET)
    public String PlaceOrdersHome(Model model, HttpServletRequest request) {
        List<Map> orderlist = new ArrayList<>();
        Set<Long> storeunits = new HashSet<>();

        String[] params1 = {"facilityunitid", "isactive", "suppliertype"};
        Object[] paramsValues1 = {(Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"), Boolean.TRUE, "internal"};
        String[] fields1 = {"facilityunitsupplierid", "supplierid"};
        List<Object[]> facilityunit1 = (List<Object[]>) genericClassService.fetchRecord(Facilityunitsupplier.class, fields1, "WHERE facilityunitid=:facilityunitid AND isactive=:isactive AND suppliertype=:suppliertype", params1, paramsValues1);
        if (facilityunit1 != null) {
            for (Object[] facilityunt : facilityunit1) {
                storeunits.add((Long) facilityunt[1]);
            }

        }

        String[] params = {"facility", "status", "servicekey"};
        Object[] paramsValues = {request.getSession().getAttribute("sessionActiveLoginFacility"), Boolean.TRUE, "key_suppliyunitstore"};
        String[] fields = {"facilityservices.serviceid", "facilityunit.facilityunitid"};
        String where = "WHERE r.facilityunit.facilityid=:facility AND status=:status AND r.facilityservices.servicekey=:servicekey";
        List<Object[]> facilityunitservicesLists = (List<Object[]>) genericClassService.fetchRecord(Facilityunitservice.class, fields, where, params, paramsValues);
        if (facilityunitservicesLists != null) {
            for (Object[] facilityunitservice : facilityunitservicesLists) {
                if (storeunits.isEmpty() || !storeunits.contains((Long) facilityunitservice[1])) {
                    Facilityunitsupplier facilityunitsupplier = new Facilityunitsupplier();
                    facilityunitsupplier.setAddedby((Long) request.getSession().getAttribute("person_id"));
                    facilityunitsupplier.setDateadded(new Date());
                    facilityunitsupplier.setIsactive(Boolean.TRUE);
                    facilityunitsupplier.setSuppliertype("internal");
                    facilityunitsupplier.setSupplierid((Long) facilityunitservice[1]);
                    facilityunitsupplier.setFacilityunitid(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))));
                    facilityunitsupplier.setStatus("approved");
                    genericClassService.saveOrUpdateRecordLoadObject(facilityunitsupplier);
                }
            }
        }
        String[] params2 = {"facilityunitid", "status", "isactive", "suppliertype"};
        Object[] paramsValues2 = {Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))), "approved", Boolean.TRUE, "internal"};
        String[] fields2 = {"facilityunitsupplierid", "supplierid"};
        List<Object[]> facilityunit2 = (List<Object[]>) genericClassService.fetchRecord(Facilityunitsupplier.class, fields2, "WHERE facilityunitid=:facilityunitid AND status=:status AND isactive=:isactive AND suppliertype=:suppliertype", params2, paramsValues2);
        if (facilityunit2 != null) {
            Map<String, Object> orderListRow;
            for (Object[] fac : facilityunit2) {
                orderListRow = new HashMap<>();
                String[] params3 = {"facilityunitid"};
                Object[] paramsValues3 = {fac[1]};
                String[] fields3 = {"facilityunitname"};
                List<String> facilityunit3 = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fields3, "WHERE facilityunitid=:facilityunitid", params3, paramsValues3);
                if (facilityunit3 != null) {
                    orderListRow.put("facilityunitname", facilityunit3.get(0));
                    orderListRow.put("facilityunitsupplierid", fac[1]);
                    orderlist.add(orderListRow);
                }
            }
        }
        String[] params6 = {"facilityunitid"};
        Object[] paramsValues6 = {Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))};
        String[] fields6 = {"facilityunitname"};
        List<String> facilityunitlog = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fields6, "WHERE facilityunitid=:facilityunitid", params6, paramsValues6);
        if (facilityunitlog != null) {
            model.addAttribute("loggedinfacilityunitname", facilityunitlog.get(0));
        }
        model.addAttribute("orderlist", orderlist);

        String[] params7 = {"facilityunitid", "catitemstatus", "isactive"};
        Object[] paramsValues7 = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), "APPROVED", Boolean.TRUE};
        String[] fields7 = {"unitcatalogueitemid", "packagename"};
        List<Object[]> facilitylog = (List<Object[]>) genericClassService.fetchRecord(Unitcatalogue.class, fields7, "WHERE facilityunitid=:facilityunitid AND catitemstatus=:catitemstatus AND isactive=:isactive", params7, paramsValues7);
        if (facilitylog != null) {
            model.addAttribute("catalogue", "unitcatalogue");
        } else {
            model.addAttribute("catalogue", "nounitcatalogue");
        }
        String[] params8 = {"facilityunitid"};
        Object[] paramsValues8 = {Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))};
        String[] fields8 = {"zoneid"};
        List<Integer> zone = (List<Integer>) genericClassService.fetchRecord(Unitstoragezones.class, fields8, "WHERE facilityunitid=:facilityunitid", params8, paramsValues8);
        if (zone == null) {
            model.addAttribute("zone", "nozone");
        }
        model.addAttribute("serverdate", formatterwithtime.format(serverDate));
        return "inventoryAndSupplies/orders/placeOrders/placeOrdersHome";
    }

    private String generatefacilityorderno(String facilityunit, BigInteger originstoreid) {
        String name = facilityunit + "/";
        SimpleDateFormat f = new SimpleDateFormat("yyMM");
        String pattern = name + f.format(new Date()) + "/%";
        String facilityorderno = "";

        String[] params = {"originstore", "facilityorderno"};
        Object[] paramsValues = {originstoreid, pattern};
        String[] fields = {"facilityorderno"};
        String where = "WHERE originstore=:originstore AND facilityorderno LIKE :facilityorderno ORDER BY facilityorderno DESC LIMIT 1";
        List<String> lastFacilityorderno = (List<String>) genericClassService.fetchRecord(Facilityorder.class, fields, where, params, paramsValues);
        if (lastFacilityorderno == null) {
            facilityorderno = name + f.format(new Date()) + "/0001";
            return facilityorderno;
        } else {
            try {
                int lastNo = Integer.parseInt(lastFacilityorderno.get(0).split("\\/")[2]);
                String newNo = String.valueOf(lastNo + 1);
                switch (newNo.length()) {
                    case 1:
                        facilityorderno = name + f.format(new Date()) + "/000" + newNo;
                        break;
                    case 2:
                        facilityorderno = name + f.format(new Date()) + "/00" + newNo;
                        break;
                    case 3:
                        facilityorderno = name + f.format(new Date()) + "/0" + newNo;
                        break;
                    default:
                        facilityorderno = name + f.format(new Date()) + "/" + newNo;
                        break;
                }
            } catch (NumberFormatException e) {
                System.out.println(e);
            }
        }
        return facilityorderno;
    }

    @RequestMapping(value = "/savepausedorsubmittedfacilityunitorder.htm")
    public @ResponseBody
    String savepausedorsubmittedfacilityunitorder(HttpServletRequest request) {
        String results = "";
        try {
            Facilityorder facilityorder = new Facilityorder();

            facilityorder.setPreparedby(BigInteger.valueOf((Long) request.getSession().getAttribute("person_id")));
            facilityorder.setOriginstore(BigInteger.valueOf(((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")).longValue()));
            facilityorder.setOrdertype("INTERNAL");
            facilityorder.setDateprepared(formatter.parse(request.getParameter("orderdatecreated").replaceAll("/", "-")));
            facilityorder.setDestinationstore(BigInteger.valueOf(Long.parseLong(request.getParameter("facilityunitsupplierid"))));
            facilityorder.setFacilityorderno(request.getParameter("ordernumber"));
            if ("Yes".equals(request.getParameter("ordercriteria"))) {
                facilityorder.setDateneeded(new Date());
                facilityorder.setIsemergency(Boolean.TRUE);
            } else {
                facilityorder.setIsemergency(Boolean.FALSE);
                facilityorder.setDateneeded(formatter.parse(request.getParameter("dateneeded").replaceAll("/", "-")));
            }
            if ("paused".equals(request.getParameter("type"))) {
                facilityorder.setStatus("PAUSED");
            } else {
                facilityorder.setStatus("SUBMITTED");
            }
            Object save = genericClassService.saveOrUpdateRecordLoadObject(facilityorder);
            if (save != null) {
                List<Map> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("values"), List.class);
                for (Map item1 : item) {
                    Map<String, Object> map = (HashMap) item1;
                    Facilityorderitems facilityorderitems = new Facilityorderitems();
                    facilityorderitems.setFacilityorderid(facilityorder);
                    facilityorderitems.setApproved(Boolean.FALSE);
                    facilityorderitems.setQtyapproved(BigInteger.valueOf(Long.parseLong((String) map.get("qty"))));
                    facilityorderitems.setQtyordered(BigInteger.valueOf(Long.parseLong((String) map.get("qty"))));
                    facilityorderitems.setItemid(new Item(((Integer) map.get("itemid")).longValue()));
                    genericClassService.saveOrUpdateRecordLoadObject(facilityorderitems);
                }
            }
        } catch (IOException | ParseException e) {
            System.out.println(":::::::::::::::::::::::::::"+e);
        }
        return results;
    }

    @RequestMapping(value = "/internalordersview.htm", method = RequestMethod.GET)
    public String internalordersview(Model model, HttpServletRequest request) {
        List<Map> ordersFound = new ArrayList<>();
        if ("a".equals(request.getParameter("act"))) {
            String[] params1 = {"originstore", "ordertype", "paused", "submitted", "sent", "serviced", "picked"};
            Object[] paramsValues1 = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), "INTERNAL", "PAUSED", "SUBMITTED", "SENT", "SERVICED", "PICKED"};
            String where1 = "WHERE originstore=:originstore AND ordertype=:ordertype AND (status=:paused OR status=:submitted OR status=:sent OR status=:serviced OR status=:picked)";
            String[] fields1 = {"facilityorderid", "status", "facilityorderno", "dateneeded", "dateprepared", "preparedby", "destinationstore", "isemergency"};
            List<Object[]> internalordersincomplete = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fields1, where1, params1, paramsValues1);
            if (internalordersincomplete != null) {
                Map<String, Object> internalordersincompleteRow;
                for (Object[] iternalorder : internalordersincomplete) {

                    internalordersincompleteRow = new HashMap<>();
                    int internalordersitemscount = 0;
                    String[] params = {"facilityorderid"};
                    Object[] paramsValues = {iternalorder[0]};
                    String where = "WHERE facilityorderid=:facilityorderid";
                    internalordersitemscount = genericClassService.fetchRecordCount(Facilityorderitems.class, where, params, paramsValues);

                    internalordersincompleteRow.put("internalordersitemscount", internalordersitemscount);
                    internalordersincompleteRow.put("facilityorderno", iternalorder[2]);
                    internalordersincompleteRow.put("criteria", iternalorder[7]);
                    internalordersincompleteRow.put("status", iternalorder[1]);
                    internalordersincompleteRow.put("facilityorderid", iternalorder[0]);
                    internalordersincompleteRow.put("dateneeded", formatter.format((Date) iternalorder[3]));
                    internalordersincompleteRow.put("dateprepared", formatter.format((Date) iternalorder[4]));

                    String[] params4 = {"facilityunitid"};
                    Object[] paramsValues4 = {iternalorder[6]};
                    String where4 = "WHERE facilityunitid=:facilityunitid";
                    String[] fields4 = {"facilityunitname", "shortname"};
                    List<Object[]> facilitysuppliername = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields4, where4, params4, paramsValues4);
                    if (facilitysuppliername != null) {
                        internalordersincompleteRow.put("facilitysuppliername", facilitysuppliername.get(0)[0]);
                        internalordersincompleteRow.put("shortname", facilitysuppliername.get(0)[1]);
                    }
                    String[] params7 = {"personid"};
                    Object[] paramsValues7 = {iternalorder[5]};
                    String[] fields7 = {"firstname", "lastname"};
                    List<Object[]> preparedby = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields7, "WHERE personid=:personid", params7, paramsValues7);
                    if (preparedby != null) {
                        internalordersincompleteRow.put("personname", preparedby.get(0)[0] + " " + preparedby.get(0)[1]);
                    }
                    ordersFound.add(internalordersincompleteRow);
                }

            }

        } else {
            String[] params1 = {"originstore", "ordertype", "approved", "status"};
            Object[] paramsValues1 = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), "INTERNAL", Boolean.TRUE, "DELIVERED"};
            String where1 = "WHERE originstore=:originstore AND ordertype=:ordertype AND approved=:approved AND status=:status";
            String[] fields1 = {"facilityorderid", "status", "facilityorderno", "dateneeded", "dateprepared", "preparedby", "destinationstore"};
            List<Object[]> internalordersincomplete = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fields1, where1, params1, paramsValues1);
            if (internalordersincomplete != null) {
                Map<String, Object> internalordersincompleteRow;
                for (Object[] iternalorder : internalordersincomplete) {

                    internalordersincompleteRow = new HashMap<>();
                    int internalordersitemscount = 0;
                    String[] params = {"facilityorderid"};
                    Object[] paramsValues = {(Long) iternalorder[0]};
                    String where = "WHERE facilityorderid=:facilityorderid";
                    internalordersitemscount = genericClassService.fetchRecordCount(Facilityorderitems.class, where, params, paramsValues);

                    internalordersincompleteRow.put("internalordersitemscount", internalordersitemscount);
                    internalordersincompleteRow.put("facilityorderno", iternalorder[2]);
                    internalordersincompleteRow.put("status", iternalorder[1]);
                    internalordersincompleteRow.put("facilityorderid", iternalorder[0]);
                    internalordersincompleteRow.put("dateneeded", formatter.format((Date) iternalorder[3]));
                    internalordersincompleteRow.put("dateprepared", formatter.format((Date) iternalorder[4]));

                    String[] params4 = {"facilityunitid"};
                    Object[] paramsValues4 = {iternalorder[6]};
                    String where4 = "WHERE facilityunitid=:facilityunitid";
                    String[] fields4 = {"facilityunitname", "shortname"};
                    List<Object[]> facilitysuppliername = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields4, where4, params4, paramsValues4);
                    if (facilitysuppliername != null) {
                        internalordersincompleteRow.put("facilitysuppliername", facilitysuppliername.get(0)[0]);
                        internalordersincompleteRow.put("shortname", facilitysuppliername.get(0)[1]);
                    }
                    String[] params7 = {"personid"};
                    Object[] paramsValues7 = {iternalorder[5]};
                    String[] fields7 = {"firstname", "lastname"};
                    List<Object[]> preparedby = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields7, "WHERE personid=:personid", params7, paramsValues7);
                    if (preparedby != null) {
                        internalordersincompleteRow.put("personname", preparedby.get(0)[0] + " " + preparedby.get(0)[1]);
                    }
                    ordersFound.add(internalordersincompleteRow);
                }
            }
        }
        model.addAttribute("ordersFound", ordersFound);
        model.addAttribute("act", request.getParameter("act"));
        return "inventoryAndSupplies/orders/placeOrders/internalOrder/viewOrManageOrders/incopleteAndCompleteOrders/views/orders";
    }

    @RequestMapping(value = "/pausedfacilityorderitems.htm", method = RequestMethod.GET)
    public String pausedfacilityorderitems(Model model, HttpServletRequest request) {
        List<Map> itemsFound = new ArrayList<>();
        String[] params4 = {"facilityorderid"};
        Object[] paramsValues4 = {Long.parseLong(request.getParameter("facilityorderid"))};
        String where4 = "WHERE facilityorderid=:facilityorderid";
        String[] fields4 = {"facilityorderitemsid", "qtyordered", "itemid.itemid"};
        List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fields4, where4, params4, paramsValues4);
        if (items != null) {
            Map<String, Object> internalordersitemsRow;
            for (Object[] item : items) {
                internalordersitemsRow = new HashMap<>();
                String[] params7 = {"itempackageid"};
                Object[] paramsValues7 = {item[2]};
                String[] fields7 = {"packagename", "packagequantity", "itemstrength"};
                List<Object[]> itemdetalis = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields7, "WHERE itempackageid=:itempackageid", params7, paramsValues7);
                if (itemdetalis != null) {
                    internalordersitemsRow.put("genericname", itemdetalis.get(0)[0]);
                    internalordersitemsRow.put("packsize", itemdetalis.get(0)[1]);
                    internalordersitemsRow.put("itemstrength", itemdetalis.get(0)[2]);
                    internalordersitemsRow.put("facilityorderitemsid", item[0]);
                    internalordersitemsRow.put("qtyordered", item[1]);
                    internalordersitemsRow.put("itemid", item[2]);
                    itemsFound.add(internalordersitemsRow);
                }
            }
        }
        model.addAttribute("facilityorderid", request.getParameter("facilityorderid"));
        model.addAttribute("itemsFound", itemsFound);
        model.addAttribute("facilityorderno", request.getParameter("facilityorderno"));

        model.addAttribute("facilitysuppliername", request.getParameter("facilitysuppliername"));
        model.addAttribute("internalordersitemscount", request.getParameter("internalordersitemscount"));
        model.addAttribute("dateneeded", request.getParameter("dateneeded"));
        model.addAttribute("dateprepared", request.getParameter("dateprepared"));
        model.addAttribute("personname", request.getParameter("personname"));
        model.addAttribute("orderstage", request.getParameter("orderstage"));
        model.addAttribute("criteria", request.getParameter("criteria"));

        String[] params = {"facilityunitid"};
        Object[] paramsValues = {Long.parseLong(String.valueOf((int) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))};
        String where = "WHERE facilityunitid=:facilityunitid";
        String[] fields = {"facilityunitname", "shortname"};
        List<Object[]> originorder = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields, where, params, paramsValues);
        if (originorder != null) {
            model.addAttribute("originorder", originorder.get(0)[0]);
        }
        return "inventoryAndSupplies/orders/placeOrders/internalOrder/viewOrManageOrders/incopleteAndCompleteOrders/views/items";
    }

    @RequestMapping(value = "/removeitemfromfacilityunitorder.htm")
    public @ResponseBody
    String removeitemfromfacilityunitorder(HttpServletRequest request) {
        String results = "";
        String[] columns = {"facilityorderitemsid"};
        Object[] columnValues = {Long.parseLong(request.getParameter("facilityorderitemsid"))};
        int result = genericClassService.deleteRecordByByColumns("store.facilityorderitems", columns, columnValues);
        if (result != 0) {
            results = "success";
        }
        return results;
    }

    @RequestMapping(value = "/saveorsubmitpausedfacilityunitorders.htm")
    public @ResponseBody
    String saveorsubmitpausedfacilityunitorders(HttpServletRequest request) {
        String results = "";
        if ("save".equals(request.getParameter("type"))) {
            String[] columns = {"status"};
            Object[] columnValues = {"SUBMITTED"};
            String pk = "facilityorderid";
            Object pkValue = Long.parseLong(request.getParameter("facilityorderid"));
            int result = genericClassService.updateRecordSQLSchemaStyle(Facilityorder.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                results = "success";
            }
        } else {
            String[] columns = {"status"};
            Object[] columnValues = {"PAUSED"};
            String pk = "facilityorderid";
            Object pkValue = Long.parseLong(request.getParameter("facilityorderid"));
            int result = genericClassService.updateRecordSQLSchemaStyle(Facilityorder.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                results = "success";
            }
        }
        return results;
    }

    @RequestMapping(value = "/orderprocessmainpage", method = RequestMethod.GET)
    public String orderProcessMainPage(Model model, HttpServletRequest request) {
        //Fetch Today's Sent Orders
        List<String> scheduleDays = new ArrayList<>();
        List<Map> todaysOrders = new ArrayList<>();
        Date now = new Date();

//        //Fetch Facilityunitsupplierschedule
//        String[] paramsfunitsuppschedu2 = {"facilityunitid"};
//        Object[] paramsValuesfunitsuppschedu2 = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))))};
//        String[] fieldsfunitsuppschedu2 = {"scheduleid"};
//        String wherefunitsuppschedu2 = "WHERE facilityunitid=:facilityunitid";
//        List<Object> objFunitsuppschedu2 = (List<Object>) genericClassService.fetchRecord(Facilityunitschedule.class, fieldsfunitsuppschedu2, wherefunitsuppschedu2, paramsfunitsuppschedu2, paramsValuesfunitsuppschedu2);
//        if (objFunitsuppschedu2 != null) {
//            for (Object day : objFunitsuppschedu2) {
//                scheduleDays.add(day.toString());
//            }
//
//            if (scheduleDays.contains(String.valueOf(now.getDay()))) {
//                //Fetch Facility Orders
//                String[] paramsfacilityunittodayorders = {"destinationstore", "status", "isemergency"};
//                Object[] paramsValuesfacilitunittodayorders = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), "SENT", Boolean.FALSE};
//                String[] fieldsunittodayorders = {"facilityorderid", "facilityorderno", "ordertype", "originstore", "isemergency", "dateprepared", "dateneeded", "approvedby", "status", "preparedby"};
//                String whereunittodayorders = "WHERE destinationstore=:destinationstore AND status=:status AND isemergency=:isemergency";
//                List<Object[]> objunittodayorders = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fieldsunittodayorders, whereunittodayorders, paramsfacilityunittodayorders, paramsValuesfacilitunittodayorders);
//                Map<String, Object> unittodayorders;
//                if (objunittodayorders != null) {
//                    for (Object[] ord : objunittodayorders) {
//                        unittodayorders = new HashMap<>();
//                        unittodayorders.put("dateneeded", format.format((Date) ord[6]));
//                        unittodayorders.put("facilityorderid", ord[0]);
//                        unittodayorders.put("facilityorderno", (String) ord[1]);
//                        unittodayorders.put("ordertype", (String) ord[2]);
//                        unittodayorders.put("originstore", ord[3]);
//                        unittodayorders.put("isemergency", "false");
//
//                        //Fetch Facility Units
//                        String[] paramsfunits = {"facilityunitid"};
//                        Object[] paramsValuesfunit = {ord[3]};
//                        String wherefunit = "WHERE facilityunitid=:facilityunitid";
//                        String[] fieldsfunit = {"facilityunitname"};
//                        List<String> facilityunitnames = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fieldsfunit, wherefunit, paramsfunits, paramsValuesfunit);
//                        if (facilityunitnames != null) {
//                            unittodayorders.put("orderingUnit", facilityunitnames.get(0));
//                        }
//
//                        //Fetch Order Items number
//                        int noOfItems = 0;
//                        String[] paramsnumberofitems = {"facilityorderid"};
//                        Object[] paramsValuesnumberofitems = {ord[0]};
//                        String wherenumberofitems = "WHERE facilityorderid=:facilityorderid";
//                        noOfItems = genericClassService.fetchRecordCount(Facilityorderitems.class, wherenumberofitems, paramsnumberofitems, paramsValuesnumberofitems);
//                        unittodayorders.put("numberofitems", noOfItems);
//
//                        unittodayorders.put("dateprepared", format.format((Date) ord[5]));
//                        if (ord[7] != null) {
//                            if (ord[7] != null) {
//                                String[] paramsApprovedby = {"personid"};
//                                Object[] paramsValuesApprovedby = {ord[7]};
//                                String[] fieldsApprovedby = {"personid", "firstname", "lastname", "othernames"};
//                                String where7 = "WHERE personid=:personid";
//                                List<Object[]> objApprov = (List<Object[]>) genericClassService.fetchRecord(Person.class, fieldsApprovedby, where7, paramsApprovedby, paramsValuesApprovedby);
//                                if (objApprov != null) {
//                                    Object[] approvedby = objApprov.get(0);
//                                    if (approvedby[3] != null) {
//                                        unittodayorders.put("approvedby", (String) approvedby[1] + " " + (String) approvedby[2] + " " + (String) approvedby[3]);
//                                    } else {
//                                        unittodayorders.put("approvedby", (String) approvedby[1] + " " + (String) approvedby[2]);
//                                    }
//                                }
//                            }
//                        }
//
//                        if (ord[9] != null) {
//                            String[] paramsPreparedby = {"personid"};
//                            Object[] paramsValuesPreparedby = {ord[9]};
//                            String[] fieldsPreparedby = {"personid", "firstname", "lastname", "othernames"};
//                            String where7 = "WHERE personid=:personid";
//                            List<Object[]> objPrepered = (List<Object[]>) genericClassService.fetchRecord(Person.class, fieldsPreparedby, where7, paramsPreparedby, paramsValuesPreparedby);
//                            if (objPrepered != null) {
//                                Object[] Preparedby = objPrepered.get(0);
//                                if (Preparedby[3] != null) {
//                                    unittodayorders.put("preparedby", (String) Preparedby[1] + " " + (String) Preparedby[2] + " " + (String) Preparedby[3]);
//                                } else {
//                                    unittodayorders.put("preparedby", (String) Preparedby[1] + " " + (String) Preparedby[2]);
//                                }
//                            }
//                        }
//
//                        todaysOrders.add(unittodayorders);
//                    }
//                }
//            }
//        } else {
//            //Fetch Facility Orders with supplieir unit that has no schedule days
//            String[] paramsfacilityunittodayorders3 = {"destinationstore", "status", "isemergency"};
//            Object[] paramsValuesfacilitunittodayorders3 = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), "SENT", Boolean.FALSE};
//            String[] fieldsunittodayorders3 = {"facilityorderid", "facilityorderno", "ordertype", "originstore", "isemergency", "dateprepared", "dateneeded", "approvedby", "status", "preparedby"};
//            String whereunittodayorders3 = "WHERE destinationstore=:destinationstore AND status=:status AND isemergency=:isemergency";
//            List<Object[]> objunittodayorders3 = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fieldsunittodayorders3, whereunittodayorders3, paramsfacilityunittodayorders3, paramsValuesfacilitunittodayorders3);
//            Map<String, Object> unittodayorders3;
//            if (objunittodayorders3 != null) {
//                for (Object[] ord : objunittodayorders3) {
//
//                    unittodayorders3 = new HashMap<>();
//                    unittodayorders3.put("dateneeded", format.format((Date) ord[6]));
//                    unittodayorders3.put("facilityorderid", ord[0]);
//                    unittodayorders3.put("facilityorderno", (String) ord[1]);
//                    unittodayorders3.put("ordertype", (String) ord[2]);
//                    unittodayorders3.put("originstore", ord[3]);
//                    unittodayorders3.put("isemergency", "false");
//
//                    //Fetch Facility Units
//                    String[] paramsfunits3 = {"facilityunitid"};
//                    Object[] paramsValuesfunit3 = {ord[3]};
//                    String wherefunit3 = "WHERE facilityunitid=:facilityunitid";
//                    String[] fieldsfunit3 = {"facilityunitname"};
//                    List<String> facilityunitnames3 = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fieldsfunit3, wherefunit3, paramsfunits3, paramsValuesfunit3);
//                    if (facilityunitnames3 != null) {
//                        unittodayorders3.put("orderingUnit", facilityunitnames3.get(0));
//                    }
//
//                    //Fetch Order Items number
//                    int noOfItems3 = 0;
//                    String[] paramsnumberofitems3 = {"facilityorderid"};
//                    Object[] paramsValuesnumberofitems3 = {ord[0]};
//                    String wherenumberofitems3 = "WHERE facilityorderid=:facilityorderid";
//                    noOfItems3 = genericClassService.fetchRecordCount(Facilityorderitems.class, wherenumberofitems3, paramsnumberofitems3, paramsValuesnumberofitems3);
//                    unittodayorders3.put("numberofitems", noOfItems3);
//
//                    unittodayorders3.put("dateprepared", format.format((Date) ord[5]));
//                    if (ord[7] != null) {
//                        if (ord[7] != null) {
//                            String[] paramsApprovedby3 = {"personid"};
//                            Object[] paramsValuesApprovedby3 = {ord[7]};
//                            String[] fieldsApprovedby3 = {"personid", "firstname", "lastname", "othernames"};
//                            String where73 = "WHERE personid=:personid";
//                            List<Object[]> objApprov3 = (List<Object[]>) genericClassService.fetchRecord(Person.class, fieldsApprovedby3, where73, paramsApprovedby3, paramsValuesApprovedby3);
//                            if (objApprov3 != null) {
//                                Object[] approvedby3 = objApprov3.get(0);
//                                if (approvedby3[3] != null) {
//                                    unittodayorders3.put("approvedby", (String) approvedby3[1] + " " + (String) approvedby3[2] + " " + (String) approvedby3[3]);
//                                } else {
//                                    unittodayorders3.put("approvedby", (String) approvedby3[1] + " " + (String) approvedby3[2]);
//                                }
//                            }
//                        }
//                    }
//
//                    if (ord[9] != null) {
//                        String[] paramsPreparedby3 = {"personid"};
//                        Object[] paramsValuesPreparedby3 = {ord[9]};
//                        String[] fieldsPreparedby3 = {"personid", "firstname", "lastname", "othernames"};
//                        String where73 = "WHERE personid=:personid";
//                        List<Object[]> objPrepered3 = (List<Object[]>) genericClassService.fetchRecord(Person.class, fieldsPreparedby3, where73, paramsPreparedby3, paramsValuesPreparedby3);
//                        if (objPrepered3 != null) {
//                            Object[] Preparedby3 = objPrepered3.get(0);
//                            if (Preparedby3[3] != null) {
//                                unittodayorders3.put("preparedby", (String) Preparedby3[1] + " " + (String) Preparedby3[2] + " " + (String) Preparedby3[3]);
//                            } else {
//                                unittodayorders3.put("preparedby", (String) Preparedby3[1] + " " + (String) Preparedby3[2]);
//                            }
//                        }
//                    }
//                    todaysOrders.add(unittodayorders3);
//                }
//            }
//        }
//Fetch Facility Orders
                System.out.println("------------HAS scheduleDays Contains::::::::: "+String.valueOf(now.getDay()));
                String[] paramsfacilityunittodayorders = {"destinationstore", "status", "isemergency"};
                Object[] paramsValuesfacilitunittodayorders = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), "SENT", Boolean.FALSE};
                String[] fieldsunittodayorders = {"facilityorderid", "facilityorderno", "ordertype", "originstore", "isemergency", "dateprepared", "dateneeded", "approvedby", "status", "preparedby"};
                String whereunittodayorders = "WHERE destinationstore=:destinationstore AND status=:status AND isemergency=:isemergency AND dateneeded=current_date";
                List<Object[]> objunittodayorders = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fieldsunittodayorders, whereunittodayorders, paramsfacilityunittodayorders, paramsValuesfacilitunittodayorders);
                Map<String, Object> unittodayorders;
                if (objunittodayorders != null) {
                    for (Object[] ord : objunittodayorders) {
                        unittodayorders = new HashMap<>();
                        unittodayorders.put("dateprepared", format.format((Date) ord[5]));
                        unittodayorders.put("dateneeded", format.format((Date) ord[6]));
                        unittodayorders.put("facilityorderid", ord[0]);
                        unittodayorders.put("facilityorderno", (String) ord[1]);
                        unittodayorders.put("ordertype", (String) ord[2]);
                        unittodayorders.put("originstore", ord[3]);
                        unittodayorders.put("isemergency", "false");

                        //Fetch Facility Units
                        String[] paramsfunits = {"facilityunitid"};
                        Object[] paramsValuesfunit = {ord[3]};
                        String wherefunit = "WHERE facilityunitid=:facilityunitid";
                        String[] fieldsfunit = {"facilityunitname"};
                        List<String> facilityunitnames = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fieldsfunit, wherefunit, paramsfunits, paramsValuesfunit);
                        if (facilityunitnames != null) {
                            unittodayorders.put("orderingUnit", facilityunitnames.get(0));
                        }
                        //
                        unittodayorders.put("orderingunitid", ord[3]);
                        //
                        //Fetch Order Items number
                        int noOfItems = 0;
                        String[] paramsnumberofitems = {"facilityorderid"};
                        Object[] paramsValuesnumberofitems = {ord[0]};
//                        String wherenumberofitems = "WHERE facilityorderid=:facilityorderid";
                        String wherenumberofitems = "WHERE facilityorderid=:facilityorderid AND approved=true";
                        noOfItems = genericClassService.fetchRecordCount(Facilityorderitems.class, wherenumberofitems, paramsnumberofitems, paramsValuesnumberofitems);
                        unittodayorders.put("numberofitems", noOfItems);

                        unittodayorders.put("dateprepared", format.format((Date) ord[5]));
                        if (ord[7] != null) {
                            if (ord[7] != null) {
                                String[] paramsApprovedby = {"personid"};
                                Object[] paramsValuesApprovedby = {ord[7]};
                                String[] fieldsApprovedby = {"personid", "firstname", "lastname", "othernames"};
                                String where7 = "WHERE personid=:personid";
                                List<Object[]> objApprov = (List<Object[]>) genericClassService.fetchRecord(Person.class, fieldsApprovedby, where7, paramsApprovedby, paramsValuesApprovedby);
                                if (objApprov != null) {
                                    Object[] approvedby = objApprov.get(0);
                                    if (approvedby[3] != null) {
                                        unittodayorders.put("approvedby", (String) approvedby[1] + " " + (String) approvedby[2] + " " + (String) approvedby[3]);
                                    } else {
                                        unittodayorders.put("approvedby", (String) approvedby[1] + " " + (String) approvedby[2]);
                                    }
                                }
                            }
                        }

                        if (ord[9] != null) {
                            String[] paramsPreparedby = {"personid"};
                            Object[] paramsValuesPreparedby = {ord[9]};
                            String[] fieldsPreparedby = {"personid", "firstname", "lastname", "othernames"};
                            String where7 = "WHERE personid=:personid";
                            List<Object[]> objPrepered = (List<Object[]>) genericClassService.fetchRecord(Person.class, fieldsPreparedby, where7, paramsPreparedby, paramsValuesPreparedby);
                            if (objPrepered != null) {
                                Object[] Preparedby = objPrepered.get(0);
                                if (Preparedby[3] != null) {
                                    unittodayorders.put("preparedby", (String) Preparedby[1] + " " + (String) Preparedby[2] + " " + (String) Preparedby[3]);
                                } else {
                                    unittodayorders.put("preparedby", (String) Preparedby[1] + " " + (String) Preparedby[2]);
                                }
                            }
                        }

                        todaysOrders.add(unittodayorders);
                    }
                }

        //Fetch re-instated order
        String[] paramsfacilityunitfuturereinstated = {"destinationstore", "status"};
        Object[] paramsValuesfacilitunitfuturereinstated = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), "REINSTATED"};
        String[] fieldsunitfuturereinstated = {"facilityorderid", "facilityorderno", "ordertype", "originstore", "isemergency", "dateprepared", "dateneeded", "approvedby", "status", "preparedby"};
        String whereunitfuturereinstated = "WHERE destinationstore=:destinationstore AND status=:status";
        List<Object[]> objunitexpiredreinstated = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fieldsunitfuturereinstated, whereunitfuturereinstated, paramsfacilityunitfuturereinstated, paramsValuesfacilitunitfuturereinstated);
        if (objunitexpiredreinstated != null) {
            Map<String, Object> unittodayorders2;
            for (Object[] ordreinst : objunitexpiredreinstated) {
                unittodayorders2 = new HashMap<>();
                try {
                    unittodayorders2.put("dateprepared", format.format((Date) ordreinst[5]));
                    unittodayorders2.put("dateneeded", format.format((Date) ordreinst[6]));
                    unittodayorders2.put("facilityorderid", ordreinst[0]);
                    unittodayorders2.put("facilityorderno", (String) ordreinst[1]);
                    unittodayorders2.put("ordertype", (String) ordreinst[2]);
                    unittodayorders2.put("originstore", ordreinst[3]);
                    unittodayorders2.put("isemergency", "false");

                    //Fetch Facility Units
                    String[] paramsfunits = {"facilityunitid"};
                    Object[] paramsValuesfunit = {ordreinst[3]};
                    String wherefunit = "WHERE facilityunitid=:facilityunitid";
                    String[] fieldsfunit = {"facilityunitname"};
                    List<String> facilityunitnames = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fieldsfunit, wherefunit, paramsfunits, paramsValuesfunit);
                    if (facilityunitnames != null) {
                        unittodayorders2.put("orderingUnit", facilityunitnames.get(0));
                    }
                    //
                    unittodayorders2.put("orderingunitid", ordreinst[3]);
                    //
                    //Fetch Order Items number
                    int noOfItems = 0;
                    String[] paramsnumberofitems = {"facilityorderid"};
                    Object[] paramsValuesnumberofitems = {ordreinst[0]};
//                    String wherenumberofitems = "WHERE facilityorderid=:facilityorderid";
                    String wherenumberofitems = "WHERE facilityorderid=:facilityorderid AND approved=true";
                    noOfItems = genericClassService.fetchRecordCount(Facilityorderitems.class, wherenumberofitems, paramsnumberofitems, paramsValuesnumberofitems);
                    unittodayorders2.put("numberofitems", noOfItems);
                    unittodayorders2.put("dateprepared", format.format((Date) ordreinst[5]));

                    if (ordreinst[7] != null) {
                        if (ordreinst[7] != null) {
                            String[] paramsApprovedby = {"personid"};
                            Object[] paramsValuesApprovedby = {ordreinst[7]};
                            String[] fieldsApprovedby = {"personid", "firstname", "lastname", "othernames"};
                            String where7 = "WHERE personid=:personid";
                            List<Object[]> objApprov = (List<Object[]>) genericClassService.fetchRecord(Person.class, fieldsApprovedby, where7, paramsApprovedby, paramsValuesApprovedby);
                            if (objApprov != null) {
                                Object[] approvedby = objApprov.get(0);
                                if (approvedby[3] != null) {
                                    unittodayorders2.put("approvedby", (String) approvedby[1] + " " + (String) approvedby[2] + " " + (String) approvedby[3]);
                                } else {
                                    unittodayorders2.put("approvedby", (String) approvedby[1] + " " + (String) approvedby[2]);
                                }
                            }
                        }
                    }

                    if (ordreinst[9] != null) {
                        String[] paramsPreparedby = {"personid"};
                        Object[] paramsValuesPreparedby = {ordreinst[9]};
                        String[] fieldsPreparedby = {"personid", "firstname", "lastname", "othernames"};
                        String where7 = "WHERE personid=:personid";
                        List<Object[]> objPrepered = (List<Object[]>) genericClassService.fetchRecord(Person.class, fieldsPreparedby, where7, paramsPreparedby, paramsValuesPreparedby);
                        if (objPrepered != null) {
                            Object[] Preparedby = objPrepered.get(0);
                            if (Preparedby[3] != null) {
                                unittodayorders2.put("preparedby", (String) Preparedby[1] + " " + (String) Preparedby[2] + " " + (String) Preparedby[3]);
                            } else {
                                unittodayorders2.put("preparedby", (String) Preparedby[1] + " " + (String) Preparedby[2]);
                            }
                        }
                    }
                    todaysOrders.add(unittodayorders2);
                } catch (Exception ex) {
                    System.out.println(ex);
                }
            }
        }

        //Fetch OVERRDEN order
        Map<String, Object> unittodayorders3;
        String[] paramsfacilityunitexpiredoverriden = {"destinationstore", "status"};
        Object[] paramsValuesfacilitunitexpiredoverriden = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), "OVERRIDEN"};
        String[] fieldsunitexpiredoverriden = {"facilityorderid", "facilityorderno", "ordertype", "originstore", "isemergency", "dateprepared", "dateneeded", "approvedby", "status", "preparedby"};
        String whereunitexpiredoverriden = "WHERE destinationstore=:destinationstore AND status=:status";
        List<Object[]> objunitexpiredoverriden = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fieldsunitexpiredoverriden, whereunitexpiredoverriden, paramsfacilityunitexpiredoverriden, paramsValuesfacilitunitexpiredoverriden);
        if (objunitexpiredoverriden != null) {
            for (Object[] expiredoverriden : objunitexpiredoverriden) {
                unittodayorders3 = new HashMap<>();
                try {
                    unittodayorders3.put("dateprepared", format.format((Date) expiredoverriden[5]));
                    unittodayorders3.put("dateneeded", format.format((Date) expiredoverriden[6]));
                    unittodayorders3.put("facilityorderid", expiredoverriden[0]);
                    unittodayorders3.put("facilityorderno", (String) expiredoverriden[1]);
                    unittodayorders3.put("ordertype", (String) expiredoverriden[2]);
                    unittodayorders3.put("originstore", expiredoverriden[3]);
                    unittodayorders3.put("isemergency", "false");

                    //Fetch Facility Units
                    String[] paramsfunitsoverri = {"facilityunitid"};
                    Object[] paramsValuesfunitoverri = {expiredoverriden[3]};
                    String wherefunitoverri = "WHERE facilityunitid=:facilityunitid";
                    String[] fieldsfunitoverri = {"facilityunitname"};
                    List<String> facilityunitnamesoverri = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fieldsfunitoverri, wherefunitoverri, paramsfunitsoverri, paramsValuesfunitoverri);
                    if (facilityunitnamesoverri != null) {
                        unittodayorders3.put("orderingUnit", facilityunitnamesoverri.get(0));
                    }
                    //
                    unittodayorders3.put("orderingunitid", expiredoverriden[3]);
                    //
                    //Fetch Order Items number
                    int noOfItems = 0;
                    String[] paramsnumberofitemsoverri = {"facilityorderid"};
                    Object[] paramsValuesnumberofitemsoverri = {expiredoverriden[0]};
//                    String wherenumberofitemsoverri = "WHERE facilityorderid=:facilityorderid";
                    String wherenumberofitemsoverri = "WHERE facilityorderid=:facilityorderid AND approved=true";
                    noOfItems = genericClassService.fetchRecordCount(Facilityorderitems.class, wherenumberofitemsoverri, paramsnumberofitemsoverri, paramsValuesnumberofitemsoverri);
                    unittodayorders3.put("numberofitems", noOfItems);
                    unittodayorders3.put("dateprepared", format.format((Date) expiredoverriden[5]));

                    if (expiredoverriden[7] != null) {

                        String[] paramsApprovedby = {"personid"};
                        Object[] paramsValuesApprovedby = {expiredoverriden[7]};
                        String[] fieldsApprovedby = {"personid", "firstname", "lastname", "othernames"};
                        String where7overri = "WHERE personid=:personid";
                        List<Object[]> objApprovoverri = (List<Object[]>) genericClassService.fetchRecord(Person.class, fieldsApprovedby, where7overri, paramsApprovedby, paramsValuesApprovedby);
                        if (objApprovoverri != null) {
                            Object[] approvedbyoverri = objApprovoverri.get(0);
                            if (approvedbyoverri[3] != null) {
                                unittodayorders3.put("approvedby", (String) approvedbyoverri[1] + " " + (String) approvedbyoverri[2] + " " + (String) approvedbyoverri[3]);
                            } else {
                                unittodayorders3.put("approvedby", (String) approvedbyoverri[1] + " " + (String) approvedbyoverri[2]);
                            }
                        }
                    }

                    if (expiredoverriden[9] != null) {
                        String[] paramsPreparedbyoverri = {"personid"};
                        Object[] paramsValuesPreparedbyoverri = {expiredoverriden[9]};
                        String[] fieldsPreparedbyoverri = {"personid", "firstname", "lastname", "othernames"};
                        String whereoverri2 = "WHERE personid=:personid";
                        List<Object[]> objPreperedoverri = (List<Object[]>) genericClassService.fetchRecord(Person.class, fieldsPreparedbyoverri, whereoverri2, paramsPreparedbyoverri, paramsValuesPreparedbyoverri);
                        if (objPreperedoverri != null) {
                            Object[] Preparedby = objPreperedoverri.get(0);
                            if (Preparedby[3] != null) {
                                unittodayorders3.put("preparedby", (String) Preparedby[1] + " " + (String) Preparedby[2] + " " + (String) Preparedby[3]);
                            } else {
                                unittodayorders3.put("preparedby", (String) Preparedby[1] + " " + (String) Preparedby[2]);
                            }
                        }
                    }
                    todaysOrders.add(unittodayorders3);
                } catch (Exception ex) {
                    System.out.println(ex);
                }
            }
        }

        //Fetch Emergency order
        Map<String, Object> unittodayordersemergency;
        String[] paramsfacilityunitemergency = {"destinationstore", "status", "isemergency"};
        Object[] paramsValuesfacilitunitemergency = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), "SENT", Boolean.TRUE};
        String[] fieldsunitemergency = {"facilityorderid", "facilityorderno", "ordertype", "originstore", "isemergency", "dateprepared", "dateneeded", "approvedby", "status", "preparedby"};
        String whereunitemergency = "WHERE destinationstore=:destinationstore AND status=:status AND isemergency=:isemergency";
        List<Object[]> objemergency = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fieldsunitemergency, whereunitemergency, paramsfacilityunitemergency, paramsValuesfacilitunitemergency);
        if (objemergency != null) {
            for (Object[] emergencyorder : objemergency) {
                unittodayordersemergency = new HashMap<>();
                try {
                    unittodayordersemergency.put("dateprepared", format.format((Date) emergencyorder[5]));
                    unittodayordersemergency.put("dateneeded", format.format((Date) emergencyorder[6]));
                    unittodayordersemergency.put("facilityorderid", emergencyorder[0]);
                    unittodayordersemergency.put("facilityorderno", (String) emergencyorder[1]);
                    unittodayordersemergency.put("ordertype", (String) emergencyorder[2]);
                    unittodayordersemergency.put("originstore", emergencyorder[3]);
                    unittodayordersemergency.put("isemergency", "true");

                    //Fetch Facility Units
                    String[] paramsfunitsem = {"facilityunitid"};
                    Object[] paramsValuesfunitem = {emergencyorder[3]};
                    String wherefunitem = "WHERE facilityunitid=:facilityunitid";
                    String[] fieldsfunitem = {"facilityunitname"};
                    List<String> facilityunitnamesem = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fieldsfunitem, wherefunitem, paramsfunitsem, paramsValuesfunitem);
                    if (facilityunitnamesem != null) {
                        unittodayordersemergency.put("orderingUnit", facilityunitnamesem.get(0));
                    }
                    //
                    unittodayordersemergency.put("orderingunitid", emergencyorder[3]);
                    //    
                    //Fetch Order Items number
                    int noOfItems = 0;
                    String[] paramsnumberofitemsemgcy = {"facilityorderid"};
                    Object[] paramsValuesnumberofitemsemgcy = {emergencyorder[0]};
//                    String wherenumberofitemsemgcy = "WHERE facilityorderid=:facilityorderid";
                    String wherenumberofitemsemgcy = "WHERE facilityorderid=:facilityorderid AND approved=true";
                    noOfItems = genericClassService.fetchRecordCount(Facilityorderitems.class, wherenumberofitemsemgcy, paramsnumberofitemsemgcy, paramsValuesnumberofitemsemgcy);
                    unittodayordersemergency.put("numberofitems", noOfItems);
                    unittodayordersemergency.put("dateprepared", format.format((Date) emergencyorder[5]));

                    if (emergencyorder[7] != null) {

                        String[] paramsApprovedbyemgcy = {"personid"};
                        Object[] paramsValuesApprovedbyemgcy = {emergencyorder[7]};
                        String[] fieldsApprovedbyemgcy = {"personid", "firstname", "lastname", "othernames"};
                        String where7emgcy = "WHERE personid=:personid";
                        List<Object[]> objApprovemgcy = (List<Object[]>) genericClassService.fetchRecord(Person.class, fieldsApprovedbyemgcy, where7emgcy, paramsApprovedbyemgcy, paramsValuesApprovedbyemgcy);
                        if (objApprovemgcy != null) {
                            Object[] approvedbyemgcy = objApprovemgcy.get(0);
                            if (approvedbyemgcy[3] != null) {
                                unittodayordersemergency.put("approvedby", (String) approvedbyemgcy[1] + " " + (String) approvedbyemgcy[2] + " " + (String) approvedbyemgcy[3]);
                            } else {
                                unittodayordersemergency.put("approvedby", (String) approvedbyemgcy[1] + " " + (String) approvedbyemgcy[2]);
                            }
                        }
                    }

                    if (emergencyorder[9] != null) {
                        String[] paramsPreparedbyemgcy = {"personid"};
                        Object[] paramsValuesPreparedbyemgcy = {emergencyorder[9]};
                        String[] fieldsPreparedbyemgcy = {"personid", "firstname", "lastname", "othernames"};
                        String whereemgcy = "WHERE personid=:personid";
                        List<Object[]> objPreperedemgcy = (List<Object[]>) genericClassService.fetchRecord(Person.class, fieldsPreparedbyemgcy, whereemgcy, paramsPreparedbyemgcy, paramsValuesPreparedbyemgcy);
                        if (objPreperedemgcy != null) {
                            Object[] Preparedbyemgcy = objPreperedemgcy.get(0);
                            if (Preparedbyemgcy[3] != null) {
                                unittodayordersemergency.put("preparedby", (String) Preparedbyemgcy[1] + " " + (String) Preparedbyemgcy[2] + " " + (String) Preparedbyemgcy[3]);
                            } else {
                                unittodayordersemergency.put("preparedby", (String) Preparedbyemgcy[1] + " " + (String) Preparedbyemgcy[2]);
                            }
                        }
                    }
                    todaysOrders.add(unittodayordersemergency);
                } catch (Exception ex) {
                    System.out.println(ex);
                }
            }
        }

        //NO OF TODAY'S DELIVERED ORDERS
        int noOfOrderDeliveredsitemstoday = 0;

        String[] paramsfacilityunitorderstoday = {"destinationstore", "status", "ordertype"};
        Object[] paramsValuestodaydeliveredorders = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), "DELIVERED", "INTERNAL"};
        String[] fieldsunittodaydelivered = {"facilityorderid", "facilityorderno", "ordertype", "originstore", "isemergency", "dateprepared", "dateneeded", "approvedby", "status"};
        String whereunittodaydelivered = "WHERE destinationstore=:destinationstore AND status=:status AND ordertype=:ordertype";
        List<Object[]> objunittodaydelivered = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fieldsunittodaydelivered, whereunittodaydelivered, paramsfacilityunitorderstoday, paramsValuestodaydeliveredorders);
        if (objunittodaydelivered != null) {
            for (Object[] todaydelivered : objunittodaydelivered) {
                try {

                    String[] paramsfacilityunitorderstoday2 = {"facilityorderid", "isdelivered", "datedelivered"};
                    Object[] paramsValuestodaydeliveredorders2 = {todaydelivered[0], true, new Date()};
                    String[] fieldsunittodaydelivered2 = {"facilityorderitemsid", "datedelivered"};
                    String whereunittodaydelivered2 = "WHERE facilityorderid=:facilityorderid AND isdelivered=:isdelivered AND datedelivered=:datedelivered ORDER BY facilityorderitemsid LIMIT 1";
                    List<Object[]> objunittodaydelivered2 = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fieldsunittodaydelivered2, whereunittodaydelivered2, paramsfacilityunitorderstoday2, paramsValuestodaydeliveredorders2);
                    if (objunittodaydelivered2 != null) {
                        noOfOrderDeliveredsitemstoday = noOfOrderDeliveredsitemstoday + 1;
                    }
                } catch (Exception ex) {
                    System.out.println(ex);
                }
            }
        }

        model.addAttribute("noOfTodaysDelivereditemsCount", noOfOrderDeliveredsitemstoday);
        model.addAttribute("todaysOrders", todaysOrders);
        model.addAttribute("todaysOrdersCount", todaysOrders.size());
        model.addAttribute("serverdate", formatterwithtime.format(serverDate));
        return "inventoryAndSupplies/orders/processOrder/processOrderMainPane";
    }

    @RequestMapping(value = "/orderSanctionedCount", method = RequestMethod.GET)
    public @ResponseBody
    String orderSanctionedCount(Model model, HttpServletRequest request) {
        int sanctionedOrderCount = 0;
        String results = "";

        String[] paramsCount = {"destinationstore", "status", "ordertype"};
        Object[] paramsValuesCount = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), "SERVICED", "INTERNAL"};
        String[] fieldsCount = {"facilityorderid"};
        String whereCount = "WHERE destinationstore=:destinationstore AND status=:status AND ordertype=:ordertype";
        List<Long> objunitCount = (List<Long>) genericClassService.fetchRecord(Facilityorder.class, fieldsCount, whereCount, paramsCount, paramsValuesCount);
        if (objunitCount != null) {
            for (Long sanctionedcount : objunitCount) {
                try {
                    String[] paramsitms = {"facilityorderid", "serviced"};
                    Object[] paramsValuesitms = {sanctionedcount, true};
                    String[] fieldsunititms = {"facilityorderitemsid"};
                    String whereitms = "WHERE facilityorderid=:facilityorderid AND serviced=:serviced ORDER BY facilityorderitemsid LIMIT 1";
                    List<Long> objunititms = (List<Long>) genericClassService.fetchRecord(Facilityorderitems.class, fieldsunititms, whereitms, paramsitms, paramsValuesitms);
                    if (objunititms != null) {
                        sanctionedOrderCount = sanctionedOrderCount + 1;
                    }
                } catch (Exception ex) {
                    System.out.println(ex);
                }
            }
        }
        results = String.valueOf(sanctionedOrderCount);
        return results;
    }

    @RequestMapping(value = "/readyToIssue", method = RequestMethod.GET)
    public @ResponseBody
    String readyToIssue(Model model, HttpServletRequest request) {
        int pickedOrderCount = 0;
        String results = "";

        String[] paramsCount = {"destinationstore", "status", "ordertype"};
        Object[] paramsValuesCount = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), "PICKED", "INTERNAL"};
        String[] fieldsCount = {"facilityorderid"};
        String whereCount = "WHERE destinationstore=:destinationstore AND status=:status AND ordertype=:ordertype";
        List<Long> objunitCount = (List<Long>) genericClassService.fetchRecord(Facilityorder.class, fieldsCount, whereCount, paramsCount, paramsValuesCount);
        if (objunitCount != null) {
            for (Long sanctionedcount : objunitCount) {
                try {
                    String[] paramsitms = {"facilityorderid", "ispicked"};
                    Object[] paramsValuesitms = {sanctionedcount, true};
                    String[] fieldsunititms = {"facilityorderitemsid"};
                    String whereitms = "WHERE facilityorderid=:facilityorderid AND ispicked=:ispicked ORDER BY facilityorderitemsid LIMIT 1";
                    List<Long> objunititms = (List<Long>) genericClassService.fetchRecord(Facilityorderitems.class, fieldsunititms, whereitms, paramsitms, paramsValuesitms);
                    if (objunititms != null) {
                        pickedOrderCount = pickedOrderCount + 1;
                    }
                } catch (Exception ex) {
                    System.out.println(ex);
                }
            }
        }
        results = String.valueOf(pickedOrderCount);
        return results;
    }

    @RequestMapping(value = "/viewTodaysDeliveredOrders", method = RequestMethod.GET)
    public String viewTodaysDeliveredOrders(Model model, HttpServletRequest request) {
        List<Map> todaysDeliveredOrders = new ArrayList<>();

        String[] paramsorderstodayFOrder = {"destinationstore", "status"};
        Object[] paramsValuesFOrder = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), "DELIVERED"};
        String[] fieldsFOrder = {"facilityorderid", "facilityorderno", "ordertype", "originstore", "isemergency", "dateprepared", "dateneeded", "approvedby", "status"};
        String whereunitFOrder = "WHERE destinationstore=:destinationstore AND status=:status ORDER BY facilityorderid";
        List<Object[]> objunitFOrder = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fieldsFOrder, whereunitFOrder, paramsorderstodayFOrder, paramsValuesFOrder);
        if (objunitFOrder != null) {
            Map<String, Object> unitTodayDeliveredorders2;
            for (Object[] todaydelivered : objunitFOrder) {
                int noOfItems = 0;
                try {
                    unitTodayDeliveredorders2 = new HashMap<>();
                    unitTodayDeliveredorders2.put("dateprepared", format.format((Date) todaydelivered[5]));
                    unitTodayDeliveredorders2.put("dateneeded", format.format((Date) todaydelivered[6]));                    
                    unitTodayDeliveredorders2.put("facilityorderid", todaydelivered[0]);
                    unitTodayDeliveredorders2.put("facilityorderno", (String) todaydelivered[1]);
                    unitTodayDeliveredorders2.put("ordertype", (String) todaydelivered[2]);
                    unitTodayDeliveredorders2.put("originstore", todaydelivered[3]);

                    //Fetch Facility Units
                    String[] paramsfunits = {"facilityunitid"};
                    Object[] paramsValuesfunit = {todaydelivered[3]};
                    String wherefunit = "WHERE facilityunitid=:facilityunitid";
                    String[] fieldsfunit = {"facilityunitname"};
                    List<String> facilityunitnames = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fieldsfunit, wherefunit, paramsfunits, paramsValuesfunit);
                    if (facilityunitnames != null) {
                        unitTodayDeliveredorders2.put("orderingUnit", facilityunitnames.get(0));
                    }

                    String[] paramsDeliveredby = {"facilityorderid", "isdelivered", "datedelivered"};
                    Object[] paramsValuesDeliveredby = {todaydelivered[0], true, new Date()};
                    String whereDeliveredby = "WHERE facilityorderid=:facilityorderid AND isdelivered=:isdelivered AND datedelivered=:datedelivered ORDER BY datedelivered ASC LIMIT 1";
                    String[] fieldsDeliveredby = {"facilityorderitemsid", "deliveredby", "datedelivered", "deliveredto"};
                    List<Object[]> objDeliveredbystaff = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fieldsDeliveredby, whereDeliveredby, paramsDeliveredby, paramsValuesDeliveredby);

                    if (objDeliveredbystaff != null) {
                        Object[] deliveredby = objDeliveredbystaff.get(0);

                        //Query Staff details
                        String[] paramsstaffidDelivertoday = {"staffid"};
                        Object[] paramsValuesstaffidDelivertoday = {deliveredby[1]};
                        String[] fieldsstaffidDelivertoday = {"personid.personid"};
                        String wherestaffidDelivertoday = "WHERE staffid=:staffid";
                        List<Long> objstaffidDelivertoday = (List<Long>) genericClassService.fetchRecord(Staff.class, fieldsstaffidDelivertoday, wherestaffidDelivertoday, paramsstaffidDelivertoday, paramsValuesstaffidDelivertoday);
                        if (objstaffidDelivertoday != null) {
                            String[] paramsPersondetailsDelivertoday = {"personid"};
                            Object[] paramsValuesPersondetailsDelivertoday = {objstaffidDelivertoday.get(0)};
                            String[] fieldsPersondetailsDelivertoday = {"personid", "firstname", "lastname", "othernames"};
                            String wherePersondetailsDelivertoday = "WHERE personid=:personid";
                            List<Object[]> objPersondetailsDelivertoday = (List<Object[]>) genericClassService.fetchRecord(Person.class, fieldsPersondetailsDelivertoday, wherePersondetailsDelivertoday, paramsPersondetailsDelivertoday, paramsValuesPersondetailsDelivertoday);
                            if (objPersondetailsDelivertoday != null) {
                                Object[] persondetailsDelivertoday = objPersondetailsDelivertoday.get(0);
                                if (persondetailsDelivertoday[3] != null) {
                                    unitTodayDeliveredorders2.put("deliveredby", (String) persondetailsDelivertoday[1] + " " + (String) persondetailsDelivertoday[2] + " " + (String) persondetailsDelivertoday[3]);
                                } else {
                                    unitTodayDeliveredorders2.put("deliveredby", (String) persondetailsDelivertoday[1] + " " + (String) persondetailsDelivertoday[2]);
                                }
                            }
                            unitTodayDeliveredorders2.put("datedelivered", formatter.format((Date) deliveredby[2]));
                        }

                        String[] paramsPersondetailsDeliver2 = {"staffid"};
                        Object[] paramsValuesPersondetailsDeliver2 = {deliveredby[3]};
                        String[] fieldsPersondetailsDeliver2 = {"personid", "firstname", "lastname", "othernames"};
                        String wherePersondetailsDeliver2 = "WHERE staffid=:staffid";
                        List<Object[]> objPersondetailsDeliver2 = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fieldsPersondetailsDeliver2, wherePersondetailsDeliver2, paramsPersondetailsDeliver2, paramsValuesPersondetailsDeliver2);
                        if (objPersondetailsDeliver2 != null) {
                            Object[] persondetailsDeliver2 = objPersondetailsDeliver2.get(0);
                            if (persondetailsDeliver2[3] != null) {
                                unitTodayDeliveredorders2.put("deliveredto", (String) persondetailsDeliver2[1] + " " + (String) persondetailsDeliver2[2] + " " + (String) persondetailsDeliver2[3]);
                            } else {
                                unitTodayDeliveredorders2.put("deliveredto", (String) persondetailsDeliver2[1] + " " + (String) persondetailsDeliver2[2]);
                            }
                        }

                        //Fetch Order Items number
                        String[] paramsfacilityunitorderstoday2 = {"facilityorderid", "isdelivered", "datedelivered"};
                        Object[] paramsValuestodaydeliveredorders2 = {todaydelivered[0], true, new Date()};
                        String[] fieldsunittodaydelivered2 = {"facilityorderitemsid", "datedelivered"};
                        String whereunittodaydelivered2 = "WHERE facilityorderid=:facilityorderid AND isdelivered=:isdelivered AND datedelivered=:datedelivered";
                        List<Object[]> objunittodaydelivered2 = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fieldsunittodaydelivered2, whereunittodaydelivered2, paramsfacilityunitorderstoday2, paramsValuestodaydeliveredorders2);
                        if (objunittodaydelivered2 != null) {
                            noOfItems = objunittodaydelivered2.size();
                        }
                        unitTodayDeliveredorders2.put("noOfItems", noOfItems);

                        todaysDeliveredOrders.add(unitTodayDeliveredorders2);
                    }
                } catch (Exception ex) {
                    System.out.println(ex);
                }
            }
        }
        model.addAttribute("todayDeliveredOrders", todaysDeliveredOrders);
        return "inventoryAndSupplies/orders/processOrder/views/viewFacilityOrderItemsDeriveredToday";
    }

    @RequestMapping(value = "/overridefutureorder.htm", method = RequestMethod.GET)
    public @ResponseBody
    String overridefutureorder(HttpServletRequest request, @ModelAttribute("facilityorderidfut") String facilityorderidfut) {
        try {
            String[] columns = {"status"};
            Object[] columnValues = {"OVERRIDEN"};
            String pk = "facilityorderid";
            Object pkValue = Long.parseLong(facilityorderidfut);
            genericClassService.updateRecordSQLSchemaStyle(Facilityorder.class, columns, columnValues, pk, pkValue, "store");
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return "";
    }

    @RequestMapping(value = "/numberoftodayfutureexpireorders.htm", method = RequestMethod.GET)
    public @ResponseBody
    String numberoftodayfutureexpireorders(HttpServletRequest request, Model model) {
        Date now = new Date();
        List<String> scheduleDays = new ArrayList<>();
        List<Map> futureexpirenolist = new ArrayList<>();
        Map<String, Object> listmap = new HashMap<>();

        //NO OF FUTURE ORDERS
        int noOfFutureorders = 0;
        int noOfExpiredorders = 0;
        //Fetch Facility Orders
//        String[] paramsfunitsuppschedu2 = {"facilityunitid"};
//        Object[] paramsValuesfunitsuppschedu2 = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))))};
//        String[] fieldsfunitsuppschedu2 = {"scheduleid"};
//        String wherefunitsuppschedu2 = "WHERE facilityunitid=:facilityunitid";
//        List<Object> objFunitsuppschedu2 = (List<Object>) genericClassService.fetchRecord(Facilityunitschedule.class, fieldsfunitsuppschedu2, wherefunitsuppschedu2, paramsfunitsuppschedu2, paramsValuesfunitsuppschedu2);
//        if (objFunitsuppschedu2 != null) {
//            for (Object day : objFunitsuppschedu2) {
//                scheduleDays.add(day.toString());
//            }
//            if (!scheduleDays.contains(String.valueOf(now.getDay()))) {
//                String[] paramsfacilityunittodayorders = {"destinationstore", "status", "isemergency"};
//                Object[] paramsValuesfacilitunittodayorders = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), "SENT", false};
//                String whereunittodayorders = "WHERE destinationstore=:destinationstore AND status=:status AND isemergency=:isemergency";
//                noOfFutureorders = genericClassService.fetchRecordCount(Facilityorder.class, whereunittodayorders, paramsfacilityunittodayorders, paramsValuesfacilitunittodayorders);
//            }
//        }
        String[] paramsfacilityunittodayorders = {"destinationstore", "status", "isemergency"};
        Object[] paramsValuesfacilitunittodayorders = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), "SENT", false};
        String whereunittodayorders = "WHERE destinationstore=:destinationstore AND status=:status AND isemergency=:isemergency AND dateneeded>current_date";
        noOfFutureorders = genericClassService.fetchRecordCount(Facilityorder.class, whereunittodayorders, paramsfacilityunittodayorders, paramsValuesfacilitunittodayorders);
        
        String whereUnitExpiredOrders = "WHERE destinationstore=:destinationstore AND status=:status AND isemergency=:isemergency AND dateneeded<current_date";
        noOfExpiredorders = genericClassService.fetchRecordCount(Facilityorder.class, whereUnitExpiredOrders, paramsfacilityunittodayorders, paramsValuesfacilitunittodayorders);

        listmap.put("noOfFutureorders", noOfFutureorders);
        listmap.put("noOfExpiredorders", noOfExpiredorders);
        
        futureexpirenolist.add(listmap);

        String jsonqtylist = "";
        try {
            jsonqtylist = new ObjectMapper().writeValueAsString(futureexpirenolist);
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return jsonqtylist;
    }

    @RequestMapping(value = "/reinstateeexpiredorder.htm", method = RequestMethod.GET)
    public @ResponseBody
    String reinstateeexpiredorder(HttpServletRequest request, @ModelAttribute("facilityorderidexp") String facilityorderidexp) {
        try {
            String[] columns = {"status"};
            Object[] columnValues = {"REINSTATED"};
            String pk = "facilityorderid";
            Object pkValue = Long.parseLong(facilityorderidexp);
            genericClassService.updateRecordSQLSchemaStyle(Facilityorder.class, columns, columnValues, pk, pkValue, "store");
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return "";
    }

    @RequestMapping(value = "/managefutureorders", method = RequestMethod.GET)
    public String manageFutureOrders(Model model, HttpServletRequest request) {

        //Fetch Future Sent Orders
        List<String> scheduleDays = new ArrayList<>();
        List<Map> futureOrders = new ArrayList<>();
        Date now = new Date();

//        String[] paramsfunitfutureorders = {"facilityunitid"};
//        Object[] paramsValuesfacilityunitfutureorders = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))))};
//        String[] fieldsfunitfutureorders = {"scheduleid"};
//        String wherefunitfutureorders = "WHERE facilityunitid=:facilityunitid";
//        List<Integer> objFunitsuppschedu4 = (List<Integer>) genericClassService.fetchRecord(Facilityunitschedule.class, fieldsfunitfutureorders, wherefunitfutureorders, paramsfunitfutureorders, paramsValuesfacilityunitfutureorders);
//        if (objFunitsuppschedu4 != null) {
//            for (Object day : objFunitsuppschedu4) {
//                scheduleDays.add(day.toString());
//            }
//
//            //Fetch Facility Orders
//            if (!scheduleDays.contains(String.valueOf(now.getDay()))) {
//                String[] paramsfacilityunittodayorders = {"destinationstore", "status", "isemergency"};
//                Object[] paramsValuesfacilitunittodayorders = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), "SENT", false};
//                String[] fieldsunittodayorders = {"facilityorderid", "facilityorderno", "ordertype", "originstore", "isemergency", "dateprepared", "dateneeded", "approvedby", "status", "preparedby"};
//                String whereunittodayorders = "WHERE destinationstore=:destinationstore AND status=:status AND isemergency=:isemergency";
//                List<Object[]> objunittodayorders = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fieldsunittodayorders, whereunittodayorders, paramsfacilityunittodayorders, paramsValuesfacilitunittodayorders);
//                Map<String, Object> unitFutureorders;
//                if (objunittodayorders != null) {
//                    for (Object[] ord : objunittodayorders) {
//                        unitFutureorders = new HashMap<>();
//                        unitFutureorders.put("dateneeded", format.format((Date) ord[6]));
//                        unitFutureorders.put("facilityorderid", ord[0]);
//                        unitFutureorders.put("facilityorderno", (String) ord[1]);
//                        unitFutureorders.put("ordertype", (String) ord[2]);
//                        unitFutureorders.put("originstore", ord[3]);
//
//                        //Fetch Facility Units
//                        String[] paramsfunits = {"facilityunitid"};
//                        Object[] paramsValuesfunit = {ord[3]};
//                        String wherefunit = "WHERE facilityunitid=:facilityunitid";
//                        String[] fieldsfunit = {"facilityunitname"};
//                        List<String> facilityunitnames = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fieldsfunit, wherefunit, paramsfunits, paramsValuesfunit);
//                        if (facilityunitnames != null) {
//                            unitFutureorders.put("orderingUnit", facilityunitnames.get(0));
//                        }
//
//                        //Fetch Order Items number
//                        int noOfItems = 0;
//                        String[] paramsnumberofitems = {"facilityorderid"};
//                        Object[] paramsValuesnumberofitems = {ord[0]};
//                        String wherenumberofitems = "WHERE facilityorderid=:facilityorderid";
//                        noOfItems = genericClassService.fetchRecordCount(Facilityorderitems.class, wherenumberofitems, paramsnumberofitems, paramsValuesnumberofitems);
//                        unitFutureorders.put("numberofitems", noOfItems);
//
//                        unitFutureorders.put("dateprepared", format.format((Date) ord[5]));
//                        if (ord[7] != null) {
//                            if (ord[7] != null) {
//                                String[] paramsApprovedby = {"personid"};
//                                Object[] paramsValuesApprovedby = {ord[7]};
//                                String[] fieldsApprovedby = {"personid", "firstname", "lastname", "othernames"};
//                                String where7 = "WHERE personid=:personid";
//                                List<Object[]> objApprov = (List<Object[]>) genericClassService.fetchRecord(Person.class, fieldsApprovedby, where7, paramsApprovedby, paramsValuesApprovedby);
//                                if (objApprov != null) {
//                                    Object[] approvedby = objApprov.get(0);
//                                    if (approvedby[3] != null) {
//                                        unitFutureorders.put("approvedby", (String) approvedby[1] + " " + (String) approvedby[2] + " " + (String) approvedby[3]);
//                                    } else {
//                                        unitFutureorders.put("approvedby", (String) approvedby[1] + " " + (String) approvedby[2]);
//                                    }
//                                }
//                            }
//                        }
//
//                        if (ord[9] != null) {
//                            String[] paramsPreparedby = {"personid"};
//                            Object[] paramsValuesPreparedby = {ord[9]};
//                            String[] fieldsPreparedby = {"personid", "firstname", "lastname", "othernames"};
//                            String where7 = "WHERE personid=:personid";
//                            List<Object[]> objPrepered = (List<Object[]>) genericClassService.fetchRecord(Person.class, fieldsPreparedby, where7, paramsPreparedby, paramsValuesPreparedby);
//                            if (objPrepered != null) {
//                                Object[] Preparedby = objPrepered.get(0);
//                                if (Preparedby[3] != null) {
//                                    unitFutureorders.put("preparedby", (String) Preparedby[1] + " " + (String) Preparedby[2] + " " + (String) Preparedby[3]);
//                                } else {
//                                    unitFutureorders.put("preparedby", (String) Preparedby[1] + " " + (String) Preparedby[2]);
//                                }
//                            }
//                        }
//                        futureOrders.add(unitFutureorders);
//                    }
//                }
//            }
//        }

String[] paramsfacilityunittodayorders = {"destinationstore", "status", "isemergency"};
                Object[] paramsValuesfacilitunittodayorders = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), "SENT", false};
                String[] fieldsunittodayorders = {"facilityorderid", "facilityorderno", "ordertype", "originstore", "isemergency", "dateprepared", "dateneeded", "approvedby", "status", "preparedby"};
                String whereunittodayorders = "WHERE destinationstore=:destinationstore AND status=:status AND isemergency=:isemergency AND dateneeded>current_date";
                List<Object[]> objunittodayorders = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fieldsunittodayorders, whereunittodayorders, paramsfacilityunittodayorders, paramsValuesfacilitunittodayorders);
                Map<String, Object> unitFutureorders;
                if (objunittodayorders != null) {
                    for (Object[] ord : objunittodayorders) {
                        unitFutureorders = new HashMap<>();
                        unitFutureorders.put("dateprepared", format.format((Date) ord[5]));
                        unitFutureorders.put("dateneeded", format.format((Date) ord[6]));
                        unitFutureorders.put("facilityorderid", ord[0]);
                        unitFutureorders.put("facilityorderno", (String) ord[1]);
                        unitFutureorders.put("ordertype", (String) ord[2]);
                        unitFutureorders.put("originstore", ord[3]);

                        //Fetch Facility Units
                        String[] paramsfunits = {"facilityunitid"};
                        Object[] paramsValuesfunit = {ord[3]};
                        String wherefunit = "WHERE facilityunitid=:facilityunitid";
                        String[] fieldsfunit = {"facilityunitname"};
                        List<String> facilityunitnames = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fieldsfunit, wherefunit, paramsfunits, paramsValuesfunit);
                        if (facilityunitnames != null) {
                            unitFutureorders.put("orderingUnit", facilityunitnames.get(0));
                        }

                        //Fetch Order Items number
                        int noOfItems = 0;
                        String[] paramsnumberofitems = {"facilityorderid"};
                        Object[] paramsValuesnumberofitems = {ord[0]};
                        String wherenumberofitems = "WHERE facilityorderid=:facilityorderid";
                        noOfItems = genericClassService.fetchRecordCount(Facilityorderitems.class, wherenumberofitems, paramsnumberofitems, paramsValuesnumberofitems);
                        unitFutureorders.put("numberofitems", noOfItems);

                        unitFutureorders.put("dateprepared", format.format((Date) ord[5]));
                        if (ord[7] != null) {
                            if (ord[7] != null) {
                                String[] paramsApprovedby = {"personid"};
                                Object[] paramsValuesApprovedby = {ord[7]};
                                String[] fieldsApprovedby = {"personid", "firstname", "lastname", "othernames"};
                                String where7 = "WHERE personid=:personid";
                                List<Object[]> objApprov = (List<Object[]>) genericClassService.fetchRecord(Person.class, fieldsApprovedby, where7, paramsApprovedby, paramsValuesApprovedby);
                                if (objApprov != null) {
                                    Object[] approvedby = objApprov.get(0);
                                    if (approvedby[3] != null) {
                                        unitFutureorders.put("approvedby", (String) approvedby[1] + " " + (String) approvedby[2] + " " + (String) approvedby[3]);
                                    } else {
                                        unitFutureorders.put("approvedby", (String) approvedby[1] + " " + (String) approvedby[2]);
                                    }
                                }
                            }
                        }

                        if (ord[9] != null) {
                            String[] paramsPreparedby = {"personid"};
                            Object[] paramsValuesPreparedby = {ord[9]};
                            String[] fieldsPreparedby = {"personid", "firstname", "lastname", "othernames"};
                            String where7 = "WHERE personid=:personid";
                            List<Object[]> objPrepered = (List<Object[]>) genericClassService.fetchRecord(Person.class, fieldsPreparedby, where7, paramsPreparedby, paramsValuesPreparedby);
                            if (objPrepered != null) {
                                Object[] Preparedby = objPrepered.get(0);
                                if (Preparedby[3] != null) {
                                    unitFutureorders.put("preparedby", (String) Preparedby[1] + " " + (String) Preparedby[2] + " " + (String) Preparedby[3]);
                                } else {
                                    unitFutureorders.put("preparedby", (String) Preparedby[1] + " " + (String) Preparedby[2]);
                                }
                            }
                        }
                        futureOrders.add(unitFutureorders);
                    }
                }
        model.addAttribute("futureOrders", futureOrders);
        return "inventoryAndSupplies/orders/processOrder/views/futureOrders";
    }

    @RequestMapping(value = "/manageexpiredorders", method = RequestMethod.GET)
    public String manageExpiredOrders(Model model, HttpServletRequest request) {

        List<Map> expiredOrders = new ArrayList<>();

        String[] paramsfacilityunittodayorders = {"destinationstore", "status"};
        Object[] paramsValuesfacilitunittodayorders = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), "SENT"};
        String[] fieldsunittodayorders = {"facilityorderid", "facilityorderno", "ordertype", "originstore", "isemergency", "dateprepared", "dateneeded", "approvedby", "status", "preparedby"};
        String whereunittodayorders = "WHERE destinationstore=:destinationstore AND status=:status AND dateneeded<current_date";
        List<Object[]> objunittodayorders = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fieldsunittodayorders, whereunittodayorders, paramsfacilityunittodayorders, paramsValuesfacilitunittodayorders);
        Map<String, Object> unittodayorders;
        if (objunittodayorders != null) {
            for (Object[] ord : objunittodayorders) {
                unittodayorders = new HashMap<>();
                unittodayorders.put("dateneeded", format.format((Date) ord[6]));
                unittodayorders.put("facilityorderid", ord[0]);
                unittodayorders.put("facilityorderno", (String) ord[1]);
                unittodayorders.put("ordertype", (String) ord[2]);
                unittodayorders.put("originstore", ord[3]);
                unittodayorders.put("isemergency", "false");

                //Fetch Facility Units
                String[] paramsfunits = {"facilityunitid"};
                Object[] paramsValuesfunit = {ord[3]};
                String wherefunit = "WHERE facilityunitid=:facilityunitid";
                String[] fieldsfunit = {"facilityunitname"};
                List<String> facilityunitnames = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fieldsfunit, wherefunit, paramsfunits, paramsValuesfunit);
                if (facilityunitnames != null) {
                    unittodayorders.put("orderingUnit", facilityunitnames.get(0));
                }

                //Fetch Order Items number
                int noOfItems = 0;
                String[] paramsnumberofitems = {"facilityorderid"};
                Object[] paramsValuesnumberofitems = {ord[0]};
                String wherenumberofitems = "WHERE facilityorderid=:facilityorderid";
                noOfItems = genericClassService.fetchRecordCount(Facilityorderitems.class, wherenumberofitems, paramsnumberofitems, paramsValuesnumberofitems);
                unittodayorders.put("numberofitems", noOfItems);

                unittodayorders.put("dateprepared", format.format((Date) ord[5]));
                if (ord[7] != null) {
                    if (ord[7] != null) {
                        String[] paramsApprovedby = {"personid"};
                        Object[] paramsValuesApprovedby = {ord[7]};
                        String[] fieldsApprovedby = {"personid", "firstname", "lastname", "othernames"};
                        String where7 = "WHERE personid=:personid";
                        List<Object[]> objApprov = (List<Object[]>) genericClassService.fetchRecord(Person.class, fieldsApprovedby, where7, paramsApprovedby, paramsValuesApprovedby);
                        if (objApprov != null) {
                            Object[] approvedby = objApprov.get(0);
                            if (approvedby[3] != null) {
                                unittodayorders.put("approvedby", (String) approvedby[1] + " " + (String) approvedby[2] + " " + (String) approvedby[3]);
                            } else {
                                unittodayorders.put("approvedby", (String) approvedby[1] + " " + (String) approvedby[2]);
                            }
                        }
                    }
                }

                if (ord[9] != null) {
                    String[] paramsPreparedby = {"personid"};
                    Object[] paramsValuesPreparedby = {ord[9]};
                    String[] fieldsPreparedby = {"personid", "firstname", "lastname", "othernames"};
                    String where7 = "WHERE personid=:personid";
                    List<Object[]> objPrepered = (List<Object[]>) genericClassService.fetchRecord(Person.class, fieldsPreparedby, where7, paramsPreparedby, paramsValuesPreparedby);
                    if (objPrepered != null) {
                        Object[] Preparedby = objPrepered.get(0);
                        if (Preparedby[3] != null) {
                            unittodayorders.put("preparedby", (String) Preparedby[1] + " " + (String) Preparedby[2] + " " + (String) Preparedby[3]);
                        } else {
                            unittodayorders.put("preparedby", (String) Preparedby[1] + " " + (String) Preparedby[2]);
                        }
                    }
                }

                expiredOrders.add(unittodayorders);
            }
        }
        model.addAttribute("expiredOrders", expiredOrders);
        return "inventoryAndSupplies/orders/processOrder/views/expiredOrders";
    }


    @RequestMapping(value = "/managedeliveredorders", method = RequestMethod.GET)
    public String managedeliveredorders(Model model, HttpServletRequest request) {
        List<Map> deliveredOrders = new ArrayList<>();

        //Fetch Facility Orders
        String[] paramsfacilityunitexpirorders = {"destinationstore", "status"};
        Object[] paramsValuesfacilitunitepiredorders = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), "DELIVERED"};
        String[] fieldsunitDeliveredorders = {"facilityorderid", "facilityorderno", "ordertype", "originstore", "isemergency", "dateprepared", "dateneeded", "approvedby", "status"};
        String whereunitDeliveredorders = "WHERE destinationstore=:destinationstore AND status=:status";
        List<Object[]> objunitsxipiredorders = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fieldsunitDeliveredorders, whereunitDeliveredorders, paramsfacilityunitexpirorders, paramsValuesfacilitunitepiredorders);
        if (objunitsxipiredorders != null) {
            Map<String, Object> unitDeliveredorders;
            for (Object[] ord44 : objunitsxipiredorders) {
                unitDeliveredorders = new HashMap<>();
                try {

                    //Fetch Order Items number
                    int noOfItems = 0;
                    String[] paramsnumberofitems = {"facilityorderid", "isdelivered", "datedelivered"};
                    Object[] paramsValuesnumberofitems = {ord44[0], true, new Date()};
                    String wherenumberofitems = "WHERE facilityorderid=:facilityorderid AND isdelivered=:isdelivered AND datedelivered=:datedelivered";
                    noOfItems = genericClassService.fetchRecordCount(Facilityorderitems.class, wherenumberofitems, paramsnumberofitems, paramsValuesnumberofitems);
                    unitDeliveredorders.put("numberofitems", noOfItems);

                    if (noOfItems > 0) {
                        unitDeliveredorders.put("facilityorderid", ord44[0]);
                        unitDeliveredorders.put("facilityorderno", (String) ord44[1]);
                        unitDeliveredorders.put("ordertype", (String) ord44[2]);
                        unitDeliveredorders.put("originstore", ord44[3]);
                        unitDeliveredorders.put("dateprepared", format.format((Date) ord44[5]));
                        unitDeliveredorders.put("dateneeded", format.format((Date) ord44[6]));
                        //Fetch Facility Units
                        String[] paramsfunits = {"facilityunitid"};
                        Object[] paramsValuesfunit = {ord44[3]};
                        String wherefunit = "WHERE facilityunitid=:facilityunitid";
                        String[] fieldsfunit = {"facilityunitname"};
                        List<String> facilityunitnames = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fieldsfunit, wherefunit, paramsfunits, paramsValuesfunit);
                        if (facilityunitnames != null) {
                            unitDeliveredorders.put("orderingUnit", facilityunitnames.get(0));
                        }

                        //Fetch Delivered By
                        String[] paramsDeliveredby = {"facilityorderid", "isdelivered"};
                        Object[] paramsValuesDeliveredby = {ord44[0], true};
                        String whereDeliveredby = "WHERE facilityorderid=:facilityorderid AND isdelivered=:isdelivered ORDER BY datedelivered ASC LIMIT 1";
                        String[] fieldsDeliveredby = {"facilityorderitemsid", "deliveredby", "datedelivered", "deliveredto"};
                        List<Object[]> objDeliveredbystaff = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fieldsDeliveredby, whereDeliveredby, paramsDeliveredby, paramsValuesDeliveredby);
                        if (objDeliveredbystaff != null) {
                            Object[] deliveredby = objDeliveredbystaff.get(0);

                            //Query Staff details
                            String[] paramsPersondetailsDeliver = {"staffid"};
                            Object[] paramsValuesPersondetailsDeliver = {deliveredby[1]};
                            String[] fieldsPersondetailsDeliver = {"personid", "firstname", "lastname", "othernames"};
                            String wherePersondetailsDeliver = "WHERE staffid=:staffid";
                            List<Object[]> objPersondetailsDeliver = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fieldsPersondetailsDeliver, wherePersondetailsDeliver, paramsPersondetailsDeliver, paramsValuesPersondetailsDeliver);
                            if (objPersondetailsDeliver != null) {
                                Object[] persondetailsDeliver = objPersondetailsDeliver.get(0);
                                if (persondetailsDeliver[3] != null) {
                                    unitDeliveredorders.put("deliveredby", (String) persondetailsDeliver[1] + " " + (String) persondetailsDeliver[2] + " " + (String) persondetailsDeliver[3]);
                                } else {
                                    unitDeliveredorders.put("deliveredby", (String) persondetailsDeliver[1] + " " + (String) persondetailsDeliver[2]);
                                }
                            }
                            unitDeliveredorders.put("datedelivered", formatter.format((Date) deliveredby[2]));

                            String[] paramsPersondetailsDeliver2 = {"staffid"};
                            Object[] paramsValuesPersondetailsDeliver2 = {deliveredby[3]};
                            String[] fieldsPersondetailsDeliver2 = {"personid", "firstname", "lastname", "othernames"};
                            String wherePersondetailsDeliver2 = "WHERE staffid=:staffid";
                            List<Object[]> objPersondetailsDeliver2 = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fieldsPersondetailsDeliver2, wherePersondetailsDeliver2, paramsPersondetailsDeliver2, paramsValuesPersondetailsDeliver2);
                            if (objPersondetailsDeliver2 != null) {
                                Object[] persondetailsDeliver2 = objPersondetailsDeliver2.get(0);
                                if (persondetailsDeliver2[3] != null) {
                                    unitDeliveredorders.put("deliveredto", (String) persondetailsDeliver2[1] + " " + (String) persondetailsDeliver2[2] + " " + (String) persondetailsDeliver2[3]);
                                } else {
                                    unitDeliveredorders.put("deliveredto", (String) persondetailsDeliver2[1] + " " + (String) persondetailsDeliver2[2]);
                                }
                            }

                        }
                        deliveredOrders.add(unitDeliveredorders);
                    }
                } catch (Exception ex) {
                    System.out.println(ex);
                }
            }
        }

        model.addAttribute("deliveredOrders", deliveredOrders);
        model.addAttribute("serverdate", formatterwithtime.format(serverDate));
        return "inventoryAndSupplies/orders/processOrder/views/deliveredOrders";
    }

    @RequestMapping(value = "/managedeliveredordersbyydate", method = RequestMethod.GET)
    public String managedeliveredordersbyydate(Model model, HttpServletRequest request) {
        List<Map> deliveredOrders = new ArrayList<>();
        try {
            String date = request.getParameter("date");
            Date datedelivered = formatter.parse(date);
            //Fetch Facility Orders
            String[] paramsfacilityunitexpirorders = {"destinationstore", "status", "ordertype"};
            Object[] paramsValuesfacilitunitepiredorders = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), "DELIVERED", "INTERNAL"};
            String[] fieldsunitDeliveredorders = {"facilityorderid", "facilityorderno", "ordertype", "originstore", "isemergency", "dateprepared", "dateneeded", "approvedby", "status"};
            String whereunitDeliveredorders = "WHERE destinationstore=:destinationstore AND status=:status AND ordertype=:ordertype ORDER BY facilityorderid";
            List<Object[]> objunitsxipiredorders = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fieldsunitDeliveredorders, whereunitDeliveredorders, paramsfacilityunitexpirorders, paramsValuesfacilitunitepiredorders);
            if (objunitsxipiredorders != null) {
                Map<String, Object> unitDeliveredorders;
                for (Object[] ord44 : objunitsxipiredorders) {
                    unitDeliveredorders = new HashMap<>();
                    try {

                        //Fetch Order Items number
                        int noOfItems = 0;
                        String[] paramsnumberofitems = {"facilityorderid", "isdelivered", "datedelivered"};
                        Object[] paramsValuesnumberofitems = {ord44[0], true, datedelivered};
                        String wherenumberofitems = "WHERE facilityorderid=:facilityorderid AND isdelivered=:isdelivered AND datedelivered=:datedelivered";
                        noOfItems = genericClassService.fetchRecordCount(Facilityorderitems.class, wherenumberofitems, paramsnumberofitems, paramsValuesnumberofitems);
                        unitDeliveredorders.put("numberofitems", noOfItems);

                        if (noOfItems > 0) {
                            unitDeliveredorders.put("facilityorderid", ord44[0]);
                            unitDeliveredorders.put("facilityorderno", (String) ord44[1]);
                            unitDeliveredorders.put("ordertype", (String) ord44[2]);
                            unitDeliveredorders.put("originstore", ord44[3]);
                            unitDeliveredorders.put("dateprepared", format.format((Date) ord44[5]));
                            unitDeliveredorders.put("dateneeded", format.format((Date) ord44[6]));

                            //Fetch Facility Units
                            String[] paramsfunits = {"facilityunitid"};
                            Object[] paramsValuesfunit = {ord44[3]};
                            String wherefunit = "WHERE facilityunitid=:facilityunitid";
                            String[] fieldsfunit = {"facilityunitname"};
                            List<String> facilityunitnames = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fieldsfunit, wherefunit, paramsfunits, paramsValuesfunit);
                            if (facilityunitnames != null) {
                                unitDeliveredorders.put("orderingUnit", facilityunitnames.get(0));
                            }

                            //Fetch Delivered By
                            String[] paramsDeliveredby = {"facilityorderid", "isdelivered"};
                            Object[] paramsValuesDeliveredby = {ord44[0], true};
                            String whereDeliveredby = "WHERE facilityorderid=:facilityorderid AND isdelivered=:isdelivered ORDER BY datedelivered ASC LIMIT 1";
                            String[] fieldsDeliveredby = {"facilityorderitemsid", "deliveredby", "datedelivered", "deliveredto"};
                            List<Object[]> objDeliveredbystaff = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fieldsDeliveredby, whereDeliveredby, paramsDeliveredby, paramsValuesDeliveredby);
                            if (objDeliveredbystaff != null) {
                                Object[] deliveredby = objDeliveredbystaff.get(0);

                                //Query Staff details
                                String[] paramsPersondetailsDeliver = {"staffid"};
                                Object[] paramsValuesPersondetailsDeliver = {deliveredby[1]};
                                String[] fieldsPersondetailsDeliver = {"personid", "firstname", "lastname", "othernames"};
                                String wherePersondetailsDeliver = "WHERE staffid=:staffid";
                                List<Object[]> objPersondetailsDeliver = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fieldsPersondetailsDeliver, wherePersondetailsDeliver, paramsPersondetailsDeliver, paramsValuesPersondetailsDeliver);
                                if (objPersondetailsDeliver != null) {
                                    Object[] persondetailsDeliver = objPersondetailsDeliver.get(0);
                                    if (persondetailsDeliver[3] != null) {
                                        unitDeliveredorders.put("deliveredby", (String) persondetailsDeliver[1] + " " + (String) persondetailsDeliver[2] + " " + (String) persondetailsDeliver[3]);
                                    } else {
                                        unitDeliveredorders.put("deliveredby", (String) persondetailsDeliver[1] + " " + (String) persondetailsDeliver[2]);
                                    }
                                }
                                unitDeliveredorders.put("datedelivered", formatter.format((Date) deliveredby[2]));

                                String[] paramsPersondetailsDeliver2 = {"staffid"};
                                Object[] paramsValuesPersondetailsDeliver2 = {deliveredby[3]};
                                String[] fieldsPersondetailsDeliver2 = {"personid", "firstname", "lastname", "othernames"};
                                String wherePersondetailsDeliver2 = "WHERE staffid=:staffid";
                                List<Object[]> objPersondetailsDeliver2 = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fieldsPersondetailsDeliver2, wherePersondetailsDeliver2, paramsPersondetailsDeliver2, paramsValuesPersondetailsDeliver2);
                                if (objPersondetailsDeliver2 != null) {
                                    Object[] persondetailsDeliver2 = objPersondetailsDeliver2.get(0);
                                    if (persondetailsDeliver2[3] != null) {
                                        unitDeliveredorders.put("deliveredto", (String) persondetailsDeliver2[1] + " " + (String) persondetailsDeliver2[2] + " " + (String) persondetailsDeliver2[3]);
                                    } else {
                                        unitDeliveredorders.put("deliveredto", (String) persondetailsDeliver2[1] + " " + (String) persondetailsDeliver2[2]);
                                    }
                                }
                            }
                            deliveredOrders.add(unitDeliveredorders);
                        }
                    } catch (Exception ex) {
                        System.out.println(ex);
                    }
                }
            }
        } catch (Exception ex) {
            System.out.println("ERROR:" + ex);
        }
        model.addAttribute("deliveredOrders", deliveredOrders);
        model.addAttribute("serverdate", formatterwithtime.format(serverDate));
        return "inventoryAndSupplies/orders/processOrder/views/deliveredOrdersByDate";
    }

    @RequestMapping(value = "/approveorconsolidateordershome.htm", method = RequestMethod.GET)
    public String approveorconsolidateordershome(Model model, HttpServletRequest request) {
        List<Map> internalOrders = new ArrayList<>();
        int internalorders = 0;
        String[] params1 = {"originstore", "ordertype"};
        Object[] paramsValues1 = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), "INTERNAL"};
        String where1 = "WHERE originstore=:originstore AND ordertype=:ordertype";
        internalorders = genericClassService.fetchRecordCount(Facilityorder.class, where1, params1, paramsValues1);
        model.addAttribute("internalorders", internalorders);

        int externalorders = 0;
        String[] params2 = {"originstore", "ordertype", "status"};
        Object[] paramsValues2 = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), "EXTERNAL", "SUBMITTED"};
        String where2 = "WHERE originstore=:originstore AND ordertype=:ordertype AND status=:status";
        externalorders = genericClassService.fetchRecordCount(Facilityorder.class, where2, params2, paramsValues2);
        model.addAttribute("externalorders", externalorders);

        model.addAttribute("totalorders", internalorders + externalorders);

        String[] params4 = {"originstore", "ordertype", "submitted"};
        Object[] paramsValues4 = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), "INTERNAL", "SUBMITTED"};
        String where4 = "WHERE originstore=:originstore AND ordertype=:ordertype AND status=:submitted";
        String[] fields4 = {"facilityorderid", "destinationstore", "isemergency", "preparedby", "dateprepared", "dateneeded", "facilityorderno"};
        List<Object[]> facilityunitinternalorders = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fields4, where4, params4, paramsValues4);
        if (facilityunitinternalorders != null) {
            Map<String, Object> internalorderRow;
            for (Object[] facilityunitinternalorder : facilityunitinternalorders) {
                internalorderRow = new HashMap<>();

                internalorderRow.put("facilityorderno", facilityunitinternalorder[6]);
                internalorderRow.put("dateprepared", formatter.format((Date) facilityunitinternalorder[4]));
                internalorderRow.put("dateneeded", formatter.format((Date) facilityunitinternalorder[5]));
                internalorderRow.put("isemergency", facilityunitinternalorder[2]);
                internalorderRow.put("facilityorderid", facilityunitinternalorder[0]);

                String[] params = {"facilityunitid"};
                Object[] paramsValues = {facilityunitinternalorder[1]};
                String where = "WHERE facilityunitid=:facilityunitid";
                String[] fields = {"facilityunitname", "shortname"};
                List<Object[]> destinationunit = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields, where, params, paramsValues);
                if (destinationunit != null) {
                    internalorderRow.put("destinationfacilityunit", destinationunit.get(0)[0]);
                    internalorderRow.put("shortname", destinationunit.get(0)[1]);
                }

                String[] params8 = {"personid"};
                Object[] paramsValues8 = {facilityunitinternalorder[3]};
                String where8 = "WHERE personid=:personid";
                String[] fields8 = {"firstname", "lastname"};
                List<Object[]> personname = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields8, where8, params8, paramsValues8);
                if (personname != null) {
                    internalorderRow.put("personname", personname.get(0)[0] + " " + personname.get(0)[1]);
                }

                int internalordersitemscount = 0;
                String[] params9 = {"facilityorderid"};
                Object[] paramsValues9 = {(Long) facilityunitinternalorder[0]};
                String where9 = "WHERE facilityorderid=:facilityorderid";
                internalordersitemscount = genericClassService.fetchRecordCount(Facilityorderitems.class, where9, params9, paramsValues9);

                internalorderRow.put("internalordersitemscount", internalordersitemscount);
                internalOrders.add(internalorderRow);
            }
        }
        model.addAttribute("internalOrders", internalOrders);
        model.addAttribute("internalOrdersize", internalOrders.size());
        return "inventoryAndSupplies/orders/approveOrConsolidateOrders/approveOrConsolidateOrdersHome";
    }

    @RequestMapping(value = "/verifyfacilityunitorders.htm", method = RequestMethod.GET)
    public String verifyfacilityunitorders(Model model, HttpServletRequest request) {
        List<Map> internalOrdersitems = new ArrayList<>();

        String[] params = {"facilityorderid"};
        Object[] paramsValues = {Long.parseLong(request.getParameter("facilityorderid"))};
        String where = "WHERE facilityorderid=:facilityorderid";
        String[] fields = {"qtyordered", "itemid.itemid", "facilityorderitemsid", "approved"};
        List<Object[]> facilityorder = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fields, where, params, paramsValues);
        if (facilityorder != null) {
            Map<String, Object> internalorderitemRow;
            for (Object[] facilityord : facilityorder) {
                internalorderitemRow = new HashMap<>();
                internalorderitemRow.put("facilityorderitemsid", facilityord[2]);
                internalorderitemRow.put("approved", facilityord[3]);
                String[] params1 = {"itempackageid"};
                Object[] paramsValues1 = {facilityord[1]};
                String where1 = "WHERE itempackageid=:itempackageid";
                String[] fields1 = {"packagename", "packagequantity"};
                List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields1, where1, params1, paramsValues1);
                if (items != null) {
                    internalorderitemRow.put("genericname", items.get(0)[0]);
                    internalorderitemRow.put("packsize", items.get(0)[1]);
                    internalorderitemRow.put("qtyordered", facilityord[0]);
                    internalorderitemRow.put("stockbalance", String.format("%,d", facilityunitstockbalance(facilityord[1], request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))));

                    internalOrdersitems.add(internalorderitemRow);
                }
            }
        }
        model.addAttribute("internalOrdersitems", internalOrdersitems);
        model.addAttribute("facilityorderid", Long.parseLong(request.getParameter("facilityorderid")));

        model.addAttribute("facilityorderno", request.getParameter("facilityorderno"));
        model.addAttribute("destinationfacilityunit", request.getParameter("destinationfacilityunit"));
        model.addAttribute("isemergency", request.getParameter("isemergency"));
        model.addAttribute("personname", request.getParameter("personname"));
        model.addAttribute("dateneeded", request.getParameter("dateneeded"));
        model.addAttribute("dateprepared", request.getParameter("dateprepared"));

        return "inventoryAndSupplies/orders/approveOrConsolidateOrders/approveOrders/internalOrders/forms/orderItems";
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

    @RequestMapping(value = "/approveorunapprovefacilityunitorderitems.htm")
    public @ResponseBody
    String approveorunapprovefacilityunitorderitems(HttpServletRequest request) {
        String results = "";
        if ("approve".equals(request.getParameter("type"))) {
            String[] columns = {"approved", "approvedby", "dateapproved"};
            Object[] columnValues = {Boolean.TRUE, BigInteger.valueOf((Long) request.getSession().getAttribute("person_id")), new Date()};
            String pk = "facilityorderitemsid";
            Object pkValue = Long.parseLong(request.getParameter("facilityorderitemsid"));
            int result = genericClassService.updateRecordSQLSchemaStyle(Facilityorderitems.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                results = "success";
            }
        } else {
            String[] columns = {"approved", "approvedby", "dateapproved"};
            Object[] columnValues = {Boolean.FALSE, BigInteger.valueOf((Long) request.getSession().getAttribute("person_id")), new Date()};
            String pk = "facilityorderitemsid";
            Object pkValue = Long.parseLong(request.getParameter("facilityorderitemsid"));
            int result = genericClassService.updateRecordSQLSchemaStyle(Facilityorderitems.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                results = "success";
            }
        }
        return results;
    }

    @RequestMapping(value = "/submitosavepausefacilityuntord.htm")
    public @ResponseBody
    String submitosavepausefacilityuntord(HttpServletRequest request) {
        String results = "";
        if ("submit".equals(request.getParameter("type"))) {
            String[] params = {"facilityorderid", "approved"};
            Object[] paramsValues = {Long.parseLong(request.getParameter("facilityorderid")), Boolean.TRUE};
            String where = "WHERE facilityorderid=:facilityorderid AND approved=:approved";
            int internalordersitemsapproved = genericClassService.fetchRecordCount(Facilityorderitems.class, where, params, paramsValues);
            if (internalordersitemsapproved != 0) {
                String[] columns = {"status", "approved", "approvedby", "dateapproved"};
                Object[] columnValues = {"SENT", Boolean.TRUE, BigInteger.valueOf((Long) request.getSession().getAttribute("person_id")), new Date()};
                String pk = "facilityorderid";
                Object pkValue = Long.parseLong(request.getParameter("facilityorderid"));
                int result = genericClassService.updateRecordSQLSchemaStyle(Facilityorder.class, columns, columnValues, pk, pkValue, "store");
                if (result != 0) {
                    results = "success";
                }
            } else {
                results = "nothing";
            }
        } else {
            results = "success";
        }
        return results;
    }

    @RequestMapping(value = "/ordersitemsprocessmanagement.htm", method = RequestMethod.GET)
    public String manageTodayOrderItems(Model model, HttpServletRequest request, @ModelAttribute("facilityorderid") long facilityorderid) {
        List<Map> orderItemsList = new ArrayList<>();
        long orderingUnitId = Long.parseLong(request.getParameter("orderingunitid"));        
        //Fetch items in a new ORDER FOR PROCESSING
        String[] paramorderItems = {"facilityorderid", "approved"};
        Object[] paramsValuesorderItems = {facilityorderid, true};
        String[] fieldsorderItems = {"facilityorderitemsid", "qtyordered", "facilityorderid.facilityorderid", "itemid.itemid", "qtyapproved"};
        String whereorderItems = "WHERE facilityorderid=:facilityorderid AND approved=:approved";
        List<Object[]> objOrderItems = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fieldsorderItems, whereorderItems, paramorderItems, paramsValuesorderItems);
        Map<String, Object> items;
        if (objOrderItems != null) {
            for (Object[] itm : objOrderItems) {
                items = new HashMap<>();
                String[] paramsitemname = {"itempackageid"};
                Object[] paramsValuesitemname = {itm[3]};
                String whereitemname = "WHERE itempackageid=:itempackageid";
                String[] fieldsitemname = {"itempackageid", "itemcode", "packagename"};
                List<Object[]> objitemname = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fieldsitemname, whereitemname, paramsitemname, paramsValuesitemname);
                if (objitemname != null) {
                    for (Object[] name : objitemname) {
                        items.put("qtyapproved", itm[4]);
                        items.put("itemcode", (String) name[1]);
                        items.put("genericname", (String) name[2]);
                    }
                }
                int itemPicklistQuantity = 0;
                int transactionalstock = 0;
                long unshelved = 0;

                //FETCH BOOKED OFF QUANTITIES
                String[] paramsfacilityorderspickqty = {"destinationstore", "status", "ordertype", "facilityorderid"};
                Object[] paramsValuesfacilitorderspickqty = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), "SERVICED", "INTERNAL", facilityorderid};
                String[] fieldsunitorderspickqty = {"facilityorderid", "ordertype"};
                String whereunitorderspickqty = "WHERE destinationstore=:destinationstore AND status=:status AND ordertype=:ordertype AND facilityorderid!=:facilityorderid";
                List<Object[]> objunitpickqty = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fieldsunitorderspickqty, whereunitorderspickqty, paramsfacilityorderspickqty, paramsValuesfacilitorderspickqty);
                if (objunitpickqty != null) {
                    for (Object[] pickqty : objunitpickqty) {
                        String[] paramorderItemspkqty = {"itemid", "facilityorderid", "serviced"};
                        Object[] paramsValuesorderItemspkqty = {itm[3], pickqty[0], true};
//                        String[] fieldsorderItemspkqty = {"facilityorderitemsid", "qtyapproved"};
                        String[] fieldsorderItemspkqty = {"facilityorderitemsid", "qtysanctioned"};
                        String whereorderItemspkqty = "WHERE itemid=:itemid AND facilityorderid=:facilityorderid AND serviced=:serviced";
                        List<Object[]> objOrderItemspkqty = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fieldsorderItemspkqty, whereorderItemspkqty, paramorderItemspkqty, paramsValuesorderItemspkqty);
                        if (objOrderItemspkqty != null) {
                            for (Object[] pkqty : objOrderItemspkqty) {
//                                itemPicklistQuantity = itemPicklistQuantity + Integer.parseInt(String.valueOf(((BigInteger) pkqty[1]).longValue()));
                                itemPicklistQuantity = itemPicklistQuantity + Integer.parseInt(pkqty[1].toString());
                            }
                        }
                    }
                }
//                items.put("facilityorderitemsid", itm[0]);
//                String[] paramsCellitem = {"itemid", "facilityunitid"};
//                Object[] paramsValuesCellitem = {itm[3], Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))};
//                String whereCellitem = "WHERE itemid=:itemid AND facilityunitid=:facilityunitid";
//                String[] fieldsCellitem = {"celllabel", "daystoexpire", "quantityshelved", "packsize"};
//                List<Object[]> objCellitem = (List<Object[]>) genericClassService.fetchRecord(Cellitems.class, fieldsCellitem, whereCellitem, paramsCellitem, paramsValuesCellitem);
                //
                items.put("facilityorderitemsid", itm[0]);
                String[] paramsCellitem = {"itemid", "facilityunitid"};
                Object[] paramsValuesCellitem = {itm[3], Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))};
                String whereCellitem = "WHERE itemid=:itemid AND facilityunitid=:facilityunitid";
                String[] fieldsCellitem = {"celllabel", "daystoexpire", "quantityshelved", "packsize"};
                List<Object[]> objCellitem = (List<Object[]>) genericClassService.fetchRecord(Cellitems.class, fieldsCellitem, whereCellitem, paramsCellitem, paramsValuesCellitem, false);
                //
                int stockBalance = 0;
                //NEED THIS
                if (objCellitem != null) {
                    for (Object[] cellitem : objCellitem) {
                        if (cellitem[1] != null) {
                            if ((Integer) cellitem[1] > 0) {
                                stockBalance = stockBalance + (Integer) cellitem[2];
                            }
                        } else {
                            stockBalance = stockBalance + (Integer) cellitem[2];
                        }
                        transactionalstock = stockBalance;
                    }
                    items.put("packsize", (Integer) objCellitem.get(0)[3]);
                } else {
                    items.put("packsize", 1);
                }

                //FETCH Qty unshelved
                String[] paramsstockrecieved = {"itemid", "facilityunitid"};
                Object[] paramsValuesstockrecieved = {itm[3], Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))};
                String wherestockrecieved = "WHERE itemid=:itemid AND facilityunitid=:facilityunitid";
                String[] fieldsstockrecieved = {"quantityrecieved", "shelvedstock", "stockid"};
                List<Object[]> objstockrecieved = (List<Object[]>) genericClassService.fetchRecord(Stock.class, fieldsstockrecieved, wherestockrecieved, paramsstockrecieved, paramsValuesstockrecieved);
                if (objstockrecieved != null) {
                    for (Object[] stockrecieved : objstockrecieved) {
                        unshelved = unshelved + (Integer) stockrecieved[0] - (Integer) stockrecieved[1];
                    }
                    items.put("unshelvedstock", unshelved);
                }
                items.put("picklistqty", itemPicklistQuantity);
                items.put("transactionalStock", transactionalstock - itemPicklistQuantity);
                items.put("transactionalStocknocommas", (transactionalstock - itemPicklistQuantity));
                items.put("itemid", itm[3]);
                
                //
                items.put("stockbalance", String.format("%,d", facilityunitstockbalance(itm[3], orderingUnitId)));
                //

                orderItemsList.add(items);
            }
        }
        model.addAttribute("orderItemsList", orderItemsList);
        model.addAttribute("orderItemsListsize", orderItemsList.size());
        model.addAttribute("facilityorderid", facilityorderid);
        //
        model.addAttribute("orderingunitid", orderingUnitId);
        //
        return "inventoryAndSupplies/orders/processOrder/views/viewSentOrderItems";
    }

    @RequestMapping(value = "/viewfacilityunitorderitemsneworders.htm", method = RequestMethod.GET)
    public String viewfacilityunitorderitemsneworders(Model model, HttpServletRequest request, @ModelAttribute("facilityorderid") String facilityorderid) {
        List<Map> orderItemsList = new ArrayList<>();

        String[] paramorderItems = {"facilityorderid", "approved"};
        Object[] paramsValuesorderItems = {Long.parseLong(facilityorderid), true};
        String[] fieldsorderItems = {"facilityorderitemsid", "itemid.itemid", "qtyordered", "qtyapproved"};
        String whereorderItems = "WHERE facilityorderid=:facilityorderid AND approved=:approved";
        List<Object[]> objOrderItems4 = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fieldsorderItems, whereorderItems, paramorderItems, paramsValuesorderItems);
        Map<String, Object> items;
        if (objOrderItems4 != null) {
            for (Object[] itm : objOrderItems4) {
                items = new HashMap<>();
                String[] paramsitemname = {"itempackageid"};
                Object[] paramsValuesitemname = {itm[1]};
                String whereitemname = "WHERE itempackageid=:itempackageid";
                String[] fieldsitemname = {"itempackageid", "packagename", "packagequantity"};
                List<Object[]> objitemname = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fieldsitemname, whereitemname, paramsitemname, paramsValuesitemname);
                if (objitemname != null) {
                    for (Object[] name : objitemname) {
                        if (name[2] != null) {
                            items.put("packsize", name[2]);
                        } else {
                            items.put("packsize", 1);
                        }
                        items.put("genericname", (String) name[1]);
                        items.put("qtyordered", itm[2]);
                        items.put("qtyapproved", itm[3]);
                    }
                    orderItemsList.add(items);
                }
            }
        }
        model.addAttribute("orderItemsList", orderItemsList);
        return "inventoryAndSupplies/orders/processOrder/views/viewFacilityUnitOrderItemsnew";
    }

    @RequestMapping(value = "/viewfacilityunitorderitemsdeliveredorders.htm", method = RequestMethod.GET)
    public String viewfacilityunitorderitemsdeliveredorders(Model model, HttpServletRequest request, @ModelAttribute("facilityorderid") String facilityorderid) {

        List<Map> orderDeliveredItemsList = new ArrayList<>();
        String[] paramorderItems = {"facilityorderid", "isdelivered"};
        Object[] paramsValuesorderItems = {Long.parseLong(facilityorderid), true};
        String[] fieldsorderItems = {"facilityorderitemsid", "itemid.itemid", "qtyordered", "qtyapproved", "qtysanctioned"};
        String whereorderItems = "WHERE facilityorderid=:facilityorderid AND isdelivered=:isdelivered";
        List<Object[]> objOrderItems5 = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fieldsorderItems, whereorderItems, paramorderItems, paramsValuesorderItems);
        Map<String, Object> pickeditemsmap;
        if (objOrderItems5 != null) {
            for (Object[] itm : objOrderItems5) {
                int countQtyPicked = 0;
                pickeditemsmap = new HashMap<>();

                String[] paramorderQtyPicked = {"facilityorderitemsid"};
                Object[] paramsValuesorderQtyPicked = {itm[0]};
                String[] fieldsorderQtyPicked = {"orderissuanceid", "quantitydelivered"};
                String whereorderQtyPicked = "WHERE facilityorderitemsid=:facilityorderitemsid";
                List<Object[]> objOrderQtyPicked = (List<Object[]>) genericClassService.fetchRecord(Orderissuance.class, fieldsorderQtyPicked, whereorderQtyPicked, paramorderQtyPicked, paramsValuesorderQtyPicked);

                if (objOrderQtyPicked != null) {
                    for (Object[] pickedqty : objOrderQtyPicked) {
                        countQtyPicked = countQtyPicked + (Integer) pickedqty[1];
                    }
                    pickeditemsmap.put("quantitydelivered", countQtyPicked);
                }

                pickeditemsmap.put("qtyordered", itm[2]);
                pickeditemsmap.put("qtyapproved", itm[3]);
                pickeditemsmap.put("qtysanctioned", itm[4]);

                String[] paramsitemname = {"itempackageid"};
                Object[] paramsValuesitemname = {itm[1]};
                String whereitemname = "WHERE itempackageid=:itempackageid";
                String[] fieldsitemname = {"itempackageid", "packagename", "packagequantity"};
                List<Object[]> objitemname = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fieldsitemname, whereitemname, paramsitemname, paramsValuesitemname);
                if (objitemname != null) {
                    for (Object[] name : objitemname) {
                        if (name[2] != null) {
                            pickeditemsmap.put("packsize", name[2]);
                        } else {
                            pickeditemsmap.put("packsize", 1);
                        }
                        pickeditemsmap.put("genericname", (String) name[1]);
                    }
                    orderDeliveredItemsList.add(pickeditemsmap);
                }
            }
        }
        model.addAttribute("orderDeliveredItemsList", orderDeliveredItemsList);
        return "inventoryAndSupplies/orders/processOrder/views/viewFacilityUnitOrderItemsDerivered";
    }
    
    @RequestMapping(value = "/viewfacilityunitorderitemsdeliveredorders22.htm", method = RequestMethod.GET)
    public String viewfacilityunitorderitemsdeliveredorders22(Model model, HttpServletRequest request, @ModelAttribute("facilityorderid") String facilityorderid) {

        List<Map> orderDeliveredItemsList = new ArrayList<>();
        String[] paramorderItems = {"facilityorderid", "isdelivered"};
        Object[] paramsValuesorderItems = {Long.parseLong(facilityorderid), true};
        String[] fieldsorderItems = {"facilityorderitemsid", "itemid.itemid", "qtyordered", "qtyapproved", "qtysanctioned"};
        String whereorderItems = "WHERE facilityorderid=:facilityorderid AND isdelivered=:isdelivered";
        List<Object[]> objOrderItems5 = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fieldsorderItems, whereorderItems, paramorderItems, paramsValuesorderItems);
        Map<String, Object> pickeditemsmap;
        if (objOrderItems5 != null) {
            for (Object[] itm : objOrderItems5) {
                int countQtyPicked = 0;
                pickeditemsmap = new HashMap<>();

                String[] paramorderQtyPicked = {"facilityorderitemsid"};
                Object[] paramsValuesorderQtyPicked = {itm[0]};
                String[] fieldsorderQtyPicked = {"orderissuanceid", "quantitydelivered"};
                String whereorderQtyPicked = "WHERE facilityorderitemsid=:facilityorderitemsid";
                List<Object[]> objOrderQtyPicked = (List<Object[]>) genericClassService.fetchRecord(Orderissuance.class, fieldsorderQtyPicked, whereorderQtyPicked, paramorderQtyPicked, paramsValuesorderQtyPicked);

                if (objOrderQtyPicked != null) {
                    for (Object[] pickedqty : objOrderQtyPicked) {
                        countQtyPicked = countQtyPicked + (Integer) pickedqty[1];
                    }
                    pickeditemsmap.put("quantitydelivered", countQtyPicked);
                }

                pickeditemsmap.put("qtyordered", itm[2]);
                pickeditemsmap.put("qtyapproved", itm[3]);
                pickeditemsmap.put("qtysanctioned", itm[4]);

                String[] paramsitemname = {"itempackageid"};
                Object[] paramsValuesitemname = {itm[1]};
                String whereitemname = "WHERE itempackageid=:itempackageid";
                String[] fieldsitemname = {"itempackageid", "packagename"};
                List<Object[]> objitemname = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fieldsitemname, whereitemname, paramsitemname, paramsValuesitemname);
                if (objitemname != null) {
                    for (Object[] name : objitemname) {
                        pickeditemsmap.put("genericname", (String) name[1]);
                    }
                    orderDeliveredItemsList.add(pickeditemsmap);
                }
            }
        }
        model.addAttribute("orderDeliveredItemsList", orderDeliveredItemsList);
        return "inventoryAndSupplies/inventory/views/receiveSentOrders/viewUnitOrderItemsDerivered";
    }

    @RequestMapping(value = "/viewfacilityunitorderitemsFuture.htm", method = RequestMethod.GET)
    public String viewfacilityunitorderitemsFuture(Model model, HttpServletRequest request, @ModelAttribute("facilityorderid") String facilityorderid) {
        List<Map> orderItemsList = new ArrayList<>();

        String[] paramorderItems = {"facilityorderid"};
        Object[] paramsValuesorderItems = {Long.parseLong(facilityorderid)};
        String[] fieldsorderItems = {"facilityorderitemsid", "itemid.itemid", "qtyordered", "qtyapproved"};
        String whereorderItems = "WHERE facilityorderid=:facilityorderid";
        List<Object[]> objOrderItems6 = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fieldsorderItems, whereorderItems, paramorderItems, paramsValuesorderItems);
        Map<String, Object> items;
        if (objOrderItems6 != null) {
            for (Object[] itm : objOrderItems6) {
                items = new HashMap<>();
                String[] paramsitemname = {"itempackageid"};
                Object[] paramsValuesitemname = {itm[1]};
                String whereitemname = "WHERE itempackageid=:itempackageid";
                String[] fieldsitemname = {"itempackageid", "packagename", "packagequantity"};
                List<Object[]> objitemname = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fieldsitemname, whereitemname, paramsitemname, paramsValuesitemname);
                if (objitemname != null) {
                    for (Object[] name : objitemname) {
                        if (name[2] != null) {
                            items.put("packsize", name[2]);
                        } else {
                            items.put("packsize", 1);
                        }
                        items.put("genericname", (String) name[1]);
                        items.put("qtyordered", itm[2]);
                        items.put("qtyapproved", itm[3]);
                    }
                    orderItemsList.add(items);
                }
            }
        }
        model.addAttribute("orderItemsList", orderItemsList);
        return "inventoryAndSupplies/orders/processOrder/views/viewFacilityUnitOrderItemsnew";
    }

    @RequestMapping(value = "/viewfacilityunitorderitemsExpired.htm", method = RequestMethod.GET)
    public String viewfacilityunitorderitemsExpired(Model model, HttpServletRequest request, @ModelAttribute("facilityorderid") String facilityorderid) {
        try {
            List<Map<String, Object>> expiredItems = new ArrayList<>();
            String [] params = { "facilityorderid", "approved" };
            Object [] paramsValues = { Long.parseLong(facilityorderid), Boolean.TRUE };
            String where = "WHERE facilityorderid=:facilityorderid AND approved=:approved";
            String[] fields = {"facilityorderitemsid", "itemid.itemid", "qtyordered", "qtyapproved"};
            List<Object[]> expiredOrderItems = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fields, where, params, paramsValues);
            Map<String, Object> items;
            if (expiredOrderItems != null) {
                for (Object[] expiredOrderItem : expiredOrderItems) {
                    items = new HashMap<>();
                    params = new String [] {"itempackageid"};
                    paramsValues = new Object [] {expiredOrderItem[1]};
                    where = "WHERE itempackageid=:itempackageid";
                    fields = new String [] {"itempackageid", "packagename", "packagequantity"};
                    List<Object[]> itemNames = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields, where, params, paramsValues);
                    if (itemNames != null) {
                        for (Object[] itemName : itemNames) {
                            if (itemName[2] != null) {
                                items.put("packsize", itemName[2]);
                            } else {
                                items.put("packsize", 1);
                            }
                            items.put("genericname", (String) itemName[1]);
                            items.put("qtyordered", expiredOrderItem[2]);
                            items.put("qtyapproved", expiredOrderItem[3]);
                        }
                        expiredItems.add(items);
                    }
                }
            }
            model.addAttribute("orderItemsList", expiredItems);
        } catch(Exception e){
            System.out.println(e);
        }
        return "inventoryAndSupplies/orders/processOrder/views/viewFacilityUnitOrderItemsnew";
    }

    @RequestMapping(value = "/viewfacilityunitorderitemssanctionedorder.htm", method = RequestMethod.GET)
    public String viewfacilityunitorderitemssanctionedorder(Model model, HttpServletRequest request, @ModelAttribute("facilityorderid") String facilityorderid) {
        List<Map> orderItemsList = new ArrayList<>();

        String[] paramorderItems = {"facilityorderid", "serviced"};
        Object[] paramsValuesorderItems = {Long.parseLong(facilityorderid), true};
        String[] fieldsorderItems = {"facilityorderitemsid", "itemid.itemid", "qtysanctioned"};
        String whereorderItems = "WHERE facilityorderid=:facilityorderid AND serviced=:serviced";
        List<Object[]> objOrderItems8 = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fieldsorderItems, whereorderItems, paramorderItems, paramsValuesorderItems);
        Map<String, Object> items;
        if (objOrderItems8 != null) {
            for (Object[] itm : objOrderItems8) {
                items = new HashMap<>();
                String[] paramsitemname = {"itempackageid"};
                Object[] paramsValuesitemname = {itm[1]};
                String whereitemname = "WHERE itempackageid=:itempackageid";
                String[] fieldsitemname = {"itemid", "packagename", "packagequantity"};
                List<Object[]> objitemname = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fieldsitemname, whereitemname, paramsitemname, paramsValuesitemname);
                if (objitemname != null) {
                    for (Object[] name : objitemname) {
                        if (name[2] != null) {
                            items.put("packsize", name[2]);
                        } else {
                            items.put("packsize", 1);
                        }
                        items.put("genericname", (String) name[1]);
                        items.put("qtysanctioned", itm[2]);
                    }
                    orderItemsList.add(items);
                }
            }
        }
        model.addAttribute("orderItemsList", orderItemsList);
        return "inventoryAndSupplies/orders/processOrder/views/viewFacilityUnitOrderItemssanctioned";
    }

    @RequestMapping(value = "/viewfacilityunitorderitemspickedorder.htm", method = RequestMethod.GET)
    public String viewfacilityunitorderitemspickedorder(Model model, HttpServletRequest request, @ModelAttribute("facilityorderid") String facilityorderid) {
        List<Map> orderItemsList = new ArrayList<>();

        String[] paramorderItems = {"facilityorderid", "ispicked"};
        Object[] paramsValuesorderItems = {Long.parseLong(facilityorderid), true};
        String[] fieldsorderItems = {"facilityorderitemsid", "itemid.itemid", "qtysanctioned"};
        String whereorderItems = "WHERE facilityorderid=:facilityorderid AND ispicked=:ispicked";
        List<Object[]> objOrderItems9 = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fieldsorderItems, whereorderItems, paramorderItems, paramsValuesorderItems);
        Map<String, Object> pickeditemsmap;
        if (objOrderItems9 != null) {
            for (Object[] itm : objOrderItems9) {
                int countQtyPicked = 0;
                pickeditemsmap = new HashMap<>();
                pickeditemsmap.put("qtysanctioned", itm[2]);

                String[] paramorderQtyPicked = {"facilityorderitemsid"};
                Object[] paramsValuesorderQtyPicked = {itm[0]};
                String[] fieldsorderQtyPicked = {"orderissuanceid", "qtypicked"};
                String whereorderQtyPicked = "WHERE facilityorderitemsid=:facilityorderitemsid";
                List<Object[]> objOrderQtyPicked = (List<Object[]>) genericClassService.fetchRecord(Orderissuance.class, fieldsorderQtyPicked, whereorderQtyPicked, paramorderQtyPicked, paramsValuesorderQtyPicked);

                if (objOrderQtyPicked != null) {
                    for (Object[] pickedqty : objOrderQtyPicked) {
                        countQtyPicked = countQtyPicked + (Integer) pickedqty[1];
                    }
                    pickeditemsmap.put("qtypicked", countQtyPicked);
                }

                String[] paramsitemname = {"itempackageid"};
                Object[] paramsValuesitemname = {itm[1]};
                String whereitemname = "WHERE itempackageid=:itempackageid";
                String[] fieldsitemname = {"itemid", "packagename", "packagequantity"};
                List<Object[]> objitemname = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fieldsitemname, whereitemname, paramsitemname, paramsValuesitemname);
                if (objitemname != null) {
                    for (Object[] name : objitemname) {
                        if (name[2] != null) {
                            pickeditemsmap.put("packsize", name[2]);
                        } else {
                            pickeditemsmap.put("packsize", 1);
                        }
                        pickeditemsmap.put("genericname", (String) name[1]);
                    }
                    orderItemsList.add(pickeditemsmap);
                }
            }
        }
        model.addAttribute("orderItemsList", orderItemsList);
        return "inventoryAndSupplies/orders/processOrder/views/viewFacilityUnitOrderItemPicked";
    }

    @RequestMapping(value = "/generateorderpicklist.htm", method = RequestMethod.GET)
    public String generateOrderPickList(Model model, HttpServletRequest request, @ModelAttribute("facilityorderid") long facilityunitorderid) throws IOException {
        List<Map> qtylist = new ArrayList<>();
        List<Map> picklist = new ArrayList<>();
        List<Map> itemPickList = new ArrayList<>();

        String personidsession = request.getSession().getAttribute("person_id").toString();
        String[] paramsper = {"personid"};
        Object[] paramsValuesper = {BigInteger.valueOf(Long.parseLong(personidsession))};
        String whereper = "WHERE personid=:personid";
        String[] fieldsper = {"firstname", "lastname", "othernames"};
        List<Object[]> objper = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fieldsper, whereper, paramsper, paramsValuesper);
        if (objper != null) {
            Object[] objper2 = objper.get(0);
            if (objper2[2] != null) {
                model.addAttribute("name", objper2[0] + " " + objper2[1] + " " + objper2[2]);
            } else {
                model.addAttribute("name", objper2[0] + " " + objper2[1]);
            }
        }

        int picklisttablesize = 0;
        String[] paramqtyApproved = {"facilityorderid", "serviced"};
        Object[] paramsValuesqtyApproved = {facilityunitorderid, true};
        String[] fieldsqtyApproved = {"qtysanctioned", "itemid.itemid", "facilityorderitemsid"};
        String whereqtyApproved = "WHERE facilityorderid=:facilityorderid AND serviced=:serviced";
        List<Object[]> objOrderqtyApproved = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fieldsqtyApproved, whereqtyApproved, paramqtyApproved, paramsValuesqtyApproved);
        Map<String, Object> item;
        Map<String, Object> picklistqtys;
        if (objOrderqtyApproved != null) {
            for (Object[] itemQtysApproved : objOrderqtyApproved) {
                item = new HashMap<>();
                item.put("facilityorderitemsid", itemQtysApproved[2]);
                String[] paramitem = {"itempackageid"};
                Object[] paramsValueitem = {itemQtysApproved[1]};
                String whereitem = "WHERE itempackageid=:itempackageid";
                String[] fieldsitem = {"itemid", "packagename"};
                List<Object[]> objItem = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fieldsitem, whereitem, paramitem, paramsValueitem);
                if (objItem != null) {
                    Object[] itemdetails = objItem.get(0);
                    item.put("genericname", (String) itemdetails[1]);
                }

                List<Map> itemLocation = getItemslocations((long) itemQtysApproved[1], Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))));
                itemPickList = generatePickList(itemLocation, Integer.parseInt(String.valueOf(((Integer) itemQtysApproved[0]).longValue())));
                item.put("itemid", itemQtysApproved[1]);
                Collections.sort(itemPickList, sortCells);

                for (Map itemsstockdetails : itemPickList) {
                    picklistqtys = new HashMap<>();
                    picklistqtys.put("facilityorderitemsid", itemQtysApproved[2]);
                    picklistqtys.put("cellid", itemsstockdetails.get("cellid"));
                    picklistqtys.put("stockid", itemsstockdetails.get("stockid"));
                    picklistqtys.put("qtypicked", 0);
                    picklist.add(picklistqtys);
                }

                int itemPickListsize = itemPickList.size();
                picklisttablesize = picklisttablesize + itemPickListsize;
                item.put("pick", itemPickList);
                item.put("quantityapproved", itemQtysApproved[0]);
                qtylist.add(item);
            }
        }

        String jsonqtypicklist = "";
        try {
            jsonqtypicklist = new ObjectMapper().writeValueAsString(picklist);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }

        String jsonqtylist = "";
        try {
            jsonqtylist = new ObjectMapper().writeValueAsString(jsonqtypicklist);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }
        model.addAttribute("date", formatter.format(new Date()));
        model.addAttribute("picklisttablesize", picklisttablesize);
        model.addAttribute("facilityorderid", facilityunitorderid);
        model.addAttribute("items", qtylist);
        model.addAttribute("jsonitems", jsonqtylist);
        model.addAttribute("jsonqtypicklist", jsonqtypicklist);
        return "inventoryAndSupplies/orders/processOrder/views/pickList";
    }

    @RequestMapping(value = "/savesentApprovedOrders.htm", method = RequestMethod.GET)
    public @ResponseBody
    String saveSentApprovedOrders(Model model, HttpServletRequest request, @ModelAttribute("facilityorderid") long facilityorderid) throws IOException {
        try {
            final long facilityUnitId = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString());
            final long staffId = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginStaffid").toString());
            final long orderingUnitId = Long.parseLong(request.getParameter("orderingunitid"));
            List<Map> itemorderqty = (ArrayList) new ObjectMapper().readValue(request.getParameter("qtyorderedvalues"), List.class);
            for (Map itemone : itemorderqty) {
                long facilityorderitemsid = Long.parseLong((String) itemone.get("name"));                
                if (itemone.get("value") != "") {
                    //
                    boolean initialRequest = (request.getParameter("initialrequest") != null) ? Boolean.valueOf(request.getParameter("initialrequest")): false;
                    int packSize = 0;
                    int bookedSum = 0, transactionalstock = 0, stockBalance = 0;
                    long itemId = Long.parseLong(itemone.get("itemid").toString());
                    //
                    String[] params = {"itemid", "facilityunitid"};
                    Object[] paramsValues = {itemId, Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))};
                    String where = "WHERE itemid=:itemid AND facilityunitid=:facilityunitid";
                    String[] fields = {"celllabel", "daystoexpire", "quantityshelved", "packsize"};
                    List<Object[]> cellItems = (List<Object[]>) genericClassService.fetchRecord(Cellitems.class, fields, where, params, paramsValues, false);
                    //   
                    //NEED THIS
                    if (cellItems != null) {
                        for (Object[] cellitem : cellItems) {
                            if (cellitem[1] != null) {
                                if ((Integer) cellitem[1] > 0) {
                                    stockBalance = stockBalance + Integer.parseInt(cellitem[2].toString());
                                }
                            } else {
                                stockBalance = stockBalance + Integer.parseInt(cellitem[2].toString());
                            }
                            transactionalstock = stockBalance;
                        }
                        packSize = ((cellItems.get(0)[3] != null)) ? Integer.parseInt(cellItems.get(0)[3].toString()) : 1;
                        packSize = (packSize <= 0)? 1 : packSize;
                    }
                    //FETCH BOOKED OFF QUANTITIES
                    params = new String[] {"destinationstore", "status", "ordertype", "facilityorderid"};
                    paramsValues = new Object[] {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), "SERVICED", "INTERNAL", facilityorderid};
                    fields = new String[] {"facilityorderid", "ordertype"};
                    where = "WHERE destinationstore=:destinationstore AND status=:status AND ordertype=:ordertype AND facilityorderid!=:facilityorderid";
                    List<Object[]> bookedQuantities = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fields, where, params, paramsValues);
                    if (bookedQuantities != null) {
                        for (Object[] bookedQuantity : bookedQuantities) {
                            params = new String [] {"itemid", "facilityorderid", "serviced"};
                            paramsValues = new Object [] {itemId, Long.parseLong(bookedQuantity[0].toString()), Boolean.TRUE};
                            fields = new String [] {"facilityorderitemsid", "qtyapproved"};
                            where = "WHERE itemid=:itemid AND facilityorderid=:facilityorderid AND serviced=:serviced";
                            List<Object[]> bookedItemQuantities = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fields, where, params, paramsValues);
                            if (bookedItemQuantities != null) {
                                for (Object[] bookedItemQuantity : bookedItemQuantities) {
                                    bookedSum += Integer.parseInt(bookedItemQuantity[1].toString());
                                }
                            }
                        }
                    }                
                    //
                    packSize = (packSize <= 0)? 1 : packSize;
                    if((Integer.parseInt(itemone.get("value").toString()) >  ((transactionalstock - bookedSum) / packSize)) && initialRequest == true){
                        return String.format("Demanded quantity is greater than available stock. If you proceed, the transaction will be reduced to the available stock");
                    }
                    //
//                    if (!itemone.get("value").equals(0)) {
                      if ((itemone.get("value") != null) && (!(Integer.parseInt(itemone.get("value").toString()) <= 0))) {
                        int quantityapproved = Integer.parseInt((String) itemone.get("value"));
                        //
                        quantityapproved = ((Integer.parseInt(itemone.get("value").toString()) >  (transactionalstock - bookedSum)) && initialRequest == false) ? (transactionalstock - bookedSum) : quantityapproved;
                        //
                        if(quantityapproved > 0){
                            Long currStaffId = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");

                            String[] columns = {"serviced", "servicedby", "dateserviced", "qtysanctioned"};
                            Object[] columnValues = {true, BigInteger.valueOf(currStaffId), new Date(), quantityapproved};
                            String pk = "facilityorderitemsid";
                            Object pkValue = facilityorderitemsid;
                            if (quantityapproved > 0) {
                                genericClassService.updateRecordSQLSchemaStyle(Facilityorderitems.class, columns, columnValues, pk, pkValue, "store");
                            }
                        }
                    } else {    
                        long unservicedorderId = 0L;
                        fields = new String [] { "unservicedorderid", "orderid", "dateadded", "addedby", "servicingunitid", "orderingunitid" };
                        params = new String [] { "servicingunitid", "orderid" };
                        paramsValues = new Object [] { facilityUnitId, facilityorderid };
                        where = "WHERE servicingunitid=:servicingunitid AND orderid=:orderid";
                        List<Object[]> unservicedOrders = (List<Object[]>) genericClassService.fetchRecord(Unservicedorder.class, fields, where, params, paramsValues);                                               

                        if(unservicedOrders == null){
                            Unservicedorder unservicedorder = new Unservicedorder();
                            unservicedorder.setOrderid(facilityorderid);
                            unservicedorder.setAddedby(staffId);
                            unservicedorder.setDateadded(new Date());
                            unservicedorder.setOrderingunitid(orderingUnitId);
                            unservicedorder.setServicingunitid(facilityUnitId);
                            Object saved = genericClassService.saveOrUpdateRecordLoadObject(unservicedorder);  
                            unservicedorderId = ((Unservicedorder) saved).getUnservicedorderid();
                        } else {                            
                            unservicedorderId = Long.parseLong(unservicedOrders.get(0)[0].toString());
                        }
                        Unservicedorderitem unservicedOrderItem = new Unservicedorderitem();
                        unservicedOrderItem.setUnservicedorderid(unservicedorderId);
                        unservicedOrderItem.setItemid(itemId);
                        unservicedOrderItem.setAddedby(staffId);
                        unservicedOrderItem.setDateadded(new Date());
                        Object saved = genericClassService.saveOrUpdateRecordLoadObject(unservicedOrderItem);
                    }
                }
            }
        } catch (Exception ex) {
            System.out.println(ex);
        }

        try {
            String[] columns = {"status"};
            Object[] columnValues = {"SERVICED"};
            String pk = "facilityorderid";
            Object pkValue = facilityorderid;
            genericClassService.updateRecordSQLSchemaStyle(Facilityorder.class, columns, columnValues, pk, pkValue, "store");
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return "success";
    }

    @RequestMapping(value = "/submitOrderePickedList.htm", method = RequestMethod.GET)
    public @ResponseBody
    String submitOrderePickedList(Model model, HttpServletRequest request, @ModelAttribute("facilityorderid") long facilityorderid) throws IOException {
        List<Map> stockList = new ArrayList<>();
        Set<Long> facilityorderitemsset = new HashSet<>();
        Long currStaffId = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");

        List<Map> itemorderqty = (ArrayList) new ObjectMapper().readValue(request.getParameter("qtypickedvalues"), List.class);
        for (Map picked : itemorderqty) {
            int qtyPicked = (int) picked.get("qtypicked");
            if (qtyPicked > 0) {
                Long cellid = Long.parseLong(picked.get("cellid").toString());
                Long stockid = Long.parseLong(picked.get("stockid").toString());
                Long orderitemid = Long.parseLong(picked.get("facilityorderitemsid").toString());
                boolean stockExists = false;
                for (int i = 0; i < stockList.size(); i++) {
                    if ((stockList.get(i).get("stockid").toString()).equals(picked.get("stockid").toString())) {
                        int qty = (int) stockList.get(i).get("qty") + qtyPicked;
                        stockList.get(i).put("qty", qty);
                        stockExists = true;
                        break;
                    }
                }
                if (!stockExists) {
                    Map<String, Object> stockLog = new HashMap<>();
                    stockLog.put("stockid", stockid);
                    stockLog.put("qty", qtyPicked);
                    stockLog.put("orderitem", orderitemid);
                    stockList.add(stockLog);
                }
                //Fetch Previous cell qty value.
                String[] paramscellqty = {"stockid", "cellid"};
                Object[] paramsValuescellqty = {BigInteger.valueOf(stockid), BigInteger.valueOf(cellid)};
                String wherecellqty = "WHERE stockid=:stockid AND cellid=:cellid";
                String[] fieldscellqty = {"shelfstockid", "quantityshelved", "packsize"};
                List<Object[]> objcellqty = (List<Object[]>) genericClassService.fetchRecord(Cellitems.class, fieldscellqty, wherecellqty, paramscellqty, paramsValuescellqty);
                if (objcellqty != null) {
                    Object[] cellqty = objcellqty.get(0);
                    // UPDATE CELL VALUES
                    String[] columnscellqty = {"quantityshelved", "updatedby", "dateupdated"};
                    Object[] columnValuescellqty = {((Integer) cellqty[1] - (qtyPicked * (Integer) cellqty[2])), currStaffId.intValue(), new Date()};
                    String pkcellqty = "shelfstockid";
                    Object pkValuecellqty = cellqty[0];
                    genericClassService.updateRecordSQLSchemaStyle(Shelfstock.class, columnscellqty, columnValuescellqty, pkcellqty, pkValuecellqty, "store");
                    new ShelfActivityLog(genericClassService, cellid.intValue(), stockid.intValue(), currStaffId.intValue(), "OUT", qtyPicked * (Integer) cellqty[2]).start();
                }
            }
        }

        for (Map log : stockList) {
            Orderissuance orderissuance = new Orderissuance();
            orderissuance.setFacilityorderitemsid(new Facilityorderitems((long) log.get("orderitem")));
            orderissuance.setQtypicked((int) log.get("qty"));
            orderissuance.setStockid(new Stock((long) log.get("stockid")));
            genericClassService.saveOrUpdateRecordLoadObject(orderissuance);
            facilityorderitemsset.add((long) log.get("orderitem"));
        }
        String[] columns = {"status"};
        Object[] columnValues = {"PICKED"};
        String pk = "facilityorderid";
        Object pkValue = facilityorderid;
        genericClassService.updateRecordSQLSchemaStyle(Facilityorder.class, columns, columnValues, pk, pkValue, "store");

        for (long facilityorderitemsid : facilityorderitemsset) {
            String[] columns2 = {"ispicked", "pickedby", "datepicked", "isdelivered"};
            Object[] columnValues2 = {true, BigInteger.valueOf(currStaffId), new Date(), false};
            String pk2 = "facilityorderitemsid";
            Object pkValue2 = facilityorderitemsid;
            genericClassService.updateRecordSQLSchemaStyle(Facilityorderitems.class, columns2, columnValues2, pk2, pkValue2, "store");
        }
        return "";
    }

    @RequestMapping(value = "/viewSentApprovedOrders.htm", method = RequestMethod.GET)
    public String viewSentApprovedOrders(Model model, HttpServletRequest request) {
        List<Map> sentApprovedOrderItemQtyList = new ArrayList<>();

        String[] paramsfacilityunitapprovedorders = {"status", "ordertype", "destinationstore"};
        Object[] paramsValuesfacilitunitapprovedorders = {"SERVICED", "INTERNAL", BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))))};
        String[] fieldsunitapprovedorders = {"facilityorderid", "facilityorderno", "ordertype", "originstore", "isemergency", "dateprepared", "dateneeded", "approvedby", "status"};
        String whereunitapprovedorders = "WHERE status=:status AND ordertype=:ordertype AND destinationstore=:destinationstore ORDER BY facilityorderid";
        List<Object[]> objunitapprovedorders = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fieldsunitapprovedorders, whereunitapprovedorders, paramsfacilityunitapprovedorders, paramsValuesfacilitunitapprovedorders);
        Map<String, Object> unitApprovedorders;
        if (objunitapprovedorders != null) {
            for (Object[] ord33 : objunitapprovedorders) {
                unitApprovedorders = new HashMap<>();

                try {
                    //Fetch Serviced By
                    String[] paramsServicedby = {"facilityorderid", "serviced"};
                    Object[] paramsValuesServicedby = {ord33[0], true};
                    String whereServicedby = "WHERE facilityorderid=:facilityorderid AND serviced=:serviced ORDER BY dateserviced ASC LIMIT 1";
                    String[] fieldsServicedby = {"facilityorderitemsid", "servicedby", "dateserviced"};
                    List<Object[]> objServicedbystaff = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fieldsServicedby, whereServicedby, paramsServicedby, paramsValuesServicedby);
                    if (objServicedbystaff != null) {
                        Object[] servicedby = objServicedbystaff.get(0);

                        //Fetch Order Items number
                        int noOfItems = 0;
                        String[] paramsnumberofitems = {"facilityorderid", "serviced"};
                        Object[] paramsValuesnumberofitems = {ord33[0], true};
                        String wherenumberofitems = "WHERE facilityorderid=:facilityorderid AND serviced=:serviced";
                        noOfItems = genericClassService.fetchRecordCount(Facilityorderitems.class, wherenumberofitems, paramsnumberofitems, paramsValuesnumberofitems);
                        unitApprovedorders.put("numberofitems", noOfItems);

                        if (noOfItems > 0) {
                            unitApprovedorders.put("dateprepared", format.format((Date) ord33[5]));
                            unitApprovedorders.put("dateneeded", format.format((Date) ord33[6]));
                            unitApprovedorders.put("facilityorderid", ord33[0]);
                            unitApprovedorders.put("facilityorderno", (String) ord33[1]);
                            unitApprovedorders.put("ordertype", (String) ord33[2]);
                            unitApprovedorders.put("originstore", ord33[3]);

                            //Fetch Facility Units
                            String[] paramsfunits = {"facilityunitid"};
                            Object[] paramsValuesfunit = {ord33[3]};
                            String wherefunit = "WHERE facilityunitid=:facilityunitid";
                            String[] fieldsfunit = {"facilityunitname"};
                            List<String> facilityunitnames = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fieldsfunit, wherefunit, paramsfunits, paramsValuesfunit);
                            if (facilityunitnames != null) {
                                unitApprovedorders.put("orderingUnit", facilityunitnames.get(0));
                            }

                            //Query Staff details
                            String[] paramsPersondetails = {"staffid"};
                            Object[] paramsValuesPersondetails = {servicedby[1]};
                            String[] fieldsPersondetails = {"personid", "firstname", "lastname", "othernames"};
                            String wherePersondetails = "WHERE staffid=:staffid";
                            List<Object[]> objPersondetails = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fieldsPersondetails, wherePersondetails, paramsPersondetails, paramsValuesPersondetails);
                            if (objPersondetails != null) {
                                Object[] persondetails = objPersondetails.get(0);
                                if (persondetails[3] != null) {
                                    unitApprovedorders.put("servicedby", (String) persondetails[1] + " " + (String) persondetails[2] + " " + (String) persondetails[3]);
                                } else {
                                    unitApprovedorders.put("servicedby", (String) persondetails[1] + " " + (String) persondetails[2]);
                                }
                            }
                            unitApprovedorders.put("dateserviced", formatter.format((Date) servicedby[2]));

                            sentApprovedOrderItemQtyList.add(unitApprovedorders);
                        }
                    }
                } catch (Exception ex) {
                    System.out.println("ERROR:" + ex);
                }
            }
        }
        model.addAttribute("sentApprovedOrderItemQtyList", sentApprovedOrderItemQtyList);
        model.addAttribute("serverdate", formatterwithtime.format(serverDate));
        return "inventoryAndSupplies/orders/processOrder/views/sentProcessedApprovedOrders";
    }

    @RequestMapping(value = "/viewSentApprovedOrdersByDate.htm", method = RequestMethod.GET)
    public String viewSentApprovedOrdersByDate(Model model, HttpServletRequest request) {
        List<Map> sentApprovedOrderItemQtyList = new ArrayList<>();
        try {
            String date = request.getParameter("date");
            Date datesanctioned = formatter.parse(date);

            String[] paramsfacilityunitapprovedorders = {"status", "ordertype", "destinationstore"};
            Object[] paramsValuesfacilitunitapprovedorders = {"SERVICED", "INTERNAL", BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))))};
            String[] fieldsunitapprovedorders = {"facilityorderid", "facilityorderno", "ordertype", "originstore", "isemergency", "dateprepared", "dateneeded", "approvedby", "status"};
            String whereunitapprovedorders = "WHERE status=:status AND ordertype=:ordertype AND destinationstore=:destinationstore";
            List<Object[]> objunitapprovedorders = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fieldsunitapprovedorders, whereunitapprovedorders, paramsfacilityunitapprovedorders, paramsValuesfacilitunitapprovedorders);
            Map<String, Object> unitApprovedorders;
            if (objunitapprovedorders != null) {
                for (Object[] ord33 : objunitapprovedorders) {
                    unitApprovedorders = new HashMap<>();

                    try {
                        //Fetch Serviced By
                        String[] paramsServicedby = {"facilityorderid", "serviced"};
                        Object[] paramsValuesServicedby = {ord33[0], true};
                        String whereServicedby = "WHERE facilityorderid=:facilityorderid AND serviced=:serviced ORDER BY dateserviced ASC LIMIT 1";
                        String[] fieldsServicedby = {"facilityorderitemsid", "servicedby", "dateserviced"};
                        List<Object[]> objServicedbystaff = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fieldsServicedby, whereServicedby, paramsServicedby, paramsValuesServicedby);
                        if (objServicedbystaff != null) {
                            Object[] servicedby = objServicedbystaff.get(0);

                            //Fetch Order Items number
                            int noOfItems = 0;
                            String[] paramsnumberofitems = {"facilityorderid", "serviced", "dateserviced"};
                            Object[] paramsValuesnumberofitems = {ord33[0], true, datesanctioned};
                            String wherenumberofitems = "WHERE facilityorderid=:facilityorderid AND serviced=:serviced AND dateserviced=:dateserviced";
                            noOfItems = genericClassService.fetchRecordCount(Facilityorderitems.class, wherenumberofitems, paramsnumberofitems, paramsValuesnumberofitems);
                            unitApprovedorders.put("numberofitems", noOfItems);

                            if (noOfItems > 0) {
                                unitApprovedorders.put("dateneeded", format.format((Date) ord33[6]));
                                unitApprovedorders.put("facilityorderid", ord33[0]);
                                unitApprovedorders.put("facilityorderno", (String) ord33[1]);
                                unitApprovedorders.put("ordertype", (String) ord33[2]);
                                unitApprovedorders.put("originstore", ord33[3]);

                                //Fetch Facility Units
                                String[] paramsfunits = {"facilityunitid"};
                                Object[] paramsValuesfunit = {ord33[3]};
                                String wherefunit = "WHERE facilityunitid=:facilityunitid";
                                String[] fieldsfunit = {"facilityunitname"};
                                List<String> facilityunitnames = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fieldsfunit, wherefunit, paramsfunits, paramsValuesfunit);
                                if (facilityunitnames != null) {
                                    unitApprovedorders.put("orderingUnit", facilityunitnames.get(0));
                                }

                                //Query Staff details
                                String[] paramsPersondetails = {"staffid"};
                                Object[] paramsValuesPersondetails = {servicedby[1]};
                                String[] fieldsPersondetails = {"personid", "firstname", "lastname", "othernames"};
                                String wherePersondetails = "WHERE staffid=:staffid";
                                List<Object[]> objPersondetails = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fieldsPersondetails, wherePersondetails, paramsPersondetails, paramsValuesPersondetails);
                                if (objPersondetails != null) {
                                    Object[] persondetails = objPersondetails.get(0);
                                    if (persondetails[3] != null) {
                                        unitApprovedorders.put("servicedby", (String) persondetails[1] + " " + (String) persondetails[2] + " " + (String) persondetails[3]);
                                    } else {
                                        unitApprovedorders.put("servicedby", (String) persondetails[1] + " " + (String) persondetails[2]);
                                    }
                                }
                                unitApprovedorders.put("dateserviced", formatter.format((Date) servicedby[2]));

                                sentApprovedOrderItemQtyList.add(unitApprovedorders);
                            }
                        }
                    } catch (Exception ex) {
                        System.out.println("ERROR:" + ex);
                    }
                }
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        model.addAttribute("sentApprovedOrderItemQtyList", sentApprovedOrderItemQtyList);
        return "inventoryAndSupplies/orders/processOrder/views/sentProcessedOrdersbyyDate";
    }

    @RequestMapping(value = "/viewReadyToIssueOrders.htm", method = RequestMethod.GET)
    public String viewReadyToIssueOrders(Model model, HttpServletRequest request) {
        List<Map> pickedReadyToIssueList = new ArrayList<>();

        String[] paramsfacilityunitapprovedorders = {"status", "ordertype", "destinationstore"};
        Object[] paramsValuesfacilitunitapprovedorders = {"PICKED", "INTERNAL", BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))))};
        String[] fieldsunitapprovedorders = {"facilityorderid", "facilityorderno", "ordertype", "originstore", "isemergency", "dateprepared", "dateneeded", "approvedby", "status"};
        String whereunitapprovedorders = "WHERE status=:status AND ordertype=:ordertype AND destinationstore=:destinationstore";
        List<Object[]> objunitapprovedorders = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fieldsunitapprovedorders, whereunitapprovedorders, paramsfacilityunitapprovedorders, paramsValuesfacilitunitapprovedorders);
        Map<String, Object> unitApprovedorders;
        if (objunitapprovedorders != null) {
            for (Object[] ord33 : objunitapprovedorders) {
                unitApprovedorders = new HashMap<>();
                //Fetch Order Items number
                int noOfItems = 0;
                String[] paramsnumberofitems = {"facilityorderid", "ispicked"};
                Object[] paramsValuesnumberofitems = {ord33[0], true};
                String wherenumberofitems = "WHERE facilityorderid=:facilityorderid AND ispicked=:ispicked";
                noOfItems = genericClassService.fetchRecordCount(Facilityorderitems.class, wherenumberofitems, paramsnumberofitems, paramsValuesnumberofitems);
                unitApprovedorders.put("numberofitems", noOfItems);

                if (noOfItems > 0) {
                    //Fetch Facility Units
                    String[] paramsfunits = {"facilityunitid"};
                    Object[] paramsValuesfunit = {ord33[3]};
                    String wherefunit = "WHERE facilityunitid=:facilityunitid";
                    String[] fieldsfunit = {"facilityunitname"};
                    List<String> facilityunitnames = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fieldsfunit, wherefunit, paramsfunits, paramsValuesfunit);
                    if (facilityunitnames != null) {
                        unitApprovedorders.put("orderingUnit", facilityunitnames.get(0));
                    }
                    unitApprovedorders.put("dateprepared", format.format((Date) ord33[5]));
                    unitApprovedorders.put("dateneeded", format.format((Date) ord33[6]));
                    unitApprovedorders.put("facilityorderid", ord33[0]);
                    unitApprovedorders.put("facilityorderno", (String) ord33[1]);
                    unitApprovedorders.put("ordertype", (String) ord33[2]);
                    unitApprovedorders.put("originstore", ord33[3]);

                    //Fetch Picked By
                    String[] paramsPickedby = {"facilityorderid", "ispicked"};
                    Object[] paramsValuesPickedby = {ord33[0], true};
                    String wherePickedby = "WHERE facilityorderid=:facilityorderid AND ispicked=:ispicked ORDER BY datepicked ASC LIMIT 1";
                    String[] fieldsPickedby = {"facilityorderitemsid", "pickedby", "datepicked"};
                    List<Object[]> objPickedbystaff = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fieldsPickedby, wherePickedby, paramsPickedby, paramsValuesPickedby);
                    if (objPickedbystaff != null) {
                        Object[] pickedby = objPickedbystaff.get(0);

                        //Query Staff details
                        String[] paramsPersondetailspick = {"staffid"};
                        Object[] paramsValuesPersondetailspick = {pickedby[1]};
                        String[] fieldsPersondetailspick = {"personid", "firstname", "lastname", "othernames"};
                        String wherePersondetailspick = "WHERE staffid=:staffid";
                        List<Object[]> objPersondetailspick = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fieldsPersondetailspick, wherePersondetailspick, paramsPersondetailspick, paramsValuesPersondetailspick);
                        if (objPersondetailspick != null) {
                            Object[] persondetailspick = objPersondetailspick.get(0);
                            if (persondetailspick[3] != null) {
                                unitApprovedorders.put("pickedby", (String) persondetailspick[1] + " " + (String) persondetailspick[2] + " " + (String) persondetailspick[3]);
                            } else {
                                unitApprovedorders.put("pickedby", (String) persondetailspick[1] + " " + (String) persondetailspick[2]);
                            }
                        }
                        unitApprovedorders.put("datepicked", formatter.format((Date) pickedby[2]));

                        pickedReadyToIssueList.add(unitApprovedorders);
                    }
                }
            }
        }

        model.addAttribute("pickedReadyToIssueList", pickedReadyToIssueList);
        model.addAttribute("serverdate", formatterwithtime.format(serverDate));

        return "inventoryAndSupplies/orders/processOrder/views/viewReadyToIssue";
    }

    @RequestMapping(value = "/viewReadyToIssueOrdersByDate.htm", method = RequestMethod.GET)
    public String viewReadyToIssueOrdersByDate(Model model, HttpServletRequest request) {
        List<Map> pickedReadyToIssueList = new ArrayList<>();

        try {
            String date = request.getParameter("date");
            Date datepicked = formatter.parse(date);

            String[] paramsfacilityunitapprovedorders = {"status", "ordertype", "destinationstore"};
            Object[] paramsValuesfacilitunitapprovedorders = {"PICKED", "INTERNAL", BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))))};
            String[] fieldsunitapprovedorders = {"facilityorderid", "facilityorderno", "ordertype", "originstore", "isemergency", "dateprepared", "dateneeded", "approvedby", "status"};
            String whereunitapprovedorders = "WHERE status=:status AND ordertype=:ordertype AND destinationstore=:destinationstore ORDER BY facilityorderid";
            List<Object[]> objunitapprovedorders = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fieldsunitapprovedorders, whereunitapprovedorders, paramsfacilityunitapprovedorders, paramsValuesfacilitunitapprovedorders);
            Map<String, Object> unitApprovedorders;
            if (objunitapprovedorders != null) {
                for (Object[] ord33 : objunitapprovedorders) {
                    unitApprovedorders = new HashMap<>();
                    //Fetch Order Items number
                    int noOfItems = 0;
                    String[] paramsnumberofitems = {"facilityorderid", "ispicked", "datepicked"};
                    Object[] paramsValuesnumberofitems = {ord33[0], true, datepicked};
                    String wherenumberofitems = "WHERE facilityorderid=:facilityorderid AND ispicked=:ispicked AND datepicked=:datepicked";
                    noOfItems = genericClassService.fetchRecordCount(Facilityorderitems.class, wherenumberofitems, paramsnumberofitems, paramsValuesnumberofitems);
                    unitApprovedorders.put("numberofitems", noOfItems);

                    if (noOfItems > 0) {
                        //Fetch Facility Units
                        String[] paramsfunits = {"facilityunitid"};
                        Object[] paramsValuesfunit = {ord33[3]};
                        String wherefunit = "WHERE facilityunitid=:facilityunitid";
                        String[] fieldsfunit = {"facilityunitname"};
                        List<String> facilityunitnames = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fieldsfunit, wherefunit, paramsfunits, paramsValuesfunit);
                        if (facilityunitnames != null) {
                            unitApprovedorders.put("orderingUnit", facilityunitnames.get(0));
                        }

                        unitApprovedorders.put("dateneeded", format.format((Date) ord33[6]));
                        unitApprovedorders.put("facilityorderid", ord33[0]);
                        unitApprovedorders.put("facilityorderno", (String) ord33[1]);
                        unitApprovedorders.put("ordertype", (String) ord33[2]);
                        unitApprovedorders.put("originstore", ord33[3]);

                        //Fetch Picked By
                        String[] paramsPickedby = {"facilityorderid", "ispicked"};
                        Object[] paramsValuesPickedby = {ord33[0], true};
                        String wherePickedby = "WHERE facilityorderid=:facilityorderid AND ispicked=:ispicked ORDER BY datepicked ASC LIMIT 1";
                        String[] fieldsPickedby = {"facilityorderitemsid", "pickedby", "datepicked"};
                        List<Object[]> objPickedbystaff = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fieldsPickedby, wherePickedby, paramsPickedby, paramsValuesPickedby);
                        if (objPickedbystaff != null) {
                            Object[] pickedby = objPickedbystaff.get(0);

                            //Query Staff details
                            String[] paramsPersondetailspick = {"staffid"};
                            Object[] paramsValuesPersondetailspick = {pickedby[1]};
                            String[] fieldsPersondetailspick = {"personid", "firstname", "lastname", "othernames"};
                            String wherePersondetailspick = "WHERE staffid=:staffid";
                            List<Object[]> objPersondetailspick = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fieldsPersondetailspick, wherePersondetailspick, paramsPersondetailspick, paramsValuesPersondetailspick);
                            if (objPersondetailspick != null) {
                                Object[] persondetailspick = objPersondetailspick.get(0);
                                if (persondetailspick[3] != null) {
                                    unitApprovedorders.put("pickedby", (String) persondetailspick[1] + " " + (String) persondetailspick[2] + " " + (String) persondetailspick[3]);
                                } else {
                                    unitApprovedorders.put("pickedby", (String) persondetailspick[1] + " " + (String) persondetailspick[2]);
                                }
                            }
                            unitApprovedorders.put("datepicked", formatter.format((Date) pickedby[2]));

                            pickedReadyToIssueList.add(unitApprovedorders);
                        }

                    }
                }
            }
        } catch (Exception ex) {
            System.out.println("ERROR:" + ex);
        }
        model.addAttribute("pickedReadyToIssueList", pickedReadyToIssueList);
        model.addAttribute("serverdate", formatterwithtime.format(serverDate));

        return "inventoryAndSupplies/orders/processOrder/views/viewReadyToIssueByyDate";
    }

    @RequestMapping(value = "/handOverOrder.htm", method = RequestMethod.GET)
    public String handOverOrder(Model model, HttpServletRequest request, @ModelAttribute("facilityorderid") String facilityorderid, @ModelAttribute("originstore") String originstore, @ModelAttribute("orderno") String orderno) {
        int handovertablesize = 0;

        List<Map> pickedOrdeList = new ArrayList<>();
        String[] paramqtyonorder = {"facilityorderid", "ispicked"};
        Object[] paramsValuesqtyonorder = {Long.parseLong(facilityorderid), true};
        String[] fieldsqtyonorder = {"qtyapproved", "itemid.itemid", "facilityorderitemsid"};
        String whereqtyonorder = "WHERE facilityorderid=:facilityorderid AND ispicked=:ispicked";
        List<Object[]> objOrderqtyonorder = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class,
                fieldsqtyonorder, whereqtyonorder, paramqtyonorder, paramsValuesqtyonorder);
        Map<String, Object> onorder;
        if (objOrderqtyonorder != null) {
            for (Object[] itemQtyonorder : objOrderqtyonorder) {
                onorder = new HashMap<>();
                String[] paramorderissuance = {"facilityorderitemsid"};
                Object[] paramsValueorderissuance = {itemQtyonorder[2]};
                String whereorderissuance = "WHERE facilityorderitemsid=:facilityorderitemsid";
                String[] fieldsorderissuance = {"orderissuanceid", "qtypicked", "stockid.stockid"};
                List<Object[]> objorderissuance = (List<Object[]>) genericClassService.fetchRecord(Orderissuance.class, fieldsorderissuance, whereorderissuance, paramorderissuance, paramsValueorderissuance);
                List<Map> pickedListItemValues = new ArrayList<>();
                if (objorderissuance != null) {
                    Map<String, Object> onorderitem;
                    for (Object[] orderissuance : objorderissuance) {
                        onorderitem = new HashMap<>();
                        onorderitem.put("qtypicked", String.format("%,d", (Integer) orderissuance[1]));
                        onorderitem.put("qtypickednocommas", orderissuance[1]);
                        onorderitem.put("orderissuanceid", orderissuance[0]);
                        onorderitem.put("stockid", orderissuance[2]);
                        onorderitem.put("facilityorderitemsid", itemQtyonorder[2]);

                        String[] parambatch = {"stockid"};
                        Object[] paramsValuebatch = {orderissuance[2]};
                        String wherebatch = "WHERE stockid=:stockid";
                        String[] fieldsbatch = {"stockid", "batchnumber", "expirydate"};
                        List<Object[]> objbatch = (List<Object[]>) genericClassService.fetchRecord(Stock.class, fieldsbatch, wherebatch, parambatch, paramsValuebatch);
                        if (objbatch != null) {
                            Object[] batch = objbatch.get(0);
                            onorderitem.put("batchno", batch[1]);
                            if (batch[2] != null) {
                                onorderitem.put("expirydate", formatter.format((Date) batch[2]));
                            } else {
                                onorderitem.put("expirydate", "No Expiry");
                            }
                        }
                        pickedListItemValues.add(onorderitem);
                    }
                }

                String[] paramitem = {"itempackageid"};
                Object[] paramsValueitem = {itemQtyonorder[1]};
                String whereitem = "WHERE itempackageid=:itempackageid";
                String[] fieldsitem = {"itempackageid", "packagename"};
                List<Object[]> objItem = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fieldsitem, whereitem, paramitem, paramsValueitem);
                if (objItem != null) {
                    for (Object[] itemdetails : objItem) {
                        onorder.put("genericname", (String) itemdetails[1]);
                    }
                }
                int itemHandoverListsize = pickedListItemValues.size();
                handovertablesize = handovertablesize + itemHandoverListsize;
                onorder.put("pickedListItemValues", pickedListItemValues);
                pickedOrdeList.add(onorder);
            }
        }
        model.addAttribute("handovertablesize", handovertablesize);
        model.addAttribute("facilityorderid", facilityorderid);
        model.addAttribute("items", pickedOrdeList);
        model.addAttribute("originstore", originstore);
        model.addAttribute("orderno", orderno);
        return "inventoryAndSupplies/orders/processOrder/views/handOver";
    }

    @RequestMapping(value = "/deliverOutProcessedOrder.htm", method = RequestMethod.GET)
    public @ResponseBody
    String deliverOutProcessedOrder(Model model, HttpServletRequest request) throws IOException {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null && request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            String personidsession = request.getSession().getAttribute("person_id").toString();
            Set<Long> facilityorderitemsset2 = new HashSet<>();
            Long currStaffId = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");

            String result = "";
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            long originstoreid = Long.parseLong(request.getParameter("originstore"));
            String facilityorderidhandover = request.getParameter("facilityorderidhandover");
            String orderno = request.getParameter("ordernumber");

            String[] paramsysuser = {"username", "password"};
            Object[] paramsValuessysuser = {username, password};
            String[] fieldssysuser = {"systemuserid", "personid.personid", "active"};
            String wheresysuser = "WHERE username=:username AND password=:password";
            List<Object[]> objsysuser = (List<Object[]>) genericClassService.fetchRecord(Systemuser.class, fieldssysuser, wheresysuser, paramsysuser, paramsValuessysuser);
            if (objsysuser != null) {
                Object[] itemdetails = objsysuser.get(0);
                if ((Integer.parseInt(personidsession)) == Integer.parseInt(String.valueOf(itemdetails[1]))) {
                    result = "sameuser";
                } else {
                    for (Object[] systemuser : objsysuser) {
                        String[] parampersn = {"personid"};
                        Object[] paramsValuepersn = {systemuser[1]};
                        String wherepersn = "WHERE personid=:personid";
                        String[] fieldspersn = {"staffid", "personid"};
                        List<Object[]> objpersn = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fieldspersn, wherepersn, parampersn, paramsValuepersn);
                        if (objpersn != null) {
                            Object[] person2 = objpersn.get(0);

//                            String[] paramstafffacilityunit = {"staffid"};
//                            Object[] paramsValuestafffacilityunit = {person2[0]};
//                            String wherestafffacilityunit = "WHERE staffid=:staffid";
                            // Get only the origin store staff details
                            String[] paramstafffacilityunit = {"staffid", "originstoreid"};
                            Object[] paramsValuestafffacilityunit = {person2[0], originstoreid};
                            String wherestafffacilityunit = "WHERE staffid=:staffid AND facilityunitid=:originstoreid";
                            //
                            String[] fieldsstafffacilityunit = {"stafffacilityunitid", "facilityunitid"};
                            List<Object[]> objstafffacilityunit = (List<Object[]>) genericClassService.fetchRecord(Stafffacilityunit.class, fieldsstafffacilityunit, wherestafffacilityunit, paramstafffacilityunit, paramsValuestafffacilityunit);

                            if (objstafffacilityunit != null) {                                
                                for (Object[] stafffacilityunit : objstafffacilityunit) {
                                    if (originstoreid == (Long) stafffacilityunit[1]) {

                                        try {
                                            List<Map> itemorderqty = (ArrayList) new ObjectMapper().readValue(request.getParameter("qtydeliveredvalues"), List.class);
                                            for (Map itemone : itemorderqty) {
                                                Long facilityunitorderitemsid = Long.parseLong(itemone.get("facilityunitorderitemsid").toString());
                                                Long stockid = Long.parseLong(itemone.get("name").toString());
                                                Long orderissuanceid = Long.parseLong(itemone.get("orderissuanceid").toString());

                                                if (itemone.get("value") != "") {
                                                    if (!itemone.get("value").equals(0)) {
                                                        Integer quantitydelivered = Integer.parseInt(String.valueOf(itemone.get("value")));
                                                        facilityorderitemsset2.add(facilityunitorderitemsid);
                                                        String[] columns = {"quantitydelivered"};
                                                        Object[] columnValues = {quantitydelivered};
                                                        String pk = "orderissuanceid";
                                                        Object pkValue = orderissuanceid;
                                                        genericClassService.updateRecordSQLSchemaStyle(Orderissuance.class, columns, columnValues, pk, pkValue, "store");

                                                        //Update stock card
                                                        String[] paramsStockQty = {"stockid"};
                                                        Object[] paramsValuesStockQty = {BigInteger.valueOf(stockid)};
                                                        String whereStockQty = "WHERE stockid=:stockid";
                                                        String[] fieldsStockQty = {"stockissued", "packsize"};
                                                        List<Object[]> issued = (List<Object[]>) genericClassService.fetchRecord(Facilityunitstock.class, fieldsStockQty, whereStockQty, paramsStockQty, paramsValuesStockQty);
                                                        if (issued != null) {
                                                            Integer totalIssued = (Integer) issued.get(0)[0] + (quantitydelivered * (Integer) issued.get(0)[1]);                                                            
                                                            //UPDATE CELL VALUES
                                                            String[] columnsqty = {"stockissued"};
                                                            Object[] columnValuesqty = {totalIssued};
                                                            String pkqty = "stockid";
                                                            Object pkValueqty = stockid;

                                                            if (!quantitydelivered.equals(0)) {
                                                                genericClassService.updateRecordSQLSchemaStyle(Stock.class, columnsqty, columnValuesqty, pkqty, pkValueqty, "store");

                                                                new StockActivityLog(genericClassService, stockid.intValue(), currStaffId.intValue(), "OUT", quantitydelivered * (Integer) issued.get(0)[1], "INT", BigInteger.valueOf(originstoreid), orderno).start();
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        } catch (Exception ex) {
                                            System.out.println("ERROR ON SAVE qty delivered:" + ex);
                                        }

                                        for (long facilityorderitemsid2 : facilityorderitemsset2) {
                                            try {
                                                String[] columns = {"isdelivered", "deliveredby", "datedelivered", "deliveredto"};
                                                Object[] columnValues = {true, BigInteger.valueOf(currStaffId), new Date(), (BigInteger) person2[0]};
                                                String pk = "facilityorderitemsid";
                                                Object pkValue = facilityorderitemsid2;
                                                genericClassService.updateRecordSQLSchemaStyle(Facilityorderitems.class, columns, columnValues, pk, pkValue, "store");
                                            } catch (Exception ex) {
                                                System.out.println("ERROR ON SAVE delivered by, ot to:" + ex);
                                            }
                                        }

                                        try {
                                            String[] columns = {"status", "taken"};
                                            Object[] columnValues = {"DELIVERED", false};
                                            String pk = "facilityorderid";
                                            Object pkValue = Long.parseLong(facilityorderidhandover);
                                            genericClassService.updateRecordSQLSchemaStyle(Facilityorder.class, columns, columnValues, pk, pkValue, "store");
                                        } catch (Exception ex) {
                                            System.out.println(ex);
                                        }
                                        result = "success";
                                    } else {
                                        result = "dontbelongtooriginstore";
                                    }
                                }
                            } else {
                                result = "doesnotbelongtoanyunit";
                            }
                        }
                    }
                }
            } else {
                result = "error";
            }
            return result;
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/saveDeliveredUnitStock.htm", method = RequestMethod.GET)
    public @ResponseBody
    String saveDeliveredStock(Model model, HttpServletRequest request) throws IOException {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null && request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            long currentFacilityUnitid = Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")));
            Set<Long> facilityorderitemsset2 = new HashSet<>();
            Long currStaffId = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");

            String result = "";
            String ordernumber = request.getParameter("ordernumber");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            BigInteger deliveredto = BigInteger.valueOf(Long.parseLong(request.getParameter("deliveredto")));
            String facilityorderidhandover = request.getParameter("facilityorderidhandover");
            long destinationstore = Long.parseLong(request.getParameter("destinationstore"));

            String[] paramsysuser = {"username", "password"};
            Object[] paramsValuessysuser = {username, password};
            String[] fieldssysuser = {"systemuserid", "personid.personid", "active"};
            String wheresysuser = "WHERE username=:username AND password=:password";
            List<Object[]> objsysuser = (List<Object[]>) genericClassService.fetchRecord(Systemuser.class, fieldssysuser, wheresysuser, paramsysuser, paramsValuessysuser);
            if (objsysuser != null) {
                for (Object[] systemuser : objsysuser) {
                    String[] parampersn = {"personid"};
                    Object[] paramsValuepersn = {systemuser[1]};
                    String wherepersn = "WHERE personid=:personid";
                    String[] fieldspersn = {"staffid"};
                    List<BigInteger> objpersn = (List<BigInteger>) genericClassService.fetchRecord(Searchstaff.class, fieldspersn, wherepersn, parampersn, paramsValuepersn);

                    if (objpersn != null) {
                        if (objpersn.get(0).equals(deliveredto)) {

                            //save received unit items
                            List<Map> itemorderqty = (ArrayList) new ObjectMapper().readValue(request.getParameter("qtydeliveredvalues"), List.class);
                            for (Map itemone : itemorderqty) {
                                Long facilityunitorderitemsid = Long.parseLong(itemone.get("facilityunitorderitemsid").toString());
                                Long stockid = Long.parseLong(itemone.get("name").toString());
                                Long orderissuanceid = Long.parseLong(itemone.get("orderissuanceid").toString());
                                String batchNo;
                                long itemid;

                                if (itemone.get("value") != "") {
                                    if (!itemone.get("value").equals(0)) {
                                        Integer quantityreceived = Integer.parseInt(String.valueOf(itemone.get("value")));
                                        facilityorderitemsset2.add(facilityunitorderitemsid);
                                        String[] columns = {"unitquantityreceived"};
                                        Object[] columnValues = {quantityreceived};
                                        String pk = "orderissuanceid";
                                        Object pkValue = orderissuanceid;
                                        genericClassService.updateRecordSQLSchemaStyle(Orderissuance.class, columns, columnValues, pk, pkValue, "store");

                                        //Update new stock
                                        String[] paramsStockDetails = {"stockid"};
                                        Object[] paramsValuesStockDetails = {BigInteger.valueOf(stockid)};
                                        String[] fields5StockDetails = {"expirydate", "batchnumber", "itemid", "packsize"};
                                        List<Object[]> objStockDetails = (List<Object[]>) genericClassService.fetchRecord(Facilityunitstock.class, fields5StockDetails, "WHERE stockid=:stockid", paramsStockDetails, paramsValuesStockDetails);
                                        if (objStockDetails != null) {
                                            Object[] stockDetails = objStockDetails.get(0);
                                            batchNo = (String) stockDetails[1];
                                            itemid = Long.parseLong(String.valueOf((BigInteger) stockDetails[2]));

                                            //
                                            String[] params;
                                            Object[] paramsValues;
                                            String where;
                                            if (stockDetails[0] != null && !"".equals(batchNo)) {
                                                params = new String[]{"facilityunitid", "itemid", "batchnumber", "expirydate"};
                                                paramsValues = new Object[]{currentFacilityUnitid, itemid, batchNo.trim().toLowerCase(), (Date) stockDetails[0]};
                                                where = "WHERE itemid=:itemid AND LOWER(batchnumber)=:batchnumber AND expirydate=:expirydate AND facilityunitid=:facilityunitid";
                                            } else {
                                                if ("".equals(batchNo) && stockDetails[0] == null) {
                                                    params = new String[]{"facilityunitid", "itemid"};
                                                    paramsValues = new Object[]{currentFacilityUnitid, itemid, batchNo.trim().toLowerCase()};
                                                    where = "WHERE itemid=:itemid AND LOWER(batchnumber)=:batchnumber AND facilityunitid=:facilityunitid";
                                                } else if (stockDetails[0] == null) {
                                                    params = new String[]{"facilityunitid", "itemid", "batchnumber"};
                                                    paramsValues = new Object[]{currentFacilityUnitid, itemid, batchNo.trim().toLowerCase()};
                                                    where = "WHERE itemid=:itemid AND LOWER(batchnumber)=:batchnumber AND facilityunitid=:facilityunitid";
                                                } else {
                                                    params = new String[]{"facilityunitid", "itemid", "expirydate"};
                                                    paramsValues = new Object[]{currentFacilityUnitid, itemid, (Date) stockDetails[0]};
                                                    where = "WHERE itemid=:itemid AND expirydate=:expirydate AND facilityunitid=:facilityunitid";
                                                }
                                            }
                                            String[] fields = {"stockid", "quantityrecieved"};
                                            List<Object[]> batchStock = (List<Object[]>) genericClassService.fetchRecord(Stock.class, fields, where, params, paramsValues);
                                            if (batchStock != null) {
                                                Integer availableQuantity = (Integer) batchStock.get(0)[1];
                                                if (stockDetails[0] != null) {
                                                    String[] columnsUpdate = {"quantityrecieved", "expirydate", "expires"};
                                                    Object[] columnValuesUpdate = {(quantityreceived * (Integer) stockDetails[3]) + availableQuantity, (Date) stockDetails[0], true};
                                                    String pkUpdate = "stockid";
                                                    Object pkValueUpdate = batchStock.get(0)[0];

                                                    if (!quantityreceived.equals(0)) {
                                                        genericClassService.updateRecordSQLSchemaStyle(Stock.class, columnsUpdate, columnValuesUpdate, pkUpdate, pkValueUpdate, "store");
                                                        new StockActivityLog(genericClassService, ((Long) pkValueUpdate).intValue(), currStaffId.intValue(), "IN", (quantityreceived * (Integer) stockDetails[3]), "INT", BigInteger.valueOf(destinationstore), ordernumber).start();
                                                    }

                                                } else {
                                                    String[] columnsUpdate = {"quantityrecieved", "expires"};
                                                    Object[] columnValuesUpdate = {(quantityreceived * (Integer) stockDetails[3]) + availableQuantity, false};
                                                    String pkUpdate = "stockid";
                                                    Object pkValueUpdate = batchStock.get(0)[0];

                                                    if (!quantityreceived.equals(0)) {
                                                        genericClassService.updateRecordSQLSchemaStyle(Stock.class, columnsUpdate, columnValuesUpdate, pkUpdate, pkValueUpdate, "store");
                                                        new StockActivityLog(genericClassService, ((Long) pkValueUpdate).intValue(), currStaffId.intValue(), "IN", (quantityreceived * (Integer) stockDetails[3]), "INT", BigInteger.valueOf(destinationstore), ordernumber).start();
                                                    }
                                                }
                                            } else {
                                                Stock itemStock = new Stock();
                                                itemStock.setItemid(new Item(itemid));
                                                itemStock.setQuantityrecieved((quantityreceived * (Integer) stockDetails[3]));
                                                itemStock.setDaterecieved(new Date());
                                                itemStock.setDateadded(new Date());
                                                itemStock.setRecievedby(currStaffId);
                                                itemStock.setFacilityunitid(BigInteger.valueOf(currentFacilityUnitid));
                                                itemStock.setSuppliertype("INT");
                                                itemStock.setShelvedstock(0);
                                                itemStock.setStockissued(0);
                                                itemStock.setSupplierid(BigInteger.valueOf(destinationstore));
                                                if (batchNo.length() >= 1) {
                                                    itemStock.setBatchnumber(batchNo);
                                                }
                                                if (stockDetails[0] != null) {
                                                    itemStock.setExpires(true);
                                                    itemStock.setExpirydate((Date) stockDetails[0]);
                                                } else {
                                                    itemStock.setExpires(false);
                                                }
                                                if (!quantityreceived.equals(0)) {
                                                    genericClassService.saveOrUpdateRecordLoadObject(itemStock);
                                                    new StockActivityLog(genericClassService, itemStock.getStockid().intValue(), currStaffId.intValue(), "IN", itemStock.getQuantityrecieved(), "INT", BigInteger.valueOf(destinationstore), ordernumber).start();
                                                }
                                            }
                                        }
                                    }
                                }
                            }

                            try {
                                String[] columns = {"taken", "datetaken"};
                                Object[] columnValues = {true, new Date()};
                                String pk = "facilityorderid";
                                Object pkValue = Long.parseLong(facilityorderidhandover);
                                genericClassService
                                        .updateRecordSQLSchemaStyle(Facilityorder.class,
                                                columns, columnValues, pk, pkValue, "store");
                            } catch (Exception ex) {
                                System.out.println(ex);
                            }
                            result = "success";
                        } else {
                            result = "notgiventothisuser";
                        }
                    }
                }
            } else {
                result = "error";
            }
            return result;
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/addorderitems.htm", method = RequestMethod.GET)
    public String addorderitems(Model model, HttpServletRequest request) {
        String result_view = "";
        List<Map> ordersFound = new ArrayList<>();
        String[] paramst = {"originstore", "destinationstore", "paused", "submitted", "sent", "serviced", "ordertype"};
        Object[] paramsValuest = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), BigInteger.valueOf(Long.parseLong(request.getParameter("supplier"))), "PAUSED", "SUBMITTED", "SENT", "SERVICED", "INTERNAL"};
        String wheret = "WHERE originstore=:originstore AND destinationstore=:destinationstore AND (status=:paused OR status=:submitted OR status=:sent OR status=:serviced) AND ordertype=:ordertype";
        String[] fieldst = {"facilityorderno", "facilityorderid", "isemergency", "preparedby", "dateprepared", "status", "dateneeded"};
        List<Object[]> facilityorder = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fieldst, wheret, paramst, paramsValuest);
        if (facilityorder != null) {
            Map<String, Object> orderRow;
            for (Object[] faciltyord : facilityorder) {
                orderRow = new HashMap<>();

                orderRow.put("facilityorderno", faciltyord[0]);
                orderRow.put("facilityorderid", faciltyord[1]);
                orderRow.put("isemergency", faciltyord[2]);
                orderRow.put("dateprepared", formatter.format((Date) faciltyord[4]));
                orderRow.put("status", faciltyord[5]);
                orderRow.put("dateneeded", formatter.format((Date) faciltyord[6]));

                String[] paramse = {"facilityunitid"};
                Object[] paramsValuese = {Long.parseLong(request.getParameter("supplier"))};
                String wheree = "WHERE facilityunitid=:facilityunitid";
                String[] fieldse = {"facilityunitname", "shortname"};
                List<Object[]> facilityordere = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fieldse, wheree, paramse, paramsValuese);
                if (facilityordere != null) {
                    orderRow.put("facilityunitname", facilityordere.get(0)[0]);
                    orderRow.put("shortname", facilityordere.get(0)[1]);
                }
                String[] paramsp = {"personid"};
                Object[] paramsValuesp = {faciltyord[3]};
                String wherep = "WHERE personid=:personid";
                String[] fieldsp = {"firstname", "lastname"};
                List<Object[]> person = (List<Object[]>) genericClassService.fetchRecord(Person.class, fieldsp, wherep, paramsp, paramsValuesp);
                if (person != null) {
                    orderRow.put("personname", person.get(0)[0] + " " + person.get(0)[1]);
                }
                int internalordersitemscount = 0;
                String[] params1 = {"facilityorderid"};
                Object[] paramsValues1 = {(Long) faciltyord[1]};
                String where1 = "WHERE facilityorderid=:facilityorderid";
                internalordersitemscount = genericClassService.fetchRecordCount(Facilityorderitems.class, where1, params1, paramsValues1);
                orderRow.put("internalordersitemscount", internalordersitemscount);

                ordersFound.add(orderRow);
            }
            model.addAttribute("ordersFound", ordersFound);
            if ("No".equals(request.getParameter("criteria"))) {
                model.addAttribute("criteria", "Normal");
            } else {
                model.addAttribute("criteria", "Emergency");
            }

            model.addAttribute("facilityunitsupplierid", request.getParameter("supplier"));
            model.addAttribute("dateneeded", request.getParameter("dateneeded"));
            model.addAttribute("type", request.getParameter("type"));
            model.addAttribute("supplierfacilityunitname", request.getParameter("facilityunitname"));

            result_view = "inventoryAndSupplies/orders/placeOrders/internalOrder/forms/existingOrder";
        } else {
            String[] params2 = {"personid"};
            Object[] paramsValues2 = {(Long) request.getSession().getAttribute("person_id")};
            String[] fields2 = {"firstname", "lastname", "othernames"};
            List<Object[]> personname = (List<Object[]>) genericClassService.fetchRecord(Person.class, fields2, "WHERE personid=:personid", params2, paramsValues2);
            if (personname != null) {
                model.addAttribute("firstname", personname.get(0)[0]);
                model.addAttribute("lastname", personname.get(0)[1]);
                model.addAttribute("othernames", personname.get(0)[2]);
            }
            String[] params6 = {"facilityunitid"};
            Object[] paramsValues6 = {Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))};
            String[] fields6 = {"facilityunitname", "shortname"};
            List<Object[]> facilityunitlog = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields6, "WHERE facilityunitid=:facilityunitid", params6, paramsValues6);
            if (facilityunitlog != null) {
                model.addAttribute("facilityunitname", facilityunitlog.get(0)[0]);
                model.addAttribute("ordernumber", generatefacilityorderno(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")), BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))))));

            }
            if ("No".equals(request.getParameter("criteria"))) {
                model.addAttribute("criteria", "Normal");
            } else {
                model.addAttribute("criteria", "Emergency");
            }

            model.addAttribute("facilityunitsupplierid", request.getParameter("supplier"));
            model.addAttribute("dateneeded", request.getParameter("dateneeded"));
            model.addAttribute("type", request.getParameter("type"));
            model.addAttribute("supplierfacilityunitname", request.getParameter("facilityunitname"));
            model.addAttribute("orderstage", "CREATION");
            model.addAttribute("datecreated", formatter.format(new Date()).replaceAll("-", "/"));

            Set<String> unitservices = new HashSet<>();

            String[] parampersn = {"facilityunitid", "status"};
            Object[] paramsValuepersn = {Long.parseLong(request.getParameter("supplier")), Boolean.TRUE};
            String wherepersn = "WHERE facilityunitid=:facilityunitid AND status=:status";
            String[] fieldspersn = {"facilityservices.servicekey"};
            List<String> facilityunitservices = (List<String>) genericClassService.fetchRecord(Facilityunitservice.class, fieldspersn, wherepersn, parampersn, paramsValuepersn);
            if (facilityunitservices != null) {
                for (String facilityunitservice : facilityunitservices) {
                    unitservices.add(facilityunitservice);
                }
            }
            if (!unitservices.isEmpty()) {
                if (unitservices.contains("key_sundriesUnitStore") && unitservices.contains("key_medicinesUnitStore")) {
                    model.addAttribute("supplies", "all");
                } else if (unitservices.contains("key_sundriesUnitStore") && !unitservices.contains("key_medicinesUnitStore")) {
                    model.addAttribute("supplies", "sundries");
                } else if (!unitservices.contains("key_sundriesUnitStore") && unitservices.contains("key_medicinesUnitStore")) {
                    model.addAttribute("supplies", "medicines");
                } else if (!unitservices.contains("key_sundriesUnitStore") && !unitservices.contains("key_medicinesUnitStore")) {
                    model.addAttribute("supplies", "all");
                }
            } else {
                model.addAttribute("supplies", "all");
            }
            result_view = "inventoryAndSupplies/orders/placeOrders/internalOrder/forms/addItems";
        }
        return result_view;
    }

    @RequestMapping(value = "/searchitemsinternalorder.htm", method = RequestMethod.GET)
    public String searchitemsinternalorder(Model model, HttpServletRequest request) {

        List<Map> itemsFound = new ArrayList<>();
        try {
            Set<Long> addeditems = new HashSet<>();
            List<Integer> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("itemsSet"), List.class);
            if (!item.isEmpty()) {
                for (Integer itm : item) {
                    addeditems.add(Long.parseLong(String.valueOf(itm)));
                }
            }

            if ("all".equals(request.getParameter("supplies"))) {
                String[] params = {"value", "name", "isactive"};
                Object[] paramsValues = {request.getParameter("searchValue").trim().toLowerCase() + "%", "%" + request.getParameter("searchValue").trim().toLowerCase() + "%", Boolean.TRUE};
                String[] fields = {"itempackageid", "packagename", "categoryname"};
                String where = "WHERE isactive=:isactive AND (LOWER(packagename) LIKE :value OR LOWER(packagename) LIKE :name) ORDER BY packagename";
                List<Object[]> orderItems = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields, where, params, paramsValues);
                if (orderItems != null) {
                    Map<String, Object> itemsRow;
                    for (Object[] orderItem : orderItems) {
                        itemsRow = new HashMap<>();
                        if (addeditems.isEmpty() || !addeditems.contains(((BigInteger) orderItem[0]).longValue())) {
                            itemsRow.put("itemid", orderItem[0]);
                            itemsRow.put("packagename", orderItem[1]);
                            itemsRow.put("categoryname", orderItem[2]);
                            itemsFound.add(itemsRow);
                        }
                    }
                }
            }
            if ("sundries".equals(request.getParameter("supplies"))) {
                String[] params = {"value", "name", "isactive", "issupplies"};
                Object[] paramsValues = {request.getParameter("searchValue").trim().toLowerCase() + "%", "%" + request.getParameter("searchValue").trim().toLowerCase() + "%", Boolean.TRUE, Boolean.TRUE};
                String[] fields = {"itempackageid", "packagename", "categoryname"};
                String where = "WHERE isactive=:isactive AND issupplies=:issupplies AND (LOWER(packagename) LIKE :value OR LOWER(packagename) LIKE :name) ORDER BY packagename";
                List<Object[]> orderItems = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields, where, params, paramsValues);
                if (orderItems != null) {
                    Map<String, Object> itemsRow;
                    for (Object[] orderItem : orderItems) {
                        itemsRow = new HashMap<>();
                        if (addeditems.isEmpty() || !addeditems.contains(((BigInteger) orderItem[0]).longValue())) {
                            itemsRow.put("itemid", orderItem[0]);
                            itemsRow.put("packagename", orderItem[1]);
                            itemsRow.put("categoryname", orderItem[2]);
                            itemsFound.add(itemsRow);
                        }
                    }
                }
            }
            if ("medicines".equals(request.getParameter("supplies"))) {
                String[] params = {"value", "name", "isactive", "issupplies"};
                Object[] paramsValues = {request.getParameter("searchValue").trim().toLowerCase() + "%", "%" + request.getParameter("searchValue").trim().toLowerCase() + "%", Boolean.TRUE, Boolean.FALSE};
                String[] fields = {"itempackageid", "packagename", "categoryname"};
                String where = "WHERE isactive=:isactive AND issupplies=:issupplies AND (LOWER(packagename) LIKE :value OR LOWER(packagename) LIKE :name) ORDER BY packagename";
                List<Object[]> orderItems = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields, where, params, paramsValues);
                if (orderItems != null) {
                    Map<String, Object> itemsRow;
                    for (Object[] orderItem : orderItems) {
                        itemsRow = new HashMap<>();
                        if (addeditems.isEmpty() || !addeditems.contains(((BigInteger) orderItem[0]).longValue())) {
                            itemsRow.put("itemid", orderItem[0]);
                            itemsRow.put("packagename", orderItem[1]);
                            itemsRow.put("categoryname", orderItem[2]);
                            itemsFound.add(itemsRow);
                        }
                    }
                }
            }

        } catch (Exception e) {
            System.out.println(":::::::::::::::::::" + e);
        }

        model.addAttribute("itemsFound", itemsFound);
        model.addAttribute("searchValue", request.getParameter("searchValue"));
        return "inventoryAndSupplies/orders/placeOrders/internalOrder/forms/itemSearchResults";
    }

    @RequestMapping(value = "/searchitemsexistinginternalorder.htm", method = RequestMethod.GET)
    public String searchitemsexistinginternalorder(Model model, HttpServletRequest request) {
        List<Map> itemsFound = new ArrayList<>();
        try {
            Set<Long> addeditems = new HashSet<>();
            List<Integer> itemsss = (ArrayList) new ObjectMapper().readValue(request.getParameter("items"), List.class);
            if (!itemsss.isEmpty()) {
                for (Integer items : itemsss) {
                    addeditems.add(Long.parseLong(String.valueOf(items)));
                }
            }

            String[] params4 = {"facilityorderid"};
            Object[] paramsValues4 = {Long.parseLong(request.getParameter("facilityorderid"))};
            String[] fields4 = {"itemid.itemid"};
            String where4 = "WHERE facilityorderid=:facilityorderid";
            List<Long> itemids = (List<Long>) genericClassService.fetchRecord(Facilityorderitems.class,
                    fields4, where4, params4, paramsValues4);
            if (itemids != null) {
                for (Long items : itemids) {
                    addeditems.add(items);
                }
            }

            if ("all".equals(request.getParameter("supplies"))) {
                String[] params = {"value", "name", "isactive"};
                Object[] paramsValues = {request.getParameter("searchValue").trim().toLowerCase() + "%", "%" + request.getParameter("searchValue").trim().toLowerCase() + "%", Boolean.TRUE};
                String[] fields = {"itempackageid", "packagename", "categoryname"};
                String where = "WHERE isactive=:isactive AND (LOWER(packagename) LIKE :value OR LOWER(packagename) LIKE :name) ORDER BY packagename";
                List<Object[]> orderItems = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class,
                        fields, where, params, paramsValues);
                if (orderItems != null) {
                    Map<String, Object> itemsRow;
                    for (Object[] orderItem : orderItems) {
                        itemsRow = new HashMap<>();
                        if (addeditems.isEmpty() || !addeditems.contains(((BigInteger) orderItem[0]).longValue())) {
                            itemsRow.put("itemid", orderItem[0]);
                            itemsRow.put("packagename", orderItem[1]);
                            itemsRow.put("categoryname", orderItem[2]);
                            itemsFound.add(itemsRow);
                        }
                    }
                }
            }
            if ("sundries".equals(request.getParameter("supplies"))) {
                String[] params = {"value", "name", "isactive", "issupplies"};
                Object[] paramsValues = {request.getParameter("searchValue").trim().toLowerCase() + "%", "%" + request.getParameter("searchValue").trim().toLowerCase() + "%", Boolean.TRUE, Boolean.TRUE};
                String[] fields = {"itempackageid", "packagename", "categoryname"};
                String where = "WHERE isactive=:isactive AND issupplies=:issupplies AND (LOWER(packagename) LIKE :value OR LOWER(packagename) LIKE :name) ORDER BY packagename";
                List<Object[]> orderItems = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class,
                        fields, where, params, paramsValues);
                if (orderItems != null) {
                    Map<String, Object> itemsRow;
                    for (Object[] orderItem : orderItems) {
                        itemsRow = new HashMap<>();
                        if (addeditems.isEmpty() || !addeditems.contains(((BigInteger) orderItem[0]).longValue())) {
                            itemsRow.put("itemid", orderItem[0]);
                            itemsRow.put("packagename", orderItem[1]);
                            itemsRow.put("categoryname", orderItem[2]);
                            itemsFound.add(itemsRow);
                        }
                    }
                }
            }
            if ("medicines".equals(request.getParameter("supplies"))) {
                String[] params = {"value", "name", "isactive", "issupplies"};
                Object[] paramsValues = {request.getParameter("searchValue").trim().toLowerCase() + "%", "%" + request.getParameter("searchValue").trim().toLowerCase() + "%", Boolean.TRUE, Boolean.FALSE};
                String[] fields = {"itempackageid", "packagename", "categoryname"};
                String where = "WHERE isactive=:isactive AND issupplies=:issupplies AND (LOWER(packagename) LIKE :value OR LOWER(packagename) LIKE :name) ORDER BY packagename";
                List<Object[]> orderItems = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class,
                        fields, where, params, paramsValues);
                if (orderItems != null) {
                    Map<String, Object> itemsRow;
                    for (Object[] orderItem : orderItems) {
                        itemsRow = new HashMap<>();
                        if (addeditems.isEmpty() || !addeditems.contains(((BigInteger) orderItem[0]).longValue())) {
                            itemsRow.put("itemid", orderItem[0]);
                            itemsRow.put("packagename", orderItem[1]);
                            itemsRow.put("categoryname", orderItem[2]);
                            itemsFound.add(itemsRow);
                        }
                    }
                }
            }

        } catch (Exception e) {
            System.out.println("::::::::::::::::::::::::::::" + e);
        }

        model.addAttribute("itemsFound", itemsFound);
        model.addAttribute("searchValue", request.getParameter("searchValue"));
        return "inventoryAndSupplies/orders/placeOrders/internalOrder/forms/searchResults";
    }

    @RequestMapping(value = "/deleteexistingfacilityunitorderanditems.htm")
    public @ResponseBody
    String deleteexistingfacilityunitorderanditems(HttpServletRequest request) {
        String results = "";

        String[] params = {"facilityorderid"};
        Object[] paramsValues = {Long.parseLong(request.getParameter("facilityorderid"))};
        String[] fields = {"facilityorderitemsid"};
        String where = "WHERE facilityorderid=:facilityorderid";
        List<Long> facilityorderitemsid = (List<Long>) genericClassService.fetchRecord(Facilityorderitems.class,
                fields, where, params, paramsValues);
        if (facilityorderitemsid != null) {
            for (Long facilityorderitems : facilityorderitemsid) {
                String[] columns = {"facilityorderitemsid"};
                Object[] columnValues = {facilityorderitems};
                int result = genericClassService.deleteRecordByByColumns("store.facilityorderitems", columns, columnValues);
                if (result != 0) {
                    results = "success";
                }
            }
        }
        String[] columns = {"facilityorderid"};
        Object[] columnValues = {Long.parseLong(request.getParameter("facilityorderid"))};
        int result = genericClassService.deleteRecordByByColumns("store.facilityorder", columns, columnValues);
        if (result != 0) {
            results = "success";
        }

        return results;
    }

    @RequestMapping(value = "/manageexistingfacilityunitorderitems.htm", method = RequestMethod.GET)
    public String manageexistingfacilityunitorderitems(Model model, HttpServletRequest request) {
        Long totalcost = 0L;
        List<Map> itemsFound = new ArrayList<>();
        String[] params = {"facilityorderid"};
        Object[] paramsValues = {Long.parseLong(request.getParameter("facilityorderid"))};
        String[] fields = {"facilityorderitemsid", "qtyordered", "itemid.itemid"};
        String where = "WHERE facilityorderid=:facilityorderid";
        List<Object[]> facilityorderitems = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class,
                fields, where, params, paramsValues);
        if (facilityorderitems != null) {
            Map<String, Object> itemRow;
            for (Object[] facilityorderitem : facilityorderitems) {
                itemRow = new HashMap<>();
                String[] params1 = {"itempackageid"};
                Object[] paramsValues1 = {facilityorderitem[2]};
                String[] fields1 = {"packagename", "packagequantity"};
                String where1 = "WHERE itempackageid=:itempackageid";
                List<Object[]> orderitems = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class,
                        fields1, where1, params1, paramsValues1);
                if (orderitems != null) {
                    totalcost = totalcost + 0;
                    itemRow.put("genericname", orderitems.get(0)[0]);
                    itemRow.put("packsize", orderitems.get(0)[1]);
                    itemRow.put("qtyordered", facilityorderitem[1]);
                    itemRow.put("facilityorderitemsid", facilityorderitem[0]);
                    itemsFound.add(itemRow);
                }
            }
        }
        String[] params4 = {"facilityunitid"};
        Object[] paramsValues4 = {Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))};
        String[] fields4 = {"facilityunitname", "shortname"};
        String where4 = "WHERE facilityunitid=:facilityunitid";
        List<Object[]> originstore = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class,
                fields4, where4, params4, paramsValues4);
        if (originstore != null) {
            model.addAttribute("originstore", originstore.get(0)[0]);
        }
        model.addAttribute("totalcost", decimalFormat.format(totalcost));
        model.addAttribute("itemsFound", itemsFound);
        model.addAttribute("facilityorderid", request.getParameter("facilityorderid"));
        model.addAttribute("facilityorderno", request.getParameter("facilityorderno"));
        model.addAttribute("dateneeded", request.getParameter("dateneeded"));
        model.addAttribute("facilityunitname", request.getParameter("facilityunitname"));
        model.addAttribute("personname", request.getParameter("personname"));
        model.addAttribute("dateprepared", request.getParameter("dateprepared"));
        model.addAttribute("status", request.getParameter("status"));
        model.addAttribute("facilityunitsupplierid", request.getParameter("facilityunitsupplierid"));
        model.addAttribute("isemergency", request.getParameter("isemergency"));

        Set<String> unitservices = new HashSet<>();

        String[] parampersn = {"facilityunitid", "status"};
        Object[] paramsValuepersn = {Long.parseLong(request.getParameter("facilityunitsupplierid")), Boolean.TRUE};
        String wherepersn = "WHERE facilityunitid=:facilityunitid AND status=:status";
        String[] fieldspersn = {"facilityservices.servicekey"};
        List<String> facilityunitservices = (List<String>) genericClassService.fetchRecord(Facilityunitservice.class,
                fieldspersn, wherepersn, parampersn, paramsValuepersn);
        if (facilityunitservices != null) {
            for (String facilityunitservice : facilityunitservices) {
                unitservices.add(facilityunitservice);
            }
        }
        if (!unitservices.isEmpty()) {
            if (unitservices.contains("key_sundriesUnitStore") && unitservices.contains("key_medicinesUnitStore")) {
                model.addAttribute("supplies", "all");
            } else if (unitservices.contains("key_sundriesUnitStore") && !unitservices.contains("key_medicinesUnitStore")) {
                model.addAttribute("supplies", "sundries");
            } else if (!unitservices.contains("key_sundriesUnitStore") && unitservices.contains("key_medicinesUnitStore")) {
                model.addAttribute("supplies", "medicines");
            } else if (!unitservices.contains("key_sundriesUnitStore") && !unitservices.contains("key_medicinesUnitStore")) {
                model.addAttribute("supplies", "all");
            }
        } else {
            model.addAttribute("supplies", "all");
        }
        return "inventoryAndSupplies/orders/placeOrders/internalOrder/forms/existingOrderItems";
    }

    @RequestMapping(value = "/getsuppliersupliesday.htm")
    public @ResponseBody
    String getsuppliersupliesday(HttpServletRequest request) {
        String results = "no";
        Set<String> days = new HashSet<>();
        try {
            SimpleDateFormat format1 = new SimpleDateFormat("dd/MM/yyyy");
//            String input_date = request.getParameter("date");
            Date dt1 = new Date();
            DateFormat format2 = new SimpleDateFormat("EEEE");
            String toDay = format2.format(dt1);

            String[] params4 = {"facilityunitid", "supplierid", "isactive", "suppliertype"};
            Object[] paramsValues4 = {Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))), Long.parseLong(request.getParameter("ordersupplier")), Boolean.TRUE, "internal"};
            String[] fields4 = {"facilityunitsupplierid"};
            String where4 = "WHERE facilityunitid=:facilityunitid AND supplierid=:supplierid AND isactive=:isactive AND suppliertype=:suppliertype";
            List<Integer> facilityunitsupplierid = (List<Integer>) genericClassService.fetchRecord(Facilityunitsupplier.class, fields4, where4, params4, paramsValues4);
            if (facilityunitsupplierid != null) {
                for (Integer facilityunitsupplier : facilityunitsupplierid) {
                    String[] params1 = {"facilityunitsupplierid", "active"};
                    Object[] paramsValues1 = {facilityunitsupplier, Boolean.TRUE};
                    String[] fields1 = {"scheduleid"};
                    String where1 = "WHERE facilityunitsupplierid=:facilityunitsupplierid AND active=:active";
                    List<Integer> scheduleid = (List<Integer>) genericClassService.fetchRecord(Facilityunitsupplierschedule.class,
                            fields1, where1, params1, paramsValues1);
                    if (scheduleid != null) {
                        for (Integer schedule : scheduleid) {
                            String[] params = {"scheduleid"};
                            Object[] paramsValues = {schedule};
                            String[] fields = {"scheduledayname", "abbreviation"};
                            String where = "WHERE scheduleid=:scheduleid";
                            List<Object[]> scheduledayname = (List<Object[]>) genericClassService.fetchRecord(Schedule.class,
                                    fields, where, params, paramsValues);
                            if (scheduledayname != null) {
                                days.add((String) scheduledayname.get(0)[0]);
                            }
                        }
                    }
                }
            }
            if (!days.isEmpty()) {
                if (days.contains(toDay.toUpperCase())) {
                    results = toDay.toUpperCase() + "(Today)" + "~" + format1.format(new Date()) + "~" + days.size();
                } else {
                    HashMap<String, Object> map = getnextdayofschedule(days, format1.parse(format1.format(new Date())), format1, format2);
                    if ("no".equals((String) map.get("day"))) {
                        results = "no";
                    } else {
                        results = (String) map.get("day") + "~" + (String) map.get("date") + "~" + days.size();
                    }
                }
            }
        } catch (ParseException e) {
        }

        return results;
    }

    int k = 0;

    public HashMap<String, Object> getnextdayofschedule(Set<String> days, Date dt1, SimpleDateFormat format1, DateFormat format2) {
        HashMap<String, Object> mapDays = new HashMap<>();
        try {
            Calendar c = Calendar.getInstance();
            c.setTime(dt1);
            c.add(Calendar.DATE, 1);
            String dt = format1.format(c.getTime());
            String finalDay = format2.format(format1.parse(dt));
            if (days.contains(finalDay.toUpperCase())) {
                mapDays.put("day", finalDay.toUpperCase());
                mapDays.put("date", format1.format(format1.parse(dt)));
                return mapDays;
            } else {
                k = k + 1;
                if (k == 7) {
                    mapDays.put("day", "no");
                    mapDays.put("date", "no");
                    return mapDays;
                } else {
                    return getnextdayofschedule(days, format1.parse(dt), format1, format2);
                }

            }

        } catch (ParseException ex) {

        }
        return mapDays;
    }

    @RequestMapping(value = "/scheduledays.htm", method = RequestMethod.GET)
    public String scheduledays(Model model, HttpServletRequest request) {
        SimpleDateFormat format1 = new SimpleDateFormat("dd/MM/yyyy");
        DateFormat format2 = new SimpleDateFormat("EEEE");
        List<Map> daysFound = new ArrayList<>();
        Set<String> days = new HashSet<>();
        String[] params4 = {"facilityunitid", "supplierid", "isactive", "suppliertype"};
        Object[] paramsValues4 = {Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))), Long.parseLong(request.getParameter("facilitysupplierid")), Boolean.TRUE, "internal"};
        String[] fields4 = {"facilityunitsupplierid"};
        String where4 = "WHERE facilityunitid=:facilityunitid AND supplierid=:supplierid AND isactive=:isactive AND suppliertype=:suppliertype";
        List<Integer> facilityunitsupplierid = (List<Integer>) genericClassService.fetchRecord(Facilityunitsupplier.class, fields4, where4, params4, paramsValues4);
        if (facilityunitsupplierid != null) {
            Map<String, Object> daysRow;
            for (Integer facilityunitsupplier : facilityunitsupplierid) {
                daysRow = new HashMap<>();

                String[] params1 = {"facilityunitsupplierid", "active"};
                Object[] paramsValues1 = {facilityunitsupplier, Boolean.TRUE};
                String[] fields1 = {"scheduleid"};
                String where1 = "WHERE facilityunitsupplierid=:facilityunitsupplierid AND active=:active";
                List<Integer> scheduleid = (List<Integer>) genericClassService.fetchRecord(Facilityunitsupplierschedule.class,
                        fields1, where1, params1, paramsValues1);
                if (scheduleid != null) {
                    for (Integer schedule : scheduleid) {
                        String[] params = {"scheduleid"};
                        Object[] paramsValues = {schedule};
                        String[] fields = {"scheduledayname", "abbreviation"};
                        String where = "WHERE scheduleid=:scheduleid";
                        List<Object[]> scheduledayname = (List<Object[]>) genericClassService.fetchRecord(Schedule.class,
                                fields, where, params, paramsValues);
                        if (scheduledayname != null) {
                            days.add((String) scheduledayname.get(0)[0]);
                        }
                    }
                }
            }
        }
        if (!days.isEmpty()) {
            try {
                Date date = format1.parse(format1.format(new Date()));
                int add;
                for (int i = 1; i <= 7; i++) {
                    if (i == 1) {
                        add = 0;
                    } else {
                        add = 1;
                    }
                    HashMap<String, Object> map = getnextdayofschedules(add, date, format1, format2);
                    if (days.contains((String) map.get("day"))) {
                        daysFound.add(map);
                    } else {
                    }
                    date = format1.parse((String) map.get("date"));

                }
            } catch (ParseException ex) {
                Logger.getLogger(OrdersManagement.class
                        .getName()).log(Level.SEVERE, null, ex);
            }
        }
        model.addAttribute("daysFound", daysFound);
        return "inventoryAndSupplies/orders/placeOrders/internalOrder/forms/scheduledays";
    }

    public HashMap<String, Object> getnextdayofschedules(int add, Date dt1, SimpleDateFormat format1, DateFormat format2) {
        HashMap<String, Object> mapDays = new HashMap<>();
        try {
            Calendar c = Calendar.getInstance();
            c.setTime(dt1);
            c.add(Calendar.DATE, add);
            String dt = format1.format(c.getTime());
            String finalDay = format2.format(format1.parse(dt));
            mapDays.put("day", finalDay.toUpperCase());
            mapDays.put("date", dt);

        } catch (ParseException ex) {
            Logger.getLogger(OrdersManagement.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return mapDays;
    }

    //Ordering Unit ID DETAILS
    @RequestMapping(value = "/viewfacilityunitdetails.htm", method = RequestMethod.GET)
    public String viewFacilityUnitdetails(Model model, HttpServletRequest request, @ModelAttribute("facilityunitid") long facilityunitid) {
        List<Map> facilityUnitDetails = new ArrayList<>();
        String[] paramorderingunit = {"facilityunitid"};
        Object[] paramsValuesorderingunit = {facilityunitid};
        String[] fieldsorderingunit = {"facilityunitid", "facilityunitname", "description", "shortname"};
        String whereorderingunit = "WHERE facilityunitid=:facilityunitid";
        List<Object[]> objOrderorderingunit = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fieldsorderingunit, whereorderingunit, paramorderingunit, paramsValuesorderingunit);
        Map<String, Object> orderingUnitmap;
        if (objOrderorderingunit != null) {
            for (Object[] orderingunit : objOrderorderingunit) {
                orderingUnitmap = new HashMap<>();
                orderingUnitmap.put("facilityunitname", orderingunit[1]);
                orderingUnitmap.put("description", orderingunit[2]);
                orderingUnitmap.put("shortname", orderingunit[3]);
                facilityUnitDetails.add(orderingUnitmap);
            }
        }
        model.addAttribute("facilityunitdetails", facilityUnitDetails);

        return "inventoryAndSupplies/orders/processOrder/views/facilityUnitDetails";
    }

    @RequestMapping(value = "/pausedfacilityorderadditems.htm", method = RequestMethod.GET)
    public String pausedfacilityorderadditems(Model model, HttpServletRequest request) {

        ////////////////*******************************************
        Set<String> unitservices = new HashSet<>();

        String[] params9 = {"facilityorderid"};
        Object[] paramsValues9 = {Long.parseLong(request.getParameter("facilityorderid"))};
        String[] fields9 = {"destinationstore"};
        String where9 = "WHERE facilityorderid=:facilityorderid";
        List<BigInteger> facilityunitsupplier = (List<BigInteger>) genericClassService.fetchRecord(Facilityorder.class, fields9, where9, params9, paramsValues9);
        if (facilityunitsupplier != null) {

            String[] parampersn = {"facilityunitid", "status"};
            Object[] paramsValuepersn = {facilityunitsupplier.get(0), Boolean.TRUE};
            String wherepersn = "WHERE facilityunitid=:facilityunitid AND status=:status";
            String[] fieldspersn = {"facilityservices.servicekey"};
            List<String> facilityunitservices = (List<String>) genericClassService.fetchRecord(Facilityunitservice.class, fieldspersn, wherepersn, parampersn, paramsValuepersn);
            if (facilityunitservices != null) {
                for (String facilityunitservice : facilityunitservices) {
                    unitservices.add(facilityunitservice);
                }
            }
        }

        if (!unitservices.isEmpty()) {
            if (unitservices.contains("key_sundriesUnitStore") && unitservices.contains("key_medicinesUnitStore")) {
                model.addAttribute("supplies", "all");
            } else if (unitservices.contains("key_sundriesUnitStore") && !unitservices.contains("key_medicinesUnitStore")) {
                model.addAttribute("supplies", "sundries");
            } else if (!unitservices.contains("key_sundriesUnitStore") && unitservices.contains("key_medicinesUnitStore")) {
                model.addAttribute("supplies", "medicines");
            } else if (!unitservices.contains("key_sundriesUnitStore") && !unitservices.contains("key_medicinesUnitStore")) {
                model.addAttribute("supplies", "all");
            }
        } else {
            model.addAttribute("supplies", "all");
        }

        String[] params1 = {"facilityunitid"};
        Object[] paramsValues1 = {Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))};
        String[] fields1 = {"facilityunitname"};
        String where1 = "WHERE facilityunitid=:facilityunitid";
        List<String> facilityunitname = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fields1, where1, params1, paramsValues1);
        if (facilityunitname != null) {
            model.addAttribute("facilityunitname", facilityunitname.get(0));
        }
        model.addAttribute("facilityorderid", request.getParameter("facilityorderid"));
        model.addAttribute("facilityorderno", request.getParameter("facilityorderno"));
        model.addAttribute("facilitysuppliername", request.getParameter("facilitysuppliername"));
        model.addAttribute("internalordersitemscount", request.getParameter("internalordersitemscount"));
        model.addAttribute("dateneeded", request.getParameter("dateneeded"));
        model.addAttribute("dateprepared", request.getParameter("dateprepared"));
        model.addAttribute("personname", request.getParameter("personname"));
        model.addAttribute("orderstage", request.getParameter("orderstage"));
        model.addAttribute("criteria", request.getParameter("criteria"));
        return "inventoryAndSupplies/orders/placeOrders/internalOrder/viewOrManageOrders/incopleteAndCompleteOrders/forms/addMoreItems";
    }

    @RequestMapping(value = "/saveorpausepausedfacilityorderitmz.htm")
    public @ResponseBody
    String saveorpausepausedfacilityorderitmz(HttpServletRequest request) {
        String results = "";

        try {
            if ("pause".equals(request.getParameter("type"))) {
                List<Map> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("values"), List.class);

                for (Map item1 : item) {
                    Map<String, Object> map = (HashMap) item1;
                    Facilityorderitems facilityorderitems = new Facilityorderitems();
                    facilityorderitems.setItemid(new Item(((Integer) map.get("itemid")).longValue()));
                    facilityorderitems.setFacilityorderid(new Facilityorder(Long.parseLong(request.getParameter("facilityunitorderid"))));
                    facilityorderitems.setQtyordered(BigInteger.valueOf(Long.parseLong((String) map.get("qty"))));
                    facilityorderitems.setQtyapproved(BigInteger.valueOf(Long.parseLong((String) map.get("qty"))));
                    facilityorderitems.setApproved(Boolean.FALSE);
                    genericClassService.saveOrUpdateRecordLoadObject(facilityorderitems);

                }
                String[] columns = {"status"};
                Object[] columnValues = {"PAUSED"};
                String pk = "facilityorderid";
                Object pkValue = Long.parseLong(request.getParameter("facilityunitorderid"));

                int result = genericClassService.updateRecordSQLSchemaStyle(Facilityorder.class,
                        columns, columnValues, pk, pkValue, "store");
                if (result != 0) {
                    results = "success";

                }
            } else {
                List<Map> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("values"), List.class
                );

                for (Map item1 : item) {
                    Map<String, Object> map = (HashMap) item1;
                    Facilityorderitems facilityorderitems = new Facilityorderitems();
                    facilityorderitems.setItemid(new Item(((Integer) map.get("itemid")).longValue()));
                    facilityorderitems.setFacilityorderid(new Facilityorder(Long.parseLong(request.getParameter("facilityunitorderid"))));
                    facilityorderitems.setQtyordered(BigInteger.valueOf(Long.parseLong((String) map.get("qty"))));
                    facilityorderitems.setQtyapproved(BigInteger.valueOf(Long.parseLong((String) map.get("qty"))));
                    facilityorderitems.setApproved(Boolean.FALSE);
                    
                    genericClassService.saveOrUpdateRecordLoadObject(facilityorderitems);

                }
                String[] columns = {"status"};
                Object[] columnValues = {"SUBMITTED"};
                String pk = "facilityorderid";
                Object pkValue = Long.parseLong(request.getParameter("facilityunitorderid"));

                int result = genericClassService.updateRecordSQLSchemaStyle(Facilityorder.class, columns, columnValues, pk, pkValue, "store");
                if (result != 0) {
                    results = "success";
                }
            }
        } catch (IOException e) {
        }

        return results;
    }

    @RequestMapping(value = "/viewpausedfacilityunitorderItms.htm", method = RequestMethod.GET)
    public String viewpausedfacilityunitorderItms(Model model, HttpServletRequest request) {
        List<Map> itemsFound = new ArrayList<>();

        String[] params9 = {"facilityunitid"};
        Object[] paramsValues9 = {Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))};
        String[] fields9 = {"facilityunitname"};
        String where9 = "WHERE facilityunitid=:facilityunitid";
        List<String> facilityunitname = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fields9, where9, params9, paramsValues9);
        if (facilityunitname != null) {
            model.addAttribute("facilityunitname", facilityunitname.get(0));
        }
        Long totalcost = 0L;
        String[] params = {"facilityorderid"};
        Object[] paramsValues = {Long.parseLong(request.getParameter("facilityorderid"))};
        String[] fields = {"facilityorderitemsid", "qtyordered", "itemid.itemid"};
        String where = "WHERE facilityorderid=:facilityorderid";
        List<Object[]> facilityorderitems = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class,
                fields, where, params, paramsValues);
        if (facilityorderitems != null) {
            Map<String, Object> itemRow;
            for (Object[] facilityorderitem : facilityorderitems) {
                itemRow = new HashMap<>();
                String[] params1 = {"itempackageid"};
                Object[] paramsValues1 = {(Long) facilityorderitem[2]};
                String[] fields1 = {"packagename", "packagequantity"};
                String where1 = "WHERE itempackageid=:itempackageid";
                List<Object[]> orderitems = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class,
                        fields1, where1, params1, paramsValues1);
                if (orderitems != null) {
                    totalcost = totalcost + 0;
                    itemRow.put("genericname", orderitems.get(0)[0]);
                    itemRow.put("packsize", orderitems.get(0)[1]);
                    itemRow.put("qtyordered", facilityorderitem[1]);
                    itemRow.put("facilityorderitemsid", facilityorderitem[0]);
                    itemsFound.add(itemRow);
                }
            }
        }

        model.addAttribute("totalcost", decimalFormat.format(totalcost));
        model.addAttribute("facilityorderid", request.getParameter("facilityorderid"));
        model.addAttribute("facilityorderno", request.getParameter("facilityorderno"));
        model.addAttribute("facilitysuppliername", request.getParameter("facilitysuppliername"));
        model.addAttribute("internalordersitemscount", request.getParameter("internalordersitemscount"));
        model.addAttribute("dateneeded", request.getParameter("dateneeded"));
        model.addAttribute("dateprepared", request.getParameter("dateprepared"));
        model.addAttribute("personname", request.getParameter("personname"));
        model.addAttribute("orderstage", request.getParameter("orderstage"));
        model.addAttribute("criteria", request.getParameter("criteria"));

        model.addAttribute("itemsFound", itemsFound);
        return "inventoryAndSupplies/orders/placeOrders/internalOrder/viewOrManageOrders/incopleteAndCompleteOrders/views/orderItems";
    }

    @RequestMapping(value = "/recalledorderitems.htm", method = RequestMethod.GET)
    public String recalledorderitems(Model model, HttpServletRequest request) {
        List<Map> itemsFound = new ArrayList<>();
        String[] params9 = {"facilityunitid"};
        Object[] paramsValues9 = {Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))};
        String[] fields9 = {"facilityunitname"};
        String where9 = "WHERE facilityunitid=:facilityunitid";
        List<String> facilityunitname = (List<String>) genericClassService.fetchRecord(Facilityunit.class,
                fields9, where9, params9, paramsValues9);
        if (facilityunitname != null) {
            model.addAttribute("facilityunitname", facilityunitname.get(0));
        }
        String[] params = {"facilityorderid"};
        Object[] paramsValues = {Long.parseLong(request.getParameter("facilityorderid"))};
        String[] fields = {"facilityorderitemsid", "qtyordered", "itemid.itemid"};
        String where = "WHERE facilityorderid=:facilityorderid";
        List<Object[]> facilityorderitems = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class,
                fields, where, params, paramsValues);
        if (facilityorderitems != null) {
            Map<String, Object> itemRow;
            for (Object[] facilityorderitem : facilityorderitems) {
                itemRow = new HashMap<>();
                String[] params1 = {"itempackageid"};
                Object[] paramsValues1 = {(Long) facilityorderitem[2]};
                String[] fields1 = {"packagename", "packagequantity"};
                String where1 = "WHERE itempackageid=:itempackageid";
                List<Object[]> orderitems = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class,
                        fields1, where1, params1, paramsValues1);
                if (orderitems != null) {
                    itemRow.put("genericname", orderitems.get(0)[0]);
                    itemRow.put("packsize", orderitems.get(0)[1]);
                    itemRow.put("qtyordered", facilityorderitem[1]);
                    itemRow.put("facilityorderitemsid", facilityorderitem[0]);
                    itemsFound.add(itemRow);
                }
            }
        }

        model.addAttribute("facilityorderid", request.getParameter("facilityorderid"));
        model.addAttribute("facilityorderno", request.getParameter("facilityorderno"));
        model.addAttribute("facilitysuppliername", request.getParameter("facilitysuppliername"));
        model.addAttribute("internalordersitemscount", request.getParameter("internalordersitemscount"));
        model.addAttribute("dateneeded", request.getParameter("dateneeded"));
        model.addAttribute("dateprepared", request.getParameter("dateprepared"));
        model.addAttribute("personname", request.getParameter("personname"));
        model.addAttribute("orderstage", request.getParameter("orderstage"));
        model.addAttribute("criteria", request.getParameter("criteria"));
        model.addAttribute("itemsFound", itemsFound);
        return "inventoryAndSupplies/orders/placeOrders/internalOrder/viewOrManageOrders/incopleteAndCompleteOrders/forms/recallOrderItems";
    }

    @RequestMapping(value = "/recalledordersaddmoreitems.htm", method = RequestMethod.GET)
    public String recalledordersaddmoreitems(Model model, HttpServletRequest request) {
        /////////...........................
        Set<String> unitservices = new HashSet<>();

        String[] params9 = {"facilityorderid"};
        Object[] paramsValues9 = {Long.parseLong(request.getParameter("facilityorderid"))};
        String[] fields9 = {"destinationstore"};
        String where9 = "WHERE facilityorderid=:facilityorderid";
        List<BigInteger> facilityunitsupplier = (List<BigInteger>) genericClassService.fetchRecord(Facilityorder.class,
                fields9, where9, params9, paramsValues9);
        if (facilityunitsupplier != null) {

            String[] parampersn = {"facilityunitid", "status"};
            Object[] paramsValuepersn = {facilityunitsupplier.get(0), Boolean.TRUE};
            String wherepersn = "WHERE facilityunitid=:facilityunitid AND status=:status";
            String[] fieldspersn = {"facilityservices.servicekey"};
            List<String> facilityunitservices = (List<String>) genericClassService.fetchRecord(Facilityunitservice.class,
                    fieldspersn, wherepersn, parampersn, paramsValuepersn);
            if (facilityunitservices != null) {
                for (String facilityunitservice : facilityunitservices) {
                    unitservices.add(facilityunitservice);
                }
            }
        }

        if (!unitservices.isEmpty()) {
            if (unitservices.contains("key_sundriesUnitStore") && unitservices.contains("key_medicinesUnitStore")) {
                model.addAttribute("supplies", "all");
            } else if (unitservices.contains("key_sundriesUnitStore") && !unitservices.contains("key_medicinesUnitStore")) {
                model.addAttribute("supplies", "sundries");
            } else if (!unitservices.contains("key_sundriesUnitStore") && unitservices.contains("key_medicinesUnitStore")) {
                model.addAttribute("supplies", "medicines");
            } else if (!unitservices.contains("key_sundriesUnitStore") && !unitservices.contains("key_medicinesUnitStore")) {
                model.addAttribute("supplies", "all");
            }
        } else {
            model.addAttribute("supplies", "all");
        }

        model.addAttribute("facilityorderid", request.getParameter("facilityorderid"));
        model.addAttribute("facilityorderno", request.getParameter("facilityorderno"));
        model.addAttribute("facilitysuppliername", request.getParameter("facilitysuppliername"));
        model.addAttribute("internalordersitemscount", request.getParameter("internalordersitemscount"));
        model.addAttribute("dateneeded", request.getParameter("dateneeded"));
        model.addAttribute("dateprepared", request.getParameter("dateprepared"));
        model.addAttribute("personname", request.getParameter("personname"));
        model.addAttribute("orderstage", request.getParameter("orderstage"));
        model.addAttribute("criteria", request.getParameter("criteria"));
        model.addAttribute("facilityunitname", request.getParameter("facilityunitname"));
        return "inventoryAndSupplies/orders/placeOrders/internalOrder/viewOrManageOrders/incopleteAndCompleteOrders/forms/addMoreRecalledItems";
    }

    @RequestMapping(value = "/savepausedorsubmittedrecalledorderItems.htm")
    public @ResponseBody
    String savepausedorsubmittedrecalledorderItems(HttpServletRequest request) {
        String results = "";

        try {
            if ("pause".equals(request.getParameter("type"))) {
                List<Map> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("values"), List.class
                );
                for (Map item1 : item) {
                    Map<String, Object> map = (HashMap) item1;
                    Facilityorderitems facilityorderitems = new Facilityorderitems();
                    facilityorderitems.setFacilityorderid(new Facilityorder(Long.parseLong(request.getParameter("facilityorderid"))));
                    facilityorderitems.setItemid(new Item(Long.parseLong(String.valueOf((Integer) map.get("itemid")))));
                    facilityorderitems.setQtyordered(BigInteger.valueOf(Long.parseLong((String) map.get("qty"))));
                    facilityorderitems.setQtyapproved(BigInteger.valueOf(Long.parseLong((String) map.get("qty"))));
                    facilityorderitems.setApproved(Boolean.FALSE);
                    genericClassService.saveOrUpdateRecordLoadObject(facilityorderitems);
                }
                String[] columns = {"status"};
                Object[] columnValues = {"PAUSED"};
                String pk = "facilityorderid";
                Object pkValue = Long.parseLong(request.getParameter("facilityorderid"));

                int result = genericClassService.updateRecordSQLSchemaStyle(Facilityorder.class,
                        columns, columnValues, pk, pkValue, "store");

            } else {
                List<Map> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("values"), List.class
                );
                for (Map item1 : item) {
                    Map<String, Object> map = (HashMap) item1;
                    Facilityorderitems facilityorderitems = new Facilityorderitems();
                    facilityorderitems.setFacilityorderid(new Facilityorder(Long.parseLong(request.getParameter("facilityorderid"))));
                    facilityorderitems.setItemid(new Item(Long.parseLong(String.valueOf((Integer) map.get("itemid")))));
                    facilityorderitems.setQtyordered(BigInteger.valueOf(Long.parseLong((String) map.get("qty"))));
                    facilityorderitems.setQtyapproved(BigInteger.valueOf(Long.parseLong((String) map.get("qty"))));
                    facilityorderitems.setApproved(Boolean.FALSE);
                    genericClassService.saveOrUpdateRecordLoadObject(facilityorderitems);
                }
                String[] columns = {"status"};
                Object[] columnValues = {"SUBMITTED"};
                String pk = "facilityorderid";
                Object pkValue = Long.parseLong(request.getParameter("facilityorderid"));

                int result = genericClassService.updateRecordSQLSchemaStyle(Facilityorder.class,
                        columns, columnValues, pk, pkValue, "store");

            }

        } catch (IOException exception) {

        }
        return results;
    }

    @RequestMapping(value = "/pausercalledorder.htm")
    public @ResponseBody
    String pausercalledorder(HttpServletRequest request) {
        String results = "";
        String[] columns = {"status"};
        Object[] columnValues = {"PAUSED"};
        String pk = "facilityorderid";
        Object pkValue = Long.parseLong(request.getParameter("facilityorderid"));

        int result = genericClassService.updateRecordSQLSchemaStyle(Facilityorder.class,
                columns, columnValues, pk, pkValue, "store");
        if (result != 0) {
            results = "success";
        }
        return results;
    }

    @RequestMapping(value = "/existingordsaddmoritms.htm", method = RequestMethod.GET)

    public String existingordsaddmoritms(Model model, HttpServletRequest request) {

        model.addAttribute("facilityorderid", request.getParameter("facilityorderid"));
        model.addAttribute("facilityorderno", request.getParameter("facilityorderno"));
        model.addAttribute("facilityunitsupplierid", request.getParameter("facilityunitsupplierid"));
        model.addAttribute("dateneeded", request.getParameter("dateneeded"));
        model.addAttribute("dateprepared", request.getParameter("dateprepared"));
        model.addAttribute("personname", request.getParameter("personname"));
        model.addAttribute("status", request.getParameter("status"));
        if (Boolean.valueOf(request.getParameter("isemergency")) == true) {
            model.addAttribute("criteria", "Yes");
        } else {
            model.addAttribute("criteria", "No");
        }

        model.addAttribute("facilityunitname", request.getParameter("facilityunitname"));
        model.addAttribute("supplies", request.getParameter("supplies"));
        model.addAttribute("originstore", request.getParameter("originstore"));
        Set<Long> addeditems = new HashSet<>();

        String[] params4 = {"facilityorderid"};
        Object[] paramsValues4 = {Long.parseLong(request.getParameter("facilityorderid"))};
        String[] fields4 = {"itemid.itemid"};
        String where4 = "WHERE facilityorderid=:facilityorderid";
        List<Long> itemids = (List<Long>) genericClassService.fetchRecord(Facilityorderitems.class,
                fields4, where4, params4, paramsValues4);
        if (itemids != null) {
            for (Long items : itemids) {
                addeditems.add(items);
            }
        }
        model.addAttribute("totaladdeditems", addeditems.size());
        /////////////////////////////////////////////////ffffffffffffffffffffffffffffffffffffff
        return "inventoryAndSupplies/orders/placeOrders/internalOrder/forms/addMoreExistingOrderItems";
    }

    @RequestMapping(value = "/checkforexistingiternalorder.htm")
    public @ResponseBody
    String checkforexistingiternalorder(HttpServletRequest request) {
        String results = "";
        String[] paramst = {"originstore", "destinationstore", "paused", "submitted", "sent", "serviced", "ordertype"};
        Object[] paramsValuest = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), BigInteger.valueOf(Long.parseLong(request.getParameter("supplier"))), "PAUSED", "SUBMITTED", "SENT", "SERVICED", "INTERNAL"};
        String wheret = "WHERE originstore=:originstore AND destinationstore=:destinationstore AND (status=:paused OR status=:submitted OR status=:sent OR status=:serviced) AND ordertype=:ordertype";
        String[] fieldst = {"facilityorderno", "facilityorderid", "isemergency", "preparedby", "dateprepared", "status", "dateneeded"};
        List<Object[]> facilityorder = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class,
                fieldst, wheret, paramst, paramsValuest);
        if (facilityorder != null) {
            results = "existing";
        }
        return results;
    }

    @RequestMapping(value = "/additemstoanexternalorder.htm", method = RequestMethod.GET)
    public String additemstoanexternalorder(Model model, HttpServletRequest request) {
        List<Map> itemsFound = new ArrayList<>();
        String[] params = {"facilityunitfinancialyearid", "approved"};
        Object[] paramsValues = {Integer.parseInt(request.getParameter("facilityunitfinancialyearid")), Boolean.TRUE};
        String[] fields = {"itemid"};
        String where = "WHERE facilityunitfinancialyearid=:facilityunitfinancialyearid AND approved=:approved";
        List<Long> itemid = (List<Long>) genericClassService.fetchRecord(Facilityunitprocurementplan.class,
                fields, where, params, paramsValues);
        ///changed ddddddddddddddddddddddddddddddddddddddddddddd
        if (itemid == null) {

        }

        if ("All".equals(request.getParameter("suppliername"))) {
            String[] params1 = {"facilityid"};
            Object[] paramsValues1 = {(Integer) request.getSession().getAttribute("sessionActiveLoginFacility")};
            String[] fields1 = {"fullname", "categoryname", "itemformid", "classificationname", "itemid"};
            String where1 = "WHERE facilityid=:facilityid";
            List<Object[]> itemid1 = (List<Object[]>) genericClassService.fetchRecord(Facilitycatalogue.class,
                    fields1, where1, params1, paramsValues1);
            if (itemid1 != null) {
                Map<String, Object> item;
                for (Object[] itms : itemid1) {
                    item = new HashMap<>();
                    item.put("id", itms[4]);
                    item.put("name", itms[0]);
                    item.put("cat", itms[1]);
                    item.put("code", itms[3]);
                    itemsFound.add(item);
                }

            }
        } else {
            String[] params1 = {"facilityid"};
            Object[] paramsValues1 = {(Integer) request.getSession().getAttribute("sessionActiveLoginFacility")};
            String[] fields1 = {"fullname", "categoryname", "itemformid", "classificationname", "itemid"};
            String where1 = "WHERE facilityid=:facilityid";
            List<Object[]> itemid1 = (List<Object[]>) genericClassService.fetchRecord(Facilitycatalogue.class,
                    fields1, where1, params1, paramsValues1);
            if (itemid1 != null) {
                Map<String, Object> item;
                for (Object[] itms : itemid1) {
                    item = new HashMap<>();
                    item.put("id", itms[4]);
                    item.put("name", itms[0]);
                    item.put("cat", itms[1]);
                    item.put("code", itms[3]);
                    itemsFound.add(item);
                }

            }
        }
        model.addAttribute("items", itemsFound);

        model.addAttribute("supplierid", request.getParameter("supplierid"));
        model.addAttribute("dateneeded", request.getParameter("dateneeded"));
        model.addAttribute("suppliername", request.getParameter("suppliername"));
        model.addAttribute("facilityunitname", request.getParameter("facilityunitname"));
        model.addAttribute("ordernumber", request.getParameter("ordernumber"));
        model.addAttribute("orderstage", request.getParameter("orderstage"));
        model.addAttribute("personname", request.getParameter("personname"));
        model.addAttribute("datecreated", request.getParameter("datecreated"));
        model.addAttribute("facilityunitfinancialyearid", request.getParameter("facilityunitfinancialyearid"));
        model.addAttribute("criteria", request.getParameter("criteria"));
        return "inventoryAndSupplies/orders/placeOrders/externalOrder/forms/addItems";
    }

    @RequestMapping(value = "/checkforexistingexternalsupplier.htm")
    public @ResponseBody
    String checkforexistingexternalsupplier(HttpServletRequest request) {
        String results = "";
        String[] params = {"ordertype", "originstore", "destinationstore", "submitted", "paused"};
        Object[] paramsValues = {"EXTERNAL", BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), BigInteger.valueOf(Long.parseLong(request.getParameter("supplierid"))), "SUBMITTED", "PAUSED"};
        String[] fields = {"facilityorderid"};
        String where = "WHERE ordertype=:ordertype AND originstore=:originstore AND destinationstore=:destinationstore AND (status=:submitted OR status=:paused)";
        List<Long> facilityorderid = (List<Long>) genericClassService.fetchRecord(Facilityorder.class,
                fields, where, params, paramsValues);
        if (facilityorderid != null) {
            results = "success";
        } else {
            results = "failed";
        }
        return results;
    }

    @RequestMapping(value = "/createdexistingexternalorderdetails.htm", method = RequestMethod.GET)
    public String createdexistingexternalorderdetails(Model model, HttpServletRequest request) {
        List<Map> ordersFound = new ArrayList<>();
        String[] params = {"ordertype", "originstore", "destinationstore", "submitted", "paused"};
        Object[] paramsValues = {"EXTERNAL", BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), BigInteger.valueOf(Long.parseLong(request.getParameter("supplierid"))), "SUBMITTED", "PAUSED"};
        String[] fields = {"facilityorderid", "status", "dateprepared", "dateneeded", "facilityorderno", "preparedby", "isemergency"};
        String where = "WHERE ordertype=:ordertype AND originstore=:originstore AND destinationstore=:destinationstore AND (status=:submitted OR status=:paused)";
        List<Object[]> facilityorder = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fields, where, params, paramsValues);
        if (facilityorder != null) {
            Map<String, Object> orderRow;
            for (Object[] facilityorderdet : facilityorder) {
                orderRow = new HashMap<>();
                String[] params2 = {"personid"};
                Object[] paramsValues2 = {facilityorderdet[5]};
                String[] fields2 = {"firstname", "lastname", "othernames"};
                List<Object[]> personname = (List<Object[]>) genericClassService.fetchRecord(Person.class,
                        fields2, "WHERE personid=:personid", params2, paramsValues2);
                if (personname != null) {
                    orderRow.put("personname", personname.get(0)[0] + " " + personname.get(0)[1]);
                }
                orderRow.put("facilityorderid", facilityorderdet[0]);
                orderRow.put("status", facilityorderdet[1]);
                orderRow.put("dateprepared", formatter.format((Date) facilityorderdet[2]));
                orderRow.put("dateneeded", formatter.format((Date) facilityorderdet[3]));
                orderRow.put("facilityorderno", facilityorderdet[4]);
                orderRow.put("isemergency", facilityorderdet[6]);
                orderRow.put("suppliername", request.getParameter("suppliername"));
                int internalordersitemscount = 0;
                String[] paramsc = {"facilityorderid"};
                Object[] paramsValuesc = {(Long) facilityorderdet[0]};
                String wherec = "WHERE facilityorderid=:facilityorderid";
                internalordersitemscount = genericClassService.fetchRecordCount(Facilityorderitems.class, wherec, paramsc, paramsValuesc);

                orderRow.put("internalordersitemscount", internalordersitemscount);
                ordersFound.add(orderRow);
            }
        }
        model.addAttribute("ordersFound", ordersFound);
        model.addAttribute("facilityunitfinancialyearid", request.getParameter("facilityunitfinancialyearid"));

        model.addAttribute("supplierid", request.getParameter("supplierid"));

        return "inventoryAndSupplies/orders/placeOrders/externalOrder/views/existingExternalOrder";
    }

    @RequestMapping(value = "/createdexistingexternalorderitems.htm", method = RequestMethod.GET)
    public String createdexistingexternalorderitems(Model model, HttpServletRequest request) {
        List<Map> itemsFound = new ArrayList<>();

        String[] params6 = {"facilityunitid"};
        Object[] paramsValues6 = {Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))};
        String[] fields6 = {"facilityunitname", "shortname"};
        List<Object[]> facilityunitlog = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields6, "WHERE facilityunitid=:facilityunitid", params6, paramsValues6);
        if (facilityunitlog != null) {
            model.addAttribute("originstore", facilityunitlog.get(0)[0]);
        }
        Long totalcost = 0L;
        String[] params = {"facilityorderid"};
        Object[] paramsValues = {Long.parseLong(request.getParameter("facilityorderid"))};
        String[] fields = {"facilityorderitemsid", "qtyordered", "itemid.itemid"};
        String where = "WHERE facilityorderid=:facilityorderid";
        List<Object[]> facilityorderitems = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fields, where, params, paramsValues);
        if (facilityorderitems != null) {
            Map<String, Object> itemRow;
            for (Object[] facilityorderitem : facilityorderitems) {
                itemRow = new HashMap<>();
                String[] params1 = {"itempackageid"};
                Object[] paramsValues1 = {facilityorderitem[2]};
                String[] fields1 = {"packagename", "packagequantity"};
                String where1 = "WHERE itempackageid=:itempackageid";
                List<Object[]> orderitems = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields1, where1, params1, paramsValues1);
                if (orderitems != null) {
                    totalcost = totalcost + 0;
                    itemRow.put("genericname", orderitems.get(0)[0]);
                    itemRow.put("packsize", orderitems.get(0)[1]);
                    itemRow.put("qtyordered", facilityorderitem[1]);
                    itemRow.put("facilityorderitemsid", facilityorderitem[0]);
                    itemsFound.add(itemRow);
                }
            }
        }
        model.addAttribute("totalcost", decimalFormat.format(totalcost));
        model.addAttribute("items", itemsFound);
        model.addAttribute("status", request.getParameter("status"));
        model.addAttribute("dateprepared", request.getParameter("dateprepared"));
        model.addAttribute("facilityorderid", request.getParameter("facilityorderid"));
        model.addAttribute("facilityorderno", request.getParameter("facilityorderno"));
        model.addAttribute("criteria", request.getParameter("criteria"));
        model.addAttribute("suppliername", request.getParameter("suppliername"));
        model.addAttribute("supplierid", request.getParameter("supplierid"));
        model.addAttribute("dateneeded", request.getParameter("dateneeded"));
        model.addAttribute("facilityunitfinancialyearid", request.getParameter("facilityunitfinancialyearid"));
        model.addAttribute("personname", request.getParameter("personname"));
        return "inventoryAndSupplies/orders/placeOrders/externalOrder/views/orderItems";
    }

    @RequestMapping(value = "/createdexistingexternaladdmoreorderitems.htm", method = RequestMethod.GET)
    public String createdexistingexternaladdmoreorderitems(Model model, HttpServletRequest request) {
        List<Map> itemsFound = new ArrayList<>();
        Set<Long> addeditems = new HashSet<>();

        String[] params4 = {"facilityorderid"};
        Object[] paramsValues4 = {Long.parseLong(request.getParameter("facilityorderid"))};
        String[] fields4 = {"itemid.itemid"};
        String where4 = "WHERE facilityorderid=:facilityorderid";
        List<Long> itemids = (List<Long>) genericClassService.fetchRecord(Facilityorderitems.class, fields4, where4, params4, paramsValues4);
        if (itemids != null) {
            for (Long items : itemids) {
                addeditems.add(items);
            }
        }

        String[] params = {"facilityunitfinancialyearid", "approved"};
        Object[] paramsValues = {Integer.parseInt(request.getParameter("facilityunitfinancialyearid")), Boolean.TRUE};
        String[] fields = {"itemid"};
        String where = "WHERE facilityunitfinancialyearid=:facilityunitfinancialyearid AND approved=:approved";
        List<Long> itemid = (List<Long>) genericClassService.fetchRecord(Facilityunitprocurementplan.class, fields, where, params, paramsValues);
        if (itemid != null) {
            Map<String, Object> item;
            for (Long itemS : itemid) {
                item = new HashMap<>();
                String[] params1 = {"itempackageid"};
                Object[] paramsValues1 = {BigInteger.valueOf(itemS)};
                String[] fields1 = {"packagename", "categoryname", "itemformid", "itemcode"};
                String where1 = "WHERE itempackageid=:itempackageid";
                List<Object[]> itemid1 = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class,
                        fields1, where1, params1, paramsValues1);
                if (itemid1 != null) {
                    if (!addeditems.isEmpty() && !addeditems.contains(itemS)) {
                        item.put("id", itemS);
                        item.put("name", itemid1.get(0)[0]);
                        item.put("cat", itemid1.get(0)[1]);
                        item.put("code", itemid1.get(0)[3]);
                        itemsFound.add(item);
                    }
                }
            }
        }
        model.addAttribute("items", itemsFound);
        model.addAttribute("totalitems", addeditems.size());
        model.addAttribute("status", request.getParameter("status"));
        model.addAttribute("dateprepared", request.getParameter("dateprepared"));
        model.addAttribute("facilityorderid", request.getParameter("facilityorderid"));
        model.addAttribute("facilityorderno", request.getParameter("facilityorderno"));
        model.addAttribute("criteria", request.getParameter("criteria"));
        model.addAttribute("suppliername", request.getParameter("suppliername"));
        model.addAttribute("supplierid", request.getParameter("supplierid"));
        model.addAttribute("dateneeded", request.getParameter("dateneeded"));
        model.addAttribute("facilityunitfinancialyearid", request.getParameter("facilityunitfinancialyearid"));
        model.addAttribute("personname", request.getParameter("personname"));
        model.addAttribute("originstore", request.getParameter("originstore"));
        return "inventoryAndSupplies/orders/placeOrders/externalOrder/forms/addMoreItems";
    }

    @RequestMapping(value = "/checkforexternalorderitemsconsumptions.htm")
    public @ResponseBody
    String checkforexternalorderitemsconsumptions(HttpServletRequest request) {
        String results = "";
        try {
            if ("All".equals(request.getParameter("suppliername"))) {
                String[] params = {"itemid"};
                Object[] paramsValues = {Long.parseLong(request.getParameter("itemid"))};
                String[] fields = {"itemcost", "supplierid", "packsize"};
                String where = "WHERE itemid=:itemid";
                List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Supplieritem.class, fields, where, params, paramsValues);
                if (items != null) {
                    results = "supplied";
                } else {
                    results = "nosupplier";
                }
            } else {

            }
        } catch (NumberFormatException e) {
            System.out.println(e);
        }
        return results;
    }

    private List<Map> getItemslocations(long itemid, long currentfacility) {
        List<Map> itemsWithCellLocations = new ArrayList<>();
        float expired = 0;
        //FOR EACH ITEM(item ID find cells its located in
        String[] paramslocateitemcell = {"itemid", "facilityunitid"};
        Object[] paramsValueslocateitemcell = {itemid, currentfacility};
        String wherelocateitemcell = "WHERE itemid=:itemid AND facilityunitid=:facilityunitid AND quantityshelved > 0 ORDER BY daystoexpire";
        String[] fieldslocateitemcell = {"itemid", "bayrowcellid", "quantityshelved", "daystoexpire", "celllabel", "batchnumber", "stockid"};
        List<Object[]> objlocateitemcell = (List<Object[]>) genericClassService.fetchRecord(Cellitems.class, fieldslocateitemcell, wherelocateitemcell, paramslocateitemcell, paramsValueslocateitemcell);
        if (objlocateitemcell != null) {
            //Object[] cells = objlocateitemcell.get(0);
            Map<String, Object> cellMap;
            for (Object[] object : objlocateitemcell) {
                cellMap = new HashMap<>();
                if (object[3] != null) {
                    if ((Integer) object[3] > 0) {
                        expired = (Integer) object[3];
                        cellMap.put("daystoexpire", expired);
                        cellMap.put("itemid", object[0]);
                        cellMap.put("cellid", object[1]);
                        cellMap.put("qty", (Integer) object[2]);
                        cellMap.put("cell", object[4]);
                        cellMap.put("batchnumber", object[5]);
                        cellMap.put("stockid", object[6]);
                        itemsWithCellLocations.add(cellMap);
                    }
                } else {
                    cellMap.put("daystoexpire", 0.5);
                    cellMap.put("itemid", object[0]);
                    cellMap.put("cellid", object[1]);
                    cellMap.put("qty", (Integer) object[2]);
                    cellMap.put("cell", object[4]);
                    cellMap.put("batchnumber", object[5]);
                    cellMap.put("stockid", object[6]);
                    itemsWithCellLocations.add(cellMap);
                }
            }
        }
        return itemsWithCellLocations;
    }

    private List<Map> generatePickList(List<Map> itemLocations, Integer quantityNeeded) {
        List<Map> itemPickList = new ArrayList<>();
        Map<String, Object> cellDatails;
        for (Map loc : itemLocations) {
            cellDatails = new HashMap<>();
            if ((Integer) loc.get("qty") < quantityNeeded) {
                cellDatails.put("cellid", loc.get("cellid"));
                cellDatails.put("cell", loc.get("cell"));
                cellDatails.put("batch", loc.get("batchnumber"));
                cellDatails.put("qty", loc.get("qty"));
                cellDatails.put("stockid", loc.get("stockid"));
                itemPickList.add(cellDatails);
                quantityNeeded = quantityNeeded - (Integer) loc.get("qty");
            } else {
                cellDatails.put("cellid", loc.get("cellid"));
                cellDatails.put("cell", loc.get("cell"));
                cellDatails.put("batch", loc.get("batchnumber"));
                cellDatails.put("stockid", loc.get("stockid"));
                cellDatails.put("qty", quantityNeeded);
                itemPickList.add(cellDatails);
                break;
            }
        }
        return itemPickList;
    }

    @RequestMapping(value = "/generatewalkorder.htm")
    public @ResponseBody
    String generatewalkorder(Model model, HttpServletRequest request) throws IOException {
        Set cellLocationSet = new HashSet();
        int section = Integer.parseInt(request.getParameter("selectedid").toString());
        String page = "";
        String jsonsortedList = "";
        String jsonsortedListx = "";

        try {
            List<Map> itemorderqty = new ObjectMapper().readValue(request.getParameter("qtyorderedvalues"), List.class);
            for (Map itemone : itemorderqty) {
                Map<String, Object> map = (HashMap) itemone;
                cellLocationSet.add((String) map.get("value"));
            }
            List sortedList = new ArrayList(cellLocationSet);
            Collections.sort(sortedList);
            switch (section) {
                case 1:
                    jsonsortedListx = new ObjectMapper().writeValueAsString(sortedList);
                    page = jsonsortedListx;
                    break;
                case 2:
                    jsonsortedList = new ObjectMapper().writeValueAsString(sortedList);
                    page = jsonsortedList;
                    break;
                default:
                    break;
            }
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return page;
    }

    Comparator sortCells = new Comparator<Map>() {
        @Override
        public int compare(final Map o1, final Map o2) {
            try {
                return ((String) o1.get("cell")).compareTo((String) o2.get("cell"));
            } catch (Exception e) {
                System.out.println(e);
            }
            return 0;
        }
    };

    @RequestMapping(value = "/checkforapprovedorderitem.htm")
    public @ResponseBody
    String checkforapprovedorderitem(HttpServletRequest request) {
        String results = "";
        String[] params = {"facilityorderid", "approved"};
        Object[] paramsValues = {Long.parseLong(request.getParameter("facilityorderid")), Boolean.TRUE};
        String[] fields = {"facilityorderitemsid"};
        String where = "WHERE facilityorderid=:facilityorderid AND approved=:approved";
        List<Long> items = (List<Long>) genericClassService.fetchRecord(Facilityorderitems.class, fields, where, params, paramsValues);
        if (items == null) {
            results = "success";
        } else {
            results = "failed";
        }
        return results;
    }

    @RequestMapping(value = "/receiveSentOrders.htm", method = RequestMethod.GET)
    public String receiveSentOrders(HttpServletRequest request, Model model) {
        List<Map> readyOrdersList = new ArrayList<>();

        //Fetch Facility Orders
        String[] paramsfacilityunitReadyOrders = {"originstore", "status", "ordertype", "taken"};
        Object[] paramsValuesfacilitunitReadyOrders = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), "DELIVERED", "INTERNAL", false};
        String[] fieldsunitReadyOrders = {"facilityorderid", "facilityorderno", "destinationstore", "isemergency", "dateprepared", "dateneeded", "approvedby"};
        String whereunitReadyOrders = "WHERE originstore=:originstore AND status=:status AND ordertype=:ordertype AND taken=:taken";
        List<Object[]> objfunitReadyOrders = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fieldsunitReadyOrders, whereunitReadyOrders, paramsfacilityunitReadyOrders, paramsValuesfacilitunitReadyOrders);
        if (objfunitReadyOrders != null) {
            Map<String, Object> mapReadyOrders;
            for (Object[] readyOrders : objfunitReadyOrders) {
                mapReadyOrders = new HashMap<>();
                mapReadyOrders.put("orderno", readyOrders[1]);
                mapReadyOrders.put("facilityorderid", readyOrders[0]);
                mapReadyOrders.put("destinationstore", readyOrders[2]);

                //Fetch Facility Units
                String[] paramsfunits = {"facilityunitid"};
                Object[] paramsValuesfunit = {readyOrders[2]};
                String wherefunit = "WHERE facilityunitid=:facilityunitid";
                String[] fieldsfunit = {"facilityunitname"};
                List<String> facilityunitnames = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fieldsfunit, wherefunit, paramsfunits, paramsValuesfunit);
                if (facilityunitnames != null) {
                    mapReadyOrders.put("supplierunit", facilityunitnames.get(0));
                }

                //Fetch Order Items number
                int noOfItems = 0;
                String[] paramsnumberofitems = {"facilityorderid", "isdelivered"};
                Object[] paramsValuesnumberofitems = {readyOrders[0], Boolean.TRUE};
                String wherenumberofitems = "WHERE facilityorderid=:facilityorderid AND isdelivered=:isdelivered";
                noOfItems = genericClassService.fetchRecordCount(Facilityorderitems.class, wherenumberofitems, paramsnumberofitems, paramsValuesnumberofitems);
                mapReadyOrders.put("numberofitems", noOfItems);

                //Fetch Delivered By
                String[] paramsDeliveredby = {"facilityorderid", "isdelivered"};
                Object[] paramsValuesDeliveredby = {readyOrders[0], Boolean.TRUE};
                String whereDeliveredby = "WHERE facilityorderid=:facilityorderid AND isdelivered=:isdelivered ORDER BY datedelivered ASC LIMIT 1";
                String[] fieldsDeliveredby = {"facilityorderitemsid", "deliveredby", "datedelivered", "deliveredto"};
                List<Object[]> objDeliveredbystaff = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fieldsDeliveredby, whereDeliveredby, paramsDeliveredby, paramsValuesDeliveredby);
                if (objDeliveredbystaff != null) {
                    Object[] deliveredby = objDeliveredbystaff.get(0);

                    //Query Staff details
                    String[] paramsPersondetailsDeliver = {"staffid"};
                    Object[] paramsValuesPersondetailsDeliver = {deliveredby[1]};
                    String[] fieldsPersondetailsDeliver = {"personid", "firstname", "lastname", "othernames"};
                    String wherePersondetailsDeliver = "WHERE staffid=:staffid";
                    List<Object[]> objPersondetailsDeliver = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fieldsPersondetailsDeliver, wherePersondetailsDeliver, paramsPersondetailsDeliver, paramsValuesPersondetailsDeliver);
                    if (objPersondetailsDeliver != null) {
                        Object[] persondetailsDeliver = objPersondetailsDeliver.get(0);
                        if (persondetailsDeliver[3] != null) {
                            mapReadyOrders.put("deliveredby", (String) persondetailsDeliver[1] + " " + (String) persondetailsDeliver[2] + " " + (String) persondetailsDeliver[3]);
                        } else {
                            mapReadyOrders.put("deliveredby", (String) persondetailsDeliver[1] + " " + (String) persondetailsDeliver[2]);
                        }
                    }
                    mapReadyOrders.put("datedelivered", formatter.format((Date) deliveredby[2]));

                    String[] paramsPersondetailsDeliver2 = {"staffid"};
                    Object[] paramsValuesPersondetailsDeliver2 = {deliveredby[3]};
                    String[] fieldsPersondetailsDeliver2 = {"personid", "firstname", "lastname", "othernames"};
                    String wherePersondetailsDeliver2 = "WHERE staffid=:staffid";
                    List<Object[]> objPersondetailsDeliver2 = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fieldsPersondetailsDeliver2, wherePersondetailsDeliver2, paramsPersondetailsDeliver2, paramsValuesPersondetailsDeliver2);
                    if (objPersondetailsDeliver2 != null) {
                        Object[] persondetailsDeliver2 = objPersondetailsDeliver2.get(0);
                        if (persondetailsDeliver2[3] != null) {
                            mapReadyOrders.put("deliveredto", (String) persondetailsDeliver2[1] + " " + (String) persondetailsDeliver2[2] + " " + (String) persondetailsDeliver2[3]);
                        } else {
                            mapReadyOrders.put("deliveredto", (String) persondetailsDeliver2[1] + " " + (String) persondetailsDeliver2[2]);
                        }
                    }

                }
                readyOrdersList.add(mapReadyOrders);
            }
            model.addAttribute("readyOrdersList", readyOrdersList);
        }
        return "inventoryAndSupplies/inventory/views/receiveSentOrders/receiveSentOrdersPane";
    }

    @RequestMapping(value = "/receiveFacilityUnitReadyOrder.htm", method = RequestMethod.GET)
    public String receiveFacilityUnitReadyOrder(Model model, HttpServletRequest request, @ModelAttribute("facilityorderid") String facilityorderid, @ModelAttribute("destinationstore") String destinationstore, @ModelAttribute("ordernumber") String ordernumber) {
        int handovertablesize = 0;
        BigInteger deliveredto = null;

        List<Map> pickedOrdeList = new ArrayList<>();
        String[] paramqtyonorder = {"facilityorderid", "isdelivered"};
        Object[] paramsValuesqtyonorder = {Long.parseLong(facilityorderid), true};
        String[] fieldsqtyonorder = {"qtyapproved", "itemid.itemid", "facilityorderitemsid", "deliveredto"};
        String whereqtyonorder = "WHERE facilityorderid=:facilityorderid AND isdelivered=:isdelivered";
        List<Object[]> objOrderqtyonorder = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fieldsqtyonorder, whereqtyonorder, paramqtyonorder, paramsValuesqtyonorder);
        Map<String, Object> onorder;
        if (objOrderqtyonorder != null) {
            for (Object[] itemQtyonorder : objOrderqtyonorder) {
                onorder = new HashMap<>();
                String[] paramorderissuance = {"facilityorderitemsid"};
                Object[] paramsValueorderissuance = {itemQtyonorder[2]};
                String whereorderissuance = "WHERE facilityorderitemsid=:facilityorderitemsid";
                String[] fieldsorderissuance = {"orderissuanceid", "quantitydelivered", "stockid.stockid"};
                List<Object[]> objorderissuance = (List<Object[]>) genericClassService.fetchRecord(Orderissuance.class,
                        fieldsorderissuance, whereorderissuance, paramorderissuance, paramsValueorderissuance);
                List<Map> pickedListItemValues = new ArrayList<>();
                if (objorderissuance != null) {
                    Map<String, Object> onorderitem;
                    for (Object[] orderissuance : objorderissuance) {
                        onorderitem = new HashMap<>();
                        onorderitem.put("quantitydelivered", String.format("%,d", (Integer) orderissuance[1]));
                        onorderitem.put("quantitydeliverednocommas", orderissuance[1]);
                        onorderitem.put("orderissuanceid", orderissuance[0]);
                        onorderitem.put("stockid", orderissuance[2]);
                        onorderitem.put("facilityorderitemsid", itemQtyonorder[2]);

                        String[] parambatch = {"stockid"};
                        Object[] paramsValuebatch = {orderissuance[2]};
                        String wherebatch = "WHERE stockid=:stockid";
                        String[] fieldsbatch = {"stockid", "batchnumber", "expirydate"};
                        List<Object[]> objbatch = (List<Object[]>) genericClassService.fetchRecord(Stock.class,
                                fieldsbatch, wherebatch, parambatch, paramsValuebatch);
                        if (objbatch != null) {
                            Object[] batch = objbatch.get(0);
                            onorderitem.put("batchno", batch[1]);
                            if (batch[2] != null) {
                                onorderitem.put("expirydate", formatter.format((Date) batch[2]));
                            } else {
                                onorderitem.put("expirydate", "No Expiry");
                            }
                        }
                        pickedListItemValues.add(onorderitem);
                    }
                }
                deliveredto = (BigInteger) itemQtyonorder[3];
                String[] paramitem = {"itempackageid"};
                Object[] paramsValueitem = {itemQtyonorder[1]};
                String whereitem = "WHERE itempackageid=:itempackageid";
                String[] fieldsitem = {"itempackageid", "packagename"};
                List<Object[]> objItem = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fieldsitem, whereitem, paramitem, paramsValueitem);
                if (objItem != null) {
                    for (Object[] itemdetails : objItem) {
                        onorder.put("genericname", (String) itemdetails[1]);
                    }
                }
                int itemHandoverListsize = pickedListItemValues.size();
                handovertablesize = handovertablesize + itemHandoverListsize;
                onorder.put("pickedListItemValues", pickedListItemValues);
                pickedOrdeList.add(onorder);
            }
        }
        model.addAttribute("destinationstore", destinationstore);
        model.addAttribute("deliveredto", deliveredto);
        model.addAttribute("handovertablesize", handovertablesize);
        model.addAttribute("facilityorderid", facilityorderid);
        model.addAttribute("items", pickedOrdeList);
        model.addAttribute("ordernumber", ordernumber);
        return "inventoryAndSupplies/inventory/views/receiveSentOrders/verifyReceivedOrderItems";
    }

    @RequestMapping(value = "/printPickList.htm")
    public @ResponseBody
    String printPickList(Model model, HttpServletRequest request) throws Exception {
        ObjectMapper mapper = new ObjectMapper();
        List<Map> walkList = new ArrayList<>();
        String walkorder = request.getParameter("walkorder");
        String generatedpicklist = request.getParameter("generalpicklist");
        Document doc = new Document();
        PdfWriter docWriter = null;
        Font bfBold12 = new Font(Font.FontFamily.TIMES_ROMAN, 11, Font.BOLD, new BaseColor(0, 0, 0));
        Font bfBold = new Font(Font.FontFamily.TIMES_ROMAN, 10, Font.BOLD, new BaseColor(0, 0, 0));
        Font bfBold14 = new Font(Font.FontFamily.TIMES_ROMAN, 20, Font.BOLD, new BaseColor(0, 0, 0));
        Font bfBoldletters = new Font(Font.FontFamily.TIMES_ROMAN, 16, Font.BOLD, new BaseColor(0, 0, 0));

        try {
            List<String> walk = (ArrayList<String>) mapper.readValue(walkorder, List.class);
            Map<String, Object> node;
            for (String cell : walk) {
                node = new HashMap<>();
                node.put("cell", cell);
                List<String> letters = new ArrayList<>();
                node.put("letterList", letters);
                walkList.add(node);
            }
            doc.setPageSize(PageSize.A4);
            docWriter = PdfWriter.getInstance(doc, new FileOutputStream(createMyDirectory("MAINSTORE") + "picklist.pdf"));
            doc.open();

            String personidsession = request.getSession().getAttribute("person_id").toString();
            String personName = "";
            String[] paramsper = {"personid"};
            Object[] paramsValuesper = {BigInteger.valueOf(Long.parseLong(personidsession))};
            String whereper = "WHERE personid=:personid";
            String[] fieldsper = {"firstname", "lastname", "othernames"};
            List<Object[]> objper = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fieldsper, whereper, paramsper, paramsValuesper);
            if (objper != null) {
                Object[] objper2 = objper.get(0);
                if (objper2[2] != null) {
                    personName = objper2[0] + " " + objper2[1] + " " + objper2[2];
                } else {
                    personName = objper2[0] + " " + objper2[1];
                }
            }

            //PICK LIST Content above the tables
            Paragraph picklistno = new Paragraph(new Phrase("Pick List", bfBold14));
            picklistno.setSpacingAfter(8);

            Paragraph datecreated = new Paragraph(new Phrase("Date Created: " + formatter.format(new Date()), bfBold12));
            Paragraph createdby = new Paragraph(new Phrase("Created By: " + personName, bfBold12));
            doc.add(picklistno);
            doc.add(datecreated);
            doc.add(createdby);

            // Horizontal Line
            doc.add(Chunk.NEWLINE);
            doc.add(new LineSeparator());

            PdfPTable tableresults = new PdfPTable(2);
            tableresults.setWidthPercentage(100);
            tableresults.setSpacingBefore(4f);
            float[] px = {120, 30};
            tableresults.setWidths(px);
            List<Map> picklistTags = (ArrayList<Map>) mapper.readValue(generatedpicklist, List.class);
            PdfPCell cell1b = new PdfPCell();
            PdfPCell cell2b = new PdfPCell();
            int i = 0;
            for (Map CellItems : picklistTags) {
                String Letter = generateLetter(i);
                i = i + 1;
                String itemname = CellItems.get("genericname").toString();
                String itemqty = CellItems.get("quantityapproved").toString();
                String nameQty = itemname + "   " + "Quantity To Pick:" + itemqty;
                Paragraph nameandqty = new Paragraph(new Phrase(nameQty, bfBold12));
                nameandqty.setSpacingAfter(4f);
                cell1b.setBorder(Rectangle.NO_BORDER);
                cell1b.addElement(nameandqty);

                PdfPTable tableitems = new PdfPTable(6);
                tableitems.setWidthPercentage(100);
                tableresults.setSpacingBefore(4f);
                float[] pk = {30, 30, 80, 70, 40, 50};
                tableitems.setWidths(pk);
                PdfPCell celltagLabel = new PdfPCell(new Paragraph(" ", bfBold12));
                celltagLabel.setPadding(4f);
                PdfPCell cellNo = new PdfPCell(new Paragraph("#", bfBold12));
                cellNo.setPadding(4f);
                PdfPCell celllabel = new PdfPCell(new Paragraph("Cell", bfBold12));
                celllabel.setPadding(4f);
                PdfPCell itembatch = new PdfPCell(new Paragraph("Batch", bfBold12));
                itembatch.setPadding(4f);
                PdfPCell itemQTY = new PdfPCell(new Paragraph("QTY", bfBold12));
                itemQTY.setPadding(4f);
                itemQTY.setHorizontalAlignment(PdfPCell.ALIGN_RIGHT);
                PdfPCell itemqtyPicked = new PdfPCell(new Paragraph("QTY Picked", bfBold12));
                itemqtyPicked.setPadding(4f);
                //table alignment
                tableitems.addCell(celltagLabel);
                tableitems.addCell(cellNo);
                tableitems.addCell(celllabel);
                tableitems.addCell(itembatch);
                tableitems.addCell(itemQTY);
                tableitems.addCell(itemqtyPicked);

                //table Items contents
                List<Map> picklistitems = (ArrayList) CellItems.get("pick");
                int countx = 0;
                int spansize = picklistitems.size();
                PdfPCell testletter = new PdfPCell(new Paragraph(Letter, bfBoldletters));
                testletter.setRowspan(spansize);
                testletter.setPadding(4f);
                testletter.setVerticalAlignment(Element.ALIGN_MIDDLE);
                tableitems.addCell(testletter);
                for (Map itemspicked : picklistitems) {
                    String celltag = itemspicked.get("cell").toString();
                    String batchNo = itemspicked.get("batch").toString();
                    String qty = String.format("%,d", Integer.parseInt(itemspicked.get("qty").toString()));
                    countx = countx + 1;

                    for (int x = 0; x < walkList.size(); x++) {
                        if (celltag.equalsIgnoreCase((String) walkList.get(x).get("cell"))) {
                            List<String> temp = (List<String>) walkList.get(x).get("letterList");
                            temp.add(Letter + String.valueOf(countx));
                            walkList.get(x).put("letterList", temp);
                            break;
                        }
                    }

                    PdfPCell itemcount = new PdfPCell(new Paragraph(String.valueOf(countx), bfBold));
                    itemcount.setPadding(4f);
                    PdfPCell cell = new PdfPCell(new Paragraph(celltag, bfBold));
                    cell.setPadding(4f);
                    PdfPCell batch = new PdfPCell(new Paragraph(batchNo, bfBold));
                    batch.setPadding(4f);
                    PdfPCell quantity = new PdfPCell(new Paragraph(qty, bfBold));
                    quantity.setPadding(4f);
                    quantity.setHorizontalAlignment(PdfPCell.ALIGN_RIGHT);
                    PdfPCell quantitypick = new PdfPCell(new Paragraph(" ", bfBold));
                    quantitypick.setPadding(4f);

                    tableitems.addCell(itemcount);
                    tableitems.addCell(cell);
                    tableitems.addCell(batch);
                    tableitems.addCell(quantity);
                    tableitems.addCell(quantitypick);

                }
                cell1b.addElement(tableitems);
            }

            tableresults.addCell(cell1b);
            //generated walklist
            Paragraph walktitle = new Paragraph("Walk Order", bfBold12);
            walktitle.setSpacingAfter(4f);
            cell2b.addElement(walktitle);

            PdfPTable tablewalk = new PdfPTable(2);
            tablewalk.setWidthPercentage(100);
            tableresults.setSpacingBefore(4f);
            float[] px1 = {40, 90};
            tablewalk.setWidths(px1);
            PdfPCell cellwalkNo = new PdfPCell(new Paragraph("#", bfBold12));
            cellwalkNo.setPadding(4f);
            PdfPCell cellwalklabel = new PdfPCell(new Paragraph("CELL", bfBold12));
            cellwalklabel.setPadding(4f);
            //table alignment
            tablewalk.addCell(cellwalkNo);
            tablewalk.addCell(cellwalklabel);
            int countitem = 0;
            for (Map cellLocation : walkList) {
                countitem = countitem + 1;
                PdfPCell walkcount = new PdfPCell(new Paragraph(String.valueOf(countitem), bfBold));
                walkcount.setPadding(4f);
                PdfPCell cellname = new PdfPCell();
                cellname.addElement(new Paragraph((String) cellLocation.get("cell"), bfBold));
                List<String> letterOrder = (List<String>) cellLocation.get("letterList");
                String splitLetterOrder = "| ";
                for (int j = 0; j < letterOrder.size(); j++) {
                    splitLetterOrder = splitLetterOrder + letterOrder.get(j) + " |";
                }
                cellname.addElement(new Paragraph(splitLetterOrder, bfBold));
                cellname.setPadding(4f);
                tablewalk.addCell(walkcount);
                tablewalk.addCell(cellname);
            }
            cell2b.addElement(tablewalk);
            cell2b.setBorder(Rectangle.NO_BORDER);
            tableresults.addCell(cell2b);
            doc.add(tableresults);

            //PICK LIST Content BELOW the tables
            Paragraph pickedby = new Paragraph(new Phrase("Picked By:", bfBold12));
            Phrase phrase = new Phrase(" _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _");
            Phrase phrase2 = new Phrase("  Date and Time: _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _");
            pickedby.add(phrase);
            pickedby.add(phrase2);
            doc.add(pickedby);

            Paragraph issuedBy = new Paragraph(new Phrase("Issued By:", bfBold12));
            Phrase phraseiss = new Phrase(" _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _");
            Phrase phraseiss2 = new Phrase("  Date and Time: _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _");
            issuedBy.add(phraseiss);
            issuedBy.add(phraseiss2);
            doc.add(issuedBy);

            Paragraph collectedBy = new Paragraph(new Phrase("Collected By:", bfBold12));
            Phrase phrasecoll = new Phrase("_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _");
            Phrase phrasecoll2 = new Phrase("  Date and Time: _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _");
            collectedBy.add(phrasecoll);
            collectedBy.add(phrasecoll2);
            doc.add(collectedBy);

            doc.close();
        } catch (IOException | DocumentException ex) {
            System.out.println(ex);
        }
        try {
            File selectedpdfFile = new File(createMyDirectory("MAINSTORE") + "picklist.pdf");
            if (selectedpdfFile.exists()) {
                return Base64.getEncoder().encodeToString(loadFileAsBytesArray(createMyDirectory("MAINSTORE") + "picklist.pdf"));
            } else {
                System.out.println("File is not exists!");
            }

            System.out.println("Done");

        } catch (IOException ex) {
            ex.printStackTrace();
        }

        return "success";
    }

    public String createMyDirectory(String dir) {
        String subdirectory = "";
        switch (OsCheck.getOperatingSystemType().toString()) {
            case "Windows":
                if (!(new File("C:\\Orders\\documents\\" + dir + "\\")).exists()) {
                    (new File("C:\\Orders\\documents\\" + dir + "\\")).mkdirs();
                    subdirectory = "C:\\Orders\\documents\\" + dir + "\\";
                } else {
                    subdirectory = "C:\\Orders\\documents\\" + dir + "\\";
                }
                break;
            case "Linux":
                if (!(new File("/home/Orders/documents/" + dir + "/")).exists()) {
                    (new File("/home/Orders/documents/" + dir + "/")).mkdirs();
                    subdirectory = "/home/Orders/documents/" + dir + "/";
                } else {
                    subdirectory = "/home/Orders/documents/" + dir + "/";
                }
                break;
            case "MacOS":
                if (!(new File("/Users/Orders/documents/" + dir + "/")).exists()) {
                    (new File("/Users/Orders/documents/" + dir + "/")).mkdirs();
                    subdirectory = "/Users/Orders/documents/" + dir + "/";
                } else {
                    subdirectory = "/Users/Orders/documents/" + dir + "/";
                }
                break;
            default:
                break;
        }
        return subdirectory;
    }

    private String generateLetter(int i) {
        String[] letters = {
            "A", "B", "C", "D", "E", "F",
            "G", "H", "I", "J", "K", "L",
            "M", "N", "O", "P", "Q", "R",
            "S", "T", "U", "V", "W", "X",
            "Y", "Z"
        };
        if (i < 26) {
            return letters[i];
        }
        int j = i / 26;
        return generateLetter(j - 1) + letters[(i % 26)];
    }

    public static byte[] loadFileAsBytesArray(String fileName) throws Exception {
        File file = new File(fileName);
        int length = (int) file.length();
        BufferedInputStream reader = new BufferedInputStream(new FileInputStream(file));
        byte[] bytes = new byte[length];
        reader.read(bytes, 0, length);
        reader.close();
        return bytes;
    }

    @RequestMapping(value = "/editexistingorderitem.htm")
    public @ResponseBody
    String editexistingorderitem(HttpServletRequest request) {
        try {
            String[] columns = {"qtyapproved"};
            Object[] columnValues = {BigInteger.valueOf(Long.parseLong(request.getParameter("qty")))};
            String pk = "facilityorderitemsid";
            Object pkValue = Long.parseLong(request.getParameter("facilityorderitemsid"));
            genericClassService.updateRecordSQLSchemaStyle(Facilityorderitems.class,columns, columnValues, pk, pkValue, "store");
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return "";
    }

    @RequestMapping(value = "/approvingOrderprocess.htm")
    public @ResponseBody
    String approvingOrderprocess(HttpServletRequest request) {
        String results = "";
        int internalorderscomplete = 0;
        String[] params = {"facilityorderid", "approved"};
        Object[] paramsValues = {Long.parseLong(request.getParameter("facilityorderid")), Boolean.TRUE};
        String where = "WHERE facilityorderid=:facilityorderid AND approved=:approved";
        internalorderscomplete = genericClassService.fetchRecordCount(Facilityorderitems.class, where, params, paramsValues);
        if (internalorderscomplete == 0) 
        {
            results = "success";
        } else
        {
            results = "fail";
        }
        return results;
    }

    @RequestMapping(value = "/searchitemspausedorderitems.htm", method = RequestMethod.GET)
    public String searchitemspausedorderitems(Model model, HttpServletRequest request) {

        List<Map> itemsFound = new ArrayList<>();
        try {
            Set<Long> addeditems = new HashSet<>();
            List<Integer> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("itemsSet"), List.class);
            if (!item.isEmpty()) {
                for (Integer itm : item) {
                    addeditems.add(Long.parseLong(String.valueOf(itm)));
                }
            }

            String[] params4 = {"facilityorderid"};
            Object[] paramsValues4 = {Long.parseLong(request.getParameter("facilityorderid"))};
            String[] fields4 = {"itemid.itemid"};
            String where4 = "WHERE facilityorderid=:facilityorderid";
            List<Long> itemids = (List<Long>) genericClassService.fetchRecord(Facilityorderitems.class, fields4, where4, params4, paramsValues4);
            if (itemids != null) {
                for (Long items : itemids) {
                    addeditems.add(items);
                }
            }
            if ("all".equals(request.getParameter("supplies"))) {
                String[] params = {"value", "name", "isactive"};
                Object[] paramsValues = {request.getParameter("searchValue").trim().toLowerCase() + "%", "%" + request.getParameter("searchValue").trim().toLowerCase() + "%", Boolean.TRUE};
                String[] fields = {"itempackageid", "packagename", "categoryname"};
                String where = "WHERE isactive=:isactive AND (LOWER(packagename) LIKE :value OR LOWER(packagename) LIKE :name) ORDER BY packagename";
                List<Object[]> orderItems = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields, where, params, paramsValues);
                if (orderItems != null) {
                    Map<String, Object> itemsRow;
                    for (Object[] orderItem : orderItems) {
                        itemsRow = new HashMap<>();
                        if (addeditems.isEmpty() || !addeditems.contains(((BigInteger) orderItem[0]).longValue())) {
                            itemsRow.put("itemid", orderItem[0]);
                            itemsRow.put("packagename", orderItem[1]);
                            itemsRow.put("categoryname", orderItem[2]);
                            itemsFound.add(itemsRow);
                        }
                    }
                }
            }
            if ("sundries".equals(request.getParameter("supplies"))) {
                String[] params = {"value", "name", "isactive", "issupplies"};
                Object[] paramsValues = {request.getParameter("searchValue").trim().toLowerCase() + "%", "%" + request.getParameter("searchValue").trim().toLowerCase() + "%", Boolean.TRUE, Boolean.TRUE};
                String[] fields = {"itempackageid", "packagename", "categoryname"};
                String where = "WHERE isactive=:isactive AND issupplies=:issupplies AND (LOWER(packagename) LIKE :value OR LOWER(packagename) LIKE :name) ORDER BY packagename";
                List<Object[]> orderItems = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields, where, params, paramsValues);
                if (orderItems != null) {
                    Map<String, Object> itemsRow;
                    for (Object[] orderItem : orderItems) {
                        itemsRow = new HashMap<>();
                        if (addeditems.isEmpty() || !addeditems.contains(((BigInteger) orderItem[0]).longValue())) {
                            itemsRow.put("itemid", orderItem[0]);
                            itemsRow.put("packagename", orderItem[1]);
                            itemsRow.put("categoryname", orderItem[2]);
                            itemsFound.add(itemsRow);
                        }
                    }
                }
            }
            if ("medicines".equals(request.getParameter("supplies"))) {
                String[] params = {"value", "name", "isactive", "issupplies"};
                Object[] paramsValues = {request.getParameter("searchValue").trim().toLowerCase() + "%", "%" + request.getParameter("searchValue").trim().toLowerCase() + "%", Boolean.TRUE, Boolean.FALSE};
                String[] fields = {"itempackageid", "packagename", "categoryname"};
                String where = "WHERE isactive=:isactive AND issupplies=:issupplies AND (LOWER(packagename) LIKE :value OR LOWER(packagename) LIKE :name) ORDER BY packagename";
                List<Object[]> orderItems = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields, where, params, paramsValues);
                if (orderItems != null) {
                    Map<String, Object> itemsRow;
                    for (Object[] orderItem : orderItems) {
                        itemsRow = new HashMap<>();
                        if (addeditems.isEmpty() || !addeditems.contains(((BigInteger) orderItem[0]).longValue())) {
                            itemsRow.put("itemid", orderItem[0]);
                            itemsRow.put("packagename", orderItem[1]);
                            itemsRow.put("categoryname", orderItem[2]);
                            itemsFound.add(itemsRow);
                        }
                    }
                }
            }

        } catch (Exception e) {
            System.out.println(":::::::::::::::::::" + e);
        }

        model.addAttribute("itemsFound", itemsFound);
        model.addAttribute("searchValue", request.getParameter("searchValue"));
        return "inventoryAndSupplies/orders/placeOrders/internalOrder/viewOrManageOrders/incopleteAndCompleteOrders/forms/searchResults";
    }

    @RequestMapping(value = "/searchrecalleditems.htm", method = RequestMethod.GET)
    public String searchrecalleditems(Model model, HttpServletRequest request) {

        List<Map> itemsFound = new ArrayList<>();
        try {
            Set<Long> addeditems = new HashSet<>();
            List<Integer> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("itemsSet"), List.class);
            if (!item.isEmpty()) {
                for (Integer itm : item) {
                    addeditems.add(Long.parseLong(String.valueOf(itm)));
                }
            }

            String[] params4 = {"facilityorderid"};
            Object[] paramsValues4 = {Long.parseLong(request.getParameter("facilityorderid"))};
            String[] fields4 = {"itemid.itemid"};
            String where4 = "WHERE facilityorderid=:facilityorderid";
            List<Long> itemids = (List<Long>) genericClassService.fetchRecord(Facilityorderitems.class, fields4, where4, params4, paramsValues4);
            if (itemids != null) {
                for (Long items : itemids) {
                    addeditems.add(items);
                }
            }
            if ("all".equals(request.getParameter("supplies"))) {
                String[] params = {"value", "name", "isactive"};
                Object[] paramsValues = {request.getParameter("searchValue").trim().toLowerCase() + "%", "%" + request.getParameter("searchValue").trim().toLowerCase() + "%", Boolean.TRUE};
                String[] fields = {"itempackageid", "packagename", "categoryname"};
                String where = "WHERE isactive=:isactive AND (LOWER(packagename) LIKE :value OR LOWER(packagename) LIKE :name) ORDER BY packagename";
                List<Object[]> orderItems = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields, where, params, paramsValues);
                if (orderItems != null) {
                    Map<String, Object> itemsRow;
                    for (Object[] orderItem : orderItems) {
                        itemsRow = new HashMap<>();
                        if (addeditems.isEmpty() || !addeditems.contains(((BigInteger) orderItem[0]).longValue())) {
                            itemsRow.put("itemid", orderItem[0]);
                            itemsRow.put("packagename", orderItem[1]);
                            itemsRow.put("categoryname", orderItem[2]);
                            itemsFound.add(itemsRow);
                        }
                    }
                }
            }
            if ("sundries".equals(request.getParameter("supplies"))) {
                String[] params = {"value", "name", "isactive", "issupplies"};
                Object[] paramsValues = {request.getParameter("searchValue").trim().toLowerCase() + "%", "%" + request.getParameter("searchValue").trim().toLowerCase() + "%", Boolean.TRUE, Boolean.TRUE};
                String[] fields = {"itempackageid", "packagename", "categoryname"};
                String where = "WHERE isactive=:isactive AND issupplies=:issupplies AND (LOWER(packagename) LIKE :value OR LOWER(packagename) LIKE :name) ORDER BY packagename";
                List<Object[]> orderItems = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields, where, params, paramsValues);
                if (orderItems != null) {
                    Map<String, Object> itemsRow;
                    for (Object[] orderItem : orderItems) {
                        itemsRow = new HashMap<>();
                        if (addeditems.isEmpty() || !addeditems.contains(((BigInteger) orderItem[0]).longValue())) {
                            itemsRow.put("itemid", orderItem[0]);
                            itemsRow.put("packagename", orderItem[1]);
                            itemsRow.put("categoryname", orderItem[2]);
                            itemsFound.add(itemsRow);
                        }
                    }
                }
            }
            if ("medicines".equals(request.getParameter("supplies"))) {
                String[] params = {"value", "name", "isactive", "issupplies"};
                Object[] paramsValues = {request.getParameter("searchValue").trim().toLowerCase() + "%", "%" + request.getParameter("searchValue").trim().toLowerCase() + "%", Boolean.TRUE, Boolean.FALSE};
                String[] fields = {"itempackageid", "packagename", "categoryname"};
                String where = "WHERE isactive=:isactive AND issupplies=:issupplies AND (LOWER(packagename) LIKE :value OR LOWER(packagename) LIKE :name) ORDER BY packagename";
                List<Object[]> orderItems = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields, where, params, paramsValues);
                if (orderItems != null) {
                    Map<String, Object> itemsRow;
                    for (Object[] orderItem : orderItems) {
                        itemsRow = new HashMap<>();
                        if (addeditems.isEmpty() || !addeditems.contains(((BigInteger) orderItem[0]).longValue())) {
                            itemsRow.put("itemid", orderItem[0]);
                            itemsRow.put("packagename", orderItem[1]);
                            itemsRow.put("categoryname", orderItem[2]);
                            itemsFound.add(itemsRow);
                        }
                    }
                }
            }

        } catch (IOException | NumberFormatException e) {
            System.out.println(e);
        }

        model.addAttribute("itemsFound", itemsFound);
        model.addAttribute("searchValue", request.getParameter("searchValue"));
        return "inventoryAndSupplies/orders/placeOrders/internalOrder/viewOrManageOrders/incopleteAndCompleteOrders/forms/recalledSearchResults";
    }
    @RequestMapping(value="/unservicedorders", method=RequestMethod.GET)
    public ModelAndView unservicedOrdersServicingStore(HttpServletRequest request){
        final Map<String, Object> model = new HashMap<>();
        final List<Map<String, Object>> orders = new ArrayList<>();
        try {
//            final String targetDate = (request.getParameter("targetdate") != null) ? request.getParameter("targetdate") : formatter2.format(new Date());
            final Date targetDate = (request.getParameter("targetdate") != null) ? formatter2.parse(request.getParameter("targetdate")) : new Date();
            final long facilityUnitId = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString());
            String [] fields = { "unservicedorderid", "orderid", "dateadded", "addedby", "servicingunitid", "orderingunitid" };
            String [] params = { "dateadded", "servicingunitid" };
            Object [] paramsValues = { targetDate, facilityUnitId };
//            String where = "WHERE to_char(dateadded, 'yyyy-MM-dd')=:dateadded AND servicingunitid=:servicingunitid";
            String where = "WHERE DATE(dateadded)=:dateadded AND servicingunitid=:servicingunitid";
            List<Object[]> unservicedOrders = (List<Object[]>) genericClassService.fetchRecord(Unservicedorder.class, fields, where, params, paramsValues);
            if(unservicedOrders != null) {
                Map<String, Object> order;
                for(Object [] unservicedOrder : unservicedOrders){
                    order = new HashMap<>();
                    order.put("unservicedorderid", unservicedOrder[0]);
                    order.put("dateadded", formatter.format(unservicedOrder[2]));
                    fields = new String [] { "firstname", "lastname", "othernames" };
                    params = new String [] { "staffid" };
                    paramsValues = new Object [] { BigInteger.valueOf(Long.parseLong(unservicedOrder[3].toString())) };
                    where = "WHERE staffid=:staffid";
                    List<Object[]> staffs = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields, where, params, paramsValues);
                    if (staffs != null) {
                        Object[] staff = staffs.get(0);
                        if (staff[2] != null) {
                            order.put("addedby", staff[0] + " " + staff[1] + " " + staff[2]);
                        } else {
                            order.put("addedby", staff[0] + " " + staff[1]);
                        }
                    }
                    fields = new String [] { "facilityunitname" };
                    params = new String [] { "facilityunitid" };
                    paramsValues = new Object [] { Long.parseLong(unservicedOrder[4].toString()) };
                    where = "WHERE facilityunitid=:facilityunitid";
                    List<Object> facilityUnit = (List<Object>) genericClassService.fetchRecord(Facilityunit.class, fields, where, params, paramsValues);
                    if(facilityUnit != null){
                        order.put("servicingunit", facilityUnit.get(0));
                    }
                    
                    fields = new String [] { "facilityunitname" };
                    params = new String [] { "facilityunitid" };
                    paramsValues = new Object [] { Long.parseLong(unservicedOrder[5].toString()) };
                    where = "WHERE facilityunitid=:facilityunitid";
                    facilityUnit = (List<Object>) genericClassService.fetchRecord(Facilityunit.class, fields, where, params, paramsValues);
                    if(facilityUnit != null){
                        order.put("orderingunit", facilityUnit.get(0));
                    }
                    
                    fields = new String [] { "facilityorderno", "dateprepared", "dateneeded" };
                    params = new String [] { "facilityorderid" };
                    paramsValues = new Object [] { Long.parseLong(unservicedOrder[1].toString()) };
                    where = "WHERE facilityorderid=:facilityorderid";
                    List<Object[]> facilityOrder = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fields, where, params, paramsValues);
                    if(facilityOrder != null){
                        order.put("facilityorderno", facilityOrder.get(0)[0]);
                        order.put("dateprepared", format.format((Date) facilityOrder.get(0)[1]));
                        order.put("dateneeded", format.format((Date) facilityOrder.get(0)[2]));
                    }
                    orders.add(order);
                }
            }
            model.put("orders", orders);
            model.put("targetdate", targetDate);
            model.put("serverdate", formatterwithtime.format(serverDate));
        } catch(NumberFormatException e) {
            System.out.println(e);
        } catch(Exception e) {
            System.out.println(e);
        }
        return new ModelAndView("inventoryAndSupplies/orders/processOrder/views/unservicedOrders", model);
    }
    @RequestMapping(value="/unservicedorderitems", method=RequestMethod.GET)
    public ModelAndView unservicedOrderItemsServicingStore(HttpServletRequest request){
        final Map<String, Object> model = new HashMap<>();
        final List<Map<String, Object>> orderItems = new ArrayList<>();
        try {
            final long unservicedOrderId = Long.parseLong(request.getParameter("unservicedorderid"));
            String [] fields = { "unservicedorderitemid", "itemid", "addedby", "dateadded", "unservicedorderid" };
            String [] params = { "unservicedorderid" };
            Object [] paramsValues = { unservicedOrderId };
            String where = "WHERE unservicedorderid=:unservicedorderid";
            List<Object[]> unservicedOrderItems = (List<Object[]>) genericClassService.fetchRecord(Unservicedorderitem.class, fields, where, params, paramsValues);
            if(unservicedOrderItems != null){  
                Map<String, Object> orderItem;
                for(Object [] unservicedOrderItem : unservicedOrderItems){
                    orderItem = new HashMap<>();
                    orderItem.put("unservicedorderitemid", unservicedOrderItem[0]);
                    orderItem.put("itemid", unservicedOrderItem[1]);
                    fields = new String [] { "packagename" };
                    params = new String [] { "itempackageid" };
                    paramsValues = new Object [] { BigInteger.valueOf(Long.parseLong(unservicedOrderItem[1].toString())) };
                    where = "WHERE itempackageid=:itempackageid";
                    List<Object> itemNames = (List<Object>) genericClassService.fetchRecord(Itempackage.class, fields, where, params, paramsValues);
                    if(itemNames != null){
                        orderItem.put("itemname", itemNames.get(0));
                    }
                    orderItems.add(orderItem);
                }
            }
            model.put("orderitems", orderItems);
            model.put("serverdate", formatterwithtime.format(serverDate));
        } catch(NumberFormatException e) {
            System.out.println(e);
        } catch(Exception e) {
            System.out.println(e);
        }
        return new ModelAndView("inventoryAndSupplies/orders/processOrder/views/unservicedOrdersItems", model);
    }
    @RequestMapping(value="/unservicedordersorderingunit", method=RequestMethod.GET)
    public ModelAndView unservicedOrdersOderingUnit(HttpServletRequest request){
        final Map<String, Object> model = new HashMap<>();
        final List<Map<String, Object>> orders = new ArrayList<>();
        try {
//            final String targetDate = (request.getParameter("targetdate") != null) ? request.getParameter("targetdate") : formatter2.format(new Date());
            final Date targetDate = (request.getParameter("targetdate") != null) ? formatter2.parse(request.getParameter("targetdate")) : new Date();
            final long facilityUnitId = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString());
            String [] fields = { "unservicedorderid", "orderid", "dateadded", "addedby", "servicingunitid", "orderingunitid" };
            String [] params = { "dateadded", "orderingunitid" };
            Object [] paramsValues = { targetDate, facilityUnitId };
//            String where = "WHERE to_char(dateadded, 'yyyy-MM-dd')=:dateadded AND orderingunitid=:orderingunitid";
            String where = "WHERE DATE(dateadded)=:dateadded AND orderingunitid=:orderingunitid";
            List<Object[]> unservicedOrders = (List<Object[]>) genericClassService.fetchRecord(Unservicedorder.class, fields, where, params, paramsValues);
            if(unservicedOrders != null) {
                Map<String, Object> order;
                for(Object [] unservicedOrder : unservicedOrders){
                    order = new HashMap<>();
                    order.put("unservicedorderid", unservicedOrder[0]);
                    order.put("dateadded", formatter.format(unservicedOrder[2]));
                    fields = new String [] { "firstname", "lastname", "othernames" };
                    params = new String [] { "staffid" };
                    paramsValues = new Object [] { BigInteger.valueOf(Long.parseLong(unservicedOrder[3].toString())) };
                    where = "WHERE staffid=:staffid";
                    List<Object[]> staffs = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields, where, params, paramsValues);
                    if (staffs != null) {
                        Object[] staff = staffs.get(0);
                        if (staff[2] != null) {
                            order.put("addedby", staff[0] + " " + staff[1] + " " + staff[2]);
                        } else {
                            order.put("addedby", staff[0] + " " + staff[1]);
                        }
                    }
                    fields = new String [] { "facilityunitname" };
                    params = new String [] { "facilityunitid" };
                    paramsValues = new Object [] { Long.parseLong(unservicedOrder[4].toString()) };
                    where = "WHERE facilityunitid=:facilityunitid";
                    List<Object> facilityUnit = (List<Object>) genericClassService.fetchRecord(Facilityunit.class, fields, where, params, paramsValues);
                    if(facilityUnit != null){
                        order.put("servicingunit", facilityUnit.get(0));
                    }
                    
                    fields = new String [] { "facilityunitname" };
                    params = new String [] { "facilityunitid" };
                    paramsValues = new Object [] { Long.parseLong(unservicedOrder[5].toString()) };
                    where = "WHERE facilityunitid=:facilityunitid";
                    facilityUnit = (List<Object>) genericClassService.fetchRecord(Facilityunit.class, fields, where, params, paramsValues);
                    if(facilityUnit != null){
                        order.put("orderingunit", facilityUnit.get(0));
                    }
                    
                    fields = new String [] { "facilityorderno", "dateprepared", "dateneeded" };
                    params = new String [] { "facilityorderid" };
                    paramsValues = new Object [] { Long.parseLong(unservicedOrder[1].toString()) };
                    where = "WHERE facilityorderid=:facilityorderid";
                    List<Object[]> facilityOrder = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fields, where, params, paramsValues);
                    if(facilityOrder != null){
                        order.put("facilityorderno", facilityOrder.get(0)[0]);
                        order.put("dateprepared", format.format((Date) facilityOrder.get(0)[1]));
                        order.put("dateneeded", format.format((Date) facilityOrder.get(0)[2]));
                    }
                    orders.add(order);
                }
            }
            model.put("orders", orders);
            model.put("targetdate", targetDate);
            model.put("serverdate", formatterwithtime.format(serverDate));
        } catch(NumberFormatException e) {
            System.out.println(e);
        } catch(Exception e) {
            System.out.println(e);
        }
        return new ModelAndView("inventoryAndSupplies/orders/processOrder/views/unservicedOrders", model);
    }    
//    private Map getItemStockLevel(Integer facilityUnit, Integer itemid) {
//        long available = 0, stockReceived = 0;
//        Map<String, Object> stockLevels = new HashMap<>();
//
//        //Opening Stock.
//        String[] params = {"facilityunitid", "itemid"};
//        Object[] paramsValues = {facilityUnit, itemid};
//        String[] fields = {"r.logtype", "SUM(r.quantity)"};
//        String where = "WHERE r.facilityunitid=:facilityunitid AND r.itemid=:itemid GROUP BY r.logtype";
//        List<Object[]> stockLogs = (List<Object[]>) genericClassService.fetchRecordFunction(Facilitystocklog.class, fields, where, params, paramsValues, 0, 0);
//        if (stockLogs != null) {
//            for (Object[] opn : stockLogs) {
//                if ("IN".equalsIgnoreCase((String) opn[0])) {
//                    available = available + Long.parseLong(opn[1].toString());
//                } else {
//                    available = available - Long.parseLong(opn[1].toString());
//                }
//            }
//        }
//        stockLevels.put("opening", available);
//
//        //Received stock.
//        String[] params3 = {"facilityunitid", "itemid", "start", "end", "logtype"};
//        Object[] paramsValues3 = {facilityUnit, itemid, startDate, endDate, "IN"};
//        String[] fields3 = {"sum(r.quantity)"};
//        String where3 = "WHERE r.facilityunitid=:facilityunitid AND r.itemid=:itemid AND DATE(r.datelogged)>=:start AND DATE(r.datelogged)<=:end AND r.logtype=:logtype";
//        List<Object> received = (List) genericClassService.fetchRecordFunction(Facilitystocklog.class, fields3, where3, params3, paramsValues3, 0, 0);
//        if (received != null) {
//            if (received.get(0) != null) {
//                stockReceived = Long.parseLong(received.get(0).toString());
//                available = available + stockReceived;
//            }
//        }
//        stockLevels.put("received", stockReceived);
//
//        //Issued stock.
//        String[] params4 = {"facilityunitid", "itemid", "start", "end", "out", "disp", "disc", "exp"};
//        Object[] paramsValues4 = {facilityUnit, itemid, startDate, endDate, "OUT", "DISP", "DISC", "EXP"};
//        String[] fields4 = {"sum(r.quantity)"};
//        String where4 = "WHERE r.facilityunitid=:facilityunitid AND r.itemid=:itemid AND DATE(r.datelogged)>=:start AND DATE(r.datelogged)<=:end AND (r.logtype=:out OR r.logtype=:disp OR r.logtype=:disc OR r.logtype=:exp)";
//        List<Object> stockOut = (List) genericClassService.fetchRecordFunction(Facilitystocklog.class, fields4, where4, params4, paramsValues4, 0, 0);
//        if (stockOut != null) {
//            if (stockOut.get(0) != null) {
//                available = available - Long.parseLong(stockOut.get(0).toString());
//            }
//        }
//        stockLevels.put("available", available);
//
//        return stockLevels;
//    }
}
