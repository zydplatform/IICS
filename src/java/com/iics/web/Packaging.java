/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.domain.Searchstaff;
import com.iics.service.GenericClassService;
import com.iics.store.Bookedpackagequantities;
import com.iics.store.Cellitems;
import com.iics.store.Facilitystocklog;
import com.iics.store.Facilityunitstock;
import com.iics.store.Item;
import com.iics.store.Itempackage;
import com.iics.store.Package;
import com.iics.store.Readypackets;
import com.iics.store.Shelfstock;
import com.iics.utils.ShelfActivityLog;
import java.io.IOException;
import java.math.BigInteger;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/packaging")
public class Packaging {

    @Autowired
    GenericClassService genericClassService;
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat formatter2 = new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat formatterwithtime2 = new SimpleDateFormat("yyyy-MM-dd hh:mm aa");
    private Date serverDate = new Date();

    @RequestMapping(value = "/packaginghome", method = RequestMethod.GET)
    public String packaginghome(HttpServletRequest request, Model model) {

        return "patientsManagement/packaging/packaginghome";
    }

//    @RequestMapping(value = "/searchitem", method = RequestMethod.POST)
//    String searchitem(HttpServletRequest request, Model model, @ModelAttribute("searchValue") String searchValue) throws JsonProcessingException {
//        String FacilityUnitSession = request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString();
//        List<Map> items = new ArrayList<>();
//        String[] params = {"facilityunitid", "fullname"};
//        Object[] paramsValues = {BigInteger.valueOf(Long.parseLong(FacilityUnitSession)), searchValue.trim().toLowerCase() + "%"};
//        String[] fields = {"itemid", "fullname"};
//        String where = "WHERE facilityunitid=:facilityunitid AND LOWER(fullname) LIKE :fullname AND daystoexpire >0 AND shelvedstock > 0 ORDER BY fullname";
//        List<Object[]> found = (List<Object[]>) genericClassService.fetchRecord(Facilityunitstock.class, fields, where, params, paramsValues);
//        if (found != null) {
//            Map<String, Object> userrow;
//            for (Object[] f : found) {
//                userrow = new HashMap<>();
//                //GET FROM STOCK
//                String[] params1 = {"itemid"};
//                Object[] paramsValues1 = {(BigInteger) f[0]};
//                String[] fields1 = {"batchnumber", "stockid"};
//                String where1 = "WHERE itemid=:itemid";
//                List<Object[]> found1 = (List<Object[]>) genericClassService.fetchRecord(com.iics.store.Stock.class, fields1, where1, params1, paramsValues1);
//                if (found1 != null) {
//                    for (Object[] f1 : found1) {
//                        userrow.put("itemid", (BigInteger) f[0]);
//                        userrow.put("batchnumber", (String) f1[0]);
//                        userrow.put("stockid", (Long) f1[1]);
//                    }
//                }
//                //GET FORM ITEM PACKAGE
//                String[] param = {"itemid"};
//                Object[] paramsValuesP = {(BigInteger) f[0]};
//                String[] fieldsP = {"packagename"};
//                String whereP = "WHERE itempackageid=:itemid";
//                List<String> foundP = (List<String>) genericClassService.fetchRecord(Itempackage.class, fieldsP, whereP, param, paramsValuesP);
//                if (foundP != null) {
//                    for (String f1 : foundP) {
//                        userrow.put("fullname", f1);
//                    }
//                }
//                items.add(userrow);
//            }
//        }
//        model.addAttribute("items", items);
//        model.addAttribute("searchValue", searchValue);
//        return "patientsManagement/packaging/views/packageitemsearchresult";
//
//    }
    @RequestMapping(value = "/searchitem", method = RequestMethod.POST)
    String searchitem(HttpServletRequest request, Model model, @ModelAttribute("searchValue") String searchValue) throws JsonProcessingException {
        List<Map> items = new ArrayList<>();
        try {
            long facilityUnitId = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString());
            String [] params = { "facilityunitid", "fullname"};
            Object[] paramsValues = {BigInteger.valueOf(facilityUnitId), searchValue.trim().toLowerCase() + "%"};
            String[] fields = {"itemid", "fullname"};
            String where = "WHERE facilityunitid=:facilityunitid AND LOWER(fullname) LIKE :fullname AND daystoexpire > 0 AND shelvedstock > 0 ORDER BY fullname";
            List<Object[]> stockItems = (List<Object[]>) genericClassService.fetchRecord(Facilityunitstock.class, fields, where, params, paramsValues);
            if(stockItems != null){
                Map<String, Object> item;
                for(Object [] stockItem : stockItems){
                    item = new HashMap<>();
                    // GET ACTUAL SHELVED QUANTITY. STOCK SHELVED QUANTITY DOES NOT DECREMENT. SO IT IS INVALID TO USE HERE.
                    params = new String [] { "itemid", "facilityunitid" };
                    paramsValues = new Object [] { BigInteger.valueOf(Long.parseLong(stockItem[0].toString())), BigInteger.valueOf(facilityUnitId) };
                    fields = new String [] { "itemid", "batchnumber", "stockid" };
                    where = "WHERE itemid=:itemid AND facilityunitid=:facilityunitid";
                    List<Object[]> cellItems = (List<Object[]>) genericClassService.fetchRecord(Cellitems.class, fields, where, params, paramsValues);
                    if(cellItems != null){
                        for(Object [] cellItem : cellItems){
                            item.put("itemid", cellItem[0]);
                            item.put("batchnumber", cellItem[1]);
                            item.put("stockid", cellItem[2]);
                        }
                    }
                    params = new String [] { "itemid" };
                    paramsValues = new Object [] { BigInteger.valueOf(Long.parseLong(stockItem[0].toString())) };
                    fields = new String [] { "packagename" };
                    where = "WHERE itempackageid=:itemid";
                    List<String> packageNames = (List<String>) genericClassService.fetchRecord(Itempackage.class, fields, where, params, paramsValues);
                    if(packageNames != null){
                        for(String packageName : packageNames){
                            item.put("fullname", packageName);
                            items.add(item);
                        }
                    }
                }
            }
        } catch (NumberFormatException ex){
            System.out.println(ex);
        } catch (Exception ex){
            System.out.println(ex);
        }         
        model.addAttribute("items", items);
        model.addAttribute("searchValue", searchValue);
        return "patientsManagement/packaging/views/packageitemsearchresult";

    }
//    @RequestMapping(value = "/viewitemdetails", method = RequestMethod.GET)
//    public String viewitemdetails(HttpServletRequest request, Model model) {
//        String itemid = request.getParameter("itemid");
//        String fullname = request.getParameter("fullname");
//        String stockid = request.getParameter("stockid");
//        String FacilityUnitSession = request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString();
//        int sum = 0;
//        Integer total = 0;
//        List<Map> batcheslist = new ArrayList<>();
//        String[] params = {"itemid", "facilityunitid"};
//        Object[] paramsValues = {Long.parseLong(itemid), BigInteger.valueOf(Long.parseLong(FacilityUnitSession))};
//        String[] fields = {"batchnumber", "shelvedstock", "stockid", "daystoexpire"};
//        String where = "WHERE itemid=:itemid AND shelvedstock > 0 AND facilityunitid=:facilityunitid AND daystoexpire>0 ORDER BY daystoexpire";
//        List<Object[]> found = (List<Object[]>) genericClassService.fetchRecord(Facilityunitstock.class, fields, where, params, paramsValues);
//        Map<String, Object> itemdetails;
//        if (found != null) {
//            for (Object[] k : found) {
//                itemdetails = new HashMap<>();
//                itemdetails.put("batchnumber", (String) k[0]);
//                itemdetails.put("shelvedstock", (Integer) k[1]);
//                itemdetails.put("stockid", (BigInteger) k[2]);
//                sum += (Integer) k[1];
//                batcheslist.add(itemdetails);
//            }
//            String[] params2 = {"stockid"};
//            Object[] paramsValues2 = {(BigInteger)found.get(0)[2]};
//
//            String[] fields2 = {"packetno", "eachpacket"};
//            String where2 = "WHERE stockid=:stockid";
//            List<Object[]> found2 = (List<Object[]>) genericClassService.fetchRecord(Package.class, fields2, where2, params2, paramsValues2);
//            if (found2 != null) {
//                for (Object[] j : found2) {
//                    total = (Integer) j[0] * (Integer) j[1];
//                    int realstockqty = sum - total;
//                    model.addAttribute("Qtyshelving", realstockqty);
//                    model.addAttribute("total", total);
//                }
//            } else if (found2 == null) {
//                total = 0;
//                int realstockqty = sum;
//                model.addAttribute("Qtyshelving", realstockqty);
//                model.addAttribute("total", total);
//            }
//        }
//        //fETCH FROM PACKAGE
//
//        model.addAttribute("batcheslist", batcheslist);
//        model.addAttribute("fullname", fullname);
//        return "patientsManagement/packaging/views/create_packages";
//    }
    
    @RequestMapping(value = "/viewitemdetails", method = RequestMethod.GET)
    public String viewitemdetails(HttpServletRequest request, Model model) {        
        List<Map> batcheslist = new ArrayList<>();
         String itemId = request.getParameter("itemid");
            String fullName = request.getParameter("fullname");
            String stockId = request.getParameter("stockid"); 
        try {
            long facilityUnitId = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString());                      
            int sum = 0;
            Integer total = 0;
            String[] params = {"itemid", "facilityunitid"};
            Object[] paramsValues = {Long.parseLong(itemId), BigInteger.valueOf(facilityUnitId)};
            String[] fields = {"batchnumber", "quantityshelved", "stockid", "daystoexpire"};
            String where = "WHERE itemid=:itemid AND quantityshelved > 0 AND facilityunitid=:facilityunitid AND daystoexpire>0 ORDER BY daystoexpire";
            List<Object[]> cellItems = (List<Object[]>) genericClassService.fetchRecord(Cellitems.class, fields, where, params, paramsValues);
            Map<String, Object> itemDetails;
            if(cellItems != null){
                for(Object [] cellItem : cellItems){
                    itemDetails = new HashMap<>();
                    itemDetails.put("batchnumber", cellItem[0]);
                    itemDetails.put("shelvedstock", cellItem[1]);
                    itemDetails.put("stockid", cellItem[2]);
                    sum += Integer.parseInt(cellItem[1].toString());
                    batcheslist.add(itemDetails);
                }                
                    
                String[] params2 = {"stockid"};
                Object[] paramsValues2 = {(BigInteger)cellItems.get(0)[2]};

                String[] fields2 = {"packetno", "eachpacket"};
                String where2 = "WHERE stockid=:stockid";
                List<Object[]> found2 = (List<Object[]>) genericClassService.fetchRecord(Package.class, fields2, where2, params2, paramsValues2);
                if (found2 != null) {
                    for (Object[] j : found2) {
                        total = (Integer) j[0] * (Integer) j[1];
                        int realstockqty = sum - total;
                        model.addAttribute("Qtyshelving", realstockqty);
                        model.addAttribute("total", total);
                    }
                } else if (found2 == null) {
                    total = 0;
                    int realstockqty = sum;
                    model.addAttribute("Qtyshelving", realstockqty);
                    model.addAttribute("total", total);
                }
            }
        } catch(Exception e){
            System.out.println(e);
        } 

        model.addAttribute("batcheslist", batcheslist);
        model.addAttribute("fullname", fullName);
        return "patientsManagement/packaging/views/create_packages";
    }
    
    @RequestMapping(value = "/save_packages")
    @ResponseBody
    String save_packages(HttpServletRequest request, Model model) {
        String results = "";
        long facilityUnitId = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString());                      
        String staffidsession = request.getSession().getAttribute("sessionActiveLoginStaffid").toString();
        String stockid = request.getParameter("stockid");
        String parkagesize = request.getParameter("numberOfpackets");
        String parkno = request.getParameter("eachPkt");

        try {
            Package packageitems = new Package();
            packageitems.setDatecreated(new Date());
            packageitems.setCreatedby(Long.parseLong(staffidsession));
            packageitems.setEachpacket(Integer.parseInt(parkno));
            packageitems.setPacketno(Integer.parseInt(parkagesize));
            packageitems.setStockid(Long.parseLong(stockid));
            packageitems.setStatus("UNPACKAGED");
            //
            packageitems.setFacilityunitid(facilityUnitId);
            //
            genericClassService.saveOrUpdateRecordLoadObject(packageitems);
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return results;
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

    @RequestMapping(value = "/packageditems", method = RequestMethod.GET)
    public String packageditems(HttpServletRequest request, Model model
    ) {
        List<Map> packageditems = new ArrayList<>();
        long facilityUnitId = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString());
        String[] params = { "status", "facilityunitid" };
        Object[] paramsValues = { "PACKED", facilityUnitId };
        String[] fields = {"stockid", "packetno", "eachpacket", "createdby", "datecreated", "status", "packageid", "totalqtypicked"};
        String where = "WHERE status=:status AND facilityunitid=:facilityunitid";
        List<Object[]> found = (List<Object[]>) genericClassService.fetchRecord(Package.class, fields, where, params, paramsValues);
        Map<String, Object> itemsinpackage;
        if (found != null) {
            for (Object[] pkged : found) {
                itemsinpackage = new HashMap<>();
                itemsinpackage.put("packagesize", pkged[1]);
                itemsinpackage.put("stockid", pkged[0]);
                itemsinpackage.put("packageid", pkged[6]);
                itemsinpackage.put("packageno", pkged[2]);
                itemsinpackage.put("Status", pkged[5]);
                itemsinpackage.put("totalqtypicked", pkged[7]);
                itemsinpackage.put("datepackaged", new SimpleDateFormat("dd-MM-yyyy").format((Date) pkged[4]));

                int numberOfCreatedpkts = 0;
                String[] params2 = {"packageid", "dispensingstatus"};
                Object[] paramsValues2 = { Long.parseLong(pkged[6].toString()), Boolean.TRUE};
                String where2 = "WHERE packageid=:packageid AND dispensingstatus=:dispensingstatus";
                numberOfCreatedpkts = genericClassService.fetchRecordCount(Readypackets.class, where2, params2, paramsValues2);
                itemsinpackage.put("numberOfCreatedpkts", numberOfCreatedpkts);

                String[] params1 = {"stockid"};
                Object[] paramsValues1 = { Long.parseLong(pkged[0].toString()) };
                String[] fields1 = {"fullname", "batchnumber", "daystoexpire"};
                String where1 = "WHERE stockid=:stockid";
                List<Object[]> found1 = (List<Object[]>) genericClassService.fetchRecord(Cellitems.class, fields1, where1, params1, paramsValues1);
                if (found1 != null) {
                    itemsinpackage.put("fullname", (String) found1.get(0)[0]);
                    itemsinpackage.put("batchnumber", (String) found1.get(0)[1]);
                    itemsinpackage.put("daystoexpire", (Integer) found1.get(0)[2]);
                }
                String[] params3 = {"staffid"};
                Object[] paramsValues3 = { BigInteger.valueOf(Long.parseLong(pkged[3].toString())) };
                String[] fields3 = {"firstname", "lastname", "othernames"};
                String where3 = "WHERE staffid=:staffid";
                List<Object[]> found3 = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields3, where3, params3, paramsValues3);
                if (found3 != null) {
                    itemsinpackage.put("firstname", (String) found3.get(0)[0]);
                    itemsinpackage.put("lastname", (String) found3.get(0)[1]);
                    itemsinpackage.put("othernames", (String) found3.get(0)[2]);
                }
                packageditems.add(itemsinpackage);
            }
        }

        model.addAttribute("packageditems", packageditems);

        return "patientsManagement/packaging/views/packageditems";
    }

    @RequestMapping(value = "/viewbatchitems", method = RequestMethod.GET)
    public String viewbatchitems(HttpServletRequest request, Model model
    ) {
        String itemid = request.getParameter("itemid");
        String facilityunitid = request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString();
        List<Map> batcheslist = new ArrayList<>();
        Set<String> batchNo = new HashSet<>();
        Map<String, Object> batches;
        String[] paramsbatch = {"itemid", "facilityunitid"};
        Object[] paramsValuesbatch = {BigInteger.valueOf(Long.parseLong(itemid)), Integer.parseInt(facilityunitid)};
        String wherebatch = "WHERE itemid=:itemid AND facilityunitid=:facilityunitid AND quantityshelved > 0  AND daystoexpire>0 ORDER BY daystoexpire";
        String[] fieldsbatch = {"itemid", "bayrowcellid", "quantityshelved", "daystoexpire", "celllabel", "batchnumber", "stockid"};
        List<Object[]> objbatch = (List<Object[]>) genericClassService.fetchRecord(Cellitems.class, fieldsbatch, wherebatch, paramsbatch, paramsValuesbatch);

        if (objbatch != null) {
            for (Object[] batch : objbatch) {
                batches = new HashMap<>();
                String batchnumner = (String) batch[5];
                if (!batchNo.contains(batchnumner)) {
                    batchNo.add(batchnumner);
                    batches.put("batchnumber", (String) batch[5]);
                    batches.put("daystoexpire", (Integer) batch[3]);
                    batcheslist.add(batches);
                }
            }
        }
        model.addAttribute("batcheslist", batcheslist);
        return "patientsManagement/packaging/views/batchdetails";
    }

    @RequestMapping(value = "/picktopackets", method = RequestMethod.GET)
    public String picktopackets(HttpServletRequest request, Model model
    ) {
        List<Map> packageditems = new ArrayList<>();
        String[] params = {};
        Object[] paramsValues = {};
        String[] fields = {"stockid", "packetno", "eachpacket", "createdby", "datecreated", "status", "packageid"};
        String where = "WHERE packetno>0";
        List<Object[]> found = (List<Object[]>) genericClassService.fetchRecord(Package.class, fields, where, params, paramsValues);
        Map<String, Object> itemsinpackage;
        if (found != null) {
            for (Object[] pkged : found) {
                itemsinpackage = new HashMap<>();
                itemsinpackage.put("packagesize", pkged[1]);
                itemsinpackage.put("stockid", pkged[0]);
                itemsinpackage.put("packageid", pkged[6]);
                itemsinpackage.put("packageno", pkged[2]);
                itemsinpackage.put("Status", pkged[5]);
                itemsinpackage.put("datepackaged", new SimpleDateFormat("dd-MM-yyyy").format((Date) pkged[4]));

                String[] params1 = {"stockid"};
                Object[] paramsValues1 = { BigInteger.valueOf(Long.parseLong(pkged[0].toString())) };
                String[] fields1 = {"fullname", "batchnumber", "daystoexpire"};
                String where1 = "WHERE stockid=:stockid";
                List<Object[]> found1 = (List<Object[]>) genericClassService.fetchRecord(Cellitems.class, fields1, where1, params1, paramsValues1);
                if (found1 != null) {
                    itemsinpackage.put("fullname", (String) found1.get(0)[0]);
                    itemsinpackage.put("batchnumber", (String) found1.get(0)[1]);
                    itemsinpackage.put("daystoexpire", (Integer) found1.get(0)[2]);
                }
                String[] params2 = {"staffid"};
                Object[] paramsValues2 = { BigInteger.valueOf(Long.parseLong(pkged[3].toString())) };
                String[] fields2 = {"firstname", "lastname", "othernames"};
                String where2 = "WHERE staffid=:staffid";
                List<Object[]> found2 = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields2, where2, params2, paramsValues2);
                if (found2 != null) {
                    itemsinpackage.put("firstname", (String) found2.get(0)[0]);
                    itemsinpackage.put("lastname", (String) found2.get(0)[1]);
                    itemsinpackage.put("othernames", (String) found2.get(0)[2]);
                }
                packageditems.add(itemsinpackage);
            }
        }

        model.addAttribute("packageditems", packageditems);
        return "patientsManagement/packaging/views/picktopackets";
    }

    @RequestMapping(value = "/deletepackage", method = RequestMethod.POST)
    public @ResponseBody
    String deletepackage(HttpServletRequest request
    ) {
        Map<String, Object> model = new HashMap<String, Object>();
        String packageid = request.getParameter("packageid");
        String[] columns = {"packageid"};
        Object[] columnValues = {Integer.parseInt(packageid)};
        genericClassService.deleteRecordByByColumns("store.package", columns, columnValues);
        return "";
    }

    @RequestMapping(value = "/editpackagedetails", method = RequestMethod.GET)
    public String editpackagedetails(HttpServletRequest request, Model model
    ) {
        Set<String> genericname = new HashSet<>();
        Set<String> batchNo = new HashSet<>();
        List<Map> stockList = new ArrayList<>();
        Map<String, Object> mystockitems;
        String facilityunitid = request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString();
        String packageid = request.getParameter("packageid");
        Integer stockid = Integer.parseInt(request.getParameter("stockid"));

        String[] params = {"packageid"};
        Object[] paramsValues = {Integer.parseInt(packageid)};
        String[] fields = {"itemid", "packetno", "eachpacket"};
        String where = "WHERE packageid=:packageid ";
        List<Object[]> found = (List<Object[]>) genericClassService.fetchRecord(Package.class, fields, where, params, paramsValues);
        if (found != null) {
            model.addAttribute("packetno", (Integer) found.get(0)[1]);
            model.addAttribute("eachpacket", (Integer) found.get(0)[2]);
            String[] params1 = {"facilityunitid", "itemid"};
            Object[] paramsValues1 = {Long.parseLong(facilityunitid), BigInteger.valueOf(Long.valueOf(stockid.toString()))};
            String[] fields1 = {"quantityshelved"};
            String where1 = "WHERE facilityunitid=:facilityunitid AND itemid=:itemid";
            List<Integer> found1 = (List<Integer>) genericClassService.fetchRecord(Cellitems.class, fields1, where1, params1, paramsValues1);
            if (found1 != null) {
                int sum = 0;
                for (Integer k : found1) {
                    sum += k;
                }
                model.addAttribute("totalqtyshelved", sum);
            }
        }

        String[] params2 = {"facilityunitid"};
        Object[] paramsValues2 = { BigInteger.valueOf(Long.parseLong(facilityunitid)) };
        String[] fields2 = {"stockid", "quantityshelved", "daystoexpire", "batchnumber", "facilityunitid", "itemid", "fullname", "shelfstockid"};
        String where2 = "WHERE facilityunitid=:facilityunitid AND quantityshelved > 0";
        List<Object[]> found2 = (List<Object[]>) genericClassService.fetchRecord(Cellitems.class, fields2, where2, params2, paramsValues2);
        if (found2 != null) {
            for (Object[] x : found2) {
                String genename = String.valueOf(x[6]);
                if (!genericname.contains(genename)) {
                    genericname.add(genename);
                }
            }
        }
        if (!genericname.isEmpty()) {
            for (String y : genericname) {
                mystockitems = new HashMap<>();
                int qtyamountzz = 0;
                mystockitems.put("geneName", y);
                String[] params1 = {"fullname", "facilityunitid"};
                Object[] paramsValues1 = {y, BigInteger.valueOf(Long.parseLong(facilityunitid)) };
                String[] fields1 = {"quantityshelved", "batchnumber", "facilityunitid", "itemid", "fullname", "shelfstockid", "stockid"};
                String where1 = "WHERE fullname=:fullname AND facilityunitid=:facilityunitid";
                List<Object[]> found1 = (List<Object[]>) genericClassService.fetchRecord(Cellitems.class, fields1, where1, params1, paramsValues1);
                if (found1 != null) {
                    if (!batchNo.contains(found1.get(0)[1].toString())) {
                        batchNo.add(found1.get(0)[1].toString());
                    }
                    for (Object[] z : found1) {
                        qtyamountzz += Integer.parseInt(z[0].toString());
                        mystockitems.put("itemid", (BigInteger) z[3]);
                        mystockitems.put("stockid", (BigInteger) z[6]);
                        if (!batchNo.contains(found1.get(0)[1].toString())) {
                            batchNo.add(found1.get(0)[1].toString());
                        }
                    }
                }
                mystockitems.put("batchNoCount", batchNo.size());
                mystockitems.put("Qtyshelving", qtyamountzz);
                stockList.add(mystockitems);
            }
        }
        model.addAttribute("stockid", stockid);
        model.addAttribute("stock", stockList);
        return "patientsManagement/packaging/views/editpackagedetails";
    }

    @RequestMapping(value = "/viewitemqty")
    public @ResponseBody
    String viewitemqty(HttpServletRequest request
    ) {
        Map<String, Object> model = new HashMap<String, Object>();
        String facilityunitid = request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString();
        String results = "";
        String itemid = request.getParameter("itemselect");
        String[] params1 = {"facilityunitid", "itemid"};
        Object[] paramsValues1 = {Long.parseLong(facilityunitid), BigInteger.valueOf(Long.parseLong(itemid))};
        String[] fields1 = {"quantityshelved"};
        String where1 = "WHERE facilityunitid=:facilityunitid AND itemid=:itemid";
        List<Integer> found1 = (List<Integer>) genericClassService.fetchRecord(Cellitems.class, fields1, where1, params1, paramsValues1);
        if (found1 != null) {
            int sum = 0;
            for (Integer k : found1) {
                sum += k;
            }
            results = String.valueOf(sum);
        }
        return results;
    }

    @RequestMapping(value = "/updatepackages", method = RequestMethod.POST)
    public @ResponseBody
    String updatepackages(HttpServletRequest request
    ) {
        String staffidsession = request.getSession().getAttribute("sessionActiveLoginStaffid").toString();
        try {
            //update packages
            Integer itemmid = Integer.parseInt(request.getParameter("itemmid"));
            Integer eachpacket = Integer.parseInt(request.getParameter("eachpacket"));
            Integer noofpackets = Integer.parseInt(request.getParameter("noofpackets"));
            Integer packageid = Integer.parseInt(request.getParameter("packageid"));

            String[] columns = {"packetno", "eachpacket", "updatedby", "dateupdated", "itemid"};
            Object[] columnValues = {noofpackets, eachpacket, BigInteger.valueOf(Long.parseLong(staffidsession)), new Date(), BigInteger.valueOf(Long.parseLong(itemmid.toString()))};
            String pk = "packageid";
            Object pkValue = packageid;
            genericClassService.updateRecordSQLSchemaStyle(Package.class, columns, columnValues, pk, pkValue, "store");
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return "";
    }

    @RequestMapping(value = "/packagingpicklist", method = RequestMethod.GET)
    public String packagingpicklist(HttpServletRequest request, Model model
    ) {
        String firstname = request.getSession().getAttribute("sessionActiveLoginfirstname").toString();
        String lastname = request.getSession().getAttribute("sessionActiveLoginlastname").toString();
        String othername = request.getSession().getAttribute("sessionActiveLoginothername").toString();
        String fullname = firstname + ' ' + lastname + ' ' + othername;
        String stockid = (request.getParameter("stockid"));
        String packageid = (request.getParameter("packageid"));
        String packagesize = (request.getParameter("packagesize"));
        String packageno = (request.getParameter("packageno"));
        String itemfullname = (request.getParameter("fullname"));
        String pickedstock = (request.getParameter("pickedstock"));
        request.getSession().setAttribute("sessiondrugfullname", itemfullname);
        List<Map> cells = new ArrayList<>();
        //for PickList
        List<Map> itemLocation = getItemslocations(BigInteger.valueOf(Long.parseLong(stockid)), Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))));
        List<Map> itemPickList = generatePickList(itemLocation, Integer.parseInt(pickedstock));
        Map<String, Object> item;
        item = new HashMap<>();
        item.put("itemLocation", itemLocation);
        item.put("pick", itemPickList);
        cells.add(item);
        model.addAttribute("cells", cells);
        model.addAttribute("stockid", stockid);
        model.addAttribute("fullname", itemfullname);
        model.addAttribute("logedinusernames", fullname);
        model.addAttribute("pickedstock", pickedstock);
        model.addAttribute("noInEachPacket", packageno);
        model.addAttribute("noOfPackets", packagesize);
        model.addAttribute("packageid", packageid);
        model.addAttribute("serverdate", formatterwithtime2.format(serverDate));
        return "patientsManagement/packaging/views/packagepicklist";
    }

    private List<Map> getItemslocations(BigInteger stockid, long currentfacility) {
        List<Map> itemsWithCellLocations = new ArrayList<>();
        float expired = 0;
        //FOR EACH ITEM(item ID find cells its located in
        String[] paramslocateitemcell = {"stockid", "facilityunitid"};
        Object[] paramsValueslocateitemcell = {stockid, currentfacility};
        String wherelocateitemcell = "WHERE stockid=:stockid AND facilityunitid=:facilityunitid AND quantityshelved > 0 ORDER BY daystoexpire";
        String[] fieldslocateitemcell = {"itemid", "bayrowcellid", "quantityshelved", "daystoexpire", "celllabel", "batchnumber", "stockid", "shelfstockid"};
        List<Object[]> objlocateitemcell = (List<Object[]>) genericClassService.fetchRecord(Cellitems.class, fieldslocateitemcell, wherelocateitemcell, paramslocateitemcell, paramsValueslocateitemcell);
        if (objlocateitemcell != null) {
//            Object[] cells = objlocateitemcell.get(0);
            Map<String, Object> cellMap;
            for (Object[] object : objlocateitemcell) {
                cellMap = new HashMap<>();
                if (object[3] != null) {
                    if ((Integer) object[3] > 0) {
                        expired = (Integer) object[3];
                        cellMap.put("daystoexpire", expired);
                        cellMap.put("itemid", object[0]);
                        cellMap.put("shelfstockid", (BigInteger) object[7]);
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
                    cellMap.put("shelfstockid", (BigInteger) object[7]);
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
                cellDatails.put("shelfstockid", loc.get("shelfstockid"));
                itemPickList.add(cellDatails);
                quantityNeeded = quantityNeeded - (Integer) loc.get("qty");
            } else {
                cellDatails.put("cellid", loc.get("cellid"));
                cellDatails.put("cell", loc.get("cell"));
                cellDatails.put("batch", loc.get("batchnumber"));
                cellDatails.put("stockid", loc.get("stockid"));
                cellDatails.put("shelfstockid", loc.get("shelfstockid"));
                cellDatails.put("qty", quantityNeeded);
                itemPickList.add(cellDatails);
                break;
            }
        }
        return itemPickList;
    }

    @RequestMapping(value = "/savepickedpackets", method = RequestMethod.POST)
    public @ResponseBody
    String savepickedpackets(HttpServletRequest request) {
        String results = "";
        Map<String, Object> model = new HashMap<String, Object>();
        String staffidsession = request.getSession().getAttribute("sessionActiveLoginStaffid").toString();
        long facilityUnitId = Long.parseLong(request.getSession().getAttribute("sessionLoginFacilityUnit").toString());
        String packageid = (request.getParameter("packageid"));
        String noOfPackets = (request.getParameter("noOfPackets"));
        String noInEachPacket = (request.getParameter("noInEachPacket"));
        String topickstock = (request.getParameter("pickedstock"));
        int packetbalance = 0;
        String stocks = "";
        String batches = "";
        int qty = 0;
        try {
            List<Map> qtypickedvalues = (ArrayList) new ObjectMapper().readValue(request.getParameter("qtypickedvalues"), List.class);
            for (Map cellvalues : qtypickedvalues) {
                String stockid = cellvalues.get("stockid").toString();
                stocks = stockid;
                int itemcellid = Integer.parseInt(cellvalues.get("itemcellid").toString());
                String value = cellvalues.get("value").toString();
                String shelfstockid = cellvalues.get("shelfstockid").toString();
                String batch = cellvalues.get("batch").toString();
                batches = batch;
                qty += Integer.parseInt(value);
                //update shelfstock
                String[] params = {"shelfstockid"};
                Object[] paramsValues = {BigInteger.valueOf(Long.parseLong(shelfstockid))};
                String where = "WHERE shelfstockid=:shelfstockid";
                String[] fields = {"shelfstockid", "quantityshelved"};
                List<Object[]> object = (List<Object[]>) genericClassService.fetchRecord(Shelfstock.class, fields, where, params, paramsValues);
                if (object != null) {
                    for (Object[] z : object) {
                        int balanceStock = (Integer) z[1] - Integer.parseInt(value);
                        String[] columns = {"quantityshelved", "dateupdated"};
                        Object[] columnValues = {balanceStock, new Date()};
                        String pk = "shelfstockid";
                        Object pkValue = (Long) z[0];
                        genericClassService.updateRecordSQLSchemaStyle(Shelfstock.class, columns, columnValues, pk, pkValue, "store");
                        //
                        new ShelfActivityLog(genericClassService, itemcellid, Integer.parseInt(stockid), Integer.parseInt(staffidsession), "OUT", Integer.parseInt(value)).start();
                        //
                    }
                }
            }
            //UPDATE PACKAGES
            int totalPktsFilled = (qty / Integer.parseInt(noInEachPacket));
            packetbalance = Integer.parseInt(noOfPackets) - totalPktsFilled;
            String[] columns = {"packetno", "status", "totalqtypicked"};
            Object[] columnValues = {packetbalance, "AWAITINGPACKING", qty};
            String pk = "packageid";
            Object pkValue = Integer.parseInt(packageid);
            genericClassService.updateRecordSQLSchemaStyle(Package.class, columns, columnValues, pk, pkValue, "store");

            //CREATE INDIVIDUAL READY PACKETS
            for (int i = 1; i <= totalPktsFilled; i++) {
                String refno = generateRefNo();
                Readypackets saveReadyPackets = new Readypackets();
                saveReadyPackets.setDatepackaged(new Date());
                saveReadyPackets.setPackagedby(Long.parseLong(staffidsession));
                saveReadyPackets.setReferencenumber(refno);
                saveReadyPackets.setStatus("AVAILABLE");
                saveReadyPackets.setPackageid(Long.parseLong(packageid));
                saveReadyPackets.setDispensingstatus(false);
                //
                saveReadyPackets.setStockid(Long.parseLong(stocks));
                saveReadyPackets.setFacilityunitid(facilityUnitId);
                saveReadyPackets.setQuantity(Integer.parseInt(noInEachPacket));
                //
                Object x = genericClassService.saveOrUpdateRecordLoadObject(saveReadyPackets);
                //
                results = (x != null) ? "success" : "failure";
                //
            }
        } catch (IOException | NumberFormatException ex) {
            System.out.println(ex);
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return results;
    }   

    @RequestMapping(value = "/pack_to_packets", method = RequestMethod.GET)
    public String pack_to_packets(HttpServletRequest request, Model model) {        
        List<Map> packageditems = new ArrayList<>();
        try {
            long facilityUnitId = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString());
            String[] params = { "facilityunitid" };
            Object[] paramsValues = { facilityUnitId };
            String[] fields = {"stockid", "packetno", "eachpacket", "createdby", "datecreated", "status", "packageid", "totalqtypicked"};
            String where = "WHERE facilityunitid=:facilityunitid";
            List<Object[]> found = (List<Object[]>) genericClassService.fetchRecord(Package.class, fields, where, params, paramsValues);
            Map<String, Object> itemsinpackage;
            if (found != null) {
                for (Object[] pkged : found) {
                    itemsinpackage = new HashMap<>();
                    itemsinpackage.put("packagesize", pkged[1]);
                    itemsinpackage.put("stockid", pkged[0]);
                    itemsinpackage.put("packageid", pkged[6]);
                    itemsinpackage.put("packageno", pkged[2]);
                    itemsinpackage.put("Status", pkged[5]);
                    itemsinpackage.put("totalqtypicked", pkged[7]);
                    itemsinpackage.put("datepackaged", new SimpleDateFormat("dd-MM-yyyy").format((Date) pkged[4]));

                    int numberOfCreatedpkts = 0;
                    String[] params2 = {"packageid", "dispensingstatus"};
                    Object[] paramsValues2 = { Long.parseLong(pkged[6].toString()), Boolean.FALSE};
                    String where2 = "WHERE packageid=:packageid AND dispensingstatus=:dispensingstatus";
                    numberOfCreatedpkts = genericClassService.fetchRecordCount(Readypackets.class, where2, params2, paramsValues2);
                    itemsinpackage.put("numberOfCreatedpkts", numberOfCreatedpkts);

                    String[] params1 = {"stockid"};
                    Object[] paramsValues1 = { Long.parseLong(pkged[0].toString())};
                    String[] fields1 = {"fullname", "batchnumber", "daystoexpire"};
                    String where1 = "WHERE stockid=:stockid";
                    List<Object[]> found1 = (List<Object[]>) genericClassService.fetchRecord(Cellitems.class, fields1, where1, params1, paramsValues1);
                    if (found1 != null) {
                        itemsinpackage.put("stockid", pkged[0]);
                        itemsinpackage.put("fullname", (String) found1.get(0)[0]);
                        itemsinpackage.put("batchnumber", (String) found1.get(0)[1]);
                        itemsinpackage.put("daystoexpire", (Integer) found1.get(0)[2]);
                    }
                    packageditems.add(itemsinpackage);
                }
            }
        } catch(NumberFormatException e) {
            System.out.println(e);
        } catch(Exception e) {
            System.out.println(e);
        }
        model.addAttribute("packageditems", packageditems);
        return "patientsManagement/packaging/views/pack_to_packets";
    }

    @RequestMapping(value = "/additemstopackets", method = RequestMethod.GET)
    public String additemstopackets(HttpServletRequest request, Model model) {
        List<Map> packetpacking = new ArrayList<>();
        String packageid = (request.getParameter("packageid"));
        String packageno = (request.getParameter("packageno"));
        String stockid = request.getParameter("stockid");
        //UPDATE STATUS
        String[] columns = {"status"};
        Object[] columnValues = {"PACKED"};
        String pk = "packageid";
        Object pkValue = Integer.parseInt(packageid);
        genericClassService.updateRecordSQLSchemaStyle(Package.class, columns, columnValues, pk, pkValue, "store");

        String[] params1 = {"packageid", "dispensingstatus"};
        Object[] paramsValues1 = { Long.valueOf(packageid), Boolean.FALSE};
        String[] fields1 = {"referencenumber", "status", "readypacketsid"};
        String where1 = "WHERE packageid=:packageid AND dispensingstatus=:dispensingstatus";
        List<Object[]> found1 = (List<Object[]>) genericClassService.fetchRecord(Readypackets.class, fields1, where1, params1, paramsValues1);
        Map<String, Object> packets;
        if (found1 != null) {
            for (Object[] s : found1) {
                packets = new HashMap<>();
                packets.put("referencenumber", (String) s[0]);
                packets.put("readypacketsid", (Long) s[2]);
                packets.put("packageno", packageno);
                String[] params = {"stockid"};
                Object[] paramsValues = {Long.parseLong(stockid)};
                String[] fields = {"batchnumber"};
                String where = "WHERE stockid=:stockid";
                List<String> found = (List<String>) genericClassService.fetchRecord(com.iics.store.Stock.class, fields, where, params, paramsValues);
                if (found != null) {
                    packets.put("batches", found.get(0));
                }
                packetpacking.add(packets);
            }
        }
        model.addAttribute("packetpacking", packetpacking);
        model.addAttribute("packageid", packageid);
        model.addAttribute("stockid", stockid);
        model.addAttribute("packageno", packageno);
        return "patientsManagement/packaging/views/packingItemsView";
    }
    
    @RequestMapping(value = "/savetodispensepacket")
    @ResponseBody
    String savetodispensepacket(HttpServletRequest request, Model model) {
        String results = "";
        String readypacketsid = (request.getParameter("readypacketsid"));
        String[] columns = {"dispensingstatus"};
        Object[] columnValues = {Boolean.TRUE};
        String pk = "readypacketsid";
        Object pkValue = Long.parseLong(readypacketsid);
        genericClassService.updateRecordSQLSchemaStyle(Readypackets.class, columns, columnValues, pk, pkValue, "store");

        return results;
    }

    @RequestMapping(value = "/viewreadypackets", method = RequestMethod.GET)
    public String viewreadypackets(HttpServletRequest request, Model model) {
        List<Map> packetpacking = new ArrayList<>();
        String packageid = (request.getParameter("packageid"));
        String[] params1 = {"packageid", "dispensingstatus"};
        Object[] paramsValues1 = {BigInteger.valueOf(Long.valueOf(packageid)), Boolean.TRUE};
        String[] fields1 = {"referencenumber", "status", "readypacketsid", "packageid"};
        String where1 = "WHERE packageid=:packageid AND dispensingstatus=:dispensingstatus";
        List<Object[]> found1 = (List<Object[]>) genericClassService.fetchRecord(Readypackets.class, fields1, where1, params1, paramsValues1);
        Map<String, Object> packets;
        if (found1 != null) {
            for (Object[] s : found1) {
                packets = new HashMap<>();
                packets.put("referencenumber", (String) s[0]);
                //FETCH FROM PACKAGES
                String[] params = {"packageid"};
                Object[] paramsValues = { Long.parseLong(s[3].toString()) };
                String[] fields = {"eachpacket", "stockid", "createdby"};
                String where = "WHERE packageid=:packageid";
                List<Object[]> found = (List<Object[]>) genericClassService.fetchRecord(Package.class, fields, where, params, paramsValues);
                if (found != null) {
                    for (Object[] n : found) {
                        packets.put("eachpacket", (Integer) n[0]);
                        //FETCH BATCH NUMBER
                        String[] params2 = {"stockid"};
                        Object[] paramsValues2 = { Long.parseLong(n[1].toString()) };
                        String[] fields2 = {"batchnumber"};
                        String where2 = "WHERE stockid=:stockid";
                        List<String> found2 = (List<String>) genericClassService.fetchRecord(com.iics.store.Stock.class, fields2, where2, params2, paramsValues2);
                        if (found2 != null) {
                            for (String f : found2) {
                                packets.put("batchnumber", f);
                            }
                        }
                    }
                }
                packetpacking.add(packets);
            }
        }
        model.addAttribute("packetpacking", packetpacking);
        return "patientsManagement/packaging/views/readypackets";
    }
    @RequestMapping(value="/bookeditems", method=RequestMethod.GET)
    public ModelAndView bookedItems(HttpServletRequest request){
        Map<String, Object> model = new HashMap<>();
        List<Map<String, Object>> bookedItems = new ArrayList<>();
        try {
            long facilityUnitId = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString());                     
            String [] fields = { "itemid", "fullname", "totalqtypicked", "facilityunitid" };
            String [] params = { "facilityunitid" };
            Object [] paramsValues = { facilityUnitId };
            String where = "WHERE facilityunitid=:facilityunitid";
            List<Object[]> bookedQuantities = (List<Object[]>) genericClassService.fetchRecord(Bookedpackagequantities.class, fields, where, params, paramsValues);
            if(bookedQuantities != null){
                Map<String, Object> bookedItem;
                for(Object [] bookedQuantity : bookedQuantities){
                    String totalItemStock = "0";
                    bookedItem = new HashMap<>();
                    bookedItem.put("itemid", bookedQuantity[0]);                
                    bookedItem.put("itemname", bookedQuantity[1]);                    
                    bookedItem.put("facilityunitid", bookedQuantity[3]);
                    
                    Date today = new Date();
                    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("YYYY");                    
                    Date startDate = formatter.parse((simpleDateFormat.format(today) + "-01-01"));
                    Date endDate = today;
                    Map<String, Object> stockLevel = getItemStockLevel(Integer.valueOf(String.valueOf(facilityUnitId)), Integer.parseInt(bookedQuantity[0].toString()), startDate, endDate);
                    totalItemStock = String.format("%,d", Long.parseLong(stockLevel.get("available").toString()));
                    bookedItem.put("qtybooked", String.format("%s Out Of %s" , bookedQuantity[2], totalItemStock));
                    
                    bookedItems.add(bookedItem);
                }
            }
            model.put("bookedItems", bookedItems);
        } catch(NumberFormatException ex) {
            System.out.println(ex);
        } catch(Exception ex) {
            System.out.println(ex);
        }
        return new ModelAndView("patientsManagement/packaging/views/bookedItems", model);
    }
    private String generateRefNo() {
        String number = "RF";
        String pattern = number + "/%";
        String refno = "";

        String[] params = {"referencenumber"};
        Object[] paramsValues = {pattern};
        String[] fields = {"referencenumber"};
        String where = "WHERE referencenumber LIKE :referencenumber ORDER BY referencenumber DESC LIMIT 1";
        List<String> lastReferenceno = (List<String>) genericClassService.fetchRecord(com.iics.store.Readypackets.class, fields, where, params, paramsValues);
        if (lastReferenceno == null) {
            refno = number + "/0001";
            return refno;
        } else {
            try {
                int lastNo = Integer.parseInt(lastReferenceno.get(0).split("\\/")[1]);
                String newNo = String.valueOf(lastNo + 1);
                switch (newNo.length()) {
                    case 1:
                        refno = number + "/000" + newNo;
                        break;
                    case 2:
                        refno = number + "/00" + newNo;
                        break;
                    case 3:
                        refno = number + "/0" + newNo;
                        break;
                    default:
                        refno = number + "/" + newNo;
                        break;
                }
            } catch (Exception e) {

                System.out.println(e);
            }
        }
        return refno;
    }
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
}
