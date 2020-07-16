/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.domain.Buildingfloors;
import com.iics.domain.Facility;
import com.iics.domain.Facilitybuildings;
import com.iics.domain.Floorrooms;
import com.iics.service.GenericClassService;
import java.io.IOException;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
 * @author USER 1
 */
@Controller
@RequestMapping("/facilityinfrastructure")
public class FacilityInfrastructure {

    @Autowired
    GenericClassService genericservice;
    Object threadLock = new Object();

    /* method for manage infrastructure*/
    @RequestMapping(value = "/manageinfrastructure", method = RequestMethod.GET)
    public String manageinfrastructure(HttpServletRequest request, Model model) {
        List<Map> zoneObjList = new ArrayList<>();
        int facilityid = (int) request.getSession().getAttribute("sessionActiveLoginFacility");

        //Fetching Facility
        Facility facilityDesignations = new Facility();
        String[] paramsfacility = {"facilityid"};
        Object[] paramsValuesfacility = {facilityid};
        String[] fieldsfacility = {"facilityid", "facilityname"};
        String wherefacility = "WHERE facilityid=:facilityid";
        List<Object[]> facility = (List<Object[]>) genericservice.fetchRecord(Facility.class, fieldsfacility, wherefacility, paramsfacility, paramsValuesfacility);

        if (facility != null) {

            facilityDesignations.setFacilityid((Integer) facility.get(0)[0]);
            facilityDesignations.setFacilityname((String) facility.get(0)[1]);

            model.addAttribute("FacilityLists", facilityDesignations);
        }
        //fetching buildings
        String[] fields = {"buildingid", "buildingname"};
        List<Object[]> facilitybuilding = (List<Object[]>) genericservice.fetchRecord(Facilitybuildings.class, fields, wherefacility, paramsfacility, paramsValuesfacility);
        Map<String, Object> fbuilds;
        if (facilitybuilding != null) {
            for (Object[] building : facilitybuilding) {
                fbuilds = new HashMap<>();
                fbuilds.put("buildingid", building[0]);
                fbuilds.put("buildingname", (String) building[1]);

                zoneObjList.add(fbuilds);

            }
        }
        String jsonCreatedzone = "";
        try {
            jsonCreatedzone = new ObjectMapper().writeValueAsString(zoneObjList);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }
        model.addAttribute("jsonCreatedzone", jsonCreatedzone);

        return "controlPanel/localSettingsPanel/facilityinfrastructure/facilityinfrastructure";

    }

    /*method for checking building name*/
    @RequestMapping(value = "/checkfacilitybuildingname.htm")
    public @ResponseBody
    String checkFacilityBuildingName(HttpServletRequest request) {
        int facilityid = (int) request.getSession().getAttribute("sessionActiveLoginFacility");
        String results = "";

        String[] params = {"facilityid", "value"};
        Object[] paramsValues = {facilityid, request.getParameter("buildingname").trim().toLowerCase()};
        String[] fields = {"buildingname"};
        String where = "WHERE facilityid=:facilityid AND  (LOWER(buildingname) =:value) ORDER BY buildingname";
        List<Object[]> classficationList = (List<Object[]>) genericservice.fetchRecord(Facilitybuildings.class, fields, where, params, paramsValues);
        if (classficationList != null) {
            results = "existing";
        } else {
            results = "notexisting";
        }

        return results;
    }

    /*method for saving new buildings*/
    @RequestMapping(value = "/savenewbuildings", method = RequestMethod.POST)
    public @ResponseBody
    String saveNewBuildings(HttpServletRequest request, Model model, @ModelAttribute("buildings") String buildings) {
        Set<Integer> buildngsids = new HashSet<>();
        String results = "";
        Buildingfloors newfloor = new Buildingfloors();
        Floorrooms newroom = new Floorrooms();
        String defaultfloorname = request.getParameter("defaultfloorname");
        String defaultroomname = request.getParameter("defaultroomname");
        Integer facilityid = (int) request.getSession().getAttribute("sessionActiveLoginFacility");
        final List<String> messages = new ArrayList<>();
        final List<Map> result = new ArrayList<>();
        final Map<String, Object> res = new HashMap<>();
        try {
            List<Map> buildingList = new ObjectMapper().readValue(buildings, List.class);
            synchronized (threadLock) {
                for (Map item : buildingList) {
                    Map<String, Object> map = (HashMap) item;

                    Facilitybuildings newbuilding = new Facilitybuildings();

                    //  String addedbyname = request.getSession().getAttribute("person_id").toString();
                    // Object updatedbyname = request.getSession().getAttribute("person_id");
                    //
                    String[] params = {"facilityid", "value"};
                    Object[] paramsValues = {facilityid, map.get("buildingName").toString().trim().toLowerCase()};
                    String[] fields = {"buildingname"};
                    String where = "WHERE facilityid=:facilityid AND  (LOWER(buildingname) =:value) ORDER BY buildingname";
                    List<Object[]> classficationList = (List<Object[]>) genericservice.fetchRecord(Facilitybuildings.class, fields, where, params, paramsValues);
                    if (classficationList != null) {
                        messages.add("Building " + map.get("buildingName") + " Exists");
                    } else {
                        newbuilding.setFacilityid(facilityid);
                        newbuilding.setBuildingname((String) map.get("buildingName"));
                        newbuilding.setIsactive(Boolean.TRUE);
                        newbuilding.setDateadded(new Date());
                        //newbuilding.setAddedby(addedbyname);
                        Object save = genericservice.saveOrUpdateRecordLoadObject(newbuilding);
                        if (save != null) {

                            buildngsids.add(newbuilding.getBuildingid());
                            newfloor.setBuildingid(((Facilitybuildings) save).getBuildingid());
                            newfloor.setFloorname(defaultfloorname);
                            Object savedefaultfloor = genericservice.saveOrUpdateRecordLoadObject(newfloor);
                            if (savedefaultfloor != null) {
                                newroom.setFloorid(((Buildingfloors) savedefaultfloor).getFloorid());
                                newroom.setRoomname(defaultroomname);
                                Object savedefaultroom = genericservice.saveOrUpdateRecordLoadObject(newroom);
                                if (savedefaultroom != null) {

                                }
                            }

                        }
                    }
                }
                //

            }
            res.put("messages", messages);
            res.put("buildingids", buildngsids);
            result.add(res);
            results = new ObjectMapper().writeValueAsString(result);
        } catch (IOException ex) {
            System.out.println(ex);
            return "Failed";
        }

        return results;
    }

    /*method for fetching buildings from the database*/
    @RequestMapping(value = "/facilityinfrastructure", method = RequestMethod.GET)
    public String manageFacilityStructure(HttpServletRequest request, Model model) {

        List<Map> buildingList = new ArrayList<>();
        int facilityid = (int) request.getSession().getAttribute("sessionActiveLoginFacility");

        String[] params = {"facilityid"};
        Object[] paramValues = {facilityid};
        String[] fields = {"buildingid", "buildingname", "isactive"};
        String where = "WHERE facilityid =:facilityid";
        List<Object[]> facilitybuilding = (List<Object[]>) genericservice.fetchRecord(Facilitybuildings.class, fields, where, params, paramValues);
        Map<String, Object> fbuilds;
        if (facilitybuilding != null) {
            for (Object[] building : facilitybuilding) {
                int roomsinbuilding = 0;
                fbuilds = new HashMap<>();
                fbuilds.put("buildingid", building[0]);
                fbuilds.put("buildingname", (String) building[1]);
                fbuilds.put("facilityid", building[2]);
                int count = genericservice.fetchRecordCount(Buildingfloors.class, "WHERE buildingid=:buildingid", new String[]{"buildingid"}, new Object[]{(Integer) building[0]});
                fbuilds.put("floorsize", count);
                
                String[] params1 = {"buildingid"};
                Object[] paramsValues1 = {(Integer) building[0]};
                String[] fields1 = {"floorid", "buildingid", "floorname"};
                String where1 = "WHERE buildingid=:buildingid";
                List<Object[]> buldingfloors = (List<Object[]>) genericservice.fetchRecord(Buildingfloors.class, fields1, where1, params1, paramsValues1);
                if (buldingfloors != null) {
                    for (Object[] floor : buldingfloors) {
                        int roomCounter;
                        String[] paramsf = {"floorid"};
                        Object[] paramsValuesf = {(Integer) floor[0]};
                        String[] fieldsf = {"roomid", "floorid", "roomname"};
                        String wheref = "WHERE floorid=:floorid";
                        roomCounter = genericservice.fetchRecordCount(Floorrooms.class, wheref, paramsf, paramsValuesf);
                        roomsinbuilding = roomsinbuilding + roomCounter;

                    }
                    params1 = new String[] {"buildingid","archived"};
                 paramsValues1 = new Object []{(Integer) building[0],Boolean.FALSE};
                    String wherer = "WHERE r.roomid IN (SELECT f.roomid FROM Floorrooms f WHERE f.floorid  IN (SELECT fb.floorid FROM Buildingfloors fb WHERE fb.buildingid=:buildingid)AND f.archived =:archived)";
                    int roomCounter = genericservice.fetchRecordCount(Floorrooms.class, wherer, params1, paramsValues1);
                    fbuilds.put("roomsinbuilding", roomCounter);

                    System.out.println("roomCounter" + roomCounter);

                }
                buildingList.add(fbuilds);

            }
            String existingbuilding = "";
            try {
                existingbuilding = new ObjectMapper().writeValueAsString(buildingList);
            } catch (JsonProcessingException ex) {
                System.out.println(ex);
            }
            model.addAttribute("buildingLists", buildingList);
            model.addAttribute("existingbuilding", existingbuilding);
        }

        Facility facilityDesignations = new Facility();
        String[] paramsfacility = {"facilityid"};
        Object[] paramsValuesfacility = {facilityid};
        String[] fieldsfacility = {"facilityid", "facilityname"};
        String wherefacility = "WHERE facilityid=:facilityid";
        List<Object[]> facility = (List<Object[]>) genericservice.fetchRecord(Facility.class, fieldsfacility, wherefacility, paramsfacility, paramsValuesfacility);

        if (facility != null) {

            facilityDesignations.setFacilityid((Integer) facility.get(0)[0]);
            facilityDesignations.setFacilityname((String) facility.get(0)[1]);

            model.addAttribute("FacilityListed", facilityDesignations);

        }

        return "controlPanel/localSettingsPanel/facilityinfrastructure/views/facilityinfrastructuretable";
    }

    /*Method for displaying a view for managing floors in a building*/
    @RequestMapping(value = "/addfloors.htm", method = RequestMethod.GET)
    public String AddFloors(HttpServletRequest request, @ModelAttribute("tablerowid") String buildingid, @ModelAttribute("tableData") String buildingname, Model model) {
        List<Map> Floors = new ArrayList<>();
        String results = "";
        try {
            int buildingidx = Integer.parseInt(buildingid);
            model.addAttribute("buildingname", buildingname);
            model.addAttribute("buildingid", buildingid);

            String[] paramsbs = {"buildingid"};
            Object[] paramsValuesbs = {buildingidx};
            String[] fieldsbs = {"floorid", "buildingid", "floorname"};
            String wherebs = "WHERE buildingid=:buildingid";
            List<Object[]> Fblkbs = (List<Object[]>) genericservice.fetchRecord(Buildingfloors.class, fieldsbs, wherebs, paramsbs, paramsValuesbs);
            if (Fblkbs != null) {
                Map<String, Object> floors;
                for (Object[] blk : Fblkbs) {
                    floors = new HashMap<>();

                    floors.put("floorid", (Integer) blk[0]);
                    floors.put("floorname", (String) blk[2]);

                    Floors.add(floors);
                }
                model.addAttribute("FloorLists", Floors);
            }
            Facilitybuildings buildingDesignations = new Facilitybuildings();
            String[] paramsbuilding = {"buildingid"};
            Object[] paramsValuesbuilding = {buildingidx};
            String[] fieldsbuilding = {"buildingid", "buildingname"};
            String wherebuilding = "WHERE buildingid=:buildingid";
            List<Object[]> building = (List<Object[]>) genericservice.fetchRecord(Facilitybuildings.class, fieldsbuilding, wherebuilding, paramsbuilding, paramsValuesbuilding);

            if (building != null) {

                buildingDesignations.setBuildingid((Integer) building.get(0)[0]);
                buildingDesignations.setBuildingname((String) building.get(0)[1]);

                model.addAttribute("BuildingLists", buildingDesignations);

            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        return "controlPanel/localSettingsPanel/facilityinfrastructure/forms/managefloorinbuilding";

    }

    /*method for  checking floornames*/
    @RequestMapping(value = "/checkfloornames.htm", method = RequestMethod.GET)
    public @ResponseBody
    String checkfloornames(HttpServletRequest request, @ModelAttribute("buildingid") String tablerowid, @ModelAttribute("tableData") String tableData, Model model) throws IOException {
        String results = "";
        Set<String> floornames = new HashSet<>();
        List<Buildingfloors> buildingFloorz = new ArrayList<>();
        try {
            int buildingid = Integer.parseInt(request.getParameter("buildingid"));
            String buildingname = request.getParameter("buildingname");
            int tableid = Integer.parseInt(tablerowid);
            String[] paramszrrp = {"buildingid"};
            Object[] paramsValueszrrp = {tableid};
            String[] fieldszrrp = {"floorid", "buildingid", "floorname"};
            String wherezrrp = "WHERE r.buildingid=:buildingid ORDER BY r.floorname ASC";

            List<Object[]> floors = (List<Object[]>) genericservice.fetchRecord(Buildingfloors.class, fieldszrrp, wherezrrp, paramszrrp, paramsValueszrrp);

            if (floors != null) {
                for (Object[] dp : floors) {
                    Facilitybuildings building = new Facilitybuildings();
                    building.setBuildingid(buildingid);
                    Buildingfloors floorz = new Buildingfloors();
                    floorz.setFloorid((Integer) dp[0]);
                    floorz.setFloorname((String) dp[2]);
                    buildingFloorz.add(floorz);
                    floornames.add(floorz.getFloorname());
                }

            }
            model.addAttribute("viewFloors", buildingFloorz);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        try {
            results = new ObjectMapper().writeValueAsString(floornames);
        } catch (JsonProcessingException ex) {
            Logger.getLogger(Locationofresources.class.getName()).log(Level.SEVERE, null, ex);
        }
        model.addAttribute("viewFloorList", results);
        return results;
    }

    /*method for saving new floors in the database*/
    @RequestMapping(value = "/savefloors", method = RequestMethod.POST)
    public @ResponseBody
    String SaveFloors(HttpServletRequest request, Model model, @ModelAttribute("floorObjectLists") String selectedFloor, @ModelAttribute("buildingid") String buildingid,
            @ModelAttribute("roomx") String rowsxx) {
        Set<Integer> roomsidZ = new HashSet<>();
        String results = "";
        Buildingfloors creatingfloor;
        Facilitybuildings building = new Facilitybuildings();
        Floorrooms creatingrooms = new Floorrooms();
        int buildingidz = Integer.parseInt(buildingid);
        building.setBuildingid(buildingidz);
        ObjectMapper mapper = new ObjectMapper();
        List<Map> blded;
        final List<String> messages = new ArrayList<>();
        try {

            Object addedbynamedd = request.getSession().getAttribute("person_id");
            Object updatedbynamedd = request.getSession().getAttribute("person_id");

            blded = (ArrayList<Map>) new ObjectMapper().readValue(selectedFloor, List.class);
            synchronized (threadLock) {
                for (Map n : blded) {
                    Map<String, Object> map = (HashMap) n;

                    //
                    String[] paramszrrp = {"buildingid", "floorname"};
                    Object[] paramsValueszrrp = {buildingidz, map.get("floornamed").toString().trim().toLowerCase()};
                    String[] fieldszrrp = {"floorid", "buildingid", "floorname"};
                    String wherezrrp = "WHERE r.buildingid=:buildingid AND  (LOWER(floorname) =:floorname)ORDER BY r.floorname ASC";

                    List<Object[]> floors = (List<Object[]>) genericservice.fetchRecord(Buildingfloors.class, fieldszrrp, wherezrrp, paramszrrp, paramsValueszrrp);

                    if (floors != null) {
                        messages.add("floor " + map.get("floornamed") + " Exists");
                    } else {

                        creatingfloor = new Buildingfloors();
                        String floorname = (String) map.get("floornamed");
                        creatingfloor.setBuildingid(buildingidz);
                        creatingfloor.setFloorname(floorname);
                        Object savedfloor = genericservice.saveOrUpdateRecordLoadObject(creatingfloor);
                        if (savedfloor != null) {
                            roomsidZ.add(creatingfloor.getFloorid());

                            List<Map> rowV = (ArrayList<Map>) mapper.readValue(rowsxx, List.class);
                            for (Map k : rowV) {
                                if (Integer.parseInt(n.get("floorxid").toString()) == Integer.parseInt(k.get("floorid").toString())) {
                                    creatingrooms = new Floorrooms();
                                    String rowlabel = (String) k.get("roomnamex");
                                    creatingrooms.setRoomname(rowlabel);
                                    creatingrooms.setFloorid(((Buildingfloors) savedfloor).getFloorid());
                                    Object savedRow = genericservice.saveOrUpdateRecordLoadObject(creatingrooms);
                                    if (savedRow != null) {
                                        int roomid = creatingrooms.getRoomid();

                                        results = "Saved";
                                    } else {
                                        results = "failed";
                                    }

                                }
                            }

                        }
                    }

                }
            }
            results = new ObjectMapper().writeValueAsString(messages);
        } catch (IOException ex) {
            System.out.println(ex);
            return "Failed";
        }
        return results;
    }

    /* method for viewing floors in building*/
    @RequestMapping(value = "/viewfloorsinbuilding", method = RequestMethod.GET)
    public String viewFloors(Model model, HttpServletRequest request) {
        try {
            List<Map> Floorz = new ArrayList<>();

            int buildingid = Integer.parseInt(request.getParameter("buildingid"));
            String buildingname = request.getParameter("buildingname");

            model.addAttribute("buildingid", buildingid);
            model.addAttribute("buildingname", buildingname);

            String[] paramsbs = {"buildingid"};
            Object[] paramsValuesbs = {buildingid};
            String[] fieldsbs = {"floorid", "buildingid", "floorname"};
            String wherebs = "WHERE r.buildingid=:buildingid ORDER BY r.floorname ASC";
            List<Object[]> buildingfloors = (List<Object[]>) genericservice.fetchRecord(Buildingfloors.class, fieldsbs, wherebs, paramsbs, paramsValuesbs);
            if (buildingfloors != null) {
                Map<String, Object> fbuilds;
                for (Object[] blk : buildingfloors) {

                    fbuilds = new HashMap<>();
                    fbuilds.put("floorid", blk[0]);
                    fbuilds.put("buildingid", blk[1]);
                    fbuilds.put("floorname", blk[2]);
                    int roomCounter;
                    String[] paramsf = {"floorid","archived"};
                    Object[] paramsValuesf = {blk[0],Boolean.FALSE};
                    String[] fieldsf = {"roomid", "floorid", "roomname"};
                    String wheref = "WHERE floorid=:floorid AND archived=:archived";
                    roomCounter = genericservice.fetchRecordCount(Floorrooms.class, wheref, paramsf, paramsValuesf);
                    fbuilds.put("roomsize", roomCounter);
                    Floorz.add(fbuilds);
                }
                model.addAttribute("viewFloorsList", Floorz);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        // checking room size

        return "controlPanel/localSettingsPanel/facilityinfrastructure/views/viewfloorsinbuilding";

    }

    /* method for saving rooms to a floor*/
    @RequestMapping(value = "/saveroomTofloor", method = RequestMethod.POST)
    public @ResponseBody
    String SaveRoomtoFloor(HttpServletRequest request, Model model, @ModelAttribute("roomz") String roomz, @ModelAttribute("floorid") String floorid) {
        Set<Integer> roomsList = new HashSet<>();
        String results = "";
        Floorrooms newblkrooms;
        int flooridz = Integer.parseInt(floorid);

        ObjectMapper mapper = new ObjectMapper();
        String msg = "";
        final List<String> messages = new ArrayList<>();
        List<Map> blded;
        try {

            Object addedbynamedd = request.getSession().getAttribute("person_id");
            Object updatedbynamedd = request.getSession().getAttribute("person_id");

            blded = (ArrayList<Map>) new ObjectMapper().readValue(roomz, List.class);
            synchronized (threadLock) {
                for (Map n : blded) {
                    Map<String, Object> map = (HashMap) n;
                    String[] paramszrrp = {"floorid", "roomname"};
                    Object[] paramsValueszrrp = {flooridz, map.get("roomnamed").toString().trim().toLowerCase()};
                    String[] fieldszrrp = {"roomid", "floorid", "roomname"};
                    String wherezrrp = "WHERE r.floorid=:floorid AND(LOWER(roomname) =:roomname) ORDER BY r.roomname ASC";

                    List<Object[]> blkrmz = (List<Object[]>) genericservice.fetchRecord(Floorrooms.class, fieldszrrp, wherezrrp, paramszrrp, paramsValueszrrp);

                    if (blkrmz != null) {
                        messages.add("room " + map.get("roomnamed") + " Exists");
                    } else {
                        Buildingfloors floor = new Buildingfloors();
                        floor.setFloorid(flooridz);
                        newblkrooms = new Floorrooms();
                        String roomname = (String) map.get("roomnamed");
                        newblkrooms.setFloorid(flooridz);
                        newblkrooms.setRoomname(roomname);
                        newblkrooms.setArchived(Boolean.FALSE);

                        Object save = genericservice.saveOrUpdateRecordLoadObject(newblkrooms);
                        if (save != null) {
                            roomsList.add(newblkrooms.getRoomid());
                            results = "Saved";
                        }

                    }
                }
            }
            results = new ObjectMapper().writeValueAsString(messages);
        } catch (IOException ex) {
            System.out.println(ex);
            return "Failed";
        }
        return results;
    }

    /* method for checking room names*/
    @RequestMapping(value = "/checkfloorroomname.htm")
    public @ResponseBody
    String checkfloorroomname(HttpServletRequest request, @ModelAttribute("floorid") String floorid, @ModelAttribute("floorname") String floorname, Model model) throws IOException {
        String results = "";
        try {
            int flooridz = Integer.parseInt(floorid);
            String floornamex = request.getParameter("floorname");
            Set<String> floorrooms = new HashSet<>();
            List<Floorrooms> floorRoomz = new ArrayList<>();

            String[] paramszrrp = {"floorid"};
            Object[] paramsValueszrrp = {flooridz};
            String[] fieldszrrp = {"roomid", "floorid", "roomname"};
            String wherezrrp = "WHERE r.floorid=:floorid ORDER BY r.roomname ASC";

            List<Object[]> blkrmz = (List<Object[]>) genericservice.fetchRecord(Floorrooms.class, fieldszrrp, wherezrrp, paramszrrp, paramsValueszrrp);

            if (blkrmz != null) {
                for (Object[] dp : blkrmz) {
                    Floorrooms rooms = new Floorrooms();
                    rooms.setRoomid((Integer) dp[0]);
                    rooms.setFloorid((Integer) dp[1]);
                    rooms.setRoomname((String) dp[2]);
                    floorrooms.add(rooms.getRoomname());
                }
            }
            model.addAttribute("viewBlockRoomsList", floorRoomz);
            try {
                results = new ObjectMapper().writeValueAsString(floorrooms);
            } catch (JsonProcessingException ex) {
                Logger.getLogger(Locationofresources.class.getName()).log(Level.SEVERE, null, ex);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        };
        model.addAttribute("viewRoomsLists", results);
        return results;
    }

    /*method for dispalying view for adding rooms*/
    @RequestMapping(value = "/addrooms.htm", method = RequestMethod.GET)
    public String AddRooms(HttpServletRequest request, @ModelAttribute("buildingid") String buildingid, @ModelAttribute("tableData") String floorname, String floorid, Model model) {
        List<Map> Floors = new ArrayList<>();
        String results = "";
        try {
            int buildingidz = Integer.parseInt(buildingid);
            Buildingfloors buildingDesignations = new Buildingfloors();

            String[] paramsbuilding = {"buildingid"};
            Object[] paramsValuesbuilding = {buildingidz};
            String[] fieldsbuilding = {"floorid", "buildingid", "floorname"};
            String wherebuilding = "WHERE r.buildingid=:buildingid";
            List<Object[]> building = (List<Object[]>) genericservice.fetchRecord(Buildingfloors.class, fieldsbuilding, wherebuilding, paramsbuilding, paramsValuesbuilding);

            if (building != null) {
                Map<String, Object> floors;
                for (Object[] blk : building) {
                    floors = new HashMap<>();

                    floors.put("floorid", (Integer) blk[0]);
                    floors.put("floorname", (String) blk[2]);

                    Floors.add(floors);
                }

                model.addAttribute("floorlists", Floors);

            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        return "controlPanel/localSettingsPanel/facilityinfrastructure/forms/addroomsinfloor";

    }

    /*method for updating floor name */
    @RequestMapping(value = "/updatefloor", method = RequestMethod.POST)
    public @ResponseBody
    String updateFloor(HttpServletRequest request) {
        String results = "";
        int floorid = Integer.parseInt(request.getParameter("floorid"));
        String floorname = request.getParameter("floorname");
        String pk = "floorid";
        Object pkValue = floorid;
        String[] columns = {"floorname"};
        Object[] columnvalues = {floorname};
        String schema = "public";
        int response = genericservice.updateRecordSQLSchemaStyle(Buildingfloors.class, columns, columnvalues, pk, pkValue, schema);
        if (response > 0) {
            results = "Record updated succesfully";
        } else {
            results = "Failed";

        }
        return results;
    }

    /*method for updating building name*/
    @RequestMapping(value = "/updatebuilding", method = RequestMethod.POST)
    public @ResponseBody
    String updateBuilding(HttpServletRequest request) {
        String results = "";
    try {
        int buildingid = Integer.parseInt(request.getParameter("buildingid"));
        String buildingname = request.getParameter("buildingname");
        String pk = "buildingid";
        Object pkValue = buildingid;
        String[] columns = {"buildingname"};
        Object[] columnValues = {buildingname};
        String schema = "public";
        int response = genericservice.updateRecordSQLSchemaStyle(Facilitybuildings.class, columns, columnValues, pk, pkValue, schema);
        if (response > 0) {
            results = "Record updated successfully";
        } else {
            results = "Failed";
        }
    } catch (NumberFormatException e) {
        e.printStackTrace();

    }
        return results;
    }


    /*method for updating room name */
    @RequestMapping(value = "/updateroom", method = RequestMethod.POST)
    public @ResponseBody
    String updateRoom(HttpServletRequest request) {
        String results = "";
        int roomid = Integer.parseInt(request.getParameter("roomid"));
        String roomname = request.getParameter("roomname");
        String pk = "roomid";
        Object pkvalue = roomid;
        String[] columns = {"roomname"};
        Object[] columnValues = {roomname};
        String schema = "public";
        int response = genericservice.updateRecordSQLSchemaStyle(Floorrooms.class, columns, columnValues, pk, pkvalue, schema);
        if (response > 0) {
            results = "Record updated successfully";
        } else {
            results = "Failed";
        }
        return results;
    }

    /*method for displaying update form for rooms */
    @RequestMapping(value = "/updateroomform", method = RequestMethod.GET)
    public ModelAndView updateroomForm() {
        return new ModelAndView("controlPanel/localSettingsPanel/facilityinfrastructure/views/updateroom", "floorrooms", new Floorrooms());
    }

    /*method for displaying update form for floors*/
    @RequestMapping(value = "/updatefloorform", method = RequestMethod.GET)
    public ModelAndView updatefloorForm() {
        return new ModelAndView("controlPanel/localSettingsPanel/facilityinfrastructure/views/updatefloor", "buildingfloors", new Buildingfloors());
    }

    /*method for displaying update for building*/
    @RequestMapping(value = "/updatefacilitybuilding", method = RequestMethod.GET)
    public ModelAndView updatefacilitybuildingform() {
        return new ModelAndView("controlPanel/localSettingsPanel/facilityinfrastructure/views/updatebuilding", "facilitybuildings", new Facilitybuildings());
    }

    /* method for checking edited roomnames */
    @RequestMapping(value = "/checkEditedRoomNames.htm", method = RequestMethod.POST)
    public @ResponseBody
    String checkEditedRoomNames(HttpServletRequest request) {
        String results = "";

        String[] params = {"floorid", "roomname"};
        Object[] paramsValues = {Integer.parseInt(request.getParameter("floorid")), request.getParameter("roomname").trim().toLowerCase()};
        String[] fields = {"roomname"};

        String where = "WHERE floorid=:floorid AND  (LOWER(roomname) =:roomname) ORDER BY roomname";
        List<Object[]> floorList = (List<Object[]>) genericservice.fetchRecord(Floorrooms.class, fields, where, params, paramsValues);
        if (floorList != null) {
            results = "existing";
        } else {
            results = "notexisting";
        }

        return results;
    }

    /*method for checking editedfloornames*/
    @RequestMapping(value = "/checkEditedFloorNames.htm")
    public @ResponseBody
    String checkEditedFloorNames(HttpServletRequest request) {
        String results = "";

        String[] params = {"buildingid", "floorname"};
        Object[] paramsValues = {Integer.parseInt(request.getParameter("buildingid")), request.getParameter("floorname").trim().toLowerCase()};
        String[] fields = {"floorname"};
        String where = "WHERE buildingid=:buildingid AND  (LOWER(floorname) =:floorname) ORDER BY floorname";
        List<Object[]> floorList = (List<Object[]>) genericservice.fetchRecord(Buildingfloors.class, fields, where, params, paramsValues);
        if (floorList != null) {
            results = "existing";
        } else {
            results = "notexisting";
        }

        return results;
    }

    /*method for viewing rooms in floor*/
    @RequestMapping(value = "/viewroomsinfloors", method = RequestMethod.GET)
    public String viewRooms(Model model, HttpServletRequest request) {
        try {
            List<Map> Roomz = new ArrayList<>();

            int floorid = Integer.parseInt(request.getParameter("floorid"));
            String floorname = request.getParameter("floorname");

            model.addAttribute("floorid", floorid);
            model.addAttribute("floorname", floorname);

            String[] paramsbs = {"floorid","archived"};
            Object[] paramsValuesbs = {floorid,Boolean.FALSE};
            String[] fieldsbs = {"roomid", "floorid", "roomname"};
            String wherebs = "WHERE r.floorid=:floorid AND r.archived=:archived ORDER BY r.roomname ASC";
            List<Object[]> buildingfloors = (List<Object[]>) genericservice.fetchRecord(Floorrooms.class, fieldsbs, wherebs, paramsbs, paramsValuesbs);
            if (buildingfloors != null) {
                Map<String, Object> fbuilds;
                for (Object[] blk : buildingfloors) {

                    fbuilds = new HashMap<>();
                    fbuilds.put("roomid", blk[0]);
                    fbuilds.put("roomname", blk[2]);
                    fbuilds.put("floorid", blk[1]);

                    Roomz.add(fbuilds);
                }
                model.addAttribute("viewRoomsList", Roomz);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        return "controlPanel/localSettingsPanel/facilityinfrastructure/views/viewroomsinfloor";

    }

    /*method for displaying form for adding floors to a building*/
    @RequestMapping(value = "/addfloorz.htm", method = RequestMethod.GET)
    public String addfloor(HttpServletRequest request, Model model, @ModelAttribute("res") String response) {
        List<Map> blockList = new ArrayList<>();
        System.out.println("" + response);
        try {
            System.out.println("" + response);
            List<Integer> blkId = (ArrayList) new ObjectMapper().readValue(response, List.class);

            System.out.println("" + blkId);
            for (Integer Ids : blkId) {

                System.out.println("" + Ids);
                String[] params = {"buildingid"};
                Object[] paramsValues = {Ids};
                String[] fields = {"buildingid", "buildingname"};
                String where = "WHERE buildingid=:buildingid ORDER BY buildingname";
                List<Object[]> Fblkrm = (List<Object[]>) genericservice.fetchRecord(Facilitybuildings.class, fields, where, params, paramsValues);
                if (Fblkrm != null) {
                    Map<String, Object> fblocks;
                    Object[] fblk = Fblkrm.get(0);
                    fblocks = new HashMap<>();
                    fblocks.put("buildingid", Ids);
                    fblocks.put("buildingname", fblk[1]);
                    blockList.add(fblocks);
                }
            }
            model.addAttribute("buildingzz", blockList);
            System.out.println("" + blockList);

        } catch (Exception e) {
            System.out.println(e);
        }

        return "controlPanel/localSettingsPanel/facilityinfrastructure/forms/addfloorinbuilding";

    }

    /*method for managing rooms*/
    @RequestMapping(value = "/managerooms.htm", method = RequestMethod.GET)
    public String ManageRooms(HttpServletRequest request, @ModelAttribute("tablerowid") String buildingid, @ModelAttribute("tableData") String floorname, String floorid, Model model) {
        List<Map> Floors = new ArrayList<>();
        String results = "";

        int buildingidz = Integer.parseInt(buildingid);
        Buildingfloors buildingDesignations = new Buildingfloors();

        String[] paramsbuilding = {"buildingid"};
        Object[] paramsValuesbuilding = {buildingidz};
        String[] fieldsbuilding = {"floorid", "buildingid", "floorname"};
        String wherebuilding = "WHERE r.buildingid=:buildingid";
        List<Object[]> building = (List<Object[]>) genericservice.fetchRecord(Buildingfloors.class, fieldsbuilding, wherebuilding, paramsbuilding, paramsValuesbuilding);

        if (building != null) {
            Map<String, Object> floors;
            for (Object[] blk : building) {
                floors = new HashMap<>();

                floors.put("floorid", (Integer) blk[0]);
                floors.put("floorname", (String) blk[2]);

                Floors.add(floors);
            }

            model.addAttribute("floorlists", Floors);

        }

        return "controlPanel/localSettingsPanel/facilityinfrastructure/forms/manageroominfloor";

    }

    ///sentense case
    private static String capitalize(String str) {
        StringBuilder result = new StringBuilder(str.length());
        String words[] = str.split("\\ ");
        for (int i = 0; i < words.length; i++) {
            if (words[i].length() != 0) {
                result.append(Character.toUpperCase(words[i].charAt(0))).append(words[i].substring(1)).append(" ");
            }
        }
        return result.toString();
    }

    ////new savings for building
    @RequestMapping(value = "/createbuilding")
    public @ResponseBody
    String createZones(HttpServletRequest request, Model model,
            @ModelAttribute("buildings") String zonex,
            @ModelAttribute("floors") String baysx,
            @ModelAttribute("rooms") String rowsx
    ) {
        String msg = "";
        if (request.getSession().getAttribute("sessionActiveLoginFacility") != null) {
            try {
                Set<Integer> buildngsids = new HashSet<>();
                final List<String> messages = new ArrayList<>();
                final Map<String, Object> res = new HashMap<>();
                final List<Map> result = new ArrayList<>();
                Facilitybuildings creatingbuilding;
                Buildingfloors creatingfloor;
                Floorrooms creatingrooms;
                //BigInteger systemuserid = BigInteger.valueOf((Long) request.getSession().getAttribute("systemuserid"));
                int facilityunitid = (int) request.getSession().getAttribute("sessionActiveLoginFacility");
                BigInteger addedby = BigInteger.valueOf((Long) request.getSession().getAttribute("sessionActiveLoginStaffid"));
                ObjectMapper mapper = new ObjectMapper();
                List<Map> buildingV = (ArrayList<Map>) mapper.readValue(zonex, List.class);
                synchronized (threadLock) {
                    for (Map w : buildingV) {
                        String[] params = {"facilityid", "value"};
                        Object[] paramsValues = {facilityunitid, w.get("buildingname").toString().trim().toLowerCase()};
                        String[] fields = {"buildingname"};
                        String where = "WHERE facilityid=:facilityid AND  (LOWER(buildingname) =:value) ORDER BY buildingname";
                        List<Object[]> classficationList = (List<Object[]>) genericservice.fetchRecord(Facilitybuildings.class, fields, where, params, paramsValues);
                        if (classficationList != null) {
                            messages.add("Building " + w.get("buildingname") + " Exists");
                        } else {
                            creatingbuilding = new Facilitybuildings();
                            creatingbuilding.setBuildingname(w.get("buildingname").toString());
                            creatingbuilding.setFacilityid(facilityunitid);
                            creatingbuilding.setDateadded(new Date());
                            creatingbuilding.setAddedby(addedby.intValue());
                            Object savedbuilding = genericservice.saveOrUpdateRecordLoadObject(creatingbuilding);
                            if (savedbuilding != null) {
                                int buildingid = creatingbuilding.getBuildingid();
                                buildngsids.add(creatingbuilding.getBuildingid());
                                model.addAttribute("buildingidx", buildingid);
                                List<Map> bayV = (ArrayList<Map>) mapper.readValue(baysx, List.class);
                                for (Map n : bayV) {
                                    creatingfloor = new Buildingfloors();
                                    String baylabel = (String) n.get("floorname");
                                    creatingfloor.setFloorname(baylabel);
                                    creatingfloor.setBuildingid(((Facilitybuildings) savedbuilding).getBuildingid());
                                    Object savedfloor = genericservice.saveOrUpdateRecordLoadObject(creatingfloor);
                                    if (savedfloor != null) {
                                        int floorid = creatingfloor.getFloorid();
                                        List<Map> rowV = (ArrayList<Map>) mapper.readValue(rowsx, List.class);
                                        for (Map k : rowV) {
                                            if (Integer.parseInt(n.get("floorid").toString()) == Integer.parseInt(k.get("bayid").toString())) {
                                                creatingrooms = new Floorrooms();
                                                String rowlabel = (String) k.get("BayrowtestArray");
                                                creatingrooms.setRoomname(rowlabel);
                                                creatingrooms.setFloorid(((Buildingfloors) savedfloor).getFloorid());
                                                creatingrooms.setArchived(Boolean.FALSE);
                                                Object savedRow = genericservice.saveOrUpdateRecordLoadObject(creatingrooms);
                                                if (savedRow != null) {
                                                    int roomid = creatingrooms.getRoomid();

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
                res.put("messages", messages);
                res.put("buildingid", buildngsids);
                result.add(res);
                msg = new ObjectMapper().writeValueAsString(result);
            } catch (NullPointerException | JsonProcessingException ex) {
                System.out.println(ex);
            } catch (IOException ex) {
                System.out.println(ex);
            }
        } else {
            msg = "refresh";
        }
        return msg;
    }

    //return
    @RequestMapping(value = "/building", method = RequestMethod.GET)
    public ModelAndView infratructurebuildingForm(HttpServletRequest request, Model model) {
        List<Map> zoneObjList = new ArrayList<>();
        int facilityid = (int) request.getSession().getAttribute("sessionActiveLoginFacility");

        //Fetching Facility
        Facility facilityDesignations = new Facility();
        String[] paramsfacility = {"facilityid"};
        Object[] paramsValuesfacility = {facilityid};
        String[] fieldsfacility = {"facilityid", "facilityname"};
        String wherefacility = "WHERE facilityid=:facilityid";
        List<Object[]> facility = (List<Object[]>) genericservice.fetchRecord(Facility.class, fieldsfacility, wherefacility, paramsfacility, paramsValuesfacility);

        if (facility != null) {

            facilityDesignations.setFacilityid((Integer) facility.get(0)[0]);
            facilityDesignations.setFacilityname((String) facility.get(0)[1]);

            model.addAttribute("FacilityLists", facilityDesignations);
        }
        String[] fields = {"buildingid", "buildingname"};
        List<Object[]> facilitybuilding = (List<Object[]>) genericservice.fetchRecord(Facilitybuildings.class, fields, wherefacility, paramsfacility, paramsValuesfacility);
        Map<String, Object> fbuilds;
        if (facilitybuilding != null) {
            for (Object[] building : facilitybuilding) {
                fbuilds = new HashMap<>();
                fbuilds.put("buildingid", building[0]);
                fbuilds.put("buildingname", (String) building[1]);

                zoneObjList.add(fbuilds);

            }
        }
        String jsonCreatedzone = "";
        try {
            jsonCreatedzone = new ObjectMapper().writeValueAsString(zoneObjList);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }
        model.addAttribute("jsonCreatedzone", jsonCreatedzone);

        return new ModelAndView("controlPanel/localSettingsPanel/facilityinfrastructure/forms/infrastructurebuilding", "facilitybuildings", new Facilitybuildings());
    }

    //delete room
    @RequestMapping(value = "/deleteroom.htm", method = RequestMethod.POST)
    public @ResponseBody
    String deleteroom(HttpServletRequest request) {
        String results = "";

        String[] columns = {"roomid"};
        Object[] columnValues = {Integer.parseInt(request.getParameter("roomid"))};
        int result = genericservice.deleteRecordByByColumns(Floorrooms.class, columns, columnValues);
        if (result != 0) {
            results = "success";
        }

        return results;
    }

    //method that lists rooms in a building
//    @RequestMapping(value = "/viewroom.htm", method = RequestMethod.GET)
//    public String Viewroom(HttpServletRequest request,  Model model) {
//        List<Map> Rooms = new ArrayList<>();
//        String results = "";
//            String[] params = {};
//            Object[] paramsValues = {};
//            String[] fieldsbs = {"roomid", "roomname"};
//            String wherebs = "";
//            List<Object[]> roomlist = (List<Object[]>) genericservice.fetchRecord(Floorrooms.class, fieldsbs, wherebs, params, paramsValues);
//            if (roomlist != null) {
//                Map<String, Object> rooms;
//                for (Object[] blk : roomlist) {
//                    rooms = new HashMap<>();
//
//                    rooms.put("roomid", (Integer) blk[0]);
//                    rooms.put("roomname", (String) blk[2]);
//
//                    Rooms.add(rooms);
//                }
//                model.addAttribute("roomlists", Rooms);
//            }
//        
//
//}
    //floorlist
    @RequestMapping(value = "/viewfloorlist.htm", method = RequestMethod.GET)
    public String FloorsList(Model model, HttpServletRequest request) {
        try {
            List<Map> Floorz = new ArrayList<>();

            int buildingid = Integer.parseInt(request.getParameter("buildingid"));
            String buildingname = request.getParameter("buildingname");

            model.addAttribute("buildingid", buildingid);
            model.addAttribute("buildingname", buildingname);

            String[] paramsbs = {"buildingid"};
            Object[] paramsValuesbs = {buildingid};
            String[] fieldsbs = {"floorid", "buildingid", "floorname"};
            String wherebs = "WHERE r.buildingid=:buildingid ORDER BY r.floorname ASC";
            List<Object[]> buildingfloors = (List<Object[]>) genericservice.fetchRecord(Buildingfloors.class, fieldsbs, wherebs, paramsbs, paramsValuesbs);
            if (buildingfloors != null) {
                Map<String, Object> fbuilds;
                for (Object[] blk : buildingfloors) {

                    fbuilds = new HashMap<>();
                    fbuilds.put("floorid", blk[0]);
                    fbuilds.put("buildingid", blk[1]);
                    fbuilds.put("floorname", blk[2]);
                    Floorz.add(fbuilds);
                }
                model.addAttribute("FloorsList", Floorz);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        // checking room size

        return "controlPanel/localSettingsPanel/facilityinfrastructure/views/floorlist";

    }

    //roomlist /*method for fetching buildings from the database*/
    @RequestMapping(value = "/roomlist", method = RequestMethod.GET)
    public String roomlist(HttpServletRequest request, Model model) {

        List<Map> roomlist = new ArrayList<>();
        int buildingid = Integer.parseInt(request.getParameter("buildingid"));
        model.addAttribute("buildingid", buildingid);
        String[] params1 = {"buildingid"};
        Object[] paramsValues1 = {buildingid};
        String[] fields1 = {"floorid", "buildingid", "floorname"};
        String where1 = "WHERE buildingid=:buildingid";
        List<Object[]> buldingfloors = (List<Object[]>) genericservice.fetchRecord(Buildingfloors.class, fields1, where1, params1, paramsValues1);
        if (buldingfloors != null) {
            for (Object[] floor : buldingfloors) {
                int roomCounter;
                String[] paramsf = {"floorid","archived"};
                Object[] paramsValuesf = {(Integer) floor[0],Boolean.FALSE};
                String[] fieldsf = {"roomid", "floorid", "roomname"};
                String wheref = "WHERE floorid=:floorid AND archived=:archived";

            }

            String[] fieldsf = {"roomid", "floorid", "roomname"};
               String [] params2 = {"buildingid","archived"};
              Object []  paramsValues2={buildingid,Boolean.FALSE};
            String wherer ="WHERE r.roomid IN (SELECT f.roomid FROM Floorrooms f WHERE f.floorid  IN (SELECT fb.floorid FROM Buildingfloors fb WHERE fb.buildingid=:buildingid)AND f.archived =:archived)";
            List<Object[]> rooms = (List<Object[]>) genericservice.fetchRecord(Floorrooms.class, fieldsf, wherer, params2, paramsValues2);
            if (rooms != null) {
                for (Object[] room : rooms) {
                    Map<String, Object> rm;
                    rm = new HashMap<>();
                    rm.put("roomid", room[0]);
                    rm.put("roomname", room[2]);
                    roomlist.add(rm);
                }

            }

        }

        model.addAttribute("roomlist", roomlist);

        return "controlPanel/localSettingsPanel/facilityinfrastructure/views/roomlist";
    }

    //merge room 
    @RequestMapping(value = "/mergeroom.htm", method = RequestMethod.GET)
    public String mergeRooms(HttpServletRequest request, @ModelAttribute("buildingid") String buildingid, @ModelAttribute("tableData") String floorname, String floorid, Model model) {
        List<Map> Floors = new ArrayList<>();
        String results = "";
        try {
            int buildingidz = Integer.parseInt(buildingid);
            Buildingfloors buildingDesignations = new Buildingfloors();

            String[] paramsbuilding = {"buildingid"};
            Object[] paramsValuesbuilding = {buildingidz};
            String[] fieldsbuilding = {"floorid", "buildingid", "floorname"};
            String wherebuilding = "WHERE r.buildingid=:buildingid";
            List<Object[]> building = (List<Object[]>) genericservice.fetchRecord(Buildingfloors.class, fieldsbuilding, wherebuilding, paramsbuilding, paramsValuesbuilding);

            if (building != null) {
                Map<String, Object> floors;
                for (Object[] blk : building) {
                    floors = new HashMap<>();

                    floors.put("floorid", (Integer) blk[0]);
                    floors.put("floorname", (String) blk[2]);

                    Floors.add(floors);
                }

                model.addAttribute("floorlists", Floors);

            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        return "controlPanel/localSettingsPanel/facilityinfrastructure/forms/mergeroom";

    }

    //partition room
      @RequestMapping(value = "/partitionroom.htm", method = RequestMethod.GET)
    public String partitionRooms(HttpServletRequest request, @ModelAttribute("buildingid") String buildingid, @ModelAttribute("tableData") String floorname, String floorid, Model model) {
        List<Map> Floors = new ArrayList<>();
        String results = "";
        try {
            int buildingidz = Integer.parseInt(buildingid);

            String[] paramsbuilding = {"buildingid"};
            Object[] paramsValuesbuilding = {buildingidz};
            String[] fieldsbuilding = {"floorid", "buildingid", "floorname"};
            String wherebuilding = "WHERE r.buildingid=:buildingid";
            List<Object[]> building = (List<Object[]>) genericservice.fetchRecord(Buildingfloors.class, fieldsbuilding, wherebuilding, paramsbuilding, paramsValuesbuilding);

            if (building != null) {
                Map<String, Object> floors;
                for (Object[] blk : building) {
                    floors = new HashMap<>();

                    floors.put("floorid", (Integer) blk[0]);
                    floors.put("floorname", (String) blk[2]);

                    Floors.add(floors);
                }

                model.addAttribute("floorlists", Floors);

            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        return "controlPanel/localSettingsPanel/facilityinfrastructure/forms/partitionroom";

    }

    //loadrooms
    @RequestMapping(value = "/loadrooms", method = RequestMethod.POST)
    public @ResponseBody
    String Loadrooms(HttpServletRequest request, Model model) {
        String results = "";
        try {
            List<Map> Roomz = new ArrayList<>();

            int flooridv = Integer.parseInt(request.getParameter("floorid"));
            String floorname = request.getParameter("floorname");

            model.addAttribute("floorid", flooridv);
            model.addAttribute("floorname", floorname);

            String[] paramsbs = {"floorid","archived"};
            Object[] paramsValuesbs = {flooridv,Boolean.FALSE};
            String[] fieldsbs = {"roomid", "floorid", "roomname"};
            String wherebs = "WHERE r.floorid=:floorid AND r.archived=:archived ORDER BY r.roomname ASC";
            List<Object[]> buildingfloors = (List<Object[]>) genericservice.fetchRecord(Floorrooms.class, fieldsbs, wherebs, paramsbs, paramsValuesbs);
            if (buildingfloors != null) {
                Map<String, Object> fbuilds;
                for (Object[] blk : buildingfloors) {

                    fbuilds = new HashMap<>();
                    fbuilds.put("roomid", blk[0]);
                    fbuilds.put("roomname", blk[2]);
                    fbuilds.put("floorid", blk[1]);

                    Roomz.add(fbuilds);
                }
                String existingrm = "";
                try {
                    results = new ObjectMapper().writeValueAsString(Roomz);
                } catch (JsonProcessingException ex) {
                    System.out.println(ex);
                }
                model.addAttribute("rooms", Roomz);
                model.addAttribute("existingrm", existingrm);

            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        return results;
    }

    //savemergedroom
    @RequestMapping(value = "/savemerge")
    public @ResponseBody
    String savemerge(HttpServletRequest request, Model model, @ModelAttribute("rooms") String roomsv,@ModelAttribute("roomIds") String ids) throws IOException {
        String results = "";
        Floorrooms mergedroom;
        ObjectMapper mapper = new ObjectMapper();
        List<Map> rm = (ArrayList<Map>) mapper.readValue(roomsv, List.class);
        for (Map k : rm) {
                mergedroom = new Floorrooms();
                String roomname = (String) k.get("mergedroomname");
                int floorid = Integer.parseInt(k.get("floorid").toString());
                mergedroom.setRoomname(roomname);
                mergedroom.setFloorid(floorid);
                mergedroom.setArchived(Boolean.FALSE);
                Object savedroom = genericservice.saveOrUpdateRecordLoadObject(mergedroom);
                if (savedroom != null) {
                    int roomid = mergedroom.getRoomid();

                    results = "success";
                } else {
                    results = "failed";
                }

            }
        List<Map> rmx = (ArrayList<Map>) mapper.readValue(ids, List.class);
        for(Map m : rmx){
            int roomid = Integer.parseInt(m.get("roomid").toString());
            String pk = "roomid";
            Object pkValue = roomid;
            String[] columns = {"archived","ismerged"};
            Object[] columnValues = {Boolean.TRUE,Boolean.TRUE};
            String schema = "public";
            int response = genericservice.updateRecordSQLSchemaStyle(Floorrooms.class, columns, columnValues, pk, pkValue, schema);
            if (response > 0) {
                results = "Record updated successfully";
            } else {
                results = "Failed";
            }
        
        }
      

        return results;
    }
//savepartition

    @RequestMapping(value = "/savepartition")
    public @ResponseBody
    String savepartition(HttpServletRequest request, Model model, @ModelAttribute("rooms") String roomsv,@ModelAttribute("roomIds") String ids) throws IOException {
        String results = "";
        Floorrooms partitionroom;
        ObjectMapper mapper = new ObjectMapper();
        List<Map> rm = (ArrayList<Map>) mapper.readValue(roomsv, List.class);
        for (Map k : rm) {
                partitionroom = new Floorrooms();
                String roomname = (String) k.get("roomname");
                int floorid = Integer.parseInt(k.get("floorid").toString());
                partitionroom.setRoomname(roomname);
                partitionroom.setFloorid(floorid);
                partitionroom.setArchived(Boolean.FALSE);
                Object savedroom = genericservice.saveOrUpdateRecordLoadObject(partitionroom);
                if (savedroom != null) {
                    int roomid = partitionroom.getRoomid();

                    results = "success";
                } else {
                    results = "failed";
                }

            }
        List<Map> rmx = (ArrayList<Map>) mapper.readValue(ids, List.class);
        for(Map m : rmx){
            int roomid = Integer.parseInt(m.get("roomid").toString());
            String pk = "roomid";
            Object pkValue = roomid;
            String[] columns = {"archived","ispartitioned"};
            Object[] columnValues = {Boolean.TRUE,Boolean.TRUE};
            String schema = "public";
            int response = genericservice.updateRecordSQLSchemaStyle(Floorrooms.class, columns, columnValues, pk, pkValue, schema);
            if (response > 0) {
                results = "Record updated successfully";
            } else {
                results = "Failed";
            }
        
        }
      

        return results;
    }
}
