/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.controlpanel.Stafffacilityunit;
import com.iics.domain.Searchstaff;
import com.iics.domain.Systemuser;
import com.iics.service.GenericClassService;
import com.iics.store.Cellitems;
import com.iics.store.Facilityunitstock;
import com.iics.store.Itemcategories;
import com.iics.store.Itempackage;
import com.iics.store.Shelfstock;
import com.iics.store.Suppliesorder;
import com.iics.store.Suppliesorderitems;
import java.io.IOException;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.iics.store.Stock;
import com.iics.store.Suppliesissuance;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;
import java.util.Set;
import com.iics.utils.ShelfActivityLog;
import com.iics.utils.StockActivityLog;

/**
 *
 * @author HP
 */
@Controller
@RequestMapping("/sandriesreq")
public class SuppliesRequisitions {

    @Autowired
    GenericClassService genericClassService;
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat formatter2 = new SimpleDateFormat("dd-MM-yyyy");

    @RequestMapping(value = "/suppliesRequisitionsHome", method = RequestMethod.GET)
    public String suppliesRequisitions(HttpServletRequest request, Model model) {
        List<Map> unitStaffList = new ArrayList<>();

        String[] paramsUnitStaff = {"facilityunitid", "active"};
        Object[] paramsValuesUnitStaff = {Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))), true};
        String[] fields5UnitStaff = {"stafffacilityunitid", "staffid"};
        String whereUnitStaff = "WHERE facilityunitid=:facilityunitid AND active=:active";
        List<Object[]> objUnitStaff = (List<Object[]>) genericClassService.fetchRecord(Stafffacilityunit.class, fields5UnitStaff, whereUnitStaff, paramsUnitStaff, paramsValuesUnitStaff);
        if (objUnitStaff != null) {
            Map<String, Object> stafflist;
            for (Object[] staff : objUnitStaff) {

                stafflist = new HashMap<>();
                stafflist.put("staffid", staff[1]);
                String[] paramsUnitStaffDetails = {"staffid"};
                Object[] paramsValuesUnitSDetails = {staff[1]};
                String[] fields5UnitDetails = {"firstname", "lastname", "othernames"};
                List<Object[]> objUnitDetails = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields5UnitDetails, "WHERE staffid=:staffid", paramsUnitStaffDetails, paramsValuesUnitSDetails);
                if (objUnitDetails != null) {
                    Object[] per = objUnitDetails.get(0);
                    if (per[2] != null) {
                        stafflist.put("staffname", per[0] + " " + per[1] + " " + per[2]);
                    } else {
                        stafflist.put("staffname", per[0] + " " + per[1]);
                    }
                }
                unitStaffList.add(stafflist);
            }
        }

        Long currStaffId = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
        String[] paramsPersondetailsactivestaff = {"staffid"};
        Object[] paramsValuesPersonctivestaff = {BigInteger.valueOf(currStaffId)};
        String[] fieldsPersonctivestaff = {"personid", "firstname", "lastname", "othernames"};
        String wherectivestaff = "WHERE staffid=:staffid";
        List<Object[]> objctivestaff = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fieldsPersonctivestaff, wherectivestaff, paramsPersondetailsactivestaff, paramsValuesPersonctivestaff);
        if (objctivestaff != null) {
            Object[] personactivestaff = objctivestaff.get(0);
            if (personactivestaff[3] != null) {
                model.addAttribute("activestaff", (String) personactivestaff[1] + " " + (String) personactivestaff[2] + " " + (String) personactivestaff[3]);
            } else {
                model.addAttribute("activestaff", (String) personactivestaff[1] + " " + (String) personactivestaff[2]);
            }
        }
        
        //NO OF APPROVED
        int noOfApprovedOrders = 0;
        String[] paramsfacilityunitordersApproved = {"facilityunitid", "status"};
        Object[] paramsValuestodayApproved = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), "SENT"};
        String[] fieldsunitApproved = {"suppliesorderid"};
        String whereunitApproved = "WHERE facilityunitid=:facilityunitid AND status=:status";
        List<Long> objunitApproved = (List<Long>) genericClassService.fetchRecord(Suppliesorder.class, fieldsunitApproved, whereunitApproved, paramsfacilityunitordersApproved, paramsValuestodayApproved);
        if (objunitApproved != null) {
            for (Long todayApproved : objunitApproved) {
                try {
                    String[] paramsfacilitynuitordersitems = {"suppliesorderid"};
                    Object[] paramsValuestodayitems = {BigInteger.valueOf(todayApproved)};
                    String[] fieldsunititems = {"suppliesorderitemsid"};
                    String whereunititems = "WHERE suppliesorderid=:suppliesorderid ORDER BY suppliesorderitemsid LIMIT 1";
                    List<Long> objunititems = (List<Long>) genericClassService.fetchRecord(Suppliesorderitems.class, fieldsunititems, whereunititems, paramsfacilitynuitordersitems, paramsValuestodayitems);
                    if (objunititems != null) {
                        noOfApprovedOrders = noOfApprovedOrders + 1;
                    }
                } catch (Exception ex) {
                    System.out.println(ex);
                }
            }
        }
        
        //NO OF SERVICED
         int noOfReadyToIssueOrders = 0;
        String[] paramsfacilityunitReadyToIssue = {"facilityunitid", "status"};
        Object[] paramsValuesReadyToIssue = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), "APPROVED"};
        String[] fieldsunitReadyToIssue = {"suppliesorderid"};
        String whereunitReadyToIssue = "WHERE facilityunitid=:facilityunitid AND status=:status";
        List<Long> objunitReadyToIssue = (List<Long>) genericClassService.fetchRecord(Suppliesorder.class, fieldsunitReadyToIssue, whereunitReadyToIssue, paramsfacilityunitReadyToIssue, paramsValuesReadyToIssue);
        if (objunitReadyToIssue != null) {
            for (Long UnitReadyToIssue : objunitReadyToIssue) {
                try {
                    String[] paramsfacilitynuitordersitemsiss = {"suppliesorderid", "isapproved"};
                    Object[] paramsValuestodayitemsiss = {BigInteger.valueOf(UnitReadyToIssue), true};
                    String[] fieldsunititemsiss = {"suppliesorderitemsid"};
                    String whereunititemsiss = "WHERE suppliesorderid=:suppliesorderid AND isapproved=:isapproved ORDER BY suppliesorderitemsid LIMIT 1";
                    List<Long> objunititemsiss = (List<Long>) genericClassService.fetchRecord(Suppliesorderitems.class, fieldsunititemsiss, whereunititemsiss, paramsfacilitynuitordersitemsiss, paramsValuestodayitemsiss);
                    if (objunititemsiss != null) {
                        noOfReadyToIssueOrders = noOfReadyToIssueOrders + 1;
                    }
                } catch (Exception ex) {
                    System.out.println(ex);
                }
            }
        }

        model.addAttribute("noOfApprovedOrders", noOfApprovedOrders);
        model.addAttribute("noOfReadyToIssueOrders", noOfReadyToIssueOrders);
        model.addAttribute("ordernumber", generatesuppliesorderno(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")), BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))))));
        model.addAttribute("unitStaffList", unitStaffList);
        return "inventoryAndSupplies/placeSuppliesRequisitions/placeSuppliesRequisitionPane";
    }

    @RequestMapping(value = "/itemPackageList", method = RequestMethod.POST)
    public @ResponseBody
    String itemPackageList(HttpServletRequest request, Model model) {
        List<Map> itemsPackageList = new ArrayList<>();
        String results = "";
        try {
            String[] params = {"issupplies"};
            Object[] paramsValues = {true};
            String[] fields = {"itemid", "fullname"};
            String where = "WHERE issupplies=:issupplies";
            List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Itemcategories.class, fields, where, params, paramsValues);
            if (items != null) {
                Map<String, Object> itemsRow;
                for (Object[] item : items) {
                    itemsRow = new HashMap<>();
                    itemsRow.put("itemid", item[0]);
                    itemsRow.put("fullname", item[1]);
                    itemsPackageList.add(itemsRow);
                }
            }
            results = new ObjectMapper().writeValueAsString(itemsPackageList);
        } catch (Exception e) {
            System.out.println("::::::::::::::::::::::::::::::::" + e);
        }
        return results;
    }

    @RequestMapping(value = "/searchItemPackageList.htm", method = RequestMethod.GET)
    public String searchItemPackageList(Model model, HttpServletRequest request) {

        List<Map> itemsFound = new ArrayList<>();
        try {
            String[] paramsitems = {"value", "name", "isactive", "issupplies"};
            Object[] paramsValuesitems = {request.getParameter("searchValue").trim().toLowerCase() + "%", "%" + request.getParameter("searchValue").trim().toLowerCase() + "%", true, true};
            String[] fieldsitems = {"itempackageid", "packagename", "categoryname"};
            String whereitems = "WHERE isactive=:isactive AND issupplies=:issupplies AND (LOWER(packagename) LIKE :value OR LOWER(packagename) LIKE :name) ORDER BY packagename";
            List<Object[]> objItems = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fieldsitems, whereitems, paramsitems, paramsValuesitems);
            if (objItems != null) {
                Map<String, Object> itemsvals;
                for (Object[] orderItem : objItems) {
                    itemsvals = new HashMap<>();
                    itemsvals.put("itemid", orderItem[0]);
                    itemsvals.put("packagename", orderItem[1]);
                    itemsvals.put("categoryname", orderItem[2]);
                    itemsFound.add(itemsvals);
                }
            }
        } catch (Exception e) {
            System.out.println(":::::::::::::::::::" + e);
        }

        model.addAttribute("itemsFound", itemsFound);
        model.addAttribute("searchValue", request.getParameter("searchValue"));
        return "inventoryAndSupplies/placeSuppliesRequisitions/views/itemSearchResults";
    }

    @RequestMapping(value = "/saveUnitSupplyRequistion.htm")
    public @ResponseBody
    String saveUnitSupplyRequistion(HttpServletRequest request) {
        String results = "";
        try {
            Suppliesorder suppliesorder = new Suppliesorder();
            Long currStaffId = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
            String requester = request.getParameter("requester");
            
            suppliesorder.setRequestedby(BigInteger.valueOf(Long.parseLong(requester)));
            suppliesorder.setFacilityunitid(BigInteger.valueOf(((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")).longValue()));
            suppliesorder.setDaterequested(new Date());
            suppliesorder.setOrderno(request.getParameter("ordernumber"));
            suppliesorder.setIsemergency(false);
            suppliesorder.setStatus("SENT");
            suppliesorder.setAddedby(BigInteger.valueOf(currStaffId));

            suppliesorder = (Suppliesorder) genericClassService.saveOrUpdateRecordLoadObject(suppliesorder);
            if (suppliesorder.getSuppliesorderid() != null) {
                List<Map> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("values"), List.class);
                for (Map item1 : item) {
                    Map<String, Object> map = (HashMap) item1;
                    Suppliesorderitems suppliesorderitems = new Suppliesorderitems();
                    suppliesorderitems.setSuppliesorderid(BigInteger.valueOf(suppliesorder.getSuppliesorderid()));
                    suppliesorderitems.setItemid(BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) map.get("itemid")))));
                    suppliesorderitems.setQtyordered(Integer.parseInt((String) map.get("qty")));
                    genericClassService.saveOrUpdateRecordLoadObject(suppliesorderitems);
                }
            }
        } catch (IOException e) {
            System.out.println(e);
        }
        return results;
    }

    @RequestMapping(value = "/approveRequistionTab.htm", method = RequestMethod.GET)
    public String approveRequistionTab(Model model, HttpServletRequest request) {

        List<Map> sentOrdersList = new ArrayList<>();
        String[] paramsreqorder = {"facilityunitid", "status"};
        Object[] paramsValuesreqorder = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), "SENT"};
        String[] fieldsunitreqorder = {"suppliesorderid", "orderno", "isemergency", "requestedby", "daterequested"};
        String whereunitreqorder = "WHERE facilityunitid=:facilityunitid AND status=:status";
        List<Object[]> objunitreqorder = (List<Object[]>) genericClassService.fetchRecord(Suppliesorder.class, fieldsunitreqorder, whereunitreqorder, paramsreqorder, paramsValuesreqorder);
        Map<String, Object> unitreqorder;
        if (objunitreqorder != null) {
            for (Object[] ord : objunitreqorder) {
                unitreqorder = new HashMap<>();

                //Fetch Order Items number
                Integer noOfItems3 = 0;
                String[] paramsnumberofitems = {"suppliesorderid"};
                Object[] paramsValuesnumberofitems = {ord[0]};
                String wherenumberofitems = "WHERE suppliesorderid=:suppliesorderid";
                noOfItems3 = genericClassService.fetchRecordCount(Suppliesorderitems.class, wherenumberofitems, paramsnumberofitems, paramsValuesnumberofitems);

                if (!noOfItems3.equals(0)) {
                    unitreqorder.put("numberofitems", noOfItems3);

                    unitreqorder.put("daterequested", formatter2.format((Date) ord[4]));
                    unitreqorder.put("suppliesorderid", ord[0]);
                    unitreqorder.put("orderno", (String) ord[1]);
                    if ((Boolean) ord[2].equals(true)) {
                        unitreqorder.put("isemergency", "true");
                    } else {
                        unitreqorder.put("isemergency", "false");
                    }

                    String[] paramsPersondetailsDeliver2 = {"staffid"};
                    Object[] paramsValuesPersondetailsDeliver2 = {ord[3]};
                    String[] fieldsPersondetailsDeliver2 = {"personid", "firstname", "lastname", "othernames"};
                    String wherePersondetailsDeliver2 = "WHERE staffid=:staffid";
                    List<Object[]> objPersondetailsDeliver2 = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fieldsPersondetailsDeliver2, wherePersondetailsDeliver2, paramsPersondetailsDeliver2, paramsValuesPersondetailsDeliver2);
                    if (objPersondetailsDeliver2 != null) {
                        Object[] persondetailsDeliver2 = objPersondetailsDeliver2.get(0);
                        if (persondetailsDeliver2[3] != null) {
                            unitreqorder.put("requester", (String) persondetailsDeliver2[1] + " " + (String) persondetailsDeliver2[2] + " " + (String) persondetailsDeliver2[3]);
                        } else {
                            unitreqorder.put("requester", (String) persondetailsDeliver2[1] + " " + (String) persondetailsDeliver2[2]);
                        }
                    }
                    sentOrdersList.add(unitreqorder);
                }
            }
        }
        model.addAttribute("sentOrdersList", sentOrdersList);
        return "inventoryAndSupplies/placeSuppliesRequisitions/views/approveRequisition";
    }

    @RequestMapping(value = "/viewRequisitionItems.htm", method = RequestMethod.GET)
    public String viewRequisitionItems(Model model, HttpServletRequest request, @ModelAttribute("suppliesorderid") String suppliesorderid) {
        List<Map> orderItemsList = new ArrayList<>();

        String[] paramorderItems = {"suppliesorderid"};
        Object[] paramsValuesorderItems = {Long.parseLong(suppliesorderid)};
        String[] fieldsorderItems = {"suppliesorderitemsid", "itemid", "qtyordered"};
        String whereorderItems = "WHERE suppliesorderid=:suppliesorderid";
        List<Object[]> objOrderItems4 = (List<Object[]>) genericClassService.fetchRecord(Suppliesorderitems.class, fieldsorderItems, whereorderItems, paramorderItems, paramsValuesorderItems);
        Map<String, Object> items;
        if (objOrderItems4 != null) {
            for (Object[] itm : objOrderItems4) {
                items = new HashMap<>();
                String[] paramsitemname = {"itempackageid"};
                Object[] paramsValuesitemname = {itm[1]};
                String whereitemname = "WHERE itempackageid=:itempackageid";
                String[] fieldsitemname = {"itempackageid", "packagename"};
                List<Object[]> objitemname = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fieldsitemname, whereitemname, paramsitemname, paramsValuesitemname);
                if (objitemname != null) {
                    for (Object[] name : objitemname) {
                        items.put("genericname", (String) name[1]);
                        items.put("qtyordered", (Integer) itm[2]);
                    }
                    orderItemsList.add(items);
                }
            }
        }
        model.addAttribute("orderItemsList", orderItemsList);
        return "inventoryAndSupplies/placeSuppliesRequisitions/views/viewRequestedItems";
    }

    @RequestMapping(value = "/manageServicedOrders.htm", method = RequestMethod.GET)
    public String manageServicedOrders(Model model, HttpServletRequest request, @ModelAttribute("suppliesorderid") String suppliesorderid) {
        List<Map> orderItemsList = new ArrayList<>();

        String[] paramorderItems = {"suppliesorderid", "isissued"};
        Object[] paramsValuesorderItems = {Long.parseLong(suppliesorderid), true};
        String[] fieldsorderItems = {"suppliesorderitemsid", "itemid", "qtyordered", "qtyapproved"};
        String whereorderItems = "WHERE suppliesorderid=:suppliesorderid AND isissued=:isissued";
        List<Object[]> objOrderItems4 = (List<Object[]>) genericClassService.fetchRecord(Suppliesorderitems.class, fieldsorderItems, whereorderItems, paramorderItems, paramsValuesorderItems);
        Map<String, Object> items;
        if (objOrderItems4 != null) {
            for (Object[] itm : objOrderItems4) {
                items = new HashMap<>();
                String[] paramsitemname = {"itempackageid"};
                Object[] paramsValuesitemname = {itm[1]};
                String whereitemname = "WHERE itempackageid=:itempackageid";
                String[] fieldsitemname = {"itempackageid", "packagename"};
                List<Object[]> objitemname = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fieldsitemname, whereitemname, paramsitemname, paramsValuesitemname);
                if (objitemname != null) {
                    for (Object[] name : objitemname) {
                        items.put("genericname", (String) name[1]);
                        items.put("qtyordered", (Integer) itm[2]);
                        items.put("qtyapproved", (Integer) itm[3]);
                    }
                    orderItemsList.add(items);
                }
            }
        }
        model.addAttribute("orderItemsList", orderItemsList);
        return "inventoryAndSupplies/placeSuppliesRequisitions/views/viewRequestedItemsIssued";
    }

    @RequestMapping(value = "/viewRequisitionItemsApproved.htm", method = RequestMethod.GET)
    public String viewRequisitionItemsApproved(Model model, HttpServletRequest request, @ModelAttribute("suppliesorderid") String suppliesorderid) {
        List<Map> orderItemsList = new ArrayList<>();

        String[] paramorderItems2 = {"suppliesorderid", "isapproved"};
        Object[] paramsValuesorderItems2 = {Long.parseLong(suppliesorderid), true};
        String[] fieldsorderItems2 = {"suppliesorderitemsid", "itemid", "qtyordered", "qtyapproved"};
        String whereorderItems2 = "WHERE suppliesorderid=:suppliesorderid AND isapproved=:isapproved";
        List<Object[]> objOrderItems22 = (List<Object[]>) genericClassService.fetchRecord(Suppliesorderitems.class, fieldsorderItems2, whereorderItems2, paramorderItems2, paramsValuesorderItems2);
        Map<String, Object> items2;
        if (objOrderItems22 != null) {
            for (Object[] itm : objOrderItems22) {
                items2 = new HashMap<>();
                String[] paramsitemname = {"itempackageid"};
                Object[] paramsValuesitemname = {itm[1]};
                String whereitemname = "WHERE itempackageid=:itempackageid";
                String[] fieldsitemname = {"itempackageid", "packagename"};
                List<Object[]> objitemname = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fieldsitemname, whereitemname, paramsitemname, paramsValuesitemname);
                if (objitemname != null) {
                    for (Object[] name : objitemname) {
                        items2.put("genericname", (String) name[1]);
                        items2.put("qtyordered", (Integer) itm[2]);
                        items2.put("qtyapproved", (Integer) itm[3]);
                    }
                    orderItemsList.add(items2);
                }
            }
        }
        model.addAttribute("orderItemsList", orderItemsList);
        return "inventoryAndSupplies/placeSuppliesRequisitions/views/viewRequestedItemsApproved";
    }

    @RequestMapping(value = "/suppliesRequestItemApproval.htm", method = RequestMethod.GET)
    public String suppliesRequestItemApproval(Model model, HttpServletRequest request, @ModelAttribute("suppliesorderid") String suppliesorderid) {
        List<Map> orderItemsList = new ArrayList<>();

        //Fetch items in a new ORDER FOR PROCESSING
        String[] paramorderItems = {"suppliesorderid"};
        Object[] paramsValuesorderItems = {Long.parseLong(suppliesorderid)};
        String[] fieldsorderItems = {"suppliesorderitemsid", "qtyordered", "suppliesorderid", "itemid"};
        String whereorderItems = "WHERE suppliesorderid=:suppliesorderid";
        List<Object[]> objOrderItems = (List<Object[]>) genericClassService.fetchRecord(Suppliesorderitems.class, fieldsorderItems, whereorderItems, paramorderItems, paramsValuesorderItems);
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
                        items.put("qtyordered", itm[1]);
                        items.put("itemcode", (String) name[1]);
                        items.put("genericname", (String) name[2]);
                    }
                }
                int transactionalstock = 0;
                long unshelved = 0;

                items.put("suppliesorderitemsid", itm[0]);
                String[] paramsCellitem = {"itemid", "facilityunitid"};
                Object[] paramsValuesCellitem = {itm[3], Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))};
                String whereCellitem = "WHERE itemid=:itemid AND facilityunitid=:facilityunitid";
                String[] fieldsCellitem = {"celllabel", "daystoexpire", "quantityshelved", "packsize"};
                List<Object[]> objCellitem = (List<Object[]>) genericClassService.fetchRecord(Cellitems.class, fieldsCellitem, whereCellitem, paramsCellitem, paramsValuesCellitem);
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

                items.put("transactionalStock", transactionalstock);
                items.put("transactionalStocknocommas", (transactionalstock));
                items.put("itemid", itm[3]);
                orderItemsList.add(items);
            }
        }
        model.addAttribute("orderItemsList", orderItemsList);
        model.addAttribute("orderItemsListsize", orderItemsList.size());
        model.addAttribute("suppliesorderid", suppliesorderid);
        return "inventoryAndSupplies/placeSuppliesRequisitions/views/suppliesRequestedItems";
    }

    @RequestMapping(value = "/savesuppliyApprovedOrders.htm", method = RequestMethod.GET)
    public @ResponseBody
    String savesuppliyApprovedOrders(Model model, HttpServletRequest request, @ModelAttribute("suppliesorderid") String suppliesorderid) throws IOException {
        Long currStaffId = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");

        try {
            List<Map> itemorderqty = (ArrayList) new ObjectMapper().readValue(request.getParameter("qtyorderedvalues"), List.class);
            for (Map itemone : itemorderqty) {
                long suppliesorderitemsid = Long.parseLong((String) itemone.get("name"));
                if (itemone.get("value") != "") {
                    if (!itemone.get("value").equals(0)) {
                        int quantityapproved = Integer.parseInt((String) itemone.get("value"));

                        String[] columns = {"isapproved", "qtyapproved"};
                        Object[] columnValues = {true, quantityapproved};
                        String pk = "suppliesorderitemsid";
                        Object pkValue = suppliesorderitemsid;
                        if (quantityapproved != 0) {
                            genericClassService.updateRecordSQLSchemaStyle(Suppliesorderitems.class, columns, columnValues, pk, pkValue, "store");
                        }
                    }
                }
            }
        } catch (Exception ex) {
            System.out.println(ex);
        }

        try {
            String[] columns = {"status", "approvedby", "dateapproved"};
            Object[] columnValues = {"APPROVED", BigInteger.valueOf(currStaffId), new Date()};
            String pk = "suppliesorderid";
            Object pkValue = Long.parseLong(suppliesorderid);
            genericClassService.updateRecordSQLSchemaStyle(Suppliesorder.class, columns, columnValues, pk, pkValue, "store");
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return "";
    }

    @RequestMapping(value = "/issueOutRequests.htm", method = RequestMethod.GET)
    public String issueOutRequests(Model model, HttpServletRequest request) {

        List<Map> readyToIssueList = new ArrayList<>();
        String[] paramsreqorder = {"facilityunitid", "status"};
        Object[] paramsValuesreqorder = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), "APPROVED"};
        String[] fieldsunitreqorder = {"suppliesorderid", "orderno", "approvedby", "dateapproved", "daterequested"};
        String whereunitreqorder = "WHERE facilityunitid=:facilityunitid AND status=:status";
        List<Object[]> objunitreqorder = (List<Object[]>) genericClassService.fetchRecord(Suppliesorder.class, fieldsunitreqorder, whereunitreqorder, paramsreqorder, paramsValuesreqorder);
        Map<String, Object> unitreqorder;
        if (objunitreqorder != null) {
            for (Object[] ord : objunitreqorder) {

                unitreqorder = new HashMap<>();

                //Fetch Order Items number
                Integer noOfItems3 = 0;
                String[] paramsnumberofitems = {"suppliesorderid", "isapproved"};
                Object[] paramsValuesnumberofitems = {ord[0], true};
                String wherenumberofitems = "WHERE suppliesorderid=:suppliesorderid AND isapproved=:isapproved";
                noOfItems3 = genericClassService.fetchRecordCount(Suppliesorderitems.class, wherenumberofitems, paramsnumberofitems, paramsValuesnumberofitems);

                if (!noOfItems3.equals(0)) {
                    unitreqorder.put("daterequested", formatter2.format((Date) ord[4]));
                    unitreqorder.put("dateapproved", formatter2.format((Date) ord[3]));
                    unitreqorder.put("suppliesorderid", ord[0]);
                    unitreqorder.put("orderno", (String) ord[1]);

                    unitreqorder.put("numberofitems", noOfItems3);

                    String[] paramsPersondetailsDeliver2 = {"staffid"};
                    Object[] paramsValuesPersondetailsDeliver2 = {ord[2]};
                    String[] fieldsPersondetailsDeliver2 = {"personid", "firstname", "lastname", "othernames"};
                    String wherePersondetailsDeliver2 = "WHERE staffid=:staffid";
                    List<Object[]> objPersondetailsDeliver2 = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fieldsPersondetailsDeliver2, wherePersondetailsDeliver2, paramsPersondetailsDeliver2, paramsValuesPersondetailsDeliver2);
                    if (objPersondetailsDeliver2 != null) {
                        Object[] persondetailsDeliver2 = objPersondetailsDeliver2.get(0);
                        if (persondetailsDeliver2[3] != null) {
                            unitreqorder.put("approvedby", (String) persondetailsDeliver2[1] + " " + (String) persondetailsDeliver2[2] + " " + (String) persondetailsDeliver2[3]);
                        } else {
                            unitreqorder.put("approvedby", (String) persondetailsDeliver2[1] + " " + (String) persondetailsDeliver2[2]);
                        }
                    }
                    readyToIssueList.add(unitreqorder);
                }
            }
        }
        model.addAttribute("readyToIssueList", readyToIssueList);
        return "inventoryAndSupplies/placeSuppliesRequisitions/views/issueOutRequisitions";
    }

    @RequestMapping(value = "/suppliesRequesitionHandOverItems.htm", method = RequestMethod.GET)
    public String suppliesRequesitionHandOverItems(Model model, HttpServletRequest request, @ModelAttribute("suppliesorderid") String suppliesorderid) {
        List<Map> qtylist = new ArrayList<>();
        int picklisttablesize = 0;
        List<Map> picklist = new ArrayList<>();
        String[] paramqtyApproved = {"suppliesorderid", "isapproved"};
        Object[] paramsValuesqtyApproved = {Long.parseLong(suppliesorderid), true};
        String[] fieldsqtyApproved = {"qtyapproved", "itemid", "suppliesorderitemsid"};
        String whereqtyApproved = "WHERE suppliesorderid=:suppliesorderid AND isapproved=:isapproved";
        List<Object[]> objOrderqtyApproved = (List<Object[]>) genericClassService.fetchRecord(Suppliesorderitems.class, fieldsqtyApproved, whereqtyApproved, paramqtyApproved, paramsValuesqtyApproved);
        Map<String, Object> item;
        Map<String, Object> picklistqtys;
        if (objOrderqtyApproved != null) {
            for (Object[] itemQtysApproved : objOrderqtyApproved) {
                item = new HashMap<>();
                item.put("suppliesorderitemsid", itemQtysApproved[2]);
                String[] paramitem = {"itempackageid"};
                Object[] paramsValueitem = {itemQtysApproved[1]};
                String whereitem = "WHERE itempackageid=:itempackageid";
                String[] fieldsitem = {"itemid", "packagename"};
                List<Object[]> objItem = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fieldsitem, whereitem, paramitem, paramsValueitem);
                if (objItem != null) {
                    Object[] itemdetails = objItem.get(0);
                    item.put("genericname", (String) itemdetails[1]);
                }
                BigInteger suppItemId = (BigInteger) itemQtysApproved[1];

                List<Map> itemLocation = getSuppliesItemslocations(suppItemId.longValue(), Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))));
                List<Map> itemPickList = generateSuppliesPickList(itemLocation, (Integer) itemQtysApproved[0]);
                item.put("itemid", itemQtysApproved[1]);
                Collections.sort(itemPickList, sortCells010);

                for (Map itemsstockdetails : itemPickList) {
                    picklistqtys = new HashMap<>();
                    picklistqtys.put("suppliesorderitemsid", itemQtysApproved[2]);
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

        model.addAttribute("picklisttablesize", picklisttablesize);
        model.addAttribute("suppliesorderid", suppliesorderid);
        model.addAttribute("items", qtylist);
        model.addAttribute("jsonqtypicklist", jsonqtypicklist);
        return "inventoryAndSupplies/placeSuppliesRequisitions/views/handOverSupplies";
    }

    @RequestMapping(value = "/submitSuppliesRequisition.htm", method = RequestMethod.GET)
    public @ResponseBody
    String submitSuppliesRequisition(Model model, HttpServletRequest request, @ModelAttribute("suppliesorderid") String suppliesorderid) throws IOException {

        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null && request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {

            String result = "";
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            long currUnit = Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")));

            String[] paramsysuser = {"username", "password"};
            Object[] paramsValuessysuser = {username, password};
            String[] fieldssysuser = {"systemuserid", "personid.personid", "active"};
            String wheresysuser = "WHERE username=:username AND password=:password";
            List<Object[]> objsysuser = (List<Object[]>) genericClassService.fetchRecord(Systemuser.class, fieldssysuser, wheresysuser, paramsysuser, paramsValuessysuser);
            if (objsysuser != null) {
                Object[] itemdetails = objsysuser.get(0);
                for (Object[] systemuser : objsysuser) {
                    String[] parampersn = {"personid"};
                    Object[] paramsValuepersn = {systemuser[1]};
                    String wherepersn = "WHERE personid=:personid";
                    String[] fieldspersn = {"staffid", "personid"};
                    List<Object[]> objpersn = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fieldspersn, wherepersn, parampersn, paramsValuepersn);
                    if (objpersn != null) {
                        Object[] person2 = objpersn.get(0);

                        String[] paramstafffacilityunit = {"staffid"};
                        Object[] paramsValuestafffacilityunit = {person2[0]};
                        String wherestafffacilityunit = "WHERE staffid=:staffid";
                        String[] fieldsstafffacilityunit = {"stafffacilityunitid", "facilityunitid"};
                        List<Object[]> objstafffacilityunit = (List<Object[]>) genericClassService.fetchRecord(Stafffacilityunit.class, fieldsstafffacilityunit, wherestafffacilityunit, paramstafffacilityunit, paramsValuestafffacilityunit);

                        if (objstafffacilityunit != null) {
                            for (Object[] stafffacilityunit : objstafffacilityunit) {
                                if (currUnit == (Long) stafffacilityunit[1]) {
                                    BigInteger issuedto = (BigInteger) person2[0];

                                    /*---------------------------------------*/
                                    Set<Long> suppliesorderitemsset = new HashSet<>();
                                    List<Map> stockList = new ArrayList<>();
                                    Long currStaffId = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
                                    List<Map> itemorderqty = (ArrayList) new ObjectMapper().readValue(request.getParameter("qtyissuedvalues"), List.class);
                                    for (Map picked : itemorderqty) {

                                        int qtyPicked = (int) picked.get("qtypicked");
                                        if (qtyPicked > 0) {
                                            Long cellid = Long.parseLong(picked.get("cellid").toString());
                                            Long stockid = Long.parseLong(picked.get("stockid").toString());
                                            Long orderitemid = Long.parseLong(picked.get("suppliesorderitemsid").toString());
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
                                            Object[] paramsValuescellqty = {BigInteger.valueOf(stockid), cellid};
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

                                            //Update stock card
                                            String[] paramsStockQty = {"stockid"};
                                            Object[] paramsValuesStockQty = {BigInteger.valueOf(stockid)};
                                            String whereStockQty = "WHERE stockid=:stockid";
                                            String[] fieldsStockQty = {"stockissued", "packsize"};
                                            List<Object[]> issued = (List<Object[]>) genericClassService.fetchRecord(Facilityunitstock.class, fieldsStockQty, whereStockQty, paramsStockQty, paramsValuesStockQty);
                                            if (issued != null) {
                                                Integer totalIssued22 = (Integer) issued.get(0)[0] + (qtyPicked * (Integer) issued.get(0)[1]);

                                                //UPDATE CELL VALUES
                                                String[] columnsqty = {"stockissued"};
                                                Object[] columnValuesqty = {totalIssued22};
                                                String pkqty = "stockid";
                                                Object pkValueqty = stockid;
                                                genericClassService.updateRecordSQLSchemaStyle(Stock.class, columnsqty, columnValuesqty, pkqty, pkValueqty, "store");
                                                new StockActivityLog(genericClassService, stockid.intValue(), currStaffId.intValue(), "OUT", qtyPicked * (Integer) issued.get(0)[1], null, null, null).start();
                                            }
                                        }
                                    }

                                    for (Map log : stockList) {
                                        Suppliesissuance suppliesissuance = new Suppliesissuance();
                                        suppliesissuance.setSuppliesorderitemsid(BigInteger.valueOf((long) log.get("orderitem")));
                                        suppliesissuance.setQtyissued((int) log.get("qty"));
                                        suppliesissuance.setStockid(BigInteger.valueOf((long) log.get("stockid")));
                                        genericClassService.saveOrUpdateRecordLoadObject(suppliesissuance);
                                        suppliesorderitemsset.add((long) log.get("orderitem"));
                                    }

                                    String[] columns = {"status", "issuedby", "issuedto", "dateissued"};
                                    Object[] columnValues = {"ISSUED", BigInteger.valueOf(currStaffId), issuedto, new Date()};
                                    String pk = "suppliesorderid";
                                    Object pkValue = Long.parseLong(suppliesorderid);
                                    genericClassService.updateRecordSQLSchemaStyle(Suppliesorder.class, columns, columnValues, pk, pkValue, "store");

                                    for (long suppliesreqitemsid : suppliesorderitemsset) {
                                        try {
                                            String[] columns2 = {"isissued"};
                                            Object[] columnValues2 = {true};
                                            String pk2 = "suppliesorderitemsid";
                                            Object pkValue2 = suppliesreqitemsid;
                                            genericClassService.updateRecordSQLSchemaStyle(Suppliesorderitems.class, columns2, columnValues2, pk2, pkValue2, "store");
                                        } catch (Exception ex) {
                                            System.out.println(ex);
                                        }
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
            } else {
                result = "error";
            }
            return result;
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/servicesdOrderRequisitions", method = RequestMethod.GET)
    public String servicesdOrderRequisitions(Model model, HttpServletRequest request) {
        List<Map> deliveredOrders = new ArrayList<>();

        //Fetch Facility Orders
        String[] paramsfacilityunitexpirorders = {"facilityunitid", "status", "dateissued"};
        Object[] paramsValuesfacilitunitepiredorders = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), "ISSUED", new Date()};
        String[] fieldsunitDeliveredorders = {"suppliesorderid", "orderno", "approvedby", "dateapproved", "daterequested", "issuedby", "requestedby", "issuedto"};
        String whereunitDeliveredorders = "WHERE facilityunitid=:facilityunitid AND status=:status AND dateissued=:dateissued";
        List<Object[]> objunitsxipiredorders = (List<Object[]>) genericClassService.fetchRecord(Suppliesorder.class, fieldsunitDeliveredorders, whereunitDeliveredorders, paramsfacilityunitexpirorders, paramsValuesfacilitunitepiredorders);
        if (objunitsxipiredorders != null) {
            Map<String, Object> unitDeliveredorders;
            for (Object[] ord44 : objunitsxipiredorders) {
                unitDeliveredorders = new HashMap<>();
                try {

                    //Fetch Order Items number
                    int noOfItems = 0;
                    String[] paramsnumberofitems = {"suppliesorderid", "isissued"};
                    Object[] paramsValuesnumberofitems = {ord44[0], true};
                    String wherenumberofitems = "WHERE suppliesorderid=:suppliesorderid AND isissued=:isissued";
                    noOfItems = genericClassService.fetchRecordCount(Suppliesorderitems.class, wherenumberofitems, paramsnumberofitems, paramsValuesnumberofitems);
                    unitDeliveredorders.put("numberofitems", noOfItems);

                    if (noOfItems > 0) {
                        unitDeliveredorders.put("suppliesorderid", ord44[0]);
                        unitDeliveredorders.put("orderno", (String) ord44[1]);
                        unitDeliveredorders.put("dateapproved", formatter2.format((Date) ord44[3]));
                        unitDeliveredorders.put("daterequested", formatter2.format((Date) ord44[4]));

                        //Query requester
                        String[] paramsPersondetailsDeliver = {"staffid"};
                        Object[] paramsValuesPersondetailsDeliver = {ord44[6]};
                        String[] fieldsPersondetailsDeliver = {"personid", "firstname", "lastname", "othernames"};
                        String wherePersondetailsDeliver = "WHERE staffid=:staffid";
                        List<Object[]> objPersondetailsDeliver = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fieldsPersondetailsDeliver, wherePersondetailsDeliver, paramsPersondetailsDeliver, paramsValuesPersondetailsDeliver);
                        if (objPersondetailsDeliver != null) {
                            Object[] persondetailsDeliver = objPersondetailsDeliver.get(0);
                            if (persondetailsDeliver[3] != null) {
                                unitDeliveredorders.put("requester", (String) persondetailsDeliver[1] + " " + (String) persondetailsDeliver[2] + " " + (String) persondetailsDeliver[3]);
                            } else {
                                unitDeliveredorders.put("requester", (String) persondetailsDeliver[1] + " " + (String) persondetailsDeliver[2]);
                            }
                        }

                        //Query approved by
                        String[] paramsPersondetailsDeliver2 = {"staffid"};
                        Object[] paramsValuesPersondetailsDeliver2 = {ord44[2]};
                        String[] fieldsPersondetailsDeliver2 = {"personid", "firstname", "lastname", "othernames"};
                        String wherePersondetailsDeliver2 = "WHERE staffid=:staffid";
                        List<Object[]> objPersondetailsDeliver2 = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fieldsPersondetailsDeliver2, wherePersondetailsDeliver2, paramsPersondetailsDeliver2, paramsValuesPersondetailsDeliver2);
                        if (objPersondetailsDeliver2 != null) {
                            Object[] persondetailsDeliver2 = objPersondetailsDeliver2.get(0);
                            if (persondetailsDeliver2[3] != null) {
                                unitDeliveredorders.put("approved", (String) persondetailsDeliver2[1] + " " + (String) persondetailsDeliver2[2] + " " + (String) persondetailsDeliver2[3]);
                            } else {
                                unitDeliveredorders.put("approved", (String) persondetailsDeliver2[1] + " " + (String) persondetailsDeliver2[2]);
                            }
                        }

                        //Query issued by
                        String[] paramsPersondetailsDeliver4 = {"staffid"};
                        Object[] paramsValuesPersondetailsDeliver4 = {ord44[5]};
                        String[] fieldsPersondetailsDeliver4 = {"personid", "firstname", "lastname", "othernames"};
                        String wherePersondetailsDeliver4 = "WHERE staffid=:staffid";
                        List<Object[]> objPersondetailsDeliver4 = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fieldsPersondetailsDeliver4, wherePersondetailsDeliver4, paramsPersondetailsDeliver4, paramsValuesPersondetailsDeliver4);
                        if (objPersondetailsDeliver4 != null) {
                            Object[] persondetailsDeliver4 = objPersondetailsDeliver4.get(0);
                            if (persondetailsDeliver4[3] != null) {
                                unitDeliveredorders.put("issuedby", (String) persondetailsDeliver4[1] + " " + (String) persondetailsDeliver4[2] + " " + (String) persondetailsDeliver4[3]);
                            } else {
                                unitDeliveredorders.put("issuedby", (String) persondetailsDeliver4[1] + " " + (String) persondetailsDeliver4[2]);
                            }
                        }

                        //Query recieved by
                        String[] paramsPersondetailsDeliver002 = {"staffid"};
                        Object[] paramsValuesPersondetailsDeliver002 = {ord44[7]};
                        String[] fieldsPersondetailsDeliver002 = {"personid", "firstname", "lastname", "othernames"};
                        String wherePersondetailsDeliver4002 = "WHERE staffid=:staffid";
                        List<Object[]> objPersondetailsDeliver4002 = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fieldsPersondetailsDeliver002, wherePersondetailsDeliver4002, paramsPersondetailsDeliver002, paramsValuesPersondetailsDeliver002);
                        if (objPersondetailsDeliver4002 != null) {
                            Object[] persondetailsDeliver4002 = objPersondetailsDeliver4002.get(0);
                            if (persondetailsDeliver4002[3] != null) {
                                unitDeliveredorders.put("receiver", (String) persondetailsDeliver4002[1] + " " + (String) persondetailsDeliver4002[2] + " " + (String) persondetailsDeliver4002[3]);
                            } else {
                                unitDeliveredorders.put("receiver", (String) persondetailsDeliver4002[1] + " " + (String) persondetailsDeliver4002[2]);
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
        return "inventoryAndSupplies/placeSuppliesRequisitions/views/readyOrders";
    }

    @RequestMapping(value = "/viewfacilityunitorderitemsservicedsupbydate", method = RequestMethod.GET)
    public String viewfacilityunitorderitemsservicedsupbydate(Model model, HttpServletRequest request) {
        List<Map> deliveredOrders = new ArrayList<>();
        try {
            String date = request.getParameter("date");
            Date dateIssued = formatter2.parse(date);
            //Fetch Facility Orders
            String[] paramsfacilityunitexpirorders = {"facilityunitid", "status", "dateissued"};
            Object[] paramsValuesfacilitunitepiredorders = {BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))), "ISSUED", dateIssued};
            String[] fieldsunitDeliveredorders = {"suppliesorderid", "orderno", "approvedby", "dateapproved", "daterequested", "issuedby", "requestedby", "issuedto"};
            String whereunitDeliveredorders = "WHERE facilityunitid=:facilityunitid AND status=:status AND dateissued=:dateissued";
            List<Object[]> objunitsxipiredorders = (List<Object[]>) genericClassService.fetchRecord(Suppliesorder.class, fieldsunitDeliveredorders, whereunitDeliveredorders, paramsfacilityunitexpirorders, paramsValuesfacilitunitepiredorders);
            if (objunitsxipiredorders != null) {
                Map<String, Object> unitDeliveredorders;
                for (Object[] ord44 : objunitsxipiredorders) {
                    unitDeliveredorders = new HashMap<>();
                    try {

                        //Fetch Order Items number
                        int noOfItems = 0;
                        String[] paramsnumberofitems = {"suppliesorderid", "isissued"};
                        Object[] paramsValuesnumberofitems = {ord44[0], true};
                        String wherenumberofitems = "WHERE suppliesorderid=:suppliesorderid AND isissued=:isissued";
                        noOfItems = genericClassService.fetchRecordCount(Suppliesorderitems.class, wherenumberofitems, paramsnumberofitems, paramsValuesnumberofitems);
                        unitDeliveredorders.put("numberofitems", noOfItems);

                        if (noOfItems > 0) {
                            unitDeliveredorders.put("suppliesorderid", ord44[0]);
                            unitDeliveredorders.put("orderno", (String) ord44[1]);
                            unitDeliveredorders.put("dateapproved", formatter2.format((Date) ord44[3]));
                            unitDeliveredorders.put("daterequested", formatter2.format((Date) ord44[4]));

                            //Query requester
                            String[] paramsPersondetailsDeliver = {"staffid"};
                            Object[] paramsValuesPersondetailsDeliver = {ord44[6]};
                            String[] fieldsPersondetailsDeliver = {"personid", "firstname", "lastname", "othernames"};
                            String wherePersondetailsDeliver = "WHERE staffid=:staffid";
                            List<Object[]> objPersondetailsDeliver = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fieldsPersondetailsDeliver, wherePersondetailsDeliver, paramsPersondetailsDeliver, paramsValuesPersondetailsDeliver);
                            if (objPersondetailsDeliver != null) {
                                Object[] persondetailsDeliver = objPersondetailsDeliver.get(0);
                                if (persondetailsDeliver[3] != null) {
                                    unitDeliveredorders.put("requester", (String) persondetailsDeliver[1] + " " + (String) persondetailsDeliver[2] + " " + (String) persondetailsDeliver[3]);
                                } else {
                                    unitDeliveredorders.put("requester", (String) persondetailsDeliver[1] + " " + (String) persondetailsDeliver[2]);
                                }
                            }

                            //Query approved by
                            String[] paramsPersondetailsDeliver2 = {"staffid"};
                            Object[] paramsValuesPersondetailsDeliver2 = {ord44[2]};
                            String[] fieldsPersondetailsDeliver2 = {"personid", "firstname", "lastname", "othernames"};
                            String wherePersondetailsDeliver2 = "WHERE staffid=:staffid";
                            List<Object[]> objPersondetailsDeliver2 = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fieldsPersondetailsDeliver2, wherePersondetailsDeliver2, paramsPersondetailsDeliver2, paramsValuesPersondetailsDeliver2);
                            if (objPersondetailsDeliver2 != null) {
                                Object[] persondetailsDeliver2 = objPersondetailsDeliver2.get(0);
                                if (persondetailsDeliver2[3] != null) {
                                    unitDeliveredorders.put("approved", (String) persondetailsDeliver2[1] + " " + (String) persondetailsDeliver2[2] + " " + (String) persondetailsDeliver2[3]);
                                } else {
                                    unitDeliveredorders.put("approved", (String) persondetailsDeliver2[1] + " " + (String) persondetailsDeliver2[2]);
                                }
                            }

                            //Query issued by
                            String[] paramsPersondetailsDeliver4 = {"staffid"};
                            Object[] paramsValuesPersondetailsDeliver4 = {ord44[5]};
                            String[] fieldsPersondetailsDeliver4 = {"personid", "firstname", "lastname", "othernames"};
                            String wherePersondetailsDeliver4 = "WHERE staffid=:staffid";
                            List<Object[]> objPersondetailsDeliver4 = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fieldsPersondetailsDeliver4, wherePersondetailsDeliver4, paramsPersondetailsDeliver4, paramsValuesPersondetailsDeliver4);
                            if (objPersondetailsDeliver4 != null) {
                                Object[] persondetailsDeliver4 = objPersondetailsDeliver4.get(0);
                                if (persondetailsDeliver4[3] != null) {
                                    unitDeliveredorders.put("issuedby", (String) persondetailsDeliver4[1] + " " + (String) persondetailsDeliver4[2] + " " + (String) persondetailsDeliver4[3]);
                                } else {
                                    unitDeliveredorders.put("issuedby", (String) persondetailsDeliver4[1] + " " + (String) persondetailsDeliver4[2]);
                                }
                            }

                            //Query recieved by
                            String[] paramsPersondetailsDeliver002 = {"staffid"};
                            Object[] paramsValuesPersondetailsDeliver002 = {ord44[7]};
                            String[] fieldsPersondetailsDeliver002 = {"personid", "firstname", "lastname", "othernames"};
                            String wherePersondetailsDeliver4002 = "WHERE staffid=:staffid";
                            List<Object[]> objPersondetailsDeliver4002 = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fieldsPersondetailsDeliver002, wherePersondetailsDeliver4002, paramsPersondetailsDeliver002, paramsValuesPersondetailsDeliver002);
                            if (objPersondetailsDeliver4002 != null) {
                                Object[] persondetailsDeliver4002 = objPersondetailsDeliver4002.get(0);
                                if (persondetailsDeliver4002[3] != null) {
                                    unitDeliveredorders.put("receiver", (String) persondetailsDeliver4002[1] + " " + (String) persondetailsDeliver4002[2] + " " + (String) persondetailsDeliver4002[3]);
                                } else {
                                    unitDeliveredorders.put("receiver", (String) persondetailsDeliver4002[1] + " " + (String) persondetailsDeliver4002[2]);
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
        return "inventoryAndSupplies/placeSuppliesRequisitions/views/readyOrdersByDate";
    }

    private List<Map> getSuppliesItemslocations(long itemid, long currentfacility) {
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

    private List<Map> generateSuppliesPickList(List<Map> itemLocations, Integer quantityNeeded) {
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

    Comparator sortCells010 = new Comparator<Map>() {
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

    private String generatesuppliesorderno(String facilityunit, BigInteger supplyunit) {
        String name = facilityunit + "/";
        SimpleDateFormat f = new SimpleDateFormat("yyMM");
        String pattern = name + f.format(new Date()) + "/%";
        String orderno = "";

        String[] params = {"facilityunitid", "orderno"};
        Object[] paramsValues = {supplyunit, pattern};
        String[] fields = {"orderno"};
        String where = "WHERE facilityunitid=:facilityunitid AND orderno LIKE :orderno ORDER BY orderno DESC LIMIT 1";
        List<String> lastFacilityorderno = (List<String>) genericClassService.fetchRecord(Suppliesorder.class,
                fields, where, params, paramsValues);
        if (lastFacilityorderno == null) {
            orderno = name + f.format(new Date()) + "/0001";
            return orderno;
        } else {
            try {
                int lastNo = Integer.parseInt(lastFacilityorderno.get(0).split("\\/")[2]);
                String newNo = String.valueOf(lastNo + 1);
                switch (newNo.length()) {
                    case 1:
                        orderno = name + f.format(new Date()) + "/000" + newNo;
                        break;
                    case 2:
                        orderno = name + f.format(new Date()) + "/00" + newNo;
                        break;
                    case 3:
                        orderno = name + f.format(new Date()) + "/0" + newNo;
                        break;
                    default:
                        orderno = name + f.format(new Date()) + "/" + newNo;
                        break;
                }
            } catch (Exception e) {
                System.out.println(e);
            }
        }
        return orderno;
    }
}
