/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.domain.Designationcategory;
import com.iics.domain.Facility;
import com.iics.domain.Facilitydomain;
import com.iics.domain.Facilitylevel;
import com.iics.domain.Facilityowner;
import com.iics.domain.Location;
import com.iics.domain.Village;
import com.iics.service.GenericClassService;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Grace-K
 */
@Controller
@RequestMapping("/facility")
public class FacilityController {

    @Autowired
    GenericClassService genericClassService;

    @RequestMapping(value = "/facilityhome", method = RequestMethod.GET)
    public String init(Model model) {

        //Fetch Facility Owners
        List<Facilityowner> faclilityOwnerList = new ArrayList<>();
        String[] paramsfacilityowner = {};
        Object[] paramsValuesfacilityowner = {};
        String[] fieldsfacilityowner = {"facilityownerid", "ownername", "description"};
        String wherefacilityowner = "";
        List<Object[]> facilityOwner = (List<Object[]>) genericClassService.fetchRecord(Facilityowner.class, fieldsfacilityowner, wherefacilityowner, paramsfacilityowner, paramsValuesfacilityowner);
        Facilityowner fOwners;
        if (facilityOwner != null) {
            for (Object[] own : facilityOwner) {
                fOwners = new Facilityowner();
                fOwners.setFacilityownerid((Integer) own[0]);
                fOwners.setOwnername((String) own[1]);
                fOwners.setDescription((String) own[2]);
                faclilityOwnerList.add(fOwners);
            }
            model.addAttribute("faclilityOwnerList", faclilityOwnerList);
        }
        return "controlPanel/universalPanel/facility/views/facilityMain";
    }

    @RequestMapping(value = "/submitfacilityowner", method = RequestMethod.POST)
    public @ResponseBody
    String submitFacilityOwner(Model model, HttpServletRequest request) {
        try{
        Facilityowner facilityowner = new Facilityowner();
        String ownername = request.getParameter("ownername");
        String description = request.getParameter("description");
         //Check Existing Facility Owner
        List<Object[]> existingOwner = (List<Object[]>) genericClassService.fetchRecord(Facilityowner.class, new String[]{"facilityownerid"}, "WHERE LOWER(r.ownername)=:name", new String[]{"name"}, new Object[]{ownername.toLowerCase()});
        if (existingOwner != null) {
            return "FACILITY OWNER "+ownername+" ALREADY EXISTS!";
        }
         //Save Facility Owner Objec
        facilityowner.setOwnername(ownername);
        facilityowner.setDescription(description);
        genericClassService.saveOrUpdateRecordLoadObject(facilityowner);
        }catch(Exception ex){
            System.out.println(ex);
                return "Error Occured!";
        }
        return "";
    }

    @RequestMapping(value = "/updatefacilityowner", method = RequestMethod.POST)
    public @ResponseBody
    String updateFacilityOwner(Model model, HttpServletRequest request) {
        String updateownername = request.getParameter("updateownername");
        String updatedescription = request.getParameter("updatedescription");
        int facilityownerid = Integer.parseInt(request.getParameter("facilityownerid"));

        String[] columns = {"ownername", "description"};
        Object[] columnValues = {updateownername, updatedescription};
        String pk = "facilityownerid";
        Object pkValue = facilityownerid;
        genericClassService.updateRecordSQLSchemaStyle(Facilityowner.class, columns, columnValues, pk, pkValue, "public");
        return "";
    }

    @RequestMapping(value = "/viewfacilitydomains", method = RequestMethod.GET)
    public String viewFacilityDomains(Model model, HttpServletRequest request) {

        //Fetch Facility Domains
        List<Map> faclilityDomainList = new ArrayList<>();
        String[] paramsfacilitydomain = {};
        Object[] paramsValuesfacilitydomain = {};
        String[] fieldsfacilitydomain = {"facilitydomainid", "domainname", "description", "status"};
        String wherefacilitydomain = "";
        List<Object[]> facilityDomain = (List<Object[]>) genericClassService.fetchRecord(Facilitydomain.class, fieldsfacilitydomain, wherefacilitydomain, paramsfacilitydomain, paramsValuesfacilitydomain);
        Map<String, Object> fDomain;
        int facilityLevelCount = 0;
        int facilityDesignationCategoryCount = 0;
        if (facilityDomain != null) {
            for (Object[] domn : facilityDomain) {
                fDomain = new HashMap<>();
                fDomain.put("facilitydomainid", (Integer) domn[0]);
                fDomain.put("domainname", (String) domn[1]);
                fDomain.put("description", (String) domn[2]);
                fDomain.put("status", (Boolean) domn[3]);

                // Count Domain Levels
                String[] paramsLevelCount = {"facilitydomain"};
                Object[] paramsValuesLevelCount = {(Integer) domn[0]};
                String whereLevelCount = "WHERE facilitydomain=:facilitydomain";
                facilityLevelCount = genericClassService.fetchRecordCount(Facilitylevel.class, whereLevelCount, paramsLevelCount, paramsValuesLevelCount);
                fDomain.put("faclilityDomainLevelCount", facilityLevelCount);

                // Count Designation Categories
                String[] paramsDesigtnCategoryCount = {"facilitydomainid"};
                Object[] paramsValuesDesigtnCategoryCount = {(Integer) domn[0]};
                String whereDesigtnCategoryCount = "WHERE facilitydomainid=:facilitydomainid";
                facilityDesignationCategoryCount = genericClassService.fetchRecordCount(Designationcategory.class, whereDesigtnCategoryCount, paramsDesigtnCategoryCount, paramsValuesDesigtnCategoryCount);
                fDomain.put("facilityDesignationCategoryCount", facilityDesignationCategoryCount);

                faclilityDomainList.add(fDomain);
            }
            model.addAttribute("faclilityDomainList", faclilityDomainList);

            //Fetch All Domain Levels
            List<Facilitylevel> faclilityLevelList2 = new ArrayList<>();
            String[] paramsfacilitylevel2 = {};
            Object[] paramsValuesfacilitylevel2 = {};
            String[] fieldsfacilitylevel2 = {"facilitylevelid", "shortname", "description", "facilitylevelname"};
            String wherefacilitylevel2 = "";
            List<Object[]> facilitylevel2 = (List<Object[]>) genericClassService.fetchRecord(Facilitylevel.class, fieldsfacilitylevel2, wherefacilitylevel2, paramsfacilitylevel2, paramsValuesfacilitylevel2);
            Facilitylevel fLevel2;
            if (facilitylevel2 != null) {
                for (Object[] levels : facilitylevel2) {
                    fLevel2 = new Facilitylevel();
                    fLevel2.setFacilitylevelid((Integer) levels[0]);
                    fLevel2.setShortname((String) levels[1]);
                    fLevel2.setDescription((String) levels[2]);
                    fLevel2.setFacilitylevelname((String) levels[3]);
                    faclilityLevelList2.add(fLevel2);
                }
                model.addAttribute("faclilityLevelList", faclilityLevelList2);
            }
        }
        return "controlPanel/universalPanel/facility/views/viewFacilityDomains";
    }

    @RequestMapping(value = "/submitfacilitydomain", method = RequestMethod.POST)
    public @ResponseBody
    String submitFacilityDomain(Model model, HttpServletRequest request) {
        int newDomainId = 0;
        Facilitydomain facilitydomain = new Facilitydomain();
        String domainname = request.getParameter("domainname");
        String description = request.getParameter("description2");

        facilitydomain.setDomainname(domainname);
        facilitydomain.setDescription(description);
        facilitydomain.setStatus(true);
        facilitydomain = (Facilitydomain) genericClassService.saveOrUpdateRecordLoadObject(facilitydomain);

        if (facilitydomain != null) {
            newDomainId = facilitydomain.getFacilitydomainid();
        }
        return String.valueOf(newDomainId);
    }

    @RequestMapping(value = "/updatefacilitydomain", method = RequestMethod.POST)
    public String updateFacilityDomain(Model model, HttpServletRequest request) {
        String updatedomainname = request.getParameter("updatedomainname");
        String updatedescription2 = request.getParameter("updatedescription2");
        int facilitydomainid = Integer.parseInt(request.getParameter("facilitydomainid"));

        String[] columnsdom = {"domainname", "description"};
        Object[] columnValuesdom = {updatedomainname, updatedescription2};
        String domainPrimaryKey = "facilitydomainid";
        Object domainPkValue = facilitydomainid;
        genericClassService.updateRecordSQLSchemaStyle(Facilitydomain.class, columnsdom, columnValuesdom, domainPrimaryKey, domainPkValue, "public");
        return "controlPanel/universalPanel/facility/views/facilityOwnersTabContent";
    }

    @RequestMapping(value = "/facilitywoners", method = RequestMethod.GET)
    public String viewFacilityOwners(Model model) {
        //Fetch Facility Owners
        List<Facilityowner> faclilityOwnerList2 = new ArrayList<>();
        String[] paramsfacilityowner2 = {};
        Object[] paramsValuesfacilityowner2 = {};
        String[] fieldsfacilityowner2 = {"facilityownerid", "ownername", "description"};
        String wherefacilityowner2 = "";
        List<Object[]> facilityOwner2 = (List<Object[]>) genericClassService.fetchRecord(Facilityowner.class, fieldsfacilityowner2, wherefacilityowner2, paramsfacilityowner2, paramsValuesfacilityowner2);
        Facilityowner fOwners2;
        if (facilityOwner2 != null) {
            for (Object[] own : facilityOwner2) {
                fOwners2 = new Facilityowner();
                fOwners2.setFacilityownerid((Integer) own[0]);
                fOwners2.setOwnername((String) own[1]);
                fOwners2.setDescription((String) own[2]);
                faclilityOwnerList2.add(fOwners2);
            }
            model.addAttribute("faclilityOwnerList", faclilityOwnerList2);
        }
        return "controlPanel/universalPanel/facility/views/facilityOwnersTabContent";
    }
    
    @RequestMapping(value = "/discardFacilitywOners", method = RequestMethod.GET)
    public final ModelAndView discardFacilitywOners(Principal principal, HttpServletRequest request,
            @RequestParam("act") String activity, @RequestParam("i") long id) {

        Map<String, Object> model = new HashMap<String, Object>();

        String[] paramsfacilityowner2 = {"Id"};
        Object[] paramsValuesfacilityowner2 = {id};
        String wherefacilityowner2 = "WHERE r.facilityownerid=:Id";
        List<Object[]> facilityOwner2 = (List<Object[]>) genericClassService.fetchRecord(Facilityowner.class, new String[]{"facilityownerid", "ownername", "description"}, wherefacilityowner2, paramsfacilityowner2, paramsValuesfacilityowner2);
        Facilityowner fOwner = new Facilityowner();
        if (facilityOwner2 != null) {
            for (Object[] own : facilityOwner2) {
                fOwner = new Facilityowner();
                fOwner.setFacilityownerid((Integer) own[0]);
                fOwner.setOwnername((String) own[1]);
            }
        }
        genericClassService.deleteRecordByByColumns(Facilityowner.class, new String[]{"facilityownerid"}, new Object[]{id});
        //Checking for successful deletion        
        //Check if Owner Still Exists = {"Id"};
        if (genericClassService.fetchRecord(Facilityowner.class, new String[]{"facilityownerid", "ownername", "description"}, wherefacilityowner2, paramsfacilityowner2, paramsValuesfacilityowner2) != null) {
            String[] params = {"Id"};
            Object[] paramsValues = {id};
            int countFacs = genericClassService.fetchRecordCount(Facility.class, "WHERE r.facilityownerid.facilityownerid=:Id", params, paramsValues);
            fOwner.setSubunits(countFacs);
            fOwner.setActive(false);
            fOwner.setDescription("Delete Failed! Divorce Any Attachments ");
//            <a href='#' onClick=\"ajaxSubmitData('facility/viewFacOwnerAttachment.htm', 'facliltyOwnerContent', 'act=a&i="+id+"&b=a&c=0&d=0', 'GET');\">[Facility Records:" + countFacs + "]</a>
        } else {
            fOwner.setActive(true);
        }
        model.put("facOwner", fOwner);
        return new ModelAndView("controlPanel/universalPanel/facility/views/discardFacOwnerResp", "model", model);
    }
    
    /**
     *
     * @param principal
     * @return
     */
    @RequestMapping("/viewFacOwnerAttachment")
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView viewFacOwnerAttachment(Principal principal, HttpServletRequest request,
            @RequestParam("act") String activity, @RequestParam("i") long id, @RequestParam("d") long id2,
            @RequestParam("b") String strVal, @RequestParam("c") String strVal2) {
        if (principal == null) {
            return new ModelAndView("refresh");
        }
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            model.put("act", activity);
            model.put("b", strVal);
            model.put("i", id);
            model.put("c", strVal2);
            model.put("d", id2);

            System.out.print("activity.equals(a):"+activity.equals("a"));
            if (activity.equals("a")) {
                
                String[] paramsfacilityowner2 = {"Id"};
                Object[] paramsValuesfacilityowner2 = {id};
                String whereOwner = "WHERE r.facilityownerid=:Id";
                List<Object[]> facilityOwner = (List<Object[]>) genericClassService.fetchRecord(Facilityowner.class, new String[]{"facilityownerid", "ownername", "description"}, whereOwner, paramsfacilityowner2, paramsValuesfacilityowner2);
                Facilityowner fOwner = new Facilityowner();
                if (facilityOwner != null) {
                    for (Object[] own : facilityOwner) {
                        fOwner = new Facilityowner();
                        fOwner.setFacilityownerid((Integer) own[0]);
                        fOwner.setOwnername((String) own[1]);
                    }
                }
                
                List<Facility> facilityList = new ArrayList<Facility>();
                String where2 = "WHERE r.facilityownerid.facilityownerid=:Id ORDER BY r.facilityname ASC";
                List<Object[]> facilityArrList = (List<Object[]>) genericClassService.fetchRecord(Facility.class, new String[]{"facilityid", "facilityname", "facilitylevelid.facilitylevelname"}, where2, new String[]{"Id"}, new Object[]{id});
                if (facilityArrList != null) {
                    for (Object[] obj : facilityArrList) {
                        Facility fac = new Facility((Integer)obj[0]);
                        fac.setFacilityname((String)obj[1]);
                        Facilitylevel level = new Facilitylevel();
                        level.setFacilitylevelname((String)obj[2]);
                        fac.setFacilitylevelid(level);
                        facilityList.add(fac);
                    }
                }
                System.out.print("fOwner *****************:"+fOwner.getOwnername());
                model.put("facOwner", fOwner);
                model.put("facilityList", facilityList);
                if(facilityList!=null){
                    model.put("size", facilityList.size());
                }
                
                List<Facilityowner> facilityOwnerList = new ArrayList<Facilityowner>();
                List<Object[]> facilityOwnerArr = (List<Object[]>) genericClassService.fetchRecord(Facilityowner.class, new String[]{"facilityownerid", "ownername"}, "ORDER BY r.ownername ASC ", new String[]{}, new Object[]{});
                if (facilityOwnerArr != null) {
                    for (Object[] own : facilityOwnerArr) {
                        Facilityowner fo = new Facilityowner();
                        fo.setFacilityownerid((Integer) own[0]);
                        fo.setOwnername((String) own[1]);
                        facilityOwnerList.add(fo);
                    }
                }
                model.put("facilityOwnerList", facilityOwnerList);
                return new ModelAndView("controlPanel/universalPanel/facility/views/attachedFacility", "model", model);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        model.put("success", "<span class='text6'>Contact System Administrator :: Page Not Found!</span>");
        return new ModelAndView("response", "model", model);
    }
    
    
    /**
     *
     * @param request
     * @param principal
     * @return
     */
    @RequestMapping(value = "/transferFacility", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView transferFacility(HttpServletRequest request, Principal principal) {
        System.out.println("Received request to transfer attachment to facility owner");
        Map<String, Object> model = new HashMap<String, Object>();
        int facilityOwner = Integer.parseInt(request.getParameter("owner"));
        int ownerId = Integer.parseInt(request.getParameter("ownerId"));
        try {
            if (principal == null) {
                return new ModelAndView("refresh");
            }
                        
            List<Integer> ids = new ArrayList<Integer>();
            List<Facility> customList = new ArrayList<Facility>();

            int count = Integer.parseInt(request.getParameter("itemSize"));
            if (count > 0) {
                for (int i = 1; i <= count; i++) {
                    if (request.getParameter("selectObj" + i) != null) {
                        int id = Integer.parseInt(request.getParameter("selectObj" + i));
                        ids.add(id);
                    }
                }
            } else {
                return discardFacilitywOners(principal, request, "a", ownerId);
            }
            for (Integer id : ids) {
                genericClassService.updateRecordSQLStyle(Facility.class, new String[]{"facilityownerid"},new Object[]{facilityOwner}, "facilityid", id);
            }
            model.put("customList", customList);
            if (customList != null) {
                model.put("size", customList.size());
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.put("resp", false);
            model.put("errorMessage", "Action Unsuccessfull!. If Error Persists Contact Systems Admin");
        }
        model.put("mainActivity", "Facility");
        return discardFacilitywOners(principal, request, "a", ownerId);
    }
    
    @RequestMapping(value = "/addnewdomainlevel", method = RequestMethod.GET)
    public String addNewDomainLevel(Model model, @ModelAttribute("domainid") int domainid, @ModelAttribute("domainname") String domainname) {

        model.addAttribute("domainid", domainid);
        model.addAttribute("domainname", domainname);
        return "controlPanel/universalPanel/facility/forms/addNewDomainLevels";
    }

    @RequestMapping(value = "/viewfacilitylevel", method = RequestMethod.GET)
    public String updateFacilityLevel(Model model, @ModelAttribute("domainid") int domainid, @ModelAttribute("domainname") String domainname) {
        //Fetch All Domain Levels
        List<Facilitylevel> faclilityLevelList = new ArrayList<>();
        String[] paramsfacilitylevel = {"facilitydomain"};
        Object[] paramsValuesfacilitylevel = {domainid};
        String[] fieldsfacilitylevel = {"facilitylevelid", "shortname", "description", "facilitylevelname"};
        String wherefacilitylevel = "WHERE facilitydomain=:facilitydomain";
        List<Object[]> facilitylevel = (List<Object[]>) genericClassService.fetchRecord(Facilitylevel.class, fieldsfacilitylevel, wherefacilitylevel, paramsfacilitylevel, paramsValuesfacilitylevel);
        Facilitylevel fLevel;
        if (facilitylevel != null) {
            for (Object[] levels : facilitylevel) {
                fLevel = new Facilitylevel();
                fLevel.setFacilitylevelid((Integer) levels[0]);
                fLevel.setShortname((String) levels[1]);
                fLevel.setDescription((String) levels[2]);
                fLevel.setFacilitylevelname((String) levels[3]);
                faclilityLevelList.add(fLevel);
            }
            model.addAttribute("faclilityLevelList", faclilityLevelList);
            model.addAttribute("domainid", domainid);
            model.addAttribute("domainname", domainname);
        }
        return "controlPanel/universalPanel/facility/views/viewFacilityLevels";
    }

    @RequestMapping(value = "/submitfacilitylevel", method = RequestMethod.POST)
    public @ResponseBody
    String submitFacilityLevels(Model model, HttpServletRequest request, @ModelAttribute("ids") String ids, @ModelAttribute("items") String items) {
        try {
            List levelList = new ObjectMapper().readValue(ids, List.class);
            List<Map> itemList = new ObjectMapper().readValue(items, List.class);
            for (Object itemCode : levelList) {
                for (Map item : itemList) {
                    if (itemCode.equals(item.get("shortname"))) {
                        Facilitylevel newItem = new Facilitylevel();
                        newItem.setFacilitylevelname((String) item.get("facilitylevelname"));
                        newItem.setFacilitydomain(Integer.parseInt((String) item.get("domainid")));
                        newItem.setShortname((String) item.get("shortname"));
                        newItem.setDescription((String) item.get("description"));
                        genericClassService.saveOrUpdateRecordLoadObject(newItem);
                    }
                }
            }
        } catch (IOException ex) {
            return "Failed";
        }
        return "Saved";
    }

    @RequestMapping(value = "/updatedomainlevel", method = RequestMethod.POST)
    public @ResponseBody
    String updateDomainLevel(Model model, HttpServletRequest request) {
        String updatelevelname = request.getParameter("updatelevelname");
        String shortname2 = request.getParameter("shortname2");
        String updatedescription2 = request.getParameter("updatedescription2");
        int facilitylevelid = Integer.parseInt(request.getParameter("facilitylevelid"));

        String[] columnslev = {"facilitylevelname", "shortname", "description"};
        Object[] columnValueslev = {updatelevelname, shortname2, updatedescription2};
        String levelPrimaryKey = "facilitylevelid";
        Object levelPkValue = facilitylevelid;
        genericClassService.updateRecordSQLSchemaStyle(Facilitylevel.class, columnslev, columnValueslev, levelPrimaryKey, levelPkValue, "public");
        return "";
    }

    @RequestMapping(value = "/viewfacilities", method = RequestMethod.GET)
    public String viewFacilities(Model model) {
        //Fetch All Domain Levels
        List<Facility> faclilitiesList = new ArrayList<>();
        String[] paramsfacility = {};
        Object[] paramsValuesfacility = {};
        String[] fieldsfacility = {"facilityid", "facilityname", "facilitycode", "status"};
        String wherefacility = "ORDER BY facilityname";
        List<Object[]> facilityObj = (List<Object[]>) genericClassService.fetchRecord(Facility.class, fieldsfacility, wherefacility, paramsfacility, paramsValuesfacility);
        Facility facility;
        if (facilityObj != null) {
            for (Object[] levels : facilityObj) {
                facility = new Facility();
                facility.setFacilityid((Integer) levels[0]);
                facility.setFacilityname((String) levels[1]);
                facility.setFacilitycode((String) levels[2]);
                facility.setStatus((String) levels[3]);
                faclilitiesList.add(facility);
            }
            model.addAttribute("faclilitiesList", faclilitiesList);
        }
        return "controlPanel/universalPanel/facility/views/viewFacilities";
    }

    @RequestMapping(value = "/fetchfaclilityowners", method = RequestMethod.POST)
    public @ResponseBody
    String fetchFaclilityOwners(Model model) {
        String jsondata = "";
        //Fetch Facility Owners
        List<Map> faclilityOwnerList2 = new ArrayList<>();
        String[] paramsfacilityowner2 = {};
        Object[] paramsValuesfacilityowner2 = {};
        String[] fieldsfacilityowner2 = {"facilityownerid", "ownername"};
        String wherefacilityowner2 = "";
        List<Object[]> facilityOwner2 = (List<Object[]>) genericClassService.fetchRecord(Facilityowner.class, fieldsfacilityowner2, wherefacilityowner2, paramsfacilityowner2, paramsValuesfacilityowner2);
        Map<String, Object> fOwners;
        if (facilityOwner2 != null) {
            for (Object[] own2 : facilityOwner2) {
                fOwners = new HashMap<>();
                fOwners.put("id", (Integer) own2[0]);
                fOwners.put("ownername", (String) own2[1]);
                faclilityOwnerList2.add(fOwners);
            }
        }
        try {
            jsondata = new ObjectMapper().writeValueAsString(faclilityOwnerList2);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }
        return jsondata;
    }

    @RequestMapping(value = "/fetchfaclilitydomains", method = RequestMethod.POST)
    public @ResponseBody
    String fetchFaclilityDomains(Model model) {
        String jsondata = "";
        //Fetch Facility Owners
        List<Map> facilityDomainsList2 = new ArrayList<>();
        String[] paramsfacilitydomain2 = {};
        Object[] paramsValuesfacilitydomain2 = {};
        String[] fieldsfacilitydomain2 = {"facilitydomainid", "domainname"};
        String wherefacilitydomain2 = "";
        List<Object[]> facilityDomain2 = (List<Object[]>) genericClassService.fetchRecord(Facilitydomain.class, fieldsfacilitydomain2, wherefacilitydomain2, paramsfacilitydomain2, paramsValuesfacilitydomain2);
        Map<String, Object> fDomain;
        if (facilityDomain2 != null) {
            for (Object[] own2 : facilityDomain2) {
                fDomain = new HashMap<>();
                fDomain.put("id", (Integer) own2[0]);
                fDomain.put("domainname", (String) own2[1]);
                facilityDomainsList2.add(fDomain);
            }

        }
        try {
            jsondata = new ObjectMapper().writeValueAsString(facilityDomainsList2);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }
        return jsondata;
    }

    @RequestMapping(value = "/fetchdomainlevels", method = RequestMethod.POST)
    public @ResponseBody
    String fetchDomainLevels(Model model, @ModelAttribute("domainid") Integer domainid) {
        String jsondata = "";
        List<Map> levels = new ArrayList<>();
        String[] params = {"facilitydomain"};
        Object[] paramsValues = {domainid};
        String[] fields = {"facilitylevelid", "facilitylevelname", "shortname"};
        String where = "WHERE facilitydomain=:facilitydomain ORDER BY facilitylevelname";
        List<Object[]> objLevels = (List<Object[]>) genericClassService.fetchRecord(Facilitylevel.class, fields, where, params, paramsValues);
        if (objLevels != null) {
            Map<String, Object> domainLevels;
            for (Object[] domainLevelDetails : objLevels) {
                domainLevels = new HashMap<>();
                domainLevels.put("id", (Integer) domainLevelDetails[0]);
                domainLevels.put("facilitylevelname", (String) domainLevelDetails[1]);
                domainLevels.put("shortname", (String) domainLevelDetails[2]);
                levels.add(domainLevels);
            }
        }
        try {
            jsondata = new ObjectMapper().writeValueAsString(levels);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }
        return jsondata;
    }

    @RequestMapping(value = "/viewfacilitycategories", method = RequestMethod.GET)
    public String viewFacilityCategories(Model model, @ModelAttribute("domainid") int domainid, @ModelAttribute("domainname") String domainname) {
        //Fetch All Domain Levels
        List<Designationcategory> domainCategoryList = new ArrayList<>();
        String[] paramsdomaincategory = {"facilitydomainid"};
        Object[] paramsValuesdomaincategory = {domainid};
        String[] fieldsdomaincategory = {"designationcategoryid", "categoryname", "description"};
        String wheredomaincategory = "WHERE facilitydomainid=:facilitydomainid";
        List<Object[]> domaincategoryobj = (List<Object[]>) genericClassService.fetchRecord(Designationcategory.class, fieldsdomaincategory, wheredomaincategory, paramsdomaincategory, paramsValuesdomaincategory);
        Designationcategory desiginationcategories;
        if (domaincategoryobj != null) {
            for (Object[] categories : domaincategoryobj) {
                desiginationcategories = new Designationcategory();
                desiginationcategories.setDesignationcategoryid((Integer) categories[0]);
                desiginationcategories.setCategoryname((String) categories[1]);
                desiginationcategories.setDescription((String) categories[2]);
                domainCategoryList.add(desiginationcategories);
            }
            model.addAttribute("domainCategoryList", domainCategoryList);
            model.addAttribute("domainid", domainid);
            model.addAttribute("domainname", domainname);
        }
        return "controlPanel/universalPanel/facility/views/viewDomainCategories";
    }

    @RequestMapping(value = "/addnewdomaincategory", method = RequestMethod.GET)
    public String addNewDomainCategory(Model model, @ModelAttribute("domainid") int domainid, @ModelAttribute("domainname") String domainname) {

        model.addAttribute("domainid", domainid);
        model.addAttribute("domainname", domainname);
        return "controlPanel/universalPanel/facility/forms/addNewDomainCategory";
    }

    @RequestMapping(value = "/submitnewfacility", method = RequestMethod.POST)
    public @ResponseBody
    String submitNewFacility(Model model, HttpServletRequest request) {
        Facility newFacility;
        String facilityname = request.getParameter("facilityname");
        String facilitycode = request.getParameter("facilitycode");
        int facilityowner = Integer.parseInt(request.getParameter("facilityowner"));
        int facilitydomains = Integer.parseInt(request.getParameter("facilitydomains"));
        int facilitydomainlevels = Integer.parseInt(request.getParameter("facilitydomainlevels"));
        int village = Integer.parseInt(request.getParameter("village"));

        newFacility = new Facility();
        newFacility.setFacilityname(facilityname);
        newFacility.setFacilitycode(facilitycode);
        newFacility.setFacilityownerid(new Facilityowner(facilityowner));
        newFacility.setFacilitydomainid(new Facilitydomain(facilitydomains));
        newFacility.setFacilitylevelid(new Facilitylevel(facilitydomainlevels));
        newFacility.setStatus("APPROVED");
        newFacility = (Facility) genericClassService.saveOrUpdateRecordLoadObject(newFacility);

        if (newFacility != null) {
            Location location = new Location();
            location.setFacilityid(new Facility(newFacility.getFacilityid()));
            location.setVillageid(new Village(village));
        }
        return "";
    }
    
     @RequestMapping(value = "/updatefacility", method = RequestMethod.POST)
    public @ResponseBody
    String updateFacility(Model model, HttpServletRequest request) {
        String updatedfacilityname = request.getParameter("updatedfacilityname");
        String updatedshortname = request.getParameter("updatedshortname");
        int facilitiesId = Integer.parseInt(request.getParameter("facilitiesId"));

        String[] columns = {"facilityname", "facilitycode"};
        Object[] columnValues = {updatedfacilityname, updatedshortname};
        String pk = "facilityid";
        Object pkValue = facilitiesId;
        genericClassService.updateRecordSQLSchemaStyle(Facility.class, columns, columnValues, pk, pkValue, "public");
        return "";
    }
}
