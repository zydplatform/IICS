/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.controlpanel.Stafffacilityunit;
import com.iics.domain.Facilityunit;
import com.iics.domain.Searchstaff;
import com.iics.patient.Facilityunitblock;
import com.iics.service.GenericClassService;
import com.iics.store.Bayrow;
import com.iics.store.Bayrowcell;
import com.iics.store.Cellitems;
import com.iics.store.Staffbayrowcell;
import com.iics.store.Storagemechanism;
import com.iics.store.Storagetype;
import com.iics.store.Zone;
import com.iics.store.Staffassignedcell;
import com.iics.store.Unitstoragezones;
import com.iics.store.Zonebay;
import com.iics.utils.OsCheck;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
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
 * @author IICSRemote
 */
@Controller
@RequestMapping("/localsettigs")
public class LocalSettingsController {

    @Autowired
    GenericClassService genericClassService;
    SimpleDateFormat formatterx = new SimpleDateFormat("yyyy-MM-dd");

    @RequestMapping(value = "/manage", method = RequestMethod.GET)
    public String managePageMenu(Model model) {
        return "controlPanel/localSettingsPanel/ManageMenu";
    }

    @RequestMapping(value = "/configure", method = RequestMethod.GET)
    public String configurePageMenu(Model model) {
        return "controlPanel/localSettingsPanel/configureMenu";
    }

    @RequestMapping(value = "/patientsids", method = RequestMethod.GET)
    public String patientsIDs(HttpServletRequest request, Model model) {
        //Facility Unit Blocks
        List<Map> facilityUnitBlocksList = new ArrayList<>();
        String[] paramsBlock = {"active"};
        Object[] paramsValuesBlock = {true};
        String[] fieldsBlock = {"facilityunitblockid", "minval", "maxval", "currentval", "facilityunitid", "active"};
        String whereBlock = "WHERE active=:active ORDER BY currentval";
        List<Object[]> objFacilityUnitBlocks = (List<Object[]>) genericClassService.fetchRecord(Facilityunitblock.class, fieldsBlock, whereBlock, paramsBlock, paramsValuesBlock);
        Map<String, Object> idBlocks;
        if (objFacilityUnitBlocks != null) {
            for (Object[] block : objFacilityUnitBlocks) {
                idBlocks = new HashMap<>();
                idBlocks.put("minval", (Integer) block[1]);
                idBlocks.put("maxval", (Integer) block[2]);
                idBlocks.put("currentval", (Integer) block[3]);

                //Facility Unit
                String[] paramsunit = {"facilityunitid"};
                Object[] paramsValuesunit = {(long) block[4]};
                String whereunit = "WHERE facilityunitid=:facilityunitid";
                String[] fieldsunit = {"facilityunitid", "facilityunitname", "shortname"};
                List<Object[]> objFacilityUnit = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fieldsunit, whereunit, paramsunit, paramsValuesunit);

                if (objFacilityUnit != null) {
                    Object[] unit = objFacilityUnit.get(0);

                    idBlocks.put("facilityunitname", (String) unit[1]);
                    idBlocks.put("shortname", (String) unit[2]);
                    facilityUnitBlocksList.add(idBlocks);
                }
            }
            if (facilityUnitBlocksList.size() > 0) {
                model.addAttribute("blocklist", true);
                model.addAttribute("facilityUnitBlocksList", facilityUnitBlocksList);
            }
        }
        return "controlPanel/localSettingsPanel/patientIDs/generatePatientsIds";
    }

    @RequestMapping(value = "/shelvingtab", method = RequestMethod.GET)
    public String shelvingtab(HttpServletRequest request, Model model) {
        List<Map> spacemechanismlist = new ArrayList<>();
        Map<String, Object> spacemechanism;
        String[] params2 = {};
        Object[] paramsValues2 = {};
        String[] fields2 = {"storagemechanismid", "storagemechanismname"};
        String where2 = "";
        List<Object[]> spaceMechanismObj = (List<Object[]>) genericClassService.fetchRecord(Storagemechanism.class, fields2, where2, params2, paramsValues2);
        if (spaceMechanismObj != null) {
            for (Object[] x : spaceMechanismObj) {
                spacemechanism = new HashMap();
                spacemechanism.put("sMechanismid", x[0]);
                spacemechanism.put("sMechanismName", x[1]);
                spacemechanismlist.add(spacemechanism);
            }
        }
        List<Map> spacetypelist = new ArrayList<>();
        Map<String, Object> spacetype;
        String[] params3 = {};
        Object[] paramsValues3 = {};
        String[] fields3 = {"storagetype", "storagetypename"};
        String where3 = "";
        List<Object[]> spacetypeObj = (List<Object[]>) genericClassService.fetchRecord(Storagetype.class, fields3, where3, params3, paramsValues3);
        if (spacetypeObj != null) {
            for (Object[] v : spacetypeObj) {
                spacetype = new HashMap();
                spacetype.put("stypeid", v[0]);
                spacetype.put("stypeName", v[1]);
                spacetypelist.add(spacetype);
            }
        }

        //Created Zones display 
        String page = "";
        BigInteger facilityunitid = BigInteger.valueOf(Long.parseLong(String.valueOf((int) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))));
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") == null) {
            page = "refresh";
        } else {
            List<Map> zoneObjList = new ArrayList<>();
            Map<String, Object> ZoneObjMap = null;
            String searchdata = "";
            String[] params4 = {"facilityunitid"};
            Object[] paramsValues4 = {facilityunitid};
            String[] fields4 = {"zoneid", "zonelabel", "storagetypeid.storagetype", "searchstate"};
            String where4 = "WHERE facilityunitid=:facilityunitid  ORDER BY zoneid DESC";
            List<Object[]> zoneObj = (List<Object[]>) genericClassService.fetchRecord(Zone.class, fields4, where4, params4, paramsValues4);
            if (zoneObj != null) {
                for (Object[] d : zoneObj) {
                    int zoneid = Integer.parseInt(String.valueOf(d[0]));
                    ZoneObjMap = new HashMap();
                    ZoneObjMap.put("zoneid", d[0]);
                    ZoneObjMap.put("zoneName", d[1]);
                    ZoneObjMap.put("storageTyped", storagetypeCountsALL(zoneid).split("-")[1]);
                    ZoneObjMap.put("unstorageTyped", storagetypeCountsALL(zoneid).split("-")[0]);
                    zoneObjList.add(ZoneObjMap);
                }
            }
            String jsonCreatedzone = "";
            try {
                jsonCreatedzone = new ObjectMapper().writeValueAsString(zoneObjList);
            } catch (JsonProcessingException ex) {
                System.out.println(ex);
            }
            model.addAttribute("jsonCreatedzone", jsonCreatedzone);
            model.addAttribute("CreatedZone", zoneObjList);
            model.addAttribute("StorageMechanism", spacemechanismlist);
            model.addAttribute("StorageType", spacetypelist);
            page = "controlPanel/localSettingsPanel/unitStorageSpace/storagespace";
        }
        return page;
    }

    @RequestMapping(value = "/manageshelvingtab", method = RequestMethod.GET)
    public String manageshelvingtab(HttpServletRequest request, Model model) {
        String pagereturn = "";
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            BigInteger facilityunitid = BigInteger.valueOf(Long.parseLong(String.valueOf((int) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))));
            List<Map> zoneObjList = new ArrayList<>();
            Map<String, Object> ZoneObjMap;
            Map<String, Object> bayxxObjMap = null;
            Map<String, Object> rowxxObjMap = null;
            ObjectMapper mapper = new ObjectMapper();
            String[] params4 = {"facilityunitid"};
            Object[] paramsValues4 = {facilityunitid};
            String[] fields4 = {"zoneid", "zonelabel", "storagetypeid.storagetype", "addedby", "zonestate"};
            String where4 = "WHERE facilityunitid=:facilityunitid ORDER BY zoneid DESC";
            List<Object[]> zoneObj = (List<Object[]>) genericClassService.fetchRecord(Zone.class, fields4, where4, params4, paramsValues4);
            if (zoneObj != null) {
                for (Object[] d : zoneObj) {
                    ZoneObjMap = new HashMap();
                    ZoneObjMap.put("zoneid", d[0]);
                    ZoneObjMap.put("zoneName", d[1]);
                    ZoneObjMap.put("addedby", d[3]);
                    ZoneObjMap.put("zonestate", d[4]);

                    //checking
                    List<Map> baycountsList = new ArrayList<>();
                    String[] params6 = {"zoneid"};
                    Object[] paramsValues6 = {d[0]};
                    String[] fields6 = {"zonebayid"};
                    String where6 = "WHERE zoneid=:zoneid ";
                    List<Integer> bayObj = (List<Integer>) genericClassService.fetchRecord(Zonebay.class, fields6, where6, params6, paramsValues6);
                    if (bayObj != null) {
                        ZoneObjMap.put("bayscount", bayObj.size());
                        for (Integer x : bayObj) {
                            bayxxObjMap = new HashMap();
                            bayxxObjMap.put("zonebaysid", x);
                            baycountsList.add(bayxxObjMap);
                        }
                    }

                    List<Map> bayzids = null;
                    try {
                        bayzids = (ArrayList<Map>) mapper.readValue(mapper.writeValueAsString(baycountsList), List.class);
                    } catch (JsonProcessingException ex) {
                        System.out.println(ex);
                    } catch (IOException ex) {
                        System.out.println(ex);
                    }

                    List<Map> rowcountsList = new ArrayList<>();
                    for (Map v : bayzids) {
                        String[] params7 = {"zonebayid"};
                        Object[] paramsValues7 = {v.get("zonebaysid")};
                        String[] fields7 = {"bayrowid"};
                        String where7 = "WHERE zonebayid=:zonebayid";
                        List<Integer> rowObj = (List<Integer>) genericClassService.fetchRecord(Bayrow.class, fields7, where7, params7, paramsValues7);
                        if (rowObj != null) {
                            for (Integer n : rowObj) {
                                rowxxObjMap = new HashMap();
                                rowxxObjMap.put("bayrowid", n);
                                rowcountsList.add(rowxxObjMap);
                            }
                        }
                    }
                    ZoneObjMap.put("rowscount", rowcountsList.size());
                    String[] params8 = {"zoneid"};
                    Object[] paramsValues8 = {d[0]};
                    String[] fields8 = {"bayrowcellid"};
                    String where8 = "WHERE zoneid=:zoneid ";
                    List<Integer> cellObj = (List<Integer>) genericClassService.fetchRecord(Unitstoragezones.class, fields8, where8, params8, paramsValues8);
                    if (cellObj != null) {
                        ZoneObjMap.put("cellscount", cellObj.size());
                    }
                    zoneObjList.add(ZoneObjMap);
                }
            }
            model.addAttribute("managezone", zoneObjList);
            pagereturn = "controlPanel/localSettingsPanel/unitStorageSpace/views/managespace";
        } else {
            pagereturn = "refresh";
        }
        return pagereturn;
    }

    @RequestMapping(value = "/createZones")
    public @ResponseBody
    String createZones(HttpServletRequest request, Model model,
            @ModelAttribute("zones") String zonex,
            @ModelAttribute("bays") String baysx,
            @ModelAttribute("rows") String rowsx,
            @ModelAttribute("cells") String cellsx) {
        String msg = "";
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            try {
                Zone creatingzone;
                Zonebay creatingbay;
                Bayrow creatingrows;
                Bayrowcell creatingcells;
                //BigInteger systemuserid = BigInteger.valueOf((Long) request.getSession().getAttribute("systemuserid"));
                BigInteger facilityunitid = BigInteger.valueOf(Long.parseLong(String.valueOf((int) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))));
                ObjectMapper mapper = new ObjectMapper();
                List<Map> zoneV = (ArrayList<Map>) mapper.readValue(zonex, List.class);
                for (Map w : zoneV) {
                    creatingzone = new Zone();
                    creatingzone.setZonelabel(w.get("zoneName").toString());
                    //creatingzone.setStoragetypeid(new Storagetype(Long.valueOf((String) zoneV.get(0).get("zoneType"))));
                    creatingzone.setFacilityunitid(facilityunitid);
                    //creatingzone.setAddedby(systemuserid.intValue());
                    creatingzone.setDateadded(new Date());
                    creatingzone.setLastupdated(new Date());
                    //creatingzone.setLastupdatedby(systemuserid.intValue());
                    creatingzone.setZonestate(true);
                    creatingzone.setSearchstate(true);
                    Object savedzone = genericClassService.saveOrUpdateRecordLoadObject(creatingzone);
                    if (savedzone != null) {
                        int zoneid = creatingzone.getZoneid();
                        List<Map> bayV = (ArrayList<Map>) mapper.readValue(baysx, List.class);
                        for (Map n : bayV) {
                            creatingbay = new Zonebay();
                            String baylabel = (String) n.get("zonebaylabel");
                            String baymechanism = (String) n.get("baymechanism");
                            creatingbay.setBaylabel(baylabel);
                            creatingbay.setZoneid(new Zone(zoneid));
                            creatingbay.setStoragemechanismid(new Storagemechanism(Long.parseLong(baymechanism)));
                            Object savedbay = genericClassService.saveOrUpdateRecordLoadObject(creatingbay);
                            if (savedbay != null) {
                                int zonebayid = creatingbay.getZonebayid();
                                List<Map> rowV = (ArrayList<Map>) mapper.readValue(rowsx, List.class);
                                for (Map k : rowV) {
                                    if (Integer.parseInt(n.get("zonebayid").toString()) == Integer.parseInt(k.get("bayid").toString())) {
                                        creatingrows = new Bayrow();
                                        String rowlabel = (String) k.get("BayrowtestArray");
                                        creatingrows.setRowlabel(rowlabel);
                                        creatingrows.setZonebayid(new Zonebay(zonebayid));
                                        Object savedRow = genericClassService.saveOrUpdateRecordLoadObject(creatingrows);
                                        if (savedRow != null) {
                                            int bayrowid = creatingrows.getBayrowid();
                                            List<Map> cellsV = (ArrayList<Map>) mapper.readValue(cellsx, List.class);
                                            for (Map h : cellsV) {
                                                // System.out.println("===============================" + Integer.parseInt(k.get("bayrowidxxx").toString()) + "==" + Integer.parseInt(h.get("rowid").toString()));
                                                if (Integer.parseInt(k.get("bayrowidxxx").toString()) == Integer.parseInt(h.get("rowid").toString())) {
                                                    //System.out.println("===============================" + Integer.parseInt(k.get("rowidpos").toString()) + "==" + Integer.parseInt(h.get("rowidpos").toString()));
                                                    if (Integer.parseInt(k.get("rowidpos").toString()) == Integer.parseInt(h.get("rowidpos").toString())) {
                                                        creatingcells = new Bayrowcell();
                                                        long num = 0;
                                                        System.out.println("--------------------------" + h.get("celllabel"));
                                                        creatingcells.setCelllabel((String) h.get("celllabel"));
                                                        creatingcells.setBayrowid(new Bayrow(bayrowid));
                                                        creatingcells.setCellstate(false);
                                                        creatingcells.setStoragetypeid(num);
                                                        creatingcells.setIsolated(false);
                                                        Object CellcreatedObj = genericClassService.saveOrUpdateRecordLoadObject(creatingcells);
                                                        if (CellcreatedObj != null) {
                                                            msg = "success";
                                                        } else {
                                                            msg = "failed";
                                                        }

                                                    }
                                                }
                                            }
                                        }
                                    }
                                }

                            }
                        }
                    }
                }
            } catch (JsonProcessingException ex) {
                System.out.println(ex);
            } catch (IOException ex) {
                System.out.println(ex);
            }
        } else {
            msg = "refresh";
        }
        return msg;
    }

    public String StorageType(BigInteger id) {
        String storagetype = "";
        String[] params3 = {"storagetype"};
        Object[] paramsValues3 = {id};
        String[] fields3 = {"storagetype", "storagetypename"};
        String where3 = "WHERE storagetype=:storagetype";
        List<Object[]> spacetypeObj = (List<Object[]>) genericClassService.fetchRecord(Storagetype.class, fields3, where3, params3, paramsValues3);
        if (spacetypeObj != null) {
            for (Object[] n : spacetypeObj) {
                storagetype = (String) n[1];
            }
        }
        return storagetype;
    }

    @RequestMapping(value = "/viewUnitZoneBay", method = RequestMethod.GET)
    public String viewUnitZoneBay(HttpServletRequest request, Model model, @ModelAttribute("selectedzoneid") int zoneid, @ModelAttribute("myid") int selectedid) {
        String zonename = "";
        String[] paramsx = {"zoneid"};
        Object[] paramsValuesx = {zoneid};
        String[] fieldsx = {"zonelabel", "zoneid"};
        String wherex = "WHERE zoneid=:zoneid ";
        List<Object[]> xxObj = (List<Object[]>) genericClassService.fetchRecord(Zone.class, fieldsx, wherex, paramsx, paramsValuesx);
        if (xxObj != null) {
            zonename = (String) xxObj.get(0)[0];
        }
        ObjectMapper mapper = new ObjectMapper();
        String pageSection = "";
        if (selectedid == 1) {
            //bays
            List<Map> selectedzoneObjList = new ArrayList<>();
            Map<String, Object> SelectZoneObjMap = null;
            String[] params6 = {"zoneid"};
            Object[] paramsValues6 = {zoneid};
            String[] fields6 = {"zonebayid", "baylabel"};
            String where6 = "WHERE zoneid=:zoneid ORDER BY zonebayid";
            List<Object[]> bayObj = (List<Object[]>) genericClassService.fetchRecord(Zonebay.class, fields6, where6, params6, paramsValues6);
            if (bayObj != null) {
                for (Object[] x : bayObj) {
                    SelectZoneObjMap = new HashMap();
                    SelectZoneObjMap.put("zonebayid", x[0]);
                    SelectZoneObjMap.put("baylabel", x[1]);
                    SelectZoneObjMap.put("baylabel2", x[1].toString().split("-")[1]);
                    SelectZoneObjMap.put("zonelabel", zonename);
                    SelectZoneObjMap.put("zoneid", zoneid);
                    SelectZoneObjMap.put("lastRowrecord", getLastRow(Integer.valueOf(x[0].toString())));
                    selectedzoneObjList.add(SelectZoneObjMap);
                }

            }

            String jsonselectedbay = "";
            try {
                jsonselectedbay = mapper.writeValueAsString(selectedzoneObjList);
            } catch (JsonProcessingException ex) {
                System.out.println(ex);
            }
            model.addAttribute("jsonselectedbay", jsonselectedbay);
            model.addAttribute("selectedbayMap", SelectZoneObjMap);
            model.addAttribute("selectedbayDetails", selectedzoneObjList);
            model.addAttribute("divtest", "1");
            pageSection = "controlPanel/localSettingsPanel/unitStorageSpace/views/selectedzonemodalDialog";
        } else if (selectedid == 2) {
            //rows
            List<Map> selectedzonebayxObjList = new ArrayList<>();
            Map<String, Object> SelectzonebayxObjMap = null;
            String[] params6 = {"zoneid"};
            Object[] paramsValues6 = {zoneid};
            String[] fields6 = {"zonebayid", "baylabel"};
            String where6 = "WHERE zoneid=:zoneid ";
            List<Object[]> bayvvObj = (List<Object[]>) genericClassService.fetchRecord(Zonebay.class, fields6, where6, params6, paramsValues6);
            if (bayvvObj != null) {
                for (Object[] a : bayvvObj) {
                    SelectzonebayxObjMap = new HashMap();
                    SelectzonebayxObjMap.put("zonebayid", a[0]);
                    SelectzonebayxObjMap.put("baylabel", a[1]);
                    SelectzonebayxObjMap.put("rowcount", countBayRows(Integer.parseInt(a[0].toString())));
                    SelectzonebayxObjMap.put("baylabel2", a[1].toString().split("-")[1]);
                    selectedzonebayxObjList.add(SelectzonebayxObjMap);
                }

            }
            List<Map> bayobjzids = null;
            try {
                bayobjzids = (ArrayList<Map>) mapper.readValue(mapper.writeValueAsString(selectedzonebayxObjList), List.class);
            } catch (JsonProcessingException ex) {
                System.out.println(ex);
            } catch (IOException ex) {
                System.out.println(ex);
            }
            List<Map> selectedrowObjList = new ArrayList<>();
            Map<String, Object> SelectRowObjMap = null;
            for (Map b : bayobjzids) {
                String[] params7 = {"zonebayid"};
                Object[] paramsValues7 = {b.get("zonebayid")};
                String[] fields7 = {"bayrowid", "rowlabel"};
                String where7 = "WHERE zonebayid=:zonebayid ORDER BY bayrowid DESC ";
                List<Object[]> rowObj = (List<Object[]>) genericClassService.fetchRecord(Bayrow.class, fields7, where7, params7, paramsValues7);
                if (rowObj != null) {
                    for (Object[] k : rowObj) {
                        SelectRowObjMap = new HashMap();
                        SelectRowObjMap.put("bayrowid", k[0]);
                        SelectRowObjMap.put("baylabel", b.get("baylabel"));
                        SelectRowObjMap.put("rowlabel", k[1]);
                        SelectRowObjMap.put("zonelabel", zonename);
                        selectedrowObjList.add(SelectRowObjMap);
                    }
                }
            }
            String jsonselectedRow = "";
            try {
                jsonselectedRow = mapper.writeValueAsString(selectedrowObjList);
            } catch (JsonProcessingException ex) {
                System.out.println(ex);
            }
            model.addAttribute("bayListinZone", selectedzonebayxObjList);
            model.addAttribute("jsonselectedRow", jsonselectedRow);
            model.addAttribute("selectedrowMap", SelectRowObjMap);
            model.addAttribute("selectedrowDetails", selectedrowObjList);
            model.addAttribute("divtest", "2");
            pageSection = "controlPanel/localSettingsPanel/unitStorageSpace/views/selectedzonemodalDialog";
        } else if (selectedid == 3) {
            //cells
            List<Map> selectedcellObjList = new ArrayList<>();
            Map<String, Object> SelectCellObjMap = null;
            String[] params8 = {"zoneid"};
            Object[] paramsValues8 = {zoneid};
            String[] fields8 = {"bayrowcellid", "celllabel", "rowlabel", "zonelabel", "cellstate"};
            String where8 = "WHERE zoneid=:zoneid ORDER BY bayrowcellid DESC";
            List<Object[]> rowObj = (List<Object[]>) genericClassService.fetchRecord(Unitstoragezones.class, fields8, where8, params8, paramsValues8);
            if (rowObj != null) {
                for (Object[] k : rowObj) {
                    SelectCellObjMap = new HashMap();
                    SelectCellObjMap.put("cellid", k[0]);
                    SelectCellObjMap.put("celllabel", k[1]);
                    SelectCellObjMap.put("rowlabel", k[2]);
                    SelectCellObjMap.put("zonelabel", k[3]);
                    SelectCellObjMap.put("cellstate", k[4]);
                    SelectCellObjMap.put("zoneid", zoneid);
                    selectedcellObjList.add(SelectCellObjMap);
                }

            }
            String jsonselectedCell = "";
            try {
                jsonselectedCell = mapper.writeValueAsString(selectedcellObjList);
            } catch (JsonProcessingException ex) {
                System.out.println(ex);
            }
            //System.out.println("------------------"+selectedcellObjList);
            model.addAttribute("jsonselectedCell", jsonselectedCell);
            model.addAttribute("selectedcellMap", SelectCellObjMap);
            model.addAttribute("selectedcellDetails", selectedcellObjList);
            model.addAttribute("divtest", "3");
            pageSection = "controlPanel/localSettingsPanel/unitStorageSpace/views/selectedzonemodalDialog";
        }

        return pageSection;
    }

    @RequestMapping(value = "/viewUnitZonecells", method = RequestMethod.GET)
    public String viewUnitZonecells(HttpServletRequest request, Model model, @ModelAttribute("selectedzoneid") int zoneid) {
        String zonename = "";
        String[] paramsx = {"zoneid"};
        Object[] paramsValuesx = {zoneid};
        String[] fieldsx = {"zonelabel", "zoneid"};
        String wherex = "WHERE zoneid=:zoneid ";
        List<Object[]> xxObj = (List<Object[]>) genericClassService.fetchRecord(Zone.class, fieldsx, wherex, paramsx, paramsValuesx);
        if (xxObj != null) {
            zonename = (String) xxObj.get(0)[0];
        }
        ObjectMapper mapper = new ObjectMapper();

        List<Map> selectedcellObjList = new ArrayList<>();
        Map<String, Object> SelectCellObjMap = null;
        String[] params8 = {"zoneid"};
        Object[] paramsValues8 = {zoneid};
        String[] fields8 = {"bayrowcellid", "celllabel", "rowlabel", "zonelabel", "cellstate"};
        String where8 = "WHERE zoneid=:zoneid ORDER BY bayrowcellid DESC";
        List<Object[]> rowObj = (List<Object[]>) genericClassService.fetchRecord(Unitstoragezones.class, fields8, where8, params8, paramsValues8);
        if (rowObj != null) {
            for (Object[] k : rowObj) {
                SelectCellObjMap = new HashMap();
                SelectCellObjMap.put("cellid", k[0]);
                SelectCellObjMap.put("celllabel", k[1]);
                SelectCellObjMap.put("rowlabel", k[2]);
                SelectCellObjMap.put("zonelabel", k[3]);
                SelectCellObjMap.put("zoneid", zoneid);
                selectedcellObjList.add(SelectCellObjMap);
            }

        }
        String jsonselectedCell = "";
        try {
            jsonselectedCell = mapper.writeValueAsString(selectedcellObjList);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }
        //System.out.println("------------------"+selectedcellObjList);
        model.addAttribute("zName", zonename);
        model.addAttribute("jsonselectedCell", jsonselectedCell);
        model.addAttribute("selectedcellMap", SelectCellObjMap);
        model.addAttribute("selectedcellDetails", selectedcellObjList);
        return "controlPanel/localSettingsPanel/unitStorageSpace/views/viewcelllabels";

    }

    @RequestMapping(value = "/checkBaystatus")
    public @ResponseBody
    String checkBaystatus(Model model, @ModelAttribute("selectedzoneid") int zoneid, @ModelAttribute("selectedzonename") String zonename) {
        //bays
        List<Map> selectedzoneObjList = new ArrayList<>();
        Map<String, Object> SelectZoneObjMap = null;
        String[] params6 = {"zoneid"};
        Object[] paramsValues6 = {zoneid};
        String[] fields6 = {"zonebayid", "baylabel"};
        String where6 = "WHERE zoneid=:zoneid ORDER BY zonebayid";
        List<Object[]> bayObj = (List<Object[]>) genericClassService.fetchRecord(Zonebay.class, fields6, where6, params6, paramsValues6);
        if (bayObj != null) {
            for (Object[] x : bayObj) {
                SelectZoneObjMap = new HashMap();
                SelectZoneObjMap.put("zonebayid", x[0]);
                SelectZoneObjMap.put("baylabel", x[1]);
                SelectZoneObjMap.put("baylabel2", x[1].toString().split("-")[1]);
                SelectZoneObjMap.put("zonelabel", zonename);
                SelectZoneObjMap.put("zoneid", zoneid);
                SelectZoneObjMap.put("lastRowrecord", getLastRow(Integer.valueOf(x[0].toString())));
                selectedzoneObjList.add(SelectZoneObjMap);
            }

        }

        String jsonselectedbay = "";
        try {
            jsonselectedbay = new ObjectMapper().writeValueAsString(selectedzoneObjList);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }
        model.addAttribute("jsonselectedbay", jsonselectedbay);
        return jsonselectedbay;
    }

    @RequestMapping(value = "/manageshelveactivity", method = RequestMethod.GET)
    public String manageshelveactivity(HttpServletRequest request, Model model) {
        BigInteger facilityunitid = BigInteger.valueOf(Long.parseLong(String.valueOf((int) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))));
        List<Map> zoneShelveObjList = new ArrayList<>();
        Map<String, Object> ZoneShelveObjMap;
        String[] params4 = {"facilityunitid", "zonestate"};
        Object[] paramsValues4 = {facilityunitid, true};
        String[] fields4 = {"zoneid", "zonelabel", "storagetypeid.storagetype"};
        String where4 = "WHERE facilityunitid=:facilityunitid AND zonestate=:zonestate ORDER BY zoneid DESC";
        List<Object[]> zonexObj = (List<Object[]>) genericClassService.fetchRecord(Zone.class, fields4, where4, params4, paramsValues4);
        if (zonexObj != null) {
            for (Object[] d : zonexObj) {
                ZoneShelveObjMap = new HashMap();
                String[] params5 = {"zoneid"};
                Object[] paramsValues5 = {d[0]};
                String[] fields5 = {"zonebayid", "baylabel"};
                String where5 = "WHERE zoneid=:zoneid";
                List<Object[]> zonebayObj = (List<Object[]>) genericClassService.fetchRecord(Zonebay.class, fields5, where5, params5, paramsValues5);
                if (zonebayObj != null) {
                    for (Object[] e : zonebayObj) {
                        String[] params6 = {"zonebayid"};
                        Object[] paramsValues6 = {e[0]};
                        String[] fields6 = {"bayrowid", "rowlabel"};
                        String where6 = "WHERE zonebayid=:zonebayid";
                        List<Object[]> bayrowObj = (List<Object[]>) genericClassService.fetchRecord(Bayrow.class, fields6, where6, params6, paramsValues6);
                        if (bayrowObj != null) {
                            // ZoneShelveObjMap = new HashMap();[{zoneid=2561, zoneName=MAINSTORE, storagetype=Transactional Storage}, {}]
                            for (Object[] f : bayrowObj) {
                                String[] params7 = {"bayrowid"};
                                Object[] paramsValues7 = {f[0]};
                                String[] fields7 = {"bayrowcellid", "celllabel"};
                                String where7 = "WHERE bayrowid=:bayrowid";
                                List<Object[]> bayrowcellObj = (List<Object[]>) genericClassService.fetchRecord(Bayrowcell.class, fields7, where7, params7, paramsValues7);
                                if (bayrowcellObj != null) {
                                    ZoneShelveObjMap.put("zoneid", d[0]);
                                    ZoneShelveObjMap.put("zoneName", d[1]);
                                }
                            }
                        }
                    }
                }
                //if()
                zoneShelveObjList.add(ZoneShelveObjMap);
            }
        }

        //System.out.println("----------------------------------------" + zoneShelveObjList);
        model.addAttribute("ZoneShelveManage", zoneShelveObjList);
        return "controlPanel/localSettingsPanel/unitStorageSpace/views/manageshelving/manageshelvingactivity";
    }

    @RequestMapping(value = "/selectedBaysList", method = RequestMethod.GET)
    public String selectedBaysList(HttpServletRequest request, Model model, @ModelAttribute("zonebayid") int zonebayid) {
        List<Map> bayrowObjList = new ArrayList<>();
        Map<String, Object> bayrowObjMap;
        String[] params = {"zonebayid"};
        Object[] paramsValues = {zonebayid};
        String[] fields = {"bayrowid", "rowlabel"};
        String where = "WHERE zonebayid=:zonebayid ORDER BY bayrowid DESC";
        List<Object[]> bayrowObj = (List<Object[]>) genericClassService.fetchRecord(Bayrow.class, fields, where, params, paramsValues);
        if (bayrowObj != null) {
            for (Object[] x : bayrowObj) {
                bayrowObjMap = new HashMap();
                bayrowObjMap.put("bayrowid", x[0]);
                bayrowObjMap.put("rowlabel", x[1]);
                bayrowObjMap.put("rowlabel2", x[1].toString().split("-")[2]);
                bayrowObjList.add(bayrowObjMap);
            }
        }
        model.addAttribute("bayrowList", bayrowObjList);
        return "controlPanel/localSettingsPanel/unitStorageSpace/views/selectedbayrowsListing";
    }

    @RequestMapping(value = "/displayfacilitystaffunit", method = RequestMethod.GET)
    public String displayfacilitystaffunit(HttpServletRequest request, Model model, @ModelAttribute("selectedzoneid") int zoneid, @ModelAttribute("selectedname") String zoneName) {
        //System.out.println("**************************" + zoneName);
        BigInteger facilityunitid = BigInteger.valueOf(Long.parseLong(String.valueOf((int) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))));
        List<Map> stafffacilityList = new ArrayList<>();
        Map<String, Object> stafffacilityMap = null;
        boolean status = true;
        String[] params = {"facilityunitid", "active"};
        Object[] paramsValues = {facilityunitid, status};
        String[] fields = {"staffid", "facilityunitid"};
        String where = "WHERE facilityunitid=:facilityunitid AND active=:active";
        List<Object[]> facUnitObj = (List<Object[]>) genericClassService.fetchRecord(Stafffacilityunit.class, fields, where, params, paramsValues);
        if (facUnitObj != null) {
            for (Object[] x : facUnitObj) {
                stafffacilityMap = new HashMap();
                stafffacilityMap.put("staffid", x[0]);
                stafffacilityMap.put("StaffName", Staffname(BigInteger.valueOf(Long.parseLong(String.valueOf(x[0])))));
                stafffacilityMap.put("Zonelabel", zoneName);
                stafffacilityMap.put("zoneid", zoneid);
                stafffacilityList.add(stafffacilityMap);
            }
        }
        model.addAttribute("staffvmember", stafffacilityMap);
        model.addAttribute("staffmembers", stafffacilityList);
        return "controlPanel/localSettingsPanel/unitStorageSpace/views/manageshelving/manageshelvingStaffdisplay";
    }

    @RequestMapping(value = "/staffstoreunit", method = RequestMethod.GET)
    public String staffstoreunit(HttpServletRequest request, Model model, @ModelAttribute("selectedzoneid") int zoneid, @ModelAttribute("staffnames") String staffName, @ModelAttribute("staffid") String staffid, @ModelAttribute("zonelabel") String zoneName) {
        //others search details(Zone details)<!----Starts------>
        Set<Integer> assignedbay = new HashSet<>();
        Set<Integer> assignedrow = new HashSet<>();
        Set<Integer> assignedcell = new HashSet<>();

        String[] paramsvx = {"staffid", "zoneid"};
        Object[] paramsValuesvx = {BigInteger.valueOf(Long.valueOf(staffid)), zoneid};
        String[] fieldsvx = {"bayrowcellid", "zoneid", "bayrowid", "zonebayid"};
        String wherevx = "WHERE staffid =:staffid AND zoneid=:zoneid";
        List<Object[]> staffcellxxObj = (List<Object[]>) genericClassService.fetchRecord(Staffassignedcell.class, fieldsvx, wherevx, paramsvx, paramsValuesvx);
        //System.out.println("-------------***********------------"+staffcellxxObj.size());
        if (staffcellxxObj != null) {
            for (Object[] sfceo : staffcellxxObj) {
                assignedbay.add((int) sfceo[3]);
                assignedrow.add((int) sfceo[2]);
                assignedcell.add((int) sfceo[0]);
            }
        }
        List<Map> ZoneList = new ArrayList<>();
        Map<String, Object> zoneMap = new HashMap();
        Map<String, Object> bayMap = null;
        Map<String, Object> rowMap = null;
        Map<String, Object> cellMap = null;

        zoneMap.put("zoneid", zoneid);
        zoneMap.put("zonelabel", zoneName);
        zoneMap.put("staffName", staffName);
        zoneMap.put("staffid", staffid);
        String[] paramsx = {"zoneid", "staffid"};
        Object[] paramsValuesx = {zoneid, BigInteger.valueOf(Long.valueOf(staffid))};
        String[] fieldsx = {"bayrowcellid", "staffid", "zoneid"};
        String wherex = "WHERE zoneid=:zoneid AND staffid =:staffid";
        List<Object[]> staffcellObj = (List<Object[]>) genericClassService.fetchRecord(Staffbayrowcell.class, fieldsx, wherex, paramsx, paramsValuesx);
        if (staffcellObj != null) {
            //shows staff  with cells assigned
            int test = 0;
            zoneMap.put("staffcheck", test);
            String[] params6 = {"zoneid"};
            Object[] paramsValues6 = {zoneid};
            String[] fields6 = {"zonebayid", "baylabel", "zoneid.zoneid"};
            String where6 = "WHERE zoneid=:zoneid ";
            List<Object[]> bayObj = (List<Object[]>) genericClassService.fetchRecord(Zonebay.class, fields6, where6, params6, paramsValues6);
            List<Map> bayList = new ArrayList<>();
            if (bayObj != null) {
                zoneMap.put("baysize", bayObj.size());
                for (Object[] bay : bayObj) {
                    if (zoneid == Integer.parseInt(bay[2].toString())) {
                        bayMap = new HashMap();
                        bayMap.put("bayid", bay[0]);
                        bayMap.put("bayName", bay[1]);
                        bayMap.put("bayName2", bay[1].toString().split("-")[1]);
                        bayMap.put("zoneid", bay[2]);
                        if (!assignedbay.isEmpty() && assignedbay.contains((int) bay[0])) {
                            bayMap.put("assigned", true);
                        } else {
                            bayMap.put("assigned", false);
                        }
                        String[] params7 = {"zonebayid"};
                        Object[] paramsValues7 = {bay[0]};
                        String[] fields7 = {"bayrowid", "rowlabel", "zonebayid.zonebayid"};
                        String where7 = "WHERE zonebayid=:zonebayid ";
                        List<Object[]> rowObj = (List<Object[]>) genericClassService.fetchRecord(Bayrow.class, fields7, where7, params7, paramsValues7);
                        List<Map> rowList = new ArrayList<>();
                        if (rowObj != null) {
                            bayMap.put("rowsize", rowObj.size());
                            for (Object[] row : rowObj) {
                                if (Integer.parseInt(bay[0].toString()) == Integer.parseInt(row[2].toString())) {
                                    rowMap = new HashMap();
                                    rowMap.put("rowid", row[0]);
                                    rowMap.put("rowlabel", row[1]);
                                    rowMap.put("bayid", row[2]);
                                    //rowMap.put("baysize", rowsize);
                                    if (!assignedrow.isEmpty() && assignedrow.contains((int) row[0])) {
                                        rowMap.put("assigned", true);
                                    } else {
                                        rowMap.put("assigned", false);
                                    }
                                    //cells
                                    String[] params8 = {"bayrowid"};
                                    Object[] paramsValues8 = {row[0]};
                                    String[] fields8 = {"bayrowcellid", "celllabel", "bayrowid.bayrowid", "celltranslimit"};
                                    String where8 = "WHERE bayrowid=:bayrowid";
                                    List<Object[]> cellObj = (List<Object[]>) genericClassService.fetchRecord(Bayrowcell.class, fields8, where8, params8, paramsValues8);
                                    List<Map> cellList = new ArrayList<>();
                                    if (cellObj != null) {
                                        rowMap.put("cellsize", cellObj.size());
                                        for (Object[] cell : cellObj) {
                                            if (Integer.parseInt(row[0].toString()) == Integer.parseInt(cell[2].toString())) {
                                                cellMap = new HashMap();
                                                cellMap.put("cellid", cell[0]);
                                                cellMap.put("cellLabel", cell[1]);
                                                cellMap.put("rowid", cell[2]);
                                                int trsLimit = Integer.parseInt(cell[3].toString());
                                                if (trsLimit == 0) {
                                                    cellMap.put("transLimit", " ");
                                                } else {
                                                    cellMap.put("transLimit", cell[3]);
                                                }
                                                if (!assignedcell.isEmpty() && assignedcell.contains((int) cell[0])) {
                                                    cellMap.put("assigned", true);
                                                } else {
                                                    cellMap.put("assigned", false);
                                                }
                                                cellList.add(cellMap);
                                            }
                                        }
//
                                    }
                                    rowMap.put("cells", cellList);
                                    rowList.add(rowMap);
                                }
                            }
                        }
                        bayMap.put("rows", rowList);
                        bayList.add(bayMap);
                    }
                }

            }
            zoneMap.put("bays", bayList);
            zoneMap.put("StaffassignedcellCount", staffcellxxObj.size());
            ZoneList.add(zoneMap);
        } else {
            //shows staff without cells assigned
            int test = 1;
            zoneMap.put("staffcheck", test);
            String[] params6 = {"zoneid"};
            Object[] paramsValues6 = {zoneid};
            String[] fields6 = {"zonebayid", "baylabel", "zoneid.zoneid"};
            String where6 = "WHERE zoneid=:zoneid ";
            List<Object[]> bayObj = (List<Object[]>) genericClassService.fetchRecord(Zonebay.class, fields6, where6, params6, paramsValues6);
            List<Map> bayList = new ArrayList<>();
            if (bayObj != null) {
                zoneMap.put("baysize", bayObj.size());
                for (Object[] bay : bayObj) {
                    if (zoneid == Integer.parseInt(bay[2].toString())) {
                        bayMap = new HashMap();
                        bayMap.put("bayid", bay[0]);
                        bayMap.put("bayName", bay[1]);
                        bayMap.put("bayName2", bay[1].toString().split("-")[1]);
                        bayMap.put("zoneid", bay[2]);

                        String[] params7 = {"zonebayid"};
                        Object[] paramsValues7 = {bay[0]};
                        String[] fields7 = {"bayrowid", "rowlabel", "zonebayid.zonebayid"};
                        String where7 = "WHERE zonebayid=:zonebayid ";
                        List<Object[]> rowObj = (List<Object[]>) genericClassService.fetchRecord(Bayrow.class, fields7, where7, params7, paramsValues7);
                        List<Map> rowList = new ArrayList<>();
                        if (rowObj != null) {
                            bayMap.put("rowsize", rowObj.size());
                            for (Object[] row : rowObj) {
                                if (Integer.parseInt(bay[0].toString()) == Integer.parseInt(row[2].toString())) {
                                    rowMap = new HashMap();
                                    rowMap.put("rowid", row[0]);
                                    rowMap.put("rowlabel", row[1]);
                                    rowMap.put("bayid", row[2]);
                                    //rowMap.put("baysize", rowsize);

                                    //cells
                                    String[] params8 = {"bayrowid"};
                                    Object[] paramsValues8 = {row[0]};
                                    String[] fields8 = {"bayrowcellid", "celllabel", "bayrowid.bayrowid"};
                                    String where8 = "WHERE bayrowid=:bayrowid";
                                    List<Object[]> cellObj = (List<Object[]>) genericClassService.fetchRecord(Bayrowcell.class, fields8, where8, params8, paramsValues8);
                                    List<Map> cellList = new ArrayList<>();
                                    if (cellObj != null) {
                                        rowMap.put("cellsize", cellObj.size());
                                        for (Object[] cell : cellObj) {
                                            if (Integer.parseInt(row[0].toString()) == Integer.parseInt(cell[2].toString())) {
                                                cellMap = new HashMap();
                                                cellMap.put("cellid", cell[0]);
                                                cellMap.put("cellLabel", cell[1]);
                                                cellMap.put("rowid", cell[2]);
                                                cellList.add(cellMap);
                                            }
                                        }
                                    }
                                    rowMap.put("cells", cellList);
                                    rowList.add(rowMap);
                                }
                            }
                        }
                        bayMap.put("rows", rowList);
                        bayList.add(bayMap);
                    }
                }

            }
            zoneMap.put("bays", bayList);
            ZoneList.add(zoneMap);
        }

        //System.out.println("-************************-----------" + ZoneList);
        model.addAttribute("Zonetree", zoneMap);
        model.addAttribute("ZoneTreedata", ZoneList);
        String jsonzonetree = "";
        try {
            jsonzonetree = new ObjectMapper().writeValueAsString(ZoneList);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }
        model.addAttribute("jsonzonetree", jsonzonetree);

        //<!-------Ends--------->
        return "controlPanel/localSettingsPanel/unitStorageSpace/views/manageshelving/showStaffStorageUnits";
    }

    @RequestMapping(value = "/Operationalspace", method = RequestMethod.GET)
    public String Operationalspace(HttpServletRequest request, Model model) {
        String page = null;
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            BigInteger facilityunitid = BigInteger.valueOf(Long.parseLong(String.valueOf((int) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))));
            List<Map> ZoneSpaceList = new ArrayList<>();
            Map<String, Object> zonespaceMap = new HashMap();
            String[] params4 = {"facilityunitid"};
            Object[] paramsValues4 = {facilityunitid};
            String[] fields4 = {"zoneid", "zonelabel", "searchstate"};
            String where4 = "WHERE facilityunitid=:facilityunitid  ORDER BY zoneid DESC";
            List<Object[]> zoneObj = (List<Object[]>) genericClassService.fetchRecord(Zone.class, fields4, where4, params4, paramsValues4);
            if (zoneObj != null) {
                for (Object[] d : zoneObj) {
                    zonespaceMap = new HashMap();
                    zonespaceMap.put("zoneid", d[0]);
                    zonespaceMap.put("zoneName", d[1]);
                    //zonespaceMap.put("CellLimit", cellLimit((int) d[0]));
                    zonespaceMap.put("Searchlist", d[2]);
                    ZoneSpaceList.add(zonespaceMap);
                }
            }
            model.addAttribute("Zonespace", ZoneSpaceList);
            page = "controlPanel/localSettingsPanel/unitStorageSpace/views/managestorefunction/manageoperationalspace";
        } else {
            page = "refresh";
        }
        return page;
    }

    @RequestMapping(value = "/getcells")
    public @ResponseBody
    String getcells(HttpServletRequest request, Model model, @ModelAttribute("zoneid") int zoneid) {
        List<Map> getcellsList = new ArrayList<>();
        Map<String, Object> getcellsMap;
        ObjectMapper mapper = new ObjectMapper();
        String[] params = {"zoneid"};
        Object[] paramsValues = {zoneid};
        String[] fields = {"bayrowcellid", "celllabel", "celltranslimit"};
        String where = "WHERE zoneid=:zoneid";
        List<Object[]> bayrowcellidObj = (List<Object[]>) genericClassService.fetchRecord(Unitstoragezones.class, fields, where, params, paramsValues);
        if (bayrowcellidObj != null) {
            for (Object[] x : bayrowcellidObj) {
                int limt = Integer.parseInt(x[2].toString());
                if (limt != 0) {
                    getcellsMap = new HashMap();
                    getcellsMap.put("bayrowcellid", x[0]);
                    getcellsMap.put("cellLabel", x[1]);
                    getcellsMap.put("cellLmt", x[2]);
                    getcellsList.add(getcellsMap);
                }
            }
        }
        String jsoncellsandlimits = null;
        try {
            jsoncellsandlimits = mapper.writeValueAsString(getcellsList);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }

        return jsoncellsandlimits;
    }

    @RequestMapping(value = "/storagetypeshow", method = RequestMethod.GET)
    public String storagetypeshow(HttpServletRequest request, Model model) {
        String page = "";
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            List<Map> spacetypelistz = new ArrayList<>();
            List<Map> checklabelslistz = new ArrayList<>();
            Map<String, Object> spacetypez;
            Map<String, Object> checklabels;
            String[] params3 = {};
            Object[] paramsValues3 = {};
            String[] fields3 = {"storagetype", "storagetypename"};
            String where3 = "ORDER BY storagetype DESC";
            List<Object[]> spacetypeObj = (List<Object[]>) genericClassService.fetchRecord(Storagetype.class, fields3, where3, params3, paramsValues3);
            if (spacetypeObj != null) {
                for (Object[] v : spacetypeObj) {
                    //if (Integer.parseInt(String.valueOf(v[0])) > 4) {
                    spacetypez = new HashMap();
                    spacetypez.put("stypeid", v[0]);
                    spacetypez.put("stypeName", v[1]);
                    Object[] storagetypevObject = storageTypecount(BigInteger.valueOf(Long.parseLong(v[0].toString())));
                    spacetypez.put("stypecount", storagetypevObject[0]);
                    spacetypez.put("stypeCells", storagetypevObject[1]);
                    spacetypelistz.add(spacetypez);
                    //}
                }
            }

            String jsonspacetypelistz = "";
            try {
                jsonspacetypelistz = new ObjectMapper().writeValueAsString(spacetypelistz);
            } catch (JsonProcessingException ex) {
                System.out.println(ex);
            }
            model.addAttribute("jsonstoragespaceList", jsonspacetypelistz);
            model.addAttribute("storagespaceList", spacetypelistz);

            //Restrict zonelabels,baylabels,rowlabels,celllabels as storage types
            BigInteger facUnitid = BigInteger.valueOf(Long.parseLong(String.valueOf((int) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))));
            String[] params = {"facilityunitid"};
            Object[] paramsValues = {facUnitid};
            String[] fields = {"zonelabel", "baylabel", "rowlabel", "celllabel"};
            String where = "WHERE facilityunitid=:facilityunitid";
            List<Object[]> checkObj = (List<Object[]>) genericClassService.fetchRecord(Unitstoragezones.class, fields, where, params, paramsValues);
            if (checkObj != null) {
                for (Object[] v : checkObj) {
                    checklabels = new HashMap();
                    checklabels.put("zonelabel",v[0]);
                    checklabels.put("baylabel",v[1]);
                    checklabels.put("rowlabel",v[2]);
                    checklabels.put("celllabel",v[3]);
                    checklabelslistz.add(checklabels);
                }
            }
            String jsonchecklabelslistz = "";
            try {
                jsonchecklabelslistz = new ObjectMapper().writeValueAsString(checklabelslistz);
            } catch (JsonProcessingException ex) {
                System.out.println(ex);
            }
            model.addAttribute("jsonchecklabelslist", jsonchecklabelslistz);
            page = "controlPanel/localSettingsPanel/unitStorageSpace/views/showViewstoragetype";
        } else {
            page = "refresh";
        }
        return page;
    }

    @RequestMapping(value = "/addStoragetypeorEdit")
    public @ResponseBody
    String addStoragetypeorEdit(HttpServletRequest request, Model model, @ModelAttribute("storageTypename") String storagetypename, @ModelAttribute("type") int typexz) {
        String msg = "";
        System.out.println("~~~~~~~~~~~~~~~~~~"+typexz);
        if (typexz == 1) {
            Storagetype storagetype = new Storagetype();
            storagetype.setStoragetypename(storagetypename);
            Object saved = genericClassService.saveOrUpdateRecordLoadObject(storagetype);
            if (saved != null) {
                msg = "success";
            } else {
                msg = "failure";
            }
        } else if (typexz == 2) {
            try {
                List<Map> storageTypeObj = (ArrayList<Map>) new ObjectMapper().readValue(storagetypename, List.class);
                int storagetypeid = Integer.parseInt(storageTypeObj.get(0).get("stypeid").toString());
                String storagetypeName = storageTypeObj.get(0).get("stypename").toString();
                String[] columnslev = {"storagetypename"};
                Object[] columnValueslev = {storagetypeName};
                String levelPrimaryKey = "storagetype";
                Object levelPkValue = storagetypeid;
                Object savedx = genericClassService.updateRecordSQLSchemaStyle(Storagetype.class, columnslev, columnValueslev, levelPrimaryKey, levelPkValue, "store");
                if (savedx != null) {
                    msg = "success";
                } else {
                    msg = "failure";
                }
            } catch (IOException ex) {
                System.out.println(ex);
            }
        }
        return msg;
    }

    @RequestMapping(value = "/updatesearchstatus")
    public @ResponseBody
    String updatesearchstatus(HttpServletRequest request, Model model, @ModelAttribute("searchstatus") boolean searchstatus, @ModelAttribute("zoneid") int zoneid) {
        //System.out.println("----------b----"+searchstatus);
        //  System.out.println("----------v----"+zoneid);
        String[] columnslev = {"searchstate"};
        Object[] columnValueslev = {searchstatus};
        String levelPrimaryKey = "zoneid";
        Object levelPkValue = zoneid;
        genericClassService.updateRecordSQLSchemaStyle(Zone.class, columnslev, columnValueslev, levelPrimaryKey, levelPkValue, "store");
        return "";
    }

    @RequestMapping(value = "/activateDeactivatezone", method = RequestMethod.GET)
    public String activateDeactivatezone(HttpServletRequest request, Model model, @ModelAttribute("zonestate") boolean zonestatus, @ModelAttribute("zoneid") int zoneid) {
        String[] columnslev = {"zonestate"};
        Object[] columnValueslev = {zonestatus};
        String levelPrimaryKey = "zoneid";
        Object levelPkValue = zoneid;
        genericClassService.updateRecordSQLSchemaStyle(Zone.class, columnslev, columnValueslev, levelPrimaryKey, levelPkValue, "store");
        return "";
    }

    @RequestMapping(value = "/activateDeactivatecell", method = RequestMethod.GET)
    public String activateDeactivatecell(HttpServletRequest request, Model model, @ModelAttribute("cellstate") boolean cellstatus, @ModelAttribute("cellid") int cellid) {
        String[] columnslev = {"cellstate"};
        Object[] columnValueslev = {cellstatus};
        String levelPrimaryKey = "bayrowcellid";
        Object levelPkValue = cellid;
        genericClassService.updateRecordSQLSchemaStyle(Bayrowcell.class, columnslev, columnValueslev, levelPrimaryKey, levelPkValue, "store");
        return "";
    }

    //
    @RequestMapping(value = "/updatecellLimit")
    public @ResponseBody
    String updatecellLimit(Model model, @ModelAttribute("id") int cellid, @ModelAttribute("celllimit") int cellinput) {
        String msg = null;
        String[] columnslev = {"celltranslimit"};
        Object[] columnValueslev = {cellinput};
        String levelPrimaryKey = "bayrowcellid";
        Object levelPkValue = cellid;
        Object updatelimit = genericClassService.updateRecordSQLSchemaStyle(Bayrowcell.class, columnslev, columnValueslev, levelPrimaryKey, levelPkValue, "store");
        if (updatelimit != null) {
            msg = "success";
        } else {
            msg = "fail";
        }
        return msg;
    }

    public Integer cellLimit(int zoneid) {
        Integer translimit = 0;
        String[] params = {"zoneid"};
        Object[] paramsValues = {zoneid};
        String[] fields = {"zoneid.zoneid", "celltransactionlimit"};
        String where = "WHERE zoneid=:zoneid";
        List<Object[]> celltransitObj = (List<Object[]>) genericClassService.fetchRecord(Zonebay.class, fields, where, params, paramsValues);
        if (celltransitObj != null) {
           if(celltransitObj.get(0)[1] == null  || Integer.parseInt(celltransitObj.get(0)[1].toString()) == 0){
             translimit = 0;
           }else{
               translimit +=Integer.parseInt(celltransitObj.get(0)[1].toString());
           }
            
        }
       
        return translimit;
    }

    public long Storagemechanismid(long zoneid) {
        long storemechid = 0;
        String[] params = {"zoneid"};
        Object[] paramsValues = {zoneid};
        String[] fields = {"zoneid.zoneid", "storagemechanismid.storagemechanismid"};
        String where = "WHERE zoneid=:zoneid";
        List<Object[]> celltransitObj = (List<Object[]>) genericClassService.fetchRecord(Zonebay.class, fields, where, params, paramsValues);
        if (celltransitObj != null) {
            storemechid = storemechid + Long.valueOf(celltransitObj.get(0)[1].toString());
        }
        return storemechid;
    }

    public String Staffname(BigInteger sid) {
        String names = "";
        String[] params = {"staffid"};
        Object[] paramsValues = {sid};
        String[] fields = {"staffid", "firstname", "lastname", "othernames"};
        String where = "WHERE staffid=:staffid";
        List<Object[]> staffObj = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields, where, params, paramsValues);
        if (staffObj != null) {
            if (staffObj.get(0)[3] != " ") {
                names = (String) staffObj.get(0)[2] + " " + (String) staffObj.get(0)[1] + " " + (String) staffObj.get(0)[3];
            } else {
                names = (String) staffObj.get(0)[2] + " " + (String) staffObj.get(0)[1];
            }
        }
        return names;
    }

    public Integer getLastRow(int zonebayid) {
        Integer lastRow = 0;
        String[] params = {"zonebayid"};
        Object[] paramsValues = {zonebayid};
        String[] fields = {"bayrowid", "rowlabel", "zonebayid.zonebayid"};
        String where = "WHERE zonebayid=:zonebayid ORDER BY bayrowid DESC LIMIT 1";
        List<Object[]> bayrowVObj = (List<Object[]>) genericClassService.fetchRecord(Bayrow.class, fields, where, params, paramsValues);
        if (bayrowVObj != null) {
            String str = bayrowVObj.get(0)[1].toString();
            String[] bits = str.split("-");
            String lastOne = bits[bits.length - 1];
            System.out.println(lastOne);
            lastRow = lastRow + Integer.parseInt(lastOne);
        } else {
            lastRow = lastRow + 0;
        }
        return lastRow;
    }

    /*public String getLastRowCell(int rowid) {
        String lastRowCell = "";
        String[] params = {"bayrowid"};
        Object[] paramsValues = {rowid};
        String[] fields = {"bayrowcellid", "celllabel", "bayrowid.bayrowid"};
        String where = "WHERE bayrowid=:bayrowid ORDER BY bayrowcellid DESC LIMIT 1";
        List<Object[]> bayrowcellVObj = (List<Object[]>) genericClassService.fetchRecord(Bayrowcell.class, fields, where, params, paramsValues);
        if (bayrowcellVObj != null) {
            String str = bayrowcellVObj.get(0)[1].toString();
            String[] bits = str.split("-");
            String lastOne = bits[bits.length - 1];
            lastRowCell = lastOne;
        } else {
            lastRowCell = "@";
        }
        return lastRowCell;
    }*/
    public int getLastRowCell(int rowid) {
        int lastRowCell = 0;
        String[] params = {"bayrowid"};
        Object[] paramsValues = {rowid};
        String[] fields = {"bayrowcellid", "celllabel", "bayrowid.bayrowid"};
        String where = "WHERE bayrowid=:bayrowid";
        List<Object[]> bayrowcellVObj = (List<Object[]>) genericClassService.fetchRecord(Bayrowcell.class, fields, where, params, paramsValues);
        if (bayrowcellVObj != null) {
            lastRowCell = bayrowcellVObj.size();
        }
        return lastRowCell;
    }

    @RequestMapping(value = "/savestaffbayrowcell")
    public @ResponseBody
    String savestaffbayrowcell(HttpServletRequest request, Model model, @ModelAttribute("selectedstaffbayrowcells") String staffcells) {
        String msg = "";
        try {
            ObjectMapper mapper = new ObjectMapper();
            List<Map> selectedTags = (ArrayList<Map>) mapper.readValue(staffcells, List.class);
            for (Map x : selectedTags) {
                BigInteger staffid = BigInteger.valueOf(Long.parseLong(String.valueOf(x.get("staffid"))));
                int selectedzoneid = Integer.parseInt(x.get("zoneid").toString());
                List<Integer> selectedStaffcells = (ArrayList<Integer>) mapper.readValue(x.get("staffcells").toString(), List.class);
                for (Integer p : selectedStaffcells) {
                    String staffActivity = "INITIAL";
                    Staffbayrowcell staffbayrowcellx = new Staffbayrowcell();
                    staffbayrowcellx.setStaffid(staffid);
                    staffbayrowcellx.setBayrowcellid(new Bayrowcell(p));
                    staffbayrowcellx.setStaffactivity(staffActivity);
                    staffbayrowcellx.setZoneid(new Zone(selectedzoneid));
                    Object saved = genericClassService.saveOrUpdateRecordLoadObject(staffbayrowcellx);
                    if (saved != null) {
                        msg = "success";
                    } else {
                        msg = "failure";
                    }
                }
            }
        } catch (IOException ex) {
            System.out.println(ex);
        }
        return msg;
    }

    @RequestMapping(value = "/saveorremovecellsfromstaff")
    public @ResponseBody
    String saveorremovecellsfromstaff(HttpServletRequest request, Model model, @ModelAttribute("add") String AssignCells, @ModelAttribute("remove") String DeassignCells, @ModelAttribute("zoneid") int selectedzoneid, @ModelAttribute("staffid") String selectedstaffid) {
        String msg = "";
        ObjectMapper mapper = new ObjectMapper();
        BigInteger staffid = BigInteger.valueOf(Long.parseLong(selectedstaffid));
        if (AssignCells != null) {
            try {
                List<String> selectedStaffcells = (ArrayList<String>) mapper.readValue(AssignCells, List.class);
                for (String p : selectedStaffcells) {
                    String staffActivity = "INITIAL";
                    Staffbayrowcell staffbayrowcellx = new Staffbayrowcell();
                    staffbayrowcellx.setStaffid(staffid);
                    staffbayrowcellx.setBayrowcellid(new Bayrowcell(Integer.valueOf(p)));
                    staffbayrowcellx.setStaffactivity(staffActivity);
                    staffbayrowcellx.setZoneid(new Zone(selectedzoneid));
                    Object saved = genericClassService.saveOrUpdateRecordLoadObject(staffbayrowcellx);
                    if (saved != null) {
                        msg = "success";
                    } else {
                        msg = "failure";
                    }
                }

            } catch (IOException ex) {
                System.out.println(ex);
            }
        }
        if (DeassignCells != null) {
            try {
                List<String> RemoveselectedStaffcells = (ArrayList<String>) mapper.readValue(DeassignCells, List.class);
                for (String v : RemoveselectedStaffcells) {
                    String[] columns = {"bayrowcellid", "staffid"};
                    Object[] columnValues = {Integer.valueOf(v), staffid};
                    Object result = genericClassService.deleteRecordByByColumns("store.staffbayrowcell", columns, columnValues);
                    if (result != null) {
                        msg = "success";
                    } else {
                        msg = "failure";
                    }
                }
            } catch (IOException ex) {
                System.out.println(ex);
            }
        }
        return msg;
    }

    @RequestMapping(value = "/addNewBays")
    public @ResponseBody
    String addNewBays(HttpServletRequest request, Model model, @ModelAttribute("cells") String selectedCell, @ModelAttribute("rows") String selectedRow, @ModelAttribute("bays") String selectedBay, @ModelAttribute("zoneid") int zoneid) {
        Zonebay creatingbay;
        Bayrow creatingrows;
        Bayrowcell creatingcells;
        ObjectMapper mapper = new ObjectMapper();
        String msg = "";
        List<Map> bayV;
        try {

            bayV = (ArrayList<Map>) new ObjectMapper().readValue(selectedBay, List.class);
            for (Map n : bayV) {
                creatingbay = new Zonebay();
                String baylabel = (String) n.get("baylabel");
                creatingbay.setBaylabel(baylabel);
                creatingbay.setZoneid(new Zone(zoneid));
                creatingbay.setStoragemechanismid(new Storagemechanism(Storagemechanismid(zoneid)));
                Object savedbay = genericClassService.saveOrUpdateRecordLoadObject(creatingbay);
                if (savedbay != null) {
                    int zonebayid = creatingbay.getZonebayid();
                    List<Map> rowV = (ArrayList<Map>) mapper.readValue(selectedRow, List.class);
                    for (Map k : rowV) {
                        // System.out.println("------------"+Integer.parseInt(n.get("id").toString())+ "==" +Integer.parseInt(k.get("bayid").toString()));
                        if (Integer.parseInt(n.get("id").toString()) == Integer.parseInt(k.get("bayid").toString())) {
                            creatingrows = new Bayrow();
                            String rowlabel = (String) k.get("BayrowtestArray");
                            creatingrows.setRowlabel(rowlabel);
                            creatingrows.setZonebayid(new Zonebay(zonebayid));
                            Object savedRow = genericClassService.saveOrUpdateRecordLoadObject(creatingrows);
                            if (savedRow != null) {
                                int bayrowid = creatingrows.getBayrowid();
                                List<Map> cellsV = (ArrayList<Map>) mapper.readValue(selectedCell, List.class);
                                for (Map h : cellsV) {
                                    if (Integer.parseInt(k.get("rowid").toString()) == Integer.parseInt(h.get("rowid").toString())) {
                                        creatingcells = new Bayrowcell();
                                        // System.out.println("--------------------------" + h.get("celllabel"));
                                        long num = 0;
                                        creatingcells.setCelllabel((String) h.get("celllabel"));
                                        creatingcells.setBayrowid(new Bayrow(bayrowid));
                                        creatingcells.setCellstate(false);
                                        creatingcells.setStoragetypeid(num);
                                        creatingcells.setIsolated(false);
                                        Object savedcell = genericClassService.saveOrUpdateRecordLoadObject(creatingcells);
                                        if (savedcell != null) {
                                            msg = "success";
                                        } else {
                                            msg = "Failed";
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } catch (IOException ex) {
            System.out.println(ex);
        }
        return msg;
    }

    @RequestMapping(value = "/addNewRows")
    public @ResponseBody
    String addNewRows(HttpServletRequest request, Model model, @ModelAttribute("cells") String selectedCell, @ModelAttribute("rows") String selectedRow, @ModelAttribute("bayid") int zonebayid) {
        String msg = "";
        try {
            Bayrow creatingrows;
            Bayrowcell creatingcells;
            ObjectMapper mapper = new ObjectMapper();
            List<Map> rowV = (ArrayList<Map>) mapper.readValue(selectedRow, List.class);
            for (Map k : rowV) {
                creatingrows = new Bayrow();
                String rowlabel = (String) k.get("BayrowtestArray");
                creatingrows.setRowlabel(rowlabel);
                creatingrows.setZonebayid(new Zonebay(zonebayid));
                Object savedRow = genericClassService.saveOrUpdateRecordLoadObject(creatingrows);
                if (savedRow != null) {
                    int bayrowid = creatingrows.getBayrowid();
                    List<Map> cellsV = (ArrayList<Map>) mapper.readValue(selectedCell, List.class);
                    for (Map h : cellsV) {
                        if (Integer.parseInt(k.get("rowid").toString()) == Integer.parseInt(h.get("rowid").toString())) {
                            creatingcells = new Bayrowcell();
                            // System.out.println("--------------------------" + h.get("celllabel"));
                            long num = 0;
                            creatingcells.setCelllabel((String) h.get("celllabel"));
                            creatingcells.setBayrowid(new Bayrow(bayrowid));
                            creatingcells.setCellstate(false);
                            creatingcells.setStoragetypeid(num);
                            creatingcells.setIsolated(false);
                            Object savedcell = genericClassService.saveOrUpdateRecordLoadObject(creatingcells);
                            if (savedcell != null) {
                                msg = "success";
                            } else {
                                msg = "Failed";
                            }
                        }
                    }
                }
            }

        } catch (IOException ex) {
            System.out.println(ex);
        }
        return msg;
    }

    @RequestMapping(value = "/addNewCells")
    public @ResponseBody
    String addNewCells(HttpServletRequest request, Model model, @ModelAttribute("rowidx") int selectedrowid, @ModelAttribute("cellNumbers") int cellnumbers, @ModelAttribute("rowlabeL") String selectedrowlabeL) {

        String msg = "";//()
        //System.out.println("--------1---------" + getLastRowCell(selectedrowid));
        //System.out.println("--------2---------" + generateLetter(getLastRowCell(selectedrowid)));
        int lastcellLabel = getLastRowCell(selectedrowid);
        int newTotalrow = lastcellLabel + cellnumbers;
        Bayrowcell creatingcells;
        for (int a = lastcellLabel; a < newTotalrow; a++) {
            //  System.out.println("****************1111******vvvvvv********" + selectedrowlabeL + "-" + generateLetter(a));           
            creatingcells = new Bayrowcell();
            String celllabel = selectedrowlabeL + "-" + generateLetter(a);
            long num = 0;
            creatingcells.setCelllabel(celllabel);
            creatingcells.setBayrowid(new Bayrow(selectedrowid));
            creatingcells.setCellstate(Boolean.FALSE);
            creatingcells.setStoragetypeid(num);
            creatingcells.setIsolated(false);
            Object savedcell = genericClassService.saveOrUpdateRecordLoadObject(creatingcells);
            if (savedcell != null) {
                msg = "success";
            } else {
                msg = "Failure";
            }
        }
        return msg;
    }

    @RequestMapping(value = "/addNewBaysAndRows")
    public @ResponseBody
    String addNewBaysAndRows(Model model, @ModelAttribute("rows") String selectedRows, @ModelAttribute("bays") String selectedBay, @ModelAttribute("zoneid") int zoneid, @ModelAttribute("cells") String selectedCells) {
        String msg = "";
        try {
            Zonebay creatingbay;
            Bayrow creatingrows;
            Bayrowcell creatingcells;
            ObjectMapper mapper = new ObjectMapper();
            List<Map> bayV = (ArrayList<Map>) mapper.readValue(selectedBay, List.class);
            for (Map n : bayV) {
                creatingbay = new Zonebay();
                String baylabel = (String) n.get("baylabel");
                creatingbay.setBaylabel(baylabel);
                creatingbay.setCelltransactionlimit(cellLimit(zoneid));
                creatingbay.setZoneid(new Zone(zoneid));
                creatingbay.setStoragemechanismid(new Storagemechanism(Storagemechanismid(zoneid)));
                Object savedbay = genericClassService.saveOrUpdateRecordLoadObject(creatingbay);
                if (savedbay != null) {
                    int zonebayid = creatingbay.getZonebayid();
                    List<Map> rowV = (ArrayList<Map>) mapper.readValue(selectedRows, List.class);
                    for (Map k : rowV) {
                        if (Integer.parseInt(n.get("id").toString()) == Integer.parseInt(k.get("bayid").toString())) {
                            creatingrows = new Bayrow();
                            String rowlabel = (String) k.get("BayrowtestArray");
                            creatingrows.setRowlabel(rowlabel);
                            creatingrows.setZonebayid(new Zonebay(zonebayid));
                            Object savedRow = genericClassService.saveOrUpdateRecordLoadObject(creatingrows);
                            if (savedRow != null) {
                                int bayrowid = creatingrows.getBayrowid();
                                List<Map> cellsV = (ArrayList<Map>) mapper.readValue(selectedCells, List.class);
                                for (Map h : cellsV) {
                                    if (Integer.parseInt(k.get("bayrowidxxx").toString()) == Integer.parseInt(h.get("rowid").toString())) {
                                        if (Integer.parseInt(k.get("rowidpos").toString()) == Integer.parseInt(h.get("rowidpos").toString())) {
                                            creatingcells = new Bayrowcell();
                                            long num = 0;
                                            creatingcells.setCelllabel((String) h.get("celllabel"));
                                            creatingcells.setBayrowid(new Bayrow(bayrowid));
                                            creatingcells.setCellstate(false);
                                            creatingcells.setStoragetypeid(num);
                                            creatingcells.setIsolated(false);
                                            Object CellcreatedObj = genericClassService.saveOrUpdateRecordLoadObject(creatingcells);
                                            if (CellcreatedObj != null) {
                                                msg = "success";
                                            } else {
                                                msg = "Failed";
                                            }

                                        }
                                    }
                                }
                            }
                        }
                    }

                }
            }
        } catch (IOException ex) {
            System.out.println(ex);
        }

        return msg;
    }

    @RequestMapping(value = "/addNewRowsAndCells")
    public @ResponseBody
    String addNewRowsAndCells(Model model, @ModelAttribute("rows") String selectedRows, @ModelAttribute("bays") String selectedBay, @ModelAttribute("zoneid") int zoneid) {
        String msg = "";
        try {
            Zonebay creatingbay;
            Bayrow creatingrows;
            ObjectMapper mapper = new ObjectMapper();
            List<Map> bayV = (ArrayList<Map>) mapper.readValue(selectedBay, List.class);
            for (Map n : bayV) {
                creatingbay = new Zonebay();
                String baylabel = (String) n.get("baylabel");
                creatingbay.setBaylabel(baylabel);
                creatingbay.setCelltransactionlimit(cellLimit(zoneid));
                creatingbay.setZoneid(new Zone(zoneid));
                creatingbay.setStoragemechanismid(new Storagemechanism(Storagemechanismid(zoneid)));
                Object savedbay = genericClassService.saveOrUpdateRecordLoadObject(creatingbay);
                if (savedbay != null) {
                    int zonebayid = creatingbay.getZonebayid();
                    List<Map> rowV = (ArrayList<Map>) mapper.readValue(selectedRows, List.class);
                    for (Map k : rowV) {
                        if (Integer.parseInt(n.get("id").toString()) == Integer.parseInt(k.get("bayid").toString())) {
                            creatingrows = new Bayrow();
                            String rowlabel = (String) k.get("BayrowtestArray");
                            creatingrows.setRowlabel(rowlabel);
                            creatingrows.setZonebayid(new Zonebay(zonebayid));
                            Object savedRow = genericClassService.saveOrUpdateRecordLoadObject(creatingrows);
                            if (savedRow != null) {
                                msg = "success";
                            } else {
                                msg = "Failed";
                            }
                        }
                    }

                }
            }
        } catch (IOException ex) {
            System.out.println(ex);
        }

        return msg;
    }

    @RequestMapping(value = "/addNewBaysRowsAndCells")
    public @ResponseBody
    String addNewBaysRowsAndCells(Model model, @ModelAttribute("cells") String selectedCells, @ModelAttribute("rows") String selectedRows, @ModelAttribute("bays") String selectedBay, @ModelAttribute("zoneid") int zoneid) {
        String msg = "";
        try {
            Zonebay creatingbay;
            Bayrow creatingrows;
            Bayrowcell creatingcells;
            ObjectMapper mapper = new ObjectMapper();
            List<Map> bayV = (ArrayList<Map>) mapper.readValue(selectedBay, List.class);
            for (Map n : bayV) {
                creatingbay = new Zonebay();
                String baylabel = (String) n.get("baylabel");
                creatingbay.setBaylabel(baylabel);
                creatingbay.setCelltransactionlimit(cellLimit(zoneid));
                creatingbay.setZoneid(new Zone(zoneid));
                creatingbay.setStoragemechanismid(new Storagemechanism(Storagemechanismid(zoneid)));
                Object savedbay = genericClassService.saveOrUpdateRecordLoadObject(creatingbay);
                if (savedbay != null) {
                    int zonebayid = creatingbay.getZonebayid();
                    List<Map> rowV = (ArrayList<Map>) mapper.readValue(selectedRows, List.class);
                    for (Map k : rowV) {
                        if (Integer.parseInt(n.get("id").toString()) == Integer.parseInt(k.get("bayid").toString())) {
                            creatingrows = new Bayrow();
                            String rowlabel = (String) k.get("BayrowtestArray");
                            creatingrows.setRowlabel(rowlabel);
                            creatingrows.setZonebayid(new Zonebay(zonebayid));
                            Object savedRow = genericClassService.saveOrUpdateRecordLoadObject(creatingrows);
                            if (savedRow != null) {
                                int bayrowid = creatingrows.getBayrowid();
                                List<Map> cellsV = (ArrayList<Map>) mapper.readValue(selectedCells, List.class);
                                for (Map h : cellsV) {
                                    if (Integer.parseInt(k.get("bayrowidxxx").toString()) == Integer.parseInt(h.get("rowid").toString())) {
                                        //System.out.println("============1111===================" + Integer.parseInt(k.get("rowidpos").toString()) + "==" + Integer.parseInt(h.get("rowidpos").toString()));
                                        if (Integer.parseInt(k.get("rowidpos").toString()) == Integer.parseInt(h.get("rowidpos").toString())) {
                                            // System.out.println("==========2222=====================" + k.get("rowidpos").toString() + "==" + h.get("rowidpos").toString());
                                            long num = 0;
                                            creatingcells = new Bayrowcell();
                                            creatingcells.setCelllabel((String) h.get("celllabel"));
                                            creatingcells.setBayrowid(new Bayrow(bayrowid));
                                            creatingcells.setCellstate(false);
                                            creatingcells.setStoragetypeid(num);
                                            creatingcells.setIsolated(false);
                                            Object savedCell = genericClassService.saveOrUpdateRecordLoadObject(creatingcells);
                                            if (savedCell != null) {
                                                msg = "success";
                                            } else {
                                                msg = "Failed";
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                }
            }
        } catch (IOException ex) {
            System.out.println(ex);
        }

        return msg;
    }

    @RequestMapping(value = "/addNewRowsCells")
    public @ResponseBody
    String addNewRowsCells(Model model, @ModelAttribute("cells") String selectedCells, @ModelAttribute("rows") String selectedRows, @ModelAttribute("zonebayid") int zonebayid) {
        String msg = "";
        try {
            Bayrow creatingrows;
            Bayrowcell creatingcells;
            ObjectMapper mapper = new ObjectMapper();
            List<Map> rowV = (ArrayList<Map>) mapper.readValue(selectedRows, List.class);
            for (Map k : rowV) {
                creatingrows = new Bayrow();
                String rowlabel = (String) k.get("BayrowtestArray");
                creatingrows.setRowlabel(rowlabel);
                creatingrows.setZonebayid(new Zonebay(zonebayid));
                Object savedRow = genericClassService.saveOrUpdateRecordLoadObject(creatingrows);
                if (savedRow != null) {
                    int bayrowid = creatingrows.getBayrowid();
                    List<Map> cellsV = (ArrayList<Map>) mapper.readValue(selectedCells, List.class);
                    for (Map h : cellsV) {
                        //System.out.println("===============================" + Integer.parseInt(k.get("rowidpos").toString()) + "==" + Integer.parseInt(h.get("rowidpos").toString()));
                        if (Integer.parseInt(k.get("rowidpos").toString()) == Integer.parseInt(h.get("rowidpos").toString())) {
                            creatingcells = new Bayrowcell();
                            // System.out.println("--------------------------" + h.get("celllabel"));
                            long num = 0;
                            creatingcells.setCelllabel((String) h.get("celllabel"));
                            creatingcells.setBayrowid(new Bayrow(bayrowid));
                            creatingcells.setCellstate(false);
                            creatingcells.setStoragetypeid(num);
                            creatingcells.setIsolated(false);
                            Object savedCell = genericClassService.saveOrUpdateRecordLoadObject(creatingcells);
                            if (savedCell != null) {
                                msg = "success";
                            } else {
                                msg = "Failed";
                            }
                        }

                    }
                }

            }
        } catch (IOException ex) {
            System.out.println(ex);
        }

        return msg;
    }

    @RequestMapping(value = "/updatezoneLabel")
    public @ResponseBody
    String updatezoneLabel(HttpServletRequest request, Model model, @ModelAttribute("zoneid") int zoneid, @ModelAttribute("zonelabel") String zoneName) {
        String msg = "";
        Set<Integer> contentExists = new HashSet<>();
        int qtysize = 0;
        String[] params = {"zoneid"};
        Object[] paramsValues = {zoneid};
        String[] fields = {"quantityshelved", "zonelabel"};
        String where = "WHERE zoneid=:zoneid AND quantityshelved > 0";
        List<Object[]> contObj = (List<Object[]>) genericClassService.fetchRecord(Cellitems.class, fields, where, params, paramsValues);
        if (contObj != null) {
            //it has items
            msg = "containsitems";
        } else {
            //it has no items
            String[] columnslev = {"zonelabel"};
            Object[] columnValueslev = {zoneName};
            String levelPrimaryKey = "zoneid";
            Object levelPkValue = zoneid;
            Object xObj = genericClassService.updateRecordSQLSchemaStyle(Zone.class, columnslev, columnValueslev, levelPrimaryKey, levelPkValue, "store");
            if (xObj != null) {
                msg = "success";
            } else {
                msg = "failed";
            }
        }
        return msg;
    }//

    @RequestMapping(value = "/deletezoneLabel")
    public @ResponseBody
    String deletezoneLabel(HttpServletRequest request, Model model, @ModelAttribute("zoneid") int zoneid) {
        String msg = "";
        Set<Integer> contentzonebayid = new HashSet<>();
        Set<Integer> contentbayrowid = new HashSet<>();
        Set<Integer> contentbayrowcellid = new HashSet<>();
        String[] params = {"zoneid"};
        Object[] paramsValues = {zoneid};
        String[] fields = {"quantityshelved", "zonelabel"};
        String where = "WHERE zoneid=:zoneid AND quantityshelved > 0";
        List<Object[]> contObj = (List<Object[]>) genericClassService.fetchRecord(Cellitems.class, fields, where, params, paramsValues);
        if (contObj != null) {
            //it has items
            msg = "containsitems";
        } else {
            //has no items
            String[] params2 = {"zoneid"};
            Object[] paramsValues2 = {zoneid};
            String[] fields2 = {"zonebayid", "bayrowid", "bayrowcellid"};
            String where2 = "WHERE zoneid=:zoneid";
            List<Object[]> zoneContentObj = (List<Object[]>) genericClassService.fetchRecord(Unitstoragezones.class, fields2, where2, params2, paramsValues2);
            if (zoneContentObj != null) {
                for (Object[] x : zoneContentObj) {
                    int bayid = Integer.parseInt(x[0].toString());
                    int rowid = Integer.parseInt(x[1].toString());
                    int cellid = Integer.parseInt(x[2].toString());
                    contentzonebayid.add(bayid);
                    contentbayrowid.add(rowid);
                    contentbayrowcellid.add(cellid);
                }
            }
            //System.out.println("--------------bays---------" + contentzonebayid);
            // System.out.println("-------------rows----------" + contentbayrowid);
            //System.out.println("-----------cells------------" + contentbayrowcellid);
            ObjectMapper mapper = new ObjectMapper();
            if (!contentbayrowcellid.isEmpty()) {
                List<Integer> bayrowcelldel;
                try {
                    bayrowcelldel = (ArrayList<Integer>) mapper.readValue(mapper.writeValueAsString(contentbayrowcellid), List.class);
                    for (Integer p : bayrowcelldel) {
                        String[] columns4 = {"bayrowcellid"};
                        Object[] columnValues4 = {p};
                        genericClassService.deleteRecordByByColumns("store.bayrowcell", columns4, columnValues4);
                    }
                } catch (JsonProcessingException ex) {
                    System.out.println(ex);
                } catch (IOException ex) {
                    System.out.println(ex);
                }
            }
            if (!contentbayrowid.isEmpty()) {
                List<Integer> bayrowdel;
                try {
                    bayrowdel = (ArrayList<Integer>) mapper.readValue(mapper.writeValueAsString(contentbayrowid), List.class);
                    for (Integer o : bayrowdel) {
                        String[] columns3 = {"bayrowid"};
                        Object[] columnValues3 = {o};
                        genericClassService.deleteRecordByByColumns("store.bayrow", columns3, columnValues3);
                    }
                } catch (JsonProcessingException ex) {
                    System.out.println(ex);
                } catch (IOException ex) {
                    System.out.println(ex);
                }

            }
            if (!contentzonebayid.isEmpty()) {
                List<Integer> zonebaydel;
                try {
                    zonebaydel = (ArrayList<Integer>) mapper.readValue(mapper.writeValueAsString(contentzonebayid), List.class);
                    for (Integer n : zonebaydel) {
                        String[] columns2 = {"zonebayid"};
                        Object[] columnValues2 = {n};
                        genericClassService.deleteRecordByByColumns("store.zonebay", columns2, columnValues2);
                    }
                } catch (JsonProcessingException ex) {
                    System.out.println(ex);
                } catch (IOException ex) {
                    System.out.println(ex);
                }

            }

            //final deleting of zone
            String[] columns5 = {"zoneid"};
            Object[] columnValues5 = {zoneid};
            Object zonedel = genericClassService.deleteRecordByByColumns("store.zone", columns5, columnValues5);
            if (zonedel != null) {
                msg = "success";
            } else {
                msg = "failed";
            }
        }
        return msg;
    }

    @RequestMapping(value = "/fetchzoneCellsfortreeview", method = RequestMethod.GET)
    public String fetchzoneCellsfortreeview(HttpServletRequest request, Model model, @ModelAttribute("selectedzoneid") int zoneid, @ModelAttribute("selectedzone") String zonex) {
        List<Map> ZoneList = new ArrayList<>();
        Map<String, Object> zoneMap = new HashMap();
        Map<String, Object> bayMap = null;
        Map<String, Object> rowMap = null;
        Map<String, Object> cellMap = null;
        int checktypedoruntyped = Integer.parseInt(storagetypeCountsALL(zoneid).split("-")[1]);
        if (checktypedoruntyped == 0) {
            zoneMap.put("zonelabel", zonex);
            zoneMap.put("cellsUnassignedType", storagetypeCountsALL(zoneid).split("-")[0]);
            String[] params6 = {"zoneid"};
            Object[] paramsValues6 = {zoneid};
            String[] fields6 = {"zonebayid", "baylabel", "zoneid.zoneid"};
            String where6 = "WHERE zoneid=:zoneid ";
            List<Object[]> bayObj = (List<Object[]>) genericClassService.fetchRecord(Zonebay.class, fields6, where6, params6, paramsValues6);
            List<Map> bayList = new ArrayList<>();
            if (bayObj != null) {
                zoneMap.put("baysize", bayObj.size());
                for (Object[] bay : bayObj) {
                    if (zoneid == Integer.parseInt(bay[2].toString())) {
                        bayMap = new HashMap();
                        bayMap.put("bayid", bay[0]);
                        bayMap.put("bayName", bay[1]);
                        bayMap.put("bayName2", bay[1].toString().split("-")[1]);
                        bayMap.put("zoneid", bay[2]);

                        String[] params7 = {"zonebayid"};
                        Object[] paramsValues7 = {bay[0]};
                        String[] fields7 = {"bayrowid", "rowlabel", "zonebayid.zonebayid"};
                        String where7 = "WHERE zonebayid=:zonebayid ";
                        List<Object[]> rowObj = (List<Object[]>) genericClassService.fetchRecord(Bayrow.class, fields7, where7, params7, paramsValues7);
                        List<Map> rowList = new ArrayList<>();
                        if (rowObj != null) {
                            bayMap.put("rowsize", rowObj.size());
                            for (Object[] row : rowObj) {
                                if (Integer.parseInt(bay[0].toString()) == Integer.parseInt(row[2].toString())) {
                                    rowMap = new HashMap();
                                    rowMap.put("rowid", row[0]);
                                    rowMap.put("rowlabel", row[1]);
                                    rowMap.put("rowlabel2", row[1].toString().split("-")[2]);
                                    rowMap.put("bayid", row[2]);
                                    //rowMap.put("baysize", rowsize);

                                    //cells
                                    String[] params8 = {"bayrowid"};
                                    Object[] paramsValues8 = {row[0]};
                                    String[] fields8 = {"bayrowcellid", "celllabel", "bayrowid.bayrowid"};
                                    String where8 = "WHERE bayrowid=:bayrowid";
                                    List<Object[]> cellObj = (List<Object[]>) genericClassService.fetchRecord(Bayrowcell.class, fields8, where8, params8, paramsValues8);
                                    List<Map> cellList = new ArrayList<>();
                                    if (cellObj != null) {
                                        rowMap.put("cellsize", cellObj.size());
                                        for (Object[] cell : cellObj) {
                                            if (Integer.parseInt(row[0].toString()) == Integer.parseInt(cell[2].toString())) {
                                                cellMap = new HashMap();
                                                cellMap.put("cellid", cell[0]);
                                                cellMap.put("cellLabel", cell[1]);
                                                cellMap.put("cellLabel2", cell[1].toString().split("-")[3]);
                                                cellMap.put("rowid", cell[2]);
                                                cellList.add(cellMap);
                                            }
                                        }
                                    }
                                    rowMap.put("cells", cellList);
                                    rowList.add(rowMap);
                                }
                            }
                        }
                        bayMap.put("rows", rowList);
                        bayList.add(bayMap);
                    }
                }

            }
            zoneMap.put("bays", bayList);
            zoneMap.put("status", "storageunTyped");
        } else {
            zoneMap.put("status", "storageTyped");
            zoneMap.put("cellsAssignedType", storagetypeCountsALL(zoneid).split("-")[1]);
            zoneMap.put("zonelabel", zonex);
            String[] params6 = {"zoneid"};
            Object[] paramsValues6 = {zoneid};
            String[] fields6 = {"zonebayid", "baylabel", "zoneid.zoneid"};
            String where6 = "WHERE zoneid=:zoneid ";
            List<Object[]> bayObj = (List<Object[]>) genericClassService.fetchRecord(Zonebay.class, fields6, where6, params6, paramsValues6);
            List<Map> bayList = new ArrayList<>();
            if (bayObj != null) {
                zoneMap.put("baysize", bayObj.size());
                for (Object[] bay : bayObj) {
                    if (zoneid == Integer.parseInt(bay[2].toString())) {
                        bayMap = new HashMap();
                        bayMap.put("bayid", bay[0]);
                        bayMap.put("bayName", bay[1]);
                        bayMap.put("bayName2", bay[1].toString().split("-")[1]);
                        bayMap.put("zoneid", bay[2]);

                        String[] params7 = {"zonebayid"};
                        Object[] paramsValues7 = {bay[0]};
                        String[] fields7 = {"bayrowid", "rowlabel", "zonebayid.zonebayid"};
                        String where7 = "WHERE zonebayid=:zonebayid ";
                        List<Object[]> rowObj = (List<Object[]>) genericClassService.fetchRecord(Bayrow.class, fields7, where7, params7, paramsValues7);
                        List<Map> rowList = new ArrayList<>();
                        if (rowObj != null) {
                            bayMap.put("rowsize", rowObj.size());
                            for (Object[] row : rowObj) {
                                if (Integer.parseInt(bay[0].toString()) == Integer.parseInt(row[2].toString())) {
                                    rowMap = new HashMap();
                                    rowMap.put("rowid", row[0]);
                                    rowMap.put("rowlabel", row[1]);
                                    rowMap.put("rowlabel2", row[1].toString().split("-")[2]);
                                    rowMap.put("bayid", row[2]);
                                    //rowMap.put("baysize", rowsize);

                                    //cells
                                    String[] params8 = {"bayrowid"};
                                    Object[] paramsValues8 = {row[0]};
                                    String[] fields8 = {"bayrowcellid", "celllabel", "bayrowid.bayrowid", "storagetypeid"};
                                    String where8 = "WHERE bayrowid=:bayrowid  ORDER BY bayrowcellid ASC";
                                    List<Object[]> cellObj = (List<Object[]>) genericClassService.fetchRecord(Bayrowcell.class, fields8, where8, params8, paramsValues8);
                                    List<Map> cellList = new ArrayList<>();
                                    if (cellObj != null) {
                                        rowMap.put("cellsize", cellObj.size());
                                        for (Object[] cell : cellObj) {
                                            if (Integer.parseInt(row[0].toString()) == Integer.parseInt(cell[2].toString())) {
                                                cellMap = new HashMap();
                                                cellMap.put("cellid", cell[0]);
                                                cellMap.put("cellLabel", cell[1]);
                                                cellMap.put("cellLabel2", cell[1].toString().split("-")[3]);
                                                cellMap.put("rowid", cell[2]);
                                                if (!storagetypeCountsALL(zoneid).split("-")[3].isEmpty() && storagetypeCountsALL(zoneid).split("-")[3].contains(cell[0].toString())) {
                                                    cellMap.put("assigned", true);
                                                    cellMap.put("storetype", cell[3]);
                                                } else {
                                                    cellMap.put("assigned", false);
                                                }
                                                cellList.add(cellMap);
                                            }
                                        }
                                    }
                                    rowMap.put("cells", cellList);
                                    rowList.add(rowMap);
                                }
                            }
                        }
                        bayMap.put("rows", rowList);
                        bayList.add(bayMap);
                    }
                }

            }
            zoneMap.put("bays", bayList);
        }
        ZoneList.add(zoneMap);
        model.addAttribute("Zonetree", zoneMap);
        model.addAttribute("ZoneTreedata", ZoneList);
        String jsonzonetree = "";
        try {
            jsonzonetree = new ObjectMapper().writeValueAsString(ZoneList);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }
        List<Map> spacetypelist = new ArrayList<>();
        Map<String, Object> spacetype;
        String[] params3 = {};
        Object[] paramsValues3 = {};
        String[] fields3 = {"storagetype", "storagetypename"};
        String where3 = "";
        List<Object[]> spacetypeObj = (List<Object[]>) genericClassService.fetchRecord(Storagetype.class, fields3, where3, params3, paramsValues3);
        if (spacetypeObj != null) {
            for (Object[] v : spacetypeObj) {
                spacetype = new HashMap();
                spacetype.put("stypeid", v[0]);
                spacetype.put("stypeName", v[1]);
                spacetypelist.add(spacetype);
            }
        }
        model.addAttribute("StorageTypex", spacetypelist);
        model.addAttribute("jsonzonetree", jsonzonetree);
        return "controlPanel/localSettingsPanel/unitStorageSpace/views/managestoragetypeview/managestoragetypeassignandDeassign";
    }

    @RequestMapping(value = "/saveselectedstoragetype")
    public @ResponseBody
    String saveselectedstoragetype(HttpServletRequest request, Model model, @ModelAttribute("add") String assignCellsStoragetypes) {
        String msg = "";
        ObjectMapper mapper = new ObjectMapper();
        if (assignCellsStoragetypes != null) {
            try {
                List<Map> selectedStoragetypecells = (ArrayList<Map>) mapper.readValue(assignCellsStoragetypes, List.class);
                for (Map x : selectedStoragetypecells) {
                    String assignedstoragetypeAll = String.valueOf(x.get("addStoragecontent"));
                    int cellid = Integer.parseInt(assignedstoragetypeAll.split(",")[1]);
                    long storagetypeid = Long.valueOf(assignedstoragetypeAll.split(",")[2]);
                    String trlimitx = x.get("transLimit").toString();
                    long trlimit = 0;
                    if (!"".equals(trlimitx)) {
                        trlimit = Long.parseLong(trlimitx);
                    }
                    String[] columnslev = {"storagetypeid", "celltranslimit"};
                    Object[] columnValueslev = {storagetypeid, trlimit};
                    String levelPrimaryKey = "bayrowcellid";
                    Object levelPkValue = cellid;
                    Object updatestoragetypelimit = genericClassService.updateRecordSQLSchemaStyle(Bayrowcell.class, columnslev, columnValueslev, levelPrimaryKey, levelPkValue, "store");
                    if (updatestoragetypelimit != null) {
                        msg = "success";
                    } else {
                        msg = "fail";
                    }
                }
            } catch (IOException ex) {
                System.out.println(ex);
            }
        }
        return msg;
    }

    @RequestMapping(value = "/addorremovestoragetype")
    public @ResponseBody
    String addorremovestoragetype(HttpServletRequest request, Model model, @ModelAttribute("addstoragetype") String addstoragetyp, @ModelAttribute("removestoragetype") String removestoragetyp) {
        String msg = "";
        ObjectMapper mapper = new ObjectMapper();
        if (addstoragetyp != null) {
            try {
                List<Map> selectedaddStoragetypecells = (ArrayList<Map>) mapper.readValue(addstoragetyp, List.class);
                for (Map x : selectedaddStoragetypecells) {
                    String assignedstoragetypeAll = String.valueOf(x.get("addStoragetypecontent"));
                    int cellid = Integer.parseInt(assignedstoragetypeAll.split(",")[1]);
                    long storagetypeid = Long.valueOf(assignedstoragetypeAll.split(",")[2]);
                    String trlimitx = x.get("transLimit").toString();
                    long trlimit = 0;
                    if (!"".equals(trlimitx)) {
                        trlimit = Long.parseLong(trlimitx);
                    }
                    String[] columnslev = {"storagetypeid", "celltranslimit"};
                    Object[] columnValueslev = {storagetypeid, trlimit};
                    String levelPrimaryKey = "bayrowcellid";
                    Object levelPkValue = cellid;
                    Object updateaddstoragetypelimit = genericClassService.updateRecordSQLSchemaStyle(Bayrowcell.class, columnslev, columnValueslev, levelPrimaryKey, levelPkValue, "store");
                    if (updateaddstoragetypelimit != null) {
                        msg = "success";
                    } else {
                        msg = "fail";
                    }
                }
            } catch (IOException ex) {
                System.out.println(ex);
            }
        }

        if (removestoragetyp != null) {
            try {
                List<String> selectedremoveStoragetypecells = (ArrayList<String>) mapper.readValue(removestoragetyp, List.class);
                for (String x : selectedremoveStoragetypecells) {
                    int cellidx = Integer.parseInt(x);
                    String[] columnslev = {"storagetypeid", "celltranslimit"};
                    Object[] columnValueslev = {0, 0};
                    String levelPrimaryKey = "bayrowcellid";
                    Object levelPkValue = cellidx;
                    Object updateremovestoragetypelimit = genericClassService.updateRecordSQLSchemaStyle(Bayrowcell.class, columnslev, columnValueslev, levelPrimaryKey, levelPkValue, "store");
                    if (updateremovestoragetypelimit != null) {
                        msg = "success";
                    } else {
                        msg = "fail";
                    }
                }
            } catch (IOException ex) {
                System.out.println(ex);
            }
        }
        return msg;
    }

    @RequestMapping(value = "/printzoneTagsALL")
    public @ResponseBody
    String printzoneTagsALL(HttpServletRequest request, Model model, @ModelAttribute("Tags") String selectedtags, @ModelAttribute("zonetitle") String zoneName) {
        ObjectMapper mapper = new ObjectMapper();
        String status = "";
        Document doc = new Document();
        PdfWriter docWriter = null;
        Font bfBold12 = new Font(Font.FontFamily.TIMES_ROMAN, 75, Font.BOLD, new BaseColor(0, 0, 0));
        Font bfBold12x = new Font(Font.FontFamily.TIMES_ROMAN, 20, Font.BOLD, new BaseColor(0, 0, 0));
        try {
            //doc.setPageSize(PageSize.A4.rotate());
            doc.setPageSize(PageSize.A4);
            docWriter = PdfWriter.getInstance(doc, new FileOutputStream(createMyDirectory(zoneName) + zoneName + "-Cells.pdf"));
            doc.open();
            List<String> cellsTags = (ArrayList<String>) mapper.readValue(selectedtags, List.class);
            for (String cell : cellsTags) {
                Paragraph celltitle = new Paragraph(zoneName, bfBold12x);
                celltitle.setAlignment(Element.ALIGN_CENTER);
                celltitle.setSpacingAfter(-55f);
                doc.add(celltitle);
                String cellprintLabel = cell.split("-")[1] + "-" + cell.split("-")[2] + "-" + cell.split("-")[3];
                Paragraph cellname = new Paragraph(cellprintLabel, bfBold12);
                cellname.setAlignment(Element.ALIGN_CENTER);
                cellname.setSpacingAfter(-75f);
                doc.add(cellname);
                doc.add(new Chunk(Chunk.NEWLINE));
                //doc.newPage();
            }
            doc.close();
        } catch (IOException e) {
            System.out.println(e);
        } catch (DocumentException ex) {
            System.out.println(ex);
        }

        File selectedpdfFile = new File(createMyDirectory(zoneName) + zoneName + "-Cells.pdf");
        if (selectedpdfFile.exists()) {

            try {
               /* if (Desktop.isDesktopSupported()) {
                    Desktop.getDesktop().open(selectedpdfFile);
                    } else {
                    System.out.println("Desktop is not supported!");
                    }*/
                status = Base64.getEncoder().encodeToString(loadFileAsBytesArray(createMyDirectory(zoneName) + zoneName + "-Cells.pdf"));

            } catch (Exception ex) {
                System.out.println(ex);
            }
            if (selectedpdfFile.delete()) {
                System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~File deleted successfully");
            } else {
                System.out.println("~~~~~~~~~~~~~~~~~~~Failed to delete the file");
            }
        } else {
            System.out.println("File is not exists!");
        }
        System.out.println("Done");

        return status;
    }

    @RequestMapping(value = "/printselectedcellLabels")
    public @ResponseBody
    String printselectedcellLabels(HttpServletRequest request, Model model, @ModelAttribute("Tags") String selectedtags, @ModelAttribute("zonetitle") String zoneName) {
        ObjectMapper mapper = new ObjectMapper();
        Document doc = new Document();
        PdfWriter docWriter = null;
        Font bfBold12 = new Font(Font.FontFamily.TIMES_ROMAN, 75, Font.BOLD, new BaseColor(0, 0, 0));
        Font bfBold12x = new Font(Font.FontFamily.TIMES_ROMAN, 20, Font.BOLD, new BaseColor(0, 0, 0));
        try {
            //doc.setPageSize(PageSize.A4.rotate());
            doc.setPageSize(PageSize.A4);
            docWriter = PdfWriter.getInstance(doc, new FileOutputStream(createMyDirectory(zoneName) + "UserselectedCells.pdf"));
            doc.open();
            List<Map> cellsTags = (ArrayList<Map>) mapper.readValue(selectedtags, List.class);
            for (Map cell : cellsTags) {
                Paragraph celltitle = new Paragraph(cellsTags.get(0).get("celllabel").toString().split("-")[0], bfBold12x);
                celltitle.setAlignment(Element.ALIGN_CENTER);
                celltitle.setSpacingAfter(-55f);
                doc.add(celltitle);
                String cellprintLabel = cell.get("celllabel").toString().split("-")[1] + "-" + cell.get("celllabel").toString().split("-")[2] + "-" + cell.get("celllabel").toString().split("-")[3];
                Paragraph cellname = new Paragraph(cellprintLabel, bfBold12);
                cellname.setAlignment(Element.ALIGN_CENTER);
                cellname.setSpacingAfter(-75f);
                doc.add(cellname);
                doc.add(new Chunk(Chunk.NEWLINE));
                //doc.newPage();
            }
            doc.close();
        } catch (IOException e) {
            System.out.println(e);
        } catch (DocumentException ex) {
            System.out.println(ex);
        }
        String state = "";
        File selectedpdfFile = new File(createMyDirectory(zoneName) + "UserselectedCells.pdf");
        if (selectedpdfFile.exists()) {

            try {
                // if (Desktop.isDesktopSupported()) {
                // Desktop.getDesktop().open(selectedpdfFile);
                // Desktop.getDesktop().browse(java.net.URI.create(createMyDirectory(zoneName) + zoneName + "-UserselectedCells.pdf"));
                //} else {
                // System.out.println("Desktop is not supported!");
                // }
                // state = createMyDirectory(zoneName) + zoneName + "-UserselectedCells.pdf";
                state = Base64.getEncoder().encodeToString(loadFileAsBytesArray(createMyDirectory(zoneName) + "UserselectedCells.pdf"));
            } catch (Exception ex) {
                System.out.println(ex);
            }
            if (selectedpdfFile.delete()) {
                System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~File deleted successfully");
            } else {
                System.out.println("~~~~~~~~~~~~~~~~~~~Failed to delete the file");
            }
        } else {
            System.out.println("~~~~~~~~~~~~~File is not exists!");
        }
        System.out.println("Done");
        return state;
    }

    @RequestMapping(value = "/printingzonecellLabels", method = RequestMethod.GET)
    public String printingzonecellLabels(HttpServletRequest request, Model model) {
        ObjectMapper mapper = new ObjectMapper();
        String status = "";
        manageshelvingtab(request, model);
        return "controlPanel/localSettingsPanel/unitStorageSpace/views/printlabelz";
    }

    public Integer countBayRows(int bayid) {
        int rowsizecount = 0;
        String[] params = {"zonebayid"};
        Object[] paramsValues = {bayid};
        String[] fields = {"bayrowid", "rowlabel"};
        String where = "WHERE zonebayid=:zonebayid";
        List<Object[]> rowObj = (List<Object[]>) genericClassService.fetchRecord(Bayrow.class, fields, where, params, paramsValues);
        if (rowObj != null) {
            rowsizecount = +rowObj.size();
        }
        return rowsizecount;
    }

    public String createMyDirectory(String dir) {
        String subdirectory = "";
        switch (OsCheck.getOperatingSystemType().toString()) {
            case "Windows":
                if (!(new File("C:\\Pharmacy\\documents\\" + dir + "\\")).exists()) {
                    (new File("C:\\Pharmacy\\documents\\" + dir + "\\")).mkdirs();
                    subdirectory = "C:\\Pharmacy\\documents\\" + dir + "\\";
                } else {
                    subdirectory = "C:\\Pharmacy\\documents\\" + dir + "\\";
                }
                break;
            case "Linux":
                if (!(new File("/home/Pharmacy/documents/" + dir + "/")).exists()) {
                    (new File("/home/Pharmacy/documents/" + dir + "/")).mkdirs();
                    subdirectory = "/home/Pharmacy/documents/" + dir + "/";
                } else {
                    subdirectory = "/home/Pharmacy/documents/" + dir + "/";
                }
                break;
            case "MacOS":
                if (!(new File("/Users/Pharmacy/documents/" + dir + "/")).exists()) {
                    (new File("/Users/Pharmacy/documents/" + dir + "/")).mkdirs();
                    subdirectory = "/Users/Pharmacy/documents/" + dir + "/";
                } else {
                    subdirectory = "/Users/Pharmacy/documents/" + dir + "/";
                }
                break;
            default:
                break;
        }
        return subdirectory;
    }

    public String storagetypeCountsALL(int zoneid) {
        Set<Integer> storagetyped = new HashSet<>();
        Set<Integer> unstoragetype = new HashSet<>();
        String[] params = {"zoneid"};
        Object[] paramsValues = {zoneid};
        String[] fields = {"bayrowcellid", "zoneid", "storagetypeid"};
        String where = "WHERE zoneid=:zoneid";
        List<Object[]> bayrowcellidObj = (List<Object[]>) genericClassService.fetchRecord(Unitstoragezones.class, fields, where, params, paramsValues);
        if (bayrowcellidObj != null) {
            for (Object[] x : bayrowcellidObj) {
                if (Integer.parseInt(x[2].toString()) == 0) {
                    unstoragetype.add(Integer.parseInt(x[0].toString()));
                } else {
                    storagetyped.add(Integer.parseInt(x[0].toString()));
                }
            }
        }

        String storagetypeCountsRes = unstoragetype.size() + "-" + storagetyped.size() + "-" + unstoragetype + "-" + storagetyped;
        //System.out.println("--------------------------------------*****************"+storagetypeCountsRes);
        return storagetypeCountsRes;
    }

    @RequestMapping(value = "/fetchstoragelistTypedorUntyped")
    public @ResponseBody
    String fetchstoragelistTypedorUntyped(HttpServletRequest request, Model model, @ModelAttribute("zoneid") int zoneid, @ModelAttribute("type") int typex) {
        List<Map> unstoragetypeList = new ArrayList<>();
        List<Map> storagetypedList = new ArrayList<>();
        Map<String, Object> storagetypedMap;
        Map<String, Object> unstoragetypeMap;
        String[] params = {"zoneid"};
        Object[] paramsValues = {zoneid};
        String[] fields = {"bayrowcellid", "zoneid", "storagetypeid", "celllabel"};
        String where = "WHERE zoneid=:zoneid";
        List<Object[]> bayrowcellidObj = (List<Object[]>) genericClassService.fetchRecord(Unitstoragezones.class, fields, where, params, paramsValues);
        if (bayrowcellidObj != null) {
            for (Object[] x : bayrowcellidObj) {
                if (Integer.parseInt(x[2].toString()) == 0) {
                    unstoragetypeMap = new HashMap();
                    unstoragetypeMap.put("cell", x[3]);
                    unstoragetypeMap.put("stypeName", storageTypeFetch(BigInteger.valueOf(Long.parseLong(x[2].toString()))));
                    unstoragetypeList.add(unstoragetypeMap);
                } else {
                    storagetypedMap = new HashMap();
                    storagetypedMap.put("cell", x[3]);
                    storagetypedMap.put("stypeName", storageTypeFetch(BigInteger.valueOf(Long.parseLong(x[2].toString()))));
                    storagetypedList.add(storagetypedMap);
                }
            }
        }
        String JsonStorageTypedorUntyped = "";
        if (typex == 1) {
            try {
                JsonStorageTypedorUntyped = new ObjectMapper().writeValueAsString(storagetypedList);
            } catch (JsonProcessingException ex) {
                System.out.println(ex);
            }
        } else if (typex == 2) {
            try {
                JsonStorageTypedorUntyped = new ObjectMapper().writeValueAsString(unstoragetypeList);
            } catch (JsonProcessingException ex) {
                System.out.println(ex);
            }
        }

        return JsonStorageTypedorUntyped;
    }

    /*@RequestMapping(value = "/getcellstolockwithLimit")
    public @ResponseBody
    String getcellstolockwithLimit(HttpServletRequest request, Model model) {
        SimpleDateFormat formatterx = new SimpleDateFormat("yyyy-MM-dd");
        List<Map> typeCellObjList = new ArrayList<>();
        Map<String, Object> typeCellObjMap;
        Set<Integer> cells2lock = new HashSet<>();
        String[] params = {"out", "tra"};
        Object[] paramsValues = {"OUT", "TRA"};
        String[] fields = {"r.cellid.bayrowcellid", "count(r.cellid.bayrowcellid)"};
        String where = "WHERE (CAST(datelogged AS DATE)=DATE 'now') AND (logtype=:out OR logtype=:tra) GROUP BY r.cellid.bayrowcellid";
        List<Object[]> typeCellObj = (List<Object[]>) genericClassService.fetchRecordFunction(Shelflog.class, fields, where, params, paramsValues, 0, 0);
        if (typeCellObj != null) {
            for (Object[] n : typeCellObj) {
                typeCellObjMap = new HashMap();
                typeCellObjMap.put("cellid", n[0]);
                typeCellObjMap.put("transCount", n[1]);
                typeCellObjList.add(typeCellObjMap);
            }
        }
        String msg = "";
        BigInteger facUnitid = null;
        if (!typeCellObjList.isEmpty()) {
            for (Map x : typeCellObjList) {
                int cellID = Integer.parseInt(x.get("cellid").toString());
                int itemcount = Integer.parseInt(x.get("transCount").toString());
                String[] params3 = {"bayrowcellid", "cellstate"};
                Object[] paramsValues3 = {cellID, Boolean.FALSE};
                String[] fields3 = {"bayrowcellid", "celllabel", "celltranslimit", "cellstate", "facilityunitid"};
                String where3 = "WHERE bayrowcellid=:bayrowcellid AND cellstate=:cellstate ";
                List<Object[]> spacetypeObj = (List<Object[]>) genericClassService.fetchRecord(Unitstoragezones.class, fields3, where3, params3, paramsValues3);
                if (spacetypeObj != null) {
                    for (Object[] n : spacetypeObj) {
                        System.out.println("~~~~~~~~~~~~" + n[0] + "~~~~~~~~~~~~~" + n[1] + "~~~~~~~~~~~" + n[2] + "~~~~~~~" + n[3] + "~~~~~~" + n[4]);
                        int celltrLmt = Integer.parseInt(n[2].toString());
                        if (itemcount >= celltrLmt) {
                            facUnitid = BigInteger.valueOf(Long.parseLong(n[4].toString()));
                            if (!cells2lock.contains((int) n[0])) {
                                cells2lock.add((int) n[0]);
                            }
                            String[] columnslev = {"cellstate"};
                            Object[] columnValueslev = {Boolean.TRUE};
                            String levelPrimaryKey = "bayrowcellid";
                            Object levelPkValue = cellID;
                            genericClassService.updateRecordSQLSchemaStyle(Bayrowcell.class, columnslev, columnValueslev, levelPrimaryKey, levelPkValue, "store");

                        }
                    }
                }
            }
        }

        if (!cells2lock.isEmpty() && facUnitid != null) {
            System.out.println("~~~~~~~~~~~~SET DATA~~~~~~~~~~~~~" + cells2lock);
            System.out.println("~~~~~~~~~~~~FAC ID~~~~~~~~~~~~~" + facUnitid);
            try {
                Stockactivity stockactive = new Stockactivity();
                String activeName = "AUTO-[" + formatterx.format(new Date()) + "]";
                stockactive.setActivityname(activeName);

                String start = formatterx.format(new Date());
                String end = formatterx.format(new Date());

                Calendar cal_Start = Calendar.getInstance();
                cal_Start.setTime(formatterx.parse(start));
                cal_Start.add(Calendar.DATE, 1);
                start = formatterx.format(cal_Start.getTime());

                Calendar cal_End = Calendar.getInstance();
                cal_End.setTime(formatterx.parse(end));
                cal_End.add(Calendar.DATE, 1);
                end = formatterx.format(cal_End.getTime());

                String today = formatterx.format(new Date());
                stockactive.setStartdate(formatterx.parse(start));
                stockactive.setEnddate(formatterx.parse(end));
                stockactive.setDateadded(formatterx.parse(today));
                stockactive.setFacilityunitid(facUnitid);
                Object saved = genericClassService.saveOrUpdateRecordLoadObject(stockactive);
                if (saved != null) {
                    long stockactiveID = stockactive.getStockactivityid();
                    String today2 = formatterx.format(new Date());
                    for (Integer x : cells2lock) {
                        Activitycell savelockedcells = new Activitycell();
                        savelockedcells.setCellid(new Bayrowcell(x));
                        savelockedcells.setDateadded(formatterx.parse(today2));
                        savelockedcells.setStockactivityid(new Stockactivity(stockactiveID));
                        genericClassService.saveOrUpdateRecordLoadObject(savelockedcells);
                    }
                }
            } catch (ParseException ex) {
                System.out.println(ex);
            }
        }
        return msg;
    }*/
    public String storageTypeFetch(BigInteger id) {
        String storagetype = "";
        String[] params3 = {"storagetype"};
        Object[] paramsValues3 = {id};
        String[] fields3 = {"storagetype", "storagetypename"};
        String where3 = "WHERE storagetype=:storagetype";
        List<Object[]> spacetypeObj = (List<Object[]>) genericClassService.fetchRecord(Storagetype.class, fields3, where3, params3, paramsValues3);
        if (spacetypeObj != null) {
            for (Object[] n : spacetypeObj) {
                storagetype = (String) n[1];
            }
        }
        return storagetype;
    }

    /*public int storageTypecount(BigInteger id) {
        int count = 0;
        String[] params3 = {"storagetypeid"};
        Object[] paramsValues3 = {id};
        String[] fields3 = {"storagetypeid", "celllabel"};
        String where3 = "WHERE storagetypeid=:storagetypeid";
        List<Object[]> spacetypeObj = (List<Object[]>) genericClassService.fetchRecord(Bayrowcell.class, fields3, where3, params3, paramsValues3);
        if (spacetypeObj != null) {
            count += spacetypeObj.size();
        }
        return count;
    }*/
    public Object[] storageTypecount(BigInteger id) {
        List<Map> storagetypedObjList = new ArrayList<>();
        Map<String, Object> storagetypedObjMap;
        int count = 0;
        String[] params3 = {"storagetypeid"};
        Object[] paramsValues3 = {id};
        String[] fields3 = {"storagetypeid", "celllabel"};
        String where3 = "WHERE storagetypeid=:storagetypeid";
        List<Object[]> spacetypeObj = (List<Object[]>) genericClassService.fetchRecord(Bayrowcell.class, fields3, where3, params3, paramsValues3);
        if (spacetypeObj != null) {
            count += spacetypeObj.size();
            for (Object[] x : spacetypeObj) {
                storagetypedObjMap = new HashMap();
                storagetypedObjMap.put("cellLabelx", x[1]);
                storagetypedObjList.add(storagetypedObjMap);
            }
        }
        return new Object[]{count, storagetypedObjList};
    }

    public String generateLetter(int i) {
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
}
