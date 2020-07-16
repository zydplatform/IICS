/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.assetsmanager.Blockfloor;
import com.iics.assetsmanager.Blockroom;
import com.iics.assetsmanager.Building;
import com.iics.assetsmanager.Facilityblock;
import com.iics.assetsmanager.Facilitylocations;
import com.iics.assetsmanager.Facilityunitroom;
import com.iics.assetsmanager.Facilityunitroomservice;
import com.iics.domain.Facilityservices;
import com.iics.domain.Facilityunitservice;
import com.iics.service.GenericClassService;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author user
 */
@Controller
@RequestMapping("/serviceallocation")
public class Serviceallocations {

    @Autowired
    GenericClassService genericClassService;
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat formatter2 = new SimpleDateFormat("dd-MM-yyyy");

    @RequestMapping(value = "/servicelocationmenu", method = RequestMethod.GET)
    public String servicelocationmenu(HttpServletRequest request, Model model) {
        List<Map> unitservices = new ArrayList<>();
        List<Map> unitservices2 = new ArrayList<>();
        Set<Long> assignedserviceIDs = new HashSet<>();
        Set<Long> assignedfacroomID = new HashSet<>();

        String[] paramsx = {};
        Object[] paramsValuex = {};
        String[] fieldx = {"facilityunitservice"};
        String wherex = "";
        List<Long> foundObJ = (List<Long>) genericClassService.fetchRecord(Facilityunitroomservice.class, fieldx, wherex, paramsx, paramsValuex);
        if (foundObJ != null) {
            for (Long k : foundObJ) {
                if (assignedfacroomID.contains(k)) {
                } else {
                    assignedfacroomID.add(k);
                }
            }
        }
        Map<String, Object> printservicelocations;
        Map<String, Object> printservicelocations2;
        if (!assignedfacroomID.isEmpty()) {
            for (Long z : assignedfacroomID) {
                String[] params = {"facilityunitserviceid"};
                Object[] paramsValues = {z};
                String[] fields = {"facilityservices.serviceid", "facilityunitserviceid"};
                String where = "WHERE facilityunitserviceid=:facilityunitserviceid";
                List<Object[]> found = (List<Object[]>) genericClassService.fetchRecord(Facilityunitservice.class, fields, where, params, paramsValues);
                if (found != null) {
                    for (Object[] serviceid : found) {
                        String[] paramsname = {"serviceid"};
                        Object[] paramsValuename = {(Integer) serviceid[0]};
                        String[] fieldname = {"servicename"};
                        String wherename = "WHERE serviceid=:serviceid";
                        List<String> foundname = (List<String>) genericClassService.fetchRecord(Facilityservices.class, fieldname, wherename, paramsname, paramsValuename);
                        if (foundname != null) {
                            for (String m : foundname) {
                                printservicelocations = new HashMap<>();
                                printservicelocations.put("servicename", m);
                                printservicelocations.put("FacserviceID", serviceid[1].toString());
                                unitservices.add(printservicelocations);
                            }

                        }
                        Long facservid = Long.parseLong(serviceid[1].toString());
                        if (assignedserviceIDs.contains(facservid)) {
                        } else {
                            assignedserviceIDs.add(facservid);
                        }
                    }
                }
            }
        }
        if (!assignedserviceIDs.isEmpty()) {
            for (Long x : assignedserviceIDs) {
                String[] paramsa = {"facilityunitserviceid"};
                Object[] paramsValuea = {x};
                String[] fielda = {"facilityunitroomid"};
                String wherea = "WHERE facilityunitservice=:facilityunitserviceid";
                List<Integer> founda = (List<Integer>) genericClassService.fetchRecord(Facilityunitroomservice.class, fielda, wherea, paramsa, paramsValuea);
                if (founda != null) {
                    for (Integer reqn : founda) {
                        String[] paramsb = {"facilityunitroomid"};
                        Object[] paramsValueb = {reqn};
                        String[] fieldb = {"buildingname", "blockname", "floorname", "roomname"};
                        String whereb = "WHERE facilityunitroomid=:facilityunitroomid";
                        List<Object[]> foundb = (List<Object[]>) genericClassService.fetchRecord(Facilitylocations.class, fieldb, whereb, paramsb, paramsValueb);
                        if (foundb != null) {
                            for (Object[] req : foundb) {
                                printservicelocations2 = new HashMap<>();
                                printservicelocations2.put("facunitsrvid", x);
                                printservicelocations2.put("buildingname", (String) req[0]);
                                printservicelocations2.put("blockname", (String) req[1]);
                                printservicelocations2.put("floorname", (String) req[2]);
                                printservicelocations2.put("roomname", (String) req[3]);
                                unitservices2.add(printservicelocations2);
                            }
                        }
                    }
                }
            }
        }
        model.addAttribute("unitservices", unitservices);
        model.addAttribute("unitservices2", unitservices2);
        return "controlPanel/localSettingsPanel/Serviceallocation/serviceallocationmenu";
    }

    @RequestMapping(value = "/assignedservices", method = RequestMethod.POST)
    public String assignedservices(Model model) {

        return "controlPanel/localSettingsPanel/Serviceallocation/views/assignedservices";
    }

    @RequestMapping(value = "/unassignedservices", method = RequestMethod.GET)
    public String unassignedservices(Model model, @ModelAttribute("facilityunitserviceid") int facilityunitserviceid, @ModelAttribute("serviceid") int serviceid) {
        List<Map> blockroomlist = new ArrayList<>();
        Set<String> assignedbuildingname = new HashSet<>();
        String[] params = {"UNASSIGNED"};
        Object[] paramsValues = {"UNASSIGNED"};
        String[] fields = {"buildingid", "buildingname", "facilityid", "facilityblockid", "blockname", "blockfloorid", "floorname", "blockroomid", "roomname", "facilityunitroomid", "roomstatus"};
        String where = "WHERE roomstatus=:UNASSIGNED";
        List<Object[]> found = (List<Object[]>) genericClassService.fetchRecord(Facilitylocations.class, fields, where, params, paramsValues);
        Map<String, Object> unassignedservice;
        if (found != null) {
            for (Object[] req : found) {
                unassignedservice = new HashMap<>();
                unassignedservice.put("buildingid", (Integer) req[0]);
                String buildName = req[1].toString();
                if (assignedbuildingname.contains(buildName)) {
                } else {
                    assignedbuildingname.add(buildName);
                    unassignedservice.put("buildingname", buildName);
                }
                unassignedservice.put("facilityblockid", (Integer) req[3]);
                unassignedservice.put("blockname", (String) req[4]);
                unassignedservice.put("blockfloorid", (Integer) req[5]);
                unassignedservice.put("floorname", (String) req[6]);
                unassignedservice.put("blockroomid", (Integer) req[7]);
                unassignedservice.put("roomname", (String) req[8]);
                unassignedservice.put("facilityunitroomid", (Integer) req[9]);

                String[] paramsroom = {"facilityunitroomid"};
                Object[] paramsValuesroom = {(Integer) req[9]};
                String[] fieldsroom = {"facilityunitservice", "facilityunitroomserviceid"};
                String whereroom = "WHERE facilityunitroomid=:facilityunitroomid";
                List<Object[]> foundroom = (List<Object[]>) genericClassService.fetchRecord(Facilityunitroomservice.class, fieldsroom, whereroom, paramsroom, paramsValuesroom);
                if (foundroom != null) {
                    unassignedservice.put("facilityunitroomserviceid", (Integer) foundroom.get(0)[1]);
                    String[] paramsservice = {"facilityunitservice", "serviceid"};
                    Object[] paramsValuesservice = {(long) foundroom.get(0)[0], serviceid};
                    String[] fieldsservice = {"facilityunitserviceid"};
                    String whereservice = "WHERE facilityunitserviceid=:facilityunitservice AND serviceid=:serviceid";
                    List<Long> foundservice = (List<Long>) genericClassService.fetchRecord(Facilityunitservice.class, fieldsservice, whereservice, paramsservice, paramsValuesservice);
                    if (foundservice != null) {
                        unassignedservice.put("facilityunitserviceid", foundservice.get(0));
                    }
                }
                unassignedservice.put("roomstatus", (String) req[10]);
                blockroomlist.add(unassignedservice);
            }
        }
        String jsonsunassignedroomlist = "";
        try {
            jsonsunassignedroomlist = new ObjectMapper().writeValueAsString(blockroomlist);

        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }
        List<Map> buildings = new ArrayList<>();
        String[] params1 = {};
        Object[] paramsValues1 = {};
        String[] fields1 = {"buildingname", "buildingid"};
        String where1 = "";
        List<Object[]> found1 = (List<Object[]>) genericClassService.fetchRecord(Facilitylocations.class, fields1, where1, params1, paramsValues1);
        Map<String, Object> buildingdetails;
        if (found1 != null) {
            for (Object[] req : found1) {
                buildingdetails = new HashMap<>();
                buildingdetails.put("buildingname", (String) req[0]);
                buildingdetails.put("buildingid", (Integer) req[1]);
                buildings.add(buildingdetails);
            }
        }
        model.addAttribute("buildings", buildings);
        model.addAttribute("serviceid", serviceid);
        model.addAttribute("facilityunitserviceid", facilityunitserviceid);
        model.addAttribute("blockroomlist", blockroomlist);
        model.addAttribute("jsonsunassignedroomlists", jsonsunassignedroomlist);
        return "controlPanel/localSettingsPanel/Serviceallocation/views/seviceroomassignment";
    }

    @RequestMapping(value = "/serviceslist", method = RequestMethod.GET)
    public String serviceslist(HttpServletRequest request, Model model
    ) {
        String FacilityUnitSession = request.getSession().getAttribute("sessionActiveLoginFacilityUnit").toString();
        List<Map> servicelist = new ArrayList<>();
        Set<Integer> roomz = new HashSet<>();
        String[] params = {"facilityunitid"};
        Object[] paramsValues = {BigInteger.valueOf(Long.parseLong(FacilityUnitSession))};
        String[] fields = {"facilityservices.serviceid", "facilityunitserviceid"};
        String where = "WHERE facilityunitid=:facilityunitid";
        List<Object[]> found = (List<Object[]>) genericClassService.fetchRecord(Facilityunitservice.class, fields, where, params, paramsValues);
        Map<String, Object> servicerooms;
        if (found != null) {
            for (Object[] req : found) {
                servicerooms = new HashMap<>();
                servicerooms.put("serviceid", (Integer) req[0]);
                servicerooms.put("facilityunitserviceid", (Long) req[1]);
                String[] paramssname = {"serviceid"};
                Object[] paramsValuessname = {(Integer) req[0]};
                String[] fieldsname = {"servicename"};
                String wheresname = "WHERE serviceid=:serviceid";
                List<String> foundsname = (List<String>) genericClassService.fetchRecord(Facilityservices.class, fieldsname, wheresname, paramssname, paramsValuessname);
                if (foundsname != null) {
                    servicerooms.put("servicename", foundsname.get(0));

                }
                String[] params2 = {"facilityunitserviceid"};
                Object[] paramsValues2 = {(Long) req[1]};
                String where2 = "WHERE facilityunitservice=:facilityunitserviceid";
                int rooms = genericClassService.fetchRecordCount(Facilityunitroomservice.class, where2, params2, paramsValues2);

                servicerooms.put("rooms", rooms);
                roomz.add((Integer) rooms);
                if (roomz.size() != 0) {
                    servicerooms.put("roomstatus", "norooms");
                } else {
                    servicerooms.put("roomstatus", "hasrooms");
                }
                servicelist.add(servicerooms);
            }

        }

        model.addAttribute("servicelist", servicelist);
        return "controlPanel/localSettingsPanel/Serviceallocation/views/assignedservices";
    }

    @RequestMapping(value = "/savefavilityunitroom.htm")
    public final ModelAndView savefavilityunitroom(HttpServletRequest request, @ModelAttribute("selectedroomid") String selectedroomid) {
        long staffid = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginStaffid").toString());
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            List<Map> roomids = new ObjectMapper().readValue(selectedroomid, List.class);
            for (Map room : roomids) {
                Map<String, Object> map = (HashMap) room;
                Facilityunitroomservice saverroms = new Facilityunitroomservice();
                String serviceid = request.getParameter("serviceid");
                saverroms.setFacilityunitservice(Long.parseLong(serviceid));
                saverroms.setFacilityunitroomid((Integer) map.get("facilityunitroomid"));
                saverroms.setDateadded(new Date());
                saverroms.setAddedby(staffid);
                Object save = genericClassService.saveOrUpdateRecordLoadObject(saverroms);
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return new ModelAndView("controlPanel/localSettingsPanel/Serviceallocation/views/seviceroomassignment", "model", model);
    }

    @RequestMapping(value = "/savecheckedroomservice", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView savecheckedroomservice(HttpServletRequest request
    ) {
        long staffid = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginStaffid").toString());
        Map<String, Object> model = new HashMap<String, Object>();

        try {
            //saving requisition
            Facilityunitroomservice saverroms = new Facilityunitroomservice();
            String facilityunitserviceid = request.getParameter("facilityunitserviceid");
            String facilityunitroomid = request.getParameter("facilityunitroomid");
            saverroms.setFacilityunitservice(Long.parseLong(facilityunitserviceid));
            saverroms.setFacilityunitroomid(Integer.parseInt(facilityunitroomid));
            saverroms.setDateadded(new Date());
            saverroms.setAddedby(staffid);
            Object save = genericClassService.saveOrUpdateRecordLoadObject(saverroms);

        } catch (Exception ex) {
            ex.printStackTrace();
            model.put("error", ex);
        }

        return new ModelAndView("controlPanel/localSettingsPanel/Serviceallocation/views/seviceroomassignment", "model", model);
    }

    @RequestMapping(value = "/uncheckedroomservice", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView uncheckedroomservice(HttpServletRequest request
    ) {
        long staffid = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginStaffid").toString());
        Map<String, Object> model = new HashMap<String, Object>();

        try {
            //saving requisition
            Facilityunitroomservice saverroms = new Facilityunitroomservice();
            String facilityunitroomserviceid = request.getParameter("facilityunitroomserviceid");
            System.out.println("----------facilityunitroomserviceid----"+facilityunitroomserviceid);
            String[] columns = {"facilityunitroomserviceid"};
            Object[] columnValues = {Integer.parseInt(facilityunitroomserviceid)};
            genericClassService.deleteRecordByByColumns("assetsmanager.Facilityunitroomservice", columns, columnValues);
        } catch (Exception ex) {
            ex.printStackTrace();
            model.put("error", ex);
        }

        return new ModelAndView("controlPanel/localSettingsPanel/Serviceallocation/views/seviceroomassignment", "model", model);
    }

    @RequestMapping(value = "/viewroomswithservices.htm", method = RequestMethod.GET)
    public String viewroomswithservices(Model model, HttpServletRequest request, @ModelAttribute("serviceid") int serviceid) {
        List<Map> servicerooms = new ArrayList<>();
        Set<String> serviceset = new HashSet<>();
        String[] paramserviceroom = {"serviceid"};
        Object[] paramsValuesserviceroom = {serviceid};
        String[] fieldsserviceroom = {"facilityunitserviceid"};
        String whereserviceroom = "WHERE serviceid=:serviceid";
        List<Long> foundserviceroom = (List<Long>) genericClassService.fetchRecord(Facilityunitservice.class, fieldsserviceroom, whereserviceroom, paramserviceroom, paramsValuesserviceroom);
        Map<String, Object> serviceroom = null;
        if (foundserviceroom != null) {
            for (Long rms : foundserviceroom) {
                String[] paramsunitroom = {"facilityunitserviceid"};
                Object[] paramsValuesunitroom = {rms};
                String[] fieldsunitroom = {"facilityunitroomid"};
                String whereunitroom = "WHERE facilityunitservice=:facilityunitserviceid";
                List<Integer> foundunitroom = (List<Integer>) genericClassService.fetchRecord(Facilityunitroomservice.class, fieldsunitroom, whereunitroom, paramsunitroom, paramsValuesunitroom);
                if (foundunitroom != null) {
                    for (Integer rmservice : foundunitroom) {
                        String[] paramslocation = {"facilityunitroomid"};
                        Object[] paramsValueslocation = {rmservice};
                        String[] fieldslocation = {"roomname", "floorname", "blockname", "buildingname"};
                        String wherelocation = "WHERE facilityunitroomid=:facilityunitroomid";
                        List<Object[]> foundlocation = (List<Object[]>) genericClassService.fetchRecord(Facilitylocations.class, fieldslocation, wherelocation, paramslocation, paramsValueslocation);
                        if (foundlocation != null) {
                            for (Object[] locz : foundlocation) {
                                serviceroom = new HashMap<>();
                                serviceroom.put("roomname", (String) locz[0]);
                                serviceroom.put("floorname", (String) locz[1]);
                                serviceroom.put("blockname", (String) locz[2]);
                                serviceroom.put("buildingname", (String) locz[3]);
                                servicerooms.add(serviceroom);
                            }

                        }
                    }
                }
            }
        }
        model.addAttribute("servicerooms", servicerooms);
        return "controlPanel/localSettingsPanel/Serviceallocation/views/viewroomwithservices";
    }

}
