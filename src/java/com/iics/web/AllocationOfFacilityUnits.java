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
import com.iics.assetsmanager.Facilityunitroom;
import com.iics.domain.Facilityunit;
import com.iics.service.GenericClassService;
import com.iics.store.Activitycell;
import java.io.IOException;
import java.math.BigInteger;
import java.text.DateFormat;
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

/**
 *
 * @author RESEARCH
 */
@Controller
@RequestMapping("/allocationoffacilityunits")
public class AllocationOfFacilityUnits {

    DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    @Autowired
    GenericClassService genericClassService;

    @RequestMapping(value = "/locationallocationpane", method = RequestMethod.GET)
    public String locationAllocationPane(HttpServletRequest request, Model model) {

        return "controlPanel/localSettingsPanel/locationsofresources/locationallocation/views/viewallocations";

    }

    @RequestMapping(value = "/fetchAssignedRooms", method = RequestMethod.POST)
    public String FetchAssignedRooms(HttpServletRequest request, Model model) {

        if (request.getSession().getAttribute("sessionActiveLoginFacility") != null) {
            String results = "";
            Integer facilityid = (Integer) request.getSession().getAttribute("sessionActiveLoginFacility");
            List<Map> units = new ArrayList<>();

            String[] params4 = {"facilityid"};
            Object[] paramsValues4 = {facilityid};
            String where4 = "WHERE facilityid=:facilityid";
            String[] fields4 = {"facilityunitid", "facilityunitname"};
            List<Object[]> facilityunitexternalorders = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields4, where4, params4, paramsValues4);
            if (facilityunitexternalorders != null) {
                Map<String, Object> unitz;
                for (Object[] facilityunitexternalorder : facilityunitexternalorders) {
                    unitz = new HashMap<>();

                    unitz.put("facilityunitname", facilityunitexternalorder[1]);
                    unitz.put("facilityunitid", facilityunitexternalorder[0]);

                    String[] params = {"facilityunitid"};
                    Object[] paramsValues = {(Long) facilityunitexternalorder[0]};
                    String where = "WHERE facilityunitid=:facilityunitid";
                    String[] fields = {"blockroomid", "facilityunitroomid"};
                    List<Object[]> destinationunit = (List<Object[]>) genericClassService.fetchRecord(Facilityunitroom.class, fields, where, params, paramsValues);
                    if (destinationunit != null) {
                        for (Object[] facrooms : destinationunit) {

                            String[] params1 = {"blockroomid"};
                            Object[] paramsValues1 = {(Integer) facrooms[0]};
                            String where1 = "WHERE blockroomid=:blockroomid";
                            String[] fields1 = {"blockroomid", "roomname", "blockfloorid"};
                            List<Object[]> destinationunit1 = (List<Object[]>) genericClassService.fetchRecord(Blockroom.class, fields1, where1, params1, paramsValues1);
                            if (destinationunit1 != null) {
                                for (Object[] rooms : destinationunit1) {
                                    unitz.put("blockroomid", rooms[0]);
                                    unitz.put("roomname", rooms[1]);

                                    int facilityunitroomcount = 0;
                                    String[] params10 = {"blockroomid"};
                                    Object[] paramsValues10 = {(Integer) rooms[0]};
                                    String where10 = "WHERE blockroomid=:blockroomid";
                                    facilityunitroomcount = genericClassService.fetchRecordCount(Facilityunitroom.class, where10, params10, paramsValues10);

                                    unitz.put("facilityunitroomcount", facilityunitroomcount);

                                    String[] params8 = {"blockfloorid"};
                                    Object[] paramsValues8 = {(Integer) rooms[2]};
                                    String where8 = "WHERE blockfloorid=:blockfloorid";
                                    String[] fields8 = {"blockfloorid", "floorname", "facilityblockid"};
                                    List<Object[]> blkFloor = (List<Object[]>) genericClassService.fetchRecord(Blockfloor.class, fields8, where8, params8, paramsValues8);
                                    if (blkFloor != null) {
                                        for (Object[] floors : blkFloor) {
                                            unitz.put("blockfloorid", floors[0]);
                                            unitz.put("floorname", floors[1]);

                                            String[] params6 = {"facilityblockid"};
                                            Object[] paramsValues6 = {(Integer) floors[2]};
                                            String where6 = "WHERE facilityblockid=:facilityblockid";
                                            String[] fields6 = {"facilityblockid", "blockname", "buildingid"};
                                            List<Object[]> blkRoom = (List<Object[]>) genericClassService.fetchRecord(Facilityblock.class, fields6, where6, params6, paramsValues6);
                                            if (blkRoom != null) {
                                                for (Object[] blocks : blkRoom) {
                                                    unitz.put("facilityblockid", blocks[0]);
                                                    unitz.put("blockname", blocks[1]);

                                                    String[] params9 = {"buildingid"};
                                                    Object[] paramsValues9 = {(Integer) blocks[2]};
                                                    String where9 = "WHERE buildingid=:buildingid";
                                                    String[] fields9 = {"buildingid", "buildingname"};
                                                    List<Object[]> facilityunitroom = (List<Object[]>) genericClassService.fetchRecord(Building.class, fields9, where9, params9, paramsValues9);
                                                    if (facilityunitroom != null) {
                                                        unitz.put("buildingid", facilityunitroom.get(0)[0]);
                                                        unitz.put("buildingname", facilityunitroom.get(0)[1]);
                                                    }

                                                }
                                            }

                                        }
                                    }
                                }
                            }
                        }
                    }

                    units.add(unitz);
                }
            }

//            String[] params = {"facilityid"};
//            Object[] paramsValues = {facilityid};
//            String[] fields = {"facilityunitid", "facilityunitname", "facilityid"};
//            String where = "WHERE facilityid =:facilityid ORDER BY facilityunitname";
//            List<Object[]> objUnit = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields, where, params, paramsValues);
//            if (objUnit != null) {
//                Map<String, Object> unitz;
//                for (Object[] unitobj : objUnit) {
//                    unitz = new HashMap<>();
//                    unitz.put("facilityunitid", (Long) unitobj[0]);
//                    unitz.put("facilityunitname", (String) unitobj[1]);
//                    unitz.put("facilityid", (Integer) unitobj[2]);
//
//                    String[] params2 = {"facilityunitid"};
//                    Object[] paramsValues2 = {unitobj[0]};
//                    String[] fields2 = {"facilityunitid", "blockroomid"};
//                    String where2 = "WHERE facilityunitid=:facilityunitid";
//                    List<Object[]> objUnits = (List<Object[]>) genericClassService.fetchRecord(Facilityunitroom.class, fields2, where2, params2, paramsValues2);
//                    if (objUnits != null) {
//                        for (Object[] flrs : objUnits) {
//                            System.out.println("-------------------------blockroomid" + flrs[1]);
//                            String[] paramszj = {"blockroomid", "status"};
//                            Object[] paramsValueszj = {flrs[1], Boolean.TRUE};
//                            String[] fieldszj = {"blockroomid", "blockfloorid", "roomname"};
//                            String wherezj = "WHERE blockroomid=:blockroomid AND status=:status";
//
//                            List<Object[]> rooms = (List<Object[]>) genericClassService.fetchRecord(Blockroom.class, fieldszj, wherezj, paramszj, paramsValueszj);
//                            if (rooms != null) {
//                                for (Object[] rms : rooms) {
//
//                                    unitz.put("blockroomid", (Integer) rms[0]);
//                                    unitz.put("blockfloorid", (Integer) rms[1]);
//                                    unitz.put("roomname", (String) rms[2]);
//
//                                    String[] paramszr = {"blockfloorid"};
//                                    Object[] paramsValueszr = {rms[1]};
//                                    String[] fieldszr = {"blockfloorid", "floorname", "facilityblockid"};
//                                    String wherezr = "WHERE blockfloorid=:blockfloorid";
//                                    List<Object[]> floors = (List<Object[]>) genericClassService.fetchRecord(Blockfloor.class, fieldszr, wherezr, paramszr, paramsValueszr);
//                                    if (floors != null) {
//                                        for (Object[] blks : floors) {
//
//                                            unitz.put("blockfloorid", (Integer) blks[0]);
//                                            unitz.put("floorname", (String) blks[1]);
//                                            unitz.put("facilityblockid", (Integer) blks[2]);
//
//                                            String[] paramszp = {"facilityblockid"};
//                                            Object[] paramsValueszp = {blks[2]};
//                                            String[] fieldszp = {"facilityblockid", "blockname", "buildingid"};
//                                            String wherezp = "WHERE facilityblockid=:facilityblockid";
//                                            List<Object[]> blocks = (List<Object[]>) genericClassService.fetchRecord(Facilityblock.class, fieldszp, wherezp, paramszp, paramsValueszp);
//                                            if (blocks != null) {
//                                                for (Object[] blk : blocks) {
//
//                                                    unitz.put("facilityblockid", (Integer) blk[0]);
//                                                    unitz.put("blockname", (String) blk[1]);
//                                                    unitz.put("buildingid", (Integer) blk[2]);
//
//                                                    String[] paramszz = {"buildingid"};
//                                                    Object[] paramsValueszz = {blk[2]};
//                                                    String[] fieldszz = {"buildingid", "buildingname"};
//                                                    String wherezz = "WHERE buildingid=:buildingid";
//                                                    List<Object[]> buildings = (List<Object[]>) genericClassService.fetchRecord(Building.class, fieldszz, wherezz, paramszz, paramsValueszz);
//                                                    if (buildings != null) {
//                                                        Object[] blds = buildings.get(0);
//
//                                                        unitz.put("buildingid", (Integer) blds[0]);
//                                                        unitz.put("buildingname", (String) blds[1]);
//
//                                                    }
//
//                                                }
//                                            }
//                                        }
//                                    }
//                                    String[] params3 = {"blockroomid"};
//                                    Object[] paramsValues3 = {flrs[1]};
//                                    String[] fields3 = {"blockroomid"};
//                                    String where3 = "WHERE blockroomid=:blockroomid";
//                                    List<Integer> roomCount = (List<Integer>) genericClassService.fetchRecord(Facilityunitroom.class, fields3, where3, params3, paramsValues3);
//                                    if (roomCount != null) {
//                                        unitz.put("roomCount", roomCount.size());
//
//                                    }
//                                }
//
//                            }
//                        }
//                    }
//                    units.add(unitz);
//
//                }
//            }
            System.out.println("MY FACILITY UNITS" + units);
            model.addAttribute("assignedUnitsList", units);

            return "controlPanel/localSettingsPanel/locationsofresources/locationallocation/views/viewassignedrooms";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchUnassignedRooms", method = RequestMethod.GET)
    public String FetchUnassignedRooms(HttpServletRequest request, Model model) {
        String results = "";
        if (request.getSession().getAttribute("sessionActiveLoginFacility") != null) {
            Set<String> buildingnames = new HashSet<>();
            List<Map> buildList = new ArrayList<>();
            int facilityid = (int) request.getSession().getAttribute("sessionActiveLoginFacility");

            String[] params = {"facilityid"};
            Object[] paramsValues = {facilityid};
            String[] fields = {"facilityid", "buildingid", "buildingname", "isactive"};
            String where = "WHERE facilityid=:facilityid";
            List<Object[]> Fbld = (List<Object[]>) genericClassService.fetchRecord(Building.class, fields, where, params, paramsValues);
            Map<String, Object> fbuilds;
            if (Fbld != null) {
                for (Object[] fbld : Fbld) {
                    fbuilds = new HashMap<>();
                    fbuilds.put("facilityid", (Integer) fbld[0]);
                    fbuilds.put("buildingid", (Integer) fbld[1]);
                    fbuilds.put("buildingname", (String) fbld[2]);
                    fbuilds.put("isactive", (Boolean) fbld[3]);
                    buildList.add(fbuilds);
                }
                model.addAttribute("BuildingsLists", buildList);
            }

            try {
                results = new ObjectMapper().writeValueAsString(buildingnames);
            } catch (JsonProcessingException ex) {
                Logger.getLogger(AllocationOfFacilityUnits.class.getName()).log(Level.SEVERE, null, ex);
            }
            model.addAttribute("viewBuildingLists", results);
        }
        return "controlPanel/localSettingsPanel/locationsofresources/locationallocation/views/viewunassignedrooms";

    }

    @RequestMapping(value = "/fetchUnassigned.htm", method = RequestMethod.GET)
    public String fetchUnassigned(HttpServletRequest request, Model model, @ModelAttribute("buildingid") int buildingid) throws JsonProcessingException {
        String results = "";
        List<Map> locationsList = new ArrayList<Map>();

        String[] paramszr = {"buildingid"};
        Object[] paramsValueszr = {buildingid};
        String[] fieldszr = {"facilityblockid", "buildingid", "blockname"};
        String wherezr = "WHERE buildingid=:buildingid";

        List<Object[]> blocks = (List<Object[]>) genericClassService.fetchRecord(Facilityblock.class, fieldszr, wherezr, paramszr, paramsValueszr);
        Map<String, Object> locations;

        if (blocks != null) {
            for (Object[] blks : blocks) {

                String[] paramszi = {"facilityblockid"};
                Object[] paramsValueszi = {blks[0]};
                String[] fieldszi = {"blockfloorid", "facilityblockid", "floorname"};
                String wherezi = "WHERE facilityblockid=:facilityblockid";

                List<Object[]> floors = (List<Object[]>) genericClassService.fetchRecord(Blockfloor.class, fieldszi, wherezi, paramszi, paramsValueszi);
                if (floors != null) {
                    for (Object[] flrs : floors) {
                        String[] paramszj = {"blockfloorid", "status"};
                        Object[] paramsValueszj = {flrs[0], Boolean.FALSE};
                        String[] fieldszj = {"blockroomid", "roomname"};
                        String wherezj = "WHERE blockfloorid=:blockfloorid AND status=:status";

                        List<Object[]> rooms = (List<Object[]>) genericClassService.fetchRecord(Blockroom.class, fieldszj, wherezj, paramszj, paramsValueszj);
                        if (rooms != null) {
                            for (Object[] rms : rooms) {

                                locations = new HashMap<>();

                                locations.put("blockroomid", (Integer) rms[0]);
                                locations.put("roomname", (String) rms[1]);

                                locations.put("blockfloorid", (Integer) flrs[0]);
                                locations.put("facilityblockid", (Integer) flrs[1]);
                                locations.put("floorname", (String) flrs[2]);

                                locations.put("facilityblockid", (Integer) blks[0]);
                                locations.put("buildingid", (Integer) blks[1]);
                                locations.put("blockname", (String) blks[2]);

                                locationsList.add(locations);

                            }
                        }
                    }
                    System.out.println("locationsList" + locationsList);
                    model.addAttribute("locationsList", locationsList);
                }
            }
        }
        String jsonRooms = "";
        try {
            jsonRooms = new ObjectMapper().writeValueAsString(locationsList);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }
        model.addAttribute("unassignedRoomsJSON", jsonRooms);

        return "controlPanel/localSettingsPanel/locationsofresources/locationallocation/views/viewunassignedroomstable";
    }

    @RequestMapping(value = "/fetchFacilityUnit", method = RequestMethod.GET)
    public String fetchFacilityUnit(HttpServletRequest request, Model model, @ModelAttribute("buildingid") Integer buildingid) {
        if (request.getSession().getAttribute("sessionActiveLoginFacility") != null) {
            String results = "";
            Integer facilityid = (Integer) request.getSession().getAttribute("sessionActiveLoginFacility");
            List<Map> units = new ArrayList<>();

            String[] params = {"facilityid"};
            Object[] paramsValues = {facilityid};
            String[] fields = {"facilityunitid", "facilityunitname", "facilityid"};
            String where = "WHERE facilityid =:facilityid ORDER BY facilityunitname";
            List<Object[]> objUnit = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields, where, params, paramsValues);
            if (objUnit != null) {
                Map<String, Object> unitz;
                for (Object[] unitobj : objUnit) {
                    unitz = new HashMap<>();
                    unitz.put("facilityunitid", (Long) unitobj[0]);
                    unitz.put("facilityunitname", (String) unitobj[1]);
                    unitz.put("facilityid", (Integer) unitobj[2]);
                    String[] params3 = {"facilityunitid"};
                    Object[] paramsValues3 = {unitobj[0]};
                    String where3 = "WHERE facilityunitid=:facilityunitid";
                    int roomCount = genericClassService.fetchRecordCount(Facilityunitroom.class, where3, params3, paramsValues3);
                    unitz.put("roomCount", roomCount);
                    units.add(unitz);
                    System.out.println("----------------" + roomCount);

                }
            }

            System.out.println("MY FACILITY UNITS" + units);
            model.addAttribute("unitsList", units);

            return "controlPanel/localSettingsPanel/locationsofresources/locationallocation/views/facUnitSearchResults";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/saveFacilityUnitAllocations", method = RequestMethod.POST)
    public @ResponseBody
    String saveStaffAllocations(HttpServletRequest request, Model model, @ModelAttribute("rooms") String roomsJSON, @ModelAttribute("facilityunitid") BigInteger facilityunitid) {
        if (request.getSession().getAttribute("sessionActiveLoginFacility") != null) {
            Object addedbynamed = request.getSession().getAttribute("person_id");
            Object updatedbynamed = request.getSession().getAttribute("person_id");
            Integer facilityUnit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
            try {
                List roomList = new ObjectMapper().readValue(roomsJSON, List.class);
                System.out.println("-------------------------------------roomids" + roomList);
                for (Object roomsid : roomList) {
                    Facilityunitroom unitrooms = new Facilityunitroom();
                    System.out.println("-------------------------------------roomsid" + (Integer) roomsid);
                    unitrooms.setFacilityunitid((BigInteger) facilityunitid);
                    unitrooms.setBlockroomid((Integer) roomsid);
                    unitrooms.setRoomstatus("UNASSIGNED");
                    unitrooms.setDateadded(new Date());
                    unitrooms.setDateupdated(new Date());

                    Object save = genericClassService.saveOrUpdateRecordLoadObject(unitrooms);

                    String[] columnsr = {"status", "updatedby", "dateupdated"};
                    Object[] columnValuesr = {Boolean.TRUE, (Long) updatedbynamed, new Date()};
                    String pkr = "blockroomid";
                    Object pkValuer = (Integer) roomsid;
                    genericClassService.updateRecordSQLSchemaStyle(Blockroom.class, columnsr, columnValuesr, pkr, pkValuer, "assetsmanager");
                }
                return "updated";
            } catch (IOException e) {
                System.out.println(e);
                return "failed";
            }
        }
        return "refresh";
    }

    @RequestMapping(value = "/fetchlocations.htm", method = RequestMethod.GET)
    public String fetchLocations(HttpServletRequest request, Model model, @ModelAttribute("buildingid") int buildingid, @ModelAttribute("facilityunitid") long facilityunitid) throws JsonProcessingException {
        String results = "";
        List<Map> locationLists = new ArrayList<Map>();

        String[] paramszjs = {"facilityunitid"};
        Object[] paramsValueszjs = {facilityunitid};
        String[] fieldszjs = {"blockroomid", "facilityunitid", "facilityunitroomid"};
        String wherezjs = "WHERE facilityunitid=:facilityunitid";

        List<Object[]> facilityunitrooms = (List<Object[]>) genericClassService.fetchRecord(Facilityunitroom.class, fieldszjs, wherezjs, paramszjs, paramsValueszjs);
        if (facilityunitrooms != null) {
            Map<String, Object> locations;
            for (Object[] funits : facilityunitrooms) {
                locations = new HashMap<>();
                String[] paramszi = {"blockroomid", "status"};
                Object[] paramsValueszi = {funits[0], Boolean.TRUE};
                String[] fieldszi = {"blockfloorid", "roomname", "blockroomid"};
                String wherezi = "WHERE blockroomid=:blockroomid AND status=:status";
                List<Object[]> rooms = (List<Object[]>) genericClassService.fetchRecord(Blockroom.class, fieldszi, wherezi, paramszi, paramsValueszi);
                if (rooms != null) {
                    for (Object[] rms : rooms) {
                        String[] paramszj = {"blockfloorid"};
                        Object[] paramsValueszj = {rms[0]};
                        String[] fieldszj = {"blockfloorid", "floorname", "facilityblockid"};
                        String wherezj = "WHERE blockfloorid=:blockfloorid";
                        List<Object[]> floors = (List<Object[]>) genericClassService.fetchRecord(Blockfloor.class, fieldszj, wherezj, paramszj, paramsValueszj);
                        if (floors != null) {
                            for (Object[] flrs : floors) {
                                String[] paramszr = {"buildingid", "facilityblockid"};
                                Object[] paramsValueszr = {buildingid, flrs[2]};
                                String[] fieldszr = {"facilityblockid", "buildingid", "blockname"};
                                String wherezr = "WHERE buildingid=:buildingid AND facilityblockid=:facilityblockid";
                                List<Object[]> blocks = (List<Object[]>) genericClassService.fetchRecord(Facilityblock.class, fieldszr, wherezr, paramszr, paramsValueszr);
                                if (blocks != null) {

                                    locations.put("facilityblockid", blocks.get(0)[0]);
                                    locations.put("buildingid", blocks.get(0)[1]);
                                    locations.put("blockname", blocks.get(0)[2]);

                                    locations.put("blockfloorid", (Integer) rms[0]);
                                    locations.put("roomname", (String) rms[1]);
                                    locations.put("blockroomid", (Integer) rms[2]);

                                    locations.put("blockfloorid", (Integer) flrs[0]);
                                    locations.put("floorname", (String) flrs[1]);
                                    locations.put("facilityblockid", (Integer) flrs[2]);

                                    locations.put("facilityunitid", funits[1]);
                                    locations.put("facilityunitroomid", funits[2]);

                                    locationLists.add(locations);
                                    System.out.println("-----------------------------" + locationLists);

                                }
                            }
                        }
                        model.addAttribute("locationLists", locationLists);

                    }
                }
            }

        }

        return "controlPanel/localSettingsPanel/locationsofresources/locationallocation/views/searchUnits";
    }

    @RequestMapping(value = "/deAssignLocation", method = RequestMethod.POST)
    public @ResponseBody
    String deAssignLocation(HttpServletRequest request, Model model, @ModelAttribute("rooms") String rooms, @ModelAttribute("facilityunitid") Long facilityunitid) {
        String results = "";
        try {
            Object addedbynamed = request.getSession().getAttribute("person_id");
            Object updatedbynamed = request.getSession().getAttribute("person_id");
            List<Map> roomList = new ObjectMapper().readValue(rooms, List.class);
            for (Map item : roomList) {

                Map<String, Object> map = (HashMap) item;

                Facilityunitroom unitroom = new Facilityunitroom();

                String[] columns = {"facilityunitroomid"};
                Object[] columnValues = {(Integer) map.get("facRoomId")};
                int result = genericClassService.deleteRecordByByColumns("assetsmanager.facilityunitroom", columns, columnValues);
                if (result != 0) {
                    results = "success";
                }
                String[] columnsr = {"status", "updatedby", "dateupdated"};
                Object[] columnValuesr = {Boolean.FALSE, (Long) updatedbynamed, new Date()};
                String pkr = "blockroomid";
                Object pkValuer = (Integer) map.get("roomId");
                genericClassService.updateRecordSQLSchemaStyle(Blockroom.class, columnsr, columnValuesr, pkr, pkValuer, "assetsmanager");
            }
        } catch (IOException ex) {
            return "Failed";
        }

        return results;
    }

    @RequestMapping(value = "/fetchrooms.htm", method = RequestMethod.GET)
    public String fetchRooms(HttpServletRequest request, Model model, @ModelAttribute("buildingid") int buildingid, @ModelAttribute("facilityunitid") long facilityunitid) throws JsonProcessingException {
        String results = "";
        List<Map> locationLists = new ArrayList<Map>();
        Map<String, Object> locations;

        String[] paramszjs = {"facilityunitid"};
        Object[] paramsValueszjs = {facilityunitid};
        String[] fieldszjs = {"blockroomid", "facilityunitid", "facilityunitroomid"};
        String wherezjs = "WHERE facilityunitid=:facilityunitid";

        List<Object[]> facilityunitrooms = (List<Object[]>) genericClassService.fetchRecord(Facilityunitroom.class, fieldszjs, wherezjs, paramszjs, paramsValueszjs);
        if (facilityunitrooms != null) {
            for (Object[] funits : facilityunitrooms) {

                String[] paramszi = {"blockroomid", "status"};
                Object[] paramsValueszi = {funits[0], Boolean.TRUE};
                String[] fieldszi = {"blockfloorid", "roomname", "blockroomid"};
                String wherezi = "WHERE blockroomid=:blockroomid AND status=:status";
                List<Object[]> rooms = (List<Object[]>) genericClassService.fetchRecord(Blockroom.class, fieldszi, wherezi, paramszi, paramsValueszi);
                if (rooms != null) {
                    for (Object[] rms : rooms) {
                        String[] paramszj = {"blockfloorid"};
                        Object[] paramsValueszj = {rms[0]};
                        String[] fieldszj = {"blockfloorid", "floorname", "facilityblockid"};
                        String wherezj = "WHERE blockfloorid=:blockfloorid";
                        List<Object[]> floors = (List<Object[]>) genericClassService.fetchRecord(Blockfloor.class, fieldszj, wherezj, paramszj, paramsValueszj);
                        if (floors != null) {
                            for (Object[] flrs : floors) {
                                String[] paramszr = {"buildingid", "facilityblockid"};
                                Object[] paramsValueszr = {buildingid, flrs[2]};
                                String[] fieldszr = {"facilityblockid", "buildingid", "blockname"};
                                String wherezr = "WHERE buildingid=:buildingid AND facilityblockid=:facilityblockid";
                                List<Object[]> blocks = (List<Object[]>) genericClassService.fetchRecord(Facilityblock.class, fieldszr, wherezr, paramszr, paramsValueszr);
                                if (blocks != null) {
                                    Object[] blks = blocks.get(0);

                                    locations = new HashMap<>();

                                    locations.put("blockfloorid", (Integer) rms[0]);
                                    locations.put("roomname", (String) rms[1]);
                                    locations.put("blockroomid", (Integer) rms[2]);

                                    locations.put("blockfloorid", (Integer) flrs[0]);
                                    locations.put("floorname", (String) flrs[1]);
                                    locations.put("facilityblockid", (Integer) flrs[2]);

                                    locations.put("facilityblockid", (Integer) blks[0]);
                                    locations.put("buildingid", (Integer) blks[1]);
                                    locations.put("blockname", (String) blks[2]);

                                    locations.put("facilityunitid", funits[1]);
                                    locations.put("facilityunitroomid", funits[2]);

                                    locationLists.add(locations);

                                }
                            }
                        }
                        model.addAttribute("locationLists", locationLists);
                    }
                }
            }

        }

        return "controlPanel/localSettingsPanel/locationsofresources/locationallocation/views/assignedrooms";
    }

}
