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
import com.iics.service.GenericClassService;
import com.iics.store.Activitycell;
import com.iics.store.Activitycellitem;
import com.iics.store.Activityfollowup;
import com.iics.store.Bayrowcell;
import com.iics.store.Cellitems;
import com.iics.store.Discrepancy;
import com.iics.store.Item;
import com.iics.store.Itempackage;
import com.iics.store.Itemrecount;
import com.iics.store.Recount;
import com.iics.store.Recountitem;
import com.iics.store.Shelflogstock;
import com.iics.store.Shelfstock;
import com.iics.store.Stockactivity;
import com.iics.store.Stockcount;
import com.iics.store.Unitstoragezones;
import com.iics.utils.IICS;
import com.iics.utils.OsCheck;
import com.iics.utils.ShelfActivityLog;
import com.iics.utils.StockActivityLog;
import com.itextpdf.text.Document;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.tool.xml.XMLWorkerHelper;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.math.BigInteger;
import java.net.URL;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
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

/**
 *
 * @author IICS
 */
@Controller
@RequestMapping("/stock")
public class Stock {

    @Autowired
    GenericClassService genericClassService;
    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    private SimpleDateFormat formatterwithtime = new SimpleDateFormat("yyyy-MM-dd hh:mm aa");
    private Date serverDate = new Date();

    //Stock taking setup
    @RequestMapping(value = "/stockManagementPane", method = RequestMethod.GET)
    public String stockManagementPane(HttpServletRequest request, Model model, @ModelAttribute("tab") String tabid) throws ParseException {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            List<Map> stockActivities = new ArrayList<>();

            Integer facilityUnit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
            String[] params = {"facilityunitid"};
            Object[] paramsValues = {facilityUnit};
            String[] fields = {"stockactivityid", "activityname", "startdate", "enddate", "dateadded"};
            String where = "WHERE facilityunitid=:facilityunitid ORDER BY enddate DESC";
            List<Object[]> activities = (List<Object[]>) genericClassService.fetchRecord(Stockactivity.class, fields, where, params, paramsValues);
            if (activities != null) {
                Date now, start, end;
                now = formatter.parse(formatter.format(new Date()));
                Map<String, Object> activity;
                for (Object[] object : activities) {
                    end = (Date) object[3];
                    start = (Date) object[2];
                    activity = new HashMap<>();
                    activity.put("id", object[0]);
                    activity.put("name", object[1]);
                    activity.put("start", formatter.format(start));
                    activity.put("end", formatter.format(end));
                    activity.put("added", formatter.format((Date) object[3]));
                    if (now.getTime() >= start.getTime() && now.getTime() <= end.getTime()) {
                        activity.put("state", 0);
                        activity.put("days", (end.getTime() - now.getTime()) / (1000 * 60 * 60 * 24));
                    } else if (now.getTime() < start.getTime()) {
                        activity.put("state", 1);
                    } else if (now.getTime() > end.getTime()) {
                        activity.put("state", 2);
                    }
                    String[] params2 = {"stockactivityid"};
                    Object[] paramsValues2 = {object[0]};
                    String where2 = "WHERE stockactivityid=:stockactivityid";
                    int cellCount = genericClassService.fetchRecordCount(Activitycell.class, where2, params2, paramsValues2);
                    activity.put("cells", cellCount);

                    String[] params3 = {"stockactivityid", "activitystatus"};
                    Object[] paramsValues3 = {object[0], "SUBMITTED"};
                    String where3 = "WHERE stockactivityid=:stockactivityid AND activitystatus=:activitystatus";
                    int cellCompletion = genericClassService.fetchRecordCount(Activitycell.class, where3, params3, paramsValues3);
                    activity.put("completion", cellCompletion);
                    stockActivities.add(activity);
                }
            }
            model.addAttribute("tabid", tabid);
            model.addAttribute("activities", stockActivities);
            model.addAttribute("serverdate", formatterwithtime.format(serverDate));
            return "inventoryAndSupplies/stockManagement/stockManagementPane";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/saveStockActivity", method = RequestMethod.POST)
    public @ResponseBody
    String saveStockActivity(HttpServletRequest request, Model model, @ModelAttribute("title") String title, @ModelAttribute("start") String start, @ModelAttribute("end") String end) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null && request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            Long staffid = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
            Integer facilityUnit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
            try {
                Stockactivity activity = new Stockactivity();
                activity.setActivityname(title);
                activity.setStartdate(formatter.parse(start));
                activity.setEnddate(formatter.parse(end));
                activity.setDateadded(new Date());
                activity.setDateupdated(new Date());
                activity.setAddedby(BigInteger.valueOf(staffid));
                activity.setUpdatedby(BigInteger.valueOf(staffid));
                activity.setFacilityunitid(BigInteger.valueOf(facilityUnit.longValue()));
                genericClassService.saveOrUpdateRecordLoadObject(activity);
                return "saved";
            } catch (ParseException e) {
                return "failed";
            }
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/searchCells", method = RequestMethod.GET)
    public String searchCells(HttpServletRequest request, Model model, @ModelAttribute("name") String searchValue, @ModelAttribute("activityid") Integer activityid) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            Integer facilityUnit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
            List<Map> itemsFound = new ArrayList<>();
            String[] params = {"facilityunitid", "value"};
            Object[] paramsValues = {facilityUnit, searchValue.trim().toLowerCase() + "%"};
            String[] fields = {"bayrowcellid", "celllabel", "rowlabel", "baylabel", "zonelabel"};
            String where = "WHERE facilityunitid=:facilityunitid AND (LOWER(celllabel) LIKE :value OR LOWER(rowlabel) LIKE :value OR LOWER(baylabel) LIKE :value OR LOWER(zonelabel) LIKE :value) ORDER BY celllabel";
            List<Object[]> cellList = (List<Object[]>) genericClassService.fetchRecord(Unitstoragezones.class, fields, where, params, paramsValues);
            if (cellList != null) {
                Map<String, Object> item;
                for (Object[] object : cellList) {
                    item = new HashMap<>();
                    item.put("id", object[0]);
                    item.put("name", object[1]);
                    item.put("row", object[2]);
                    item.put("bay", object[3]);
                    item.put("zone", object[4]);
                    itemsFound.add(item);
                }
            }
            String jsonCells = "";
            try {
                jsonCells = new ObjectMapper().writeValueAsString(itemsFound);
            } catch (JsonProcessingException ex) {
                System.out.println(ex);
            }
            model.addAttribute("name", searchValue);
            model.addAttribute("cells", itemsFound);
            model.addAttribute("jsonCells", jsonCells);
            return "inventoryAndSupplies/stockManagement/stockTakingSetup/cellSearchResults";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/saveActivityCells", method = RequestMethod.POST)
    public @ResponseBody
    String saveActivityCells(HttpServletRequest request, Model model, @ModelAttribute("cells") String cellsJSON, @ModelAttribute("activityid") Integer activityid) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            Long staffid = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
            try {
                List cellList = new ObjectMapper().readValue(cellsJSON, List.class);
                for (Object cellid : cellList) {
                    String[] params = {"stockactivityid", "cellid"};
                    Object[] paramsValues = {BigInteger.valueOf(activityid), (Integer) cellid};
                    String where = "WHERE stockactivityid=:stockactivityid AND cellid=:cellid";
                    int catItemCount = genericClassService.fetchRecordCount(Activitycell.class, where, params, paramsValues);
                    if (catItemCount <= 0) {
                        Activitycell cell = new Activitycell();
                        cell.setStockactivityid(new Stockactivity(activityid.longValue()));
                        cell.setCellid(new Bayrowcell((Integer) cellid));
                        cell.setAddedby(BigInteger.valueOf(staffid));
                        cell.setUpdatedby(BigInteger.valueOf(staffid));
                        cell.setDateadded(new Date());
                        cell.setRecount(false);
                        cell.setDateupdated(new Date());
                        cell.setActivitystatus("PENDING");
                        cell.setClosed(false);
                        genericClassService.saveOrUpdateRecordLoadObject(cell);
                    }
                }
                new CloseCells(genericClassService, activityid, cellList).start();
                return "Saved";
            } catch (IOException e) {
                return "Failed";
            }
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchActivityCells", method = RequestMethod.POST)
    public String fetchActivityCells(HttpServletRequest request, Model model, @ModelAttribute("activityid") Integer activityid) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            List<Map> setCells = new ArrayList<>();
            String[] params = {"stockactivityid"};
            Object[] paramsValues = {activityid};
            String[] fields = {"activitycellid", "cellid.bayrowcellid", "cellstaff", "activitystatus"};
            String where = "WHERE stockactivityid=:stockactivityid";
            List<Object[]> cellList = (List<Object[]>) genericClassService.fetchRecord(Activitycell.class, fields, where, params, paramsValues);
            if (cellList != null) {
                Map<String, Object> cell;
                for (Object[] object : cellList) {
                    cell = new HashMap<>();
                    cell.put("id", object[0]);
                    cell.put("status", object[3]);
                    String[] params2 = {"bayrowcellid"};
                    Object[] paramsValues2 = {object[1]};
                    String[] fields2 = {"celllabel", "rowlabel", "baylabel", "zonelabel"};
                    String where2 = "WHERE bayrowcellid=:bayrowcellid";
                    List<Object[]> cellDetails = (List<Object[]>) genericClassService.fetchRecord(Unitstoragezones.class, fields2, where2, params2, paramsValues2);
                    if (cellDetails != null) {
                        cell.put("cell", cellDetails.get(0)[0]);
                        cell.put("row", cellDetails.get(0)[1]);
                        cell.put("bay", cellDetails.get(0)[2]);
                        cell.put("zone", cellDetails.get(0)[3]);
                    }
                    if (object[2] != null && (BigInteger) object[2] != BigInteger.ZERO) {
                        String[] params3 = {"staffid"};
                        Object[] paramsValues3 = {object[2]};
                        String[] fields3 = {"firstname", "othernames", "lastname"};
                        String where3 = "WHERE staffid=:staffid";
                        List<Object[]> staffDetails = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields3, where3, params3, paramsValues3);
                        if (staffDetails != null) {
                            String names;
                            if (staffDetails.get(0)[1] != null) {
                                if (((String) staffDetails.get(0)[1]).length() > 0) {
                                    names = ((String) staffDetails.get(0)[0]).charAt(0) + "." + ((String) staffDetails.get(0)[1]).charAt(0) + " " + staffDetails.get(0)[2];
                                } else {
                                    names = ((String) staffDetails.get(0)[0]).charAt(0) + ". " + staffDetails.get(0)[2];
                                }
                            } else {
                                names = ((String) staffDetails.get(0)[0]).charAt(0) + ". " + staffDetails.get(0)[2];
                            }
                            cell.put("names", names);
                        }
                    } else {
                        cell.put("names", "Not Assigned");
                    }
                    setCells.add(cell);
                }
            }
            Collections.sort(setCells, sortCells);
            model.addAttribute("setCells", setCells);
            return "inventoryAndSupplies/stockManagement/stockTakingSetup/setCells";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/removeActivityCell", method = RequestMethod.POST)
    public @ResponseBody
    String removeActivityCell(HttpServletRequest request, Model model, @ModelAttribute("id") Integer activityCellid) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            String[] params = {"activitycellid"};
            Object[] paramsValues = {BigInteger.valueOf(activityCellid)};
            String where = "WHERE activitycellid=:activitycellid";
            int catItemCount = genericClassService.fetchRecordCount(Activitycellitem.class, where, params, paramsValues);
            if (catItemCount > 0) {
                String[] columns = {"activitycellid"};
                Object[] columnValues = {activityCellid};
                int result = genericClassService.deleteRecordByByColumns("store.activitycellitem", columns, columnValues);
                if (result != 0) {
                    String[] columns2 = {"activitycellid"};
                    Object[] columnValues2 = {activityCellid};
                    genericClassService.deleteRecordByByColumns("store.activitycell", columns2, columnValues2);
                }
            } else {
                String[] columns = {"activitycellid"};
                Object[] columnValues = {activityCellid};
                genericClassService.deleteRecordByByColumns("store.activitycell", columns, columnValues);
            }
            return "deleted";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchActivityUnassignedCells", method = RequestMethod.POST)
    public String fetchActivityUnassignedCells(HttpServletRequest request, Model model, @ModelAttribute("activityid") Integer activityid) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            List<Map> unassignedCells = new ArrayList<>();
            String[] params = {"stockactivityid"};
            Object[] paramsValues = {activityid};
            String[] fields = {"activitycellid", "cellid.bayrowcellid", "cellstaff"};
            String where = "WHERE stockactivityid=:stockactivityid";
            List<Object[]> cellList = (List<Object[]>) genericClassService.fetchRecord(Activitycell.class, fields, where, params, paramsValues);
            if (cellList != null) {
                Map<String, Object> cell;
                for (Object[] object : cellList) {
                    if (object[2] == null || (BigInteger) object[2] == BigInteger.ZERO) {
                        cell = new HashMap<>();
                        cell.put("id", object[0]);
                        String[] params2 = {"bayrowcellid"};
                        Object[] paramsValues2 = {object[1]};
                        String[] fields2 = {"celllabel", "rowlabel", "baylabel", "zonelabel"};
                        String where2 = "WHERE bayrowcellid=:bayrowcellid";
                        List<Object[]> cellDetails = (List<Object[]>) genericClassService.fetchRecord(Unitstoragezones.class, fields2, where2, params2, paramsValues2);
                        if (cellDetails != null) {
                            cell.put("cell", cellDetails.get(0)[0]);
                            cell.put("row", cellDetails.get(0)[1]);
                            cell.put("bay", cellDetails.get(0)[2]);
                            cell.put("zone", cellDetails.get(0)[3]);
                        }
                        unassignedCells.add(cell);
                    }
                }
            }
            Collections.sort(unassignedCells, sortCells);
            String jsonCells = "";
            try {
                jsonCells = new ObjectMapper().writeValueAsString(unassignedCells);
            } catch (JsonProcessingException ex) {
                System.out.println(ex);
            }
            model.addAttribute("activityid", activityid);
            model.addAttribute("unassignedCellsJSON", jsonCells);
            model.addAttribute("unassignedCells", unassignedCells);
            return "inventoryAndSupplies/stockManagement/cellLocations/unassignedCells";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchUnitStaff", method = RequestMethod.POST)
    public String fetchUnitStaff(HttpServletRequest request, Model model, @ModelAttribute("activityid") Integer activityid) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            Integer facilityUnit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
            List<Map> unitStaffList = new ArrayList<>();
            String[] params = {"facilityunitid", "active"};
            Object[] paramsValues = {facilityUnit, true};
            String[] fields = {"staffid"};
            String where = "WHERE facilityunitid=:facilityunitid AND active=:active";
            List<Long> staff = (List<Long>) genericClassService.fetchRecord(Stafffacilityunit.class, fields, where, params, paramsValues);
            if (staff != null) {
                Map<String, Object> staffRec;
                for (Long staffid : staff) {
                    staffRec = new HashMap<>();
                    staffRec.put("id", staffid);
                    String[] params2 = {"staffid"};
                    Object[] paramsValues2 = {BigInteger.valueOf(staffid)};
                    String[] fields2 = {"firstname", "othernames", "lastname"};
                    String where2 = "WHERE staffid=:staffid";
                    List<Object[]> staffDetails = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields2, where2, params2, paramsValues2);
                    if (staffDetails != null) {
                        String names;
                        if (staffDetails.get(0)[1] != null) {
                            names = staffDetails.get(0)[0] + " " + staffDetails.get(0)[1] + " " + staffDetails.get(0)[2];
                        } else {
                            names = staffDetails.get(0)[0] + " " + staffDetails.get(0)[2];
                        }
                        staffRec.put("names", names);
                        String[] params3 = {"cellstaff", "stockactivityid"};
                        Object[] paramsValues3 = {BigInteger.valueOf(staffid), activityid};
                        String where3 = "WHERE stockactivityid=:stockactivityid AND cellstaff=:cellstaff";
                        int cellCount = genericClassService.fetchRecordCount(Activitycell.class, where3, params3, paramsValues3);
                        staffRec.put("cellCount", cellCount);
                        unitStaffList.add(staffRec);
                    }
                }
            }
            model.addAttribute("unitStaffList", unitStaffList);
            return "inventoryAndSupplies/stockManagement/cellLocations/staffSearchResults";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchUnitStaffJSON", method = RequestMethod.POST)
    public @ResponseBody
    String fetchUnitStaffJSON(HttpServletRequest request, Model model) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            Integer facilityUnit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
            List<Map> unitStaffList = new ArrayList<>();
            String[] params = {"facilityunitid", "active"};
            Object[] paramsValues = {facilityUnit, true};
            String[] fields = {"staffid"};
            String where = "WHERE facilityunitid=:facilityunitid AND active=:active";
            List<Long> staff = (List<Long>) genericClassService.fetchRecord(Stafffacilityunit.class, fields, where, params, paramsValues);
            if (staff != null) {
                Map<String, Object> staffRec;
                for (Long staffid : staff) {
                    staffRec = new HashMap<>();
                    staffRec.put("id", staffid);
                    String[] params2 = {"staffid"};
                    Object[] paramsValues2 = {BigInteger.valueOf(staffid)};
                    String[] fields2 = {"firstname", "othernames", "lastname"};
                    String where2 = "WHERE staffid=:staffid";
                    List<Object[]> staffDetails = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields2, where2, params2, paramsValues2);
                    if (staffDetails != null) {
                        String names;
                        if (staffDetails.get(0)[1] != null) {
                            names = staffDetails.get(0)[0] + " " + staffDetails.get(0)[1] + " " + staffDetails.get(0)[2];
                        } else {
                            names = staffDetails.get(0)[0] + " " + staffDetails.get(0)[2];
                        }
                        staffRec.put("names", names);
                        unitStaffList.add(staffRec);
                    }
                }
            }
            String staffList = "[]";
            try {
                staffList = new ObjectMapper().writeValueAsString(unitStaffList);
            } catch (JsonProcessingException ex) {
                System.out.println(ex);
            }
            return staffList;
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/saveStaffAllocations", method = RequestMethod.POST)
    public @ResponseBody
    String saveStaffAllocations(HttpServletRequest request, Model model, @ModelAttribute("cells") String cellsJSON, @ModelAttribute("staffid") Integer cellStaff) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            Long staffid = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
            try {
                List cellList = new ObjectMapper().readValue(cellsJSON, List.class);
                for (Object cellid : cellList) {
                    String[] columns = {"cellstaff", "updatedby", "dateupdated"};
                    Object[] columnValues = {cellStaff, staffid, new Date()};
                    String pk = "activitycellid";
                    Object pkValue = ((Integer) cellid).longValue();
                    genericClassService.updateRecordSQLSchemaStyle(Activitycell.class, columns, columnValues, pk, pkValue, "store");
                }
                return "updated";
            } catch (IOException e) {
                System.out.println(e);
                return "failed";
            }
        }
        return "refresh";
    }

    @RequestMapping(value = "/fetchActivityAssignedCells", method = RequestMethod.POST)
    public String fetchActivityAssignedCells(HttpServletRequest request, Model model, @ModelAttribute("activityid") Integer activityid) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            List<Map> assignedStaff = new ArrayList<>();
            String[] params = {"stockactivityid"};
            Object[] paramsValues = {activityid};
            String[] fields = {"cellstaff"};
            String where = "WHERE stockactivityid=:stockactivityid AND cellstaff > 0 GROUP BY cellstaff";
            List<BigInteger> cellList = (List<BigInteger>) genericClassService.fetchRecord(Activitycell.class, fields, where, params, paramsValues);
            if (cellList != null) {
                Map<String, Object> cell;
                for (BigInteger cellStaffid : cellList) {
                    cell = new HashMap<>();
                    cell.put("id", cellStaffid);
                    String[] params2 = {"stockactivityid", "cellstaff"};
                    Object[] paramsValues2 = {activityid, cellStaffid};
                    String where2 = "WHERE stockactivityid=:stockactivityid AND cellstaff=:cellstaff";
                    int cellCount = genericClassService.fetchRecordCount(Activitycell.class, where2, params2, paramsValues2);
                    cell.put("cellCount", cellCount);

                    String[] params3 = {"staffid"};
                    Object[] paramsValues3 = {cellStaffid};
                    String[] fields3 = {"firstname", "othernames", "lastname"};
                    String where3 = "WHERE staffid=:staffid";
                    List<Object[]> staffDetails = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields3, where3, params3, paramsValues3);
                    if (staffDetails != null) {
                        String names;
                        if (staffDetails.get(0)[1] != null) {
                            names = staffDetails.get(0)[0] + " " + staffDetails.get(0)[1] + " " + staffDetails.get(0)[2];
                        } else {
                            names = staffDetails.get(0)[0] + " " + staffDetails.get(0)[2];
                        }
                        cell.put("names", names);
                    }

                    String[] params4 = {"stockactivityid", "cellstaff", "activitystatus"};
                    Object[] paramsValues4 = {activityid, cellStaffid, "SUBMITTED"};
                    String where4 = "WHERE stockactivityid=:stockactivityid AND cellstaff=:cellstaff AND activitystatus=:activitystatus";
                    int cellCompletion = genericClassService.fetchRecordCount(Activitycell.class, where4, params4, paramsValues4);
                    cell.put("completion", ((float) cellCompletion / (float) cellCount) * 100);
                    assignedStaff.add(cell);
                }
            }
            model.addAttribute("assignedStaff", assignedStaff);
            return "inventoryAndSupplies/stockManagement/cellLocations/assignedStaff";
        }
        return "refresh";
    }

    @RequestMapping(value = "/fetchStaffCells", method = RequestMethod.POST)
    public String fetchStaffCells(HttpServletRequest request, Model model, @ModelAttribute("staffid") Integer staffid, @ModelAttribute("activityid") Integer activityid) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            List<Map> staffCells = new ArrayList<>();
            String[] params = {"stockactivityid", "cellstaff"};
            Object[] paramsValues = {BigInteger.valueOf(activityid.longValue()), BigInteger.valueOf(staffid.longValue())};
            String[] fields = {"activitycellid", "cellid.bayrowcellid", "activitystatus"};
            String where = "WHERE stockactivityid=:stockactivityid AND cellstaff=:cellstaff";
            List<Object[]> cellList = (List<Object[]>) genericClassService.fetchRecord(Activitycell.class, fields, where, params, paramsValues);
            if (cellList != null) {
                Map<String, Object> cell;
                for (Object[] cellid : cellList) {
                    cell = new HashMap<>();
                    cell.put("id", cellid[0]);
                    cell.put("status", cellid[2]);
                    String[] params2 = {"bayrowcellid"};
                    Object[] paramsValues2 = {cellid[1]};
                    String[] fields2 = {"celllabel", "rowlabel", "baylabel", "zonelabel"};
                    String where2 = "WHERE bayrowcellid=:bayrowcellid";
                    List<Object[]> cellDetails = (List<Object[]>) genericClassService.fetchRecord(Unitstoragezones.class, fields2, where2, params2, paramsValues2);
                    if (cellDetails != null) {
                        cell.put("cell", cellDetails.get(0)[0]);
                        cell.put("row", cellDetails.get(0)[1]);
                        cell.put("bay", cellDetails.get(0)[2]);
                        cell.put("zone", cellDetails.get(0)[3]);
                    }
                    staffCells.add(cell);
                }
            }
            Collections.sort(staffCells, sortCells);
            model.addAttribute("staffCells", staffCells);
            return "inventoryAndSupplies/stockManagement/cellLocations/staffCells";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/unassignStaffCell", method = RequestMethod.POST)
    public @ResponseBody
    String unassignStaffCell(HttpServletRequest request, Model model, @ModelAttribute("id") Integer activitycellid) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            Long staffid = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");

            String[] columns = {"cellstaff", "updatedby", "dateupdated"};
            Object[] columnValues = {BigInteger.ZERO, staffid, new Date()};
            String pk = "activitycellid";
            Object pkValue = BigInteger.valueOf(activitycellid.longValue());
            int result = genericClassService.updateRecordSQLSchemaStyle(Activitycell.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                return "updated";
            } else {
                return "failed";
            }
        } else {
            return "refresh";
        }
    }

    //Stock taking activities
    @RequestMapping(value = "/stockTakingPane", method = RequestMethod.GET)
    public String stockTakingPane(HttpServletRequest request, Model model, @ModelAttribute("tab") String tabid) throws ParseException {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null && request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            Long staffid = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
            List<Map> stockActivities = new ArrayList<>();

            Integer facilityUnit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
            String[] params = {"facilityunitid"};
            Object[] paramsValues = {facilityUnit};
            String[] fields = {"stockactivityid", "activityname", "enddate"};
            String where = "WHERE facilityunitid=:facilityunitid AND enddate >= date 'now' ORDER BY enddate DESC";
            List<Object[]> activities = (List<Object[]>) genericClassService.fetchRecord(Stockactivity.class, fields, where, params, paramsValues);
            if (activities != null) {
                Map<String, Object> activity;
                for (Object[] object : activities) {
                    String[] params2 = {"stockactivityid", "cellstaff"};
                    Object[] paramsValues2 = {object[0], staffid};
                    String where2 = "WHERE stockactivityid=:stockactivityid AND cellstaff=:cellstaff";
                    int cellCount = genericClassService.fetchRecordCount(Activitycell.class, where2, params2, paramsValues2);
                    if (cellCount > 0) {
                        activity = new HashMap<>();
                        activity.put("id", object[0]);
                        activity.put("name", object[1]);
                        activity.put("end", ((Date) object[2]).getTime());
                        stockActivities.add(activity);
                    }
                }
            }
            model.addAttribute("tabid", tabid);
            model.addAttribute("activities", stockActivities);
            model.addAttribute("serverdate", formatterwithtime.format(serverDate));
            return "inventoryAndSupplies/stockTaking/stockTakingPane";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchStaffCellAllocation", method = RequestMethod.POST)
    public String fetchStaffCellAllocation(HttpServletRequest request, Model model, @ModelAttribute("activityid") Integer activityid) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            Long staffid = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
            List<Map> staffCells = new ArrayList<>();
            String[] params = {"stockactivityid", "cellstaff"};
            Object[] paramsValues = {BigInteger.valueOf(activityid.longValue()), BigInteger.valueOf(staffid)};
            String[] fields = {"activitycellid", "cellid.bayrowcellid"};
            String where = "WHERE stockactivityid=:stockactivityid AND cellstaff=:cellstaff";
            List<Object[]> cellList = (List<Object[]>) genericClassService.fetchRecord(Activitycell.class, fields, where, params, paramsValues);
            if (cellList != null) {
                Map<String, Object> cell;
                for (Object[] cellid : cellList) {
                    cell = new HashMap<>();
                    cell.put("id", cellid[0]);
                    String[] params2 = {"bayrowcellid"};
                    Object[] paramsValues2 = {cellid[1]};
                    String[] fields2 = {"celllabel", "rowlabel", "baylabel", "zonelabel"};
                    String where2 = "WHERE bayrowcellid=:bayrowcellid";
                    List<Object[]> cellDetails = (List<Object[]>) genericClassService.fetchRecord(Unitstoragezones.class, fields2, where2, params2, paramsValues2);
                    if (cellDetails != null) {
                        cell.put("cell", cellDetails.get(0)[0]);
                        cell.put("row", cellDetails.get(0)[1]);
                        cell.put("bay", cellDetails.get(0)[2]);
                        cell.put("zone", cellDetails.get(0)[3]);
                    }
                    staffCells.add(cell);
                }
            }
            Collections.sort(staffCells, sortCells);
            model.addAttribute("staffCells", staffCells);
            return "inventoryAndSupplies/stockTaking/locations/staffCells";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchCounter", method = RequestMethod.POST)
    public String fetchCounter(HttpServletRequest request, Model model, @ModelAttribute("time") Long time) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            model.addAttribute("time", time);
            return "inventoryAndSupplies/stockTaking/locations/timer";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchStaffAssignedCells", method = RequestMethod.POST)
    public String fetchStaffAssignedCells(HttpServletRequest request, Model model, @ModelAttribute("activityid") Integer activityid) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            Long staffid = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
            List<Map> staffCells = new ArrayList<>();
            String[] params = {"stockactivityid", "cellstaff"};
            Object[] paramsValues = {BigInteger.valueOf(activityid.longValue()), BigInteger.valueOf(staffid)};
            String[] fields = {"activitycellid", "cellid.bayrowcellid", "activitystatus"};
            String where = "WHERE stockactivityid=:stockactivityid AND cellstaff=:cellstaff";
            List<Object[]> cellList = (List<Object[]>) genericClassService.fetchRecord(Activitycell.class, fields, where, params, paramsValues);
            if (cellList != null) {
                Map<String, Object> cell;
                for (Object[] cellid : cellList) {
                    cell = new HashMap<>();
                    cell.put("id", cellid[0]);
                    String[] params2 = {"bayrowcellid"};
                    Object[] paramsValues2 = {cellid[1]};
                    String[] fields2 = {"celllabel"};
                    String where2 = "WHERE bayrowcellid=:bayrowcellid";
                    List<String> cellLabel = (List<String>) genericClassService.fetchRecord(Unitstoragezones.class, fields2, where2, params2, paramsValues2);
                    if (cellLabel != null) {
                        cell.put("cell", cellLabel.get(0));
                    }

                    String[] params3 = {"activitycellid"};
                    Object[] paramsValues3 = {cellid[0]};
                    String[] fields3 = {"itemid.itemid"};
                    String where3 = "WHERE activitycellid=:activitycellid";
                    List items = genericClassService.fetchRecord(Activitycellitem.class, fields3, where3, params3, paramsValues3);
                    if (items != null) {
                        Set itemSet = new HashSet(items);
                        cell.put("itemCount", String.format("%,d", itemSet.size()));
                    } else {
                        cell.put("itemCount", 0);
                    }
                    cell.put("status", cellid[2]);
                    staffCells.add(cell);
                }
            }
            Collections.sort(staffCells, sortCells);
            model.addAttribute("staffCells", staffCells);
            return "inventoryAndSupplies/stockTaking/counting/assignedCells";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/searchStock", method = RequestMethod.GET)
    public String searchStock(HttpServletRequest request, Model model, @ModelAttribute("name") String searchValue) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            List<Map> itemsFound = new ArrayList<>();
            String[] params = {"isactive", "value"};
            Object[] paramsValues = {true, searchValue.trim().toLowerCase() + "%"};
            String[] fields = {"itempackageid", "packagename", "categoryname"};
            String where = "WHERE isactive=:isactive AND (LOWER(packagename) LIKE :value OR LOWER(itemcode) LIKE :value) ORDER BY packagename";
            List<Object[]> cellList = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields, where, params, paramsValues);
            if (cellList != null) {
                Map<String, Object> item;
                for (Object[] object : cellList) {
                    item = new HashMap<>();
                    item.put("id", object[0]);
                    item.put("name", object[1]);
                    itemsFound.add(item);
                }
            }
            model.addAttribute("name", searchValue);
            model.addAttribute("items", itemsFound);
            return "inventoryAndSupplies/stockTaking/counting/itemSearchResults";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/saveCellItemCount", method = RequestMethod.POST)
    public @ResponseBody
    String saveCellItemCount(HttpServletRequest request, Model model, @ModelAttribute("items") String items) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            try {
                List<Map> countedItems = new ObjectMapper().readValue(items, List.class);
                for (Map item : countedItems) {
                    String[] params;
                    Object[] paramsValues;
                    String where;
                    if (item.get("batch") == "") {
                        params = new String[]{"itemid", "cellid"};
                        paramsValues = new Object[]{Long.parseLong(item.get("itemid").toString()), Long.parseLong(item.get("activitycell").toString())};
                        where = "WHERE itemid=:itemid AND cellid=:cellid";
                    } else {
                        params = new String[]{"itemid", "activitycellid", "batchnumber"};
                        paramsValues = new Object[]{Long.parseLong(item.get("itemid").toString()), Long.parseLong(item.get("activitycell").toString()), item.get("batch").toString()};
                        where = "WHERE itemid=:itemid AND activitycellid=:activitycellid AND batchnumber=:batchnumber";
                    }
                    String[] fields = {"activitycellitemid", "countedstock"};
                    List<Object[]> activityCell = (List<Object[]>) genericClassService.fetchRecord(Activitycellitem.class, fields, where, params, paramsValues);
                    if (activityCell != null) {
                        String[] columns = {"countedstock", "dateadded"};
                        Object[] columnValues = {(Integer) activityCell.get(0)[1] + Integer.parseInt(item.get("quantity").toString()), new Date()};
                        String pk = "activitycellitemid";
                        Object pkValue = activityCell.get(0)[0];
                        genericClassService.updateRecordSQLSchemaStyle(Activitycellitem.class, columns, columnValues, pk, pkValue, "store");
                    } else {
                        try {
                            Activitycellitem cellItem = new Activitycellitem();
                            cellItem.setActivitycellid(new Activitycell(Long.parseLong(item.get("activitycell").toString())));
                            cellItem.setBatchnumber(item.get("batch").toString());
                            cellItem.setCountedstock(Integer.parseInt(item.get("quantity").toString()));
                            cellItem.setItemid(new Item(Long.parseLong(item.get("itemid").toString())));
                            cellItem.setExpirydate(formatter.parse(item.get("expiry").toString()));
                            cellItem.setDateadded(new Date());
                            genericClassService.saveOrUpdateRecordLoadObject(cellItem);
                        } catch (ParseException ex) {
                            System.out.println(ex);
                        }
                    }
                }
                return "saved";
            } catch (IOException e) {
                return "failed";
            }
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchCellCountedItems", method = RequestMethod.GET)
    public String fetchCellCountedItems(HttpServletRequest request, Model model, @ModelAttribute("cellid") Integer cellid) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            List<Map> itemsCounted = new ArrayList<>();
            String[] params = {"activitycellid"};
            Object[] paramsValues = {cellid};
            String[] fields = {"activitycellitemid", "itemid.itemid", "countedstock", "batchnumber", "expirydate", "dateadded"};
            String where = "WHERE activitycellid=:activitycellid";
            List<Object[]> cellList = (List<Object[]>) genericClassService.fetchRecord(Activitycellitem.class, fields, where, params, paramsValues);
            if (cellList != null) {
                Map<String, Object> item;
                for (Object[] object : cellList) {
                    item = new HashMap<>();
                    item.put("id", object[0]);
                    String[] params2 = {"itempackageid"};
                    Object[] paramsValues2 = {object[1]};
                    String[] fields2 = {"packagename"};
                    String where2 = "WHERE itempackageid=:itempackageid";
                    List<String> itemName = (List<String>) genericClassService.fetchRecord(Itempackage.class, fields2, where2, params2, paramsValues2);
                    if (itemName != null) {
                        item.put("name", itemName.get(0));
                    }
                    item.put("count", String.format("%,d", (Integer) object[2]));
                    item.put("batch", object[3]);
                    if (object[4] != null) {
                        item.put("expiry", formatter.format((Date) object[4]));
                    } else {
                        item.put("expiry", "");
                    }
                    item.put("entry", formatter.format((Date) object[5]));
                    itemsCounted.add(item);
                }
            }
            model.addAttribute("items", itemsCounted);
            return "inventoryAndSupplies/stockTaking/counting/countedItems";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/submitActivityCell", method = RequestMethod.POST)
    public @ResponseBody
    String submitActivityCell(HttpServletRequest request, Model model, @ModelAttribute("cellid") Integer cellid) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            String[] columns = {"activitystatus", "dateupdated"};
            Object[] columnValues = {"SUBMITTED", new Date()};
            String pk = "activitycellid";
            Object pkValue = cellid.longValue();
            int result = genericClassService.updateRecordSQLSchemaStyle(Activitycell.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                return "updated";
            } else {
                return "failed";
            }
        }
        return "refresh";
    }

    @RequestMapping(value = "/fetchActivityCellSummary", method = RequestMethod.POST)
    public String fetchActivityCellSummary(HttpServletRequest request, Model model, @ModelAttribute("activityid") Integer activityid) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            Date startDate;
            List<Map> activityCells = new ArrayList<>();
            String[] params = {"stockactivityid"};
            Object[] paramsValues = {activityid};
            String[] fields = {"activitycellid", "cellid.bayrowcellid", "recount", "closed", "closedby"};
            String where = "WHERE stockactivityid=:stockactivityid";
            List<Object[]> cellList = (List<Object[]>) genericClassService.fetchRecord(Activitycell.class, fields, where, params, paramsValues);
            if (cellList != null) {
                Map<String, Object> cell;
                String[] params1 = {"stockactivityid"};
                Object[] paramsValues1 = {activityid};
                String[] fields1 = {"startdate"};
                String where1 = "WHERE stockactivityid=:stockactivityid";
                List<Date> activityStartDate = (List<Date>) genericClassService.fetchRecord(Stockactivity.class, fields1, where1, params1, paramsValues1);
                if (activityStartDate != null) {
                    startDate = activityStartDate.get(0);
                    for (Object[] cellDetails : cellList) {
                        cell = new HashMap<>();
                        cell.put("activitycellid", cellDetails[0]);
                        cell.put("cellid", cellDetails[1]);
                        cell.put("recount", cellDetails[2]);
                        cell.put("closed", cellDetails[3]);
                        String[] params2 = {"bayrowcellid"};
                        Object[] paramsValues2 = {cellDetails[1]};
                        String[] fields2 = {"celllabel"};
                        String where2 = "WHERE bayrowcellid=:bayrowcellid";
                        List<String> cellLabel = (List<String>) genericClassService.fetchRecord(Unitstoragezones.class, fields2, where2, params2, paramsValues2);
                        if (cellLabel != null) {
                            cell.put("cell", cellLabel.get(0));
                        }

                        String[] params3 = {"activitycellid"};
                        Object[] paramsValues3 = {cellDetails[0]};
                        String[] fields3 = {"COUNT(DISTINCT r.itemid.itemid)"};
                        String where3 = "WHERE activitycellid=:activitycellid";
                        List counted = genericClassService.fetchRecordFunction(Activitycellitem.class, fields3, where3, params3, paramsValues3, 0, 0);
                        if (counted != null) {
                            cell.put("count", String.format("%,d", Long.parseLong(counted.get(0).toString())));
                        } else {
                            cell.put("count", (long) 0);
                        }
                        int available = 0;
                        List<Map> itemSet = new ArrayList<>();
                        String[] params4 = {"cellid", "activityStartDate"};
                        Object[] paramsValues4 = {cellDetails[1], startDate};
                        String[] fields4 = {"r.itemid", "SUM(r.quantity)", "r.logtype"};
                        String where4 = "WHERE cellid=:cellid AND datelogged<=:activityStartDate GROUP BY r.itemid,r.logtype";
                        List<Object[]> stockItems = (List<Object[]>) genericClassService.fetchRecordFunction(Shelflogstock.class, fields4, where4, params4, paramsValues4, 0, 0);
                        if (stockItems != null) {
                            Map<String, Object> item;
                            for (Object[] itm : stockItems) {
                                boolean found = false;
                                for (int i = 0; i < itemSet.size(); i++) {
                                    if ((itemSet.get(i).get("itemid").toString()).equalsIgnoreCase(itm[0].toString())) {
                                        long balance = Long.parseLong(itemSet.get(i).get("balance").toString());
                                        if ("TRA".equalsIgnoreCase((String) itm[2]) || "OUT".equalsIgnoreCase((String) itm[2]) || "DISC".equalsIgnoreCase((String) itm[2])) {
                                            itemSet.get(i).put("balance", balance - Long.parseLong(itm[1].toString()));
                                        } else {
                                            itemSet.get(i).put("balance", balance + Long.parseLong(itm[1].toString()));
                                        }
                                        found = true;
                                        break;
                                    }
                                }
                                if (!found) {
                                    item = new HashMap<>();
                                    item.put("itemid", (BigInteger) itm[0]);
                                    long balance = 0;
                                    if ("TRA".equalsIgnoreCase((String) itm[2]) || "OUT".equalsIgnoreCase((String) itm[2]) || "DISC".equalsIgnoreCase((String) itm[2])) {
                                        item.put("balance", balance - Long.parseLong(itm[1].toString()));
                                    } else {
                                        item.put("balance", balance + Long.parseLong(itm[1].toString()));
                                    }
                                    itemSet.add(item);
                                }
                            }
                        }
                        for (int i = 0; i < itemSet.size(); i++) {
                            if (Long.parseLong(itemSet.get(i).get("balance").toString()) > 0) {
                                available = available + 1;
                            }
                        }
                        cell.put("expected", String.format("%,d", available));
                        if ((boolean) cellDetails[3]) {
                            String[] params5 = {"staffid"};
                            Object[] paramsValues5 = {cellDetails[4]};
                            String[] fields5 = {"firstname", "othernames", "lastname"};
                            String where5 = "WHERE staffid=:staffid";
                            List<Object[]> staff = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields5, where5, params5, paramsValues5);
                            if (staff != null) {
                                String names;
                                if (staff.get(0)[1] != null) {
                                    if (((String) staff.get(0)[1]).length() > 0) {
                                        names = ((String) staff.get(0)[0]).charAt(0) + "." + ((String) staff.get(0)[1]).charAt(0) + " " + staff.get(0)[2];
                                    } else {
                                        names = ((String) staff.get(0)[0]).charAt(0) + ". " + staff.get(0)[2];
                                    }
                                } else {
                                    names = ((String) staff.get(0)[0]).charAt(0) + ". " + staff.get(0)[2];
                                }
                                cell.put("review", names);
                            }
                        }
                        activityCells.add(cell);
                    }
                }
            }
            Collections.sort(activityCells, sortCells);
            model.addAttribute("cells", activityCells);
            return "inventoryAndSupplies/stockManagement/stockCount/cellSummary";
        }
        return "refresh";
    }

    @RequestMapping(value = "/fetchCellCountDetails", method = RequestMethod.POST)
    public String fetchCellCountDetails(HttpServletRequest request, @ModelAttribute("activityid") Integer activityid, Model model, @ModelAttribute("activitycellid") Integer activitycellid, @ModelAttribute("cellid") Integer cellid) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            Date startDate = null;
            List<Map> itemSet = new ArrayList<>();
            String[] params = {"stockactivityid"};
            Object[] paramsValues = {activityid};
            String[] fields = {"startdate"};
            String where = "WHERE stockactivityid=:stockactivityid";
            List<Date> activityStartDate = (List<Date>) genericClassService.fetchRecord(Stockactivity.class, fields, where, params, paramsValues);
            if (activityStartDate != null) {
                startDate = activityStartDate.get(0);
                String[] params3 = {"cellid", "activityStartDate"};
                Object[] paramsValues3 = {cellid, startDate};
                String[] fields3 = {"r.itemid", "r.packagename", "SUM(r.quantity)", "r.logtype"};
//                String where3 = "WHERE cellid=:cellid AND datelogged <=:activityStartDate GROUP BY r.itemid,r.packagename,r.logtype";
                String where3 = "WHERE cellid=:cellid AND CAST(datelogged AS DATE)<=:activityStartDate GROUP BY r.itemid,r.packagename,r.logtype";
                List<Object[]> stockItems = (List<Object[]>) genericClassService.fetchRecordFunction(Shelflogstock.class, fields3, where3, params3, paramsValues3, 0, 0);
                if (stockItems != null) {
                    Map<String, Object> item;
                    for (Object[] itm : stockItems) {
                        boolean found = false;
                        for (int i = 0; i < itemSet.size(); i++) {
                            if ((itemSet.get(i).get("itemid").toString()).equalsIgnoreCase(itm[0].toString())) {
                                long balance = Long.parseLong(itemSet.get(i).get("balance").toString());
                                if ("TRA".equalsIgnoreCase((String) itm[3]) || "OUT".equalsIgnoreCase((String) itm[3]) || "DISC".equalsIgnoreCase((String) itm[3])) {
                                    itemSet.get(i).put("balance", balance - Long.parseLong(itm[2].toString()));
                                } else {
                                    itemSet.get(i).put("balance", balance + Long.parseLong(itm[2].toString()));
                                }
                                found = true;
                                break;
                            }
                        }
                        if (!found) {
                            item = new HashMap<>();
                            item.put("itemid", (BigInteger) itm[0]);
                            item.put("itemname", (String) itm[1]);
                            item.put("batches", new ArrayList<>());
                            long balance = 0;
                            if ("TRA".equalsIgnoreCase((String) itm[3]) || "OUT".equalsIgnoreCase((String) itm[3]) || "DISC".equalsIgnoreCase((String) itm[3])) {
                                item.put("balance", balance - Long.parseLong(itm[2].toString()));
                            } else {
                                item.put("balance", balance + Long.parseLong(itm[2].toString()));
                            }
                            itemSet.add(item);
                        }
                    }
                }
            }
            List<Map> allItems = new ArrayList<>(itemSet);
            if (startDate != null) {
                List<Map> empty = new ArrayList<>();
                for (int i = 0; i < allItems.size(); i++) {
                    if (Long.parseLong(allItems.get(i).get("balance").toString()) > 0) {
                        long expected = 0;
                        String[] params2 = {"itemid", "cellid", "activityStartDate"};
                        Object[] paramsValues2 = {allItems.get(i).get("itemid"), BigInteger.valueOf(cellid.longValue()), startDate};
                        String[] fields2 = {"r.batchnumber", "SUM(r.quantity)", "r.logtype", "r.expirydate"};
//                        String where2 = "WHERE itemid=:itemid AND cellid=:cellid AND datelogged <=:activityStartDate GROUP BY r.batchnumber,r.expirydate,r.logtype ORDER BY r.expirydate";
                        String where2 = "WHERE itemid=:itemid AND cellid=:cellid AND CAST(datelogged AS DATE)<=:activityStartDate GROUP BY r.batchnumber,r.expirydate,r.logtype ORDER BY r.expirydate";
                        List<Object[]> stockIn = genericClassService.fetchRecordFunction(Shelflogstock.class, fields2, where2, params2, paramsValues2, 0, 0);
                        if (stockIn != null) {
                            Map<String, Object> batch;
                            List<Map> batches = (List<Map>) allItems.get(i).get("batches");
                            for (Object[] stock : stockIn) {
                                String batchNo;
                                if (stock[0] != null) {
                                    batchNo = (String) stock[0];
                                } else {
                                    batchNo = "-";
                                }
                                boolean found = false;
                                for (int j = 0; j < batches.size(); j++) {
                                    if (batchNo.equalsIgnoreCase((String) batches.get(j).get("batch"))) {
                                        long qty = Long.parseLong(batches.get(j).get("expected").toString());
                                        if ("TRA".equalsIgnoreCase((String) stock[2]) || "OUT".equalsIgnoreCase((String) stock[2]) || "DISC".equalsIgnoreCase((String) stock[2])) {
                                            batches.get(j).put("expected", qty - Long.parseLong(stock[1].toString()));
                                            expected = expected - Long.parseLong(stock[1].toString());
                                        } else {
                                            batches.get(j).put("expected", qty + Long.parseLong(stock[1].toString()));
                                            expected = expected + Long.parseLong(stock[1].toString());
                                        }
                                        found = true;
                                        break;
                                    }
                                }
                                if (!found) {
                                    batch = new HashMap<>();
                                    batch.put("batch", batchNo);
                                    if ("TRA".equalsIgnoreCase((String) stock[2]) || "OUT".equalsIgnoreCase((String) stock[2]) || "DISC".equalsIgnoreCase((String) stock[2])) {
                                        batch.put("expected", 0 - Long.parseLong(stock[1].toString()));
                                        expected = expected - Long.parseLong(stock[1].toString());
                                    } else {
                                        batch.put("expected", 0 + Long.parseLong(stock[1].toString()));
                                        expected = expected + Long.parseLong(stock[1].toString());
                                    }
                                    batch.put("counted", (long) 0);
                                    batch.put("expiry", formatter.format((Date) stock[3]));
                                    batches.add(batch);
                                }
                            }
                            allItems.get(i).put("batches", batches);
                        }
                        allItems.get(i).put("counted", (long) 0);
                        allItems.get(i).put("expected", expected);
                    } else {
                        empty.add(allItems.get(i));
                    }
                }
                allItems.removeAll(empty);
                String[] params2 = {"activitycellid"};
                Object[] paramsValues2 = {activitycellid};
                String[] fields2 = {"r.itemid", "r.packagename", "r.batchnumber", "SUM(r.countedstock)", "r.expirydate"};
                String where2 = "WHERE activitycellid=:activitycellid GROUP BY r.itemid,r.packagename,r.batchnumber,r.expirydate ORDER BY r.expirydate";
                List<Object[]> stockCounted = genericClassService.fetchRecordFunction(Stockcount.class, fields2, where2, params2, paramsValues2, 0, 0);
                if (stockCounted != null) {
                    String batchNo;
                    Map<String, Object> newItem;
                    for (Object[] count : stockCounted) {
                        Map<String, Object> batch;
                        if (count[2] != null) {
                            batchNo = (String) count[2];
                        } else {
                            batchNo = "-";
                        }
                        boolean itemFound = false;
                        for (int i = 0; i < allItems.size(); i++) {
                            if ((allItems.get(i).get("itemid").toString()).equalsIgnoreCase(count[0].toString())) {
                                List<Map> batches = (List<Map>) allItems.get(i).get("batches");
                                boolean found = false;
                                for (int j = 0; j < batches.size(); j++) {
                                    if (batchNo.equalsIgnoreCase((String) batches.get(j).get("batch"))) {
                                        batches.get(j).put("counted", Long.parseLong(count[3].toString()));
                                        found = true;
                                        break;
                                    }
                                }
                                if (!found) {
                                    batch = new HashMap<>();
                                    batch.put("batch", batchNo);
                                    batch.put("expected", (long) 0);
                                    batch.put("counted", Long.parseLong(count[3].toString()));
                                    batch.put("expiry", formatter.format((Date) count[4]));
                                    batches.add(batch);
                                }
                                long qty = Long.parseLong(allItems.get(i).get("counted").toString());
                                allItems.get(i).put("batches", batches);
                                allItems.get(i).put("counted", Long.parseLong(count[3].toString()) + qty);
                                itemFound = true;
                                break;
                            }
                        }
                        if (!itemFound) {
                            //Create new item
                            newItem = new HashMap<>();
                            newItem.put("itemid", (BigInteger) count[0]);
                            newItem.put("itemname", (String) count[1]);
                            //Add count to batch
                            List<Map> batches = new ArrayList<>();
                            batch = new HashMap<>();
                            batch.put("batch", batchNo);
                            batch.put("expected", 0);
                            batch.put("counted", Long.parseLong(count[3].toString()));
                            batch.put("expiry", formatter.format((Date) count[4]));
                            batches.add(batch);
                            //Add batch to items.
                            newItem.put("expected", 0);
                            newItem.put("batches", batches);
                            newItem.put("counted", Long.parseLong(count[3].toString()));
                            allItems.add(newItem);
                        }
                    }
                }
            }
            String[] params9 = {"activitycellid"};
            Object[] paramsValues9 = {activitycellid};
            String[] fields9 = {"closed", "recount"};
            String where9 = "WHERE activitycellid=:activitycellid";
            List<Object[]> cellStatus = (List<Object[]>) genericClassService.fetchRecord(Activitycell.class, fields9, where9, params9, paramsValues9);
            if (cellStatus != null) {
                model.addAttribute("closed", cellStatus.get(0)[0]);
                model.addAttribute("recount", cellStatus.get(0)[1]);
            }
            Collections.sort(allItems, sortItems);
            model.addAttribute("cellid", cellid);
            model.addAttribute("items", allItems);
            model.addAttribute("activitycellid", activitycellid);
            return "inventoryAndSupplies/stockManagement/stockCount/cellItems";
        }
        return "refresh";
    }

    @RequestMapping(value = "/saveRecount", method = RequestMethod.POST)
    public @ResponseBody
    String saveRecount(HttpServletRequest request, Model model, @ModelAttribute("itemid") Integer itemid, @ModelAttribute("activitycellid") Integer activitycellid, @ModelAttribute("staffid") Integer staffid) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            Long curUser = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
            Recount recount = new Recount();
            recount.setReviewed(false);
            recount.setActivitycellid(new Activitycell(activitycellid.longValue()));
            recount.setItemid(new Item(itemid.longValue()));
            recount.setStaff(BigInteger.valueOf(staffid.longValue()));
            recount.setStatus("PENDING");
            recount.setDateissued(new Date());
            recount.setIssuedby(BigInteger.valueOf(curUser));
            recount = (Recount) genericClassService.saveOrUpdateRecordLoadObject(recount);
            if (recount.getRecountid() != null) {
                String[] columns = {"recount"};
                Object[] columnValues = {true};
                String pk = "activitycellid";
                Object pkValue = activitycellid.longValue();
                genericClassService.updateRecordSQLSchemaStyle(Activitycell.class, columns, columnValues, pk, pkValue, "store");
                return "saved";
            } else {
                return "failed";
            }
        }
        return "refresh";
    }

    @RequestMapping(value = "/closeCell", method = RequestMethod.POST)
    public @ResponseBody
    String closeCell(HttpServletRequest request, Model model, @ModelAttribute("activitycellid") Integer activitycellid, @ModelAttribute("cellid") Integer cellid) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            Long curUser = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");

            String[] columns = {"closed", "closedby"};
            Object[] columnValues = {true, curUser};
            String pk = "activitycellid";
            Object pkValue = activitycellid.longValue();
            int result = genericClassService.updateRecordSQLSchemaStyle(Activitycell.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                String[] columns2 = {"cellstate"};
                Object[] columnValues2 = {false};
                String pk2 = "bayrowcellid";
                Object pkValue2 = cellid.longValue();
                int update = genericClassService.updateRecordSQLSchemaStyle(Bayrowcell.class, columns2, columnValues2, pk2, pkValue2, "store");
                if (update != 0) {
                    return "saved";
                }
            }
            return "failed";
        }
        return "refresh";
    }

    @RequestMapping(value = "/fetchRecountItems", method = RequestMethod.POST)
    public String fetchRecountItems(HttpServletRequest request, Model model) throws JsonProcessingException {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            List<Map> assignedItems = new ArrayList<>();
            Long staff = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
            String[] params = {"staff", "reviewed"};
            Object[] paramsValues = {BigInteger.valueOf(staff), false};
            String[] fields = {"recountid", "activitycellid", "itemid.itemid", "status"};
            String where = "WHERE staff=:staff AND reviewed=:reviewed";
            List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Recount.class, fields, where, params, paramsValues);
            if (items != null) {
                Map<String, Object> item;
                for (Object[] rec : items) {
                    item = new HashMap<>();
                    item.put("id", rec[0]);
                    item.put("status", rec[3]);
                    String[] params2 = {"recountid"};
                    Object[] paramsValues2 = {rec[0]};
                    String[] fields2 = {"countedstock"};
                    String where2 = "WHERE recountid=:recountid";
                    List<Integer> recounts = (List<Integer>) genericClassService.fetchRecord(Recountitem.class, fields2, where2, params2, paramsValues2);
                    if (recounts != null) {
                        int sum = 0;
                        for (Integer recount : recounts) {
                            sum = sum + recount;
                        }
                        item.put("qty", String.format("%,d", sum));
                    } else {
                        item.put("qty", String.format("%,d", 0));
                    }

                    String[] params3 = {"itempackageid"};
                    Object[] paramsValues3 = {rec[2]};
                    String[] fields3 = {"packagename"};
                    String where3 = "WHERE itempackageid=:itempackageid";
                    List<String> itemName = (List<String>) genericClassService.fetchRecord(Itempackage.class, fields3, where3, params3, paramsValues3);
                    if (itemName != null) {
                        item.put("name", itemName.get(0));
                    }

                    String[] params4 = {"activitycellid"};
                    Object[] paramsValues4 = {rec[1]};
                    String[] fields4 = {"cellid.bayrowcellid"};
                    String where4 = "WHERE activitycellid=:activitycellid";
                    List<BigInteger> cellDetails = (List<BigInteger>) genericClassService.fetchRecord(Activitycell.class, fields4, where4, params4, paramsValues4);
                    if (cellDetails != null) {
                        String[] params5 = {"bayrowcellid"};
                        Object[] paramsValues5 = {cellDetails.get(0)};
                        String[] fields5 = {"celllabel"};
                        String where5 = "WHERE bayrowcellid=:bayrowcellid";
                        List<String> cellLabel = (List<String>) genericClassService.fetchRecord(Bayrowcell.class, fields5, where5, params5, paramsValues5);
                        if (cellLabel != null) {
                            item.put("cell", cellLabel.get(0));
                        }
                    }
                    assignedItems.add(item);
                }
            }
            Collections.sort(assignedItems, sortCells);
            model.addAttribute("assignedItems", assignedItems);
            return "inventoryAndSupplies/stockTaking/recounts/staffAssignedItems";
        }
        return "refresh";
    }

    @RequestMapping(value = "/saveItemRecount", method = RequestMethod.POST)
    public @ResponseBody
    String saveItemRecount(HttpServletRequest request, Model model, @ModelAttribute("items") String items) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            try {
                List<Map> countedItems = new ObjectMapper().readValue(items, List.class);
                for (Map item : countedItems) {
                    String[] params;
                    Object[] paramsValues;
                    String where;
                    if (item.get("batch") == "") {
                        params = new String[]{"recountid"};
                        paramsValues = new Object[]{Long.parseLong(item.get("recountid").toString())};
                        where = "WHERE recountid=:recountid";
                    } else {
                        params = new String[]{"recountid", "batchnumber"};
                        paramsValues = new Object[]{Long.parseLong(item.get("recountid").toString()), item.get("batch").toString()};
                        where = "WHERE recountid=:recountid AND batchnumber=:batchnumber";
                    }
                    String[] fields = {"recountitemid", "countedstock"};
                    List<Object[]> recountItem = (List<Object[]>) genericClassService.fetchRecord(Recountitem.class, fields, where, params, paramsValues);
                    if (recountItem != null) {
                        String[] columns = {"countedstock", "dateadded"};
                        Object[] columnValues = {(Integer) recountItem.get(0)[1] + Integer.parseInt(item.get("quantity").toString()), new Date()};
                        String pk = "recountitemid";
                        Object pkValue = recountItem.get(0)[0];
                        genericClassService.updateRecordSQLSchemaStyle(Recountitem.class, columns, columnValues, pk, pkValue, "store");
                    } else {
                        try {
                            Recountitem recount = new Recountitem();
                            recount.setRecountid(new Recount(Long.parseLong(item.get("recountid").toString())));
                            recount.setBatchnumber(item.get("batch").toString());
                            recount.setCountedstock(Integer.parseInt(item.get("quantity").toString()));
                            recount.setExpirydate(formatter.parse(item.get("expiry").toString()));
                            recount.setDateadded(new Date());
                            genericClassService.saveOrUpdateRecordLoadObject(recount);
                        } catch (ParseException ex) {
                            System.out.println(ex);
                        }
                    }
                }
                return "saved";
            } catch (IOException e) {
                return "failed";
            }
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchRecountedItems", method = RequestMethod.GET)
    public String fetchRecountedItems(HttpServletRequest request, Model model, @ModelAttribute("recountid") Integer recountid) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            List<Map> itemsCounted = new ArrayList<>();
            String[] params = {"recountid"};
            Object[] paramsValues = {recountid};
            String[] fields = {"recountitemid", "countedstock", "batchnumber", "expirydate", "dateadded"};
            String where = "WHERE recountid=:recountid";
            List<Object[]> cellList = (List<Object[]>) genericClassService.fetchRecord(Recountitem.class, fields, where, params, paramsValues);
            if (cellList != null) {
                Map<String, Object> item;
                for (Object[] object : cellList) {
                    item = new HashMap<>();
                    item.put("id", object[0]);
                    item.put("count", String.format("%,d", (Integer) object[1]));
                    item.put("batch", object[2]);
                    if (object[3] != null) {
                        item.put("expiry", formatter.format((Date) object[3]));
                    } else {
                        item.put("expiry", "");
                    }
                    item.put("entry", formatter.format((Date) object[4]));
                    itemsCounted.add(item);
                }
            }
            model.addAttribute("items", itemsCounted);
            return "inventoryAndSupplies/stockTaking/recounts/recountedItemBatches";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/submitItemRecount", method = RequestMethod.POST)
    public @ResponseBody
    String submitItemRecount(HttpServletRequest request, Model model, @ModelAttribute("recountid") Integer recountid) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            String[] columns = {"status", "dateupdated"};
            Object[] columnValues = {"SUBMITTED", new Date()};
            String pk = "recountid";
            Object pkValue = recountid.longValue();
            int result = genericClassService.updateRecordSQLSchemaStyle(Recount.class, columns, columnValues, pk, pkValue, "store");
            if (result != 0) {
                return "updated";
            } else {
                return "failed";
            }
        }
        return "refresh";
    }

    @RequestMapping(value = "/fetchRecountReviewItems", method = RequestMethod.POST)
    public String fetchRecountReviewItems(HttpServletRequest request, Model model, @ModelAttribute("activityid") Integer activityid) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            List<Map> itemRecounts = new ArrayList<>();
            String[] params = {"stockactivityid", "reviewed"};
            Object[] paramsValues = {BigInteger.valueOf(activityid.longValue()), false};
            String[] fields = {"recountid", "cellid", "itemid", "status", "staff", "activitycellid"};
            String where = "WHERE stockactivityid=:stockactivityid AND reviewed=:reviewed";
            List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Itemrecount.class, fields, where, params, paramsValues);
            if (items != null) {
                Map<String, Object> item;
                for (Object[] rec : items) {
                    item = new HashMap<>();
                    item.put("id", rec[0]);
                    item.put("cellid", rec[1]);
                    item.put("itemid", rec[2]);
                    item.put("status", rec[3]);
                    item.put("activitycellid", rec[5]);

                    String[] params1 = {"bayrowcellid", "itemid", "quantityshelved"};
                    Object[] paramsValues1 = {rec[1], rec[2], 0};
                    String[] fields1 = {"quantityshelved"};
                    String where1 = "WHERE bayrowcellid=:bayrowcellid AND itemid=:itemid AND quantityshelved>:quantityshelved";
                    List<Integer> expected = (List<Integer>) genericClassService.fetchRecord(Cellitems.class, fields1, where1, params1, paramsValues1);
                    if (expected != null) {
                        int sum = 0;
                        for (Integer shelved : expected) {
                            sum = sum + shelved;
                        }
                        item.put("expected", String.format("%,d", sum));
                    } else {
                        item.put("expected", String.format("%,d", 0));
                    }

                    String[] params2 = {"recountid"};
                    Object[] paramsValues2 = {rec[0]};
                    String[] fields2 = {"countedstock"};
                    String where2 = "WHERE recountid=:recountid";
                    List<Integer> recounts = (List<Integer>) genericClassService.fetchRecord(Recountitem.class, fields2, where2, params2, paramsValues2);
                    if (recounts != null) {
                        int sum = 0;
                        for (Integer recount : recounts) {
                            sum = sum + recount;
                        }
                        item.put("counted", String.format("%,d", sum));
                    } else {
                        item.put("counted", String.format("%,d", 0));
                    }

                    String[] params3 = {"itempackageid"};
                    Object[] paramsValues3 = {rec[2]};
                    String[] fields3 = {"packagename"};
                    String where3 = "WHERE itempackageid=:itempackageid";
                    List<String> itemName = (List<String>) genericClassService.fetchRecord(Itempackage.class, fields3, where3, params3, paramsValues3);
                    if (itemName != null) {
                        item.put("name", itemName.get(0));
                    }

                    String[] params4 = {"bayrowcellid"};
                    Object[] paramsValues4 = {rec[1]};
                    String[] fields4 = {"celllabel"};
                    String where4 = "WHERE bayrowcellid=:bayrowcellid";
                    List<String> cellLabel = (List<String>) genericClassService.fetchRecord(Bayrowcell.class, fields4, where4, params4, paramsValues4);
                    if (cellLabel != null) {
                        item.put("cell", cellLabel.get(0));
                    }

                    String[] params5 = {"staffid"};
                    Object[] paramsValues5 = {rec[4]};
                    String[] fields5 = {"firstname", "othernames", "lastname"};
                    String where5 = "WHERE staffid=:staffid";
                    List<Object[]> staff = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields5, where5, params5, paramsValues5);
                    if (staff != null) {
                        String names;
                        if (staff.get(0)[1] != null) {
                            if (((String) staff.get(0)[1]).length() > 0) {
                                if (((String) staff.get(0)[1]).length() > 0) {
                                    names = ((String) staff.get(0)[0]).charAt(0) + "." + ((String) staff.get(0)[1]).charAt(0) + " " + staff.get(0)[2];
                                } else {
                                    names = ((String) staff.get(0)[0]).charAt(0) + ". " + staff.get(0)[2];
                                }
                            } else {
                                names = ((String) staff.get(0)[0]).charAt(0) + ". " + staff.get(0)[2];
                            }
                        } else {
                            names = ((String) staff.get(0)[0]).charAt(0) + ". " + staff.get(0)[2];
                        }
                        item.put("staff", names);
                    }
                    itemRecounts.add(item);
                }
            }
            Collections.sort(itemRecounts, sortCells);
            model.addAttribute("items", itemRecounts);
            return "inventoryAndSupplies/stockManagement/recounts/reviewRecounts";
        }
        return "refresh";
    }

    @RequestMapping(value = "/fetchItemRecountDetails", method = RequestMethod.POST)
    public String fetchItemRecountDetails(HttpServletRequest request, Model model, @ModelAttribute("recountid") Integer recountid, @ModelAttribute("cellid") Integer cellid, @ModelAttribute("itemid") Integer itemid, @ModelAttribute("activitycellid") Integer activitycellid) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            int totalCounted = 0;
            int totalExpected = 0;
            List<Map> itemBatches = new ArrayList<>();
            String[] params = {"bayrowcellid", "itemid", "quantityshelved"};
            Object[] paramsValues = {cellid, itemid, 0};
            String[] fields = {"quantityshelved", "batchnumber", "expirydate"};
            String where = "WHERE bayrowcellid=:bayrowcellid AND itemid=:itemid AND quantityshelved>:quantityshelved ORDER BY batchnumber";
            List<Object[]> expected = (List<Object[]>) genericClassService.fetchRecord(Cellitems.class, fields, where, params, paramsValues);
            if (expected != null) {
                Map<String, Object> batch;
                for (Object[] bt : expected) {
                    batch = new HashMap<>();
                    totalExpected = totalExpected + (Integer) bt[0];
                    batch.put("batch", bt[1]);
                    batch.put("expected", String.format("%,d", bt[0]));
                    batch.put("counted", String.format("%,d", 0));
                    if (bt[2] != null) {
                        batch.put("expiry", formatter.format((Date) bt[2]));
                    } else {
                        batch.put("expiry", "");
                    }
                    itemBatches.add(batch);
                }
            }

            String[] params2 = {"recountid"};
            Object[] paramsValues2 = {recountid};
            String[] fields2 = {"countedstock", "batchnumber", "expirydate"};
            String where2 = "WHERE recountid=:recountid ORDER BY batchnumber";
            List<Object[]> counted = (List<Object[]>) genericClassService.fetchRecord(Recountitem.class, fields2, where2, params2, paramsValues2);
            if (counted != null) {
                Map<String, Object> batch;
                for (Object[] count : counted) {
                    boolean found = false;
                    totalCounted = totalCounted + (Integer) count[0];
                    for (int i = 0; i < itemBatches.size(); i++) {
                        if (((String) itemBatches.get(i).get("batch")).equalsIgnoreCase((String) count[1])) {
                            itemBatches.get(i).put("counted", String.format("%,d", count[0]));
                            found = true;
                            break;
                        }
                    }
                    if (!found) {
                        batch = new HashMap<>();
                        batch.put("batch", count[1]);
                        batch.put("expected", String.format("%,d", 0));
                        batch.put("counted", String.format("%,d", count[0]));
                        if (count[2] != null) {
                            batch.put("expiry", formatter.format((Date) count[2]));
                        } else {
                            batch.put("expiry", "");
                        }
                        itemBatches.add(batch);
                    }
                }
            }
            String[] params3 = {"recountid"};
            Object[] paramsValues3 = {recountid};
            String[] fields3 = {"reviewed"};
            String where3 = "WHERE recountid=:recountid";
            List reviewed = genericClassService.fetchRecord(Recount.class, fields3, where3, params3, paramsValues3);
            if (reviewed != null) {
                model.addAttribute("reviewed", reviewed.get(0));
            }
            model.addAttribute("recountid", recountid);
            model.addAttribute("batches", itemBatches);
            model.addAttribute("activitycellid", activitycellid);
            model.addAttribute("counted", String.format("%,d", totalCounted));
            model.addAttribute("expected", String.format("%,d", totalExpected));
            model.addAttribute("change", String.format("%,d", totalCounted - totalExpected));
            return "inventoryAndSupplies/stockManagement/recounts/itemBatches";
        }
        return "refresh";
    }

    @RequestMapping(value = "/fetchReviewedRecountItems", method = RequestMethod.POST)
    public String fetchReviewedRecountItems(HttpServletRequest request, Model model, @ModelAttribute("activityid") Integer activityid) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            List<Map> itemRecounts = new ArrayList<>();
            String[] params = {"stockactivityid", "reviewed"};
            Object[] paramsValues = {BigInteger.valueOf(activityid.longValue()), true};
            String[] fields = {"recountid", "cellid", "itemid", "status", "reviewedby", "activitycellid"};
            String where = "WHERE stockactivityid=:stockactivityid AND reviewed=:reviewed";
            List<Object[]> items = (List<Object[]>) genericClassService.fetchRecord(Itemrecount.class, fields, where, params, paramsValues);
            if (items != null) {
                Map<String, Object> item;
                for (Object[] rec : items) {
                    item = new HashMap<>();
                    item.put("id", rec[0]);
                    item.put("cellid", rec[1]);
                    item.put("itemid", rec[2]);
                    item.put("status", rec[3]);
                    item.put("activitycellid", rec[5]);

                    String[] params1 = {"bayrowcellid", "itemid", "quantityshelved"};
                    Object[] paramsValues1 = {rec[1], rec[2], 0};
                    String[] fields1 = {"quantityshelved"};
                    String where1 = "WHERE bayrowcellid=:bayrowcellid AND itemid=:itemid AND quantityshelved>:quantityshelved";
                    List<Integer> expected = (List<Integer>) genericClassService.fetchRecord(Cellitems.class, fields1, where1, params1, paramsValues1);
                    if (expected != null) {
                        int sum = 0;
                        for (Integer shelved : expected) {
                            sum = sum + shelved;
                        }
                        item.put("expected", String.format("%,d", sum));
                    } else {
                        item.put("expected", String.format("%,d", 0));
                    }

                    String[] params2 = {"recountid"};
                    Object[] paramsValues2 = {rec[0]};
                    String[] fields2 = {"countedstock"};
                    String where2 = "WHERE recountid=:recountid";
                    List<Integer> recounts = (List<Integer>) genericClassService.fetchRecord(Recountitem.class, fields2, where2, params2, paramsValues2);
                    if (recounts != null) {
                        int sum = 0;
                        for (Integer recount : recounts) {
                            sum = sum + recount;
                        }
                        item.put("counted", String.format("%,d", sum));
                    } else {
                        item.put("counted", String.format("%,d", 0));
                    }

                    String[] params3 = {"itempackageid"};
                    Object[] paramsValues3 = {rec[2]};
                    String[] fields3 = {"packagename"};
                    String where3 = "WHERE itempackageid=:itempackageid";
                    List<String> itemName = (List<String>) genericClassService.fetchRecord(Itempackage.class, fields3, where3, params3, paramsValues3);
                    if (itemName != null) {
                        item.put("name", itemName.get(0));
                    }

                    String[] params4 = {"bayrowcellid"};
                    Object[] paramsValues4 = {rec[1]};
                    String[] fields4 = {"celllabel"};
                    String where4 = "WHERE bayrowcellid=:bayrowcellid";
                    List<String> cellLabel = (List<String>) genericClassService.fetchRecord(Bayrowcell.class, fields4, where4, params4, paramsValues4);
                    if (cellLabel != null) {
                        item.put("cell", cellLabel.get(0));
                    }

                    String[] params5 = {"staffid"};
                    Object[] paramsValues5 = {rec[4]};
                    String[] fields5 = {"firstname", "othernames", "lastname"};
                    String where5 = "WHERE staffid=:staffid";
                    List<Object[]> staff = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields5, where5, params5, paramsValues5);
                    if (staff != null) {
                        String names;
                        if (staff.get(0)[1] != null) {
                            if (((String) staff.get(0)[1]).length() > 0) {
                                names = ((String) staff.get(0)[0]).charAt(0) + "." + ((String) staff.get(0)[1]).charAt(0) + " " + staff.get(0)[2];
                            } else {
                                names = ((String) staff.get(0)[0]).charAt(0) + ". " + staff.get(0)[2];
                            }
                        } else {
                            names = ((String) staff.get(0)[0]).charAt(0) + ". " + staff.get(0)[2];
                        }
                        item.put("reviewer", names);
                    }
                    itemRecounts.add(item);
                }
            }
            Collections.sort(itemRecounts, sortCells);
            model.addAttribute("items", itemRecounts);
            return "inventoryAndSupplies/stockManagement/recounts/reviewedRecounts";
        }
        return "refresh";
    }

    @RequestMapping(value = "/closeRecount", method = RequestMethod.POST)
    public @ResponseBody
    String closeRecount(HttpServletRequest request, Model model, @ModelAttribute("activitycellid") Integer activitycellid, @ModelAttribute("recountid") Integer recountid, @ModelAttribute("closeStatus") boolean closeStatus) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            Long curUser = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");

            String[] columns = {"reviewed", "reviewedby"};
            Object[] columnValues = {true, curUser};
            String pk = "recountid";
            Object pkValue = recountid.longValue();
            int recountUpdate = genericClassService.updateRecordSQLSchemaStyle(Recount.class, columns, columnValues, pk, pkValue, "store");
            if (recountUpdate != 0) {
                String[] params = {"activitycellid", "reviewed"};
                Object[] paramsValues = {activitycellid, false};
                String where = "WHERE activitycellid=:activitycellid AND reviewed=:reviewed";
                int pending = genericClassService.fetchRecordCount(Recount.class, where, params, paramsValues);
                if (pending <= 0) {
                    String[] columns2 = {"recount"};
                    Object[] columnValues2 = {false};
                    String pk2 = "activitycellid";
                    Object pkValue2 = activitycellid.longValue();
                    genericClassService.updateRecordSQLSchemaStyle(Activitycell.class, columns2, columnValues2, pk2, pkValue2, "store");
                }
                if (!closeStatus) {
                    return "updated";
                } else {
                    String[] params2 = {"recountid"};
                    Object[] paramsValues2 = {recountid};
                    String[] fields2 = {"itemid.itemid"};
                    String where2 = "WHERE recountid=:recountid";
                    List<Long> recountItem = (List<Long>) genericClassService.fetchRecord(Recount.class, fields2, where2, params2, paramsValues2);
                    if (recountItem != null) {
                        Integer itemid = recountItem.get(0).intValue();
                        new OverwriteCountItems(genericClassService, recountid, itemid, activitycellid).start();
                        return "updated";
                    }
                }
            }
            return "failed";
        }
        return "refresh";
    }

    @RequestMapping(value = "/fetchActivitycellRecountItems", method = RequestMethod.POST)
    public @ResponseBody
    String fetchActivitycellRecountItems(HttpServletRequest request, Model model, @ModelAttribute("activitycellid") Integer activitycellid) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            Set<Long> items = new HashSet();
            String[] params = {"activitycellid", "reviewed"};
            Object[] paramsValues = {activitycellid, false};
            String[] fields = {"itemid.itemid"};
            String where = "WHERE activitycellid=:activitycellid AND reviewed=:reviewed";
            List<Long> counted = (List<Long>) genericClassService.fetchRecord(Recount.class, fields, where, params, paramsValues);
            if (counted != null) {
                for (Long object : counted) {
                    items.add(object);
                }
            }
            String ids = "[]";
            try {
                ids = new ObjectMapper().writeValueAsString(items);
            } catch (JsonProcessingException ex) {
                System.out.println(ex);
            }
            return ids;
        }
        return "refresh";
    }

    //Stock taking setup
    @RequestMapping(value = "/countActivityPendingCells", method = RequestMethod.POST)
    public @ResponseBody
    String countActivityPendingCells(HttpServletRequest request, Model model, @ModelAttribute("activityid") Integer activityid) {
        String[] params = {"stockactivityid", "closed"};
        Object[] paramsValues = {activityid, false};
        String where = "WHERE stockactivityid=:stockactivityid AND closed=:closed";
        Integer pending = genericClassService.fetchRecordCount(Activitycell.class, where, params, paramsValues);

        return pending.toString();
    }

    @RequestMapping(value = "/loadActivityReport", method = RequestMethod.POST)
    public String loadActivityReport(HttpServletRequest request, Model model, @ModelAttribute("activityid") Integer activityid) throws ParseException {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            String cells = "";
            Integer facilityUnit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
            List<Map> itemSet = new ArrayList<>();

            Date endDate = null;
            Date startDate = null;
            Date dateAdded = null;
            String activity = null;
            BigInteger addedby = null;
            String[] params = {"stockactivityid"};
            Object[] paramsValues = {activityid};
            String[] fields = {"activityname", "startdate", "enddate", "addedby", "dateadded"};
            String where = "WHERE stockactivityid=:stockactivityid";
            List<Object[]> activityStart = (List<Object[]>) genericClassService.fetchRecord(Stockactivity.class, fields, where, params, paramsValues);
            if (activityStart != null) {
                endDate = (Date) activityStart.get(0)[2];
                startDate = (Date) activityStart.get(0)[1];
                dateAdded = (Date) activityStart.get(0)[4];
                activity = (String) activityStart.get(0)[0];
                addedby = (BigInteger) activityStart.get(0)[3];
                String[] params2 = {"stockactivityid"};
                Object[] paramsValues2 = {activityid};
                String[] fields2 = {"cellid.bayrowcellid"};
                String where2 = "WHERE stockactivityid=:stockactivityid";
                List<Integer> activityCells = (List<Integer>) genericClassService.fetchRecord(Activitycell.class, fields2, where2, params2, paramsValues2);
                if (activityCells != null) {
                    for (Integer cellid : activityCells) {
                        String[] params3 = {"cellid", "activityStartDate"};
                        Object[] paramsValues3 = {cellid, startDate};
                        String[] fields3 = {"r.itemid", "r.packagename", "SUM(r.quantity)", "r.logtype"};
                        String where3 = "WHERE cellid=:cellid AND datelogged<=:activityStartDate GROUP BY r.itemid,r.packagename,r.logtype";
                        List<Object[]> stockItems = (List<Object[]>) genericClassService.fetchRecordFunction(Shelflogstock.class, fields3, where3, params3, paramsValues3, 0, 0);
                        if (stockItems != null) {
                            Map<String, Object> item;
                            for (Object[] itm : stockItems) {
                                boolean found = false;
                                for (int i = 0; i < itemSet.size(); i++) {
                                    if ((itemSet.get(i).get("itemid").toString()).equalsIgnoreCase(itm[0].toString())) {
                                        long balance = Long.parseLong(itemSet.get(i).get("balance").toString());
                                        if ("TRA".equalsIgnoreCase((String) itm[3]) || "OUT".equalsIgnoreCase((String) itm[3]) || "DISC".equalsIgnoreCase((String) itm[3])) {
                                            itemSet.get(i).put("balance", balance - Long.parseLong(itm[2].toString()));
                                        } else {
                                            itemSet.get(i).put("balance", balance + Long.parseLong(itm[2].toString()));
                                        }
                                        found = true;
                                        break;
                                    }
                                }
                                if (!found) {
                                    item = new HashMap<>();
                                    item.put("itemid", (BigInteger) itm[0]);
                                    item.put("itemname", (String) itm[1]);
                                    item.put("batches", new ArrayList<>());
                                    long balance = 0;
                                    if ("TRA".equalsIgnoreCase((String) itm[3]) || "OUT".equalsIgnoreCase((String) itm[3]) || "DISC".equalsIgnoreCase((String) itm[3])) {
                                        item.put("balance", balance - Long.parseLong(itm[2].toString()));
                                    } else {
                                        item.put("balance", balance + Long.parseLong(itm[2].toString()));
                                    }
                                    itemSet.add(item);
                                }
                            }
                        }
                        cells = cells + " OR cellid=" + cellid;
                    }
                }
            }
            cells = "(" + cells.substring(3) + ")";
            List<Map> allItems = new ArrayList<>(itemSet);
            if (startDate != null) {
                for (int i = 0; i < allItems.size(); i++) {
                    if (Long.parseLong(allItems.get(i).get("balance").toString()) > 0) {
                        long expected = 0;
                        String[] params2 = {"itemid", "activityStartDate"};
                        Object[] paramsValues2 = {allItems.get(i).get("itemid"), startDate};
                        String[] fields2 = {"r.batchnumber", "SUM(r.quantity)", "r.logtype", "r.expirydate"};
                        String where2 = "WHERE itemid=:itemid AND " + cells + " AND datelogged<=:activityStartDate GROUP BY r.batchnumber,r.expirydate,r.logtype ORDER BY r.expirydate";
                        List<Object[]> stockIn = genericClassService.fetchRecordFunction(Shelflogstock.class, fields2, where2, params2, paramsValues2, 0, 0);
                        if (stockIn != null) {
                            Map<String, Object> batch;
                            List<Map> batches = (List<Map>) allItems.get(i).get("batches");
                            for (Object[] stock : stockIn) {
                                String batchNo;
                                if (stock[0] != null) {
                                    batchNo = (String) stock[0];
                                } else {
                                    batchNo = "-";
                                }
                                boolean found = false;
                                for (int j = 0; j < batches.size(); j++) {
                                    if (batchNo.equalsIgnoreCase((String) batches.get(j).get("batch"))) {
                                        long qty = Long.parseLong(batches.get(j).get("expected").toString());
                                        if ("TRA".equalsIgnoreCase((String) stock[2]) || "OUT".equalsIgnoreCase((String) stock[2]) || "DISC".equalsIgnoreCase((String) stock[2])) {
                                            batches.get(j).put("expected", qty - Long.parseLong(stock[1].toString()));
                                            expected = expected - Long.parseLong(stock[1].toString());
                                        } else {
                                            batches.get(j).put("expected", qty + Long.parseLong(stock[1].toString()));
                                            expected = expected + Long.parseLong(stock[1].toString());
                                        }
                                        found = true;
                                        break;
                                    }
                                }
                                if (!found) {
                                    batch = new HashMap<>();
                                    batch.put("batch", batchNo);
                                    if ("TRA".equalsIgnoreCase((String) stock[2]) || "OUT".equalsIgnoreCase((String) stock[2]) || "DISC".equalsIgnoreCase((String) stock[2])) {
                                        batch.put("expected", 0 - Long.parseLong(stock[1].toString()));
                                        expected = expected - Long.parseLong(stock[1].toString());
                                    } else {
                                        batch.put("expected", 0 + Long.parseLong(stock[1].toString()));
                                        expected = expected + Long.parseLong(stock[1].toString());
                                    }
                                    batch.put("counted", (long) 0);
                                    batch.put("expiry", formatter.format((Date) stock[3]));
                                    batches.add(batch);
                                }
                            }
                            allItems.get(i).put("batches", batches);
                        }
                        allItems.get(i).put("counted", (long) 0);
                        allItems.get(i).put("expected", expected);
                    }
                }
                String[] params2 = {"stockactivityid"};
                Object[] paramsValues2 = {activityid};
                String[] fields2 = {"r.itemid", "r.packagename", "r.batchnumber", "SUM(r.countedstock)", "r.expirydate"};
                String where2 = "WHERE stockactivityid=:stockactivityid GROUP BY r.itemid,r.packagename,r.batchnumber,r.expirydate ORDER BY r.expirydate";
                List<Object[]> stockCounted = genericClassService.fetchRecordFunction(Stockcount.class, fields2, where2, params2, paramsValues2, 0, 0);
                if (stockCounted != null) {
                    String batchNo;
                    Map<String, Object> newItem;
                    for (Object[] count : stockCounted) {
                        Map<String, Object> batch;
                        if (count[2] != null) {
                            batchNo = (String) count[2];
                        } else {
                            batchNo = "-";
                        }
                        boolean itemFound = false;
                        for (int i = 0; i < allItems.size(); i++) {
                            if ((allItems.get(i).get("itemid").toString()).equalsIgnoreCase(count[0].toString())) {
                                List<Map> batches = (List<Map>) allItems.get(i).get("batches");
                                boolean found = false;
                                for (int j = 0; j < batches.size(); j++) {
                                    if (batchNo.equalsIgnoreCase((String) batches.get(j).get("batch"))) {
                                        batches.get(j).put("counted", Long.parseLong(count[3].toString()));
                                        found = true;
                                        break;
                                    }
                                }
                                if (!found) {
                                    batch = new HashMap<>();
                                    batch.put("batch", batchNo);
                                    batch.put("expected", (long) 0);
                                    batch.put("counted", Long.parseLong(count[3].toString()));
                                    batch.put("expiry", formatter.format((Date) count[4]));
                                    batches.add(batch);
                                }
                                long qty = Long.parseLong(allItems.get(i).get("counted").toString());
                                allItems.get(i).put("batches", batches);
                                allItems.get(i).put("counted", Long.parseLong(count[3].toString()) + qty);
                                itemFound = true;
                                break;
                            }
                        }
                        if (!itemFound) {
                            //Create new item
                            newItem = new HashMap<>();
                            newItem.put("itemid", (BigInteger) count[0]);
                            newItem.put("itemname", (String) count[1]);
                            //Add count to batch
                            List<Map> batches = new ArrayList<>();
                            batch = new HashMap<>();
                            batch.put("batch", batchNo);
                            batch.put("expected", 0);
                            batch.put("counted", Long.parseLong(count[3].toString()));
                            batch.put("expiry", formatter.format((Date) count[4]));
                            batches.add(batch);
                            //Add batch to items.
                            newItem.put("expected", 0);
                            newItem.put("batches", batches);
                            newItem.put("counted", Long.parseLong(count[3].toString()));
                            allItems.add(newItem);
                        }
                    }
                }
            }
            String names = null;
            String designation = null;
            if (addedby != null) {
                String[] params3 = {"staffid"};
                Object[] paramsValues3 = {addedby};
                String[] fields3 = {"firstname", "othernames", "lastname", "designationname"};
                String where3 = "WHERE staffid=:staffid";
                List<Object[]> staffDetails = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields3, where3, params3, paramsValues3);
                if (staffDetails != null) {
                    designation = (String) staffDetails.get(0)[3];
                    if (staffDetails.get(0)[1] != null) {
                        if (((String) staffDetails.get(0)[1]).length() > 0) {
                            names = ((String) staffDetails.get(0)[0]).charAt(0) + "." + ((String) staffDetails.get(0)[1]).charAt(0) + " " + staffDetails.get(0)[2];
                        } else {
                            names = ((String) staffDetails.get(0)[0]).charAt(0) + ". " + staffDetails.get(0)[2];
                        }
                    } else {
                        names = ((String) staffDetails.get(0)[0]) + " " + staffDetails.get(0)[2];
                    }
                }
            } else {
                designation = "Auto Generated";
                names = formatter.format(dateAdded);
            }
            List<Map> emptyItems = new ArrayList<>();
            for (int i = 0; i < allItems.size(); i++) {
                List<Map> emptyBatches = new ArrayList<>();
                List<Map> batches = (List<Map>) allItems.get(i).get("batches");
                for (int j = 0; j < batches.size(); j++) {
                    if (Long.parseLong(batches.get(j).get("expected").toString()) == 0 && Long.parseLong(batches.get(j).get("counted").toString()) == 0) {
                        emptyBatches.add(batches.get(j));
                    }
                }
                batches.removeAll(emptyBatches);
                allItems.get(i).put("batches", batches);
                if (batches.size() < 1) {
                    emptyItems.add(allItems.get(i));
                }
            }
            allItems.removeAll(emptyItems);

            String[] params4 = {"facilityunitid"};
            Object[] paramsValues4 = {BigInteger.valueOf(facilityUnit.longValue())};
            String where4 = "WHERE facilityunitid=:facilityunitid";
            int cellCount = genericClassService.fetchRecordCount(Unitstoragezones.class, where4, params4, paramsValues4);

            String[] params5 = {"stockactivityid"};
            Object[] paramsValues5 = {BigInteger.valueOf(activityid.longValue())};
            String where5 = "WHERE stockactivityid=:stockactivityid";
            int cellIncude = genericClassService.fetchRecordCount(Activitycell.class, where5, params5, paramsValues5);

            Collections.sort(allItems, sortItems);
            String fileName = activityid.toString() + ".json";
            Map<String, Object> pdfData = new HashMap<>();
            pdfData.put("staff", names);
            pdfData.put("activity", activity);
            pdfData.put("cellCount", cellCount);
            pdfData.put("cellInclude", cellIncude);
            pdfData.put("designation", designation);
            pdfData.put("end", formatter.format(endDate));
            pdfData.put("start", formatter.format(startDate));
            pdfData.put("reportItems", allItems);
            try {
                new ObjectMapper().writeValue(new File(getStockReportPath() + fileName), pdfData);
            } catch (IOException ex) {
                System.out.println(ex);
            }
            model.addAttribute("staff", names);
            model.addAttribute("file", fileName);
            model.addAttribute("activity", activity);
            model.addAttribute("cellCount", cellCount);
            model.addAttribute("cellInclude", cellIncude);
            model.addAttribute("designation", designation);
            model.addAttribute("end", formatter.format(endDate));
            model.addAttribute("start", formatter.format(startDate));
            model.addAttribute("reportItems", allItems);
            return "inventoryAndSupplies/stockManagement/stockCount/activityReport";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/updateActivityDeadline", method = RequestMethod.POST)
    public @ResponseBody
    String updateActivityDeadline(HttpServletRequest request, Model model, @ModelAttribute("activityid") Integer activityid, @ModelAttribute("end") String endDate) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            Long staffid = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
            try {
                Date end = formatter.parse(endDate);
                String[] columns = {"enddate", "updatedby", "dateupdated"};
                Object[] columnValues = {end, staffid, new Date()};
                String pk = "stockactivityid";
                Object pkValue = activityid.longValue();
                int result = genericClassService.updateRecordSQLSchemaStyle(Stockactivity.class, columns, columnValues, pk, pkValue, "store");
                if (result != 0) {
                    return "updated";
                } else {
                    return "failed";
                }
            } catch (ParseException e) {
                return "error";
            }
        }
        return "refresh";
    }

    @RequestMapping(value = "/fetchStaffCountSheet", method = RequestMethod.POST)
    public String fetchStaffCountSheet(HttpServletRequest request, Model model, @ModelAttribute("staffid") Integer staffid, @ModelAttribute("activityid") Integer activityid) throws ParseException {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            List<Map> itemSet = new ArrayList<>();

            Date endDate = null;
            Date startDate = null;
            String activity = null;
            String[] params = {"stockactivityid"};
            Object[] paramsValues = {activityid};
            String[] fields = {"activityname", "startdate", "enddate", "addedby"};
            String where = "WHERE stockactivityid=:stockactivityid";
            List<Object[]> activityStart = (List<Object[]>) genericClassService.fetchRecord(Stockactivity.class, fields, where, params, paramsValues);
            if (activityStart != null) {
                endDate = (Date) activityStart.get(0)[2];
                startDate = (Date) activityStart.get(0)[1];
                activity = (String) activityStart.get(0)[0];
                String[] params2 = {"stockactivityid", "cellstaff"};
                Object[] paramsValues2 = {activityid, staffid};
                String[] fields2 = {"itemid", "packagename"};
                String where2 = "WHERE stockactivityid=:stockactivityid AND cellstaff=:cellstaff GROUP BY itemid,packagename";
                List<Object[]> activityCells = (List<Object[]>) genericClassService.fetchRecord(Stockcount.class, fields2, where2, params2, paramsValues2);
                if (activityCells != null) {
                    Map<String, Object> item;
                    for (Object[] itm : activityCells) {
                        item = new HashMap<>();
                        item.put("itemid", (BigInteger) itm[0]);
                        item.put("itemname", (String) itm[1]);
                        itemSet.add(item);
                    }
                }
            }
            if (startDate != null) {
                for (int i = 0; i < itemSet.size(); i++) {
                    String[] params2 = {"stockactivityid", "cellstaff", "itemid"};
                    Object[] paramsValues2 = {activityid, staffid, itemSet.get(i).get("itemid")};
                    String[] fields2 = {"batchnumber", "countedstock", "expirydate", "dateadded", "cellid"};
                    String where2 = "WHERE stockactivityid=:stockactivityid AND cellstaff=:cellstaff AND itemid=:itemid";
                    List<Object[]> stockCounted = (List<Object[]>) genericClassService.fetchRecord(Stockcount.class, fields2, where2, params2, paramsValues2);
                    if (stockCounted != null) {
                        String batchNo;
                        long itemQty = 0;
                        Map<String, Object> batch;
                        List<Map> batches = new ArrayList<>();
                        for (Object[] count : stockCounted) {
                            if (count[0] != null) {
                                batchNo = (String) count[0];
                            } else {
                                batchNo = "-";
                            }
                            batch = new HashMap<>();
                            batch.put("batch", batchNo);
                            batch.put("expiry", formatter.format((Date) count[2]));
                            batch.put("counted", (Integer) count[1]);
                            batch.put("dateadded", formatter.format((Date) count[3]));

                            String[] params3 = {"bayrowcellid"};
                            Object[] paramsValues3 = {count[4]};
                            String[] fields3 = {"celllabel"};
                            String where3 = "WHERE bayrowcellid=:bayrowcellid";
                            List<String> staffDetails = (List<String>) genericClassService.fetchRecord(Bayrowcell.class, fields3, where3, params3, paramsValues3);
                            if (staffDetails != null) {
                                batch.put("cell", staffDetails.get(0));
                            }
                            batches.add(batch);
                            itemQty = itemQty + (Integer) count[1];
                        }
                        Collections.sort(batches, sortCells);
                        itemSet.get(i).put("batches", batches);
                        itemSet.get(i).put("counted", itemQty);
                    }
                }
            }
            //User Details
            String names = null;
            String designation = null;
            String[] params3 = {"staffid"};
            Object[] paramsValues3 = {staffid};
            String[] fields3 = {"firstname", "othernames", "lastname", "designationname"};
            String where3 = "WHERE staffid=:staffid";
            List<Object[]> staffDetails = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields3, where3, params3, paramsValues3);
            if (staffDetails != null) {
                designation = (String) staffDetails.get(0)[3];
                if (staffDetails.get(0)[1] != null) {
                    if (((String) staffDetails.get(0)[1]).length() > 0) {
                        if (((String) staffDetails.get(0)[1]).length() > 0) {
                            names = ((String) staffDetails.get(0)[0]).charAt(0) + "." + ((String) staffDetails.get(0)[1]).charAt(0) + " " + staffDetails.get(0)[2];
                        } else {
                            names = ((String) staffDetails.get(0)[0]).charAt(0) + ". " + staffDetails.get(0)[2];
                        }
                    } else {
                        names = ((String) staffDetails.get(0)[0]) + " " + staffDetails.get(0)[2];
                    }
                } else {
                    names = ((String) staffDetails.get(0)[0]) + " " + staffDetails.get(0)[2];
                }
            }
            String[] params4 = {"stockactivityid", "cellstaff", "activitystatus"};
            Object[] paramsValues4 = {activityid, staffid, "SUBMITTED"};
            String where4 = "WHERE stockactivityid=:stockactivityid AND cellstaff=:cellstaff AND activitystatus=:activitystatus";
            int submitted = genericClassService.fetchRecordCount(Activitycell.class, where4, params4, paramsValues4);

            String[] params5 = {"stockactivityid", "cellstaff"};
            Object[] paramsValues5 = {activityid, staffid};
            String where5 = "WHERE stockactivityid=:stockactivityid AND cellstaff=:cellstaff";
            int assigned = genericClassService.fetchRecordCount(Activitycell.class, where5, params5, paramsValues5);

            Collections.sort(itemSet, sortItems);

            String fileName = staffid.toString() + activityid.toString() + ".json";
            Map<String, Object> pdfData = new HashMap<>();
            pdfData.put("staff", names);
            pdfData.put("activity", activity);
            pdfData.put("assigned", assigned);
            pdfData.put("submitted", submitted);
            pdfData.put("designation", designation);
            pdfData.put("end", formatter.format(endDate));
            pdfData.put("start", formatter.format(startDate));
            pdfData.put("reportItems", itemSet);
            try {
                new ObjectMapper().writeValue(new File(getUserReportPath() + fileName), pdfData);
            } catch (IOException ex) {
                System.out.println(ex);
            }
            model.addAttribute("staff", names);
            model.addAttribute("file", fileName);
            model.addAttribute("activity", activity);
            model.addAttribute("assigned", assigned);
            model.addAttribute("submitted", submitted);
            model.addAttribute("designation", designation);
            model.addAttribute("end", formatter.format(endDate));
            model.addAttribute("start", formatter.format(startDate));
            model.addAttribute("reportItems", itemSet);
            return "inventoryAndSupplies/stockManagement/cellLocations/userReport";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchActivityFollowupItems", method = RequestMethod.POST)
    public String fetchActivityFollowupItems(HttpServletRequest request, Model model, @ModelAttribute("activityid") Integer activityid) throws ParseException {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            String cells = "";
            List<Map> itemSet = new ArrayList<>();

            Date endDate = null;
            Date startDate = null;
            String activityName = null;
            String[] params = {"stockactivityid"};
            Object[] paramsValues = {activityid};
            String[] fields = {"startdate", "enddate", "activityname"};
            String where = "WHERE stockactivityid=:stockactivityid";
            List<Object[]> activityStart = (List<Object[]>) genericClassService.fetchRecord(Stockactivity.class, fields, where, params, paramsValues);
            if (activityStart != null) {
                endDate = (Date) activityStart.get(0)[1];
                startDate = (Date) activityStart.get(0)[0];
                activityName = (String) activityStart.get(0)[2];
                String[] params2 = {"stockactivityid"};
                Object[] paramsValues2 = {activityid};
                String[] fields2 = {"cellid.bayrowcellid"};
                String where2 = "WHERE stockactivityid=:stockactivityid";
                List<Integer> activityCells = (List<Integer>) genericClassService.fetchRecord(Activitycell.class, fields2, where2, params2, paramsValues2);
                if (activityCells != null) {
                    for (Integer cellid : activityCells) {
                        String[] params3 = {"cellid", "activityStartDate"};
                        Object[] paramsValues3 = {cellid, startDate};
                        String[] fields3 = {"r.itemid", "r.packagename", "SUM(r.quantity)", "r.logtype"};
//                        String where3 = "WHERE cellid=:cellid AND datelogged<=:activityStartDate GROUP BY r.itemid,r.packagename,r.logtype";
                        String where3 = "WHERE cellid=:cellid AND CAST(datelogged AS DATE)<=:activityStartDate GROUP BY r.itemid,r.packagename,r.logtype";
                        List<Object[]> stockItems = (List<Object[]>) genericClassService.fetchRecordFunction(Shelflogstock.class, fields3, where3, params3, paramsValues3, 0, 0);
                        if (stockItems != null) {
                            Map<String, Object> item;
                            for (Object[] itm : stockItems) {
                                boolean found = false;
                                for (int i = 0; i < itemSet.size(); i++) {
                                    if ((itemSet.get(i).get("itemid").toString()).equalsIgnoreCase(itm[0].toString())) {
                                        long balance = Long.parseLong(itemSet.get(i).get("balance").toString());
                                        if ("TRA".equalsIgnoreCase((String) itm[3]) || "OUT".equalsIgnoreCase((String) itm[3]) || "DISC".equalsIgnoreCase((String) itm[3])) {
                                            itemSet.get(i).put("balance", balance - Long.parseLong(itm[2].toString()));
                                        } else {
                                            itemSet.get(i).put("balance", balance + Long.parseLong(itm[2].toString()));
                                        }
                                        found = true;
                                        break;
                                    }
                                }
                                if (!found) {
                                    item = new HashMap<>();
                                    item.put("itemid", (BigInteger) itm[0]);
                                    item.put("itemname", (String) itm[1]);
                                    item.put("batches", new ArrayList<>());
                                    long balance = 0;
                                    if ("TRA".equalsIgnoreCase((String) itm[3]) || "OUT".equalsIgnoreCase((String) itm[3]) || "DISC".equalsIgnoreCase((String) itm[3])) {
                                        item.put("balance", balance - Long.parseLong(itm[2].toString()));
                                    } else {
                                        item.put("balance", balance + Long.parseLong(itm[2].toString()));
                                    }
                                    itemSet.add(item);
                                }
                            }
                        }
                        cells = cells + " OR cellid=" + cellid;
                    }
                }
            }
            List<Map> allItems = new ArrayList<>();
            if (cells.length() > 0) {
                allItems = new ArrayList<>(itemSet);
                cells = "(" + cells.substring(3) + ")";
                if (startDate != null) {
                    for (int i = 0; i < allItems.size(); i++) {
                        if (Long.parseLong(allItems.get(i).get("balance").toString()) > 0) {
                            long expected = 0;
                            String[] params2 = {"itemid", "activityStartDate"};
                            Object[] paramsValues2 = {allItems.get(i).get("itemid"), startDate};
                            String[] fields2 = {"r.batchnumber", "SUM(r.quantity)", "r.logtype", "r.expirydate"};
//                            String where2 = "WHERE itemid=:itemid AND " + cells + " AND datelogged<=:activityStartDate GROUP BY r.batchnumber,r.expirydate,r.logtype ORDER BY r.expirydate";
                            String where2 = "WHERE itemid=:itemid AND " + cells + " AND CAST(datelogged AS DATE)<=:activityStartDate GROUP BY r.batchnumber,r.expirydate,r.logtype ORDER BY r.expirydate";
                            List<Object[]> stockIn = genericClassService.fetchRecordFunction(Shelflogstock.class, fields2, where2, params2, paramsValues2, 0, 0);
                            if (stockIn != null) {
                                Map<String, Object> batch;
                                List<Map> batches = (List<Map>) allItems.get(i).get("batches");
                                for (Object[] stock : stockIn) {
                                    String batchNo;
                                    if (stock[0] != null) {
                                        batchNo = (String) stock[0];
                                    } else {
                                        batchNo = "-";
                                    }
                                    boolean found = false;
                                    for (int j = 0; j < batches.size(); j++) {
                                        if (batchNo.equalsIgnoreCase((String) batches.get(j).get("batch"))) {
                                            long qty = Long.parseLong(batches.get(j).get("expected").toString());
                                            if ("TRA".equalsIgnoreCase((String) stock[2]) || "OUT".equalsIgnoreCase((String) stock[2]) || "DISC".equalsIgnoreCase((String) stock[2])) {
                                                batches.get(j).put("expected", qty - Long.parseLong(stock[1].toString()));
                                                expected = expected - Long.parseLong(stock[1].toString());
                                            } else {
                                                batches.get(j).put("expected", qty + Long.parseLong(stock[1].toString()));
                                                expected = expected + Long.parseLong(stock[1].toString());
                                            }
                                            found = true;
                                            break;
                                        }
                                    }
                                    if (!found) {
                                        batch = new HashMap<>();
                                        batch.put("batch", batchNo);
                                        if ("TRA".equalsIgnoreCase((String) stock[2]) || "OUT".equalsIgnoreCase((String) stock[2]) || "DISC".equalsIgnoreCase((String) stock[2])) {
                                            batch.put("expected", 0 - Long.parseLong(stock[1].toString()));
                                            expected = expected - Long.parseLong(stock[1].toString());
                                        } else {
                                            batch.put("expected", 0 + Long.parseLong(stock[1].toString()));
                                            expected = expected + Long.parseLong(stock[1].toString());
                                        }
                                        batch.put("counted", (long) 0);
                                        batch.put("expiry", formatter.format((Date) stock[3]));
                                        batches.add(batch);
                                    }
                                }
                                allItems.get(i).put("batches", batches);
                            }
                            allItems.get(i).put("counted", (long) 0);
                            allItems.get(i).put("expected", expected);
                        }
                    }
                    String[] params2 = {"stockactivityid"};
                    Object[] paramsValues2 = {activityid};
                    String[] fields2 = {"r.itemid", "r.packagename", "r.batchnumber", "SUM(r.countedstock)", "r.expirydate"};
                    String where2 = "WHERE stockactivityid=:stockactivityid GROUP BY r.itemid,r.packagename,r.batchnumber,r.expirydate ORDER BY r.expirydate";
                    List<Object[]> stockCounted = genericClassService.fetchRecordFunction(Stockcount.class, fields2, where2, params2, paramsValues2, 0, 0);
                    if (stockCounted != null) {
                        String batchNo;
                        Map<String, Object> newItem;
                        for (Object[] count : stockCounted) {
                            Map<String, Object> batch;
                            if (count[2] != null) {
                                batchNo = (String) count[2];
                            } else {
                                batchNo = "-";
                            }
                            boolean itemFound = false;
                            for (int i = 0; i < allItems.size(); i++) {
                                if ((allItems.get(i).get("itemid").toString()).equalsIgnoreCase(count[0].toString())) {
                                    List<Map> batches = (List<Map>) allItems.get(i).get("batches");
                                    boolean found = false;
                                    for (int j = 0; j < batches.size(); j++) {
                                        if (batchNo.equalsIgnoreCase((String) batches.get(j).get("batch"))) {
                                            long batchCounted = Long.parseLong(batches.get(j).get("expected").toString());
                                            if (batchCounted == Long.parseLong(count[3].toString())) {
                                                batches.remove(j);
                                            } else {
                                                batches.get(j).put("counted", Long.parseLong(count[3].toString()));
                                            }
                                            found = true;
                                            break;
                                        }
                                    }
                                    if (!found) {
                                        batch = new HashMap<>();
                                        batch.put("batch", batchNo);
                                        batch.put("expected", (long) 0);
                                        batch.put("counted", Long.parseLong(count[3].toString()));
                                        batch.put("expiry", formatter.format((Date) count[4]));
                                        batches.add(batch);
                                    }
                                    if (batches.size() > 0) {
                                        long qty = Long.parseLong(allItems.get(i).get("counted").toString());
                                        allItems.get(i).put("batches", batches);
                                        allItems.get(i).put("counted", Long.parseLong(count[3].toString()) + qty);
                                    } else {
                                        allItems.remove(i);
                                    }
                                    itemFound = true;
                                    break;
                                }
                            }
                            if (!itemFound) {
                                //Create new item
                                newItem = new HashMap<>();
                                newItem.put("itemid", (BigInteger) count[0]);
                                newItem.put("itemname", (String) count[1]);
                                //Add count to batch
                                List<Map> batches = new ArrayList<>();
                                batch = new HashMap<>();
                                batch.put("batch", batchNo);
                                batch.put("expected", 0);
                                batch.put("counted", Long.parseLong(count[3].toString()));
                                batch.put("expiry", formatter.format((Date) count[4]));
                                batches.add(batch);
                                //Add batch to items.
                                newItem.put("expected", 0);
                                newItem.put("batches", batches);
                                newItem.put("counted", Long.parseLong(count[3].toString()));
                                allItems.add(newItem);
                            }
                        }
                    }
                }
            }
            List<Map> emptyItems = new ArrayList<>();
            for (int i = 0; i < allItems.size(); i++) {
                List<Map> emptyBatches = new ArrayList<>();
                List<Map> batches = (List<Map>) allItems.get(i).get("batches");
                for (int j = 0; j < batches.size(); j++) {
                    if (Long.parseLong(batches.get(j).get("expected").toString()) == 0 && -Long.parseLong(batches.get(j).get("counted").toString()) == 0) {
                        emptyBatches.add(batches.get(j));
                    }
                }
                batches.removeAll(emptyBatches);
                allItems.get(i).put("batches", batches);
                if (batches.size() < 1) {
                    emptyItems.add(allItems.get(i));
                }
            }
            allItems.removeAll(emptyItems);

            Collections.sort(allItems, sortItems);
            String fileName = activityid.toString() + ".json";
            Map<String, Object> pdfData = new HashMap<>();
            pdfData.put("reportItems", allItems);
            pdfData.put("activityid", activityid);
            pdfData.put("activityname", activityName);
            pdfData.put("itemCount", allItems.size());
            pdfData.put("end", formatter.format(endDate));
            pdfData.put("start", formatter.format(startDate));
            try {
                new ObjectMapper().writeValue(new File(getDiscrepancyReportPath() + fileName), pdfData);
            } catch (IOException ex) {
                System.out.println(ex);
            }
            model.addAttribute("file", fileName);
            model.addAttribute("reportItems", allItems);
            model.addAttribute("itemCount", allItems.size());
            return "inventoryAndSupplies/stockManagement/follow-up/followReport";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/checkItemFollowupStatus", method = RequestMethod.POST)
    public @ResponseBody
    String checkItemFollowupStatus(HttpServletRequest request, Model model, @ModelAttribute("activityid") Integer activityid, @ModelAttribute("itemid") Integer itemid, @ModelAttribute("batch") String batch) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            String[] params;
            Object[] paramsValues;
            String where;
            if (batch.equals("-") || batch.equals("")) {
                params = new String[]{"itemid", "stockactivityid"};
                paramsValues = new Object[]{itemid, activityid};
                where = "WHERE itemid=:itemid AND stockactivityid=:stockactivityid";
            } else {
                params = new String[]{"itemid", "stockactivityid", "batchno"};
                paramsValues = new Object[]{itemid, activityid, batch};
                where = "WHERE itemid=:itemid AND stockactivityid=:stockactivityid AND batchno=:batchno";
            }
            String[] fields = {"followupaction", "followupcomment"};
            List<Object[]> itemStatus = (List<Object[]>) genericClassService.fetchRecord(Activityfollowup.class, fields, where, params, paramsValues);
            Map<String, Object> status = new HashMap<>();
            if (itemStatus != null) {
                Object[] details = itemStatus.get(0);
                status.put("action", details[0]);
                if (details[1] != null) {
                    status.put("comment", details[0]);
                }
            } else {
                status.put("action", "-");
                status.put("comment", "-");
            }
            String response = "";
            try {
                response = new ObjectMapper().writeValueAsString(status);
            } catch (JsonProcessingException ex) {
                System.out.println(ex);
            }
            return response;
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/addItemtoStock", method = RequestMethod.POST)
    public @ResponseBody
    String addItemtoStock(HttpServletRequest request, Model model, @ModelAttribute("activityid") Integer activityid, @ModelAttribute("itemid") Integer itemid, @ModelAttribute("discrepancy") Integer discrepancy, @ModelAttribute("batch") String batch, @ModelAttribute("expiry") String expiry) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null && request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            Long staffid = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
            Integer facilityUnitid = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
            try {
                String[] params;
                Object[] paramsValues;
                String where;
                if (batch.equals("")) {
                    params = new String[]{"itemid", "facilityunitid"};
                    paramsValues = new Object[]{itemid, facilityUnitid};
                    where = "WHERE itemid=:itemid AND facilityunitid=:facilityunitid";
                } else {
                    params = new String[]{"itemid", "facilityunitid", "batchno"};
                    paramsValues = new Object[]{itemid, facilityUnitid, batch};
                    where = "WHERE itemid=:itemid AND facilityunitid=:facilityunitid AND batchnumber=:batchno";
                }
                String[] fields = {"stockid", "quantityrecieved"};
                List<Object[]> stock = (List<Object[]>) genericClassService.fetchRecord(com.iics.store.Stock.class, fields, where, params, paramsValues);
                if (stock == null) {
                    com.iics.store.Stock itemStock = new com.iics.store.Stock();
                    itemStock.setItemid(new Item(itemid.longValue()));
                    itemStock.setQuantityrecieved(discrepancy);
                    itemStock.setDaterecieved(new Date());
                    itemStock.setDateadded(new Date());
                    itemStock.setRecievedby(staffid);
                    itemStock.setFacilityunitid(BigInteger.valueOf(facilityUnitid));
                    itemStock.setSuppliertype("INIT");
                    itemStock.setShelvedstock(0);
                    itemStock.setStockissued(0);
                    itemStock.setSupplierid(BigInteger.valueOf(staffid));
                    if (batch.equals("-") || batch.equals("")) {
                        itemStock.setBatchnumber("-");
                    } else {
                        itemStock.setBatchnumber(batch);
                    }
                    if (!(expiry.equals("") || expiry.length() < 1)) {
                        itemStock.setExpires(true);
                        itemStock.setExpirydate(formatter.parse(expiry));
                    } else {
                        itemStock.setExpires(false);
                    }
                    genericClassService.saveOrUpdateRecordLoadObject(itemStock);
                } else {
                    Object[] stockDetails = stock.get(0);
                    if (!((expiry.equals("") || expiry.length() < 1))) {
                        String[] columns = {"quantityrecieved", "expirydate", "expires"};
                        Object[] columnValues = {(Integer) stockDetails[1] + discrepancy, formatter.parse(expiry), true};
                        String pk = "stockid";
                        Object pkValue = stockDetails[0];
                        genericClassService.updateRecordSQLSchemaStyle(com.iics.store.Stock.class, columns, columnValues, pk, pkValue, "store");
                    } else {
                        String[] columns = {"quantityrecieved", "expires"};
                        Object[] columnValues = {(Integer) stockDetails[1] + discrepancy, false};
                        String pk = "stockid";
                        Object pkValue = stockDetails[0];
                        genericClassService.updateRecordSQLSchemaStyle(com.iics.store.Stock.class, columns, columnValues, pk, pkValue, "store");
                    }
                }
                Activityfollowup followup = new Activityfollowup();
                followup.setBatchno(batch);
                followup.setFollowupaction("ADDED");
                followup.setItemid(new Item(itemid.longValue()));
                followup.setStockactivityid(new Stockactivity(activityid.longValue()));
                followup.setAddedby(BigInteger.valueOf(staffid));
                followup.setDateadded(new Date());
                genericClassService.saveOrUpdateRecordLoadObject(followup);
                return "saved";
            } catch (ParseException e) {
                System.out.println(e);
                return "failed";
            }
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/recordDiscrepancy", method = RequestMethod.POST)
    public @ResponseBody
    String recordDiscrepancy(HttpServletRequest request, Model model, @ModelAttribute("activityid") Integer activityid, @ModelAttribute("itemid") Integer itemid, @ModelAttribute("discrepancy") Integer discrepancy, @ModelAttribute("batch") String batch, @ModelAttribute("expiry") String expiry) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null && request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            Long staffid = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
            Integer facilityUnitid = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
            try {

                String[] params;
                Object[] paramsValues;
                String where;
                if (!"".equals(expiry) && !"".equals(batch)) {
                    params = new String[]{"facilityunitid", "itemid", "batchnumber", "expirydate"};
                    paramsValues = new Object[]{facilityUnitid, itemid, batch.trim().toLowerCase(), formatter.parse(expiry)};
                    where = "WHERE itemid=:itemid AND LOWER(batchnumber)=:batchnumber AND expirydate=:expirydate AND facilityunitid=:facilityunitid";
                } else {
                    if ("".equals(batch) && "".equals(expiry)) {
                        params = new String[]{"facilityunitid", "itemid"};
                        paramsValues = new Object[]{facilityUnitid, itemid, batch.trim().toLowerCase()};
                        where = "WHERE itemid=:itemid AND LOWER(batchnumber)=:batchnumber AND facilityunitid=:facilityunitid";
                    } else if ("".equals(expiry)) {
                        params = new String[]{"facilityunitid", "itemid", "batchnumber"};
                        paramsValues = new Object[]{facilityUnitid, itemid, batch.trim().toLowerCase()};
                        where = "WHERE itemid=:itemid AND LOWER(batchnumber)=:batchnumber AND facilityunitid=:facilityunitid";
                    } else {
                        params = new String[]{"facilityunitid", "itemid", "expirydate"};
                        paramsValues = new Object[]{facilityUnitid, itemid, formatter.parse(expiry)};
                        where = "WHERE itemid=:itemid AND expirydate=:expirydate AND facilityunitid=:facilityunitid";
                    }
                }
                String[] fields = {"stockid"};
                List<Long> stock = (List<Long>) genericClassService.fetchRecord(com.iics.store.Stock.class, fields, where, params, paramsValues);
                if (stock != null) {
                    Long stockid = stock.get(0);
                    Discrepancy stockDiscrepancy = new Discrepancy();
                    stockDiscrepancy.setQuantity(discrepancy);
                    stockDiscrepancy.setDiscrepancytype("DISC");
                    stockDiscrepancy.setStockid(new com.iics.store.Stock(stockid));
                    stockDiscrepancy.setDateadded(new Date());
                    stockDiscrepancy.setDatelogged(new Date());
                    stockDiscrepancy.setLoggedby(BigInteger.valueOf(staffid));
                    stockDiscrepancy = (Discrepancy) genericClassService.saveOrUpdateRecordLoadObject(stockDiscrepancy);
                    if (stockDiscrepancy.getDiscrepancyid() != null) {
                        Activityfollowup followup = new Activityfollowup();
                        followup.setBatchno(batch);
                        followup.setFollowupaction("REDUCED");
                        followup.setItemid(new Item(itemid.longValue()));
                        followup.setStockactivityid(new Stockactivity(activityid.longValue()));
                        followup.setAddedby(BigInteger.valueOf(staffid));
                        followup.setDateadded(new Date());
                        genericClassService.saveOrUpdateRecordLoadObject(followup);
                        new ResetStock(itemid, batch, stockid.intValue(), staffid.intValue(), activityid, discrepancy, genericClassService).start();
                        return "saved";
                    }
                }
                return "failed";
            } catch (ParseException e) {
                return "failed";
            }
        } else {
            return "refresh";
        }
    }

    //Printing
    @RequestMapping(value = "/printUserStockReport", method = RequestMethod.GET)
    public String printUserStockReport(HttpServletRequest request, Model model, @ModelAttribute("file") String fileName) throws FileNotFoundException, IOException {
        Map<String, Object> report = new ObjectMapper().readValue(new FileInputStream(getUserReportPath() + fileName), Map.class);
        model.addAttribute("report", report);
        return "inventoryAndSupplies/stockManagement/cellLocations/printUserStockReport";
    }

    @RequestMapping(value = "/printStockReport", method = RequestMethod.GET)
    public String printStockReport(HttpServletRequest request, Model model, @ModelAttribute("file") String fileName) throws FileNotFoundException, IOException {
        Map<String, Object> report = new ObjectMapper().readValue(new FileInputStream(getStockReportPath() + fileName), Map.class);
        model.addAttribute("report", report);
        return "inventoryAndSupplies/stockManagement/stockCount/printStockReport";
    }

    @RequestMapping(value = "/printDiscrepancyReport", method = RequestMethod.GET)
    public String printDiscrepancyReport(HttpServletRequest request, Model model, @ModelAttribute("file") String fileName) throws FileNotFoundException, IOException {
        Map<String, Object> report = new ObjectMapper().readValue(new FileInputStream(getDiscrepancyReportPath() + fileName), Map.class);
        Integer activityid = (Integer) report.get("activityid");
        List<Map> reportItems = (List<Map>) report.get("reportItems");
        for (int i = 0; i < reportItems.size(); i++) {
            Integer itemid = (Integer) reportItems.get(i).get("itemid");
            List<Map> itemBatches = (List<Map>) reportItems.get(i).get("batches");
            for (int j = 0; j < itemBatches.size(); j++) {
                String batchNo = (String) itemBatches.get(j).get("batch");
                itemBatches.get(j).put("action", getFollowUpComment(activityid, itemid, batchNo));
            }
            reportItems.get(i).put("batches", itemBatches);
        }
        report.put("reportItems", reportItems);
        model.addAttribute("report", report);
        return "inventoryAndSupplies/stockManagement/follow-up/printFollowupReport";
    }

    @RequestMapping(value = "/createUserStockReportPDF", method = RequestMethod.GET)
    public @ResponseBody
    String createUserStockReportPDF(HttpServletRequest request, Model model, @ModelAttribute("file") String fileName) {
        String baseEncode = "";
        File json = new File(getUserReportPath() + fileName);
        String url = IICS.BASE_URL + "stock/printUserStockReport.htm?file=" + fileName;
        String path = getUserReportPath() + fileName.replace(".json", ".pdf");
        PdfWriter pdfWriter;

        Document document = new Document();
        try {
            pdfWriter = PdfWriter.getInstance(document, new FileOutputStream(path));
            document.setPageSize(PageSize.A4);
            document.open();

            URL myWebPage = new URL(url);
            InputStreamReader fis = new InputStreamReader(myWebPage.openStream());
            XMLWorkerHelper worker = XMLWorkerHelper.getInstance();
            worker.parseXHtml(pdfWriter, document, fis);

            document.close();
            pdfWriter.close();
            File pdf = new File(path);
            if (pdf.exists()) {
                baseEncode = Base64.getEncoder().encodeToString(loadFileAsBytesArray(path));
                pdf.delete();
                json.delete();
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return baseEncode;
    }

    @RequestMapping(value = "/createStockReportPDF", method = RequestMethod.GET)
    public @ResponseBody
    String createStockReportPDF(HttpServletRequest request, Model model, @ModelAttribute("file") String fileName) {
        String baseEncode = "";
        File json = new File(getUserReportPath() + fileName);
        String url = IICS.BASE_URL + "stock/printStockReport.htm?file=" + fileName;
        String path = getUserReportPath() + fileName.replace(".json", ".pdf");
        PdfWriter pdfWriter;

        Document document = new Document();
        try {
            pdfWriter = PdfWriter.getInstance(document, new FileOutputStream(path));
            document.setPageSize(PageSize.A4);
            document.open();

            URL myWebPage = new URL(url);
            InputStreamReader fis = new InputStreamReader(myWebPage.openStream());
            XMLWorkerHelper worker = XMLWorkerHelper.getInstance();
            worker.parseXHtml(pdfWriter, document, fis);

            document.close();
            pdfWriter.close();
            File pdf = new File(path);
            if (pdf.exists()) {
                baseEncode = Base64.getEncoder().encodeToString(loadFileAsBytesArray(path));
                pdf.delete();
                json.delete();
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return baseEncode;
    }

    @RequestMapping(value = "/createDiscrepancyReportPDF", method = RequestMethod.GET)
    public @ResponseBody
    String createDiscrepancyReportPDF(HttpServletRequest request, Model model, @ModelAttribute("file") String fileName) {
        String baseEncode = "";
        File json = new File(getDiscrepancyReportPath() + fileName);
        String url = IICS.BASE_URL + "stock/printDiscrepancyReport.htm?file=" + fileName;
        String path = getDiscrepancyReportPath() + fileName.replace(".json", ".pdf");
        PdfWriter pdfWriter;

        Document document = new Document();
        try {
            pdfWriter = PdfWriter.getInstance(document, new FileOutputStream(path));
            document.setPageSize(PageSize.A4);
            document.open();

            URL myWebPage = new URL(url);
            InputStreamReader fis = new InputStreamReader(myWebPage.openStream());
            XMLWorkerHelper worker = XMLWorkerHelper.getInstance();
            worker.parseXHtml(pdfWriter, document, fis);

            document.close();
            pdfWriter.close();
            File pdf = new File(path);
            if (pdf.exists()) {
                baseEncode = Base64.getEncoder().encodeToString(loadFileAsBytesArray(path));
                pdf.delete();
                json.delete();
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return baseEncode;
    }

    public String getUserReportPath() {
        File file;
        String path = "";
        switch (OsCheck.getOperatingSystemType().toString()) {
            case "Windows":
                file = new File("C:/iicsReports/stock/staff");
                path = "C:/iicsReports/stock/staff/";
                if (!file.exists()) {
                    file.mkdirs();
                }
                break;
            case "Linux":
                file = new File("/home/iicsReports/stock/staff");
                path = "/home/iicsReports/stock/staff/";
                if (!file.exists()) {
                    file.mkdirs();
                }
                break;
            case "MacOS":
                file = new File("/Users/iicsReports/stock/staff");
                path = "/Users/iicsReports/stock/staff/";
                if (!file.exists()) {
                    file.mkdirs();
                }
                break;
            default:
                break;
        }
        return path;
    }

    public String getStockReportPath() {
        File file;
        String path = "";
        switch (OsCheck.getOperatingSystemType().toString()) {
            case "Windows":
                file = new File("C:/iicsReports/stock/reports");
                path = "C:/iicsReports/stock/reports/";
                if (!file.exists()) {
                    file.mkdirs();
                }
                break;
            case "Linux":
                file = new File("/home/iicsReports/stock/reports");
                path = "/home/iicsReports/stock/reports/";
                if (!file.exists()) {
                    file.mkdirs();
                }
                break;
            case "MacOS":
                file = new File("/Users/iicsReports/stock/reports");
                path = "/Users/iicsReports/stock/reports/";
                if (!file.exists()) {
                    file.mkdirs();
                }
                break;
            default:
                break;
        }
        return path;
    }

    public String getDiscrepancyReportPath() {
        File file;
        String path = "";
        switch (OsCheck.getOperatingSystemType().toString()) {
            case "Windows":
                file = new File("C:/iicsReports/stock/discrepancies");
                path = "C:/iicsReports/stock/discrepancies/";
                if (!file.exists()) {
                    file.mkdirs();
                }
                break;
            case "Linux":
                file = new File("/home/iicsReports/stock/discrepancies");
                path = "/home/iicsReports/stock/discrepancies/";
                if (!file.exists()) {
                    file.mkdirs();
                }
                break;
            case "MacOS":
                file = new File("/Users/iicsReports/stock/discrepancies");
                path = "/Users/iicsReports/stock/discrepancies/";
                if (!file.exists()) {
                    file.mkdirs();
                }
                break;
            default:
                break;
        }
        return path;
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

    public String getFollowUpComment(Integer activityid, Integer itemid, String batch) {
        String[] params;
        Object[] paramsValues;
        String where;
        if (batch.equals("-") || batch.equals("")) {
            params = new String[]{"itemid", "stockactivityid"};
            paramsValues = new Object[]{itemid, activityid};
            where = "WHERE itemid=:itemid AND stockactivityid=:stockactivityid";
        } else {
            params = new String[]{"itemid", "stockactivityid", "batchno"};
            paramsValues = new Object[]{itemid, activityid, batch};
            where = "WHERE itemid=:itemid AND stockactivityid=:stockactivityid AND batchno=:batchno";
        }
        String[] fields = {"followupaction"};
        List<String> itemStatus = (List<String>) genericClassService.fetchRecord(Activityfollowup.class, fields, where, params, paramsValues);
        if (itemStatus != null) {
            String action = itemStatus.get(0);
            if (action.equalsIgnoreCase("ADDED")) {
                return "A";
            } else {
                return "R";
            }
        } else {
            return "N";
        }
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

    Comparator sortItems = new Comparator<Map>() {
        @Override
        public int compare(final Map o1, final Map o2) {
            try {
                return ((String) o1.get("itemname")).compareTo((String) o2.get("itemname"));
            } catch (Exception e) {
                System.out.println(e);
            }
            return 0;
        }
    };

    //generate batch numbers
    @RequestMapping(value = "/generatebatchnumbers", method = RequestMethod.POST)
    public @ResponseBody
    String generatebatch(HttpServletRequest request, Model model) {
        String results = "";
        List<Map> batchlist = new ArrayList<>();

        //fetching 
        String[] params = {};
        Object[] paramvalues = {};
        String[] fields = {"stockid", "batchnumber"};
        String where = "WHERE batchnumber ~ '^IICS-' order by stockid desc limit 1";
        try {
            List<Object[]> batches = (List<Object[]>) genericClassService.fetchRecord(com.iics.store.Stock.class, fields, where, params, paramvalues);
            String batch;
            if (batches != null) {
//            for (Object[] bat: batches) {
                Object[] bat = batches.get(0);
                String batchNumber = bat[1].toString().replaceAll("[^0-9]", "").trim();
                int batchno = Integer.parseInt(batchNumber);
                batch = String.valueOf(batchno);

//            }
                results = batch;
            } else {
                results = "No records";
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        return results;

    }
}

class OverwriteCountItems extends Thread {

    Integer itemid;
    Integer recountid;
    Integer activitycellid;
    GenericClassService genericClassService;

    public OverwriteCountItems(GenericClassService genericClassService, Integer recountid, Integer itemid, Integer activitycellid) {
        this.itemid = itemid;
        this.recountid = recountid;
        this.activitycellid = activitycellid;
        this.genericClassService = genericClassService;
    }

    @Override
    public void run() {
        String[] columns = {"activitycellid", "itemid"};
        Object[] columnValues = {activitycellid, itemid};
        genericClassService.deleteRecordByByColumns("store.activitycellitem", columns, columnValues);
        String[] params = {"recountid"};
        Object[] paramsValues = {recountid};
        String[] fields = {"countedstock", "batchnumber", "expirydate"};
        String where = "WHERE recountid=:recountid";
        List<Object[]> recountBatches = (List<Object[]>) genericClassService.fetchRecord(Recountitem.class, fields, where, params, paramsValues);
        if (recountBatches != null) {
            for (Object[] bat : recountBatches) {
                Activitycellitem cellItem = new Activitycellitem();
                cellItem.setActivitycellid(new Activitycell(activitycellid.longValue()));
                if (bat[1] != null) {
                    cellItem.setBatchnumber((String) bat[1]);
                }
                cellItem.setCountedstock((Integer) bat[0]);
                cellItem.setItemid(new Item(itemid.longValue()));
                cellItem.setExpirydate((Date) bat[2]);
                cellItem.setDateadded(new Date());
                genericClassService.saveOrUpdateRecordLoadObject(cellItem);
            }
        }
    }
}

class CloseCells extends Thread {

    Integer stockactivityid;
    List stockActivityCells;
    GenericClassService genericClassService;

    public CloseCells(GenericClassService genericClassService, Integer stockactivityid, List stockActivityCells) {
        this.stockactivityid = stockactivityid;
        this.stockActivityCells = stockActivityCells;
        this.genericClassService = genericClassService;
    }

    @Override
    public void run() {
        String[] params = {"stockactivityid"};
        Object[] paramsValues = {stockactivityid};
        String where = "WHERE stockactivityid=:stockactivityid AND startdate=DATE 'now'";
        int closeNow = genericClassService.fetchRecordCount(Stockactivity.class, where, params, paramsValues);
        if (closeNow > 0) {
            for (Object cellid : stockActivityCells) {
                String[] columns = {"cellstate"};
                Object[] columnValues = {true};
                String pks = "bayrowcellid";
                Object pkValues = (Integer) cellid;
                genericClassService.updateRecordSQLSchemaStyle(Bayrowcell.class, columns, columnValues, pks, pkValues, "store");
            }
        }
    }
}

class ResetStock extends Thread {

    Integer itemid;
    String batchNo;
    Integer stockid;
    Integer staffid;
    Integer activityid;
    Integer discrepancy;
    GenericClassService genericClassService;

    public ResetStock(Integer itemid, String batchNo, Integer stockid, Integer staffid, Integer activityid, Integer discrepancy, GenericClassService genericClassService) {
        this.itemid = itemid;
        this.batchNo = batchNo;
        this.stockid = stockid;
        this.staffid = staffid;
        this.activityid = activityid;
        this.discrepancy = discrepancy;
        this.genericClassService = genericClassService;
    }

    @Override
    public void run() {
        String[] params = {"stockactivityid"};
        Object[] paramsValues = {activityid};
        String[] fields = {"cellid.bayrowcellid", "activitycellid"};
        String where = "WHERE stockactivityid=:stockactivityid";
        List<Object[]> activtyCells = (List<Object[]>) genericClassService.fetchRecord(Activitycell.class, fields, where, params, paramsValues);
        if (activtyCells != null) {
            for (Object[] cellid : activtyCells) {
                String[] params2 = {"stockid", "cellid"};
                Object[] paramsValues2 = {stockid, cellid[0]};
                String[] fields2 = {"shelfstockid", "quantityshelved"};
                String where2 = "WHERE stockid=:stockid AND cellid=:cellid AND quantityshelved>0";
                List<Object[]> shelfSTock = (List<Object[]>) genericClassService.fetchRecord(Shelfstock.class, fields2, where2, params2, paramsValues2);
                if (shelfSTock != null) {

                    int quantityCounted = 0;
                    int quantityExpected = (int) shelfSTock.get(0)[1];

                    String[] params3 = {"itemid", "batchnumber", "activitycellid"};
                    Object[] paramsValues3 = {stockid, batchNo.trim().toLowerCase(), cellid[1]};
                    String[] fields3 = {"countedstock"};
                    String where3 = "WHERE itemid=:itemid AND LOWER(batchnumber)=:batchnumber AND activitycellid=:activitycellid";
                    List<Integer> counted = (List<Integer>) genericClassService.fetchRecord(Stockcount.class, fields3, where3, params3, paramsValues3);
                    if (counted != null) {
                        quantityCounted = counted.get(0);
                    }

                    String[] columnsUpdatecell = {"quantityshelved"};
                    Object[] columnValuesUpdatecell = {quantityCounted};
                    String pkUpdatecell = "shelfstockid";
                    Object pkValueUpdatecell = shelfSTock.get(0)[0];
                    int result = genericClassService.updateRecordSQLSchemaStyle(Shelfstock.class, columnsUpdatecell, columnValuesUpdatecell, pkUpdatecell, pkValueUpdatecell, "store");
                    if (result != 0) {
                        new ShelfActivityLog(genericClassService, (Integer) cellid[0], stockid, staffid, "DISC", Math.abs(quantityExpected - quantityCounted)).start();
                    }
                }
            }
        }
        String[] params2 = {"stockid"};
        Object[] paramsValues2 = {stockid};
        String[] fields2 = {"stockissued"};
        String where2 = "WHERE stockid=:stockid";
        List<Integer> shelved = (List<Integer>) genericClassService.fetchRecord(com.iics.store.Stock.class, fields2, where2, params2, paramsValues2);
        if (shelved != null) {
            String[] columns = {"stockissued"};
            Object[] columnValues = {shelved.get(0) + discrepancy};
            String pk = "stockid";
            Object pkValue = stockid;
            genericClassService.updateRecordSQLSchemaStyle(com.iics.store.Stock.class, columns, columnValues, pk, pkValue, "store");
            new StockActivityLog(genericClassService, stockid, staffid, "DISC", discrepancy, null, null, null).start();
        }
    }
}
