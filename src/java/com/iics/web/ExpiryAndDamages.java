/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.service.GenericClassService;
import com.iics.store.Bayrowcell;
import com.iics.store.Cellitems;
import com.iics.store.Unitstoragezones;
import java.io.IOException;
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

/**
 *
 * @author IICS
 */
@Controller
@RequestMapping("/expiryAndDamages")
public class ExpiryAndDamages {

    @Autowired
    GenericClassService genericClassService;
    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");

    @RequestMapping(value = "/expiryAndDamagePane", method = RequestMethod.GET)
    public String stockManagementPane(HttpServletRequest request, Model model) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            List<Map> expiryZones = new ArrayList<>();
            List<Map> isolatedZones = new ArrayList<>();
            Integer facilityUnit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");

            String[] params = {"facilityunitid", "isolated"};
            Object[] paramsValues = {facilityUnit, true};
            String[] fields = {"zoneid", "zonelabel"};
            String where = "WHERE facilityunitid=:facilityunitid AND isolated=:isolated ORDER BY zonelabel GROUP BY zoneid,zonelabel";
            List<Object[]> zones = (List<Object[]>) genericClassService.fetchRecord(Unitstoragezones.class, fields, where, params, paramsValues);
            if (zones != null) {
                Map<String, Object> zone;
                for (Object[] zn : zones) {
                    zone = new HashMap<>();
                    zone.put("id", zn[0]);
                    zone.put("zonename", zn[1]);
                    isolatedZones.add(zone);
                }
            }

            String[] params2 = {"facilityunitid", "isolated"};
            Object[] paramsValues2 = {facilityUnit, false};
            String[] fields2 = {"zoneid", "zonelabel"};
            String where2 = "WHERE facilityunitid=:facilityunitid AND isolated=:isolated AND quantityshelved>0 AND daystoexpire<1 ORDER BY zonelabel GROUP BY zoneid,zonelabel";
            List<Object[]> expZones = (List<Object[]>) genericClassService.fetchRecord(Cellitems.class, fields2, where2, params2, paramsValues2);
            if (expZones != null) {
                Map<String, Object> zone;
                for (Object[] zn : expZones) {
                    zone = new HashMap<>();
                    zone.put("id", zn[0]);
                    zone.put("zonename", zn[1]);
                    expiryZones.add(zone);
                }
            }
            model.addAttribute("zones", isolatedZones);
            model.addAttribute("expiryZones", expiryZones);
            return "inventoryAndSupplies/expiriesManagement/expiryAndDamagePane";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchIsolatedCellContent", method = RequestMethod.POST)
    public String fetchIsolatedCellContent(HttpServletRequest request, Model model, @ModelAttribute("zoneid") Integer zoneid) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            List<Map> rowCells = new ArrayList<>();
            String[] params = {"zoneid", "isolated"};
            Object[] paramsValues = {zoneid, true};
            String[] fields = {"bayrowcellid", "celllabel"};
            String where = "WHERE zoneid=:zoneid AND isolated=:isolated ORDER BY celllabel";
            List<Object[]> cells = (List<Object[]>) genericClassService.fetchRecord(Unitstoragezones.class, fields, where, params, paramsValues);
            if (cells != null) {
                Map<String, Object> cell;
                for (Object[] cl : cells) {
                    cell = new HashMap<>();
                    cell.put("id", cl[0]);
                    cell.put("name", cl[1]);

                    String[] params2 = {"bayrowcellid"};
                    Object[] paramsValues2 = {cl[0]};
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
            model.addAttribute("cells", rowCells);
            return "inventoryAndSupplies/expiriesManagement/isolation/isolatedCells";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/searchCells", method = RequestMethod.POST)
    public String searchCells(HttpServletRequest request, Model model, @ModelAttribute("name") String searchValue, @ModelAttribute("zoneid") Integer zoneid) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            List<Map> rowCells = new ArrayList<>();
            String[] params = {"zoneid", "searchValue", "isolated"};
            Object[] paramsValues = {zoneid, searchValue.trim().toLowerCase() + "%", true};
            String[] fields = {"bayrowcellid", "celllabel"};
            String where = "WHERE zoneid=:zoneid AND isolated=:isolated AND quantityshelved > 0 AND (LOWER(packagename) LIKE :searchValue OR LOWER(categoryname) LIKE :searchValue OR LOWER(classificationname) LIKE :searchValue OR LOWER(batchnumber) LIKE :searchValue OR LOWER(celllabel) LIKE :searchValue) ORDER BY celllabel";
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
            return "inventoryAndSupplies/expiriesManagement/isolation/cellSearchResults";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/searchUnisolatedCells", method = RequestMethod.GET)
    public String searchUnisolatedCells(HttpServletRequest request, Model model, @ModelAttribute("name") String searchValue) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            Integer facilityUnit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
            List<Map> itemsFound = new ArrayList<>();
            String[] params = {"facilityunitid", "value", "isolated"};
            Object[] paramsValues = {facilityUnit, searchValue.trim().toLowerCase() + "%", false};
            String[] fields = {"bayrowcellid", "celllabel", "rowlabel", "baylabel", "zonelabel"};
            String where = "WHERE facilityunitid=:facilityunitid AND isolated=:isolated AND (LOWER(celllabel) LIKE :value OR LOWER(rowlabel) LIKE :value OR LOWER(baylabel) LIKE :value OR LOWER(zonelabel) LIKE :value) ORDER BY celllabel";
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
            return "inventoryAndSupplies/expiriesManagement/isolation/unisolatedCells";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/saveActivityCells", method = RequestMethod.POST)
    public @ResponseBody
    String saveActivityCells(HttpServletRequest request, Model model, @ModelAttribute("cells") String cellsJSON) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            try {
                List<Object> cellList = new ObjectMapper().readValue(cellsJSON, List.class);
                for (Object cellid : cellList) {
                    String[] columns = {"isolated"};
                    Object[] columnValues = {true};
                    String pk = "bayrowcellid";
                    Object pkValue = cellid;
                    genericClassService.updateRecordSQLSchemaStyle(Bayrowcell.class, columns, columnValues, pk, pkValue, "store");
                }
                return "saved";
            } catch (IOException e) {
                return "failed";
            }
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/unisolateCell", method = RequestMethod.POST)
    public @ResponseBody
    String unisolateCell(HttpServletRequest request, Model model, @ModelAttribute("cellid") Integer cellid) {
        if (request.getSession().getAttribute("sessionActiveLoginStaffid") != null) {
            String[] columns = {"isolated"};
            Object[] columnValues = {false};
            String pk = "bayrowcellid";
            Object pkValue = cellid;
            genericClassService.updateRecordSQLSchemaStyle(Bayrowcell.class, columns, columnValues, pk, pkValue, "store");
            return "saved";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchStoreBays", method = RequestMethod.POST)
    public @ResponseBody
    String fetchStoreBays(HttpServletRequest request, Model model, @ModelAttribute("zoneid") Integer zoneid) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            String res = "";
            List<Map> zoneBays = new ArrayList<>();
            String[] params = {"zoneid", "isolated"};
            Object[] paramsValues = {zoneid, true};
            String[] fields = {"zonebayid", "baylabel"};
            String where = "WHERE zoneid=:zoneid AND isolated=:isolated ORDER BY baylabel";
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
    String fetchBayrows(HttpServletRequest request, Model model, @ModelAttribute("bayid") Integer bayid) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            String res = "";
            List<Map> bayRows = new ArrayList<>();
            String[] params = {"zonebayid", "isolated"};
            Object[] paramsValues = {bayid, true};
            String[] fields = {"bayrowid", "rowlabel"};
            String where = "WHERE zonebayid=:zonebayid AND isolated=:isolated ORDER BY rowlabel";
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
    String fetchRowCells(HttpServletRequest request, Model model, @ModelAttribute("rowid") Integer rowid) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            String res = "";
            List<Map> rowCells = new ArrayList<>();
            String[] params = {"bayrowid", "isolated"};
            Object[] paramsValues = {rowid, true};
            String[] fields = {"bayrowcellid", "celllabel"};
            String where = "WHERE bayrowid=:bayrowid AND isolated=:isolated ORDER BY celllabel";
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

    @RequestMapping(value = "/fetchExpiryCellContent", method = RequestMethod.POST)
    public String fetchExpiryCellContent(HttpServletRequest request, Model model, @ModelAttribute("zoneid") Integer zoneid) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            List<Map> rowCells = new ArrayList<>();
            String[] params = {"zoneid", "isolated"};
            Object[] paramsValues = {zoneid, false};
            String[] fields = {"bayrowcellid", "celllabel"};
            String where = "WHERE zoneid=:zoneid AND isolated=:isolated AND quantityshelved>0 AND daystoexpire<1 ORDER BY celllabel GROUP BY bayrowcellid,celllabel";
            List<Object[]> cells = (List<Object[]>) genericClassService.fetchRecord(Cellitems.class, fields, where, params, paramsValues);
            if (cells != null) {
                Map<String, Object> cell;
                for (Object[] cl : cells) {
                    cell = new HashMap<>();
                    cell.put("id", cl[0]);
                    cell.put("name", cl[1]);

                    String[] params2 = {"bayrowcellid"};
                    Object[] paramsValues2 = {cl[0]};
                    String[] fields2 = {"r.itemid", "SUM(r.quantityshelved)"};
                    String where2 = "WHERE bayrowcellid=:bayrowcellid AND quantityshelved>0 AND daystoexpire<1 GROUP BY r.itemid";
                    List<Object[]> items = (List<Object[]>) genericClassService.fetchRecordFunction(Cellitems.class, fields2, where2, params2, paramsValues2, 0, 0);
                    if (items != null) {
                        cell.put("count", String.format("%,d", items.size()));
                    } else {
                        cell.put("count", String.format("%,d", 0));
                    }
                    rowCells.add(cell);
                }
            }
            model.addAttribute("cells", rowCells);
            return "inventoryAndSupplies/expiriesManagement/collectcion/expiryCells";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchCellExpiredItems", method = RequestMethod.POST)
    public String fetchCellItems(HttpServletRequest request, Model model, @ModelAttribute("cellid") Integer cellid) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            List<Map> stockItems = new ArrayList<>();
            String[] params = {"bayrowcellid"};
            Object[] paramsValues = {cellid};
            String[] fields = {"shelfstockid", "packagename", "batchnumber", "daystoexpire", "quantityshelved", "expirydate", "stockid"};
            String where = "WHERE bayrowcellid=:bayrowcellid AND quantityshelved>0 ORDER BY daystoexpire,packagename";
            List<Object[]> classficationList = (List<Object[]>) genericClassService.fetchRecord(Cellitems.class, fields, where, params, paramsValues);
            if (classficationList != null) {
                Map<String, Object> classification;
                for (Object[] object : classficationList) {
                    if (object[5] != null) {
                        if ((int) object[3] < 1) {
                            classification = new HashMap<>();
                            classification.put("id", object[0]);
                            classification.put("name", object[1]);
                            classification.put("batch", object[2]);
                            if (object[3] != null) {
                                classification.put("expiry", (int) object[3]);
                            } else {
                                classification.put("expiry", 0.5);
                            }
                            classification.put("expirydate", new SimpleDateFormat("dd-MM-yyyy").format((Date) object[5]));
                            classification.put("qty", String.format("%,d", (Integer) object[4]));
                            classification.put("stockid", object[6]);
                            stockItems.add(classification);
                        }
                    }
                }
            }
            model.addAttribute("stockItems", stockItems);
            return "inventoryAndSupplies/expiriesManagement/collectcion/expiredItems";
        } else {
            return "refresh";
        }
    }
    
    @RequestMapping(value = "/fetchExpiredItems", method = RequestMethod.POST)
    public String fetchExpiredItems(HttpServletRequest request, Model model) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            Integer facilityUnit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
            List<Map> items = new ArrayList<>();
            
            String[] params = {"facilityunitid", "isolated"};
            Object[] paramsValues = {facilityUnit, true};
            String[] fields = {"r.itemid", "r.packagename", "r.packsize", "COUNT(DISTINCT r.stockid)", "SUM(r.quantityshelved)"};
            String where = "WHERE facilityunitid=:facilityunitid AND isolated=:isolated AND quantityshelved>0 ORDER BY r.packagename GROUP BY r.itemid,r.packagename,r.packsize";
            List<Object[]> expiredItems = (List<Object[]>) genericClassService.fetchRecordFunction(Cellitems.class, fields, where, params, paramsValues, 0, 0);
            if (expiredItems != null) {
                Map<String, Object> item;
                for (Object[] itm : expiredItems) {
                    item = new HashMap<>();
                    item.put("itemid", itm[0]);
                    item.put("itemname", itm[1]);
                    item.put("packsize", itm[2]);
                    item.put("batches", itm[3]);
                    item.put("qty", itm[4]);
                    items.add(item);
                }
            }
            model.addAttribute("items", items);
            return "inventoryAndSupplies/expiriesManagement/expiries/expiredItems";
        } else {
            return "refresh";
        }
    }
}
