/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.assetsmanager.Assetclassification;
import com.iics.assetsmanager.Assets;
import com.iics.service.GenericClassService;
import com.iics.store.Facilityorderitems;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
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
@RequestMapping("/medicalandnonmedicalequipment")
public class MedicalAndNonMedicalEquipment {

    public static String sys_info = null;
    protected static Log logger = LogFactory.getLog("controller");
    DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    @Autowired
    GenericClassService genericClassService;

    @RequestMapping(value = "/medicalEquipmentPane", method = RequestMethod.GET)
    public String medicalEquipmentPane(HttpServletRequest request, Model model) {
        //FETCHING MEDICAL EQUIPMENT CLASSIFICATIONS.
        List<Map> classifications = new ArrayList<>();

        String[] paramszrrp = {"allocationtype"};
        Object[] paramsValueszrrp = {"MEDICALEQUIPMENT"};
        String[] fieldszrrp = {"assetclassificationid", "classificationname", "moreinfo"};
        String wherezrrp = "WHERE allocationtype=:allocationtype";
        List<Object[]> classification = (List<Object[]>) genericClassService.fetchRecord(Assetclassification.class, fieldszrrp, wherezrrp, paramszrrp, paramsValueszrrp);
        if (classification != null) {
            Map<String, Object> assetclassfy;
            for (Object[] dp : classification) {
                assetclassfy = new HashMap<>();
                assetclassfy.put("assetclassificationid", dp[0]);
                assetclassfy.put("classificationname", dp[1]);
                assetclassfy.put("moreinfo", dp[2]);

                int numberOfAssets = 0;
                String[] params9 = {"assetclassificationid"};
                Object[] paramsValues9 = {dp[0]};
                String where9 = "WHERE assetclassificationid=:assetclassificationid";
                numberOfAssets = genericClassService.fetchRecordCount(Assets.class, where9, params9, paramsValues9);
                assetclassfy.put("numberOfAssets", numberOfAssets);

                classifications.add(assetclassfy);
            }
        }
        model.addAttribute("viewAssetClassificationList", classifications);

        return "controlPanel/universalPanel/medicalEquipments/medicalEquipmentPane";
    }

//FETCHING NON-MEDICAL EQUIPMENT CLASSIFICATIONS 
    @RequestMapping(value = "/nonMedicalEquipmentPane", method = RequestMethod.GET)
    public String nonMedicalEquipmentPane(HttpServletRequest request, Model model) {

        List<Map> classifications = new ArrayList<>();

        String[] paramszrrp = {"allocationtype"};
        Object[] paramsValueszrrp = {"NONMEDICALEQUIPMENT"};
        String[] fieldszrrp = {"assetclassificationid", "classificationname", "moreinfo"};
        String wherezrrp = "WHERE allocationtype=:allocationtype";
        List<Object[]> classification = (List<Object[]>) genericClassService.fetchRecord(Assetclassification.class, fieldszrrp, wherezrrp, paramszrrp, paramsValueszrrp);
        if (classification != null) {
            Map<String, Object> assetclassfy;
            for (Object[] dp : classification) {
                assetclassfy = new HashMap<>();
                assetclassfy.put("assetclassificationid", dp[0]);
                assetclassfy.put("classificationname", dp[1]);
                assetclassfy.put("moreinfo", dp[2]);

                int numberOfAssets = 0;
                String[] params9 = {"assetclassificationid"};
                Object[] paramsValues9 = {dp[0]};
                String where9 = "WHERE assetclassificationid=:assetclassificationid";
                numberOfAssets = genericClassService.fetchRecordCount(Assets.class, where9, params9, paramsValues9);
                assetclassfy.put("numberOfAssets", numberOfAssets);

                classifications.add(assetclassfy);
            }
        }
        model.addAttribute("viewNonMedicalAssetsClassificationList", classifications);

        return "controlPanel/universalPanel/medicalEquipments/views/nonMedicalPane";
    }

    //FETCHING MEDICAL EQUIPMENT CLASSIFICATION INTERFACE.
    @RequestMapping(value = "/addNewClassification", method = RequestMethod.GET)
    public String addNewClassification(HttpServletRequest request, Model model) {

        return "controlPanel/universalPanel/medicalEquipments/forms/addClassification";
    }

    //FETCHING NON MEDICAL EQUIPMENT CLASSIFICATION INTERFACE.
    @RequestMapping(value = "/addNewNonClassification", method = RequestMethod.GET)
    public String addNewNonClassification(HttpServletRequest request, Model model) {

        return "controlPanel/universalPanel/medicalEquipments/forms/addNonMedicalClassification";
    }

    //ADD MEDICAL ASSET INTERFACE
    @RequestMapping(value = "/addNewItem", method = RequestMethod.GET)
    public String addNewItem(HttpServletRequest request, Model model) {

        int assetclassificationid = Integer.parseInt(request.getParameter("assetclassificationid"));
        String classificationname = request.getParameter("classificationname");

        model.addAttribute("assetclassificationid", assetclassificationid);
        model.addAttribute("classificationname", classificationname);

        return "controlPanel/universalPanel/medicalEquipments/forms/addNewItem";
    }

    //ADD NON MEDICAL ASSET INTERFACE
    @RequestMapping(value = "/addNewNonMedicalItem", method = RequestMethod.GET)
    public String addNewNonMedicalItem(HttpServletRequest request, Model model) {

        int assetclassificationid = Integer.parseInt(request.getParameter("assetclassificationid"));
        String classificationname = request.getParameter("classificationname");

        model.addAttribute("assetclassificationid", assetclassificationid);
        model.addAttribute("classificationname", classificationname);

        return "controlPanel/universalPanel/medicalEquipments/forms/addNewNonItem";
    }

    //FETCHING ASSETS THAT BELONG TO THIS MEDICAL EQUIPMENT CLASSIFICATION.
    @RequestMapping(value = "/viewMedicalEquipment", method = RequestMethod.GET)
    public String viewMedicalEquipment(HttpServletRequest request, Model model) {

        int assetclassificationid = Integer.parseInt(request.getParameter("assetclassificationid"));
        String classificationname = request.getParameter("classificationname");

        model.addAttribute("assetclassificationid", assetclassificationid);
        model.addAttribute("classificationname", classificationname);

        List<Map> assets = new ArrayList<>();

        String[] paramszrrp = {"assetclassificationid"};
        Object[] paramsValueszrrp = {assetclassificationid};
        String[] fieldszrrp = {"assetsid", "assetsname", "moreinfo"};
        String wherezrrp = "WHERE assetclassificationid=:assetclassificationid";
        List<Object[]> asset = (List<Object[]>) genericClassService.fetchRecord(Assets.class, fieldszrrp, wherezrrp, paramszrrp, paramsValueszrrp);
        if (asset != null) {
            Map<String, Object> asst;
            for (Object[] a : asset) {
                asst = new HashMap<>();
                asst.put("assetsid", a[0]);
                asst.put("assetsname", a[1]);
                asst.put("moreinfo", a[2]);

                assets.add(asst);
            }
        }
        model.addAttribute("viewAssetsList", assets);

        return "controlPanel/universalPanel/medicalEquipments/views/viewMedicalItems";
    }

    //FETCHING ASSETS THAT BELONG A NON-MEDICAL EQUIPMENT CLASSIFICATION.
    @RequestMapping(value = "/viewNonMedicalEquipment", method = RequestMethod.GET)
    public String viewNonMedicalEquipment(HttpServletRequest request, Model model) {

        int assetclassificationid = Integer.parseInt(request.getParameter("assetclassificationid"));
        String classificationname = request.getParameter("classificationname");

        model.addAttribute("assetclassificationid", assetclassificationid);
        model.addAttribute("classificationname", classificationname);

        List<Map> assets = new ArrayList<>();

        String[] paramszrrp = {"assetclassificationid"};
        Object[] paramsValueszrrp = {assetclassificationid};
        String[] fieldszrrp = {"assetsid", "assetsname", "moreinfo"};
        String wherezrrp = "WHERE assetclassificationid=:assetclassificationid";
        List<Object[]> asset = (List<Object[]>) genericClassService.fetchRecord(Assets.class, fieldszrrp, wherezrrp, paramszrrp, paramsValueszrrp);
        if (asset != null) {
            Map<String, Object> asst;
            for (Object[] a : asset) {
                asst = new HashMap<>();
                asst.put("assetsid", a[0]);
                asst.put("assetsname", a[1]);
                asst.put("moreinfo", a[2]);

                assets.add(asst);
            }
        }
        model.addAttribute("viewNonMedicalAssetsList", assets);

        return "controlPanel/universalPanel/medicalEquipments/views/viewNonMedicalItems";
    }

    //CHECKING MEDICAL CLASSIFICATION NAME 
    @RequestMapping(value = "/checkMedicalClassificationName", method = RequestMethod.POST)
    public @ResponseBody
    String checkMedicalClassificationName(HttpServletRequest request, Model model, @ModelAttribute("searchValue") String classificationname) {
        String results = "";
        try {
            String[] paramszrrp = {"allocationtype", "classificationname"};
            Object[] paramsValueszrrp = {"MEDICALEQUIPMENT", classificationname.trim().toLowerCase() + "%"};
            String[] fieldszrrp = {"assetclassificationid", "classificationname", "moreinfo"};
            String wherezrrp = "WHERE allocationtype=:allocationtype AND (LOWER(classificationname) LIKE :classificationname)";
            List<Object[]> classification = (List<Object[]>) genericClassService.fetchRecord(Assetclassification.class, fieldszrrp, wherezrrp, paramszrrp, paramsValueszrrp);
            if (classification != null) {
                results = "exists";
            } else {
                results = "doesnotexists";
            }
        } catch (Exception ex) {
            return "Failed";
        }

        return results;
    }

    //CHECKING NON MEDICAL CLASSIFICATION NAME 
    @RequestMapping(value = "/checkNonMedicalClassificationName", method = RequestMethod.POST)
    public @ResponseBody
    String checkNonMedicalClassificationName(HttpServletRequest request, Model model, @ModelAttribute("searchValue") String classificationname) {
        String results = "";
        try {
            String[] paramszrrp = {"allocationtype", "classificationname"};
            Object[] paramsValueszrrp = {"NONMEDICALEQUIPMENT", classificationname.trim().toLowerCase() + "%"};
            String[] fieldszrrp = {"assetclassificationid", "classificationname", "moreinfo"};
            String wherezrrp = "WHERE allocationtype=:allocationtype AND (LOWER(classificationname) LIKE :classificationname)";
            List<Object[]> classification = (List<Object[]>) genericClassService.fetchRecord(Assetclassification.class, fieldszrrp, wherezrrp, paramszrrp, paramsValueszrrp);
            if (classification != null) {
                results = "exists";
            } else {
                results = "doesnotexists";
            }
        } catch (Exception ex) {
            return "Failed";
        }

        return results;
    }
     
    //CHECKING NON MEDICAL EQUIPMENT NAME 
    
     @RequestMapping(value = "/checkEquipmentName", method = RequestMethod.POST)
    public @ResponseBody
    String checkNonMedicalEquipmentName(HttpServletRequest request, Model model, @ModelAttribute("searchValue") String assetsname, @ModelAttribute("assetclassificationid") int assetclassificationid) {
        String results = "";
        try {
            String[] paramszrrp = {"assetclassificationid", "assetsname"};
            Object[] paramsValueszrrp = {assetclassificationid, assetsname.trim().toLowerCase() + "%"};
            String[] fieldszrrp = {"assetsid", "assetsname", "moreinfo"};
            String wherezrrp = "WHERE assetclassificationid=:assetclassificationid AND (LOWER(assetsname) LIKE :assetsname)";
            List<Object[]> assets = (List<Object[]>) genericClassService.fetchRecord(Assets.class, fieldszrrp, wherezrrp, paramszrrp, paramsValueszrrp);
            if (assets != null) {
                results = "exists";
            } else {
                results = "doesnotexists";
            }
        } catch (Exception ex) {
            return "Failed";
        }

        return results;
    }

    //SAVING MEDICAL EQUIPMENT CLASSIFICATIONS
    @RequestMapping(value = "/saveClassification", method = RequestMethod.POST)
    public @ResponseBody
    String saveClassification(HttpServletRequest request, Model model, @ModelAttribute("classifications") String classifications) {
        Set<Integer> classificationsids = new HashSet<>();
        String results = "";
        try {
            List<Map> classificationsList = new ObjectMapper().readValue(classifications, List.class);
            for (Map item : classificationsList) {
                Map<String, Object> map = (HashMap) item;

                Assetclassification assetsClass = new Assetclassification();
                Object addedbyname = request.getSession().getAttribute("person_id");
                Object updatedbyname = request.getSession().getAttribute("person_id");

//                assetsClass.setFacilityid(facilityid);
                assetsClass.setClassificationname((String) map.get("className"));
                assetsClass.setMoreinfo((String) map.get("description"));
                assetsClass.setAllocationtype("MEDICALEQUIPMENT");
                assetsClass.setDateadded(new Date());
                assetsClass.setDateupdated(new Date());
                assetsClass.setAddedby((Long) addedbyname);
                assetsClass.setUpdatedby((Long) updatedbyname);

                Object save = genericClassService.saveOrUpdateRecordLoadObject(assetsClass);
                if (save != null) {
                    results = "Success";
                }
            }

        } catch (IOException ex) {
            return "Failed";
        }

        return results;
    }

    //SAVING NON-MEDICAL EQUIPMENT CLASSIFICATION 
    @RequestMapping(value = "/saveNonMedicalClassification", method = RequestMethod.POST)
    public @ResponseBody
    String saveNonMedicalClassification(HttpServletRequest request, Model model, @ModelAttribute("classifications") String nonMedicalClassifications) {
        Set<Integer> classificationsids = new HashSet<>();
        String results = "";
        try {
            List<Map> classificationsList = new ObjectMapper().readValue(nonMedicalClassifications, List.class);
            for (Map item : classificationsList) {
                Map<String, Object> map = (HashMap) item;

                Assetclassification assetsClass = new Assetclassification();
                Object addedbyname = request.getSession().getAttribute("person_id");
                Object updatedbyname = request.getSession().getAttribute("person_id");

//                assetsClass.setFacilityid(facilityid);
                assetsClass.setClassificationname((String) map.get("className"));
                assetsClass.setMoreinfo((String) map.get("description"));
                assetsClass.setAllocationtype("NONMEDICALEQUIPMENT");
                assetsClass.setDateadded(new Date());
                assetsClass.setDateupdated(new Date());
                assetsClass.setAddedby((Long) addedbyname);
                assetsClass.setUpdatedby((Long) updatedbyname);

                Object save = genericClassService.saveOrUpdateRecordLoadObject(assetsClass);
                if (save != null) {
                    results = "Success";
                }
            }

        } catch (IOException ex) {
            return "Failed";
        }

        return results;
    }

    //UPDATING MEDICAL EQUIPMENT CLASSIFICATION DETAILS
    @RequestMapping(value = "/updateClassificationDetails.htm")
    public @ResponseBody
    String updateClassificationDetails(Model model, HttpServletRequest request) {

        String results = "";
        Object updatedbyname = request.getSession().getAttribute("person_id");

        String classificationname = request.getParameter("classificationname");
        String description = request.getParameter("description");
        int assetclassificationid = Integer.parseInt(request.getParameter("assetclassificationid"));

        String[] columns = {"classificationname", "moreinfo", "updatedby", "dateupdated"};
        Object[] columnValues = {classificationname, description, updatedbyname, new Date()};
        String pk = "assetclassificationid";
        Object pkValue = assetclassificationid;
        Object update = genericClassService.updateRecordSQLSchemaStyle(Assetclassification.class, columns, columnValues, pk, pkValue, "assetsmanager");
        if (update != null) {
            results = "success";
        } else {
            results = "failed";
        }

        return results;
    }

    //UPDATING MEDICAL EQUIPMENT DETAILS
    @RequestMapping(value = "/updateEquipmentDetails.htm")
    public @ResponseBody
    String updateEquipmentDetails(Model model, HttpServletRequest request) {

        String results = "";
        Object updatedbyname = request.getSession().getAttribute("person_id");

        String assetsname = request.getParameter("assetsname");
        String description = request.getParameter("description");
        int assetsid = Integer.parseInt(request.getParameter("assetsid"));

        String[] columns = {"assetsname", "moreinfo", "updatedby", "dateupdated"};
        Object[] columnValues = {assetsname, description, updatedbyname, new Date()};
        String pk = "assetsid";
        Object pkValue = assetsid;
        Object update = genericClassService.updateRecordSQLSchemaStyle(Assets.class, columns, columnValues, pk, pkValue, "assetsmanager");
        if (update != null) {
            results = "success";
        } else {
            results = "failed";
        }

        return results;
    }

    //SAVING MEDICAL EQUIPMENT
    @RequestMapping(value = "/saveEquipment", method = RequestMethod.POST)
    public @ResponseBody
    String saveEquipment(HttpServletRequest request, Model model, @ModelAttribute("assetclassificationid") int assetclassificationid, @ModelAttribute("equipments") String equipments) {
        Set<Integer> assetsids = new HashSet<>();
        String results = "";
        try {
            List<Map> assetsList = new ObjectMapper().readValue(equipments, List.class);
            for (Map item : assetsList) {
                Map<String, Object> map = (HashMap) item;

                Assets assets = new Assets();
                Object addedbyname = request.getSession().getAttribute("person_id");
                Object updatedbyname = request.getSession().getAttribute("person_id");

//                assetsClass.setFacilityid(facilityid);
                assets.setAssetsname((String) map.get("itemname"));
                assets.setMoreinfo((String) map.get("description"));
                assets.setAssetclassificationid(assetclassificationid);
                assets.setAssettype("MEDICALEQUIPMENT");
                assets.setDateadded(new Date());
                assets.setDateupdated(new Date());
                assets.setAddedby((Long) addedbyname);
                assets.setUpdatedby((Long) updatedbyname);

                Object save = genericClassService.saveOrUpdateRecordLoadObject(assets);
                if (save != null) {
                    results = "Success";
                }
            }

        } catch (IOException ex) {
            return "Failed";
        }

        return results;
    }

    //SAVING NON MEDICAL EQUIPMENT
    @RequestMapping(value = "/saveNonMedicalEquipment", method = RequestMethod.POST)
    public @ResponseBody
    String saveNonMedicalEquipment(HttpServletRequest request, Model model, @ModelAttribute("assetclassificationid") int assetclassificationid, @ModelAttribute("equipments") String equipments) {
        Set<Integer> assetsids = new HashSet<>();
        String results = "";
        try {
            List<Map> assetsList = new ObjectMapper().readValue(equipments, List.class);
            for (Map item : assetsList) {
                Map<String, Object> map = (HashMap) item;

                Assets assets = new Assets();
                Object addedbyname = request.getSession().getAttribute("person_id");
                Object updatedbyname = request.getSession().getAttribute("person_id");

//                assetsClass.setFacilityid(facilityid);
                assets.setAssetsname((String) map.get("itemname"));
                assets.setMoreinfo((String) map.get("description"));
                assets.setAssetclassificationid(assetclassificationid);
                assets.setAssettype("NONMEDICALEQUIPMENT");
                assets.setDateadded(new Date());
                assets.setDateupdated(new Date());
                assets.setAddedby((Long) addedbyname);
                assets.setUpdatedby((Long) updatedbyname);

                Object save = genericClassService.saveOrUpdateRecordLoadObject(assets);
                if (save != null) {
                    results = "Success";
                }
            }

        } catch (IOException ex) {
            return "Failed";
        }

        return results;
    }

}
