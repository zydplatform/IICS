///*
// * To change this license header, choose License Headers in Project Properties.
// * To change this template file, choose Tools | Templates
// * and open the template in the editor.
// */
//package com.iics.web;
//
//import com.fasterxml.jackson.databind.ObjectMapper;
//import com.iics.assetsmanager.Assetallocation;
//import com.iics.assetsmanager.Assetclassification;
//import com.iics.assetsmanager.Building;
//import com.iics.assetsmanager.Facilityblock;
//import com.iics.assetsmanager.Blockroom;
//import com.iics.assetsmanager.Assets;
//import com.iics.assetsmanager.Blockfloor;
//import com.iics.domain.Countrycurrency;
//import org.springframework.stereotype.Controller;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import com.iics.service.GenericClassService;
//import java.io.IOException;
//import java.text.DateFormat;
//import java.text.SimpleDateFormat;
//import java.util.ArrayList;
//import java.util.Date;
//import javax.servlet.http.HttpServletRequest;
//import java.util.HashMap;
//import java.util.HashSet;
//import java.util.List;
//import java.util.Map;
//import java.util.Set;
//import com.iics.domain.Facility;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.ModelAttribute;
//import org.springframework.web.bind.annotation.ResponseBody;
//
///**
// *
// * @author RESEARCH
// */
//@Controller
//@RequestMapping("/assetsmanagement")
//public class AssetsManagement {
//
//    DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
//    @Autowired
//    GenericClassService genericClassService;
//
//    @RequestMapping(value = "/assetmanagementPane", method = RequestMethod.GET)
//    public String AssetManagementPane(HttpServletRequest request, Model model) {
//
//        int facilityid = (int) request.getSession().getAttribute("sessionActiveLoginFacility");
//        //FACILITY ID AND NAME
//        Facility facilityDesignations = new Facility();
//        String[] paramsfacility = {"facilityid"};
//        Object[] paramsValuesfacility = {facilityid};
//        String[] fieldsfacility = {"facilityid", "facilityname", "facilitydomainid"};
//        String wherefacility = "WHERE facilityid=:facilityid";
//        List<Object[]> facility = (List<Object[]>) genericClassService.fetchRecord(Facility.class, fieldsfacility, wherefacility, paramsfacility, paramsValuesfacility);
//
//        if (facility != null) {
//
//            facilityDesignations.setFacilityid((Integer) facility.get(0)[0]);
//            facilityDesignations.setFacilityname((String) facility.get(0)[1]);
//
//            model.addAttribute("FacilityList", facilityDesignations);
//
//        }
//
//        List<Assetclassification> classifications = new ArrayList<>();
//
//        String[] paramszrrp = {"facilityid"};
//        Object[] paramsValueszrrp = {facilityid};
//        String[] fieldszrrp = {"assetclassificationid", "facilityid", "classificationname", "allocationtype", "assetsnumber"};
//        String wherezrrp = "WHERE r.facilityid=:facilityid ORDER BY r.classificationname ASC";
//
//        List<Object[]> classification = (List<Object[]>) genericClassService.fetchRecord(Assetclassification.class, fieldszrrp, wherezrrp, paramszrrp, paramsValueszrrp);
//
//        if (classification != null) {
//            for (Object[] dp : classification) {
//                Assetclassification assetclassfy = new Assetclassification();
//                assetclassfy.setAssetclassificationid((Integer) dp[0]);
////                assetclassfy.setFacilityid((Integer) dp[1]);
//                assetclassfy.setClassificationname((String) dp[2]);
//                assetclassfy.setAllocationtype((String) dp[3]);
////                int count = genericClassService.fetchRecordCount(Assets.class, "WHERE assetclassificationid=:assetclassificationid", new String[]{"assetclassificationid"}, new Object[]{assetclassfy.getAssetclassificationid()});
////                assetclassfy.setAssetsnumber(count);
//
//                classifications.add(assetclassfy);
//            }
//        }
//        model.addAttribute("viewClassificationList", classifications);
//        return "controlPanel/localSettingsPanel/assetsmanagement/assetsmanagementpane";
//
//    }
//
//    @RequestMapping(value = "/viewassets", method = RequestMethod.GET)
//    public String ViewAssets(HttpServletRequest request, Model model) {
//        List<Assets> Asts = new ArrayList<>();
//        int classificationid = Integer.parseInt(request.getParameter("classificationId"));
//        String classificationname = request.getParameter("classificationName");
//
//        model.addAttribute("classificationid", classificationid);
//        model.addAttribute("classificationname", classificationname);
//
//        String[] paramszrrp = {"assetclassificationid"};
//        Object[] paramsValueszrrp = {classificationid};
//        String[] fieldszrrp = {"assetsid", "assetclassificationid", "assetsname", "assetidentifier"};
//        String wherezrrp = "WHERE r.assetclassificationid=:assetclassificationid ORDER BY r.assetsname ASC";
//
//        List<Object[]> ass = (List<Object[]>) genericClassService.fetchRecord(Assets.class, fieldszrrp, wherezrrp, paramszrrp, paramsValueszrrp);
//
//        if (ass != null) {
//            for (Object[] dp : ass) {
//                Assets Ass = new Assets();
//                Ass.setAssetsid((Integer) dp[0]);
//                Ass.setAssetclassificationid((Integer) dp[1]);
//                Ass.setAssetsname((String) dp[2]);
////                Ass.setAssetidentifier((String) dp[3]);
//                //Ass.setIsactive((Boolean) dp[3]);
//                Asts.add(Ass);
//            }
//        }
//        model.addAttribute("viewAssetsInClassification", Asts);
//
//        return "controlPanel/localSettingsPanel/assetsmanagement/views/viewassets";
//
//    }
//
//    @RequestMapping(value = "/saveclassifications", method = RequestMethod.POST)
//    public @ResponseBody
//    String saveClassifications(HttpServletRequest request, Model model, @ModelAttribute("classifications") String classifications) {
//        Set<Integer> classificationsids = new HashSet<>();
//        String results = "";
//        int facilityid = (int) request.getSession().getAttribute("sessionActiveLoginFacility");
//        try {
//            List<Map> classificationsList = new ObjectMapper().readValue(classifications, List.class);
//            for (Map item : classificationsList) {
//                Map<String, Object> map = (HashMap) item;
//
//                Assetclassification assetsClass = new Assetclassification();
//                Object addedbyname = request.getSession().getAttribute("person_id");
//                Object updatedbyname = request.getSession().getAttribute("person_id");
//
////                assetsClass.setFacilityid(facilityid);
//                assetsClass.setClassificationname((String) map.get("classificationName"));
//                assetsClass.setAllocationtype((String) map.get("allocationtype"));
//                assetsClass.setDateadded(new Date());
//                assetsClass.setDateupdated(new Date());
//                assetsClass.setAddedby((Long) addedbyname);
//                assetsClass.setUpdatedby((Long) updatedbyname);
//
//                Object save = genericClassService.saveOrUpdateRecordLoadObject(assetsClass);
//                if (save != null) {
//                    classificationsids.add(assetsClass.getAssetclassificationid());
//                }
//            }
//
//        } catch (IOException ex) {
//            return "Failed";
//        }
//
//        return results;
//    }
//
//    @RequestMapping(value = "/UpdateassetClassification.htm")
//    public @ResponseBody
//    String UpdateassetClassification(Model model, HttpServletRequest request) {
//
//        String classificationname = request.getParameter("classificationname");
//        String allocationtype = request.getParameter("allocationtype");
//        int assetclassificationid = Integer.parseInt(request.getParameter("assetclassificationid"));
//
//        String[] columns = {"classificationname", "allocationtype", "assetclassificationid"};
//        Object[] columnValues = {classificationname, allocationtype, assetclassificationid};
//        String pk = "assetclassificationid";
//        Object pkValue = assetclassificationid;
//        genericClassService.updateRecordSQLSchemaStyle(Assetclassification.class, columns, columnValues, pk, pkValue, "assetsmanager");
//        return "";
//    }
//
//    @RequestMapping(value = "/addasset", method = RequestMethod.GET)
//    public String AddAsset(HttpServletRequest request, @ModelAttribute("tablerowid") int tablerowid, @ModelAttribute("tableData") String tableData, Model model) {
//
//        model.addAttribute("classificationname", request.getParameter("tableData"));
//        model.addAttribute("classificationid", request.getParameter("tablerowid"));
//
//        return "controlPanel/localSettingsPanel/assetsmanagement/forms/addasset";
//
//    }
//
//    @RequestMapping(value = "/saveassets", method = RequestMethod.POST)
//    public @ResponseBody
//    String saveAssets(HttpServletRequest request, Model model, @ModelAttribute("assets") String assets, @ModelAttribute("classId") int classId) {
//        Set<Integer> assetids = new HashSet<>();
//        String results = "";
//        int facilityid = (int) request.getSession().getAttribute("sessionActiveLoginFacility");
//        try {
//            List<Map> assetsList = new ObjectMapper().readValue(assets, List.class);
//            for (Map item : assetsList) {
//                Map<String, Object> map = (HashMap) item;
//
//                Assets asset = new Assets();
//                Object addedbynamed = request.getSession().getAttribute("person_id");
//                Object updatedbynamed = request.getSession().getAttribute("person_id");
//
//                asset.setAssetclassificationid((Integer) classId);
//                asset.setAssetsname((String) map.get("assetName"));
//                asset.setDateadded(new Date());
//                asset.setDateupdated(new Date());
//                asset.setAddedby((Long) addedbynamed);
//                asset.setUpdatedby((Long) updatedbynamed);
//
//                Object save = genericClassService.saveOrUpdateRecordLoadObject(asset);
//                if (save != null) {
//                    assetids.add(asset.getAssetsid());
//                }
//            }
//
//        } catch (IOException ex) {
//            return "Failed";
//        }
//
//        return results;
//    }
//
//    @RequestMapping(value = "/Updateasset.htm")
//    public @ResponseBody
//    String UpdateAsset(Model model, HttpServletRequest request) {
//
//        String assetsname = request.getParameter("assetname");
//        String assetuniqueid = request.getParameter("assetuniqueid");
//        int assetsid = Integer.parseInt(request.getParameter("assetid"));
//
//        String[] columns = {"assetsname", "assetuniqueid", "assetsid"};
//        Object[] columnValues = {assetsname, assetuniqueid, assetsid};
//        String pk = "assetsid";
//        Object pkValue = assetsid;
//        genericClassService.updateRecordSQLSchemaStyle(Assets.class, columns, columnValues, pk, pkValue, "assetsmanager");
//        return "";
//    }
//
//    @RequestMapping(value = "/assigndeassignassets", method = RequestMethod.GET)
//    public String assignDeassignAssets(HttpServletRequest request, Model model) {
//
//        List<Assets> Asts = new ArrayList<>();
//        List<Assets> Astsn = new ArrayList<>();
//        String[] paramszrrp = {};
//        Object[] paramsValueszrrp = {};
//        String[] fieldszrrp = {"assetsid", "assetclassificationid", "assetsname", "assetidentifier", "isactive"};
//
//        List<Object[]> ass = (List<Object[]>) genericClassService.fetchRecord(Assets.class, fieldszrrp, "", paramszrrp, paramsValueszrrp);
//
//        if (ass != null) {
//            for (Object[] dp : ass) {
//                Assets Ass = new Assets();
//                if ((Boolean) dp[4]) {
//                    Ass.setAssetsid((Integer) dp[0]);
//                    Ass.setAssetclassificationid((Integer) dp[1]);
//                    Ass.setAssetsname((String) dp[2]);
////                    Ass.setAssetidentifier((String) dp[3]);
////                    Ass.setIsactive((Boolean) dp[4]);
//                    Asts.add(Ass);
//                } else {
//                    Ass.setAssetsid((Integer) dp[0]);
//                    Ass.setAssetclassificationid((Integer) dp[1]);
//                    Ass.setAssetsname((String) dp[2]);
////                    Ass.setAssetidentifier((String) dp[3]);
////                    Ass.setIsactive((Boolean) dp[4]);
//                    Astsn.add(Ass);
//                }
//
//            }
//        }
//        model.addAttribute("viewAllAssignedAssets", Asts);
//        model.addAttribute("viewAllUnAssignedAssets", Astsn);
//
//        List<Map> buildList = new ArrayList<>();
//        int facilityid = (int) request.getSession().getAttribute("sessionActiveLoginFacility");
//
//        String[] params = {"facilityid"};
//        Object[] paramsValues = {facilityid};
//        String[] fields = {"facilityid", "buildingid", "buildingname", "isactive"};
//        String where = "WHERE facilityid=:facilityid";
//        List<Object[]> Fbld = (List<Object[]>) genericClassService.fetchRecord(Building.class, fields, where, params, paramsValues);
//        Map<String, Object> fbuilds;
//        if (Fbld != null) {
//            for (Object[] fbld : Fbld) {
//                fbuilds = new HashMap<>();
//                fbuilds.put("facilityid", (Integer) fbld[0]);
//                fbuilds.put("buildingid", (Integer) fbld[1]);
//                fbuilds.put("buildingname", (String) fbld[2]);
//                fbuilds.put("isactive", (Boolean) fbld[3]);
//                int count = genericClassService.fetchRecordCount(Facilityblock.class, "WHERE buildingid=:buildingid", new String[]{"buildingid"}, new Object[]{(Integer) fbld[1]});
//
//                fbuilds.put("blocksize", count);
//                buildList.add(fbuilds);
//            }
//        }
//        model.addAttribute("BuildingsLists", buildList);
//
//        String jsonBuildingList = "";
//
//        try {
//            jsonBuildingList = new ObjectMapper().writeValueAsString(buildList);
//        } catch (Exception e) {
//            System.out.println(e);
//        }
//        model.addAttribute("jsonbuildings", jsonBuildingList);
//
//        List<Map> assetlist = new ArrayList<>();
//        List<Map> assetslist;
//        String[] params62 = {"isallocated"};
//        Object[] paramsValues62 = {Boolean.TRUE};
//        String[] fields62 = {"assetallocationid", "isallocated", "assetcurrentlocation", "blockroomid", "assetsid"};
//        String where62 = "WHERE isallocated=:isallocated";
//        List<Object[]> found62 = (List<Object[]>) genericClassService.fetchRecord(Assetallocation.class, fields62, where62, params62, paramsValues62);
//        Map<String, Object> assets;
//
//        if (found62 != null) {
//            for (Object[] req : found62) {
//                assets = new HashMap<>();
//                assets.put("isallocated", (Boolean) req[1]);
//
//                String[] params8 = {"assetsid"};
//                Object[] paramsValues8 = {(int) req[4]};
//                String[] fields8 = {"assetsid", "assetsname", "assetidentifier"};
//                String where8 = "WHERE assetsid=:assetsid";
//                List<Object[]> found8 = (List<Object[]>) genericClassService.fetchRecord(Assets.class, fields8, where8, params8, paramsValues8);
//                if (found8 != null) {
//                    Object[] f8 = found8.get(0);
//
//                    assets.put("assetsid", (int) f8[0]);
//                    assets.put("assetsname", (String) f8[1]);
//                    assets.put("assetidentifier", (String) f8[2]);
//
//                    assetlist.add(assets);
//                }
//            }
//        }
//
//        model.addAttribute("viewAllAssignedAsset", assetlist);
//         List<Map> assetlists = new ArrayList<>();
//        List<Map> assetslists;
//        String[] params6 = {"isallocated"};
//        Object[] paramsValues6 = {Boolean.FALSE};
//        String[] fields6 = {"assetallocationid", "isallocated", "assetcurrentlocation", "blockroomid", "assetsid"};
//        String where6 = "WHERE isallocated=:isallocated";
//        List<Object[]> found6 = (List<Object[]>) genericClassService.fetchRecord(Assetallocation.class, fields6, where6, params6, paramsValues6);
//        Map<String, Object> assets6;
//
//        if (found6 != null) {
//            for (Object[] req : found6) {
//                assets6 = new HashMap<>();
//                assets6.put("isallocated", (Boolean) req[1]);
//
//                String[] params8 = {"assetsid"};
//                Object[] paramsValues8 = {(int) req[4]};
//                String[] fields8 = {"assetsid", "assetsname", "assetidentifier"};
//                String where8 = "WHERE assetsid=:assetsid";
//                List<Object[]> found8 = (List<Object[]>) genericClassService.fetchRecord(Assets.class, fields8, where8, params8, paramsValues8);
//                if (found8 != null) {
//                    Object[] f8 = found8.get(0);
//
//                    assets6.put("assetsid", (int) f8[0]);
//                    assets6.put("assetsname", (String) f8[1]);
//                    assets6.put("assetidentifier", (String) f8[2]);
//
//                    assetlists.add(assets6);
//                }
//                
//                String[] params81 = {"blockroomid"};
//                Object[] paramsValues81 = {(int) req[3]};
//                String[] fields81 = {"blockroomid", "roomname"};
//                String where81 = "WHERE blockroomid=:blockroomid";
//                List<Object[]> found81 = (List<Object[]>) genericClassService.fetchRecord(Blockroom.class, fields81, where81, params81, paramsValues81);
//                if (found81 != null) {
//                    Object[] f81 = found81.get(0);
//
//                    assets6.put("blockroomid", (int) f81[0]);
//                    assets6.put("roomname", (String) f81[1]);
//
//                    assetlists.add(assets6);
//                }
//            }
//        }
//
//        model.addAttribute("viewAllUnAssignedAsset", assetlists);
//
//        return "controlPanel/localSettingsPanel/assetsmanagement/views/assignanddeassignassets";
//
//    }
//
//    @RequestMapping(value = "/assignedblocksorRooms")
//    public @ResponseBody
//    String assignedblocksorRooms(HttpServletRequest request, Model model, @ModelAttribute("id") int buildingorblockid, @ModelAttribute("section") int sectionid) {
//        String JsonStringBlockorRoom = "";
//        ObjectMapper mapper = new ObjectMapper();
//        switch (sectionid) {
//            case 1:
//                //get data for blocks
//                List<Facilityblock> FBlks = new ArrayList<>();
//                String[] paramszrrp = {"buildingid"};
//                Object[] paramsValueszrrp = {buildingorblockid};
//                String[] fieldszrrp = {"facilityblockid", "buildingid", "blockname", "status"};
//                String wherezrrp = "WHERE r.buildingid=:buildingid ORDER BY r.blockname ASC";
//                List<Object[]> vblks = (List<Object[]>) genericClassService.fetchRecord(Facilityblock.class, fieldszrrp, wherezrrp, paramszrrp, paramsValueszrrp);
//                if (vblks != null) {
//                    for (Object[] dp : vblks) {
//                        Facilityblock fblk = new Facilityblock();
//                        fblk.setFacilityblockid((Integer) dp[0]);
//                        fblk.setBuildingid((Integer) dp[1]);
//                        fblk.setBlockname((String) dp[2]);
//                        fblk.setStatus((Boolean) dp[3]);
//                        FBlks.add(fblk);
//                    }
//                }
//                try {
//                    JsonStringBlockorRoom = mapper.writeValueAsString(FBlks);
//                } catch (Exception ex) {
//                    System.out.println(ex);
//                }
//                break;
//            case 2:
//                //get data for floors
//                List<Blockfloor> blockFloorz = new ArrayList<>();
//                String[] paramszrfloor = {"facilityblockid", "isactive"};
//                Object[] paramsValueszrfloor = {buildingorblockid, true};
//                String[] fieldszrfloor = {"blockfloorid", "facilityblockid", "floorname", "isactive"};
//                String wherezrfloor = "WHERE r.facilityblockid=:facilityblockid AND r.isactive=:isactive ORDER BY r.floorname ASC";
//
//                List<Object[]> blkflz = (List<Object[]>) genericClassService.fetchRecord(Blockfloor.class, fieldszrfloor, wherezrfloor,paramszrfloor , paramsValueszrfloor);
//
//                if (blkflz != null) {
//                    for (Object[] d : blkflz) {
//                        Blockfloor floors = new Blockfloor();
//                        floors.setBlockfloorid((Integer) d[0]);
//                        floors.setFloorname((String) d[2]);
//                        floors.setIsactive((Boolean) d[3]);
//                        
//                        blockFloorz.add(floors);
//                    }
//                }
//                break;
//                case 3:
//                //get data for rooms
//                List<Blockroom> blockRoomz = new ArrayList<>();
//                String[] paramszrroom = {"blockfloorid", "status"};
//                Object[] paramsValueszrroom = {buildingorblockid, true};
//                String[] fieldszrroom = {"blockroomid", "blockfloorid", "roomname", "description", "status", "roomstatus"};
//                String wherezrroom = "WHERE r.blockfloorid=:blockfloorid AND r.status=:status ORDER BY r.roomname ASC";
//
//                List<Object[]> blkrmz = (List<Object[]>) genericClassService.fetchRecord(Blockroom.class, fieldszrroom, wherezrroom, paramszrroom, paramsValueszrroom);
//
//                if (blkrmz != null) {
//                    for (Object[] dp : blkrmz) {
//                        Blockroom rooms = new Blockroom();
//                        rooms.setBlockroomid((Integer) dp[0]);
//                        //rooms.setFacilityblockid((Integer) dp[1]);
//                        rooms.setRoomname((String) dp[2]);
//                        rooms.setDescription((String) dp[3]);
//                        rooms.setStatus((Boolean) dp[4]);
//                        rooms.setRoomstatus((Boolean) dp[5]);
//                        blockRoomz.add(rooms);
//                    }
//                }
//                try {
//                    JsonStringBlockorRoom = mapper.writeValueAsString(blockRoomz);
//                } catch (Exception ex) {
//                    System.out.println(ex);
//                }
//                break;
//            default:
//                break;
//        }
//
//        return JsonStringBlockorRoom;
//
//    }
//
//    @RequestMapping(value = "/assignassets", method = RequestMethod.GET)
//    public @ResponseBody
//    String AssignAssets(HttpServletRequest request) {
//        String results = "";
//        Date date = new Date();
//        Assets asset = new Assets();
//
//        try {
//            Object addedbynamed = request.getSession().getAttribute("person_id");
//            Object updatedbynamed = request.getSession().getAttribute("person_id");
//            int blockroomid = Integer.parseInt(request.getParameter("blockroomid"));
//            List<String> itemz = (ArrayList) new ObjectMapper().readValue(request.getParameter("assetvalues"), List.class);
//            for (String item : itemz) {
//                Assetallocation assignassets = new Assetallocation();
//                assignassets.setAssetsid(Integer.parseInt(item));
//                assignassets.setBlockroomid(blockroomid);
//                assignassets.setAddedby((Long) addedbynamed);
//                assignassets.setUpdatedby((Long) updatedbynamed);
//                assignassets.setDateupdated(new Date());
//                assignassets.setDateadded(new Date());
//                assignassets.setIsallocated(Boolean.TRUE);
//                assignassets.setAssetcurrentlocation(blockroomid);
//
//                Object save = genericClassService.saveOrUpdateRecordLoadObject(assignassets);
//                if (save != null) {
//                    results = "Saved";
//                }
//                
//                
//                String[] columns = {"isactive", "dateupdated", "updatedby"};
//                Object[] columnValues = {Boolean.TRUE, new Date(), (Long) updatedbynamed};
//                String pk = "assetsid";
//                Object pkValue = Integer.parseInt(item);
//                genericClassService.updateRecordSQLSchemaStyle(Assets.class, columns, columnValues, pk, pkValue, "assetsmanager");
//
//
//            }
//
//        } catch (IOException e) {
//        }
//
//        return results;
//    }
//
//    @RequestMapping(value = "/deassignassets", method = RequestMethod.GET)
//    public @ResponseBody
//    String DeAssignAssets(HttpServletRequest request) {
//        String results = "";
//        Date date = new Date();
//        Assetallocation assignassets = new Assetallocation();
//        Assets asset = new Assets();
//
//        try {
//            Object addedbynamed = request.getSession().getAttribute("person_id");
//            Object updatedbynamed = request.getSession().getAttribute("person_id");
//            int blockroomid = Integer.parseInt(request.getParameter("blockroomid"));
//            List<String> itemz = (ArrayList) new ObjectMapper().readValue(request.getParameter("assetvalues"), List.class);
//            for (String item : itemz) {
//                assignassets.setAssetsid(Integer.parseInt(item));
//                assignassets.setBlockroomid(blockroomid);
//                assignassets.setAddedby((Long) addedbynamed);
//                assignassets.setUpdatedby((Long) updatedbynamed);
//                assignassets.setDateupdated(new Date());
//                assignassets.setDateadded(new Date());
//                assignassets.setIsallocated(Boolean.TRUE);
//
//                Object save = genericClassService.saveOrUpdateRecordLoadObject(assignassets);
//                if (save != null) {
//                    results = "Saved";
//                }
//
//                String[] columns = {"isactive", "dateupdated", "updatedby"};
//                Object[] columnValues = {Boolean.FALSE, new Date(), (Long) updatedbynamed};
//                String pk = "assetsid";
//                Object pkValue = Integer.parseInt(item);
//                genericClassService.updateRecordSQLSchemaStyle(Assets.class, columns, columnValues, pk, pkValue, "assetsmanager");
//
//            }
//
//        } catch (IOException e) {
//        }
//
//        return results;
//    }
//
//}
