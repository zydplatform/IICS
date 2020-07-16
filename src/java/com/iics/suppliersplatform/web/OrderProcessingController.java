/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.suppliersplatform.web;

import com.iics.domain.Facility;
import com.iics.domain.Facilityunit;
import com.iics.domain.Person;
import com.iics.service.GenericClassService;
import com.iics.store.Externalfacilityorders;
import com.iics.store.Facilityorder;
import com.iics.store.Facilityorderitems;
import com.iics.store.Item;
import com.iics.store.Itemcategorisation;
import com.iics.store.Supplier;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author samuelwam <samuelwam@gmail.com>
 */
@Controller
@RequestMapping("Supplier/Store")
public class OrderProcessingController {
    
    protected static Log logger = LogFactory.getLog("controller");
    @Autowired
    GenericClassService genericClassService;
    
    @RequestMapping(value = "/orderManagement", method = RequestMethod.GET)
    public String orderManagement(Model model, HttpServletRequest request) {
        try {
            long supplierid = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginSupplier").toString());
            int countNewOrders = genericClassService.fetchRecordCount(Externalfacilityorders.class, "WHERE r.supplierid=:Id AND r.orderstatus=:level AND r.isactive=:state", new String[]{"Id","level","state"}, new Object[]{supplierid,"APPROVED",true});
            model.addAttribute("countNewOrders", countNewOrders);
            model.addAttribute("countProcessingOrders", 0);
            model.addAttribute("countOrdersReady", 0);
            model.addAttribute("countDispatchedOrders", 0);
            model.addAttribute("countRejectedOrders", 0);
            
//            String[] params1 = {"Id","level","state"};
//            Object[] paramsValues1 = {supplierid,"APPROVED",true};
//            String[] fields1 = {"laboratoryrequestid", "laboratoryrequestnumber"};
//            String where1 = "r.supplierid=:Id AND r.orderstatus=:level AND r.isactive=:state";
//            List<Object[]> newOrdersArrList = (List<Object[]>) genericClassService.fetchRecord(Externalfacilityorders.class, fields1, where1, params1, paramsValues1);
//            if (newOrdersArrList != null) {
//                model.addAttribute("newOrdersArrList", newOrdersArrList);
//            } 
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "SupplierPlatform/Store/mainMenu";
    }
    
    /**
     *
     * @param principal
     * @return
     */
    @RequestMapping("/newOrdersManager.htm")
    @SuppressWarnings("CallToThreadDumpStack")
    public String newOrdersManager(HttpServletRequest request,
            @RequestParam("act") String activity, @RequestParam("i") long id, @RequestParam("d") long id2,
            @RequestParam("b") String strVal, @RequestParam("c") String strVal2,
            @RequestParam("ofst") int offset, @RequestParam("maxR") int maxResults,
            @RequestParam("sStr") String searchPhrase, Model model) {
        
        try {
            model.addAttribute("act", activity);
            model.addAttribute("b", strVal);
            model.addAttribute("i", id);
            model.addAttribute("c", strVal2);
            model.addAttribute("d", id2);
            model.addAttribute("ofst", offset);
            model.addAttribute("maxR", maxResults);
            model.addAttribute("sStr", searchPhrase);

            request.getSession().setAttribute("sessPagingOffSet", offset);
            request.getSession().setAttribute("sessPagingMaxResults", maxResults);
            request.getSession().setAttribute("vsearch", searchPhrase);

            String[] servicesFields = {"serviceid", "servicename", "description", "servicekey", "active", "released", "dateadded", "person.firstname", "person.lastname"};

            List<Externalfacilityorders> receiveOrderList = new ArrayList<Externalfacilityorders>();
            List<Object[]> receiveOrderListArr = new ArrayList<Object[]>();
            long supplierid = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginSupplier").toString());
            List<Map> ordersFound = new ArrayList<>();
            
            if (activity.equals("a")) {
                String[] params = {"Id","level","state"};
                Object[] paramsValues = {supplierid,"APPROVED",true};
                String where = "WHERE r.supplierid=:Id AND r.orderstatus=:level AND r.isactive=:state";
                String[] fields = {"externalfacilityordersid", "neworderno", "approvalstartdate", "approvalenddate", "orderingstart", "orderingenddate", "isactive", "supplierid", "facilityid", "dateapproved", "approvedby"};
                List<Object[]> orderArrList = (List<Object[]>) genericClassService.fetchRecord(Externalfacilityorders.class, fields, where, params, paramsValues);
//                logger.info("items :::------------------:::"+orderArrList.size());
                if (orderArrList != null && !orderArrList.isEmpty()) {
                    for (Object[] objexternalfacilityorders : orderArrList) {
                        Map<String, Object> externalfacilityorders;
                        externalfacilityorders = new HashMap<>();
                        externalfacilityorders.put("externalfacilityordersid", objexternalfacilityorders[0]);
                        externalfacilityorders.put("neworderno", objexternalfacilityorders[1]);
                        externalfacilityorders.put("approvalstartdate", new SimpleDateFormat("dd-MM-yyyy").format((Date) objexternalfacilityorders[2]));
                        externalfacilityorders.put("approvalenddate", new SimpleDateFormat("dd-MM-yyyy").format((Date) objexternalfacilityorders[3]));
                        externalfacilityorders.put("orderingstart", new SimpleDateFormat("dd-MM-yyyy").format((Date) objexternalfacilityorders[4]));
                        externalfacilityorders.put("orderingenddate", new SimpleDateFormat("dd-MM-yyyy").format((Date) objexternalfacilityorders[5]));
                        externalfacilityorders.put("isactive", orderArrList.get(0)[6]);
                        externalfacilityorders.put("datesent", objexternalfacilityorders[9]);
                        int emergencyCheck = genericClassService.fetchRecordCount(Facilityorder.class, "WHERE r.externalfacilityordersid=:Id AND r.isemergency=:state", new String[]{"Id","state"}, new Object[]{objexternalfacilityorders[0],true});
                        externalfacilityorders.put("emergencyCount", emergencyCheck);
                        int orderItemsCount = genericClassService.fetchRecordCount(Facilityorderitems.class, "WHERE r.facilityorderid IN (SELECT fo.facilityorderid FROM Facilityorder fo WHERE fo.externalfacilityordersid=:Id)", new String[]{"Id"}, new Object[]{objexternalfacilityorders[0]});                        
                        externalfacilityorders.put("numberofitems", orderItemsCount);
                        List<String> clientName = (List<String>) genericClassService.fetchRecord(Facility.class, new String[]{"facilityname"}, "WHERE r.facilityid=:Id", new String[]{"Id"}, new Object[]{orderArrList.get(0)[8]});
                        if (clientName != null) {
                            externalfacilityorders.put("facilityid", orderArrList.get(0)[8]);
                            externalfacilityorders.put("facilityname", clientName.get(0));
                        }
                        List<Object[]> objApprovedBy = (List<Object[]>) genericClassService.fetchRecord(Person.class, new String[]{"personid", "firstname", "lastname", "othernames"}, "WHERE personid=:personid", new String[]{"personid"}, new Object[]{orderArrList.get(0)[10]});
                        if (objApprovedBy.get(0) != null) {
                            externalfacilityorders.put("personname", objApprovedBy.get(0)[1]+" "+objApprovedBy.get(0)[2]);
                        }
                        SimpleDateFormat myFormat = new SimpleDateFormat("dd-MM-yyyy");
                        Date d1 = myFormat.parse(new SimpleDateFormat("dd-MM-yyyy").format((Date) objexternalfacilityorders[9]));
                        Date d2 = myFormat.parse(new SimpleDateFormat("dd-MM-yyyy").format(new Date()));
                        //in milliseconds
                        long diff = d2.getTime() - d1.getTime();
                        long diffDays = diff / (24 * 60 * 60 * 1000);
                        if(diffDays>0){
                            if(diffDays==1){
                                externalfacilityorders.put("waitingTime", diffDays+" Day");
                            }else{
                                externalfacilityorders.put("waitingTime", diffDays+" Days");
                            }
                        }else{
                            long diffHours = diff / (60 * 60 * 1000) % 24;
                            if(diffHours==1){
                                externalfacilityorders.put("waitingTime", diffHours+" hr");
                            }
                            if(diffHours>1){
                               externalfacilityorders.put("waitingTime", diffHours+" hrs");
                            }
                            if(diffHours==0){
                               long diffMinutes = diff / (60 * 1000) % 60;
                                if (diffMinutes == 1) {
                                    externalfacilityorders.put("waitingTime", diffMinutes + " min");
                                }
                                if (diffMinutes > 1) {
                                    externalfacilityorders.put("waitingTime", diffMinutes + " mins");
                                }
                                if (diffMinutes == 0) {
                                    long diffSeconds = diff / 1000 % 60;
                                    if (diffSeconds == 1) {
                                        externalfacilityorders.put("waitingTime", diffSeconds + " Sec");
                                    }
                                    if (diffSeconds > 1) {
                                        externalfacilityorders.put("waitingTime", diffSeconds + " Secs");
                                    }
                                }
                            }
                            
                        }
                        ordersFound.add(externalfacilityorders);
                        
                    }
                    model.addAttribute("emptyList", false);
                }else{
                    model.addAttribute("emptyList", true);
                }
                model.addAttribute("receivedOrders", ordersFound);
                return "SupplierPlatform/Store/NewOrders/orderVerification";
            }
            if (activity.equals("b")) {
                //Facility Details
                List<Object[]> facilityDetailsArr = (List<Object[]>) genericClassService.fetchRecord(Facility.class, new String[]{"facilityid", "facilityname", "facilitycode", "shortname", "phonecontact", "phonecontact2", "emailaddress", "facilitylevelid.facilitylevelname", 
                    "facilityownerid.ownername", "village.villagename", "village.parishid.subcountyid.countyid.countyname", "village.parishid.subcountyid.countyid.districtid.districtname", "village.parishid.subcountyid.countyid.districtid.regionid.regionname"}, "WHERE r.facilityid=:Id", new String[]{"Id"}, new Object[]{id});
                Map<String, Object> facilityDetails = new HashMap<>();
                if (facilityDetailsArr != null) {
                    facilityDetails.put("facilityid", facilityDetailsArr.get(0)[0]);
                    facilityDetails.put("facilityname", facilityDetailsArr.get(0)[1]);
                    facilityDetails.put("facilitycode", facilityDetailsArr.get(0)[2]);
                    facilityDetails.put("shortname", facilityDetailsArr.get(0)[3]);
                    facilityDetails.put("phonecontact", facilityDetailsArr.get(0)[4]);
                    facilityDetails.put("phonecontact2", facilityDetailsArr.get(0)[5]);
                    facilityDetails.put("emailaddress", facilityDetailsArr.get(0)[6]);
                    facilityDetails.put("levelname", facilityDetailsArr.get(0)[7]);
                    facilityDetails.put("ownername", facilityDetailsArr.get(0)[8]);
                    facilityDetails.put("villagename", facilityDetailsArr.get(0)[9]);
                    facilityDetails.put("countyname", facilityDetailsArr.get(0)[10]);
                    facilityDetails.put("districtname", facilityDetailsArr.get(0)[11]);
                    facilityDetails.put("regionname", facilityDetailsArr.get(0)[12]);
                }
                model.addAttribute("facilityDetails", facilityDetails);
                return "SupplierPlatform/Store/NewOrders/clientDetails";
            }
            if (activity.equals("c")) {
                //Facility Details
                List<Long> orderItems = new ArrayList<>();
                List<Long> addedItems = new ArrayList<>();
                List<Map> itemsCatList = new ArrayList<>();
                 List<Map> itemsList = new ArrayList<>();
                List<Object[]> orderItemsArr = (List<Object[]>) genericClassService.fetchRecord(Facilityorderitems.class, new String[]{"facilityorderitemsid", "itemid.itemid", "qtyordered", "qtyapproved"}, "WHERE r.facilityorderid IN (SELECT fo.facilityorderid FROM Facilityorder fo WHERE fo.externalfacilityordersid=:Id)", new String[]{"Id"}, new Object[]{id});
                if (orderItemsArr.get(0) != null) {
                    logger.info("Item Order List :::SIZE:::"+orderItemsArr.size());
                    for (Object[] items : orderItemsArr) {
                        orderItems.add((Long)items[1]);
                        List<Object[]> itemsObjArr = (List<Object[]>) genericClassService.fetchRecord(Item.class, new String[]{"itemid", "itemcode", "genericname", "packsize", "unitcost", "itemstrength"}, "WHERE r.itemid=:Id", new String[]{"Id"}, new Object[]{(Long)items[1]});
                        Map<String, Object> itemsDetails = new HashMap<>();
                            itemsDetails.put("itemid", itemsObjArr.get(0)[0]);
                            itemsDetails.put("itemcode", itemsObjArr.get(0)[1]);
                            itemsDetails.put("genericname", itemsObjArr.get(0)[2]);
                            itemsDetails.put("packsize", itemsObjArr.get(0)[3]);
                            itemsDetails.put("unitcost", itemsObjArr.get(0)[4]);
                            itemsDetails.put("itemstrength", itemsObjArr.get(0)[5]);
                            logger.info("**********Found Match**************");
                            itemsDetails.put("orderitemid", items[0]);
                            itemsDetails.put("qtyordered", items[2]);
                            itemsDetails.put("qtyapproved", items[3]);
                            itemsList.add(itemsDetails);
                    }
                }
                
                List<Object[]> itemsArr = (List<Object[]>) genericClassService.fetchRecord(Itemcategorisation.class, new String[]{"itemid.itemid", "itemid.itemcode", "itemid.genericname", "itemid.packsize", "itemid.unitcost", "itemid.itemstrength", "itemcategoryid.categoryname", "itemcategoryid.itemclassificationid.classificationname"}, "WHERE r.itemid.itemid IN (SELECT foi.itemid FROM Facilityorderitems foi WHERE foi.facilityorderid IN (SELECT fo.facilityorderid FROM Facilityorder fo WHERE fo.externalfacilityordersid=:Id)) ORDER BY r.itemcategoryid.itemclassificationid.classificationname, r.itemcategoryid.categoryname, r.itemid.genericname ASC", new String[]{"Id"}, new Object[]{id});
                if (itemsArr.get(0) != null) {
                    logger.info("Cat Item Order List :::SIZE:::"+orderItemsArr.size());
                    for (Object[] item : itemsArr) {
                        Map<String, Object> itemsDetails = new HashMap<>();
                        itemsDetails.put("itemid", item[0]);
                        itemsDetails.put("itemcode", item[1]);
                        itemsDetails.put("genericname", item[2]);
                        itemsDetails.put("packsize", item[3]);
                        itemsDetails.put("unitcost", item[4]);
                        itemsDetails.put("itemstrength", item[5]);
                        itemsDetails.put("categoryname", item[6]);
                        itemsDetails.put("classificationname", item[7]);
                        for (Object[] orderedItem : orderItemsArr) {
                            logger.info("Order Has Item ID:"+orderedItem[1]+" Matches Catalogue:"+item[0]+" Condition::::"+(orderedItem[1].equals(item[0])));
                            if(orderedItem[1].equals(item[0])){
                                logger.info("**********Found Match**************");
                                itemsDetails.put("orderitemid", orderedItem[0]);
                                itemsDetails.put("qtyordered", orderedItem[2]);
                                itemsDetails.put("qtyapproved", orderedItem[3]);
                            }
                        }
                        addedItems.add((Long)item[1]);
                        itemsCatList.add(itemsDetails);
                    }
                }
                
                model.addAttribute("itemsList", itemsList);
                model.addAttribute("orderItemsList", itemsCatList);
                return "SupplierPlatform/Store/NewOrders/itemDetails";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        model.addAttribute("success", "<span class='text6'>Contact System Administrator :: Page Not Found!</span>");
        return "SupplierPlatform/errorPage";
    }
    
}
