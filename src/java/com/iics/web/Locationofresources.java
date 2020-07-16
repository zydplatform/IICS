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
import com.iics.controlpanel.Buildingroom;
import com.iics.assetsmanager.Facilityblock;
import com.iics.assetsmanager.Facilitylocations;
import com.iics.domain.Contactdetails;
import com.iics.domain.Designation;
import com.iics.domain.Facility;
import com.iics.domain.Facilityunit;
import com.iics.domain.Nextofkin;
import com.iics.patient.Searchpatient;
import org.springframework.stereotype.Controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.iics.service.GenericClassService;
import com.iics.store.Facilityorder;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author RESEARCH
 */
@Controller
@RequestMapping("/locationofresources")
public class Locationofresources {

    DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    @Autowired
    GenericClassService genericClassService;

    @RequestMapping(value = "/viewbuildingsinfacility", method = RequestMethod.POST)

    public String viewBuildingsInFacility(Model model, HttpServletRequest request) {
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
                int floorsinbuilding = 0;
                int roomsinbuilding = 0;
                fbuilds = new HashMap<>();
                fbuilds.put("facilityid", (Integer) fbld[0]);
                fbuilds.put("buildingid", (Integer) fbld[1]);
                fbuilds.put("buildingname", (String) fbld[2]);
                fbuilds.put("isactive", (Boolean) fbld[3]);
                int count = genericClassService.fetchRecordCount(Facilityblock.class, "WHERE buildingid=:buildingid", new String[]{"buildingid"}, new Object[]{(Integer) fbld[1]});
                fbuilds.put("blocksize", count);

                String[] params1 = {"buildingid"};
                Object[] paramsValues1 = {(Integer) fbld[1]};
                String[] fields1 = {"facilityblockid", "buildingid", "blockname"};
                String where1 = "WHERE buildingid=:buildingid";
                List<Object[]> Fblks = (List<Object[]>) genericClassService.fetchRecord(Facilityblock.class, fields1, where1, params1, paramsValues1);
                if (Fblks != null) {
                    for (Object[] blk : Fblks) {
                        String[] paramsf = {"facilityblockid"};
                        Object[] paramsValuesf = {(Integer) blk[0]};
                        String[] fieldsf = {"blockfloorid", "facilityblockid", "floorname"};
                        String wheref = "WHERE facilityblockid=:facilityblockid";
                        List<Object[]> Fflrs = (List<Object[]>) genericClassService.fetchRecord(Blockfloor.class, fieldsf, wheref, paramsf, paramsValuesf);
                        if (Fflrs != null) {
                            for (Object[] flr : Fflrs) {
                                int roomCounter;
                                String[] paramsr = {"blockfloorid"};
                                Object[] paramsValuesr = {(Integer) flr[0]};
                                String wherer = "WHERE blockfloorid=:blockfloorid";
                                roomCounter = genericClassService.fetchRecordCount(Blockroom.class, wherer, paramsr, paramsValuesr);
                                roomsinbuilding = roomsinbuilding + roomCounter;
                            }
                        }

                    }
                    int roomCounter;
                    String wherer = "WHERE r.blockfloorid IN (SELECT f.blockfloorid FROM Blockfloor f WHERE f.facilityblockid IN (SELECT fb.facilityblockid FROM Facilityblock fb WHERE fb.buildingid=:buildingid))";
                    roomCounter = genericClassService.fetchRecordCount(Blockroom.class, wherer, params1, paramsValues1);
                    fbuilds.put("roomsinbuilding", roomCounter);

                    System.out.println("------------------------------roomCounter" + roomCounter);
                }

                int floorCounter;
                String where2 = "WHERE r.facilityblockid IN (SELECT b.facilityblockid FROM Facilityblock b WHERE b.buildingid=:buildingid)";
                floorCounter = genericClassService.fetchRecordCount(Blockfloor.class, where2, params1, paramsValues1);
                fbuilds.put("floorsinbuilding", floorCounter);

                buildList.add(fbuilds);
            }
            model.addAttribute("BuildingsLists", buildList);
        }

        //FACILITY ID AND NAME
        Facility facilityDesignations = new Facility();
        String[] paramsfacility = {"facilityid"};
        Object[] paramsValuesfacility = {facilityid};
        String[] fieldsfacility = {"facilityid", "facilityname", "facilitydomainid"};
        String wherefacility = "WHERE facilityid=:facilityid";
        List<Object[]> facility = (List<Object[]>) genericClassService.fetchRecord(Facility.class, fieldsfacility, wherefacility, paramsfacility, paramsValuesfacility);

        if (facility != null) {

            facilityDesignations.setFacilityid((Integer) facility.get(0)[0]);
            facilityDesignations.setFacilityname((String) facility.get(0)[1]);

            model.addAttribute("FacilityListed", facilityDesignations);

        }

        return "controlPanel/localSettingsPanel/locationsofresources/locationsetup/views/facilityblocktable";
    }

    @RequestMapping(value = "/viewBlocks", method = RequestMethod.GET)
    public String viewBlocks(HttpServletRequest request, Model model) {

        List<Facilityblock> FBlks = new ArrayList<>();

        int buildingid = Integer.parseInt(request.getParameter("buildingId"));
        String buildingName = request.getParameter("buildingname");

        model.addAttribute("buildingidz", buildingid);
        model.addAttribute("buildingnamez", buildingName);

        String[] paramszrrp = {"buildingid"};
        Object[] paramsValueszrrp = {buildingid};
        String[] fieldszrrp = {"facilityblockid", "buildingid", "blockname", "status"};
        String wherezrrp = "WHERE r.buildingid=:buildingid ORDER BY r.blockname ASC";

        List<Object[]> vblks = (List<Object[]>) genericClassService.fetchRecord(Facilityblock.class, fieldszrrp, wherezrrp, paramszrrp, paramsValueszrrp);

        if (vblks != null) {
            for (Object[] dp : vblks) {
                Facilityblock fblk = new Facilityblock();
                fblk.setFacilityblockid((Integer) dp[0]);
                fblk.setBuildingid((Integer) dp[1]);
                fblk.setBlockname((String) dp[2]);
                fblk.setStatus((Boolean) dp[3]);
                FBlks.add(fblk);
            }
        }
        model.addAttribute("viewBlocksInFacility", FBlks);

        return "controlPanel/localSettingsPanel/locationsofresources/locationsetup/views/viewblocksinbuilding";
    }

    @RequestMapping(value = "/viewfacblockfloors", method = RequestMethod.GET)
    public String viewFacBlockFloors(Model model, HttpServletRequest request) {
        List<Map> blockFloorz = new ArrayList<>();
        List<Map> Floorz = new ArrayList<>();

        int buildingid = Integer.parseInt(request.getParameter("buildingId"));
        String buildingname = request.getParameter("buildingname");

        model.addAttribute("buildingid", buildingid);
        model.addAttribute("buildingname", buildingname);

        String[] paramsbs = {"buildingid"};
        Object[] paramsValuesbs = {buildingid};
        String[] fieldsbs = {"facilityblockid", "buildingid", "blockname"};
        String wherebs = "WHERE buildingid=:buildingid";
        List<Object[]> Fblkbs = (List<Object[]>) genericClassService.fetchRecord(Facilityblock.class, fieldsbs, wherebs, paramsbs, paramsValuesbs);
        if (Fblkbs != null) {
            Map<String, Object> floors;
            for (Object[] blk : Fblkbs) {
                floors = new HashMap<>();

                floors.put("facilityblockid", (Integer) blk[0]);
                floors.put("blockname", (String) blk[2]);

                Floorz.add(floors);
            }
            model.addAttribute("viewFloorsList", Floorz);
        }
        String[] floorFields = {"blockfloorid", "facilityblockid", "floorname"};
        String whereFloor = "WHERE r.facilityblockid IN (SELECT b.facilityblockid FROM Facilityblock b WHERE b.buildingid=:buildingid)";
        List<Object[]> FflrsArr = (List<Object[]>) genericClassService.fetchRecord(Blockfloor.class, floorFields, whereFloor, paramsbs, paramsValuesbs);
        if (FflrsArr != null) {
            Map<String, Object> bfloors;
            for (Object[] floor : FflrsArr) {
                bfloors = new HashMap<>();
                bfloors.put("floorname", floor[2]);
                blockFloorz.add(bfloors);
            }
            model.addAttribute("viewBlockFloorsList", blockFloorz);
        }
        return "controlPanel/localSettingsPanel/locationsofresources/locationsetup/views/viewfloorsinblock";

    }

    @RequestMapping(value = "/viewfloors", method = RequestMethod.GET)
    public String viewFloors(Model model, HttpServletRequest request) {

        List<Map> blockFloor = new ArrayList<>();

        int buildingid = Integer.parseInt(request.getParameter("buildingId"));
        String buildingName = request.getParameter("buildingname");

        model.addAttribute("buildingidz", buildingid);
        model.addAttribute("buildingnamez", buildingName);

        int facilityblockid = Integer.parseInt(request.getParameter("facilityblockid"));
        System.out.println("--------------------------facilityblockid------------" + facilityblockid);

        if (facilityblockid != 0) {
            String[] paramszrrp = {"facilityblockid"};
            Object[] paramsValueszrrp = {facilityblockid};
            String[] fieldszrrp = {"blockfloorid", "facilityblockid", "floorname"};
            String wherezrrp = "WHERE facilityblockid=:facilityblockid ORDER BY floorname ASC";
            List<Object[]> floors = (List<Object[]>) genericClassService.fetchRecord(Blockfloor.class, fieldszrrp, wherezrrp, paramszrrp, paramsValueszrrp);
            if (floors != null) {
                Map<String, Object> floorz;
                for (Object[] dp : floors) {
                    floorz = new HashMap<>();
                    floorz.put("blockfloorid", (Integer) dp[0]);
                    floorz.put("floorname", (String) dp[2]);

                    blockFloor.add(floorz);
                }
            }
            model.addAttribute("viewFloorsLists", blockFloor);
        } else {
            String[] paramsbs = {"buildingid"};
            Object[] paramsValuesbs = {buildingid};
            String[] floorFields = {"blockfloorid", "facilityblockid", "floorname"};
            String whereFloor = "WHERE r.facilityblockid IN (SELECT b.facilityblockid FROM Facilityblock b WHERE b.buildingid=:buildingid)";
            List<Object[]> FflrsArr = (List<Object[]>) genericClassService.fetchRecord(Blockfloor.class, floorFields, whereFloor, paramsbs, paramsValuesbs);
            if (FflrsArr != null) {
                Map<String, Object> bfloors;
                for (Object[] floor : FflrsArr) {
                    bfloors = new HashMap<>();
                    bfloors.put("floorname", floor[2]);
                    blockFloor.add(bfloors);
                }
                model.addAttribute("viewFloorsLists", blockFloor);
            }
        }
        return "controlPanel/localSettingsPanel/locationsofresources/locationsetup/views/blockfloors";
    }

    @RequestMapping(value = "/managebuilding", method = RequestMethod.GET)
    public String manageBuilding(HttpServletRequest request, Model model) {

        int facilityid = (int) request.getSession().getAttribute("sessionActiveLoginFacility");
        List<Facility> facilityList = new ArrayList<>();

        //Fetching Facility
        Facility facilityDesignations = new Facility();
        String[] paramsfacility = {"facilityid"};
        Object[] paramsValuesfacility = {facilityid};
        String[] fieldsfacility = {"facilityid", "facilityname", "facilitydomainid"};
        String wherefacility = "WHERE facilityid=:facilityid";
        List<Object[]> facility = (List<Object[]>) genericClassService.fetchRecord(Facility.class, fieldsfacility, wherefacility, paramsfacility, paramsValuesfacility);

        if (facility != null) {

            facilityDesignations.setFacilityid((Integer) facility.get(0)[0]);
            facilityDesignations.setFacilityname((String) facility.get(0)[1]);

            model.addAttribute("FacilityLists", facilityDesignations);
        }

        return "controlPanel/localSettingsPanel/locationsofresources/locationsetup/views/viewlocationofresources";

    }

    @RequestMapping(value = "/addbuildingtoFac", method = RequestMethod.GET)
    public final ModelAndView AddBuildingToFac(HttpServletRequest request) {

        Map<String, Object> model = new HashMap<String, Object>();
        int facilityid = (int) request.getSession().getAttribute("sessionActiveLoginFacility");;
        List<Facility> facilityList = new ArrayList<>();

        return new ModelAndView("controlPanel/localSettingsPanel/locationsofresources/locationsetup/forms/addfacilitybuilding", "model", model);

    }

    @RequestMapping(value = "/addblock", method = RequestMethod.POST)
    public String AddBlock(HttpServletRequest request, Model model) {
        int facilityid = (int) request.getSession().getAttribute("sessionActiveLoginFacility");
        List<Building> buildList = new ArrayList<>();

        try {
            List<Integer> item = (ArrayList) new ObjectMapper().readValue(request.getParameter("res"), List.class);

            for (Integer item1 : item) {
                String[] params = {"facilityid", "buildingid"};
                Object[] paramsValues = {facilityid, item1};
                String[] fields = {"facilityid", "buildingid", "buildingname", "isactive"};
                String where = "WHERE facilityid=:facilityid AND buildingid=:buildingid ORDER BY buildingname";
                List<Object[]> Fbld = (List<Object[]>) genericClassService.fetchRecord(Building.class, fields, where, params, paramsValues);
                if (Fbld != null) {
                    Object[] fbld = Fbld.get(0);
                    Building fbuilds = new Building();
                    fbuilds.setFacilityid((Integer) fbld[0]);
                    fbuilds.setBuildingid((Integer) fbld[1]);
                    fbuilds.setBuildingname((String) fbld[2]);
                    fbuilds.setIsactive((Boolean) fbld[3]);
                    buildList.add(fbuilds);
                }
            }

        } catch (Exception e) {
        }
        model.addAttribute("BuildingsListsz", buildList);
        return "controlPanel/localSettingsPanel/locationsofresources/locationsetup/forms/addfacilityblk";
    }

    @RequestMapping(value = "/addotherblock", method = RequestMethod.GET)
    public String AddOtherBlock(HttpServletRequest request, @ModelAttribute("tablerowid") int tablerowid, @ModelAttribute("tableData") String tableData, Model model) {

        model.addAttribute("buildingname", request.getParameter("tableData"));
        model.addAttribute("buildingid", request.getParameter("tablerowid"));

        return "controlPanel/localSettingsPanel/locationsofresources/locationsetup/forms/addotherblocks";

    }

    @RequestMapping(value = "/addtheroom.htm", method = RequestMethod.GET)

    public String AddTheRoom(HttpServletRequest request, @ModelAttribute("tablerowid") int tablerowid, @ModelAttribute("tableData") String tableData, Model model) {
        String results = "";

        int buildingid = Integer.parseInt(request.getParameter("a"));
        String buildingname = request.getParameter("b");

        model.addAttribute("blockname", request.getParameter("tableData"));
        model.addAttribute("blockid", request.getParameter("tablerowid"));

        model.addAttribute("buildingid", buildingid);
        model.addAttribute("buildingname", buildingname);

        return "controlPanel/localSettingsPanel/locationsofresources/locationsetup/forms/addfloor";

    }

    @RequestMapping(value = "/addtherooms.htm", method = RequestMethod.GET)
    public String AddTheRooms(HttpServletRequest request, @ModelAttribute("tablerowid") int buildingid, @ModelAttribute("tableData") String buildingname, Model model) {
        List<Map> Blocks = new ArrayList<>();
        model.addAttribute("buildingid", buildingid);
        model.addAttribute("buildingname", buildingname);

        String[] paramsbs = {"buildingid"};
        Object[] paramsValuesbs = {buildingid};
        String[] fieldsbs = {"facilityblockid", "buildingid", "blockname"};
        String wherebs = "WHERE buildingid=:buildingid";
        List<Object[]> Fblkbs = (List<Object[]>) genericClassService.fetchRecord(Facilityblock.class, fieldsbs, wherebs, paramsbs, paramsValuesbs);
        if (Fblkbs != null) {
            Map<String, Object> blocks;
            for (Object[] blk : Fblkbs) {
                blocks = new HashMap<>();

                blocks.put("facilityblockid", (Integer) blk[0]);
                blocks.put("blockname", (String) blk[2]);

                Blocks.add(blocks);
            }
            model.addAttribute("BlockList", Blocks);
        }

        return "controlPanel/localSettingsPanel/locationsofresources/locationsetup/forms/addotherrooms";
    }

    @RequestMapping(value = "/floorsInBlock", method = RequestMethod.GET)
    public @ResponseBody
    String floorsInBlock(HttpServletRequest request, Model model, @ModelAttribute("facilityblockid") Integer facilityblockid) {
        String jsondata = "";
        List<Map> floors = new ArrayList<>();
        List<Map> Flr = new ArrayList<>();

        String[] params = {"facilityblockid"};
        Object[] paramsValues = {facilityblockid};
        String[] fields = {"blockfloorid", "floorname"};
        String where = "WHERE facilityblockid=:facilityblockid ORDER BY floorname ASC";
        List<Object[]> floorSelect = (List<Object[]>) genericClassService.fetchRecord(Blockfloor.class, fields, where, params, paramsValues);
        Map<String, Object> flrs;
        if (floorSelect != null) {
            flrs = new HashMap<>();
            flrs.put("blockfloorid", (Integer) floorSelect.get(0)[0]);
            flrs.put("floorname", (String) floorSelect.get(0)[1]);
            floors.add(flrs);
        }
        try {
            jsondata = new ObjectMapper().writeValueAsString(floors);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }

        return jsondata;
    }

    @RequestMapping(value = "/addtheblock.htm", method = RequestMethod.GET)
    public String AddTheBlock(HttpServletRequest request, Model model) {

        model.addAttribute("buildingnamed", request.getParameter("buildingName"));
        model.addAttribute("buildingided", request.getParameter("buildingId"));

        return "controlPanel/localSettingsPanel/locationsofresources/locationsetup/forms/newblock";

    }

    @RequestMapping(value = "/addfloors.htm", method = RequestMethod.GET)
    public String AddFloors(HttpServletRequest request, @ModelAttribute("tablerowid") int buildingid, @ModelAttribute("tableData") String buildingname, Model model) {
        List<Map> Blocks = new ArrayList<>();
        String results = "";

        model.addAttribute("buildingname", buildingname);
        model.addAttribute("buildingid", buildingid);

        String[] paramsbs = {"buildingid"};
        Object[] paramsValuesbs = {buildingid};
        String[] fieldsbs = {"facilityblockid", "buildingid", "blockname"};
        String wherebs = "WHERE buildingid=:buildingid";
        List<Object[]> Fblkbs = (List<Object[]>) genericClassService.fetchRecord(Facilityblock.class, fieldsbs, wherebs, paramsbs, paramsValuesbs);
        if (Fblkbs != null) {
            Map<String, Object> blocks;
            for (Object[] blk : Fblkbs) {
                blocks = new HashMap<>();

                blocks.put("facilityblockid", (Integer) blk[0]);
                blocks.put("blockname", (String) blk[2]);

                Blocks.add(blocks);
            }
            model.addAttribute("BlockLists", Blocks);
        }

        return "controlPanel/localSettingsPanel/locationsofresources/locationsetup/forms/addnewfloor";

    }

//    @RequestMapping(value = "/addnewrooms.htm", method = RequestMethod.GET)
//    public String AddNewRooms(HttpServletRequest request, Model model) {
//
//        model.addAttribute("blockfloorid", request.getParameter("tablerowid"));
//        model.addAttribute("floorname", request.getParameter("tableData"));
//        model.addAttribute("facilityblockid", request.getParameter("a"));
//        model.addAttribute("blockname", request.getParameter("b"));
//        model.addAttribute("buildingid", request.getParameter("c"));
//        model.addAttribute("buildingname", request.getParameter("d"));
//
//        return "controlPanel/localSettingsPanel/locationsofresources/locationsetup/forms/addnewroom";
//
//    }
    @RequestMapping(value = "/addnewrooms.htm", method = RequestMethod.POST)
    public String AddNewRooms(HttpServletRequest request, Model model, @ModelAttribute("res") String response) {

        List<Blockfloor> floorList = new ArrayList<>();

        try {
            List<Integer> flooritem = (ArrayList) new ObjectMapper().readValue(response, List.class);

            for (Integer flooritems : flooritem) {
                String[] params = {"blockfloorid", "isactive"};
                Object[] paramsValues = {flooritems, Boolean.TRUE};
                String[] fields = {"blockfloorid", "floorname", "isactive"};
                String where = "WHERE blockfloorid=:blockfloorid AND isactive=:isactive ORDER BY floorname";
                List<Object[]> floorrm = (List<Object[]>) genericClassService.fetchRecord(Blockfloor.class, fields, where, params, paramsValues);
                if (floorrm != null) {
                    Object[] f = floorrm.get(0);
                    Blockfloor floors = new Blockfloor();
                    floors.setBlockfloorid((Integer) f[0]);
                    floors.setFloorname((String) f[1]);
                    floors.setIsactive((Boolean) f[2]);
                    floorList.add(floors);
                }
            }

        } catch (Exception e) {
        }
        model.addAttribute("BlockFloorLists", floorList);
        return "controlPanel/localSettingsPanel/locationsofresources/locationsetup/forms/addnewroom";

    }

    @RequestMapping(value = "/addroomtofloor.htm", method = RequestMethod.POST)
    public String AddRoomToFloor(HttpServletRequest request, Model model, @ModelAttribute("res") String response) {

        List<Blockfloor> floorList = new ArrayList<>();
        model.addAttribute("facilityblockid", request.getParameter("facilityblockid"));
        model.addAttribute("blockname", request.getParameter("blockname"));

        try {
            List<Integer> flooritem = (ArrayList) new ObjectMapper().readValue(response, List.class);

            for (Integer flooritems : flooritem) {
                String[] params = {"blockfloorid", "isactive"};
                Object[] paramsValues = {flooritems, Boolean.TRUE};
                String[] fields = {"blockfloorid", "floorname", "isactive"};
                String where = "WHERE blockfloorid=:blockfloorid AND isactive=:isactive ORDER BY floorname";
                List<Object[]> floorrm = (List<Object[]>) genericClassService.fetchRecord(Blockfloor.class, fields, where, params, paramsValues);
                if (floorrm != null) {
                    Object[] f = floorrm.get(0);
                    Blockfloor floors = new Blockfloor();
                    floors.setBlockfloorid((Integer) f[0]);
                    floors.setFloorname((String) f[1]);
                    floors.setIsactive((Boolean) f[2]);
                    floorList.add(floors);
                }
            }

        } catch (Exception e) {
        }
        model.addAttribute("BlockFloorList", floorList);
        return "controlPanel/localSettingsPanel/locationsofresources/locationsetup/forms/roomtofloor";

    }

    @RequestMapping(value = "/activateDeactivateblock", method = RequestMethod.GET)
    public String activateDeactivateblock(HttpServletRequest request, Model model, @ModelAttribute("status") boolean status, @ModelAttribute("facilityblockid") int facilityblockid) {

        String[] columnslev = {"status"};
        Object[] columnValueslev = {status};
        String levelPrimaryKey = "facilityblockid";
        Object levelPkValue = facilityblockid;
        genericClassService.updateRecordSQLSchemaStyle(Facilityblock.class, columnslev, columnValueslev, levelPrimaryKey, levelPkValue, "assetsmanager");
        return "";
    }

    @RequestMapping(value = "/checkfacilitybuildingname.htm")
    public @ResponseBody
    String checkFacilityBuildingName(HttpServletRequest request) {
        int facilityid = (int) request.getSession().getAttribute("sessionActiveLoginFacility");
        String results = "";

        String[] params = {"facilityid", "value"};
        Object[] paramsValues = {facilityid, request.getParameter("buildingname").trim().toLowerCase()};
        String[] fields = {"buildingname"};
        String where = "WHERE facilityid=:facilityid AND  (LOWER(buildingname) =:value) ORDER BY buildingname";
        List<Object[]> classficationList = (List<Object[]>) genericClassService.fetchRecord(Building.class, fields, where, params, paramsValues);
        if (classficationList != null) {
            results = "existing";
        } else {
            results = "notexisting";
        }

        return results;
    }

    @RequestMapping(value = "/checkBlockNames.htm")
    public @ResponseBody
    String checkBlockNames(HttpServletRequest request) {
        String results = "";

        String[] params = {"buildingid", "value"};
        Object[] paramsValues = {Integer.parseInt(request.getParameter("buildingid")), request.getParameter("blockname")};
        String[] fields = {"blockname"};
        String where = "WHERE buildingid=:buildingid AND  (LOWER(blockname) =:value) ORDER BY blockname";
        List<Object[]> blockList = (List<Object[]>) genericClassService.fetchRecord(Facilityblock.class, fields, where, params, paramsValues);
        if (blockList != null) {
            results = "existing";
        } else {
            results = "notexisting";
        }

        return results;
    }

    @RequestMapping(value = "/checkEditedFloorNames.htm")
    public @ResponseBody
    String checkEditedFloorNames(HttpServletRequest request) {
        String results = "";

        String[] params = {"facilityblockid", "value"};
        Object[] paramsValues = {Integer.parseInt(request.getParameter("blockid")), request.getParameter("floorname")};
        String[] fields = {"floorname"};
        String where = "WHERE facilityblockid=:facilityblockid AND  (LOWER(floorname) =:value) ORDER BY floorname";
        List<Object[]> floorList = (List<Object[]>) genericClassService.fetchRecord(Blockfloor.class, fields, where, params, paramsValues);
        if (floorList != null) {
            results = "existing";
        } else {
            results = "notexisting";
        }

        return results;
    }

    @RequestMapping(value = "/checkEditedRoomNames.htm")
    public @ResponseBody
    String checkEditedRoomNames(HttpServletRequest request) {
        String results = "";

        String[] params = {"blockfloorid", "value"};
        Object[] paramsValues = {Integer.parseInt(request.getParameter("floorid")), request.getParameter("roomname")};
        String[] fields = {"roomname"};
        String where = "WHERE blockfloorid=:blockfloorid AND  (LOWER(roomname) =:value) ORDER BY roomname";
        List<Object[]> classficationList = (List<Object[]>) genericClassService.fetchRecord(Blockroom.class, fields, where, params, paramsValues);
        if (classficationList != null) {
            results = "existing";
        } else {
            results = "notexisting";
        }

        return results;
    }

    @RequestMapping(value = "/checkbuildingblockname.htm")
    public @ResponseBody
    String checkBuildingBlockName(HttpServletRequest request, @ModelAttribute("a") int buildingid, @ModelAttribute("b") String buildingname, Model model) {
        String results = "";
        Set<String> blocknames = new HashSet<>();
        List<Facilityblock> FBlks = new ArrayList<>();

        String[] paramszrrp = {"buildingid"};
        Object[] paramsValueszrrp = {buildingid};
        String[] fieldszrrp = {"facilityblockid", "buildingid", "blockname", "status"};
        String wherezrrp = "WHERE r.buildingid=:buildingid ORDER BY r.blockname ASC";

        List<Object[]> vblks = (List<Object[]>) genericClassService.fetchRecord(Facilityblock.class, fieldszrrp, wherezrrp, paramszrrp, paramsValueszrrp);

        if (vblks != null) {
            for (Object[] dp : vblks) {
                Facilityblock fblk = new Facilityblock();
                fblk.setFacilityblockid((Integer) dp[0]);
                fblk.setBuildingid((Integer) dp[1]);
                fblk.setBlockname((String) dp[2]);
                fblk.setStatus((Boolean) dp[3]);
                FBlks.add(fblk);
                blocknames.add(fblk.getBlockname());
            }
        }
        model.addAttribute("viewBlocksInFacility", FBlks);

        try {
            results = new ObjectMapper().writeValueAsString(blocknames);
        } catch (JsonProcessingException ex) {
            Logger.getLogger(Locationofresources.class.getName()).log(Level.SEVERE, null, ex);
        }
        model.addAttribute("viewBlockLists", results);
        return results;
    }

    @RequestMapping(value = "/checkblockfloorname.htm")
    public @ResponseBody
    String checkBlockFloorName(HttpServletRequest request, @ModelAttribute("tablerowid") int tablerowid, @ModelAttribute("tableData") String tableData, @ModelAttribute("a") int buildingid, @ModelAttribute("b") String buildingname, Model model) throws IOException {
        String results = "";
        Set<String> floornames = new HashSet<>();
        List<Blockfloor> blockFloorz = new ArrayList<>();

        String[] paramszrrp = {"facilityblockid", "isactive"};
        Object[] paramsValueszrrp = {tablerowid, true};
        String[] fieldszrrp = {"blockfloorid", "facilityblockid", "floorname", "isactive"};
        String wherezrrp = "WHERE r.facilityblockid=:facilityblockid AND r.isactive=:isactive ORDER BY r.floorname ASC";

        List<Object[]> floors = (List<Object[]>) genericClassService.fetchRecord(Blockfloor.class, fieldszrrp, wherezrrp, paramszrrp, paramsValueszrrp);

        if (floors != null) {
            for (Object[] dp : floors) {
                Blockfloor floorz = new Blockfloor();
                floorz.setBlockfloorid((Integer) dp[0]);
                floorz.setFacilityblockid((Integer) dp[1]);
                floorz.setFloorname((String) dp[2]);
                floorz.setIsactive((Boolean) dp[3]);
                blockFloorz.add(floorz);
                floornames.add(floorz.getFloorname());
            }
        }
        model.addAttribute("viewFloorsList", blockFloorz);
        try {
            results = new ObjectMapper().writeValueAsString(floornames);
        } catch (JsonProcessingException ex) {
            Logger.getLogger(Locationofresources.class.getName()).log(Level.SEVERE, null, ex);
        }
        model.addAttribute("viewFloorsLists", results);
        return results;
    }

    @RequestMapping(value = "/checkfloornames.htm")
    public @ResponseBody
    String checkfloornames(HttpServletRequest request, @ModelAttribute("tablerowid") int tablerowid, @ModelAttribute("tableData") String tableData, Model model) throws IOException {
        String results = "";
        Set<String> floornames = new HashSet<>();
        List<Blockfloor> blockFloorz = new ArrayList<>();

        String[] paramszrrp = {"facilityblockid"};
        Object[] paramsValueszrrp = {tablerowid};
        String[] fieldszrrp = {"blockfloorid", "facilityblockid", "floorname", "isactive"};
        String wherezrrp = "WHERE r.facilityblockid=:facilityblockid ORDER BY r.floorname ASC";

        List<Object[]> floors = (List<Object[]>) genericClassService.fetchRecord(Blockfloor.class, fieldszrrp, wherezrrp, paramszrrp, paramsValueszrrp);

        if (floors != null) {
            for (Object[] dp : floors) {
                Blockfloor floorz = new Blockfloor();
                floorz.setBlockfloorid((Integer) dp[0]);
                floorz.setFacilityblockid((Integer) dp[1]);
                floorz.setFloorname((String) dp[2]);
                floorz.setIsactive((Boolean) dp[3]);
                blockFloorz.add(floorz);
                floornames.add(floorz.getFloorname());
            }
        }
        model.addAttribute("viewFloors", blockFloorz);
        try {
            results = new ObjectMapper().writeValueAsString(floornames);
        } catch (JsonProcessingException ex) {
            Logger.getLogger(Locationofresources.class.getName()).log(Level.SEVERE, null, ex);
        }
        model.addAttribute("viewFloorList", results);
        return results;
    }

    @RequestMapping(value = "/checkfloorroomname.htm")
    public @ResponseBody
    String checkfloorroomname(HttpServletRequest request, @ModelAttribute("blockfloorid") int blockfloorid, @ModelAttribute("floorname") String floorname, @ModelAttribute("facilityblockid") int facilityblockid, @ModelAttribute("blockname") String blockname, Model model) throws IOException {
        String results = "";
        Set<String> floornames = new HashSet<>();
        List<Blockroom> blockRoomz = new ArrayList<>();

        String[] paramszrrp = {"blockfloorid", "status"};
        Object[] paramsValueszrrp = {blockfloorid, true};
        String[] fieldszrrp = {"blockroomid", "blockfloorid", "roomname", "description", "status", "roomstatus"};
        String wherezrrp = "WHERE r.blockfloorid=:blockfloorid AND r.status=:status ORDER BY r.roomname ASC";

        List<Object[]> blkrmz = (List<Object[]>) genericClassService.fetchRecord(Blockroom.class, fieldszrrp, wherezrrp, paramszrrp, paramsValueszrrp);

        if (blkrmz != null) {
            for (Object[] dp : blkrmz) {
                Blockroom rooms = new Blockroom();
                rooms.setBlockroomid((Integer) dp[0]);
                rooms.setBlockfloorid((Integer) dp[1]);
                rooms.setRoomname((String) dp[2]);
                rooms.setDescription((String) dp[3]);
                rooms.setStatus((Boolean) dp[4]);
                rooms.setRoomstatus((Boolean) dp[5]);
                blockRoomz.add(rooms);
            }
        }
        model.addAttribute("viewBlockRoomsList", blockRoomz);
        try {
            results = new ObjectMapper().writeValueAsString(floornames);
        } catch (JsonProcessingException ex) {
            Logger.getLogger(Locationofresources.class.getName()).log(Level.SEVERE, null, ex);
        }
        model.addAttribute("viewRoomsLists", results);
        return results;
    }

    @RequestMapping(value = "/checkroomname.htm")
    public @ResponseBody
    String checkroomname(HttpServletRequest request, @ModelAttribute("blockfloorid") int blockfloorid, @ModelAttribute("roomname") String rooms, Model model) throws IOException {
        String results = "";
        Set<String> floornames = new HashSet<>();
        List<Blockroom> blockRoomz = new ArrayList<>();

        int facilityid = (int) request.getSession().getAttribute("sessionActiveLoginFacility");
        List<Map> roomsList = new ObjectMapper().readValue(rooms, List.class);
        for (Map item : roomsList) {
            Map<String, Object> map = (HashMap) item;

            String[] paramszrrp = {"blockfloorid", "roomname"};
            Object[] paramsValueszrrp = {blockfloorid, (String) map.get("roomnames")};
            String[] fieldszrrp = {"blockroomid", "blockfloorid", "roomname", "description", "status", "roomstatus"};
            String wherezrrp = "WHERE r.blockfloorid=:blockfloorid AND r.roomname=:roomname ORDER BY r.roomname ASC";

            List<Object[]> blkrmz = (List<Object[]>) genericClassService.fetchRecord(Blockroom.class, fieldszrrp, wherezrrp, paramszrrp, paramsValueszrrp);

            if (blkrmz != null) {
                for (Object[] dp : blkrmz) {
                    Blockroom room = new Blockroom();
                    room.setBlockroomid((Integer) dp[0]);
                    room.setBlockfloorid((Integer) dp[1]);
                    room.setRoomname((String) dp[2]);
                    room.setDescription((String) dp[3]);
                    room.setStatus((Boolean) dp[4]);
                    room.setRoomstatus((Boolean) dp[5]);
                    blockRoomz.add(room);
                }
            }
            model.addAttribute("viewBlockRoomsList", blockRoomz);
        }

        try {
            results = new ObjectMapper().writeValueAsString(floornames);
        } catch (JsonProcessingException ex) {
            Logger.getLogger(Locationofresources.class.getName()).log(Level.SEVERE, null, ex);
        }
        model.addAttribute("viewRoomsLists", results);
        return results;
    }

    @RequestMapping(value = "/viewBlockRooms", method = RequestMethod.GET)
    public String viewBlockRooms(Model model, HttpServletRequest request) {

        List<Map> blockRoom = new ArrayList<>();
        int buildingid = Integer.parseInt(request.getParameter("buildingId"));
        String buildingName = request.getParameter("buildingname");
        int facilityblockid = Integer.parseInt(request.getParameter("facilityblockid"));
        System.out.println("--------------------------facilityblockid------------" + facilityblockid);

        if (facilityblockid != 0) {
            String[] paramszrrp = {"facilityblockid"};
            Object[] paramsValueszrrp = {facilityblockid};
            String[] fieldszrrp = {"blockroomid", "roomname"};
            String wherezrrp = "WHERE r.blockfloorid IN (SELECT b.blockfloorid FROM Blockfloor b WHERE b.facilityblockid=:facilityblockid)";
            List<Object[]> rooms = (List<Object[]>) genericClassService.fetchRecord(Blockroom.class, fieldszrrp, wherezrrp, paramszrrp, paramsValueszrrp);
            if (rooms != null) {
                Map<String, Object> roomz;
                for (Object[] dp : rooms) {
                    roomz = new HashMap<>();
                    roomz.put("blockroomid", (Integer) dp[0]);
                    roomz.put("roomname", (String) dp[1]);

                    blockRoom.add(roomz);
                }
                model.addAttribute("viewRoomLists", blockRoom);
            }

        } else {
            String[] paramsbs = {"buildingid"};
            Object[] paramsValuesbs = {buildingid};
            String[] floorFields = {"blockfloorid", "facilityblockid", "floorname"};
            String whereFloor = "WHERE r.blockfloorid IN (SELECT f.blockfloorid FROM Blockfloor f WHERE f.facilityblockid IN (SELECT fb.facilityblockid FROM Facilityblock fb WHERE fb.buildingid=:buildingid))";
            List<Object[]> FflrsArr = (List<Object[]>) genericClassService.fetchRecord(Blockfloor.class, floorFields, whereFloor, paramsbs, paramsValuesbs);
            if (FflrsArr != null) {
                Map<String, Object> bfloors;
                for (Object[] floor : FflrsArr) {
                    bfloors = new HashMap<>();
                    bfloors.put("floorname", floor[2]);
                    blockRoom.add(bfloors);
                }
                model.addAttribute("viewRoomLists", blockRoom);
            }
        }
        return "controlPanel/localSettingsPanel/locationsofresources/locationsetup/views/blockrooms";
    }

    @RequestMapping(value = "/viewFlrRooms", method = RequestMethod.GET)
    public String viewFlrRooms(Model model, HttpServletRequest request) {

        List<Map> blockRoom = new ArrayList<>();
        int buildingid = Integer.parseInt(request.getParameter("buildingId"));
        String buildingName = request.getParameter("buildingname");
        int blockfloorid = Integer.parseInt(request.getParameter("blockfloorid"));
        System.out.println("--------------------------blockfloorid------------" + blockfloorid);

        if (blockfloorid != 0) {
            String[] paramszrrp = {"blockfloorid"};
            Object[] paramsValueszrrp = {blockfloorid};
            String[] fieldszrrp = {"blockroomid", "roomname"};
            String wherezrrp = "WHERE blockfloorid=:blockfloorid";
            List<Object[]> rooms = (List<Object[]>) genericClassService.fetchRecord(Blockroom.class, fieldszrrp, wherezrrp, paramszrrp, paramsValueszrrp);
            if (rooms != null) {
                Map<String, Object> roomz;
                for (Object[] dp : rooms) {
                    roomz = new HashMap<>();
                    roomz.put("blockroomid", (Integer) dp[0]);
                    roomz.put("roomname", (String) dp[1]);

                    blockRoom.add(roomz);
                }
                model.addAttribute("viewFlrRoomLists", blockRoom);
            }

        } else {
            String[] paramsbs = {"buildingid"};
            Object[] paramsValuesbs = {buildingid};
            String[] floorFields = {"blockfloorid", "facilityblockid", "floorname"};
            String whereFloor = "WHERE r.blockfloorid IN (SELECT f.blockfloorid FROM Blockfloor f WHERE f.facilityblockid IN (SELECT fb.facilityblockid FROM Facilityblock fb WHERE fb.buildingid=:buildingid))";
            List<Object[]> FflrsArr = (List<Object[]>) genericClassService.fetchRecord(Blockfloor.class, floorFields, whereFloor, paramsbs, paramsValuesbs);
            if (FflrsArr != null) {
                Map<String, Object> bfloors;
                for (Object[] floor : FflrsArr) {
                    bfloors = new HashMap<>();
                    bfloors.put("floorname", floor[2]);
                    blockRoom.add(bfloors);
                }
                model.addAttribute("viewFlrRoomLists", blockRoom);
            }
        }
        return "controlPanel/localSettingsPanel/locationsofresources/locationsetup/views/floorrooms";
    }

    @RequestMapping(value = "/viewFloorrooms", method = RequestMethod.GET)
    public String viewFloorRooms(Model model, HttpServletRequest request) {

        String searchdata = "";
        List<Map> blockRoomz = new ArrayList<>();
        List<Map> Floorz = new ArrayList<>();
        List<Map> Blocks = new ArrayList<>();

        int buildingid = Integer.parseInt(request.getParameter("buildingId"));
        String buildingname = request.getParameter("buildingname");

        model.addAttribute("buildingid", buildingid);
        model.addAttribute("buildingname", buildingname);

        String[] paramsbs = {"buildingid"};
        Object[] paramsValuesbs = {buildingid};
        String[] fieldsbs = {"facilityblockid", "buildingid", "blockname"};
        String wherebs = "WHERE buildingid=:buildingid";
        List<Object[]> Fblkbs = (List<Object[]>) genericClassService.fetchRecord(Facilityblock.class, fieldsbs, wherebs, paramsbs, paramsValuesbs);
        if (Fblkbs != null) {
            Map<String, Object> blocks;
            for (Object[] blk : Fblkbs) {
                blocks = new HashMap<>();

                blocks.put("facilityblockid", (Integer) blk[0]);
                blocks.put("blockname", (String) blk[2]);

                Blocks.add(blocks);
            }
            model.addAttribute("viewBlockList", Blocks);
        }

        String[] floorFields = {"blockfloorid", "facilityblockid", "floorname"};
        String whereFloor = "WHERE r.facilityblockid IN (SELECT b.facilityblockid FROM Facilityblock b WHERE b.buildingid=:buildingid)";
        List<Object[]> FflrsArr = (List<Object[]>) genericClassService.fetchRecord(Blockfloor.class, floorFields, whereFloor, paramsbs, paramsValuesbs);
        if (FflrsArr != null) {
            Map<String, Object> bfloors;
            for (Object[] floor : FflrsArr) {
                bfloors = new HashMap<>();
                bfloors.put("blockfloorid", floor[0]);
                bfloors.put("floorname", floor[2]);
                Floorz.add(bfloors);
            }
            model.addAttribute("viewFloorList", Floorz);
        }

        String[] paramszrrp = {"buildingid"};
        Object[] paramsValueszrrp = {buildingid};
        String[] fieldszrrp = {"blockroomid", "blockfloorid", "roomname", "description", "status", "roomstatus"};
        String wherezrrp = "WHERE r.blockfloorid IN (SELECT f.blockfloorid FROM Blockfloor f WHERE f.facilityblockid IN (SELECT fb.facilityblockid FROM Facilityblock fb WHERE fb.buildingid=:buildingid))";

        List<Object[]> blkrmz = (List<Object[]>) genericClassService.fetchRecord(Blockroom.class, fieldszrrp, wherezrrp, paramszrrp, paramsValueszrrp);

        if (blkrmz != null) {
            Map<String, Object> rooms;
            for (Object[] dp : blkrmz) {
                rooms = new HashMap<>();
                rooms.put("blockroomid", (Integer) dp[0]);
                rooms.put("blockfloorid", (Integer) dp[1]);
                rooms.put("roomname", (String) dp[2]);
                rooms.put("description", (String) dp[3]);
                rooms.put("status", (Boolean) dp[4]);
                rooms.put("roomstatus", (Boolean) dp[5]);
                blockRoomz.add(rooms);
            }
        }
        model.addAttribute("viewBlockRoomsList", blockRoomz);

//        String[] paramszrrp = {"blockfloorid"};
//        Object[] paramsValueszrrp = {blockfloorid};
//        String[] fieldszrrp = {"blockroomid", "blockfloorid", "roomname", "description", "status", "roomstatus"};
//        String wherezrrp = "WHERE r.blockfloorid=:blockfloorid ORDER BY r.roomname ASC";
//
//        List<Object[]> blkrmz = (List<Object[]>) genericClassService.fetchRecord(Blockroom.class, fieldszrrp, wherezrrp, paramszrrp, paramsValueszrrp);
//
//        if (blkrmz != null) {
//            for (Object[] dp : blkrmz) {
//                Blockroom rooms = new Blockroom();
//                rooms.setBlockroomid((Integer) dp[0]);
//                rooms.setBlockfloorid((Integer) dp[1]);
//                rooms.setRoomname((String) dp[2]);
//                rooms.setDescription((String) dp[3]);
//                rooms.setStatus((Boolean) dp[4]);
//                rooms.setRoomstatus((Boolean) dp[5]);
//                blockRoomz.add(rooms);
//            }
//        }
//        model.addAttribute("viewBlockRoomsList", blockRoomz);
        return "controlPanel/localSettingsPanel/locationsofresources/locationsetup/views/viewroomsinblk";

    }

    @RequestMapping(value = "/fetchBlkFloors", method = RequestMethod.POST)
    public @ResponseBody
    String fetchBlkFloors(HttpServletRequest request, Model model, @ModelAttribute("facilityblockid") Integer facilityblockid) {
        String jsondata = "";
        List<Map> floors = new ArrayList<>();
        List<Map> Flr = new ArrayList<>();
        int buildingidz = Integer.parseInt(request.getParameter("buildingId"));
        if (true) {
            String[] params = {"facilityblockid"};
            Object[] paramsValues = {facilityblockid};
            String[] fields = {"blockfloorid", "floorname"};
            String where = "WHERE facilityblockid=:facilityblockid ORDER BY floorname ASC";
            List<Object[]> floorSelect = (List<Object[]>) genericClassService.fetchRecord(Blockfloor.class, fields, where, params, paramsValues);
            if (floorSelect != null) {
                Map<String, Object> flrs;
                for (Object[] pstDetail : floorSelect) {
                    flrs = new HashMap<>();
                    flrs.put("blockfloorid", (Integer) pstDetail[0]);
                    flrs.put("floorname", (String) pstDetail[1]);
                    floors.add(flrs);
                }
            }

            try {
                jsondata = new ObjectMapper().writeValueAsString(floors);
            } catch (JsonProcessingException ex) {
                System.out.println(ex);
            }
        } else {
            String[] paramss = {"buildingid"};
            Object[] paramsValuess = {buildingidz};
            String[] floorFieldss = {"blockfloorid", "facilityblockid", "floorname"};
            String whereFloors = "WHERE r.facilityblockid IN (SELECT b.facilityblockid FROM Facilityblock b WHERE b.buildingid=:buildingid)";
            List<Object[]> FflrsArrs = (List<Object[]>) genericClassService.fetchRecord(Blockfloor.class, floorFieldss, whereFloors, paramss, paramsValuess);
            if (FflrsArrs != null) {
                Map<String, Object> bflrs;
                for (Object[] floor : FflrsArrs) {
                    bflrs = new HashMap<>();
                    bflrs.put("blockfloorid", floor[0]);
                    bflrs.put("floorname", floor[2]);
                    Flr.add(bflrs);
                }
                model.addAttribute("viewFloorList", Flr);
            }

            try {
                jsondata = new ObjectMapper().writeValueAsString(Flr);
            } catch (JsonProcessingException ex) {
                System.out.println(ex);
            }
        }

        return jsondata;
    }

    @RequestMapping(value = "/fetchFlrRooms", method = RequestMethod.POST)
    public @ResponseBody
    String fetchFlrRooms(HttpServletRequest request, Model model, @ModelAttribute("blockfloorid") Integer blockfloorid) {
        String jsondata = "";
        List<Map> block = new ArrayList<>();
        List<Map> Flr = new ArrayList<>();
        int buildingidz = Integer.parseInt(request.getParameter("buildingId"));
        if (true) {
            String[] params = {"blockfloorid"};
            Object[] paramsValues = {blockfloorid};
            String[] fields = {"blockfloorid", "facilityblockid", "floorname"};
            String where = "WHERE blockfloorid=:blockfloorid ORDER BY floorname ASC";
            List<Object[]> floorSelect = (List<Object[]>) genericClassService.fetchRecord(Blockfloor.class, fields, where, params, paramsValues);
            if (floorSelect != null) {
                Map<String, Object> flrs;
                for (Object[] pstDetail : floorSelect) {
                    flrs = new HashMap<>();
                    flrs.put("blockfloorid", (Integer) pstDetail[0]);
                    flrs.put("facilityblockid", (Integer) pstDetail[1]);
                    flrs.put("floorname", (String) pstDetail[2]);

                    String[] paramsq = {"facilityblockid"};
                    Object[] paramsValuesq = {(Integer) pstDetail[1]};
                    String[] fieldsq = {"facilityblockid", "blockname"};
                    String whereq = "WHERE facilityblockid=:facilityblockid ORDER BY blockname ASC";
                    List<Object[]> floorSelectq = (List<Object[]>) genericClassService.fetchRecord(Facilityblock.class, fieldsq, whereq, paramsq, paramsValuesq);
                    if (floorSelectq != null) {
                        flrs.put("facilityblockid", (Integer) floorSelectq.get(0)[0]);
                        flrs.put("blockname", (String) floorSelectq.get(0)[1]);
                    }
                    block.add(flrs);
                }
            }

            try {
                jsondata = new ObjectMapper().writeValueAsString(block);
            } catch (JsonProcessingException ex) {
                System.out.println(ex);
            }
        } else {
            String[] paramss = {"buildingid"};
            Object[] paramsValuess = {buildingidz};
            String[] floorFieldss = {"facilityblockid", "blockname"};
            String whereFloors = "WHERE buildingid=:buildingid";
            List<Object[]> FflrsArrs = (List<Object[]>) genericClassService.fetchRecord(Facilityblock.class, floorFieldss, whereFloors, paramss, paramsValuess);
            if (FflrsArrs != null) {
                Map<String, Object> bflrs;
                for (Object[] floor : FflrsArrs) {
                    bflrs = new HashMap<>();
                    bflrs.put("facilityblockid", floor[0]);
                    bflrs.put("blockname", floor[1]);
                    Flr.add(bflrs);
                }
                model.addAttribute("viewFloorList", Flr);
            }

            try {
                jsondata = new ObjectMapper().writeValueAsString(Flr);
            } catch (JsonProcessingException ex) {
                System.out.println(ex);
            }
        }

        return jsondata;
    }

    @RequestMapping(value = "/Updatefacilityblock.htm")
    public @ResponseBody
    String UpdateFacilityBlock(Model model, HttpServletRequest request) {

        String blockname = request.getParameter("blockname");
        String blockdescription = request.getParameter("blockdescription");
        int facilityblockid = Integer.parseInt(request.getParameter("facilityblockid"));

        String[] columns = {"blockname", "blockdescription", "facilityblockid"};
        Object[] columnValues = {blockname, blockdescription, facilityblockid};
        String pk = "facilityblockid";
        Object pkValue = facilityblockid;
        genericClassService.updateRecordSQLSchemaStyle(Facilityblock.class, columns, columnValues, pk, pkValue, "assetsmanager");
        return "";
    }

    @RequestMapping(value = "/Updatefloorroom.htm")
    public @ResponseBody
    String Updateblockroom(Model model, HttpServletRequest request) {

        String roomname = request.getParameter("roomname");
        int blockroomid = Integer.parseInt(request.getParameter("blockroomid"));

        String[] columns = {"roomname"};
        Object[] columnValues = {roomname};
        String pk = "blockroomid";
        Object pkValue = blockroomid;
        genericClassService.updateRecordSQLSchemaStyle(Blockroom.class, columns, columnValues, pk, pkValue, "assetsmanager");
        return "";
    }

    @RequestMapping(value = "/Updateblockfloor.htm")
    public @ResponseBody
    String Updatefloorroom(Model model, HttpServletRequest request) {

        String floorname = request.getParameter("floorname");
        int blockfloorid = Integer.parseInt(request.getParameter("floorid"));

        String[] columns = {"floorname"};
        Object[] columnValues = {floorname};
        String pk = "blockfloorid";
        Object pkValue = blockfloorid;
        genericClassService.updateRecordSQLSchemaStyle(Blockfloor.class, columns, columnValues, pk, pkValue, "assetsmanager");
        return "";
    }

    @RequestMapping(value = "/manageblock", method = RequestMethod.GET)
    public final ModelAndView manageBlock(HttpServletRequest request) {

        Map<String, Object> model = new HashMap<String, Object>();

        return new ModelAndView("controlPanel/localSettingsPanel/locationsofresources/locationsetup/views/viewblksinbuilding", "model", model);

    }

    @RequestMapping(value = "/savenewbuildings", method = RequestMethod.POST)
    public @ResponseBody
    String saveNewBuildings(HttpServletRequest request, Model model, @ModelAttribute("buildings") String buildings) {
        Set<Integer> buildngsids = new HashSet<>();
        String results = "";
        int facilityid = (int) request.getSession().getAttribute("sessionActiveLoginFacility");
        try {
            List<Map> buildingList = new ObjectMapper().readValue(buildings, List.class);
            for (Map item : buildingList) {
                Map<String, Object> map = (HashMap) item;

                Building newbuilding = new Building();
                Object addedbyname = request.getSession().getAttribute("person_id");
                Object updatedbyname = request.getSession().getAttribute("person_id");

                newbuilding.setFacilityid(facilityid);
                newbuilding.setBuildingname((String) map.get("buildingName"));
                newbuilding.setIsactive(Boolean.TRUE);
                newbuilding.setDateadded(new Date());
                newbuilding.setDateupdated(new Date());
                //newbuilding.setAddedby((Long) addedbyname);
                //newbuilding.setUpdatedby((Long) updatedbyname);

                Object save = genericClassService.saveOrUpdateRecordLoadObject(newbuilding);
                if (save != null) {
                    buildngsids.add(newbuilding.getBuildingid());
                }
            }

        } catch (IOException ex) {
            return "Failed";
        }
        try {
            results = new ObjectMapper().writeValueAsString(buildngsids);
        } catch (JsonProcessingException ex) {
            Logger.getLogger(Locationofresources.class.getName()).log(Level.SEVERE, null, ex);
        }
        return results;
    }

    @RequestMapping(value = "/savenewblocks", method = RequestMethod.POST)
    public @ResponseBody
    String saveNewBlocks(HttpServletRequest request, Model model, @ModelAttribute("blocks") String blocks, @ModelAttribute("buildingid") int buildingid) {
        Set<Integer> blocksids = new HashSet<>();
        String results = "";
        int facilityid = (int) request.getSession().getAttribute("sessionActiveLoginFacility");
        try {

            List<Map> blockList = new ObjectMapper().readValue(blocks, List.class);

            for (Map item : blockList) {
                Map<String, Object> map = (HashMap) item;

                Facilityblock newblocks = new Facilityblock();
                Object addedbynamed = request.getSession().getAttribute("person_id");
                Object updatedbynamed = request.getSession().getAttribute("person_id");

                newblocks.setBuildingid((Integer) buildingid);
                newblocks.setBlockname((String) map.get("blocknames"));
                newblocks.setStatus(Boolean.TRUE);
                newblocks.setDateadded(new Date());
                newblocks.setDateupdated(new Date());
                newblocks.setAddedby((Long) addedbynamed);
                newblocks.setUpdatedby((Long) updatedbynamed);

                Object save = genericClassService.saveOrUpdateRecordLoadObject(newblocks);
                if (save != null) {
                    blocksids.add(newblocks.getFacilityblockid());
                }
            }
        } catch (IOException ex) {
            return "Failed";
        }
        try {
            results = new ObjectMapper().writeValueAsString(blocksids);
        } catch (JsonProcessingException ex) {
            Logger.getLogger(Locationofresources.class.getName()).log(Level.SEVERE, null, ex);
        }

        return results;
    }

    @RequestMapping(value = "/Updatefacilitybuilding.htm")
    public @ResponseBody
    String UpdateFacilityBuilding(Model model, HttpServletRequest request) {

        String buildingname = request.getParameter("buildingname");
        int facilityid = Integer.parseInt(request.getParameter("facilityid"));
        int buildingid = Integer.parseInt(request.getParameter("buildingid"));

        String[] columns = {"facilityid", "buildingname", "buildingid"};
        Object[] columnValues = {facilityid, buildingname, buildingid};
        String pk = "buildingid";
        Object pkValue = buildingid;
        genericClassService.updateRecordSQLSchemaStyle(Building.class, columns, columnValues, pk, pkValue, "assetsmanager");
        return "";
    }

    @RequestMapping(value = "/activateDeactivatebuilding", method = RequestMethod.GET)
    public String activateDeactivatebuilding(HttpServletRequest request, Model model, @ModelAttribute("isactive") boolean isactive, @ModelAttribute("buildingid") int buildingid) {
        String msg = "";
        String[] columnslev = {"isactive"};
        Object[] columnValueslev = {isactive};
        String levelPrimaryKey = "buildingid";
        Object levelPkValue = buildingid;
        Object x = genericClassService.updateRecordSQLSchemaStyle(Building.class, columnslev, columnValueslev, levelPrimaryKey, levelPkValue, "controlpanel");
        if (x != null) {
            msg = "success";
        } else {
            msg = "fail";
        }

        return msg;
    }

    @RequestMapping(value = "/activateDeactivateroom", method = RequestMethod.GET)
    public String activateDeactivateRoom(HttpServletRequest request, Model model, @ModelAttribute("isactive") boolean isactive, @ModelAttribute("buildingroomid") int buildingroomid) {
        String msg = "";
        String[] columnslev = {"isactive"};
        Object[] columnValueslev = {isactive};
        String levelPrimaryKey = "buildingroomid";
        Object levelPkValue = buildingroomid;
        Object x = genericClassService.updateRecordSQLSchemaStyle(Buildingroom.class, columnslev, columnValueslev, levelPrimaryKey, levelPkValue, "assetsmanager");
        if (x != null) {
            msg = "success";
        } else {
            msg = "fail";
        }

        return msg;
    }

    @RequestMapping(value = "/saveroomTofloor", method = RequestMethod.POST)
    public @ResponseBody
    String SaveRoomtoBlock(HttpServletRequest request, Model model, @ModelAttribute("roomz") String roomz, @ModelAttribute("blockfloorid") int blockfloorid) {

        try {
            List<Map> roomLists = new ObjectMapper().readValue(roomz, List.class);
            for (Map itemed : roomLists) {
                Map<String, Object> map = (HashMap) itemed;

                Blockroom newblkrooms = new Blockroom();
                Object addedbynamedd = request.getSession().getAttribute("person_id");
                Object updatedbynamedd = request.getSession().getAttribute("person_id");

                newblkrooms.setBlockfloorid((Integer) blockfloorid);
                newblkrooms.setRoomname((String) map.get("roomnamed"));
                newblkrooms.setStatus(Boolean.FALSE);
                newblkrooms.setRoomstatus(Boolean.FALSE);
                newblkrooms.setDateadded(new Date());
                newblkrooms.setDateupdated(new Date());
                newblkrooms.setAddedby((Long) addedbynamedd);
                newblkrooms.setUpdatedby((Long) updatedbynamedd);

                Object save = genericClassService.saveOrUpdateRecordLoadObject(newblkrooms);
            }

        } catch (IOException ex) {
            return "Failed";
        }
        return "Saved";
    }

    @RequestMapping(value = "/addroom", method = RequestMethod.POST)
    public @ResponseBody
    String AddRoom(HttpServletRequest request, Model model, @ModelAttribute("rooms") String roomz, @ModelAttribute("floorid") int blockfloorid) {
        String results = "";
        try {
            List<Map> roomLists = new ObjectMapper().readValue(roomz, List.class);
            for (Map itemed : roomLists) {
                Map<String, Object> map = (HashMap) itemed;

                Blockroom newblkrooms = new Blockroom();
                Object addedbynamedd = request.getSession().getAttribute("person_id");
                Object updatedbynamedd = request.getSession().getAttribute("person_id");

                newblkrooms.setBlockfloorid((Integer) blockfloorid);
                newblkrooms.setRoomname((String) map.get("roomnamed"));
                newblkrooms.setStatus(Boolean.FALSE);
                newblkrooms.setRoomstatus(Boolean.FALSE);
                newblkrooms.setDateadded(new Date());
                newblkrooms.setDateupdated(new Date());
                newblkrooms.setAddedby((Long) addedbynamedd);
                newblkrooms.setUpdatedby((Long) updatedbynamedd);

                Object save = genericClassService.saveOrUpdateRecordLoadObject(newblkrooms);
                if (save != null) {
                    results = "Saved";
                }
            }

        } catch (IOException ex) {
            return "Failed";
        }
        return results;
    }

    @RequestMapping(value = "/savefloorToblock", method = RequestMethod.POST)
    public @ResponseBody
    String SaveFloortoBlock(HttpServletRequest request, Model model, @ModelAttribute("floorz") String floorz, @ModelAttribute("facilityblockid") int facilityblockid) {
        Set<Integer> roomsids = new HashSet<>();
        String results = "";
        try {
            List<Map> floorLists = new ObjectMapper().readValue(floorz, List.class);
            for (Map itemed : floorLists) {
                Map<String, Object> map = (HashMap) itemed;

                Blockfloor newblkfloors = new Blockfloor();
                Object addedbynamedd = request.getSession().getAttribute("person_id");
                Object updatedbynamedd = request.getSession().getAttribute("person_id");

                newblkfloors.setFacilityblockid((Integer) facilityblockid);
                newblkfloors.setFloorname((String) map.get("floornamed"));
                newblkfloors.setIsactive(Boolean.TRUE);
                newblkfloors.setDateadded(new Date());
                newblkfloors.setDateupdated(new Date());
                newblkfloors.setAddedby((Long) addedbynamedd);
                newblkfloors.setUpdatedby((Long) updatedbynamedd);

                Object save = genericClassService.saveOrUpdateRecordLoadObject(newblkfloors);
                if (save != null) {
                    roomsids.add(newblkfloors.getBlockfloorid());
                }
            }
        } catch (IOException ex) {
            return "Failed";
        }

        try {
            results = new ObjectMapper().writeValueAsString(roomsids);
        } catch (JsonProcessingException ex) {
            Logger.getLogger(Locationofresources.class.getName()).log(Level.SEVERE, null, ex);
        }
        return results;
    }
    
    @RequestMapping(value = "/assignDeassignroom", method = RequestMethod.GET)
    public String AssignDeassignRoom(HttpServletRequest request, Model model, @ModelAttribute("roomstatus") boolean roomstatus, @ModelAttribute("blockroomid") int blockroomid) {
        String msg = "";
        String[] columnslev = {"roomstatus"};
        Object[] columnValueslev = {roomstatus};
        String levelPrimaryKey = "blockroomid";
        Object levelPkValue = blockroomid;
        Object x = genericClassService.updateRecordSQLSchemaStyle(Blockroom.class, columnslev, columnValueslev, levelPrimaryKey, levelPkValue, "assetsmanager");
        if (x != null) {
            msg = "success";
        } else {
            msg = "fail";
        }

        return msg;
    }

    @RequestMapping(value = "/removeroomfromBlock", method = RequestMethod.POST)
    public @ResponseBody
    String RemoveRoomFromBlock(HttpServletRequest request, Model model, @ModelAttribute("blockroomid") int blockroomid) {
        String results = "";

        String[] columnslev = {"status"};
        Object[] columnValueslev = {Boolean.TRUE};
        String levelPrimaryKey = "blockroomid";
        Object levelPkValue = blockroomid;
        int result = genericClassService.updateRecordSQLSchemaStyle(Blockroom.class, columnslev, columnValueslev, levelPrimaryKey, levelPkValue, "assetsmanager");
        if (result != 0) {
            results = "success";
        }
        return results;
    }

    @RequestMapping(value = "/addNewbuilding")
    public @ResponseBody
    String addNewBuilding(HttpServletRequest request, Model model, @ModelAttribute("floors") String selectedFloor, @ModelAttribute("blocks") String selectedBlock, @ModelAttribute("buildingObjectList") String selectedBuilding, @ModelAttribute("rooms") String selectedRoom, @ModelAttribute("facilityid") int facilityid) {

        Building creatingbuilding;
        Facilityblock creatingblocks;
        Blockfloor creatingfloors;
        Blockroom creatingrooms;
        ObjectMapper mapper = new ObjectMapper();
        String msg = "";
        List<Map> blded;
        try {

            Object addedbynamedd = request.getSession().getAttribute("person_id");
            Object updatedbynamedd = request.getSession().getAttribute("person_id");

            blded = (ArrayList<Map>) new ObjectMapper().readValue(selectedBuilding, List.class);
            for (Map n : blded) {
                Map<String, Object> map = (HashMap) n;
                creatingbuilding = new Building();
                String buildingname = (String) map.get("buildingName");
                creatingbuilding.setBuildingname(buildingname);
                creatingbuilding.setFacilityid((Integer) facilityid);
                creatingbuilding.setIsactive(Boolean.TRUE);
                creatingbuilding.setDateadded(new Date());
                creatingbuilding.setDateupdated(new Date());
                creatingbuilding.setAddedby((Long) addedbynamedd);
                creatingbuilding.setUpdatedby((Long) updatedbynamedd);

                Object savedbuilding = genericClassService.saveOrUpdateRecordLoadObject(creatingbuilding);
                if (savedbuilding != null) {
                    int buildingid = creatingbuilding.getBuildingid();
                    List<Map> blkV = (ArrayList<Map>) mapper.readValue(selectedBlock, List.class);
                    for (Map k : blkV) {
                        if (Integer.parseInt(n.get("buildingxid").toString()) == Integer.parseInt(k.get("buildingxid").toString())) {
                            Map<String, Object> map2 = (HashMap) k;
                            creatingblocks = new Facilityblock();
                            String blockname = (String) map2.get("blockname");
                            creatingblocks.setBlockname(blockname);
                            creatingblocks.setBuildingid((Integer) buildingid);
                            creatingblocks.setStatus(Boolean.TRUE);
                            creatingblocks.setDateadded(new Date());
                            creatingblocks.setDateupdated(new Date());
                            creatingblocks.setAddedby((Long) addedbynamedd);
                            creatingblocks.setUpdatedby((Long) updatedbynamedd);

                            Object savedBlk = genericClassService.saveOrUpdateRecordLoadObject(creatingblocks);
                            if (savedBlk != null) {
                                int facilityblockid = creatingblocks.getFacilityblockid();
                                List<Map> floorsV = (ArrayList<Map>) mapper.readValue(selectedFloor, List.class);
                                for (Map h : floorsV) {
                                    if (Integer.parseInt(k.get("blockid").toString()) == Integer.parseInt(h.get("blockid").toString())) {
                                        Map<String, Object> map3 = (HashMap) h;
                                        creatingfloors = new Blockfloor();
                                        creatingfloors.setFloorname((String) map3.get("floorname"));
                                        creatingfloors.setFacilityblockid((Integer) facilityblockid);
                                        creatingfloors.setIsactive(Boolean.TRUE);
                                        creatingfloors.setDateadded(new Date());
                                        creatingfloors.setDateupdated(new Date());
                                        creatingfloors.setAddedby((Long) addedbynamedd);
                                        creatingfloors.setUpdatedby((Long) updatedbynamedd);
                                        Object savedfloor = genericClassService.saveOrUpdateRecordLoadObject(creatingfloors);
                                        if (savedfloor != null) {
                                            int blockfloorid = creatingfloors.getBlockfloorid();
                                            List<Map> roomsV = (ArrayList<Map>) mapper.readValue(selectedRoom, List.class);
                                            for (Map t : roomsV) {
                                                if (Integer.parseInt(h.get("floorid").toString()) == Integer.parseInt(t.get("floorid").toString())) {
                                                    Map<String, Object> map4 = (HashMap) t;
                                                    creatingrooms = new Blockroom();
                                                    creatingrooms.setRoomname((String) map4.get("roomname"));
                                                    creatingrooms.setBlockfloorid((Integer) blockfloorid);
                                                    creatingrooms.setRoomstatus(Boolean.FALSE);
                                                    creatingrooms.setStatus(Boolean.FALSE);
                                                    creatingrooms.setDateadded(new Date());
                                                    creatingrooms.setDateupdated(new Date());
                                                    creatingrooms.setAddedby((Long) addedbynamedd);
                                                    creatingrooms.setUpdatedby((Long) updatedbynamedd);
                                                    Object savedcell = genericClassService.saveOrUpdateRecordLoadObject(creatingrooms);
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
                    }
                }
            }
        } catch (IOException ex) {
            System.out.println(ex);
        }
        return msg;
    }

    @RequestMapping(value = "/addNewbuildings")
    public @ResponseBody
    String addNewBuildings(HttpServletRequest request, Model model, @ModelAttribute("floors") String selectedFloor, @ModelAttribute("blocks") String selectedBlock, @ModelAttribute("buildingObjectList") String selectedBuilding, @ModelAttribute("facilityid") int facilityid) {
        String results = "";
        Building creatingbuilding;
        Facilityblock creatingblocks;
        Blockfloor creatingfloors;
        Set<Integer> floorids = new HashSet<>();
        ObjectMapper mapper = new ObjectMapper();
        String msg = "";
        List<Map> blded;
        try {

            Object addedbynamedd = request.getSession().getAttribute("person_id");
            Object updatedbynamedd = request.getSession().getAttribute("person_id");

            blded = (ArrayList<Map>) new ObjectMapper().readValue(selectedBuilding, List.class);
            for (Map n : blded) {
                Map<String, Object> map = (HashMap) n;
                creatingbuilding = new Building();
                String buildingname = (String) map.get("buildingName");
                creatingbuilding.setBuildingname(buildingname);
                creatingbuilding.setFacilityid((Integer) facilityid);
                creatingbuilding.setIsactive(Boolean.TRUE);
                creatingbuilding.setDateadded(new Date());
                creatingbuilding.setDateupdated(new Date());
                creatingbuilding.setAddedby((Long) addedbynamedd);
                creatingbuilding.setUpdatedby((Long) updatedbynamedd);

                Object savedbuilding = genericClassService.saveOrUpdateRecordLoadObject(creatingbuilding);
                if (savedbuilding != null) {
                    int buildingid = creatingbuilding.getBuildingid();
                    List<Map> blkV = (ArrayList<Map>) mapper.readValue(selectedBlock, List.class);
                    for (Map k : blkV) {
                        if (Integer.parseInt(n.get("buildingxid").toString()) == Integer.parseInt(k.get("buildingxid").toString())) {
                            Map<String, Object> map2 = (HashMap) k;
                            creatingblocks = new Facilityblock();
                            String blockname = (String) map2.get("blockname");
                            creatingblocks.setBlockname(blockname);
                            creatingblocks.setBuildingid((Integer) buildingid);
                            creatingblocks.setStatus(Boolean.TRUE);
                            creatingblocks.setDateadded(new Date());
                            creatingblocks.setDateupdated(new Date());
                            creatingblocks.setAddedby((Long) addedbynamedd);
                            creatingblocks.setUpdatedby((Long) updatedbynamedd);

                            Object savedBlk = genericClassService.saveOrUpdateRecordLoadObject(creatingblocks);
                            if (savedBlk != null) {
                                int facilityblockid = creatingblocks.getFacilityblockid();
                                List<Map> floorsV = (ArrayList<Map>) mapper.readValue(selectedFloor, List.class);
                                for (Map h : floorsV) {
                                    if (Integer.parseInt(k.get("blockid").toString()) == Integer.parseInt(h.get("blockid").toString())) {
                                        Map<String, Object> map3 = (HashMap) h;
                                        creatingfloors = new Blockfloor();
                                        // System.out.println("--------------------------" + h.get("celllabel"));
                                        creatingfloors.setFloorname((String) map3.get("floorname"));
                                        creatingfloors.setFacilityblockid((Integer) facilityblockid);
                                        creatingfloors.setIsactive(Boolean.TRUE);
                                        creatingfloors.setDateadded(new Date());
                                        creatingfloors.setDateupdated(new Date());
                                        creatingfloors.setAddedby((Long) addedbynamedd);
                                        creatingfloors.setUpdatedby((Long) updatedbynamedd);
                                        Object savedcell = genericClassService.saveOrUpdateRecordLoadObject(creatingfloors);
                                        if (savedcell != null) {
                                            floorids.add(creatingfloors.getBlockfloorid());
                                        }
                                    }
                                }
                                try {
                                    results = new ObjectMapper().writeValueAsString(floorids);
                                } catch (JsonProcessingException ex) {
                                    Logger.getLogger(Locationofresources.class.getName()).log(Level.SEVERE, null, ex);
                                }
                            }
                        }
                    }
                }
            }
        } catch (IOException ex) {
            System.out.println(ex);
        }
        return results;
    }

    @RequestMapping(value = "/addNewbuildingz")
    public @ResponseBody
    String addNewBuildingz(HttpServletRequest request, Model model, @ModelAttribute("blocks") String selectedBlock, @ModelAttribute("buildingObjectList") String selectedBuilding, @ModelAttribute("facilityid") int facilityid) {
        Set<Integer> blocksidZ = new HashSet<>();
        Set<Integer> buildingids = new HashSet<>();
        Set<String> buildingnames = new HashSet<>();
        String results = "";
        Building creatingbuilding;
        Facilityblock creatingblocks;
        ObjectMapper mapper = new ObjectMapper();
        String msg = "";
        List<Map> blded;
        try {

            Object addedbynamedd = request.getSession().getAttribute("person_id");
            Object updatedbynamedd = request.getSession().getAttribute("person_id");

            blded = (ArrayList<Map>) new ObjectMapper().readValue(selectedBuilding, List.class);
            for (Map n : blded) {
                Map<String, Object> map = (HashMap) n;
                creatingbuilding = new Building();
                String buildingname = (String) map.get("buildingName");
                creatingbuilding.setBuildingname(buildingname);
                creatingbuilding.setFacilityid((Integer) facilityid);
                creatingbuilding.setIsactive(Boolean.TRUE);
                creatingbuilding.setDateadded(new Date());
                creatingbuilding.setDateupdated(new Date());
                creatingbuilding.setAddedby((Long) addedbynamedd);
                creatingbuilding.setUpdatedby((Long) updatedbynamedd);

                Object savedbuilding = genericClassService.saveOrUpdateRecordLoadObject(creatingbuilding);
                if (savedbuilding != null) {
                    int buildingid = creatingbuilding.getBuildingid();
                    buildingnames.add(creatingbuilding.getBuildingname());
                    List<Map> blkV = (ArrayList<Map>) mapper.readValue(selectedBlock, List.class);
                    for (Map k : blkV) {
                        if (Integer.parseInt(n.get("buildingxid").toString()) == Integer.parseInt(k.get("buildingxid").toString())) {
                            Map<String, Object> map2 = (HashMap) k;
                            creatingblocks = new Facilityblock();
                            String blockname = (String) map2.get("blockname");
                            creatingblocks.setBlockname(blockname);
                            creatingblocks.setBuildingid((Integer) buildingid);
                            creatingblocks.setStatus(Boolean.TRUE);
                            creatingblocks.setDateadded(new Date());
                            creatingblocks.setDateupdated(new Date());
                            creatingblocks.setAddedby((Long) addedbynamedd);
                            creatingblocks.setUpdatedby((Long) updatedbynamedd);

                            Object savedBlk = genericClassService.saveOrUpdateRecordLoadObject(creatingblocks);
                            if (savedBlk != null) {
                                blocksidZ.add(creatingblocks.getFacilityblockid());
                                buildingids.add(creatingblocks.getBuildingid());
                                results = "Saved";
                            }
                        }
                    }
                }
            }
        } catch (IOException ex) {
            return "Failed";
        }
        try {
            results = new ObjectMapper().writeValueAsString(blocksidZ);

        } catch (JsonProcessingException ex) {
            Logger.getLogger(Locationofresources.class.getName()).log(Level.SEVERE, null, ex);
        }

        return results;
    }

    @RequestMapping(value = "/addNewblock")
    public @ResponseBody
    String addNewBlock(HttpServletRequest request, Model model, @ModelAttribute("floors") String selectedFloor, @ModelAttribute("blockObjectList") String selectedBlock, @ModelAttribute("buildingid") int buildingid, @ModelAttribute("buildingname") String buildingname) {
        Set<Integer> roomsidZ = new HashSet<>();
        Set<Integer> blockidZ = new HashSet<>();
        Set<String> blocknames = new HashSet<>();
        String results = "";
        Facilityblock creatingblocks;
        Blockfloor creatingfloors;
        ObjectMapper mapper = new ObjectMapper();
        String msg = "";
        List<Map> blked;
        System.out.println("-----------------------------000000000000");
        System.out.println("-----------------------------floors"+selectedFloor);
        try {
System.out.println("-----------------------------111111111111");
            Object addedbynamedd = request.getSession().getAttribute("person_id");
            Object updatedbynamedd = request.getSession().getAttribute("person_id");

            blked = (ArrayList<Map>) new ObjectMapper().readValue(selectedBlock, List.class);
            for (Map n : blked) {
                Map<String, Object> map = (HashMap) n;
                creatingblocks = new Facilityblock();
                String blockname = (String) map.get("blocknames");
                creatingblocks.setBlockname(blockname);
                creatingblocks.setBuildingid((Integer) buildingid);
                creatingblocks.setStatus(Boolean.TRUE);
                creatingblocks.setDateadded(new Date());
                creatingblocks.setDateupdated(new Date());
                creatingblocks.setAddedby((Long) addedbynamedd);
                creatingblocks.setUpdatedby((Long) updatedbynamedd);

                Object savedblock = genericClassService.saveOrUpdateRecordLoadObject(creatingblocks);
                System.out.println("-----------------------------------------savedblock11111111111"+savedblock);
                if (savedblock != null) {
                    System.out.println("-----------------------------------------savedblock"+savedblock);
                    int facilityblockid = creatingblocks.getFacilityblockid();
                    blocknames.add(creatingblocks.getBlockname());
                    List<Map> floorsV = (ArrayList<Map>) mapper.readValue(selectedFloor, List.class);
                    System.out.println("---------------------------------------IMPOSSIBLEIMPOSSIBLEIMPOSSIBLE");
                    for (Map h : floorsV) {
                        System.out.println("---------------------------------------IMPOSSIBLE");
                        if (Integer.parseInt(n.get("blockxid").toString()) == Integer.parseInt(h.get("blockxid").toString())) {
                            Map<String, Object> map3 = (HashMap) h;
                            creatingfloors = new Blockfloor();
                            System.out.println("---------------------------------------IMPOSSIBLEDDDDDDDDDDDD");
                            creatingfloors.setFloorname((String) map3.get("floorname"));
                            creatingfloors.setFacilityblockid((Integer) facilityblockid);
                            creatingfloors.setIsactive(Boolean.TRUE);
                            creatingfloors.setDateadded(new Date());
                            creatingfloors.setDateupdated(new Date());
                            creatingfloors.setAddedby((Long) addedbynamedd);
                            creatingfloors.setUpdatedby((Long) updatedbynamedd);

                            Object savedfloor = genericClassService.saveOrUpdateRecordLoadObject(creatingfloors);
                            if (savedfloor != null) {
                                roomsidZ.add(creatingfloors.getBlockfloorid());
                                blockidZ.add(creatingfloors.getFacilityblockid());
                            }

                        }
                    }
                }
            }
            System.out.println("-----------------------------000000000000");
        } catch (IOException ex) {
            return "Failed";
        }
        try {
            results = new ObjectMapper().writeValueAsString(roomsidZ);
            results = new ObjectMapper().writeValueAsString(blocknames);
            results = new ObjectMapper().writeValueAsString(blockidZ);
        } catch (JsonProcessingException ex) {
            Logger.getLogger(Locationofresources.class.getName()).log(Level.SEVERE, null, ex);
        }

        return results;
    }

    @RequestMapping(value = "/addNewblockz")
    public @ResponseBody
    String addNewBlockz(HttpServletRequest request, Model model, @ModelAttribute("rooms") String selectedRoom, @ModelAttribute("floors") String selectedFloor, @ModelAttribute("blockObjectList") String selectedBlock, @ModelAttribute("buildingid") int buildingid, @ModelAttribute("buildingname") String buildingname) {
        Set<Integer> roomsidZ = new HashSet<>();
        String results = "";
        Facilityblock creatingblocks;
        Blockroom creatingrooms;
        Blockfloor creatingfloors;
        ObjectMapper mapper = new ObjectMapper();
        String data = "";
        List<Map> blked;
        try {

            Object addedbynamedd = request.getSession().getAttribute("person_id");
            Object updatedbynamedd = request.getSession().getAttribute("person_id");

            blked = (ArrayList<Map>) new ObjectMapper().readValue(selectedBlock, List.class);
            for (Map n : blked) {
                Map<String, Object> map = (HashMap) n;
                creatingblocks = new Facilityblock();
                String blockname = (String) map.get("blocknames");
                creatingblocks.setBlockname(blockname);
                creatingblocks.setBuildingid((Integer) buildingid);
                creatingblocks.setStatus(Boolean.TRUE);
                creatingblocks.setDateadded(new Date());
                creatingblocks.setDateupdated(new Date());
                creatingblocks.setAddedby((Long) addedbynamedd);
                creatingblocks.setUpdatedby((Long) updatedbynamedd);

                Object savedblock = genericClassService.saveOrUpdateRecordLoadObject(creatingblocks);
                if (savedblock != null) {
                    int facilityblockid = creatingblocks.getFacilityblockid();
                    List<Map> floorsV = (ArrayList<Map>) mapper.readValue(selectedFloor, List.class);
                    for (Map h : floorsV) {
                        if (Integer.parseInt(n.get("blockxid").toString()) == Integer.parseInt(h.get("blockxid").toString())) {
                            Map<String, Object> map3 = (HashMap) h;
                            creatingfloors = new Blockfloor();
                            creatingfloors.setFloorname((String) map3.get("floorname"));
                            creatingfloors.setFacilityblockid((Integer) facilityblockid);
                            creatingfloors.setIsactive(Boolean.TRUE);
                            creatingfloors.setDateadded(new Date());
                            creatingfloors.setDateupdated(new Date());
                            creatingfloors.setAddedby((Long) addedbynamedd);
                            creatingfloors.setUpdatedby((Long) updatedbynamedd);
                            Object savedfloor = genericClassService.saveOrUpdateRecordLoadObject(creatingfloors);
                            if (savedfloor != null) {
                                int blockfloorid = creatingfloors.getBlockfloorid();
                                List<Map> roomsV = (ArrayList<Map>) mapper.readValue(selectedRoom, List.class);
                                for (Map t : roomsV) {
                                    if (Integer.parseInt(h.get("floorid").toString()) == Integer.parseInt(t.get("floorid").toString())) {
                                        Map<String, Object> map4 = (HashMap) t;
                                        creatingrooms = new Blockroom();
                                        creatingrooms.setRoomname((String) map4.get("roomname"));
                                        creatingrooms.setBlockfloorid((Integer) blockfloorid);
                                        creatingrooms.setRoomstatus(Boolean.FALSE);
                                        creatingrooms.setStatus(Boolean.FALSE);
                                        creatingrooms.setDateadded(new Date());
                                        creatingrooms.setDateupdated(new Date());
                                        creatingrooms.setAddedby((Long) addedbynamedd);
                                        creatingrooms.setUpdatedby((Long) updatedbynamedd);
                                        Object savedcell = genericClassService.saveOrUpdateRecordLoadObject(creatingrooms);
                                        if (savedcell != null) {
                                            data = "success";
                                        } else {
                                            data = "Failed";
                                        }

                                    }
                                }
                            }

                        }
                    }
                }
            }
        } catch (IOException ex) {
            return "Failed";
        }
        try {
            results = new ObjectMapper().writeValueAsString(roomsidZ);
        } catch (JsonProcessingException ex) {
            Logger.getLogger(Locationofresources.class.getName()).log(Level.SEVERE, null, ex);
        }

        return results;
    }

    @RequestMapping(value = "/registerFloor.htm", method = RequestMethod.POST)
    public String registerFloor(HttpServletRequest request, Model model, @ModelAttribute("res") String response) {
        List<Map> blockList = new ArrayList<>();
        int buildingid = Integer.parseInt(request.getParameter("a"));
        String buildingname = request.getParameter("b");
        try {
            
            model.addAttribute("buildingid", buildingid);
            model.addAttribute("buildingname", buildingname);
            
            List<Integer> blkitem = (ArrayList) new ObjectMapper().readValue(response, List.class);

            for (Integer blockitems : blkitem) {
                String[] params = {"facilityblockid"};
                Object[] paramsValues = {blockitems};
                String[] fields = {"facilityblockid", "blockname", "status"};
                String where = "WHERE facilityblockid=:facilityblockid ORDER BY blockname";
                List<Object[]> Fblkrm = (List<Object[]>) genericClassService.fetchRecord(Facilityblock.class, fields, where, params, paramsValues);
                if (Fblkrm != null) {
                    Map<String, Object> fblocks;
                    Object[] fblk = Fblkrm.get(0);
                    fblocks = new HashMap<>();
                    fblocks.put("facilityblockid", (Integer) fblk[0]);
                    fblocks.put("blockname", (String) fblk[1]);
                    fblocks.put("status", (Boolean) fblk[2]);
                    blockList.add(fblocks);
                }
            }

        } catch (Exception e) {
        }
        model.addAttribute("NewBlockList", blockList);

        return "controlPanel/localSettingsPanel/locationsofresources/locationsetup/forms/registerfloor";

    }

    @RequestMapping(value = "/addfloortoblock.htm", method = RequestMethod.POST)
    public String AddFloorToBlock(HttpServletRequest request, Model model, @ModelAttribute("res") String response) {
        int buildingid = Integer.parseInt(request.getParameter("a"));
        String buildingname = request.getParameter("b");
        List<Facilityblock> blockList = new ArrayList<>();
        try {

            model.addAttribute("buildingid", buildingid);
            model.addAttribute("buildingname", buildingname);

            List<Integer> blkitem = (ArrayList) new ObjectMapper().readValue(response, List.class);

            for (Integer blockitems : blkitem) {

                String[] params = {"facilityblockid"};
                Object[] paramsValues = {blockitems};
                String[] fields = {"facilityblockid", "blockname", "status"};
                String where = "WHERE facilityblockid=:facilityblockid ORDER BY blockname";
                List<Object[]> Fblkrm = (List<Object[]>) genericClassService.fetchRecord(Facilityblock.class, fields, where, params, paramsValues);
                if (Fblkrm != null) {
                    Object[] fblk = Fblkrm.get(0);
                    Facilityblock fblocks = new Facilityblock();
                    fblocks.setFacilityblockid((Integer) fblk[0]);
                    fblocks.setBlockname((String) fblk[1]);
                    fblocks.setStatus((Boolean) fblk[2]);
                    blockList.add(fblocks);
                }
            }

        } catch (Exception e) {
        }
        model.addAttribute("BldBlockLists", blockList);

        return "controlPanel/localSettingsPanel/locationsofresources/locationsetup/forms/floortoblock";

    }

    @RequestMapping(value = "/addfloor.htm", method = RequestMethod.GET)
    public String addfloor(HttpServletRequest request, Model model, @ModelAttribute("res") String response) {
        List<Map> blockList = new ArrayList<>();
        System.out.println("--------------------------BldBlocks1111" + response);
        try {
            System.out.println("--------------------------BldBlocks22222" + response);
            List<Integer> blkId = (ArrayList) new ObjectMapper().readValue(response, List.class);

            System.out.println("--------------------------BldBlocks3333" + blkId);
            for (Integer Ids : blkId) {
                System.out.println("--------------------------BldBlocks4444" + Ids);
                String[] params = {"facilityblockid"};
                Object[] paramsValues = {Ids};
                String[] fields = {"facilityblockid", "blockname", "status"};
                String where = "WHERE facilityblockid=:facilityblockid ORDER BY blockname";
                List<Object[]> Fblkrm = (List<Object[]>) genericClassService.fetchRecord(Facilityblock.class, fields, where, params, paramsValues);
                if (Fblkrm != null) {
                    Map<String, Object> fblocks;
                    Object[] fblk = Fblkrm.get(0);
                    fblocks = new HashMap<>();
                    fblocks.put("facilityblockid", (Integer) fblk[0]);
                    fblocks.put("blockname", (String) fblk[1]);
                    fblocks.put("status", (Boolean) fblk[2]);
                    blockList.add(fblocks);
                }
            }
            model.addAttribute("BldBlocks", blockList);
            System.out.println("--------------------------BldBlocks" + blockList);

        } catch (Exception e) {
        }

        return "controlPanel/localSettingsPanel/locationsofresources/locationsetup/forms/addfloor";

    }

    @RequestMapping(value = "/savefloors")
    public @ResponseBody
    String SaveFloors(HttpServletRequest request, Model model, @ModelAttribute("rooms") String selectedRoom, @ModelAttribute("floorObjectLists") String selectedFloor, @ModelAttribute("facilityblockid") int facilityblockid) {
        Set<Integer> roomsidZ = new HashSet<>();
        String results = "";
        Blockfloor creatingfloor;
        Blockroom creatingrooms;
        ObjectMapper mapper = new ObjectMapper();
        String msg = "";
        List<Map> blded;
        try {

            Object addedbynamedd = request.getSession().getAttribute("person_id");
            Object updatedbynamedd = request.getSession().getAttribute("person_id");

            blded = (ArrayList<Map>) new ObjectMapper().readValue(selectedFloor, List.class);
            for (Map n : blded) {
                Map<String, Object> map = (HashMap) n;
                creatingfloor = new Blockfloor();
                String floorname = (String) map.get("floornamed");
                creatingfloor.setFacilityblockid((Integer) facilityblockid);
                creatingfloor.setFloorname(floorname);
                creatingfloor.setIsactive(Boolean.TRUE);
                creatingfloor.setDateadded(new Date());
                creatingfloor.setDateupdated(new Date());
                creatingfloor.setAddedby((Long) addedbynamedd);
                creatingfloor.setUpdatedby((Long) updatedbynamedd);

                Object savedfloor = genericClassService.saveOrUpdateRecordLoadObject(creatingfloor);
                if (savedfloor != null) {
                    int blockfloorid = creatingfloor.getBlockfloorid();
                    List<Map> blkV = (ArrayList<Map>) mapper.readValue(selectedRoom, List.class);
                    for (Map k : blkV) {
                        System.out.println("----------------------------(String) map2.get(\"roomname\")wwwwwwwww" + Integer.parseInt(n.get("floorxid").toString()));
                        if (Integer.parseInt(n.get("floorxid").toString()) == Integer.parseInt(k.get("floorxid").toString())) {
                            Map<String, Object> map2 = (HashMap) k;
                            creatingrooms = new Blockroom();

                            System.out.println("----------------------------(String) map2.get(\"roomname\")" + (String) map2.get("roomname"));
                            String roomname = (String) map2.get("roomname");
                            creatingrooms.setRoomname(roomname);
                            creatingrooms.setBlockfloorid((Integer) blockfloorid);
                            creatingrooms.setStatus(Boolean.FALSE);
                            creatingrooms.setRoomstatus(Boolean.FALSE);
                            creatingrooms.setDateadded(new Date());
                            creatingrooms.setDateupdated(new Date());
                            creatingrooms.setAddedby((Long) addedbynamedd);
                            creatingrooms.setUpdatedby((Long) updatedbynamedd);

                            Object savedrooms = genericClassService.saveOrUpdateRecordLoadObject(creatingrooms);
                            if (savedrooms != null) {
                                roomsidZ.add(creatingrooms.getBlockroomid());
                                results = "Saved";
                            }
                        }
                    }
                }
            }
        } catch (IOException ex) {
            return "Failed";
        }
        try {
            results = new ObjectMapper().writeValueAsString(roomsidZ);
        } catch (JsonProcessingException ex) {
            Logger.getLogger(Locationofresources.class.getName()).log(Level.SEVERE, null, ex);
        }

        return results;
    }

    @RequestMapping(value = "/deleteBuilding")
    public @ResponseBody
    String deleteBuilding(HttpServletRequest request, Model model, @ModelAttribute("tablerowid") int buildingid, @ModelAttribute("tableData") String buildingname) {
        String msg = "";
        Set<Integer> contentblockid = new HashSet<>();
        Set<Integer> contentfloorid = new HashSet<>();
        Set<Integer> contentroomid = new HashSet<>();

        String[] params = {"buildingid"};
        Object[] paramsValues = {buildingid};
        String[] fields = {"facilityblockid"};
        String where = "WHERE buildingid=:buildingid";
        List<Integer> contObj = (List<Integer>) genericClassService.fetchRecord(Building.class, fields, where, params, paramsValues);
        if (contObj != null) {
            for (Integer a : contObj) {
                //it has items
                int blockid = a;

                String[] params3 = {"facilityblockid"};
                Object[] paramsValues3 = {a};
                String[] fields3 = {"blockfloorid"};
                String where3 = "WHERE facilityblockid=:facilityblockid";
                List<Integer> blockContentObj = (List<Integer>) genericClassService.fetchRecord(Facilityblock.class, fields3, where3, params3, paramsValues3);
                if (blockContentObj != null) {
                    for (Integer v : blockContentObj) {

                        int floorid = v;

                        String[] params4 = {"blockfloorid"};
                        Object[] paramsValues4 = {v};
                        String[] fields4 = {"blockroomid"};
                        String where4 = "WHERE blockfloorid=:blockfloorid";
                        List<Integer> floorContentObj = (List<Integer>) genericClassService.fetchRecord(Blockfloor.class, fields4, where4, params4, paramsValues4);
                        if (floorContentObj != null) {
                            for (Integer c : floorContentObj) {

                                String[] params5 = {"blockroomid", "status"};
                                Object[] paramsValues5 = {c, Boolean.FALSE};
                                String[] fields5 = {"status"};
                                String where5 = "WHERE blockroomid=:blockroomid AND status=:status";
                                List<Integer> roomContentObj = (List<Integer>) genericClassService.fetchRecord(Blockroom.class, fields5, where5, params5, paramsValues5);
                                if (roomContentObj != null) {
                                    for (Integer t : roomContentObj) {
                                        msg = "containsitems";
                                    }

                                }
                            }

                        }
                    }

                }
            }

        } else {
            //has no items
            String[] params2 = {"buildingid"};
            Object[] paramsValues2 = {buildingid};
            String[] fields2 = {"facilityblockid"};
            String where2 = "WHERE buildingid=:buildingid";
            List<Integer> buildingContentObj = (List<Integer>) genericClassService.fetchRecord(Facilityblock.class, fields2, where2, params2, paramsValues2);
            if (buildingContentObj != null) {
                for (Integer n : buildingContentObj) {
                    int blockid = n;

                    String[] params3 = {"facilityblockid"};
                    Object[] paramsValues3 = {n};
                    String[] fields3 = {"blockfloorid"};
                    String where3 = "WHERE facilityblockid=:facilityblockid";
                    List<Integer> blockContentObj = (List<Integer>) genericClassService.fetchRecord(Blockfloor.class, fields3, where3, params3, paramsValues3);
                    if (blockContentObj != null) {
                        for (Integer v : blockContentObj) {

                            int floorid = v;

                            String[] params4 = {"blockfloorid"};
                            Object[] paramsValues4 = {v};
                            String[] fields4 = {"blockroomid"};
                            String where4 = "WHERE blockfloorid=:blockfloorid";
                            List<Integer> floorContentObj = (List<Integer>) genericClassService.fetchRecord(Blockroom.class, fields4, where4, params4, paramsValues4);
                            if (floorContentObj != null) {
                                for (Integer c : floorContentObj) {

                                    int roomid = c;

                                    contentblockid.add(blockid);
                                    contentfloorid.add(floorid);
                                    contentroomid.add(roomid);

                                }

                            }
                        }

                    }
                }

            }
        }
        System.out.println("--------------blocks---------" + contentblockid);
        System.out.println("-------------floors----------" + contentfloorid);
        System.out.println("-----------rooms------------" + contentroomid);
        ObjectMapper mapper = new ObjectMapper();
        if (!contentroomid.isEmpty()) {
            List<Integer> roomdel;
            try {
                roomdel = (ArrayList<Integer>) mapper.readValue(mapper.writeValueAsString(contentroomid), List.class);
                for (Integer p : roomdel) {
                    String[] columns4 = {"blockroomid"};
                    Object[] columnValues4 = {p};
                    genericClassService.deleteRecordByByColumns("assetsmanager.blockroom", columns4, columnValues4);
                }
            } catch (JsonProcessingException ex) {
                System.out.println(ex);
            } catch (IOException ex) {
                System.out.println(ex);
            }
        }
        if (!contentfloorid.isEmpty()) {
            List<Integer> floordel;
            try {
                floordel = (ArrayList<Integer>) mapper.readValue(mapper.writeValueAsString(contentfloorid), List.class);
                for (Integer o : floordel) {
                    String[] columns3 = {"blockfloorid"};
                    Object[] columnValues3 = {o};
                    genericClassService.deleteRecordByByColumns("assetsmanager.blockfloor", columns3, columnValues3);
                }
            } catch (JsonProcessingException ex) {
                System.out.println(ex);
            } catch (IOException ex) {
                System.out.println(ex);
            }

        }
        if (!contentblockid.isEmpty()) {
            List<Integer> blockdel;
            try {
                blockdel = (ArrayList<Integer>) mapper.readValue(mapper.writeValueAsString(contentblockid), List.class);
                for (Integer n : blockdel) {
                    String[] columns2 = {"facilityblockid"};
                    Object[] columnValues2 = {n};
                    genericClassService.deleteRecordByByColumns("assetsmanager.facilityblock", columns2, columnValues2);
                }
            } catch (JsonProcessingException ex) {
                System.out.println(ex);
            } catch (IOException ex) {
                System.out.println(ex);
            }

        }

        //final deleting of zone
        String[] columns5 = {"buildingid"};
        Object[] columnValues5 = {buildingid};
        Object zonedel = genericClassService.deleteRecordByByColumns("assetsmanager.building", columns5, columnValues5);
        if (zonedel != null) {
            msg = "success";
        } else {
            msg = "failed";
        }
        return msg;
    }
}
