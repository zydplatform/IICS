
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.domain.Designation;
import com.iics.domain.Designationcategory;
import com.iics.domain.Facility;
import com.iics.domain.Facilitydesignations;
import com.iics.domain.Facilitydesignationview;
import com.iics.domain.Facilitydomain;
import com.iics.service.GenericClassService;
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
 * @author SAMINUNU
 */
@Controller
@RequestMapping("/localsettingspostsandactivities")
public class LocalPostsAndActivities {

    DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat format = new SimpleDateFormat("dd-MM-yyyy");

    @Autowired
    GenericClassService genericClassService;

    @RequestMapping(value = "/maindesignationpage", method = RequestMethod.GET)
    public String maindesignationpage(HttpServletRequest request, Model model) {
        int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
        List<Map> facDesignationsList = new ArrayList<>();
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

            model.addAttribute("facilityList", facilityDesignations);

        }

        Set<Integer> FacilityDesignations = new HashSet<>();
        String[] paramLocalposts2 = {"facilityid"};
        Object[] paramsValuesLocalposts2 = {facilityid};
        String whereLocalposts2 = "WHERE facilityid=:facilityid";
        String[] fieldsLocalposts2 = {"designationid"};
        List<Integer> objLocalposts2 = (List<Integer>) genericClassService.fetchRecord(Facilitydesignations.class, fieldsLocalposts2, whereLocalposts2, paramLocalposts2, paramsValuesLocalposts2);
        if (objLocalposts2 != null) {
            for (Integer lComps : objLocalposts2) {
                FacilityDesignations.add(lComps);
            }
        }
        Set<Integer> designations = new HashSet<>();

        String[] params4 = {"universaldeletestatus", "deletestatus"};
        Object[] paramsValues4 = {"NOTDELETED", "NOTDELETED"};
        String where4 = "WHERE universaldeletestatus=:universaldeletestatus AND deletestatus=:deletestatus";
        String[] fields4 = {"designationcategoryid"};
        List<Integer> facilitydesignations = (List<Integer>) genericClassService.fetchRecord(Designationcategory.class, fields4, where4, params4, paramsValues4);
        if (facilitydesignations != null) {
            for (Integer Facdesig : facilitydesignations) {

                String[] paramGlobalposts2 = {"designationcategoryid", "universaltransferstatus", "transferstatus"};
                Object[] paramsValuesGlobalposts2 = {Facdesig, "ASSIGNED", "ALLOCATED"};
                String whereGlobalposts2 = "WHERE designationcategoryid=:designationcategoryid AND universaltransferstatus=:universaltransferstatus AND transferstatus=:transferstatus";
                String[] fieldsGlobalposts2 = {"designationid"};
                List<Integer> objGlobalposts2 = (List<Integer>) genericClassService.fetchRecord(Designation.class, fieldsGlobalposts2, whereGlobalposts2, paramGlobalposts2, paramsValuesGlobalposts2);
                if (objGlobalposts2 != null) {
                    for (Integer component2 : objGlobalposts2) {
                        if (FacilityDesignations.contains((component2))) {
                            designations.add(Facdesig);
                        }
                    }
                }

            }

        }

        System.out.println("---------------------FacilityDesignations" + FacilityDesignations);
        System.out.println("---------------------designations" + designations);

        for (int newGlobalDesigCatSet : designations) {
            try {
                String[] paramszr = {"designationcategoryid", "universaldeletestatus", "deletestatus"};
                Object[] paramsValueszr = {newGlobalDesigCatSet, "NOTDELETED", "NOTDELETED"};
                String[] fieldszr = {"designationcategoryid", "categoryname", "description"};
                String wherezr = "WHERE designationcategoryid=:designationcategoryid AND universaldeletestatus=:universaldeletestatus AND deletestatus=:deletestatus";
                List<Object[]> posts = (List<Object[]>) genericClassService.fetchRecord(Designationcategory.class, fieldszr, wherezr, paramszr, paramsValueszr);
                System.out.println("---------------------facDesignationsList0000000000000" + posts);
                if (posts != null) {
                    System.out.println("---------------------facDesignationsList11111100000000000");
                    Map<String, Object> dpost;
                    for (Object[] dp : posts) {
                        dpost = new HashMap<>();

                        dpost.put("designationcategoryid", dp[0]);
                        dpost.put("categoryname", dp[1]);
                        dpost.put("description", dp[2]);

                        int designationscount = 0;

                        String[] params91 = {"designationcategoryid", "universaltransferstatus", "transferstatus", "facilityid"};
                        Object[] paramsValues91 = {newGlobalDesigCatSet, "ASSIGNED", "ALLOCATED", facilityid};
                        String where91 = "WHERE designationcategoryid=:designationcategoryid AND universaltransferstatus=:universaltransferstatus AND transferstatus=:transferstatus AND facilityid=:facilityid";
                        designationscount = genericClassService.fetchRecordCount(Facilitydesignationview.class, where91, params91, paramsValues91);
                        dpost.put("rolessize", designationscount);

                        facDesignationsList.add(dpost);

                        System.out.println("---------------------facDesignationsList111111" + facDesignationsList);
                    }
                    model.addAttribute("designations", facDesignationsList);
                    System.out.println("---------------------facDesignationsList" + facDesignationsList);
                }
                System.out.println("---------------------facDesignationsList22222" + facDesignationsList);

            } catch (Exception ex) {
                System.out.println(ex);
            }
        }

        return "controlPanel/localSettingsPanel/PostsAndActivities/views/maindesigantionpage";
    }

    @RequestMapping(value = "/viewlocalposts", method = RequestMethod.GET)
    public String viewlocalposts(HttpServletRequest request, Model model) {
        List<Map> facilityDesignations = new ArrayList<>();
        List<Map> facilityDesignationsList = new ArrayList<>();

        Integer designationcategoryid = Integer.parseInt(request.getParameter("designationcategoryid"));
        model.addAttribute("designationcategoryid", designationcategoryid);
        model.addAttribute("categoryname", request.getParameter("categoryname"));
        
        System.out.println("--------------------------------designationcategoryid" + designationcategoryid);
        int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());

        String[] params = {"designationcategoryid", "universaltransferstatus", "transferstatus", "facilityid"};
        Object[] paramsValues = {designationcategoryid, "ASSIGNED", "ALLOCATED", facilityid};
        String where = "WHERE designationcategoryid=:designationcategoryid AND universaltransferstatus=:universaltransferstatus AND transferstatus=:transferstatus AND facilityid=:facilityid";
        String[] fields = {"designationid", "designationcategoryid", "designationname"};
        List<Object[]> desig = (List<Object[]>) genericClassService.fetchRecord(Facilitydesignationview.class, fields, where, params, paramsValues);
        if (desig != null) {
            Map<String, Object> facDesignations;
            for (Object[] Desigs : desig) {
                facDesignations = new HashMap<>();
                facDesignations.put("designationid", Desigs[0]);
                facDesignations.put("designationname", Desigs[2]);

                facilityDesignationsList.add(facDesignations);

            }
        }
        model.addAttribute("facilityPostsList", facilityDesignationsList);

        return "controlPanel/localSettingsPanel/PostsAndActivities/views/desigCatPosts";

    }

    @RequestMapping(value = "/editlocalposts", method = RequestMethod.GET)
    public String editlocalposts(HttpServletRequest request, Model model) {

        int designationcategoryid = Integer.parseInt(request.getParameter("designationcategoryid"));
        String categoryname = request.getParameter("categoryname");
        int designationid = Integer.parseInt(request.getParameter("designationid"));
        String designationname = request.getParameter("designationname");
        String description = request.getParameter("description");

        model.addAttribute("designationcategoryid", designationcategoryid);
        model.addAttribute("categoryname", categoryname);
        model.addAttribute("designationid", designationid);
        model.addAttribute("designationname", designationname);
        model.addAttribute("description", description);

        return "controlPanel/localSettingsPanel/PostsAndActivities/views/editpost";

    }

    @RequestMapping(value = "/adddesignations", method = RequestMethod.GET)

    public String AddDesignations(HttpServletRequest request, Model model) {
        if (request.getSession().getAttribute("sessionActiveLoginFacility") != null) {

            int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
            int designationcategoryid = Integer.parseInt(request.getParameter("desigCatId"));
            String desigCatName = request.getParameter("desigCatName");

            model.addAttribute("designationcategoryid", designationcategoryid);
            model.addAttribute("desigCatName", desigCatName);
            //Fetching Posts

            //Atached COMPONENTS
            List<Integer> localDesigList = new ArrayList<>();
            String[] paramLocalComp2 = {"designationcategoryid", "universaltransferstatus", "transferstatus", "facilityid"};
            Object[] paramsValuesLocalComp2 = {designationcategoryid, "ASSIGNED", "ALLOCATED", facilityid};
            String whereLocalComp2 = "WHERE designationcategoryid=:designationcategoryid AND universaltransferstatus=:universaltransferstatus AND transferstatus=:transferstatus AND facilityid=:facilityid";
            String[] fieldsLocalComp2 = {"designationid"};
            List<Integer> objLocalComp2 = (List<Integer>) genericClassService.fetchRecord(Facilitydesignationview.class, fieldsLocalComp2, whereLocalComp2, paramLocalComp2, paramsValuesLocalComp2);
            if (objLocalComp2 != null) {
                for (Integer lComps : objLocalComp2) {
                    localDesigList.add(lComps);
                }
            }

            List<Integer> globalDesigList = new ArrayList<>();
            String[] paramGlobalComp2 = {"designationcategoryid", "universaltransferstatus", "transferstatus"};
            Object[] paramsValuesGlobalComp2 = {designationcategoryid, "ASSIGNED", "ALLOCATED"};
            String whereGlobalComp2 = "WHERE designationcategoryid=:designationcategoryid AND universaltransferstatus=:universaltransferstatus AND transferstatus=:transferstatus";
            String[] fieldsGlobalComp2 = {"designationid"};
            List<Integer> objGlobalComp2 = (List<Integer>) genericClassService.fetchRecord(Designation.class, fieldsGlobalComp2, whereGlobalComp2, paramGlobalComp2, paramsValuesGlobalComp2);
            if (objGlobalComp2 != null) {
                for (Integer component2 : objGlobalComp2) {
                    globalDesigList.add(component2);
                }
            }

            //Remove already added Disease components
            globalDesigList.removeAll(localDesigList);
            List<Map> postz = new ArrayList<>();

            for (int newGlobalDesigList : globalDesigList) {
                try {
                    String[] paramszr = {"designationid", "universaltransferstatus", "transferstatus", "designationcategoryid"};
                    Object[] paramsValueszr = {newGlobalDesigList, "ASSIGNED", "ALLOCATED", designationcategoryid};
                    String[] fieldszr = {"designationid", "designationcategoryid", "designationname", "shortname", "description", "status"};
                    String wherezr = "WHERE designationid=:designationid AND universaltransferstatus=:universaltransferstatus AND transferstatus=:transferstatus AND designationcategoryid=:designationcategoryid";
                    List<Object[]> posts = (List<Object[]>) genericClassService.fetchRecord(Designation.class, fieldszr, wherezr, paramszr, paramsValueszr);
                    if (posts != null) {
                        Map<String, Object> dpost;
                        for (Object[] dp : posts) {
                            dpost = new HashMap<>();

                            dpost.put("designationid", dp[0]);
                            dpost.put("designationcategoryid", dp[1]);
                            dpost.put("designationname", dp[2]);
                            dpost.put("shortname", dp[3]);
                            dpost.put("description", dp[4]);
                            dpost.put("status", dp[5]);

                            postz.add(dpost);
                        }
                        model.addAttribute("designations", postz);
                    }

                } catch (Exception ex) {
                    System.out.println(ex);
                }
            }

            return "controlPanel/localSettingsPanel/PostsAndActivities/forms/selects";
        } else {
            return "refresh";
        }

    }

    @RequestMapping(value = "/localdesignationtable", method = RequestMethod.GET)
    public final ModelAndView localDesignationTable(HttpServletRequest request) {
        Map<String, Object> model = new HashMap<String, Object>();

        //Fetching Posts
        List<Designation> postz = new ArrayList<>();

        String[] paramszrr = {};
        Object[] paramsValueszrr = {};
        String[] fieldszrr = {"designationid", "designationcategoryid", "designationname", "shortname", "description", "status"};
        String wherezrr = "";
        List<Object[]> posts = (List<Object[]>) genericClassService.fetchRecord(Designation.class, fieldszrr, wherezrr, paramszrr, paramsValueszrr);
        if (posts != null) {
            for (Object[] dp : posts) {
                Designation dpost = new Designation();
                dpost.setDesignationid((Integer) dp[0]);
                dpost.setDesignationcategoryid((Integer) dp[1]);
                dpost.setDesignationname((String) dp[2]);
                dpost.setShortname((String) dp[3]);
                dpost.setDescription((String) dp[4]);
                dpost.setStatus((Boolean) dp[5]);
                postz.add(dpost);
            }
            model.put("designationposts", postz);
        }

        return new ModelAndView("controlPanel/localSettingsPanel/PostsAndActivities/views/localdesignationtable", "model", model);
    }

    @RequestMapping(value = "/importDesignations", method = RequestMethod.GET)

    public String importDesignations(HttpServletRequest request, Model model) throws JsonProcessingException {
        List<Map> domaincategory = new ArrayList<>();
        int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
//FACILITY DOMAINS
        List<Facilitydomain> faclilityDomainList = new ArrayList<>();
        String[] paramsfacilitydomain = {"facilitydomainid"};
        Object[] paramsValuesfacilitydomain = {103};
        String[] fieldsfacilitydomain = {"facilitydomainid", "domainname", "description", "status"};
        String wherefacilitydomain = "WHERE facilitydomainid=:facilitydomainid";
        List<Object[]> facilityDomain = (List<Object[]>) genericClassService.fetchRecord(Facilitydomain.class, fieldsfacilitydomain, wherefacilitydomain, paramsfacilitydomain, paramsValuesfacilitydomain);
        Facilitydomain fDomain;
        if (facilityDomain != null) {
            for (Object[] domn : facilityDomain) {
                fDomain = new Facilitydomain();
                fDomain.setFacilitydomainid((Integer) domn[0]);
                fDomain.setDomainname((String) domn[1]);
                fDomain.setDescription((String) domn[2]);
                fDomain.setStatus((Boolean) domn[3]);
                faclilityDomainList.add(fDomain);
            }
            model.addAttribute("faclilitypostDomainList", faclilityDomainList);

        }

//Atached COMPONENTS
        List<Integer> localDesigCatList = new ArrayList<>();
        String[] paramLocalComp2 = {"facilityid"};
        Object[] paramsValuesLocalComp2 = {facilityid};
        String whereLocalComp2 = "WHERE facilityid=:facilityid";
        String[] fieldsLocalComp2 = {"designationid"};
        List<Integer> objLocalComp2 = (List<Integer>) genericClassService.fetchRecord(Facilitydesignations.class, fieldsLocalComp2, whereLocalComp2, paramLocalComp2, paramsValuesLocalComp2);
        if (objLocalComp2 != null) {
            for (Integer lComps : objLocalComp2) {
                localDesigCatList.add(lComps);
            }
        }

        List<Integer> globalDesigCatList = new ArrayList<>();
        String[] paramGlobalComp2 = {"universaltransferstatus", "transferstatus"};
        Object[] paramsValuesGlobalComp2 = {"ASSIGNED", "ALLOCATED"};
        String whereGlobalComp2 = "WHERE universaltransferstatus=:universaltransferstatus AND transferstatus=:transferstatus";
        String[] fieldsGlobalComp2 = {"designationid"};
        List<Integer> objGlobalComp2 = (List<Integer>) genericClassService.fetchRecord(Designation.class, fieldsGlobalComp2, whereGlobalComp2, paramGlobalComp2, paramsValuesGlobalComp2);
        if (objGlobalComp2 != null) {
            for (Integer component2 : objGlobalComp2) {
                globalDesigCatList.add(component2);
            }
        }

        //Remove already added Disease components
        globalDesigCatList.removeAll(localDesigCatList);

        List<Map> unattachedComponentsList = new ArrayList<>();
        for (int newGlobalCompList : globalDesigCatList) {
            try {
                String[] paramszr = {"designationid", "universaltransferstatus", "transferstatus"};
                Object[] paramsValueszr = {newGlobalCompList, "ASSIGNED", "ALLOCATED"};
                String[] fieldszr = {"designationid", "designationcategoryid", "designationname", "description"};
                String wherezr = "WHERE designationid=:designationid AND universaltransferstatus=:universaltransferstatus AND transferstatus=:transferstatus";
                List<Object[]> domainc = (List<Object[]>) genericClassService.fetchRecord(Designation.class, fieldszr, wherezr, paramszr, paramsValueszr);
                if (domainc != null) {
                    Map<String, Object> designations;
                    for (Object[] ddz : domainc) {
                        designations = new HashMap<>();
                        designations.put("designationid", (Integer) ddz[0]);
                        designations.put("designationcategoryid", (Integer) ddz[1]);
                        designations.put("designationname", (String) ddz[2]);
                        designations.put("description", (String) ddz[3]);

                        unattachedComponentsList.add(designations);
                    }
                    model.addAttribute("designationimport", unattachedComponentsList);
                }

            } catch (Exception ex) {
                System.out.println(ex);
            }
        }
        String jsondesignationimports = "";
        try {
            jsondesignationimports = new ObjectMapper().writeValueAsString(unattachedComponentsList);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }
        System.out.println("---------------------jsondesignationimports" + jsondesignationimports);

        model.addAttribute("jsondesignationimports", jsondesignationimports);

        return "controlPanel/localSettingsPanel/PostsAndActivities/views/importdesignation";

    }

    @RequestMapping(value = "/saveLocalDesignation.htm")
    public @ResponseBody
    String SaveLocalDesignation(Model model, HttpServletRequest request, @ModelAttribute("designations") String designations) {
        String data = "";
        Object addedby = request.getSession().getAttribute("person_id");
        int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
        int designationcategoryid = Integer.parseInt(request.getParameter("designationcategoryid"));

        try {
            List<Map> designationList = new ObjectMapper().readValue(designations, List.class);
            for (Map item : designationList) {
                Map<String, Object> map = (HashMap) item;
                Facilitydesignations saveposts = new Facilitydesignations();

                Integer designationid = Integer.parseInt(map.get("designationid").toString());
                saveposts.setFacilityid(facilityid);
                saveposts.setDesignationcategoryid(designationcategoryid);
                saveposts.setDesignationid(designationid);
                saveposts.setAddedby((Long) addedby);
                saveposts.setDateadded(new Date());

                Object desigCatSaved = genericClassService.saveOrUpdateRecordLoadObject(saveposts);
                if (desigCatSaved != null) {
                    data = "success";
                } else {
                    data = "Failed";
                }
            }

        } catch (IOException ex) {
            return "Failed";
        }

        return "success";
    }

    @RequestMapping(value = "/saveDesignationCategories.htm")
    public @ResponseBody
    String saveDesignationCategories(Model model, HttpServletRequest request, @ModelAttribute("designationCats") String designationCats, @ModelAttribute("facilityid") Integer facilityid, @ModelAttribute("facilityname") String facilityname) {
        String data = "";
        Object addedby = request.getSession().getAttribute("person_id");
        try {
            List<Map> designationCategoryList = new ObjectMapper().readValue(designationCats, List.class);
            for (Map item : designationCategoryList) {
                Map<String, Object> map = (HashMap) item;
                Integer designationcategoryid = Integer.parseInt(map.get("designationcategoryid").toString());
                Integer designationid = Integer.parseInt(map.get("designationid").toString());

                Facilitydesignations savedesigCats = new Facilitydesignations();
                savedesigCats.setFacilityid(facilityid);
                savedesigCats.setDesignationcategoryid(designationcategoryid);
                savedesigCats.setDesignationid(designationid);
                savedesigCats.setAddedby((Long) addedby);
                savedesigCats.setDateadded(new Date());

                Object desigCatSaved = genericClassService.saveOrUpdateRecordLoadObject(savedesigCats);
                if (desigCatSaved != null) {
                    data = "success";
                } else {
                    data = "Failed";
                }

            }

        } catch (Exception ex) {
            return "Failed";
        }

        return data;
    }

    @RequestMapping(value = "/returndesignations.htm")
    public @ResponseBody
    String returndesignations(Model model, HttpServletRequest request) {
        List<Designation> postz = new ArrayList<>();
        int designationcategoryid = Integer.parseInt(request.getParameter("designationcategoryid"));
        System.out.println("-------------------------------designationcategoryid" + designationcategoryid);

        String[] paramszr = {"designationcategoryid", "universaltransferstatus"};
        Object[] paramsValueszr = {designationcategoryid, "ASSIGNED"};
        String[] fieldszr = {"designationid", "designationcategoryid", "designationname", "shortname", "description", "status"};
        String wherezr = "WHERE designationcategoryid=:designationcategoryid AND universaltransferstatus=:universaltransferstatus ORDER BY designationname";
        List<Object[]> posts = (List<Object[]>) genericClassService.fetchRecord(Designation.class, fieldszr, wherezr, paramszr, paramsValueszr);
        if (posts != null) {
            for (Object[] dp : posts) {
                Designation dpost = new Designation();
                dpost.setDesignationid((Integer) dp[0]);
                dpost.setDesignationcategoryid((Integer) dp[1]);
                dpost.setDesignationname((String) dp[2]);
                dpost.setShortname((String) dp[3]);
                dpost.setDescription((String) dp[4]);
                dpost.setStatus((Boolean) dp[5]);
                postz.add(dpost);
            }
            System.out.println("--------------------------------postz11111111111" + postz);
        }
        model.addAttribute("newDesignations", postz);
        System.out.println("--------------------------------postz22222222" + postz);
        return "";
    }

    @RequestMapping(value = "/saveUpdateLocalDesignations.htm")
    public @ResponseBody
    String saveUpdateLocalDesignations(Model model, HttpServletRequest request) {

        Object updatedby = request.getSession().getAttribute("person_id");
        String categoryname = request.getParameter("designationcategoryid");
        String description = request.getParameter("description");
        int facilityid = Integer.parseInt(request.getParameter("facilityid"));
        int designationcategoryid = Integer.parseInt(request.getParameter("categoryname"));

        String[] columns = {"facilityid", "categoryname", "description", "designationcategoryid", "disabled", "lastupdatedby", "datelastupdated"};
        Object[] columnValues = {facilityid, categoryname, description, designationcategoryid, Boolean.TRUE, updatedby, new Date()};
        String pk = "designationcategoryid";
        Object pkValue = designationcategoryid;
        genericClassService.updateRecordSQLSchemaStyle(Designationcategory.class, columns, columnValues, pk, pkValue, "public");
        return "";
    }

    @RequestMapping(value = "/importdesignationcategory.htm")
    public @ResponseBody
    String ImportDesignationCategory(Model model, HttpServletRequest request, @ModelAttribute("values") String designationCategories) {
        String data = "";
        String results = "";
        List<Integer> designationCatList;
        int facilityid = (int) request.getSession().getAttribute("sessionActiveLoginFacility");
        Object addedby = request.getSession().getAttribute("person_id");
        try {
            designationCatList = (ArrayList) new ObjectMapper().readValue(designationCategories, List.class);

            for (Integer designationCatId : designationCatList) {
                Facilitydesignations importdesignations = new Facilitydesignations();
                importdesignations.setFacilityid(facilityid);
                importdesignations.setDesignationid(designationCatId);
                importdesignations.setAddedby((Long) addedby);
                importdesignations.setDateadded(new Date());

                Object desigCatSaved = genericClassService.saveOrUpdateRecordLoadObject(importdesignations);
                if (desigCatSaved != null) {
                    data = "success";
                } else {
                    data = "Failed";
                }

            }
        } catch (IOException ex) {
            return "Failed";
        }

        return data;

    }

    @RequestMapping(value = "/saveUpdatelocalPosts.htm")
    public @ResponseBody
    String saveUpdateLocalPosts(Model model, HttpServletRequest request) {
        String results = "";
        Object updatedby = request.getSession().getAttribute("person_id");
        String designationname = request.getParameter("designationname");
        String description = request.getParameter("description");
        int designationid = Integer.parseInt(request.getParameter("designationid"));
        int designationcategoryid = Integer.parseInt(request.getParameter("designationcategoryid"));

        String[] columns = {"designationid", "designationname", "description", "designationcategoryid", "updatedby", "dateupdated"};
        Object[] columnValues = {designationid, designationname, description, designationcategoryid, updatedby, new Date()};
        String pk = "designationid";
        Object pkValue = designationid;
        Object updated = genericClassService.updateRecordSQLSchemaStyle(Designation.class, columns, columnValues, pk, pkValue, "public");
        if (updated != null) {
                results = "success";
            } else {
                results = "failed";
            }
        
        return results;
    }

    @RequestMapping(value = "/deletelocaldesigcat")
    public @ResponseBody
    String deleteLocalDesigCat(HttpServletRequest request, Model model) {
        String results = "";
        int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
        Object updatedby = request.getSession().getAttribute("person_id");
        List<Integer[]> object = (List<Integer[]>) genericClassService.fetchRecord(Facilitydesignationview.class, new String[]{"designationid"}, " WHERE r.designationcategoryid=:designationcategoryid AND transferstatus=:transferstatus AND universaltransferstatus=:universaltransferstatus", new String[]{"designationcategoryid", "transferstatus", "universaltransferstatus"}, new Object[]{Integer.parseInt(request.getParameter("designationcategoryid")), "ALLOCATED", "ASSIGNED"});

        int designationcategoryid = Integer.parseInt(request.getParameter("designationcategoryid"));

        System.out.println("----------------------designationcategoryid" + designationcategoryid);
        if (object != null) {
            System.out.println("----------------------HAS DESIGNATIONS");
            results = String.valueOf(object.size());
        } else {
            System.out.println("----------------------HAS NO DESIGNATIONS");
            String[] columns = {"deletestatus", "lastupdatedby", "datelastupdated"};
            Object[] columnValues = {"DELETED", updatedby, new Date()};
            String pk = "designationcategoryid";
            Object pkValue = designationcategoryid;
            Object deleted = genericClassService.updateRecordSQLSchemaStyle(Designationcategory.class, columns, columnValues, pk, pkValue, "public");
            if (deleted != null) {
                results = "success";
            } else {
                results = "failed";
            }
        }
        return results;
    }

    @RequestMapping(value = "/fetchDesigCats", method = RequestMethod.POST)
    public @ResponseBody
    String fetchDesigCats(HttpServletRequest request, Model model) {
        int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
        String jsondata = "";

        List<Integer> localDesigCatList = new ArrayList<>();
        String[] paramLocalComp2 = {"facilityid", "universaldeletestatus", "deletestatus"};
        Object[] paramsValuesLocalComp2 = {facilityid, "NOTDELETED", "NOTDELETED"};
        String whereLocalComp2 = "WHERE facilityid=:facilityid AND universaldeletestatus=:universaldeletestatus AND deletestatus=:deletestatus";
        String[] fieldsLocalComp2 = {"designationcategoryid"};
        List<Integer> objLocalComp2 = (List<Integer>) genericClassService.fetchRecord(Facilitydesignationview.class, fieldsLocalComp2, whereLocalComp2, paramLocalComp2, paramsValuesLocalComp2);
        if (objLocalComp2 != null) {
            for (Integer lComps : objLocalComp2) {
                localDesigCatList.add(lComps);
            }
        }

        List<Integer> globalDesigCatList = new ArrayList<>();
        String[] paramGlobalComp2 = {"universaldeletestatus", "deletestatus"};
        Object[] paramsValuesGlobalComp2 = {"NOTDELETED", "NOTDELETED"};
        String whereGlobalComp2 = "WHERE universaldeletestatus=:universaldeletestatus AND deletestatus=:deletestatus";
        String[] fieldsGlobalComp2 = {"designationcategoryid"};
        List<Integer> objGlobalComp2 = (List<Integer>) genericClassService.fetchRecord(Designationcategory.class, fieldsGlobalComp2, whereGlobalComp2, paramGlobalComp2, paramsValuesGlobalComp2);
        if (objGlobalComp2 != null) {
            for (Integer component2 : objGlobalComp2) {
                globalDesigCatList.add(component2);
            }
        }

        //Remove already added Disease components
        globalDesigCatList.removeAll(localDesigCatList);

        List<Map> designationCats = new ArrayList<>();
        for (int newGlobalCompList : globalDesigCatList) {
            try {
                String[] paramszrr = {"universaldeletestatus", "deletestatus", "designationcategoryid"};
                Object[] paramsValueszrr = {"NOTDELETED", "NOTDELETED", newGlobalCompList};
                String[] fieldszrr = {"facilityid", "designationcategoryid", "categoryname"};
                String wherezrr = "WHERE universaldeletestatus=:universaldeletestatus AND deletestatus=:deletestatus AND designationcategoryid=:designationcategoryid";
                List<Object[]> posts = (List<Object[]>) genericClassService.fetchRecord(Designationcategory.class, fieldszrr, wherezrr, paramszrr, paramsValueszrr);
                if (posts != null) {
                    Map<String, Object> desigCat;
                    for (Object[] dp : posts) {
                        desigCat = new HashMap<>();
                        desigCat.put("facilityid", (Integer) dp[0]);
                        desigCat.put("designationcategoryid", (Integer) dp[1]);
                        desigCat.put("categoryname", (String) dp[2]);

                        designationCats.add(desigCat);
                    }
                }
            } catch (Exception ex) {
                System.out.println(ex);
            }
            try {
                jsondata = new ObjectMapper().writeValueAsString(designationCats);
            } catch (JsonProcessingException ex) {
                System.out.println(ex);
            }
        }
        return jsondata;
    }

    @RequestMapping(value = "/fetchDesigCatPosts", method = RequestMethod.POST)
    public @ResponseBody
    String fetchDesigCatPosts(HttpServletRequest request, Model model, @ModelAttribute("designationcategoryid") Integer designationcategoryid) {
        String jsondata = "";
        List<Map> posts = new ArrayList<>();
        String[] params = {"designationcategoryid", "universaltransferstatus", "transferstatus"};
        Object[] paramsValues = {designationcategoryid, "ASSIGNED", "ALLOCATED"};
        String[] fields = {"designationid", "designationname"};
        String where = "WHERE designationcategoryid=:designationcategoryid AND universaltransferstatus=:universaltransferstatus AND transferstatus=:transferstatus ORDER BY designationname ASC";
        List<Object[]> postDetails = (List<Object[]>) genericClassService.fetchRecord(Designation.class, fields, where, params, paramsValues);
        if (postDetails != null) {
            Map<String, Object> post;
            for (Object[] pstDetail : postDetails) {
                post = new HashMap<>();
                post.put("designationid", (Integer) pstDetail[0]);
                post.put("designationname", (String) pstDetail[1]);
                posts.add(post);
            }
        }
        try {
            jsondata = new ObjectMapper().writeValueAsString(posts);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }
        return jsondata;
    }

    @RequestMapping(value = "/addDesignationCategory.htm", method = RequestMethod.GET)
    public String AddDesignationCategory(HttpServletRequest request, Model model) {
        String results = "";
        if (request.getSession().getAttribute("sessionActiveLoginFacility") != null) {
            int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());

            model.addAttribute("facilityid", facilityid);
            model.addAttribute("facilityname", request.getParameter("facilityname"));

            return "controlPanel/localSettingsPanel/PostsAndActivities/forms/addDesignationCategory";
        } else {
            return "refresh";
        }
    }

    @RequestMapping("/viewtranferreddesignations")
    public String viewtranferreddesignations(HttpServletRequest request, Model model) throws JsonProcessingException {

        int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
        List<Map> desigcategoryz = new ArrayList<>();

        String[] paramLocalposts2 = {"facilityid", "transferstatus", "universaltransferstatus"};
        Object[] paramsValuesLocalposts2 = {facilityid, "UNALLOCATED", "UNASSIGNED"};
        String whereLocalposts2 = "WHERE facilityid=:facilityid AND transferstatus =:transferstatus OR universaltransferstatus=:universaltransferstatus";
        String[] fieldsLocalposts2 = {"designationid", "designationcategoryid", "designationname"};
        List<Object[]> objLocalposts2 = (List<Object[]>) genericClassService.fetchRecord(Facilitydesignationview.class, fieldsLocalposts2, whereLocalposts2, paramLocalposts2, paramsValuesLocalposts2);
        if (objLocalposts2 != null) {
            Map<String, Object> desigcategoryRow;
            for (Object[] lComps : objLocalposts2) {
                desigcategoryRow = new HashMap<>();
                desigcategoryRow.put("designationid", lComps[0]);
                desigcategoryRow.put("designationname", lComps[2]);
                if (lComps[0] != null) {
                    System.out.println("previousdesigCat" + lComps[0]);
                    String[] params9 = {"designationid"};
                    Object[] paramsValues9 = {(int) lComps[0]};
                    String[] fields9 = {"dateupdated", "transferstatus", "previousdesigcategory"};
                    String where9 = "WHERE designationid =:designationid";
                    List<Object[]> found9 = (List<Object[]>) genericClassService.fetchRecord(Designation.class, fields9, where9, params9, paramsValues9);
                    if (found9 != null) {
                        for (Object[] f9 : found9) {
                            desigcategoryRow.put("dateupdated", formatter.format((Date) f9[0]));
                            if (f9[2] != null) {
                                System.out.println("-----------previousdesigCat-------------" + f9[2]);
                                String[] params8 = {"designationcategoryid"};
                                Object[] paramsValues8 = {(int) f9[2]};
                                String[] fields8 = {"designationcategoryid", "categoryname"};
                                String where8 = "WHERE designationcategoryid =:designationcategoryid";
                                List<Object[]> found8 = (List<Object[]>) genericClassService.fetchRecord(Designationcategory.class, fields8, where8, params8, paramsValues8);
                                if (found8 != null) {
                                    Object[] f8 = found8.get(0);
                                    desigcategoryRow.put("designationcategoryid", (int) f8[0]);
                                    desigcategoryRow.put("categoryname", (String) f8[1]);

                                    System.out.println("desigcategoryz" + desigcategoryz);

                                } else {
                                    System.out.println("PRINTED ELSE");
                                }

                            }
                        }

                    } else {
                    }

                }

                desigcategoryz.add(desigcategoryRow);
            }

        }

        model.addAttribute("TransferDesignationLists", desigcategoryz);

        return "controlPanel/localSettingsPanel/PostsAndActivities/views/viewattachments";
    }

    @RequestMapping(value = "/transferPosts", method = RequestMethod.GET)
    public String TransferPosts(HttpServletRequest request, Model model) throws JsonProcessingException {

        model.addAttribute("designationid", Integer.parseInt(request.getParameter("designationid")));
        model.addAttribute("designationname", request.getParameter("designationname"));
        model.addAttribute("designationcategoryid", Integer.parseInt(request.getParameter("designationcategoryid")));
        model.addAttribute("categoryname", request.getParameter("categoryname"));

        int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
        List<Integer> localDesigCatList = new ArrayList<>();
        String[] paramLocalComp2 = {"facilityid", "designationcategoryid", "deletestatus", "universaldeletestatus"};
        Object[] paramsValuesLocalComp2 = {facilityid, Integer.parseInt(request.getParameter("designationcategoryid")), "DELETED", "DELETED"};
        String whereLocalComp2 = "WHERE facilityid=:facilityid AND designationcategoryid=:designationcategoryid AND deletestatus=:deletestatus AND universaldeletestatus=:universaldeletestatus";
        String[] fieldsLocalComp2 = {"designationcategoryid"};
        List<Integer> objLocalComp2 = (List<Integer>) genericClassService.fetchRecord(Facilitydesignationview.class, fieldsLocalComp2, whereLocalComp2, paramLocalComp2, paramsValuesLocalComp2);
        if (objLocalComp2 != null) {
            for (Integer lComps : objLocalComp2) {
                localDesigCatList.add(lComps);
            }
        }

        List<Integer> globalDesigCatList = new ArrayList<>();
        String[] paramGlobalComp2 = {"facilityid", "deletestatus", "universaldeletestatus"};
        Object[] paramsValuesGlobalComp2 = {facilityid, "NOTDELETED", "NOTDELETED"};
        String whereGlobalComp2 = "WHERE facilityid=:facilityid AND deletestatus=:deletestatus AND universaldeletestatus=:universaldeletestatus";
        String[] fieldsGlobalComp2 = {"designationcategoryid"};
        List<Integer> objGlobalComp2 = (List<Integer>) genericClassService.fetchRecord(Facilitydesignationview.class, fieldsGlobalComp2, whereGlobalComp2, paramGlobalComp2, paramsValuesGlobalComp2);
        if (objGlobalComp2 != null) {
            for (Integer component2 : objGlobalComp2) {
                globalDesigCatList.add(component2);
            }
        }

        //Remove already added Disease components
        globalDesigCatList.removeAll(localDesigCatList);

        for (int newGlobalCompList : globalDesigCatList) {
            try {
                List<Designationcategory> DesignationList = new ArrayList<>();
                String[] paramsfacilitydesig = {"designationcategoryid", "facilityid", "deletestatus", "universaldeletestatus"};
                Object[] paramsValuesfacilitydesig = {newGlobalCompList, facilityid, "NOTDELETED", "NOTDELETED"};
                String[] fieldsfacilitydesig = {"designationcategoryid", "categoryname"};
                List<Object[]> facilityDesignation = (List<Object[]>) genericClassService.fetchRecord(Facilitydesignationview.class, fieldsfacilitydesig, " WHERE designationcategoryid=:designationcategoryid AND facilityid=:facilityid AND deletestatus=:deletestatus AND universaldeletestatus=:universaldeletestatus", paramsfacilitydesig, paramsValuesfacilitydesig);
                Designationcategory fDomain;
                if (facilityDesignation != null) {
                    for (Object[] domn : facilityDesignation) {
                        fDomain = new Designationcategory();
                        fDomain.setDesignationcategoryid((Integer) domn[0]);
                        fDomain.setCategoryname((String) domn[1]);
                        DesignationList.add(fDomain);
                    }
                    model.addAttribute("transferdesigcategory", DesignationList);
                }
            } catch (Exception ex) {
                System.out.println(ex);
            }
        }
//        String jsonDesignationList = "";
//        try {
//            jsonDesignationList = new ObjectMapper().writeValueAsString(DesignationList);
//        } catch (Exception e) {
//            System.out.println(e);
//        }
//        model.addAttribute("jsontransferdesigcategory", jsonDesignationList);

        return "controlPanel/localSettingsPanel/PostsAndActivities/views/transferpost";
    }

    @RequestMapping(value = "/viewDesigCatAttachments", method = RequestMethod.GET)
    public String viewDesigCatAttachments(HttpServletRequest request, Model model) throws JsonProcessingException {

        int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
        int designationcategoryid = Integer.parseInt(request.getParameter("designationcategoryid"));
        String categoryname = request.getParameter("categoryname");

        model.addAttribute("designationcategoryid", designationcategoryid);
        model.addAttribute("categoryname", categoryname);

        List<Map> desigcategoryz = new ArrayList<>();

        String[] paramLocalposts2 = {"facilityid", "designationcategoryid", "deletestatus", "universaldeletestatus", "universaltransferstatus", "transferstatus"};
        Object[] paramsValuesLocalposts2 = {facilityid, designationcategoryid, "NOTDELETED", "NOTDELETED", "ASSIGNED", "ALLOCATED"};
        String whereLocalposts2 = "WHERE facilityid=:facilityid AND designationcategoryid=:designationcategoryid AND deletestatus=:deletestatus AND universaldeletestatus=:universaldeletestatus AND universaltransferstatus=:universaltransferstatus AND transferstatus=:transferstatus";
        String[] fieldsLocalposts2 = {"designationid", "designationname"};
        List<Object[]> objLocalposts2 = (List<Object[]>) genericClassService.fetchRecord(Facilitydesignationview.class, fieldsLocalposts2, whereLocalposts2, paramLocalposts2, paramsValuesLocalposts2);
        if (objLocalposts2 != null) {
            Map<String, Object> desigcategoryRow;
            for (Object[] lComps : objLocalposts2) {
                desigcategoryRow = new HashMap<>();
                desigcategoryRow.put("designationid", lComps[0]);
                desigcategoryRow.put("designationname", lComps[1]);
                desigcategoryz.add(desigcategoryRow);
            }

        }
        model.addAttribute("TransferPostsList", desigcategoryz);

        String jsondesignations = "";
        try {
            jsondesignations = new ObjectMapper().writeValueAsString(desigcategoryz);
        } catch (Exception e) {
            System.out.println(e);
        }
        model.addAttribute("jsondesignations", jsondesignations);
        return "controlPanel/localSettingsPanel/PostsAndActivities/forms/discardLocalDesigCat";
    }
//
//    @RequestMapping(value = "/deletelocaldesignationcategorylist", method = RequestMethod.POST)
//    public @ResponseBody
//    String deletelocaldesignationcategorylist(HttpServletRequest request, Model model) {
//        String results = "";
//        try {
//
//            Object updatedbyname = request.getSession().getAttribute("person_id");
//            int designationcategoryid = Integer.parseInt(request.getParameter("designationcategoryid"));
//            String categoryname = request.getParameter("categoryname");
//
//            String[] columnslev = {"designationcategoryid", "deletestatus", "datelastupdated", "lastupdatedby"};
//            Object[] columnValueslev = {designationcategoryid, "DELETED", new Date(), (Long) updatedbyname};
//            String levelPrimaryKey = "designationcategoryid";
//            Object levelPkValue = designationcategoryid;
//            Object updatelimit = genericClassService.updateRecordSQLSchemaStyle(Designationcategory.class, columnslev, columnValueslev, levelPrimaryKey, levelPkValue, "public");
//
//            List<Designation> postz = new ArrayList<>();
//            String[] paramszr = {"designationcategoryid"};
//            Object[] paramsValueszr = {designationcategoryid};
//            String[] fieldszr = {"designationid"};
//            String wherezr = "WHERE designationcategoryid=:designationcategoryid";
//            List<Integer> posts = (List<Integer>) genericClassService.fetchRecord(Designation.class, fieldszr, wherezr, paramszr, paramsValueszr);
//            if (posts != null) {
//                System.out.println("---------------" + posts.get(0));
//
//                for (Integer dp : posts) {
//                    String[] columnslevs = {"designationid", "transferstatus", "dateupdated", "updatedby"};
//                    Object[] columnValueslevs = {dp, "UNALLOCATED", new Date(), (Long) updatedbyname};
//                    String levelPrimaryKeys = "designationid";
//                    Object levelPkValues = dp;
//                    genericClassService.updateRecordSQLSchemaStyle(Designation.class, columnslevs, columnValueslevs, levelPrimaryKeys, levelPkValues, "public");
//
//                }
//
//            }
//        } catch (Exception ex) {
//            ex.printStackTrace();
//        }
//
//        return results;
//    }

    @RequestMapping(value = "/transferlocaldesignations", method = RequestMethod.POST)
    public @ResponseBody
    String TransferLocalDesignations(HttpServletRequest request, @ModelAttribute("designationsvalues") String designationtransferall, @ModelAttribute("designationcatid") int designationcategoryid) {
        String results = "";
        Object updatedbyname = request.getSession().getAttribute("person_id");
        try {
            ObjectMapper mapper = new ObjectMapper();
            List<Map> transferdesigs = (ArrayList<Map>) mapper.readValue(designationtransferall, List.class);
            System.out.println("----------**********-----------1111111111111" + designationtransferall);
            for (Map x : transferdesigs) {
                System.out.println("----------**********-----------2222222222222" + designationtransferall);
                String designationname = String.valueOf(x.get("designationname"));
                int designationid = (int) x.get("designationid");

                String[] columnslev = {"designationcategoryid", "transferstatus", "dateupdated", "updatedby", "previousdesigcategory"};
                Object[] columnValueslev = {designationcategoryid, "UNALLOCATED", new Date(), (Long) updatedbyname, designationcategoryid};
                String levelPrimaryKey = "designationid";
                Object levelPkValue = designationid;
                Object updatelimit = genericClassService.updateRecordSQLSchemaStyle(Designation.class, columnslev, columnValueslev, levelPrimaryKey, levelPkValue, "public");
                System.out.println("----------**********-----------3333333333333333333" + designationtransferall);

                String[] columnslevD = {"designationcategoryid", "deletestatus", "datelastupdated", "lastupdatedby"};
                Object[] columnValueslevD = {designationcategoryid, "DELETED", new Date(), (Long) updatedbyname};
                String levelPrimaryKeyD = "designationcategoryid";
                Object levelPkValueD = designationcategoryid;
                Object updatelimitD = genericClassService.updateRecordSQLSchemaStyle(Designationcategory.class, columnslevD, columnValueslevD, levelPrimaryKeyD, levelPkValueD, "public");

                if (updatelimit != null) {
                    results = "successly";
                    System.out.println("----------**********-----------4444444444444444" + designationtransferall);
                } else {
                    results = "fail";
                    System.out.println("----------**********-----------5555555555555" + designationtransferall);
                }
                System.out.println("----------**********-----------6666666666666666" + designationtransferall);
            }
            System.out.println("----------**********-----------7777777777777777" + designationtransferall);
        } catch (IOException ex) {
            System.out.println(ex);
        }
        return results;
    }

    @RequestMapping(value = "/restoredesignation", method = RequestMethod.POST)
    public @ResponseBody
    String RestoreDesignation(HttpServletRequest request, @ModelAttribute("designationcategoryid") int designationcategoryid, @ModelAttribute("designationvalues") String designationvalues) throws IOException {
        String results = "";
        Object updatedbyname = request.getSession().getAttribute("person_id");
        int designationid = Integer.parseInt(request.getParameter("designationid"));
        String[] columnslev = {"designationcategoryid", "transferstatus", "dateupdated", "updatedby"};
        Object[] columnValueslev = {designationcategoryid, "ALLOCATED", new Date(), (Long) updatedbyname};
        String levelPrimaryKey = "designationid";
        Object levelPkValue = designationid;
        Object updatelimit = genericClassService.updateRecordSQLSchemaStyle(Designation.class, columnslev, columnValueslev, levelPrimaryKey, levelPkValue, "public");

        String[] columnsle = {"designationcategoryid", "deletestatus", "datelastupdated", "lastupdatedby"};
        Object[] columnValuesle = {designationcategoryid, "NOTDELETED", new Date(), (Long) updatedbyname};
        String levelPrimaryKeys = "designationcategoryid";
        Object levelPkValues = designationcategoryid;
        Object updatelimits = genericClassService.updateRecordSQLSchemaStyle(Designationcategory.class, columnsle, columnValuesle, levelPrimaryKeys, levelPkValues, "public");
        if (updatelimit != null) {
            results = "successly";
        } else {
            results = "fail";
        }
        return results;
    }

    @RequestMapping(value = "/restoredesigs", method = RequestMethod.POST)
    public @ResponseBody
    String RestoreDesigs(HttpServletRequest request, @ModelAttribute("designationcategoryid") int designationcategoryid, @ModelAttribute("designationid") int designationid, @ModelAttribute("designationname") String designationname) {
        String results = "";
        Object updatedbyname = request.getSession().getAttribute("person_id");
        String[] columnslev = {"designationcategoryid", "transferstatus", "dateupdated", "updatedby"};
        Object[] columnValueslev = {designationcategoryid, "ALLOCATED", new Date(), (Long) updatedbyname};
        String levelPrimaryKey = "designationid";
        Object levelPkValue = designationid;

        String[] columnsle = {"designationcategoryid", "deletestatus"};
        Object[] columnValuesle = {designationcategoryid, "NOTDELETED"};
        String levelPrimaryKeys = "designationcategoryid";
        Object levelPkValues = designationcategoryid;
        Object updatelimit = genericClassService.updateRecordSQLSchemaStyle(Designation.class, columnslev, columnValueslev, levelPrimaryKey, levelPkValue, "public");
        Object updatelimits = genericClassService.updateRecordSQLSchemaStyle(Designationcategory.class, columnsle, columnValuesle, levelPrimaryKeys, levelPkValues, "public");
        if (updatelimit != null) {
            results = "successly";
        } else {
            results = "fail";
        }
        return results;
    }

    @RequestMapping(value = "/checkdesignationcategoryname.htm")
    public @ResponseBody
    String checkDesignationCategoryName(HttpServletRequest request) {
        int facilityid = (int) request.getSession().getAttribute("sessionActiveLoginFacility");
        String results = "";

        String[] params = {"facilityid", "value"};
        Object[] paramsValues = {facilityid, request.getParameter("categoryname").trim().toLowerCase()};
        String[] fields = {"categoryname"};
        String where = "WHERE facilityid=:facilityid AND  (LOWER(categoryname) =:value) ORDER BY categoryname";
        List<Object[]> classficationList = (List<Object[]>) genericClassService.fetchRecord(Designationcategory.class, fields, where, params, paramsValues);
        if (classficationList != null) {
            results = "existing";
        } else {
            results = "notexisting";
        }

        return results;
    }

    @RequestMapping(value = "/checkdesignationname.htm")
    public @ResponseBody
    String CheckDesignationName(HttpServletRequest request) {
        //String designationname = request.getParameter("designationname");
        int designationid = Integer.parseInt(request.getParameter("designationid"));
        int designationcategoryid = Integer.parseInt(request.getParameter("designationcategoryid"));
        String results = "";

        String[] params = {"designationcategoryid", "value"};
        Object[] paramsValues = {designationcategoryid, request.getParameter("designationname").trim().toLowerCase()};
        String[] fields = {"designationname"};
        String where = "WHERE designationcategoryid=:designationcategoryid AND  (LOWER(designationname) =:value) ORDER BY designationname";
        List<Object[]> classficationList = (List<Object[]>) genericClassService.fetchRecord(Designation.class, fields, where, params, paramsValues);
        if (classficationList != null) {
            results = "existing";
        } else {
            results = "notexisting";
        }

        return results;
    }

    @RequestMapping(value = "/transfersomelocaldesignations", method = RequestMethod.POST)
    public @ResponseBody
    String transfersomelocaldesignations(HttpServletRequest request, @ModelAttribute("desigvalues") String designationtransferall, @ModelAttribute("designationcatid") int designationcategoryid) {
        String results = "";
        Object updatedbyname = request.getSession().getAttribute("person_id");
        try {
            ObjectMapper mapper = new ObjectMapper();
            List<Map> transferdesigs = (ArrayList<Map>) mapper.readValue(designationtransferall, List.class);

            for (Map x : transferdesigs) {
                int designationid = (int) x.get("designationid");

                String[] columnslev = {"designationcategoryid", "transferstatus", "dateupdated", "updatedby"};
                Object[] columnValueslev = {designationcategoryid, "UNALLOCATED", new Date(), (Long) updatedbyname};
                String levelPrimaryKey = "designationid";
                Object levelPkValue = designationid;
                Object updatelimit = genericClassService.updateRecordSQLSchemaStyle(Designation.class, columnslev, columnValueslev, levelPrimaryKey, levelPkValue, "public");

                String[] columnslevD = {"designationcategoryid", "deletestatus", "dateupdated", "updatedby"};
                Object[] columnValueslevD = {designationcategoryid, "DELETED", new Date(), (Long) updatedbyname};
                String levelPrimaryKeyD = "designationcategoryid";
                Object levelPkValueD = designationcategoryid;
                Object updatelimitD = genericClassService.updateRecordSQLSchemaStyle(Designationcategory.class, columnslevD, columnValueslevD, levelPrimaryKeyD, levelPkValueD, "public");
                if (updatelimit != null) {
                    results = "successly";
                } else {
                    results = "fail";
                }

            }

        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        } catch (IOException ex) {
            System.out.println(ex);
        }
        return results;
    }

    @RequestMapping(value = "/deleteDesignation")
    public @ResponseBody
    String deleteDesignation(HttpServletRequest request, Model model) {
        String results = "";
        String[] columns = {"designationid"};
        Object[] columnValues = {Integer.parseInt(request.getParameter("designationid"))};
        int result = genericClassService.deleteRecordByByColumns("designation", columns, columnValues);
        if (result != 0) {
            results = "success";
        }

        return results;
    }

    @RequestMapping(value = "/importAllDesignationCategories", method = RequestMethod.POST)
    public @ResponseBody
    String importAllDesignationCategories(HttpServletRequest request, @ModelAttribute("desigCatvalues") String desigCatUpdateAll) {
        String results = "";
        int facilityid = (int) request.getSession().getAttribute("sessionActiveLoginFacility");
        Object addedby = request.getSession().getAttribute("person_id");
        try {
            ObjectMapper mapper = new ObjectMapper();
            List<Map> importdesigCat = (ArrayList<Map>) mapper.readValue(desigCatUpdateAll, List.class);
            System.out.println("----------**********-----------" + desigCatUpdateAll);
            for (Map x : importdesigCat) {
                Facilitydesignations importeddesignations = new Facilitydesignations();
                int designationid = (int) x.get("designationid");
                int designationcategoryid = (int) x.get("designationcategoryid");
                importeddesignations.setFacilityid(facilityid);
                importeddesignations.setDesignationid(designationid);
                importeddesignations.setDesignationcategoryid(designationcategoryid);
                importeddesignations.setAddedby((Long) addedby);
                importeddesignations.setDateadded(new Date());
                System.out.println("-------------------importeddesignations" + importeddesignations);

                Object updatelimit = genericClassService.saveOrUpdateRecordLoadObject(importeddesignations);
                if (updatelimit != null) {
                    results = "successly";
                } else {
                    results = "fail";
                }

            }

        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        } catch (IOException ex) {
            System.out.println(ex);
        }
        return results;
    }
}
