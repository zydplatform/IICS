/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.domain.Facilityunit;
import com.iics.domain.Searchstaff;
import com.iics.patient.Patientvisit;
import com.iics.patient.Prescription;
import com.iics.patient.Searchpatient;
import com.iics.service.GenericClassService;
import com.iics.store.Bayrow;
import com.iics.store.Bayrowcell;
import com.iics.store.Cellitems;
import com.iics.store.Donationconsumption;
import com.iics.store.Donorprogram;
import com.iics.store.Facilityorder;
import com.iics.store.Facilityorderitems;
import com.iics.store.Facilitystocklog;
import com.iics.store.Facilityunitstock;
import com.iics.store.Item;
import com.iics.store.Itemadministeringtype;
import com.iics.store.Itemcategories;
import com.iics.store.Itemcategorisation;
import com.iics.store.Itemcategory;
import com.iics.store.Itemclassification;
import com.iics.store.Itemform;
import com.iics.store.Itempackage;
import com.iics.store.Medicalitem;
import com.iics.store.Shelflog;
import com.iics.store.Shelfstock;
import com.iics.store.Stock;
import com.iics.store.Stocklog;
import com.iics.store.Unitstoragezones;
import com.iics.store.Zone;
import com.iics.store.Zonebay;
import com.iics.utils.ShelfActivityLog;
import com.iics.utils.StockActivityLog;
import java.io.IOException;
import java.math.BigInteger;
import java.text.ParseException;
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
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author IICS
 */
@Controller
@RequestMapping("/store")
public class Store {

    @Autowired
    GenericClassService genericClassService;
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat formatter2 = new SimpleDateFormat("dd-MM-yyyy");
    private SimpleDateFormat formatterwithtime = new SimpleDateFormat("yyyy-MM-dd hh:mm aa");
    private Date serverDate = new Date();


    @RequestMapping(value = "/inventoryAndSupplies", method = RequestMethod.GET)
    public String controlPanelMenu(Model model) {
        return "inventoryAndSupplies/inventoryAndSupplieslMenu";
    }
   
    @RequestMapping(value = "/inventoryPane", method = RequestMethod.GET)
    public String inventoryPane(HttpServletRequest request, Model model) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            List<Map> storageZones = new ArrayList<>();
            List<Map> allClassifications = new ArrayList<>();

            Integer facilityUnit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
            String[] params = {"facilityunitid"};
            Object[] paramsValues = {facilityUnit};
            String[] fields = {"zoneid", "zonelabel"};
            String where = "WHERE facilityunitid=:facilityunitid ORDER BY zonelabel";
            List<Object[]> zones = (List<Object[]>) genericClassService.fetchRecord(Zone.class, fields, where, params, paramsValues);
            if (zones != null) {
                Map<String, Object> zone;
                for (Object[] object : zones) {
                    zone = new HashMap<>();
                    zone.put("id", object[0]);
                    zone.put("name", object[1]);
                    storageZones.add(zone);
                }
            }

            String[] params2 = {"isactive"};
            Object[] paramsValues2 = {Boolean.TRUE};
            String[] fields2 = {"itemclassificationid", "classificationname"};
            String where2 = "WHERE isactive=:isactive ORDER BY classificationname";
            List<Object[]> classficationList = (List<Object[]>) genericClassService.fetchRecord(Itemclassification.class, fields2, where2, params2, paramsValues2);
            if (classficationList != null) {
                Map<String, Object> classification;
                for (Object[] object : classficationList) {
                    classification = new HashMap<>();
                    classification.put("id", object[0]);
                    classification.put("name", object[1]);
                    allClassifications.add(classification);
                }
            }

            int readyUnitOrders = 0;
            String[] paramsReadyUnitOrders = {"originstore", "status", "ordertype", "taken"};
            Object[] paramsValuesReadyUnitOrders = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), "DELIVERED", "INTERNAL", false};
            String whereReadyUnitOrders = "WHERE originstore=:originstore AND status=:status AND ordertype=:ordertype AND taken=:taken";
            readyUnitOrders = genericClassService.fetchRecordCount(Facilityorder.class, whereReadyUnitOrders, paramsReadyUnitOrders, paramsValuesReadyUnitOrders);

            int readyUnitDonations = 0;
            String[] paramsReadyUnitDonations = {"consumerunit","isdelivered"};
            Object[] paramsValuesReadyUnitDonations = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))),Boolean.FALSE};
            String whereReadyUnitDonations = "WHERE consumerunit=:consumerunit AND isdelivered=:isdelivered";
            readyUnitDonations = genericClassService.fetchRecordCount(Donationconsumption.class, whereReadyUnitDonations, paramsReadyUnitDonations, paramsValuesReadyUnitDonations);

            
            model.addAttribute("readyUnitOrdersCount", readyUnitOrders);
            model.addAttribute("readyUnitDonationsCount", readyUnitDonations);
            model.addAttribute("storageZones", storageZones);
            model.addAttribute("allClassifications", allClassifications);
            model.addAttribute("serverdate", formatterwithtime.format(serverDate));
            return "inventoryAndSupplies/inventory/views/inventoryPane";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchUnitClassificationStock", method = RequestMethod.GET)
    public String fetchUnitClassificationStock(HttpServletRequest request, Model model, @ModelAttribute("classid") Integer classid) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null && request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            Integer facilityUnit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
            List<Map> stockItems = new ArrayList<>();
            String[] params;
            Object[] paramsValues;
            String where;
            if (classid == 0) {
                params = new String[]{"facilityunitid"};
                paramsValues = new Object[]{facilityUnit};
                where = "WHERE facilityunitid=:facilityunitid AND shelvedstock<quantityrecieved ORDER BY daystoexpire,packagename";
            } else {
                params = new String[]{"facilityunitid", "classid"};
                paramsValues = new Object[]{facilityUnit, classid};
                where = "WHERE facilityunitid=:facilityunitid AND itemclassificationid=:classid AND shelvedstock<quantityrecieved ORDER BY daystoexpire,packagename";
            }
            String[] fields = {"stockid", "packagename", "batchnumber", "daystoexpire", "quantityrecieved", "shelvedstock", "expirydate"};
            List<Object[]> stockList = (List<Object[]>) genericClassService.fetchRecord(Facilityunitstock.class, fields, where, params, paramsValues);
            if (stockList != null) {
                Map<String, Object> item;
                for (Object[] object : stockList) {
                    item = new HashMap<>();
                    item.put("id", object[0]);
                    item.put("name", object[1]);
                    if (object[2] != null) {
                        item.put("batch", object[2]);
                    } else {
                        item.put("batch", "-");
                    }
                    if (object[3] != null) {
                        item.put("expiry", (int) object[3]);
                    } else {
                        item.put("expiry", 0.5);
                    }
                    if (object[6] != null) {
                        item.put("expirydate", new SimpleDateFormat("dd-MM-yyyy").format((Date) object[6]));
                    } else {
                        item.put("expirydate", "No Expiry Date");
                    }
                    item.put("unshelved", String.format("%,d", (Integer) object[4] - (Integer) object[5]));
                    stockItems.add(item);
                }
            }
            model.addAttribute("stockItems", stockItems);
            return "inventoryAndSupplies/inventory/views/entry/capturedStock";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/searchItem", method = RequestMethod.GET)
    public String searchItem(HttpServletRequest request, Model model, @ModelAttribute("name") String searchValue) {
        List<Map> itemsFound = new ArrayList<>();
        String[] params = {"value", "name", "isactive"};
        Object[] paramsValues = {searchValue.trim().toLowerCase() + "%", searchValue.trim().toLowerCase() + "%", Boolean.TRUE};
        String[] fields = {"itempackageid", "packagename", "packagequantity", "packname", "measure"};
        String where = "WHERE isactive=:isactive AND (LOWER(packagename) LIKE :name OR LOWER(itemcode) LIKE :value) ORDER BY packagename";
        List<Object[]> classficationList = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields, where, params, paramsValues);
        if (classficationList != null) {
            Map<String, Object> classification;
            for (Object[] object : classficationList) {
                classification = new HashMap<>();
                classification.put("id", object[0]);
                classification.put("name", object[1]);
                classification.put("packqty", object[2]);
                classification.put("packname", object[3]);
                classification.put("measure", object[4]);
                itemsFound.add(classification);
            }
        }
        model.addAttribute("name", searchValue);
        model.addAttribute("items", itemsFound);
        return "inventoryAndSupplies/inventory/views/entry/itemSearchResults";
    }

    @RequestMapping(value = "/checkBatchNumber", method = RequestMethod.GET)
    public @ResponseBody
    String checkBatchNumber(HttpServletRequest request, Model model, @ModelAttribute("batchNo") String batchNo) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            String res = "";
            Integer facilityUnit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
            String[] params = {"facilityunitid", "batchnumber"};
            Object[] paramsValues = {facilityUnit, batchNo.trim().toLowerCase()};
            String[] fields = {"stockid", "expirydate", "quantityrecieved"};
            String where = "WHERE LOWER(batchnumber)=:batchnumber AND facilityunitid=:facilityunitid";
            List<Object[]> batchStock = (List<Object[]>) genericClassService.fetchRecord(Stock.class, fields, where, params, paramsValues);
            if (batchStock != null) {
                Map<String, Object> batch = new HashMap<>();
                batch.put("id", batchStock.get(0)[0]);
                batch.put("expiry", batchStock.get(0)[1]);
                batch.put("qty", batchStock.get(0)[2]);
                try {
                    res = new ObjectMapper().writeValueAsString(batch);
                } catch (JsonProcessingException ex) {
                    System.out.println(ex);
                }
            }
            return res;
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/captureStock", method = RequestMethod.POST)
    public @ResponseBody
    String captureStock(HttpServletRequest request, Model model, @ModelAttribute("items") String items) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null && request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            try {
                Long staffid = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
                Integer facilityUnitid = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
                SimpleDateFormat date = new SimpleDateFormat("dd-MM-yyyy");
                List<Map> itemList = new ObjectMapper().readValue(items, List.class);
                for (Map item : itemList) {
                    String[] params;
                    Object[] paramsValues;
                    String where;
                    if (!"".equals(item.get("expiry").toString()) && !"".equals(item.get("batch").toString())) {
                        params = new String[]{"facilityunitid", "itemid", "batchnumber", "expirydate"};
                        paramsValues = new Object[]{facilityUnitid, Long.parseLong((String) item.get("itemid")), (item.get("batch").toString()).trim().toLowerCase(), date.parse(item.get("expiry").toString())};
                        where = "WHERE itemid=:itemid AND LOWER(batchnumber)=:batchnumber AND expirydate=:expirydate AND facilityunitid=:facilityunitid";
                    } else {
                        if ("".equals(item.get("batch").toString()) && "".equals(item.get("expiry").toString())) {
                            params = new String[]{"facilityunitid", "itemid"};
                            paramsValues = new Object[]{facilityUnitid, Long.parseLong((String) item.get("itemid")), (item.get("batch").toString()).trim().toLowerCase()};
                            where = "WHERE itemid=:itemid AND LOWER(batchnumber)=:batchnumber AND facilityunitid=:facilityunitid";
                        } else if ("".equals(item.get("expiry").toString())) {
                            params = new String[]{"facilityunitid", "itemid", "batchnumber"};
                            paramsValues = new Object[]{facilityUnitid, Long.parseLong((String) item.get("itemid")), (item.get("batch").toString()).trim().toLowerCase()};
                            where = "WHERE itemid=:itemid AND LOWER(batchnumber)=:batchnumber AND facilityunitid=:facilityunitid";
                        } else {
                            params = new String[]{"facilityunitid", "itemid", "expirydate"};
                            paramsValues = new Object[]{facilityUnitid, Long.parseLong((String) item.get("itemid")), date.parse(item.get("expiry").toString())};
                            where = "WHERE itemid=:itemid AND expirydate=:expirydate AND facilityunitid=:facilityunitid";
                        }
                    }
                    String[] fields = {"stockid", "quantityrecieved"};
                    List<Object[]> batchStock = (List<Object[]>) genericClassService.fetchRecord(Stock.class, fields, where, params, paramsValues);
                    if (batchStock != null) {
                        Integer availableQuantity = (Integer) batchStock.get(0)[1];
                        if (!"".equals(item.get("expiry").toString())) {
                            String[] columns = {"quantityrecieved", "expirydate", "expires"};
                            Object[] columnValues = {(Integer) item.get("qty") + availableQuantity, date.parse((String) item.get("expiry")), true};
                            String pk = "stockid";
                            Object pkValue = batchStock.get(0)[0];
                            genericClassService.updateRecordSQLSchemaStyle(Stock.class, columns, columnValues, pk, pkValue, "store");
//                            new StockActivityLog(genericClassService, ((Long) pkValue).intValue(), staffid.intValue(), "IN", (Integer) item.get("qty"), null, null, null).start();                            
                            Stocklog log = new Stocklog();
                            log.setStockid(new Stock(Long.parseLong(pkValue.toString())));
                            log.setStaffid(BigInteger.valueOf(staffid));
                            log.setLogtype("IN");
                            log.setQuantity(Integer.parseInt(item.get("qty").toString()));
                            log.setDatelogged(new Date());
                            log.setReferencetype(null);
                            log.setReference(null);
                            log.setReferencenumber(null);
                            genericClassService.saveOrUpdateRecordLoadObject(log);
                            //
                        } else {
                            String[] columns = {"quantityrecieved", "expires"};
                            Object[] columnValues = {(Integer) item.get("qty") + availableQuantity, false};
                            String pk = "stockid";
                            Object pkValue = batchStock.get(0)[0];
                            genericClassService.updateRecordSQLSchemaStyle(Stock.class, columns, columnValues, pk, pkValue, "store");
//                            new StockActivityLog(genericClassService, ((Long) pkValue).intValue(), staffid.intValue(), "IN", (Integer) item.get("qty"), null, null, null).start();
                            Stocklog log = new Stocklog();
                            log.setStockid(new Stock(Long.parseLong(pkValue.toString())));
                            log.setStaffid(BigInteger.valueOf(staffid));
                            log.setLogtype("IN");
                            log.setQuantity(Integer.parseInt(item.get("qty").toString()));
                            log.setDatelogged(new Date());
                            log.setReferencetype(null);
                            log.setReference(null);
                            log.setReferencenumber(null);
                            genericClassService.saveOrUpdateRecordLoadObject(log);
                            //
                        }
                    } else {
                        Stock itemStock = new Stock();
                        itemStock.setItemid(new Item(Long.parseLong((String) item.get("itemid"))));
                        itemStock.setQuantityrecieved((Integer) item.get("qty"));
                        itemStock.setDaterecieved(new Date());
                        itemStock.setDateadded(new Date());
                        itemStock.setRecievedby(staffid);
                        itemStock.setFacilityunitid(BigInteger.valueOf(facilityUnitid));
                        itemStock.setSuppliertype("INIT");
                        itemStock.setShelvedstock(0);
                        itemStock.setStockissued(0);
                        itemStock.setSupplierid(BigInteger.valueOf(staffid));
                        if (((String) item.get("batch")).length() >= 1) {
                            itemStock.setBatchnumber((String) item.get("batch"));
                        }
                        if (!"".equals(item.get("expiry").toString())) {
                            itemStock.setExpires(true);
                            itemStock.setExpirydate(date.parse((String) item.get("expiry")));
                        } else {
                            itemStock.setExpires(false);
                        }
                        genericClassService.saveOrUpdateRecordLoadObject(itemStock);
//                        new StockActivityLog(genericClassService, itemStock.getStockid().intValue(), staffid.intValue(), "IN", itemStock.getQuantityrecieved(), null, null, null).start();
                        Stocklog log = new Stocklog();
                        log.setStockid(new Stock(itemStock.getStockid()));
                        log.setStaffid(BigInteger.valueOf(staffid));
                        log.setLogtype("IN");
                        log.setQuantity(Integer.parseInt(item.get("qty").toString()));
                        log.setDatelogged(new Date());
                        log.setReferencetype(null);
                        log.setReference(null);
                        log.setReferencenumber(null);
                        genericClassService.saveOrUpdateRecordLoadObject(log);
                        //
                    }
                }
            } catch (IOException | ParseException ex) {
                System.out.println(ex);
                return "Failed";
            }
            return "Saved";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchStoreZones", method = RequestMethod.POST)
    public @ResponseBody
    String fetchStoreZones(HttpServletRequest request, Model model, @ModelAttribute("isolated") boolean isolated) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            String res = "[]";
            List<Map> storageZones = new ArrayList<>();

            Integer facilityUnit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
            String[] params = {"facilityunitid", "isolated"};
            Object[] paramsValues = {facilityUnit, isolated};
            String[] fields = {"zoneid", "zonelabel"};
            String where = "WHERE facilityunitid=:facilityunitid AND isolated=:isolated ORDER BY zonelabel GROUP BY zoneid,zonelabel";
            List<Object[]> zones = (List<Object[]>) genericClassService.fetchRecord(Unitstoragezones.class, fields, where, params, paramsValues);
            if (zones != null) {
                Map<String, Object> zone;
                for (Object[] object : zones) {
                    zone = new HashMap<>();
                    zone.put("id", object[0]);
                    zone.put("name", object[1]);
                    storageZones.add(zone);
                }
            }
            try {
                res = new ObjectMapper().writeValueAsString(storageZones);
            } catch (JsonProcessingException ex) {
                System.out.println(ex);
            }
            return res;
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchStoreBays", method = RequestMethod.POST)
    public @ResponseBody
    String fetchStoreBays(HttpServletRequest request, Model model, @ModelAttribute("zoneid") Integer zoneid, @ModelAttribute("isolated") boolean isolated) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            String res = "";
            List<Map> zoneBays = new ArrayList<>();
            String[] params = {"zoneid", "isolated"};
            Object[] paramsValues = {zoneid, isolated};
            String[] fields = {"zonebayid", "baylabel"};
            String where = "WHERE zoneid=:zoneid AND isolated=:isolated ORDER BY baylabel GROUP BY zonebayid,baylabel";
            List<Object[]> bays = (List<Object[]>) genericClassService.fetchRecord(Unitstoragezones.class, fields, where, params, paramsValues);
            if (bays != null) {
                Map<String, Object> bay;
                for (Object[] obj : bays) {
                    bay = new HashMap<>();
                    bay.put("id", obj[0]);
                    bay.put("name", obj[1]);
                    zoneBays.add(bay);
                }
            }
            try {
                res = new ObjectMapper().writeValueAsString(zoneBays);
            } catch (JsonProcessingException ex) {
                System.out.println(ex);
            }
            return res;
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchBayrows", method = RequestMethod.POST)
    public @ResponseBody
    String fetchBayrows(HttpServletRequest request, Model model, @ModelAttribute("bayid") Integer bayid, @ModelAttribute("isolated") boolean isolated) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            String res = "";
            List<Map> bayRows = new ArrayList<>();
            String[] params = {"zonebayid", "isolated"};
            Object[] paramsValues = {bayid, isolated};
            String[] fields = {"bayrowid", "rowlabel"};
            String where = "WHERE zonebayid=:zonebayid AND isolated=:isolated ORDER BY rowlabel GROUP BY bayrowid,rowlabel";
            List<Object[]> rows = (List<Object[]>) genericClassService.fetchRecord(Unitstoragezones.class, fields, where, params, paramsValues);
            if (rows != null) {
                Map<String, Object> row;
                for (Object[] obj : rows) {
                    row = new HashMap<>();
                    row.put("id", obj[0]);
                    row.put("name", obj[1]);
                    bayRows.add(row);
                }
            }
            try {
                res = new ObjectMapper().writeValueAsString(bayRows);
            } catch (JsonProcessingException ex) {
                System.out.println(ex);
            }
            return res;
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchRowCells", method = RequestMethod.POST)
    public @ResponseBody
    String fetchRowCells(HttpServletRequest request, Model model, @ModelAttribute("rowid") Integer rowid, @ModelAttribute("isolated") boolean isolated) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            String res = "";
            List<Map> rowCells = new ArrayList<>();
            String[] params = {"bayrowid", "isolated"};
            Object[] paramsValues = {rowid, isolated};
            String[] fields = {"bayrowcellid", "celllabel"};
            String where = "WHERE bayrowid=:bayrowid AND isolated=:isolated ORDER BY celllabel GROUP BY bayrowcellid,celllabel";
            List<Object[]> cells = (List<Object[]>) genericClassService.fetchRecord(Unitstoragezones.class, fields, where, params, paramsValues);
            if (cells != null) {
                Map<String, Object> cell;
                for (Object[] obj : cells) {
                    cell = new HashMap<>();
                    cell.put("id", obj[0]);
                    cell.put("name", obj[1]);
                    rowCells.add(cell);
                }
            }
            try {
                res = new ObjectMapper().writeValueAsString(rowCells);
            } catch (JsonProcessingException ex) {
                System.out.println(ex);
            }
            return res;
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/saveShelfStock", method = RequestMethod.GET)
    public @ResponseBody
    String saveShelfStock(HttpServletRequest request, Model model, @ModelAttribute("shelves") String shelves) throws JsonProcessingException {
        Map<String, Object> response = new HashMap<>();
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            Long satffId = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
            try {
                List<Map> shelfItems = new ObjectMapper().readValue(shelves, List.class);
                final boolean initialRequest = (request.getParameter("initialrequest") != null) ? Boolean.valueOf(request.getParameter("initialrequest")) : Boolean.FALSE;
                Shelfstock cellItem;
                    for (Map shelfItem : shelfItems) {
                        Integer unShelvedQuantity = 0;
                        synchronized(unShelvedQuantity){
                            String [] field = { "quantityrecieved", "shelvedstock" };
                            String [] params = { "stockid" };
                            Object [] paramValues = { Long.parseLong(shelfItem.get("stockid").toString()) };
                            String where = "WHERE stockid=:stockid";
                            List<Object []> unShelvedStockQuantities = (List<Object []>) genericClassService.fetchRecord(Stock.class, field, where, params, paramValues);
                            if(unShelvedStockQuantities != null){
                                Object [] unShelvedStockQuantity  = unShelvedStockQuantities.get(0);
                                unShelvedQuantity = (Integer.parseInt(unShelvedStockQuantity[0].toString()) - Integer.parseInt(unShelvedStockQuantity[1].toString()));
    //                            int newQuantity =  unShelvedQuantity - Integer.parseInt(shelfItem.get("qty").toString());
                                if(((unShelvedQuantity < Integer.parseInt(shelfItem.get("qty").toString())) && (unShelvedQuantity > 0 && initialRequest == Boolean.TRUE))){
                                    response.put("response", String.format("The available quantity is: %s do you want to shelve this quantity?", unShelvedQuantity));
                                    response.put("newquantity", unShelvedQuantity);
                                    response.put("status", "insufficient");
                                    return new ObjectMapper().writeValueAsString(response);
                                } else if(unShelvedQuantity == 0) {
                                    response.put("response", "This Item has been fully shelved");
                                    response.put("newquantity", unShelvedQuantity);
                                    response.put("status", "shelved");
                                    return new ObjectMapper().writeValueAsString(response);
                                } else if(((unShelvedQuantity < Integer.parseInt(shelfItem.get("qty").toString())) && (unShelvedQuantity > 0 && initialRequest == Boolean.FALSE))){
                                    shelfItem.put("qty", unShelvedQuantity);
                                }
                            }
                            String[] paramsCheckitem = {"stockid", "cellid"};
                            Object[] paramsValuesCheckitem = {((Integer) shelfItem.get("stockid")).longValue(), (Integer) shelfItem.get("cell")};
                            String[] fieldsCheckitem = {"shelfstockid", "quantityshelved"};
    //                        String[] fieldsCheckitem = { "shelfstockid", "quantityshelved", "inuse" };
                            String whereCheckitem = "WHERE stockid=:stockid AND cellid=:cellid";
                            List<Object[]> check = (List<Object[]>) genericClassService.fetchRecord(Shelfstock.class, fieldsCheckitem, whereCheckitem, paramsCheckitem, paramsValuesCheckitem);
                            if (check == null) {
                                cellItem = new Shelfstock();
                                cellItem.setIsstocktaken(Boolean.FALSE);
                                cellItem.setUpdatedby(satffId.intValue());
                                cellItem.setDateupdated(new Date());
                                cellItem.setQuantityshelved((Integer) shelfItem.get("qty"));
                                cellItem.setStockid(new Stock(((Integer) shelfItem.get("stockid")).longValue()));
                                cellItem.setCellid(new Bayrowcell((Integer) shelfItem.get("cell")));
                                //
    //                            cellItem.setInuse(true);
                                //
                                cellItem = (Shelfstock) genericClassService.saveOrUpdateRecordLoadObject(cellItem);
                                if (cellItem.getShelfstockid() != null) {
                                    params = new String[] {"stockid"};
                                    Object[] paramsValues = {((Integer) shelfItem.get("stockid")).longValue()};
                                    String[] fields = {"shelvedstock"};
                                    where = "WHERE stockid=:stockid";
                                    List<Integer> shelved = (List<Integer>) genericClassService.fetchRecord(Stock.class, fields, where, params, paramsValues);
                                    if (shelved != null) {
                                        String[] columns = {"shelvedstock"};
                                        Object[] columnValues = {shelved.get(0) + (Integer) shelfItem.get("qty")};
                                        String pk = "stockid";
                                        Object pkValue = ((Integer) shelfItem.get("stockid")).longValue();
                                        genericClassService.updateRecordSQLSchemaStyle(Stock.class, columns, columnValues, pk, pkValue, "store");
                                    }
                                    //Capture cell log
    //                                new ShelfActivityLog(genericClassService, (Integer) shelfItem.get("cell"), (Integer) shelfItem.get("stockid"), satffId.intValue(), "IN", (Integer) shelfItem.get("qty")).start();
                                    Shelflog log = new Shelflog();
                                    log.setCellid(new Bayrowcell((Integer) shelfItem.get("cell")));
                                    log.setStockid(new Stock(Long.parseLong(shelfItem.get("stockid").toString())));
                                    log.setStaffid(BigInteger.valueOf(satffId));
                                    log.setLogtype("IN");
                                    log.setQuantity(Integer.parseInt(shelfItem.get("qty").toString()));
                                    log.setDatelogged(new Date());
                                    genericClassService.saveOrUpdateRecordLoadObject(log);
                                }
                            } else {
                                Object[] record = check.get(0);
                                    String[] columnsUpdatecell = {"quantityshelved"};
                                    Object[] columnValuesUpdatecell = {(Integer) record[1] + (Integer) shelfItem.get("qty")};
                                    String pkUpdatecell = "shelfstockid";
                                    Object pkValueUpdatecell = (Long) record[0];
                                    int result = genericClassService.updateRecordSQLSchemaStyle(Shelfstock.class, columnsUpdatecell, columnValuesUpdatecell, pkUpdatecell, pkValueUpdatecell, "store");
                                    if (result != 0) {
                                        params = new String[] {"stockid"};
                                        Object[] paramsValues = {((Integer) shelfItem.get("stockid")).longValue()};
                                        String[] fields = {"shelvedstock"};
                                        where = "WHERE stockid=:stockid";
                                        List<Integer> shelved = (List<Integer>) genericClassService.fetchRecord(Stock.class, fields, where, params, paramsValues);
                                        if (shelved != null) {
                                            String [] columns = new String [] {"shelvedstock"};
                                            Object [] columnValues = new Object [] {shelved.get(0) + (Integer) shelfItem.get("qty")};
                                            String pk = "stockid";
                                            Object pkValue = ((Integer) shelfItem.get("stockid")).longValue();
                                            genericClassService.updateRecordSQLSchemaStyle(Stock.class, columns, columnValues, pk, pkValue, "store");
                                        }
                                        //Capture cell log
    //                                    new ShelfActivityLog(genericClassService, (Integer) shelfItem.get("cell"), (Integer) shelfItem.get("stockid"), satffId.intValue(), "IN", (Integer) shelfItem.get("qty")).start();
                                        Shelflog log = new Shelflog();
                                        log.setCellid(new Bayrowcell((Integer) shelfItem.get("cell")));
                                        log.setStockid(new Stock(Long.parseLong(shelfItem.get("stockid").toString())));
                                        log.setStaffid(BigInteger.valueOf(satffId));
                                        log.setLogtype("IN");
                                        log.setQuantity(Integer.parseInt(shelfItem.get("qty").toString()));
                                        log.setDatelogged(new Date());
                                        genericClassService.saveOrUpdateRecordLoadObject(log);
                                    }
    //                            }
                            }
    //                    String[] paramsCheckitem = {"stockid", "cellid"};
    //                    Object[] paramsValuesCheckitem = {((Integer) shelfItem.get("stockid")).longValue(), (Integer) shelfItem.get("cell")};
    //                    String[] fieldsCheckitem = {"shelfstockid", "quantityshelved"};
    //                    String whereCheckitem = "WHERE stockid=:stockid AND cellid=:cellid";
    //                    List<Object[]> check = (List<Object[]>) genericClassService.fetchRecord(Shelfstock.class, fieldsCheckitem, whereCheckitem, paramsCheckitem, paramsValuesCheckitem);
    //                    if (check == null) {
    //                        cellItem = new Shelfstock();
    //                        cellItem.setIsstocktaken(Boolean.FALSE);
    //                        cellItem.setUpdatedby(satffId.intValue());
    //                        cellItem.setDateupdated(new Date());
    //                        cellItem.setQuantityshelved((Integer) shelfItem.get("qty"));
    //                        cellItem.setStockid(new Stock(((Integer) shelfItem.get("stockid")).longValue()));
    //                        cellItem.setCellid(new Bayrowcell((Integer) shelfItem.get("cell")));
    //                        cellItem = (Shelfstock) genericClassService.saveOrUpdateRecordLoadObject(cellItem);
    //                        if (cellItem.getShelfstockid() != null) {
    //                            String[] params = {"stockid"};
    //                            Object[] paramsValues = {((Integer) shelfItem.get("stockid")).longValue()};
    //                            String[] fields = {"shelvedstock"};
    //                            String where = "WHERE stockid=:stockid";
    //                            List<Integer> shelved = (List<Integer>) genericClassService.fetchRecord(Stock.class, fields, where, params, paramsValues);
    //                            if (shelved != null) {
    //                                String[] columns = {"shelvedstock"};
    //                                Object[] columnValues = {shelved.get(0) + (Integer) shelfItem.get("qty")};
    //                                String pk = "stockid";
    //                                Object pkValue = ((Integer) shelfItem.get("stockid")).longValue();
    //                                genericClassService.updateRecordSQLSchemaStyle(Stock.class, columns, columnValues, pk, pkValue, "store");
    //                            }
    //                            //Capture cell log
    //                            new ShelfActivityLog(genericClassService, (Integer) shelfItem.get("cell"), (Integer) shelfItem.get("stockid"), satffId.intValue(), "IN", (Integer) shelfItem.get("qty")).start();
    //                        }
    //                    } else {
    //                        Object[] record = check.get(0);
    //                        String[] columnsUpdatecell = {"quantityshelved"};
    //                        Object[] columnValuesUpdatecell = {(Integer) record[1] + (Integer) shelfItem.get("qty")};
    //                        String pkUpdatecell = "shelfstockid";
    //                        Object pkValueUpdatecell = (Long) record[0];
    //                        int result = genericClassService.updateRecordSQLSchemaStyle(Shelfstock.class, columnsUpdatecell, columnValuesUpdatecell, pkUpdatecell, pkValueUpdatecell, "store");
    //                        if (result != 0) {
    //                            String[] params = {"stockid"};
    //                            Object[] paramsValues = {((Integer) shelfItem.get("stockid")).longValue()};
    //                            String[] fields = {"shelvedstock"};
    //                            String where = "WHERE stockid=:stockid";
    //                            List<Integer> shelved = (List<Integer>) genericClassService.fetchRecord(Stock.class, fields, where, params, paramsValues);
    //                            if (shelved != null) {
    //                                String[] columns = {"shelvedstock"};
    //                                Object[] columnValues = {shelved.get(0) + (Integer) shelfItem.get("qty")};
    //                                String pk = "stockid";
    //                                Object pkValue = ((Integer) shelfItem.get("stockid")).longValue();
    //                                genericClassService.updateRecordSQLSchemaStyle(Stock.class, columns, columnValues, pk, pkValue, "store");
    //                            }
    //                            //Capture cell log
    //                            new ShelfActivityLog(genericClassService, (Integer) shelfItem.get("cell"), (Integer) shelfItem.get("stockid"), satffId.intValue(), "IN", (Integer) shelfItem.get("qty")).start();
    //                        }
    //                    }
                    }
                }
                response.put("status", "saved");
                response.put("data","");
                response.put("response","");
                return new ObjectMapper().writeValueAsString(response);
//                return "saved";
            } catch (IOException ex) {
                System.out.println(ex);
            }
            response.put("status", "failed");
            response.put("data","");
            response.put("response","");
            return new ObjectMapper().writeValueAsString(response);
//            return "failed";
        } else {
            response.put("status", "refresh");
            response.put("data","");
            response.put("response","");
            return new ObjectMapper().writeValueAsString(response);
//            return "refresh";
        }
    }

    @RequestMapping(value = "/initShelfPane", method = RequestMethod.POST)
    public String initShelfPane(HttpServletRequest request, Model model, @ModelAttribute("zoneid") Integer zoneid) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            List<Map> zoneBays = new ArrayList<>();
            String[] params = {"zoneid"};
            Object[] paramsValues = {zoneid};
            String[] fields = {"zonebayid", "baylabel"};
            String where = "WHERE zoneid=:zoneid ORDER BY baylabel";
            List<Object[]> bays = (List<Object[]>) genericClassService.fetchRecord(Zonebay.class, fields, where, params, paramsValues);
            if (bays != null) {
                Map<String, Object> bay;
                for (Object[] obj : bays) {
                    bay = new HashMap<>();
                    bay.put("id", obj[0]);
                    bay.put("name", obj[1]);
                    List<Map> bayRows = new ArrayList<>();
                    String[] params2 = {"zonebayid"};
                    Object[] paramsValues2 = {obj[0]};
                    String[] fields2 = {"bayrowid", "rowlabel"};
                    String where2 = "WHERE zonebayid=:zonebayid ORDER BY rowlabel";
                    List<Object[]> rows = (List<Object[]>) genericClassService.fetchRecord(Bayrow.class, fields2, where2, params2, paramsValues2);
                    if (rows != null) {
                        Map<String, Object> row;
                        for (Object[] rw : rows) {
                            row = new HashMap<>();
                            row.put("id", rw[0]);
                            row.put("name", rw[1]);
                            String[] params3 = {"bayrowid"};
                            Object[] paramsValues3 = {rw[0]};
                            String where3 = "WHERE bayrowid=:bayrowid";
                            int cellCount = genericClassService.fetchRecordCount(Bayrowcell.class, where3, params3, paramsValues3);
                            row.put("count", cellCount);
                            bayRows.add(row);
                        }
                        bay.put("rows", bayRows);
                    }
                    zoneBays.add(bay);
                }
            }
            model.addAttribute("bays", zoneBays);
            return "inventoryAndSupplies/inventory/views/shelves/shelfPane";
        }
        return "refresh";
    }

    @RequestMapping(value = "/fetchRowCellContent", method = RequestMethod.POST)
    public String fetchRowCellContent(HttpServletRequest request, Model model, @ModelAttribute("rowid") Integer rowid, @ModelAttribute("rowname") String rowName) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            List<Map> rowCells = new ArrayList<>();
            String[] params = {"bayrowid"};
            Object[] paramsValues = {rowid};
            String[] fields = {"bayrowcellid", "celllabel"};
            String where = "WHERE bayrowid=:bayrowid ORDER BY celllabel";
            List<Object[]> cells = (List<Object[]>) genericClassService.fetchRecord(Bayrowcell.class, fields, where, params, paramsValues);
            if (cells != null) {
                Map<String, Object> cell;
                for (Object[] obj : cells) {
                    cell = new HashMap<>();
                    cell.put("id", obj[0]);
                    cell.put("name", obj[1]);

                    String[] params2 = {"bayrowcellid"};
                    Object[] paramsValues2 = {obj[0]};
                    String[] fields2 = {"r.itemid", "SUM(r.quantityshelved)"};
                    String where2 = "WHERE bayrowcellid=:bayrowcellid AND quantityshelved>0 GROUP BY r.itemid";
                    List<Object[]> items = (List<Object[]>) genericClassService.fetchRecordFunction(Cellitems.class, fields2, where2, params2, paramsValues2, 0, 0);
                    if (items != null) {
                        cell.put("count", String.format("%,d", items.size()));
                    } else {
                        cell.put("count", String.format("%,d", 0));
                    }
                    rowCells.add(cell);
                }
            }
            model.addAttribute("search", false);
            model.addAttribute("cells", rowCells);
            model.addAttribute("rowName", rowName);
            return "inventoryAndSupplies/inventory/views/shelves/rowCells";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchCellItems", method = RequestMethod.POST)
    public String fetchCellItems(HttpServletRequest request, Model model, @ModelAttribute("cellid") Integer cellid) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            List<Map> stockItems = new ArrayList<>();
            String[] params = {"bayrowcellid"};
            Object[] paramsValues = {cellid};
            String[] fields = {"shelfstockid", "packagename", "batchnumber", "daystoexpire", "quantityshelved", "expirydate", "stockid"};
            String where = "WHERE bayrowcellid=:bayrowcellid AND quantityshelved > 0 ORDER BY daystoexpire,packagename";
            List<Object[]> classficationList = (List<Object[]>) genericClassService.fetchRecord(Cellitems.class, fields, where, params, paramsValues);
            if (classficationList != null) {
                Map<String, Object> classification;
                for (Object[] object : classficationList) {
                    classification = new HashMap<>();
                    classification.put("id", object[0]);
                    classification.put("name", object[1]);
                    classification.put("batch", object[2]);
                    if (object[3] != null) {
                        classification.put("expiry", (int) object[3]);
                    } else {
                        classification.put("expiry", 0.5);
                    }
                    if (object[5] != null) {
                        classification.put("expirydate", new SimpleDateFormat("dd-MM-yyyy").format((Date) object[5]));
                    } else {
                        classification.put("expirydate", "No Expiry Date");
                    }
                    classification.put("qty", String.format("%,d", (Integer) object[4]));
                    classification.put("stockid", object[6]);
                    stockItems.add(classification);
                }
            }
            model.addAttribute("stockItems", stockItems);
            return "inventoryAndSupplies/inventory/views/shelves/shelfItems";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/transferItem", method = RequestMethod.POST)
    public @ResponseBody
    String transferItem(HttpServletRequest request, Model model, @ModelAttribute("id") Integer shelfStockId, @ModelAttribute("stock") Integer stockId, @ModelAttribute("cell") Integer newCell, @ModelAttribute("curcell") Integer curCell, @ModelAttribute("qty") Integer newQty, @ModelAttribute("curqty") Integer curQty) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            Long satffId = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
            String[] params = {"cellid", "stockid"};
            Object[] paramsValues = {newCell, stockId};
            String[] fields = {"shelfstockid", "quantityshelved"};
            String where = "WHERE cellid=:cellid AND stockid=:stockid";
            List<Object[]> existingStock = (List<Object[]>) genericClassService.fetchRecord(Shelfstock.class, fields, where, params, paramsValues);
            if (existingStock != null) {
                Shelfstock cellItem = new Shelfstock((Long) existingStock.get(0)[0]);
                cellItem.setIsstocktaken(Boolean.FALSE);
                cellItem.setUpdatedby(satffId.intValue());
                cellItem.setDateupdated(new Date());
                cellItem.setQuantityshelved((Integer) existingStock.get(0)[1] + newQty);
                cellItem.setStockid(new Stock(stockId.longValue()));
                cellItem.setCellid(new Bayrowcell(newCell));
                cellItem = (Shelfstock) genericClassService.saveOrUpdateRecordLoadObject(cellItem);
                if (cellItem.getShelfstockid() != null) {
                    cellItem = new Shelfstock(shelfStockId.longValue());
                    cellItem.setIsstocktaken(Boolean.FALSE);
                    cellItem.setUpdatedby(satffId.intValue());
                    cellItem.setDateupdated(new Date());
                    cellItem.setQuantityshelved(curQty - newQty);
                    cellItem.setStockid(new Stock(stockId.longValue()));
                    cellItem.setCellid(new Bayrowcell(curCell));
                    genericClassService.saveOrUpdateRecordLoadObject(cellItem);
                    //Capture cell log
                    new ShelfActivityLog(genericClassService, curCell, stockId, satffId.intValue(), "TRA", newQty).start();
                    new ShelfActivityLog(genericClassService, newCell, stockId, satffId.intValue(), "IN", newQty).start();
                }
            } else {
                Shelfstock cellItem = new Shelfstock();
                cellItem.setIsstocktaken(Boolean.FALSE);
                cellItem.setUpdatedby(satffId.intValue());
                cellItem.setDateupdated(new Date());
                cellItem.setQuantityshelved(newQty);
                cellItem.setStockid(new Stock(stockId.longValue()));
                cellItem.setCellid(new Bayrowcell(newCell));
                cellItem = (Shelfstock) genericClassService.saveOrUpdateRecordLoadObject(cellItem);
                if (cellItem.getShelfstockid() != null) {
                    cellItem = new Shelfstock(shelfStockId.longValue());
                    cellItem.setIsstocktaken(Boolean.FALSE);
                    cellItem.setUpdatedby(satffId.intValue());
                    cellItem.setDateupdated(new Date());
                    cellItem.setQuantityshelved(curQty - newQty);
                    cellItem.setStockid(new Stock(stockId.longValue()));
                    cellItem.setCellid(new Bayrowcell(curCell));
                    genericClassService.saveOrUpdateRecordLoadObject(cellItem);
                    //Capture cell log
                    new ShelfActivityLog(genericClassService, curCell, stockId, satffId.intValue(), "TRA", newQty).start();
                    new ShelfActivityLog(genericClassService, newCell, stockId, satffId.intValue(), "IN", newQty).start();
                }
            }
            return "saved";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/searchCells", method = RequestMethod.POST)
    public String searchCells(HttpServletRequest request, Model model, @ModelAttribute("name") String searchValue, @ModelAttribute("zoneid") Integer zoneid) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            List<Map> rowCells = new ArrayList<>();
            String[] params = {"zoneid", "searchValue"};
            Object[] paramsValues = {zoneid, searchValue.trim().toLowerCase() + "%"};
            String[] fields = {"bayrowcellid", "celllabel"};
            String where = "WHERE zoneid=:zoneid AND quantityshelved > 0 AND (LOWER(packagename) LIKE :searchValue OR LOWER(categoryname) LIKE :searchValue OR LOWER(classificationname) LIKE :searchValue OR LOWER(batchnumber) LIKE :searchValue OR LOWER(celllabel) LIKE :searchValue) ORDER BY celllabel";
            List<Object[]> cells = (List<Object[]>) genericClassService.fetchRecord(Cellitems.class, fields, where, params, paramsValues);
            if (cells != null) {
                Map<String, Object> cell;
                for (Object[] obj : cells) {
                    cell = new HashMap<>();
                    cell.put("id", obj[0]);
                    cell.put("name", obj[1]);

                    String[] params2 = {"bayrowcellid"};
                    Object[] paramsValues2 = {obj[0]};
                    String[] fields2 = {"r.itemid", "SUM(r.quantityshelved)"};
                    String where2 = "WHERE bayrowcellid=:bayrowcellid AND quantityshelved>0 GROUP BY r.itemid";
                    List<Object[]> items = (List<Object[]>) genericClassService.fetchRecordFunction(Cellitems.class, fields2, where2, params2, paramsValues2, 0, 0);
                    if (items != null) {
                        cell.put("count", String.format("%,d", items.size()));
                    } else {
                        cell.put("count", String.format("%,d", 0));
                    }
                    rowCells.add(cell);
                }
            }
            model.addAttribute("search", true);
            model.addAttribute("cells", rowCells);
            model.addAttribute("rowName", searchValue);
            return "inventoryAndSupplies/inventory/views/shelves/rowCells";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/initItemPane", method = RequestMethod.GET)
    public String initItemPane(Model model) {
        List<Map> itemForms = new ArrayList<>();
        List<Map> adminTypes = new ArrayList<>();
        List<Map> classifications = new ArrayList<>();
        String[] params = {};
        Object[] paramsValues = {};
        String[] fields = {"itemclassificationid", "classificationdescription", "classificationname", "isactive"};
        String where = "ORDER BY classificationname";
        List<Object[]> classficationList = (List<Object[]>) genericClassService.fetchRecord(Itemclassification.class, fields, where, params, paramsValues);
        if (classficationList != null) {
            Map<String, Object> classification;
            for (Object[] object : classficationList) {
                classification = new HashMap<>();
                classification.put("id", object[0]);
                classification.put("desc", object[1]);
                classification.put("name", object[2]);
                if (object[3] != null) {
                    if ((boolean) object[3]) {
                        classification.put("status", "checked");
                    } else {
                        classification.put("status", "");
                    }
                } else {
                    classification.put("status", "");
                }
                classifications.add(classification);
            }
        }

        String[] params2 = {};
        Object[] paramsValues2 = {};
        String[] fields2 = {"itemformid", "formname", "formdescription"};
        String where2 = "ORDER BY formname";
        List<Object[]> forms = (List<Object[]>) genericClassService.fetchRecord(Itemform.class, fields2, where2, params2, paramsValues2);
        if (forms != null) {
            Map<String, Object> form;
            for (Object[] object : forms) {
                form = new HashMap<>();
                form.put("id", object[0]);
                form.put("name", object[1]);
                form.put("desc", object[2]);
                itemForms.add(form);
            }
        }

        String[] params3 = {};
        Object[] paramsValues3 = {};
        String[] fields3 = {"administeringtypeid", "typename"};
        String where3 = "ORDER BY typename";
        List<Object[]> types = (List<Object[]>) genericClassService.fetchRecord(Itemadministeringtype.class, fields3, where3, params3, paramsValues3);
        if (types != null) {
            Map<String, Object> type;
            for (Object[] object : types) {
                type = new HashMap<>();
                type.put("id", object[0]);
                type.put("name", object[1]);
                adminTypes.add(type);
            }
        }

        model.addAttribute("forms", itemForms);
        model.addAttribute("types", adminTypes);
        model.addAttribute("classifications", classifications);
        return "controlPanel/universalPanel/itemLists/views/itemsPane";
    }

    @RequestMapping(value = "/saveclassification", method = RequestMethod.POST)
    public @ResponseBody
    String saveClassification(HttpServletRequest request, Model model, @ModelAttribute("name") String classification, @ModelAttribute("desc") String description) {
        Itemclassification itemClass = new Itemclassification();
        itemClass.setClassificationdescription(description);
        itemClass.setClassificationname(classification);
        itemClass = (Itemclassification) genericClassService.saveOrUpdateRecordLoadObject(itemClass);
        if (itemClass.getItemclassificationid() != null) {
            return itemClass.getItemclassificationid().toString();
        } else {
            return "";
        }
    }

    @RequestMapping(value = "/fetchClassificationCategories", method = RequestMethod.POST)
    public String fetchClassification(Model model, @ModelAttribute("classification") Integer classificationid) {
        List<Map> categories = new ArrayList<>();
        String[] params = {"itemclassificationid"};
        Object[] paramsValues = {classificationid};
        String[] fields = {"itemcategoryid", "categoryname", "categorydescription", "isactive"};
        String where = "WHERE itemclassificationid=:itemclassificationid ORDER BY categoryname";
        List<Object[]> categoryList = (List<Object[]>) genericClassService.fetchRecord(Itemcategory.class, fields, where, params, paramsValues);
        if (categoryList != null) {
            Map<String, Object> category;
            for (Object[] object : categoryList) {
                category = new HashMap<>();
                category.put("id", object[0]);
                category.put("name", object[1]);
                category.put("desc", object[2]);
                if (object[3] != null) {
                    if ((boolean) object[3]) {
                        category.put("status", "checked");
                    } else {
                        category.put("status", "");
                    }
                } else {
                    category.put("status", "");
                }
                categories.add(category);
            }
        }
        model.addAttribute("categories", categories);
        return "controlPanel/universalPanel/itemLists/views/categoryTable";
    }

    @RequestMapping(value = "/saveitemadmintype", method = RequestMethod.POST)
    public @ResponseBody
    String saveItemadmintype(HttpServletRequest request, Model model, @ModelAttribute("name") String adminType) {
        Itemadministeringtype itemAdmintype = new Itemadministeringtype();
        itemAdmintype.setTypename(adminType);
        itemAdmintype = (Itemadministeringtype) genericClassService.saveOrUpdateRecordLoadObject(itemAdmintype);
        if (itemAdmintype.getAdministeringtypeid() != null) {
            return itemAdmintype.getAdministeringtypeid().toString();
        } else {
            return "";
        }
    }

    @RequestMapping(value = "/saveClassificationCategory", method = RequestMethod.POST)
    public @ResponseBody
    String saveClassificationCategory(HttpServletRequest request, Model model, @ModelAttribute("classid") Integer classid, @ModelAttribute("name") String category, @ModelAttribute("desc") String description) {
        Itemcategory itemCategory = new Itemcategory();
        itemCategory.setCategorydescription(description);
        itemCategory.setCategoryname(category);
        itemCategory.setItemclassificationid(new Itemclassification(classid.longValue()));
        itemCategory = (Itemcategory) genericClassService.saveOrUpdateRecordLoadObject(itemCategory);
        if (itemCategory.getItemcategoryid() != null) {
            return itemCategory.getItemcategoryid().toString();
        } else {
            return "";
        }
    }

    @RequestMapping(value = "/saveitemform", method = RequestMethod.POST)
    public @ResponseBody
    String saveItemform(HttpServletRequest request, Model model, @ModelAttribute("name") String formName, @ModelAttribute("desc") String description) {
        Itemform itemform = new Itemform();
        itemform.setFormdescription(description);
        itemform.setFormname(formName);
        itemform = (Itemform) genericClassService.saveOrUpdateRecordLoadObject(itemform);
        if (itemform.getItemformid() != null) {
            return itemform.getItemformid().toString();
        } else {
            return "";
        }
    }

    @RequestMapping(value = "/fetchClassificationCategories_json", method = RequestMethod.POST)
    public @ResponseBody
    String fetchClassificationCategoriesjson(Model model, @ModelAttribute("classification") Integer classificationid) {
        List<Map> categories = new ArrayList<>();
        String[] params = {"itemclassificationid"};
        Object[] paramsValues = {classificationid};
        String[] fields = {"itemcategoryid", "categoryname", "categorydescription", "isactive"};
        String where = "WHERE itemclassificationid=:itemclassificationid ORDER BY categoryname";
        List<Object[]> categoryList = (List<Object[]>) genericClassService.fetchRecord(Itemcategory.class, fields, where, params, paramsValues);
        if (categoryList != null) {
            Map<String, Object> category;
            for (Object[] object : categoryList) {
                category = new HashMap<>();
                category.put("id", object[0]);
                category.put("name", object[1]);
                category.put("desc", object[2]);
                if (object[3] != null) {
                    if ((boolean) object[3]) {
                        category.put("status", "checked");
                    } else {
                        category.put("status", "");
                    }
                } else {
                    category.put("status", "");
                }
                categories.add(category);
            }
        }
        String response = "";
        try {
            response = new ObjectMapper().writeValueAsString(categories);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }
        return response;
    }

    @RequestMapping(value = "/fetchCategoryItems", method = RequestMethod.POST)
    public String fetchCategoryItems(Model model, @ModelAttribute("category") Integer category) {
        List<Map> categoryItems = new ArrayList<>();
        String[] params = {"itemcategoryid"};
        Object[] paramsValues = {category};
        String[] fields = {"itemid", "itemcode", "fullname", "packsize", "itemformid", "isactive"};
        String where = "WHERE itemcategoryid=:itemcategoryid ORDER BY fullname";
        List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Itemcategories.class, fields, where, params, paramsValues);
        if (items != null) {
            Map<String, Object> item;
            for (Object[] object : items) {
                item = new HashMap<>();
                item.put("id", object[0]);
                item.put("code", object[1]);
                item.put("name", object[2]);
                item.put("pack", object[3]);
                if (object[5] != null) {
                    if ((boolean) object[5]) {
                        item.put("status", "checked");
                    } else {
                        item.put("status", "");
                    }
                } else {
                    item.put("status", "");
                }
                if (object[4] != null) {
                    String[] params2 = {"itemformid"};
                    Object[] paramsValues2 = {(Integer) object[4]};
                    String[] fields2 = {"formname"};
                    String where2 = "WHERE itemformid=:itemformid";
                    List<String> forms = (List<String>) genericClassService.fetchRecord(Itemform.class, fields2, where2, params2, paramsValues2);
                    if (forms != null) {
                        item.put("form", forms.get(0));
                    } else {
                        item.put("form", "N/A");
                    }
                } else {
                    item.put("form", "N/A");
                }
                categoryItems.add(item);
            }
        }
        model.addAttribute("items", categoryItems);
        return "controlPanel/universalPanel/itemLists/views/itemsTable";
    }

    @RequestMapping(value = "/fetchItemList", method = RequestMethod.POST)
    public String fetchItemList(Model model) {
        List<Map> categoryItems = new ArrayList<>();
        String[] params = {};
        Object[] paramsValues = {};
        String[] fields = {"itemid", "itemcode", "fullname", "packsize", "formname", "isactive", "typename", "itemformid", "itemadministeringtypeid", "itemcategoryid", "itemclassificationid"};
        String where = "ORDER BY fullname";
        List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Itemcategories.class, fields, where, params, paramsValues);
        if (items != null) {
            Map<String, Object> item;
            for (Object[] object : items) {
                item = new HashMap<>();
                item.put("id", object[0]);
                item.put("code", object[1]);
                item.put("name", object[2]);
                item.put("pack", object[3]);
                item.put("form", (String) object[4]);
                if (object[5] != null) {
                    if ((boolean) object[5]) {
                        item.put("status", "checked");
                    } else {
                        item.put("status", "");
                    }
                } else {
                    item.put("status", "");
                }
                item.put("type", object[6]);
                item.put("formid", object[7]);
                item.put("typeid", object[8]);
                item.put("catid", object[9]);
                item.put("classid", object[10]);
                categoryItems.add(item);
            }
        }
        model.addAttribute("items", categoryItems);
        return "controlPanel/universalPanel/itemLists/views/itemsTable";
    }

    @RequestMapping(value = "/fetchFilteredItemList", method = RequestMethod.POST)
    public String fetchFilteredItemList(Model model, @ModelAttribute("cat") Integer categoryid, @ModelAttribute("cla") Integer classificationid) {
        List<Map> categoryItems = new ArrayList<>();
        String[] params;
        Object[] paramsValues;
        String where;
        if (categoryid == 0) {
            params = new String[]{"itemclassificationid"};
            paramsValues = new Object[]{classificationid};
            where = "WHERE itemclassificationid=:itemclassificationid ORDER BY fullname";
        } else {
            params = new String[]{"categoryid"};
            paramsValues = new Object[]{categoryid};
            where = "WHERE itemcategoryid=:categoryid ORDER BY fullname";
        }
        String[] fields = {"itemid", "itemcode", "fullname", "packsize", "formname", "isactive", "typename", "itemformid", "itemadministeringtypeid", "itemcategoryid", "itemclassificationid"};
        List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Itemcategories.class, fields, where, params, paramsValues);
        if (items != null) {
            Map<String, Object> item;
            for (Object[] object : items) {
                item = new HashMap<>();
                item.put("id", object[0]);
                item.put("code", object[1]);
                item.put("name", object[2]);
                item.put("pack", object[3]);
                item.put("form", (String) object[4]);
                if (object[5] != null) {
                    if ((boolean) object[5]) {
                        item.put("status", "checked");
                    } else {
                        item.put("status", "");
                    }
                } else {
                    item.put("status", "");
                }
                item.put("type", object[6]);
                item.put("formid", object[7]);
                item.put("typeid", object[8]);
                item.put("catid", object[9]);
                item.put("classid", object[10]);
                categoryItems.add(item);
            }
        }
        model.addAttribute("items", categoryItems);
        return "controlPanel/universalPanel/itemLists/views/itemsTable";
    }

    @RequestMapping(value = "/savenewitems", method = RequestMethod.POST)
    public @ResponseBody
    String saveNewItems(Model model, @ModelAttribute("ids") String ids, @ModelAttribute("items") String items) {

        try {
            List codeList = new ObjectMapper().readValue(ids, List.class);
            List<Map> itemList = new ObjectMapper().readValue(items, List.class);
            for (Object itemCode : codeList) {
                for (Map item : itemList) {
                    if (itemCode.equals(item.get("code"))) {
                        Medicalitem newItem = new Medicalitem();
                        newItem.setGenericname((String) item.get("name"));
                        newItem.setIsactive(true);
                        newItem.setItemadministeringtypeid(new Itemadministeringtype((Integer) item.get("type")));
                        newItem.setItemformid(new Itemform((Integer) item.get("form")));
                        newItem.setItemcode((String) item.get("code"));
                        newItem = (Medicalitem) genericClassService.saveOrUpdateRecordLoadObject(newItem);
                        if (newItem.getMedicalitemid() != null) {
                            Itemcategorisation itemCat = new Itemcategorisation();
                            itemCat.setItemid(newItem);
                            itemCat.setItemcategoryid(new Itemcategory(((Integer) item.get("cat")).longValue()));
                            genericClassService.saveOrUpdateRecordLoadObject(itemCat);
                        }
                    }
                }
            }
        } catch (IOException ex) {
            return "Failed";
        }
        return "Saved";
    }

    @RequestMapping(value = "/activateClassification", method = RequestMethod.POST)
    public @ResponseBody
    String activateClassification(HttpServletRequest request, Model model, @ModelAttribute("id") Integer itemClassificationid, @ModelAttribute("value") boolean value) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            String[] columns = {"isactive"};
            Object[] columnValues = {value};
            String pk = "itemclassificationid";
            Object pkValue = itemClassificationid.longValue();
            int result = genericClassService.updateRecordSQLSchemaStyle(Itemclassification.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                return "updated";
            } else {
                return "fail";
            }
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/activateCategory", method = RequestMethod.POST)
    public @ResponseBody
    String activateCategory(HttpServletRequest request, Model model, @ModelAttribute("id") Integer itemCategoryid, @ModelAttribute("value") boolean value) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            String[] columns = {"isactive"};
            Object[] columnValues = {value};
            String pk = "itemcategoryid";
            Object pkValue = itemCategoryid.longValue();
            int result = genericClassService.updateRecordSQLSchemaStyle(Itemcategory.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                return "updated";
            } else {
                return "fail";
            }
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/activateItem", method = RequestMethod.POST)
    public @ResponseBody
    String activateItem(HttpServletRequest request, Model model, @ModelAttribute("id") Integer itemid, @ModelAttribute("value") boolean value) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            String[] columns = {"isactive"};
            Object[] columnValues = {value};
            String pk = "itemid";
            Object pkValue = itemid.longValue();
            int result = genericClassService.updateRecordSQLSchemaStyle(Item.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                return "updated";
            } else {
                return "fail";
            }
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/updateClassification", method = RequestMethod.POST)
    public @ResponseBody
    String updateClassification(HttpServletRequest request, Model model, @ModelAttribute("id") Integer itemclassificationid, @ModelAttribute("name") String name, @ModelAttribute("desc") String desc) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            String[] columns = {"classificationname", "classificationdescription"};
            Object[] columnValues = {name, desc};
            String pk = "itemclassificationid";
            Object pkValue = itemclassificationid.longValue();
            int result = genericClassService.updateRecordSQLSchemaStyle(Itemclassification.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                return "updated";
            } else {
                return "fail";
            }
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchStock", method = RequestMethod.POST)
    public String fetchStock(HttpServletRequest request, Model model, @ModelAttribute("start") String start, @ModelAttribute("end") String end) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            try {
                Integer facilityUnit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
                Date startDate = formatter.parse(start);
                Date endDate = formatter.parse(end);
                List<Map> unitItems = new ArrayList<>();

                String[] params = {"facilityunitid"};
                Object[] paramsValues = {facilityUnit};
                String where = "WHERE facilityunitid=:facilityunitid GROUP BY itemid,packagename ORDER BY packagename";
                String[] fields = {"itemid", "packagename"};
                List<Object[]> classficationList = (List<Object[]>) genericClassService.fetchRecord(Facilityunitstock.class, fields, where, params, paramsValues);
                if (classficationList != null) {
                    Map<String, Object> item;
                    for (Object[] object : classficationList) {
                        item = new HashMap<>();
                        Map<String, Object> stockLevel = getItemStockLevel(facilityUnit, Integer.parseInt(object[0].toString()), startDate, endDate);
                        item.put("itemid", object[0]);
                        item.put("name", object[1]);
                        item.put("opening", stockLevel.get("opening"));
                        item.put("received", String.format("%,d", Long.parseLong(stockLevel.get("received").toString())));
                        item.put("currstock", String.format("%,d", Long.parseLong(stockLevel.get("available").toString())));

                        unitItems.add(item);
                    }
                }
                model.addAttribute("items", unitItems);
                return "inventoryAndSupplies/inventory/views/stock/stockItems";
            } catch (ParseException ex) {
                return "inventoryAndSupplies/inventory/views/stock/dateError";
            }
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchStockItemBatches", method = RequestMethod.POST)
    public String fetchStockItemBatches(HttpServletRequest request, Model model, @ModelAttribute("itemid") Integer itemid, @ModelAttribute("start") String start, @ModelAttribute("end") String end) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            try {
                long opening = 0, receivedStock = 0, issued = 0, expired = 0, discrepancy = 0, usable = 0;
                Integer facilityUnit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
                Date startDate = formatter.parse(start);
                Date endDate = formatter.parse(end);

                List<Map> unitItems = new ArrayList<>();
                String[] params = {"facilityunitid", "itemid", "end"};
                Object[] paramsValues = {facilityUnit, itemid, endDate};
                String[] fields = {"r.stockid", "r.batchnumber", "r.daystoexpire", "r.expirydate"};
                String where = "WHERE r.facilityunitid=:facilityunitid AND r.itemid=:itemid AND DATE(r.datelogged)<=:end GROUP BY r.stockid,r.batchnumber,r.daystoexpire,r.expirydate";
                List<Object[]> batches = (List<Object[]>) genericClassService.fetchRecordFunction(Facilitystocklog.class, fields, where, params, paramsValues, 0, 0);
                if (batches != null) {
                    for (Object[] btc : batches) {
                        Map<String, Object> item = getBatchStockLevel(Integer.parseInt(btc[0].toString()), startDate, endDate);
                        if ((long) item.get("opening") > 0 || (long) item.get("received") > 0) {
                            issued += (long) item.get("issued");
                            receivedStock += (long) item.get("received");
                            expired += (long) item.get("expired");
                            discrepancy += (long) item.get("discrepancies");
                            opening += (long) item.get("opening");
                            if (btc[1] != null) {
                                item.put("batch", btc[1]);
                            } else {
                                item.put("batch", "-");
                            }
                            if (btc[2] != null) {
                                item.put("expiry", btc[2]);
                                if ((Integer) btc[2] < 0 && item.get("available") != null) {
                                    expired += (long) item.get("available");
                                }
                                item.put("expirydate", formatter2.format((Date) btc[3]));
                            } else {
                                item.put("expiry", 0.5);
                            }
                            item.put("batch", btc[1]);

                            String[] params2 = {"stockid", "end", "logtype"};
                            Object[] paramsValues2 = {btc[0], endDate, "IN"};
                            String[] fields2 = {"to_char(r.datelogged,'DD-MM-YYYY')", "SUM(r.quantity)"};
                            String where2 = "WHERE r.stockid=:stockid AND DATE(r.datelogged)<=:end AND r.logtype=:logtype GROUP BY to_char(r.datelogged,'DD-MM-YYYY') ORDER BY to_char(r.datelogged,'DD-MM-YYYY')";
                            List<Object[]> rounds = (List<Object[]>) genericClassService.fetchRecordFunction(Facilitystocklog.class, fields2, where2, params2, paramsValues2, 0, 0);
                            if (rounds != null) {
                                Map<String, Object> round;
                                List<Map> deliveryRounds = new ArrayList<>();
                                for (Object[] rnd : rounds) {
                                    round = new HashMap<>();
                                    round.put("date", rnd[0]);
                                    round.put("qty", String.format("%,d", rnd[1]));
                                    deliveryRounds.add(round);
                                }
                                item.put("rounds", deliveryRounds.size());
                                item.put("deliveries", deliveryRounds);
                            }
                            //
                            long avail = 0L, bookedSum = 0L;                            
                            params = new String[] {"itemid", "facilityunitid"};
                            paramsValues = new Object[] {itemid, facilityUnit};
                            fields = new String[] {"r.celllabel", "r.batchnumber", "SUM(r.quantityshelved)"};
                            where = "WHERE r.itemid=:itemid AND r.facilityunitid=:facilityunitid AND r.quantityshelved>0 GROUP BY r.celllabel,r.batchnumber ORDER BY SUM(r.quantityshelved)";
                            List<Object[]> itemLocations = (List<Object[]>) genericClassService.fetchRecordFunction(Cellitems.class, fields, where, params, paramsValues, 0, 0);
                            if (itemLocations != null) {
                                for (Object[] object : itemLocations) { 
                                    if(object[1].toString().equalsIgnoreCase(btc[1].toString())){
                                        avail += Long.parseLong(object[2].toString());
                                    }
                                }
                            }
                            item.replace("available", avail);
                            
                            //FETCH BOOKED OFF QUANTITIES
                            params = new String[] {"destinationstore", "status", "ordertype"};
                            paramsValues = new Object[] {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), "PICKED", "INTERNAL"};
                            fields = new String[] {"facilityorderid", "ordertype"};
                            where = "WHERE destinationstore=:destinationstore AND status=:status AND ordertype=:ordertype AND DATE_PART('YEAR', dateprepared) = DATE_PART('YEAR', NOW())";
                            List<Object[]> bookedQuantities = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fields, where, params, paramsValues);
                            if (bookedQuantities != null) {
                                for (Object[] bookedQuantity : bookedQuantities) {
                                    params = new String [] {"itemid", "facilityorderid", "serviced"};
                                    paramsValues = new Object [] {itemid, Long.parseLong(bookedQuantity[0].toString()), Boolean.TRUE};
                                    fields = new String [] {"facilityorderitemsid", "qtysanctioned"};
                                    where = "WHERE itemid=:itemid AND facilityorderid=:facilityorderid AND serviced=:serviced AND DATE_PART('YEAR', dateapproved) = DATE_PART('YEAR', NOW())";
                                    List<Object[]> bookedItemQuantities = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fields, where, params, paramsValues);
                                    if (bookedItemQuantities != null) {
                                        for (Object[] bookedItemQuantity : bookedItemQuantities) {
                                            bookedSum += Integer.parseInt(bookedItemQuantity[1].toString());
                                        }
                                    }
                                }
                            }     
                            item.put("booked", bookedSum);
                            //
                            unitItems.add(item);
                        }
                    }
                }
                usable = (opening + receivedStock) - (expired + discrepancy + issued);
                model.addAttribute("id", itemid);
                model.addAttribute("end", end);
                model.addAttribute("start", start);
                model.addAttribute("items", unitItems);
                model.addAttribute("batches", unitItems.size());
                model.addAttribute("issued", String.format("%,d", issued));
                model.addAttribute("expired", String.format("%,d", expired));
                model.addAttribute("opening", String.format("%,d", opening));
                model.addAttribute("discrepancy", String.format("%,d", discrepancy));
                model.addAttribute("received", String.format("%,d", receivedStock));
                model.addAttribute("usable", String.format("%,d", usable));
                return "inventoryAndSupplies/inventory/views/stock/itemBatches";
            } catch (ParseException ex) {
                return "inventoryAndSupplies/inventory/views/stock/dateError";
            }
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchStockItemLocations", method = RequestMethod.POST)
    public String fetchStockItemLocations(HttpServletRequest request, Model model, @ModelAttribute("itemid") Integer itemid, @ModelAttribute("start") String start, @ModelAttribute("end") String end) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            Integer facilityUnit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
            List<Map> itemList = new ArrayList<>();

            long totalShelved = 0;
            String[] params3 = {"itemid", "facilityunitid"};
            Object[] paramsValues3 = {itemid, facilityUnit};
            String[] fields3 = {"r.celllabel", "r.batchnumber", "SUM(r.quantityshelved)"};
            String where3 = "WHERE r.itemid=:itemid AND r.facilityunitid=:facilityunitid AND r.quantityshelved>0 GROUP BY r.celllabel,r.batchnumber ORDER BY SUM(r.quantityshelved)";
            List<Object[]> itemLocations = (List<Object[]>) genericClassService.fetchRecordFunction(Cellitems.class, fields3, where3, params3, paramsValues3, 0, 0);
            if (itemLocations != null) {
                Map<String, Object> item;
                for (Object[] object : itemLocations) {
                    item = new HashMap<>();
                    item.put("cell", object[0]);
                    if (object[0] != null) {
                        item.put("batch", object[1]);
                    } else {
                        item.put("batch", "Not Set");
                    }
                    item.put("qty", String.format("%,d", object[2]));
                    totalShelved += Long.parseLong(object[2].toString());
                    itemList.add(item);
                }
            }

            model.addAttribute("total", String.format("%,d", totalShelved));
            model.addAttribute("itemLocations", itemList);
            return "inventoryAndSupplies/inventory/views/stock/stockItemLocations";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/updateCategory", method = RequestMethod.POST)
    public @ResponseBody
    String updateCategory(HttpServletRequest request, Model model, @ModelAttribute("id") Integer itemcategoryid, @ModelAttribute("name") String name, @ModelAttribute("desc") String desc) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            String[] columns = {"categoryname", "categorydescription"};
            Object[] columnValues = {name, desc};
            String pk = "itemcategoryid";
            Object pkValue = itemcategoryid.longValue();
            int result = genericClassService.updateRecordSQLSchemaStyle(Itemcategory.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                return "updated";
            } else {
                return "fail";
            }
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/updateDosageForm", method = RequestMethod.POST)
    public @ResponseBody
    String updateDosageForm(HttpServletRequest request, Model model, @ModelAttribute("id") Integer itemformid, @ModelAttribute("name") String name, @ModelAttribute("desc") String desc) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            String[] columns = {"formname", "formdescription"};
            Object[] columnValues = {name, desc};
            String pk = "itemformid";
            Object pkValue = itemformid.longValue();
            int result = genericClassService.updateRecordSQLSchemaStyle(Itemform.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                return "updated";
            } else {
                return "fail";
            }
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/updateAdminTypeName", method = RequestMethod.POST)
    public @ResponseBody
    String updateAdminTypeName(HttpServletRequest request, Model model, @ModelAttribute("id") Integer administeringtypeid, @ModelAttribute("name") String name) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            String[] columns = {"typename"};
            Object[] columnValues = {name};
            String pk = "administeringtypeid";
            Object pkValue = administeringtypeid.longValue();
            int result = genericClassService.updateRecordSQLSchemaStyle(Itemadministeringtype.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                return "updated";
            } else {
                return "fail";
            }
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchItemType", method = RequestMethod.POST)
    public @ResponseBody
    String fetchItemType(Model model, @ModelAttribute("id") Integer id) {
        String[] params = {"administeringtypeid"};
        Object[] paramsValues = {id};
        String[] fields = {"typename"};
        String where = "WHERE administeringtypeid=:administeringtypeid";
        List<String> typrName = (List<String>) genericClassService.fetchRecord(Itemadministeringtype.class, fields, where, params, paramsValues);
        if (typrName != null) {
            return typrName.get(0);
        }
        return "N/A";
    }

    @RequestMapping(value = "/updateItemDetails", method = RequestMethod.POST)
    public @ResponseBody
    String updateItemDetails(HttpServletRequest request, Model model, @ModelAttribute("id") Integer itemid, @ModelAttribute("name") String name, @ModelAttribute("code") String code, @ModelAttribute("form") Integer form, @ModelAttribute("type") Integer type, @ModelAttribute("cat") Integer categoryid) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            String[] columns = {"genericname", "itemcode", "itemformid", "itemadministeringtypeid"};
            Object[] columnValues = {name, code, form, type};
            String pk = "itemid";
            Object pkValue = itemid.longValue();
            int result = genericClassService.updateRecordSQLSchemaStyle(Item.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                String[] params = {"itemid"};
                Object[] paramsValues = {itemid};
                String[] fields = {"itemcategorisationid"};
                String where = "WHERE itemid=:itemid";
                List<Object> categorisation = (List<Object>) genericClassService.fetchRecord(Itemcategorisation.class, fields, where, params, paramsValues);
                if (categorisation != null) {
                    String[] columns2 = {"itemcategoryid"};
                    Object[] columnValues2 = {categoryid};
                    String pk2 = "itemcategorisationid";
                    Object pkValue2 = categorisation.get(0);
                    int update = genericClassService.updateRecordSQLSchemaStyle(Itemcategorisation.class, columns2, columnValues2, pk2, pkValue2, "store");
                    if (update != 0) {
                        return "updated";
                    }
                }
            }
        } else {
            return "refresh";
        }
        return "failed";
    }

    @RequestMapping(value = "/generateStockCard", method = RequestMethod.POST)
    public String generateStockCard(HttpServletRequest request, Model model, @ModelAttribute("itemid") Integer itemid, @ModelAttribute("start") String start, @ModelAttribute("end") String end) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            try {
                long used = 0;
                long available = 0;
                Map<String, Object> stockLevel = new HashMap<>();
                Date startDate = formatter.parse(start);
                Date endDate = formatter.parse(end);
                List<Map> dailyTransactions = new ArrayList<>();
                Integer facilityUnit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");

                //Opening Stock.
                String[] params = {"facilityunitid", "itemid", "start"};
                Object[] paramsValues = {facilityUnit, itemid, startDate};
                String[] fields = {"r.logtype", "SUM(r.quantity)"};
                String where = "WHERE r.facilityunitid=:facilityunitid AND r.itemid=:itemid AND DATE(r.datelogged)<:start GROUP BY r.logtype";
                List<Object[]> stockLogs = (List<Object[]>) genericClassService.fetchRecordFunction(Facilitystocklog.class, fields, where, params, paramsValues, 0, 0);
                if (stockLogs != null) {
                    for (Object[] opn : stockLogs) {
                        if ("IN".equalsIgnoreCase((String) opn[0])) {
                            available = available + Long.parseLong(opn[1].toString());
                        } else {
                            available = available - Long.parseLong(opn[1].toString());
                        }
                    }
                }
                stockLevel.put("opening", available);
                stockLevel.put("date", formatter2.format(startDate));

                String[] params2 = {"facilityunitid", "itemid", "start", "end"};
                Object[] paramsValues2 = {facilityUnit, itemid, startDate, endDate};
                String[] fields2 = {"to_date(to_char(r.datelogged,'DD-MM-YYYY'),'DD-MM-YYYY')"};
                String where2 = "WHERE r.facilityunitid=:facilityunitid AND r.itemid=:itemid AND DATE(r.datelogged)>=:start AND DATE(r.datelogged)<=:end ORDER BY to_date(to_char(r.datelogged,'DD-MM-YYYY'),'DD-MM-YYYY') GROUP BY to_date(to_char(r.datelogged,'DD-MM-YYYY'),'DD-MM-YYYY')";
                List<Date> transactionDates = (List) genericClassService.fetchRecordFunction(Facilitystocklog.class, fields2, where2, params2, paramsValues2, 0, 0);
                if (transactionDates != null) {
                    Map<String, Object> trns;
                    for (Date date : transactionDates) {
                        String[] params3 = {"facilityunitid", "itemid", "logdate", "logtype"};
                        Object[] paramsValues3 = {facilityUnit, itemid, date, "IN"};
                        String[] fields3 = {"r.reference", "r.referencetype", "r.referencenumber", "r.staffid", "sum(r.quantity)"};
                        String where3 = "WHERE r.facilityunitid=:facilityunitid AND r.itemid=:itemid AND DATE(r.datelogged)=:logdate AND r.logtype=:logtype GROUP BY r.reference,r.referencetype,r.referencenumber,r.staffid";
                        List<Object[]> received = (List<Object[]>) genericClassService.fetchRecordFunction(Facilitystocklog.class, fields3, where3, params3, paramsValues3, 0, 0);
                        if (received != null) {
                            for (Object[] rcv : received) {
                                available = available + Long.parseLong(rcv[4].toString());
                                trns = new HashMap<>();
                                trns.put("type", "in");
                                trns.put("bal", rcv[4]);
                                trns.put("total", available);
                                if (rcv[2] != null) {
                                    trns.put("refno", rcv[2]);
                                } else {
                                    trns.put("refno", "-");
                                }
                                trns.put("date", formatter2.format(date));
                                if (rcv[0] != null) {
                                    String referenceType = (String) rcv[1];
                                    if ("INT".equals(referenceType)) {
                                        String[] params4 = {"facilityunitid"};
                                        Object[] paramsValues4 = {rcv[0]};
                                        String[] fields4 = {"facilityunitname"};
                                        String where4 = "WHERE facilityunitid=:facilityunitid";
                                        List<String> reference = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fields4, where4, params4, paramsValues4);
                                        if (reference != null) {
                                            trns.put("reference", reference.get(0));
                                        }
                                    } else if ("DON".equals(referenceType)) {
                                        String[] params5 = {"donorprogramid"};
                                        Object[] paramsValues5 = {rcv[0]};
                                        String[] fields5 = {"donorname"};
                                        String where5 = "WHERE donorprogramid=:donorprogramid";
                                        List<String> reference = (List<String>) genericClassService.fetchRecord(Donorprogram.class, fields5, where5, params5, paramsValues5);
                                        if (reference != null) {
                                            trns.put("reference", reference.get(0));
                                        }
                                    }
                                } else {
                                    trns.put("reference", "Entered");
                                }
                                String[] params4 = {"staffid"};
                                Object[] paramsValues4 = {rcv[3]};
                                String[] fields4 = {"firstname", "othernames", "lastname"};
                                String where4 = "WHERE staffid=:staffid";
                                List<Object[]> staffDetails = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields4, where4, params4, paramsValues4);
                                if (staffDetails != null) {
                                    String init;
                                    if (staffDetails.get(0)[1] != null) {
                                        if (((String) staffDetails.get(0)[1]).length() > 0) {
                                            init = ((String) staffDetails.get(0)[0]).charAt(0) + "." + ((String) staffDetails.get(0)[1]).charAt(0) + "." + ((String) staffDetails.get(0)[2]).charAt(0);
                                        } else {
                                            init = ((String) staffDetails.get(0)[0]).charAt(0) + ". " + ((String) staffDetails.get(0)[2]).charAt(0);
                                        }
                                    } else {
                                        init = ((String) staffDetails.get(0)[0]).charAt(0) + "." + ((String) staffDetails.get(0)[2]).charAt(0);
                                    }
                                    trns.put("user", init);
                                }
                                dailyTransactions.add(trns);
                            }
                        }

                        String[] params4 = {"facilityunitid", "itemid", "logdate", "logtype"};
                        Object[] paramsValues4 = {facilityUnit, itemid, date, "OUT"};
                        String[] fields4 = {"r.reference", "r.referencetype", "r.referencenumber", "r.staffid", "sum(r.quantity)"};
                        String where4 = "WHERE r.facilityunitid=:facilityunitid AND r.itemid=:itemid AND DATE(r.datelogged)=:logdate AND r.logtype=:logtype GROUP BY r.reference,r.referencetype,r.referencenumber,r.staffid";
                        List<Object[]> orderOut = (List<Object[]>) genericClassService.fetchRecordFunction(Facilitystocklog.class, fields4, where4, params4, paramsValues4, 0, 0);
                        if (orderOut != null) {
                            for (Object[] rcv : orderOut) {
                                used = used + Long.parseLong(rcv[4].toString());
                                available = available - Long.parseLong(rcv[4].toString());
                                trns = new HashMap<>();
                                trns.put("type", "out");
                                trns.put("bal", rcv[4]);
                                trns.put("total", available);
                                if (rcv[2] != null) {
                                    trns.put("refno", rcv[2]);
                                } else {
                                    trns.put("refno", "-");
                                }
                                trns.put("date", formatter2.format(date));
                                if (rcv[0] != null) {
                                    String referenceType = (String) rcv[1];
                                    if ("INT".equals(referenceType)) {
                                        String[] params5 = {"facilityunitid"};
                                        Object[] paramsValues5 = {rcv[0]};
                                        String[] fields5 = {"facilityunitname"};
                                        String where5 = "WHERE facilityunitid=:facilityunitid";
                                        List<String> reference = (List<String>) genericClassService.fetchRecord(Facilityunit.class, fields5, where5, params5, paramsValues5);
                                        if (reference != null) {
                                            trns.put("reference", reference.get(0));
                                        }
                                    } else if ("DON".equals(referenceType)) {
                                        String[] params5 = {"donorprogramid"};
                                        Object[] paramsValues5 = {rcv[0]};
                                        String[] fields5 = {"donorname"};
                                        String where5 = "WHERE donorprogramid=:donorprogramid";
                                        List<String> reference = (List<String>) genericClassService.fetchRecord(Donorprogram.class, fields5, where5, params5, paramsValues5);
                                        if (reference != null) {
                                            trns.put("reference", reference.get(0));
                                        }
                                    }
                                } else {
                                    trns.put("reference", "Issued Out");
                                }
                                String[] params5 = {"staffid"};
                                Object[] paramsValues5 = {rcv[3]};
                                String[] fields5 = {"firstname", "othernames", "lastname"};
                                String where5 = "WHERE staffid=:staffid";
                                List<Object[]> staffDetails = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields5, where5, params5, paramsValues5);
                                if (staffDetails != null) {
                                    String init;
                                    if (staffDetails.get(0)[1] != null) {
                                        if (((String) staffDetails.get(0)[1]).length() > 0) {
                                            init = ((String) staffDetails.get(0)[0]).charAt(0) + "." + ((String) staffDetails.get(0)[1]).charAt(0) + "." + ((String) staffDetails.get(0)[2]).charAt(0);
                                        } else {
                                            init = ((String) staffDetails.get(0)[0]).charAt(0) + ". " + ((String) staffDetails.get(0)[2]).charAt(0);
                                        }
                                    } else {
                                        init = ((String) staffDetails.get(0)[0]).charAt(0) + "." + ((String) staffDetails.get(0)[2]).charAt(0);
                                    }
                                    trns.put("user", init);
                                }
                                dailyTransactions.add(trns);
                            }
                        }

                        String[] params5 = {"facilityunitid", "itemid", "logdate", "logtype"};
                        Object[] paramsValues5 = {facilityUnit, itemid, date, "DISC"};
                        String[] fields5 = {"r.reference", "r.referencetype", "r.referencenumber", "r.staffid", "sum(r.quantity)"};
                        String where5 = "WHERE r.facilityunitid=:facilityunitid AND r.itemid=:itemid AND DATE(r.datelogged)=:logdate AND r.logtype=:logtype GROUP BY r.reference,r.referencetype,r.referencenumber,r.staffid";
                        List<Object[]> discrepancy = (List<Object[]>) genericClassService.fetchRecordFunction(Facilitystocklog.class, fields5, where5, params5, paramsValues5, 0, 0);
                        if (discrepancy != null) {
                            for (Object[] rcv : discrepancy) {
                                available = available - Long.parseLong(rcv[4].toString());
                                trns = new HashMap<>();
                                trns.put("type", "out");
                                trns.put("bal", rcv[4]);
                                trns.put("total", available);
                                if (rcv[2] != null) {
                                    trns.put("refno", rcv[2]);
                                } else {
                                    trns.put("refno", "-");
                                }
                                trns.put("date", formatter2.format(date));
                                trns.put("reference", "Stock Taking Discrepancy");

                                String[] params6 = {"staffid"};
                                Object[] paramsValues6 = {rcv[3]};
                                String[] fields6 = {"firstname", "othernames", "lastname"};
                                String where6 = "WHERE staffid=:staffid";
                                List<Object[]> staffDetails = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields6, where6, params6, paramsValues6);
                                if (staffDetails != null) {
                                    String init;
                                    if (staffDetails.get(0)[1] != null) {
                                        if (((String) staffDetails.get(0)[1]).length() > 0) {
                                            init = ((String) staffDetails.get(0)[0]).charAt(0) + "." + ((String) staffDetails.get(0)[1]).charAt(0) + "." + ((String) staffDetails.get(0)[2]).charAt(0);
                                        } else {
                                            init = ((String) staffDetails.get(0)[0]).charAt(0) + ". " + ((String) staffDetails.get(0)[2]).charAt(0);
                                        }
                                    } else {
                                        init = ((String) staffDetails.get(0)[0]).charAt(0) + "." + ((String) staffDetails.get(0)[2]).charAt(0);
                                    }
                                    trns.put("user", init);
                                }
                                dailyTransactions.add(trns);
                            }
                        }

                        String[] params6 = {"facilityunitid", "itemid", "logdate", "logtype"};
                        Object[] paramsValues6 = {facilityUnit, itemid, date, "DISP"};
                        String[] fields6 = {"r.reference", "r.referencetype", "r.referencenumber", "r.staffid", "sum(r.quantity)"};
                        String where6 = "WHERE r.facilityunitid=:facilityunitid AND r.itemid=:itemid AND DATE(r.datelogged)=:logdate AND r.logtype=:logtype GROUP BY r.reference,r.referencetype,r.referencenumber,r.staffid";
                        List<Object[]> dispensed = (List<Object[]>) genericClassService.fetchRecordFunction(Facilitystocklog.class, fields6, where6, params6, paramsValues6, 0, 0);
                        if (dispensed != null) {
                            for (Object[] rcv : dispensed) {
                                used = used + Long.parseLong(rcv[4].toString());
                                available = available - Long.parseLong(rcv[4].toString());
                                trns = new HashMap<>();
                                trns.put("type", "out");
                                trns.put("bal", rcv[4]);
                                trns.put("total", available);
                                if (rcv[2] != null) {
                                    trns.put("refno", rcv[2]);
                                } else {
                                    trns.put("refno", "-");
                                }
                                trns.put("date", formatter2.format(date));
                                trns.put("reference", "Dispensed");

                                String[] params7 = {"staffid"};
                                Object[] paramsValues7 = {rcv[3]};
                                String[] fields7 = {"firstname", "othernames", "lastname"};
                                String where7 = "WHERE staffid=:staffid";
                                List<Object[]> staffDetails = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields7, where7, params7, paramsValues7);
                                if (staffDetails != null) {
                                    String init;
                                    if (staffDetails.get(0)[1] != null) {
                                        if (((String) staffDetails.get(0)[1]).length() > 0) {
                                            init = ((String) staffDetails.get(0)[0]).charAt(0) + "." + ((String) staffDetails.get(0)[1]).charAt(0) + "." + ((String) staffDetails.get(0)[2]).charAt(0);
                                        } else {
                                            init = ((String) staffDetails.get(0)[0]).charAt(0) + ". " + ((String) staffDetails.get(0)[2]).charAt(0);
                                        }
                                    } else {
                                        init = ((String) staffDetails.get(0)[0]).charAt(0) + "." + ((String) staffDetails.get(0)[2]).charAt(0);
                                    }
                                    trns.put("user", init);
                                }
                                dailyTransactions.add(trns);
                            }
                        }

                        String[] params7 = {"facilityunitid", "itemid", "logdate", "logtype"};
                        Object[] paramsValues7 = {facilityUnit, itemid, date, "EXP"};
                        String[] fields7 = {"r.reference", "r.referencetype", "r.referencenumber", "r.staffid", "sum(r.quantity)"};
                        String where7 = "WHERE r.facilityunitid=:facilityunitid AND r.itemid=:itemid AND DATE(r.datelogged)=:logdate AND r.logtype=:logtype GROUP BY r.reference,r.referencetype,r.referencenumber,r.staffid";
                        List<Object[]> expired = (List<Object[]>) genericClassService.fetchRecordFunction(Facilitystocklog.class, fields7, where7, params7, paramsValues7, 0, 0);
                        if (expired != null) {
                            for (Object[] rcv : expired) {
                                available = available - Long.parseLong(rcv[4].toString());
                                trns = new HashMap<>();
                                trns.put("type", "out");
                                trns.put("bal", rcv[4]);
                                trns.put("total", available);
                                if (rcv[2] != null) {
                                    trns.put("refno", rcv[2]);
                                } else {
                                    trns.put("refno", "-");
                                }
                                trns.put("date", formatter2.format(date));
                                trns.put("reference", "Expired");

                                String[] params8 = {"staffid"};
                                Object[] paramsValues8 = {rcv[3]};
                                String[] fields8 = {"firstname", "othernames", "lastname"};
                                String where8 = "WHERE staffid=:staffid";
                                List<Object[]> staffDetails = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields8, where8, params8, paramsValues8);
                                if (staffDetails != null) {
                                    String init;
                                    if (staffDetails.get(0)[1] != null) {
                                        if (((String) staffDetails.get(0)[1]).length() > 0) {
                                            init = ((String) staffDetails.get(0)[0]).charAt(0) + "." + ((String) staffDetails.get(0)[1]).charAt(0) + "." + ((String) staffDetails.get(0)[2]).charAt(0);
                                        } else {
                                            init = ((String) staffDetails.get(0)[0]).charAt(0) + ". " + ((String) staffDetails.get(0)[2]).charAt(0);
                                        }
                                    } else {
                                        init = ((String) staffDetails.get(0)[0]).charAt(0) + "." + ((String) staffDetails.get(0)[2]).charAt(0);
                                    }
                                    trns.put("user", init);
                                }
                                dailyTransactions.add(trns);
                            }
                        }
                    }
                }
                double weeks;
                Date now = new Date();
                if (endDate.getTime() > now.getTime()) {
                    weeks = (double) (now.getTime() - startDate.getTime()) / (1000 * 60 * 60 * 24 * 7);
                } else {
                    weeks = (double) (endDate.getTime() - startDate.getTime()) / (1000 * 60 * 60 * 24 * 7);
                }
                double averageConsumption = used / weeks;
                double projection = -1;
                if (averageConsumption > 0) {
                    projection = available / averageConsumption;
                }
                model.addAttribute("weeks", weeks);

                model.addAttribute("projection", projection);
                model.addAttribute("openingStock", stockLevel);
                model.addAttribute("dailyTransactions", dailyTransactions);
                model.addAttribute("averageConsumption", averageConsumption);
                model.addAttribute("available", String.format("%,d", available));
                return "inventoryAndSupplies/inventory/views/stock/stockCard/stockCard";
            } catch (ParseException ex) {
                return "inventoryAndSupplies/inventory/views/stock/dateError";
            }
        } else {
            return "refresh";
        }
    }
    //
    @RequestMapping(value="/prescriptioninfo", method=RequestMethod.GET)
    public ModelAndView prescriptionInfo(HttpServletRequest request){
        final Map<String, Object> model = new HashMap<>();
        try {
            String referenceNumber = request.getParameter("referencenumber");
            String prescriber = "", patientName = "";
            if(referenceNumber != null && (!referenceNumber.isEmpty())){
                String [] fields = { "patientvisitid", "addedby" };
                String [] params = { "referencenumber" };
                Object [] paramsValues = { referenceNumber.toLowerCase() };
                String where = "WHERE LOWER(referencenumber)=:referencenumber";
                List<Object[]> prescriptions = (List<Object[]>) genericClassService.fetchRecord(Prescription.class, fields, where, params, paramsValues);
                if(prescriptions != null){
                    Object [] prescription = prescriptions.get(0);
                    
                    fields = new String [] { "patientid" };
                    params = new String [] { "patientvisitid" };
                    paramsValues = new Object [] { Long.parseLong(prescription[0].toString()) };
                    where = "WHERE patientvisitid=:patientvisitid";
                    List<Object> patientVisits = (List<Object>) genericClassService.fetchRecord(Patientvisit.class, fields, where, params, paramsValues);
                    if(patientVisits != null){
                        Object patientId = patientVisits.get(0);
                        if(patientId != null) {
                            fields = new String [] { "firstname", "othernames", "lastname" };
                            params = new String [] { "patientid" };
                            paramsValues = new Object [] { BigInteger.valueOf(Long.parseLong(patientId.toString())) };
                            where = "WHERE patientid=:patientid";
                            List<Object[]> patientNames = (List<Object[]>) genericClassService.fetchRecord(Searchpatient.class, fields, where, params, paramsValues);
                            if(patientName != null){
                                Object [] patient = patientNames.get(0);
                                if(patient[1] != null){
                                    patientName = String.format("%s %s %s", patient[0], patient[1], patient[2]);
                                } else {
                                    patientName = String.format("%s %s", patient[0], patient[2]);
                                }
                            }
                        }
                    }
                    model.put("patientname", patientName);
                    
                    fields = new String [] { "firstname", "othernames", "lastname" };
                    params = new String [] { "staffid" };
                    paramsValues = new Object [] { BigInteger.valueOf(Long.parseLong(prescription[1].toString())) };
                    where = "WHERE staffid=:staffid";
                    List<Object[]> prescriberNames = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields, where, params, paramsValues);
                    if(prescriberNames != null){
                        Object[] staff = prescriberNames.get(0);
                        if(staff[1] != null){
                            prescriber = String.format("%s %s %s", staff[0], staff[1], staff[2]);
                        } else {
                            prescriber = String.format("%s %s", staff[0], staff[2]);
                        }
                    }
                    model.put("prescribername", prescriber);
                }
            }
        } catch(NumberFormatException e) {
            System.out.println(e);
        } catch(Exception e) {
            System.out.println(e);
        }
        return new ModelAndView("inventoryAndSupplies/inventory/views/stock/prescriptionInfo", model);
    }
    @RequestMapping(value="/orderinfo", method=RequestMethod.GET)
    public ModelAndView orderInfo(HttpServletRequest request){
        final Map<String, Object> model = new HashMap<>();
        try {
            String referenceNumber = request.getParameter("referencenumber");
            String facilityUnitName = "", StaffName = "";
            if(referenceNumber != null && (!referenceNumber.isEmpty())){
                String [] fields = { "destinationstore", "facilityorderid" };
                String [] params = { "facilityorderno" };
                Object [] paramsValues = { referenceNumber.toLowerCase() };
                String where = "WHERE LOWER(facilityorderno)=:facilityorderno";
                List<Object[]> facilityOrders = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fields, where, params, paramsValues);
                if(facilityOrders != null){
                    Object [] facilityOrder = facilityOrders.get(0);                    
                    fields = new String [] { "facilityunitname" };
                    params = new String [] { "facilityunitid" };
                    paramsValues = new Object [] { Long.parseLong(facilityOrder[0].toString()) };
                    where = "WHERE facilityunitid=:facilityunitid";
                    List<Object> facilityUnit = (List<Object>) genericClassService.fetchRecord(Facilityunit.class, fields, where, params, paramsValues);
                    if(facilityUnit != null){
                        facilityUnitName = (facilityUnit.get(0) != null) ? facilityUnit.get(0).toString() : "";
                    }
                    fields = new String [] { "facilityorderitemsid", "deliveredto" };
                    params = new String [] { "facilityorderid" };
                    paramsValues = new Object [] { Long.parseLong(facilityOrder[1].toString()) };
                    where = "WHERE facilityorderid=:facilityorderid AND serviced=true";
                    List<Object[]> facilityOrderItems = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fields, where, params, paramsValues);
                    if(facilityOrderItems != null){
                        Object[] facilityOrderItem = facilityOrderItems.get(0);
                        fields = new String [] { "firstname", "othernames", "lastname" };
                        params = new String [] { "staffid" };
                        paramsValues = new Object [] { BigInteger.valueOf(Long.parseLong(facilityOrderItem[1].toString())) };
                        where = "WHERE staffid=:staffid";
                        List<Object[]> prescriberNames = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields, where, params, paramsValues);
                        if(prescriberNames != null){
                            Object[] staff = prescriberNames.get(0);
                            if(staff[1] != null){
                                StaffName = String.format("%s %s %s", staff[0], staff[1], staff[2]);
                            } else {
                                StaffName = String.format("%s %s", staff[0], staff[2]);
                            }
                        }                        
                    }
                }
            }
            model.put("servicingunit", facilityUnitName);  
            model.put("receivername", StaffName);
        } catch(Exception e) {
            System.out.println(e);
        }
        return new ModelAndView("inventoryAndSupplies/inventory/views/stock/orderInfo", model);
    }
    //
    private Map getItemStockLevel(Integer facilityUnit, Integer itemid, Date startDate, Date endDate) {
        long available = 0, stockReceived = 0;
        Map<String, Object> stockLevels = new HashMap<>();

        //Opening Stock.
        String[] params = {"facilityunitid", "itemid", "start"};
        Object[] paramsValues = {facilityUnit, itemid, startDate};
        String[] fields = {"r.logtype", "SUM(r.quantity)"};
        String where = "WHERE r.facilityunitid=:facilityunitid AND r.itemid=:itemid AND DATE(r.datelogged)<:start GROUP BY r.logtype";
        List<Object[]> stockLogs = (List<Object[]>) genericClassService.fetchRecordFunction(Facilitystocklog.class, fields, where, params, paramsValues, 0, 0);
        if (stockLogs != null) {
            for (Object[] opn : stockLogs) {
                if ("IN".equalsIgnoreCase((String) opn[0])) {
                    available = available + Long.parseLong(opn[1].toString());
                } else {
                    available = available - Long.parseLong(opn[1].toString());
                }
            }
        }
        stockLevels.put("opening", available);

        //Received stock.
        String[] params3 = {"facilityunitid", "itemid", "start", "end", "logtype"};
        Object[] paramsValues3 = {facilityUnit, itemid, startDate, endDate, "IN"};
        String[] fields3 = {"sum(r.quantity)"};
        String where3 = "WHERE r.facilityunitid=:facilityunitid AND r.itemid=:itemid AND DATE(r.datelogged)>=:start AND DATE(r.datelogged)<=:end AND r.logtype=:logtype";
        List<Object> received = (List) genericClassService.fetchRecordFunction(Facilitystocklog.class, fields3, where3, params3, paramsValues3, 0, 0);
        if (received != null) {
            if (received.get(0) != null) {
                stockReceived = Long.parseLong(received.get(0).toString());
                available = available + stockReceived;
            }
        }
        stockLevels.put("received", stockReceived);

        //Issued stock.
        String[] params4 = {"facilityunitid", "itemid", "start", "end", "out", "disp", "disc", "exp"};
        Object[] paramsValues4 = {facilityUnit, itemid, startDate, endDate, "OUT", "DISP", "DISC", "EXP"};
        String[] fields4 = {"sum(r.quantity)"};
        String where4 = "WHERE r.facilityunitid=:facilityunitid AND r.itemid=:itemid AND DATE(r.datelogged)>=:start AND DATE(r.datelogged)<=:end AND (r.logtype=:out OR r.logtype=:disp OR r.logtype=:disc OR r.logtype=:exp)";
        List<Object> stockOut = (List) genericClassService.fetchRecordFunction(Facilitystocklog.class, fields4, where4, params4, paramsValues4, 0, 0);
        if (stockOut != null) {
            if (stockOut.get(0) != null) {
                available = available - Long.parseLong(stockOut.get(0).toString());
            }
        }
        stockLevels.put("available", available);

        return stockLevels;
    }

    private Map getBatchStockLevel(Integer stockid, Date startDate, Date endDate) {
        long available = 0, stockReceived = 0, issued = 0, discrepancies = 0, expired = 0;
        Map<String, Object> stockLevels = new HashMap<>();

        //Opening Stock.
        String[] params = {"stockid", "start"};
        Object[] paramsValues = {stockid, startDate};
        String[] fields = {"r.logtype", "SUM(r.quantity)"};
        String where = "WHERE r.stockid=:stockid AND DATE(r.datelogged)<:start GROUP BY r.logtype";
        List<Object[]> stockLogs = (List<Object[]>) genericClassService.fetchRecordFunction(Facilitystocklog.class, fields, where, params, paramsValues, 0, 0);
        if (stockLogs != null) {
            for (Object[] opn : stockLogs) {
                if ("IN".equalsIgnoreCase((String) opn[0])) {
                    available = available + Long.parseLong(opn[1].toString());
                } else {
                    available = available - Long.parseLong(opn[1].toString());
                }
            }
        }
        stockLevels.put("opening", available);

        //Received stock.
        String[] params3 = {"stockid", "start", "end", "logtype"};
        Object[] paramsValues3 = {stockid, startDate, endDate, "IN"};
        String[] fields3 = {"sum(r.quantity)"};
        String where3 = "WHERE r.stockid=:stockid AND DATE(r.datelogged)>=:start AND DATE(r.datelogged)<=:end AND r.logtype=:logtype";
        List<Object> received = (List) genericClassService.fetchRecordFunction(Facilitystocklog.class, fields3, where3, params3, paramsValues3, 0, 0);
        if (received != null) {
            if (received.get(0) != null) {
                stockReceived = Long.parseLong(received.get(0).toString());
                available = available + stockReceived;
            }
        }
        stockLevels.put("received", stockReceived);

        //Stock 0ut.
        String[] params4 = {"stockid", "start", "end", "out", "disp", "disc", "exp"};
        Object[] paramsValues4 = {stockid, startDate, endDate, "OUT", "DISP", "DISC", "EXP"};
        String[] fields4 = {"r.logtype", "sum(r.quantity)"};
        String where4 = "WHERE r.stockid=:stockid AND DATE(r.datelogged)>=:start AND DATE(r.datelogged)<=:end AND (r.logtype=:out OR r.logtype=:disp OR r.logtype=:disc OR r.logtype=:exp) GROUP BY r.logtype";
        List<Object[]> stockOut = (List<Object[]>) genericClassService.fetchRecordFunction(Facilitystocklog.class, fields4, where4, params4, paramsValues4, 0, 0);
        if (stockOut != null) {
            for (Object[] out : stockOut) {
                available = available - Long.parseLong(stockOut.get(0)[1].toString());
                if ("OUT".equalsIgnoreCase(out[0].toString()) || "DISP".equalsIgnoreCase(out[0].toString())) {
                    issued = issued + Long.parseLong(out[1].toString());
                } else if ("DISC".equalsIgnoreCase(out[0].toString())) {
                    discrepancies = discrepancies + Long.parseLong(out[1].toString());
                } else if ("EXP".equalsIgnoreCase(out[0].toString())) {
                    expired = expired + Long.parseLong(out[1].toString());
                }
            }
        }
        stockLevels.put("issued", issued);
        stockLevels.put("expired", expired);
        stockLevels.put("discrepancies", discrepancies);
        stockLevels.put("available", available);

        return stockLevels;
    }    
}
