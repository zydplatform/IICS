/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.controlpanel.Stafffacilityunit;
import com.iics.domain.Person;
import com.iics.domain.Searchstaff;
import com.iics.domain.Staff;
import com.iics.domain.Systemuser;
import com.iics.service.GenericClassService;
import com.iics.store.Facilityorder;
import com.iics.store.Facilityorderitems;
import com.iics.store.Item;
import com.iics.store.Orderitemsview;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
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
 * @author user
 */
@Controller
@RequestMapping("/internalincomingsupplies")
public class incominginternalsupplies {

    @Autowired
    GenericClassService genericClassService;
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat formatter2 = new SimpleDateFormat("dd-MM-yyyy");

    @RequestMapping(value = "/internalSupplies", method = RequestMethod.GET)
    public String internalSupplies(HttpServletRequest request, Model model) {
        String FacilityUnitSession = request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString();
        String sessionActiveLoginStaffid = request.getSession().getAttribute("sessionActiveLoginStaffid").toString();
        List<Map> deliveredorders = new ArrayList<>();
        String[] params = {"taken", "status", "ordertype", "originstore"};
        Object[] paramsValues = {Boolean.TRUE, "DELIVERED", "INTERNAL", BigInteger.valueOf(Long.parseLong(FacilityUnitSession))};
        String[] fields = {"facilityorderno", "preparedby", "facilityorderid"};
        String where = "WHERE taken=:taken AND status=:status AND ordertype=:ordertype AND originstore=:originstore";
        List<Object[]> found = (List<Object[]>) genericClassService.fetchRecord(Facilityorder.class, fields, where, params, paramsValues);
        Map<String, Object> deliveredorder;
        
        if (found != null) {
            for (Object[] ord : found) {
                deliveredorder = new HashMap<>();
                deliveredorder.put("facilityorderno", (String) ord[0]);
                deliveredorder.put("facilityorderid", (Long) ord[2]);
                deliveredorder.put("staffid", (BigInteger) ord[2]);
                //Count Items on Order
                int numberOfItemsOnOrder = 0;
                String[] params2 = {"approved", "ispicked", "serviced", "isdelivered", "pickedby"};
                Object[] paramsValues2 = {Boolean.TRUE, Boolean.TRUE, Boolean.TRUE, Boolean.TRUE, BigInteger.valueOf(Long.parseLong(sessionActiveLoginStaffid))};
                String where2 = "WHERE approved=:approved AND ispicked=:ispicked AND serviced=:serviced AND isdelivered=:isdelivered AND pickedby=:pickedby";
                numberOfItemsOnOrder = genericClassService.fetchRecordCount(Facilityorderitems.class, where2, params2, paramsValues2);
                deliveredorder.put("numberOfItemsOnOrder", numberOfItemsOnOrder);
                //Pick who prepared Order
                String[] params6 = {"preparedby"};
                Object[] paramsValues6 = {(BigInteger) ord[1]};
                String[] fields6 = {"firstname", "lastname", "othernames"};
                String where6 = "WHERE staffid=:preparedby";
                List<Object[]> found6 = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields6, where6, params6, paramsValues6);
                if (found6 != null) {
                    deliveredorder.put("firstname", (String) found6.get(0)[0]);
                    deliveredorder.put("lastname", (String) found6.get(0)[1]);
                    deliveredorder.put("othernames", (String) found6.get(0)[2]);
                }
                deliveredorders.add(deliveredorder);

            }
        }
        System.out.println("------------"+deliveredorders);
        model.addAttribute("deliveredorders", deliveredorders);
        return "inventoryAndSupplies/incominginternalorders/manageinternalorders";
    }

    @RequestMapping(value = "/getorderitems", method = RequestMethod.GET)
    public String getorderitems(Model model,
            @ModelAttribute("id") String id,
            @ModelAttribute("id1") String id1
    ) {

        List<Map> orderitems = new ArrayList<>();
        String[] params611 = {"facilityorderid", "pickedby"};
        Object[] paramsValues611 = {BigInteger.valueOf(Long.parseLong(id)), BigInteger.valueOf(Long.parseLong(id1))};
        String[] fields1 = {"facilityorderitemsid", "itemid", "qtyapproved", "facilityorderid", "batchno", "qtyordered"};
        String where611 = "WHERE facilityorderid=:facilityorderid AND pickedby=:pickedby";
        List<Object[]> found611 = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fields1, where611, params611, paramsValues611);
        Map<String, Object> itemnames;
        if (found611 != null) {
            for (Object[] requnit : found611) {
                itemnames = new HashMap<>();
                if ((long) requnit[2] == 0) {

                } else {
                    itemnames.put("qtyapproved", requnit[2]);
                    itemnames.put("facilityorderitemsid", (long) requnit[0]);
                    itemnames.put("itemid", requnit[1]);
                    itemnames.put("facilityorderid", (long) requnit[3]);
                    itemnames.put("batchno", requnit[4]);
                    itemnames.put("qtyordered", requnit[5]);
                    String[] params2 = {"itemid"};
                    Object[] paramsValues2 = {(Long) requnit[1]};
                    String[] fields2 = {"genericname", "packsize", "itemid"};
                    String where2 = "WHERE itemid=:itemid";
                    List<Object[]> found2 = (List<Object[]>) genericClassService.fetchRecord(Item.class, fields2, where2, params2, paramsValues2);

                    if (found2 != null) {
                        Object[] unit = found2.get(0);
                        itemnames.put("genericname", unit[0].toString());
                    }
                    orderitems.add(itemnames);
                }
            }
        }
        model.addAttribute("orderitems", orderitems);
        return "inventoryAndSupplies/incominginternalorders/views/transferitems";
    }

    @RequestMapping(value = "/itemshelve", method = RequestMethod.GET)
    public String itemshelve(Model model,
            @ModelAttribute("id") String id,
            @ModelAttribute("id1") String id1
    ) {
        List<Map> toshelveitems = new ArrayList<>();
        String[] params611 = {"facilityorderid", "pickedby"};
        Object[] paramsValues611 = {BigInteger.valueOf(Long.parseLong(id)), BigInteger.valueOf(Long.parseLong(id1))};
        String[] fields1 = {"facilityorderitemsid", "itemid", "qtyapproved", "facilityorderid", "batchno", "qtyordered"};
        String where611 = "WHERE facilityorderid=:facilityorderid AND pickedby=:pickedby";
        List<Object[]> found611 = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fields1, where611, params611, paramsValues611);
        Map<String, Object> itemnames;
        if (found611 != null) {
            for (Object[] requnit : found611) {
                itemnames = new HashMap<>();
                itemnames.put("qtyapproved", requnit[2]);
                itemnames.put("facilityorderitemsid", (long) requnit[0]);
                itemnames.put("itemid", requnit[1]);
                itemnames.put("facilityorderid", (long) requnit[3]);
                itemnames.put("batchno", (String) requnit[4]);
                itemnames.put("qtyordered", requnit[5]);
                String[] params2 = {"itemid"};
                Object[] paramsValues2 = {(Long) requnit[1]};
                String[] fields2 = {"genericname", "packsize", "itemid"};
                String where2 = "WHERE itemid=:itemid";
                List<Object[]> found2 = (List<Object[]>) genericClassService.fetchRecord(Item.class, fields2, where2, params2, paramsValues2);

                if (found2 != null) {
                    Object[] unit = found2.get(0);
                    itemnames.put("genericname", unit[0].toString());
                }
                toshelveitems.add(itemnames);
            }

        }
        model.addAttribute("toshelveitems", toshelveitems);
        return "inventoryAndSupplies/incominginternalorders/views/shelveitems";
    }

    @RequestMapping(value = "/transferitems.htm")
    public @ResponseBody
    String transferitems(HttpServletRequest request
    ) {
        String username = request.getParameter("username");
        String pass = request.getParameter("pass");
        Integer facilityUnit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
        String results = "";
        String[] paramsu = {"pass", "username"};
        Object[] paramsValuesu = {pass, username};
        String[] fieldsu = {"personid.personid"};
        String whereu = "WHERE password=:pass AND username=:username";
        List<Long> allowedusers = (List<Long>) genericClassService.fetchRecord(Systemuser.class, fieldsu, whereu, paramsu, paramsValuesu);
        if (allowedusers != null) {
            String[] params = {"personid"};
            Object[] paramsValues = {allowedusers.get(0)};
            String[] fields = {"staffid"};
            String where = "WHERE personid=:personid";
            List<Long> found = (List<Long>) genericClassService.fetchRecord(Staff.class, fields, where, params, paramsValues);
            if (found != null) {
                String[] paramsf = {"staffid", "facilityunitid"};
                Object[] paramsValuesf = {found.get(0), facilityUnit,};
                String[] fieldsf = {"staffid"};
                String wheref = "WHERE staffid=:staffid AND facilityunitid=:facilityunitid";
                List<Long> foundf = (List<Long>) genericClassService.fetchRecord(Stafffacilityunit.class, fieldsf, wheref, paramsf, paramsValuesf);
                if (foundf != null) {
                    try {
                        List<Map> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("additem"), List.class);
                        for (Map items : item) {
                            String staffidsession = request.getSession().getAttribute("sessionActiveLoginStaffid").toString();
                            String itemid = items.get("itemid").toString();
                            String itemvalue = items.get("itemvalue").toString();
                            String inputval = items.get("inputval").toString();
                            String variance = items.get("variance").toString();
                            String facilityorderid = items.get("facilityorderid").toString();
                            String qtyapproved = items.get("qtyapproved").toString();
                            String batchno = items.get("batchno").toString();
                            String qtyordered = items.get("qtyordered").toString();

                            //update who tranfers
                            String[] columns = {"pickedby", "qtyapproved"};
                            Object[] columnValues = {Long.parseLong(staffidsession), BigInteger.valueOf(Long.parseLong(variance))};
                            String pk = "facilityorderitemsid";
                            Object pkValue = Long.parseLong(itemvalue);
                            genericClassService.updateRecordSQLSchemaStyle(Facilityorderitems.class, columns, columnValues, pk, pkValue, "store");

                            Facilityorderitems resaveorder = new Facilityorderitems();
                            resaveorder.setApproved(Boolean.TRUE);
                            resaveorder.setFacilityorderid(new Facilityorder(Long.parseLong(facilityorderid)));
                            resaveorder.setIspicked(Boolean.TRUE);
                            resaveorder.setItemid(new Item(Long.parseLong(itemid)));
                            resaveorder.setPickedby(BigInteger.valueOf(foundf.get(0)));
                            resaveorder.setQtyapproved(BigInteger.valueOf(Long.parseLong(inputval)));
                            resaveorder.setQtyordered(BigInteger.valueOf(Long.parseLong(qtyordered)));
                            resaveorder.setServiced(Boolean.TRUE);
                            Object save = genericClassService.saveOrUpdateRecordLoadObject(resaveorder);
                        }
                    } catch (Exception ex) {
                        ex.printStackTrace();
                    }
                } else {
                    results = "THIS STAFF MEMBER DOES NOT BELONG TO THIS FACILITY UNIT ";
                }
            }

        } else {
            results = "THESE CREDENTIALS ARE NOT OF A SYSTEM USER";
        }

        return results;
    }

    @RequestMapping(value = "/orderitemlist.htm")
    @ResponseBody
    public String orderitemlist(HttpServletRequest request
    ) {
        String id = request.getParameter("id");
        String id1 = request.getParameter("id1");
        String results = "";
        List<Map> itemsonorder = new ArrayList<>();
        String[] params611 = {"facilityorderid", "pickedby"};
        Object[] paramsValues611 = {BigInteger.valueOf(Long.parseLong(id)), BigInteger.valueOf(Long.parseLong(id1))};
        String[] fields1 = {"itemid", "qtyapproved"};
        String wheref = "WHERE facilityorderid=:facilityorderid AND pickedby=:pickedby";
        List<Object[]> found611 = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, fields1, wheref, params611, paramsValues611);
        Map<String, Object> itemnames;
        if (found611 != null) {
            for (Object[] requnit : found611) {
                itemnames = new HashMap<>();
                String[] params2 = {"itemid"};
                Object[] paramsValues2 = {(Long) requnit[0]};
                String[] fields2 = {"genericname", "packsize", "itemid"};
                String where2 = "WHERE itemid=:itemid";
                List<Object[]> found2 = (List<Object[]>) genericClassService.fetchRecord(Item.class, fields2, where2, params2, paramsValues2);
                if (found2 != null) {
                    Object[] unit = found2.get(0);
                    itemnames.put("genericname", unit[0].toString());
                }
                itemsonorder.add(itemnames);
            }
        }
        try {
            results = new ObjectMapper().writeValueAsString(itemsonorder);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }

        return results;
    }
}
