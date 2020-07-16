/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.controlpanel.Stafffacilityunit;
import com.iics.domain.Ctrycurrency;
import com.iics.domain.Designation;
import com.iics.service.GenericClassService;
import java.util.ArrayList;
import java.util.List;
import java.security.Principal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.iics.domain.Designationcategory;
import com.iics.domain.Dutiesandresponsibilities;
import com.iics.domain.Facilitydomain;
import com.iics.domain.Facilitylevel;
import com.iics.domain.Facilitylevelconfigrations;
import com.iics.domain.Facilityunit;
import com.iics.domain.Poststatisticsview;
import com.iics.domain.Scheduleandpostconfigview;
import com.iics.domain.Searchstaff;
import com.iics.domain.Systemrole;
import java.io.IOException;
import java.util.Date;
import org.springframework.web.bind.annotation.RequestParam;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.iics.domain.Staff;
import static com.iics.web.RegisterUser.logger;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.HashSet;
import java.util.Set;
import java.util.logging.Logger;

/**
 *
 * @author SAMINUNU
 */
@Controller
@RequestMapping("/postsandactivities")
public class PostsAndActivitiesController {

    @Autowired
    GenericClassService genericClassService;

    @RequestMapping(value = "/postsandactivitiesPane", method = RequestMethod.GET)
    public final ModelAndView postsAndActivitiesPane(HttpServletRequest request) {

        Map<String, Object> model = new HashMap<String, Object>();

        if ("a".equals(request.getParameter("act"))) {

            int designationcategoryId = Integer.parseInt(request.getParameter("uniCatId"));

            List<Designation> post = new ArrayList<>();
            String[] paramszrr = {"designationcategoryId"};
            Object[] paramsValueszrr = {designationcategoryId};
            String[] fieldszrr = {"designationid", "designationcategoryid", "designationname", "shortname", "description", "status"};
            String wherezrr = "WHERE r.designationcategoryid=:designationcategoryId ORDER BY r.designationname ASC";

            List<Object[]> posts = (List<Object[]>) genericClassService.fetchRecord(Designation.class, fieldszrr, wherezrr, paramszrr, paramsValueszrr);
            if (posts != null) {
                for (Object[] dp : posts) {
                    Designation dpost = new Designation();
                    dpost.setDesignationid((Integer) dp[0]);
                    dpost.setDesignationcategoryid((Integer) dp[1]);
//                    dpost.setDesignationname((String) dp[2]);
                    dpost.setDesignationname(capitalize_first_leter(dp[2].toString()));
                    dpost.setShortname((String) dp[3]);
                    dpost.setDescription((String) dp[4]);
                    dpost.setStatus((Boolean) dp[5]);
                    post.add(dpost);
                }
            }
            List<Map> categories = new ArrayList<Map>();

            String[] paramszr = {"facilitydomainid"};
            Object[] paramsValueszr = {103};
            String[] fieldszr = {"categoryname", "designationcategoryid"};
            String wherezr = "WHERE facilitydomainid=:facilitydomainid";
            List<Object[]> designationCategories = (List<Object[]>) genericClassService.fetchRecord(Designationcategory.class, fieldszr, wherezr, paramszr, paramsValueszr);
            Map<String, Object> category;
            if (designationCategories != null) {
                for (Object[] designationCategory : designationCategories) {
                    category = new HashMap<>();
                    category.put("designationcategoryid", designationCategory[1]);
                    category.put("categoryname", designationCategory[0]);
                    categories.add(category);
                }
            }
            model.put("facilitydomainid", 103);
            model.put("Categories", categories);
            model.put("viewUniversaldesignationposts", post);
            return new ModelAndView("controlPanel/universalPanel/postsAndactivities/views/UnidesigCatPosts", "model", model);
        }

        //Fetch Facility Domains
        String[] paramsfacilitydomain = {"facilitydomainid"};
        Object[] paramsValuesfacilitydomain = {103};
        String[] fieldsfacilitydomain = {"facilitydomainid", "domainname", "description", "status"};
        String wherefacilitydomain = "WHERE facilitydomainid=:facilitydomainid";
        List<Object[]> facilityDomain = (List<Object[]>) genericClassService.fetchRecord(Facilitydomain.class, fieldsfacilitydomain, wherefacilitydomain, paramsfacilitydomain, paramsValuesfacilitydomain);
        Facilitydomain fDomain;
        if (facilityDomain != null && facilityDomain.size() > 0) {
            fDomain = new Facilitydomain();
            fDomain.setFacilitydomainid((Integer) facilityDomain.get(0)[0]);
            fDomain.setDomainname((String) facilityDomain.get(0)[1]);
            fDomain.setDescription((String) facilityDomain.get(0)[2]);
            fDomain.setStatus((Boolean) facilityDomain.get(0)[3]);

            model.put("faclilityDomainList", fDomain);

        }

        List<Designationcategory> domaincategory = new ArrayList<>();

        String[] paramszr = {"facilitydomainid"};
        Object[] paramsValueszr = {103};
        String[] fieldszr = {"designationcategoryid", "facilitydomainid", "categoryname", "description", "disabled"};
        String wherezr = "WHERE facilitydomainid=:facilitydomainid ORDER BY categoryname ASC";
        List<Object[]> domainc = (List<Object[]>) genericClassService.fetchRecord(Designationcategory.class, fieldszr, wherezr, paramszr, paramsValueszr);
        if (domainc != null) {
            for (Object[] ddz : domainc) {
                Designationcategory designations = new Designationcategory();
                designations.setDesignationcategoryid((Integer) ddz[0]);
                designations.setFacilitydomainid((Integer) ddz[1]);
                // designations.setCategoryname((String) ddz[2]);
                designations.setCategoryname(capitalize(ddz[2].toString()));
                designations.setDescription((String) ddz[3]);
                designations.setDisabled((Boolean) ddz[4]);
                int count = genericClassService.fetchRecordCount(Designation.class, "WHERE r.designationcategoryid=:catId", new String[]{"catId"}, new Object[]{designations.getDesignationcategoryid()});
                designations.setRolessize(count);
                domaincategory.add(designations);
            }
            model.put("facilitydomainidtable", domaincategory);
        }

        return new ModelAndView("controlPanel/universalPanel/postsAndactivities/postsandactivitiesPane", "model", model);
    }

    //Fetch Schedule Of Duties form
    @RequestMapping(value = "/scheduleOfDuties", method = RequestMethod.GET)
    public final ModelAndView scheduleOfDuties(HttpServletRequest request, Model model) {
        return new ModelAndView("controlPanel/universalPanel/scheduleOfDuties/scheduleOfDutiesPane", "model", model);
    }

    @RequestMapping(value = "/fetchDuties", method = RequestMethod.GET)
    public final ModelAndView fetchDuties(HttpServletRequest request, Model model) {

        int designationid = Integer.parseInt(request.getParameter("designationid"));
        List<Map> dutieslist = new ArrayList<>();

        String[] fields = {"dutyid", "duty"};
        String[] params = {"designationid"};
        Object[] paramValues = {designationid};

        List<Object[]> duties = (List<Object[]>) genericClassService.fetchRecord(Dutiesandresponsibilities.class, fields, "WHERE designationid=:designationid", params, paramValues);
        if (duties != null) {
            Map<String, Object> dutyy;

            for (Object[] a : duties) {
                dutyy = new HashMap<>();

                dutyy.put("dutyid", a[0]);
                dutyy.put("duty", a[1]);
                dutyy.put("designationid", designationid);
                dutieslist.add(dutyy);
            }

        }
        model.addAttribute("dutieslist", dutieslist);
        model.addAttribute("designationid", designationid);
        return new ModelAndView("controlPanel/universalPanel/postsAndactivities/views/dutiesTable", "model", model);
    }

    @RequestMapping(value = "/fetchlocalDuties", method = RequestMethod.GET)
    public final ModelAndView fetchlocalDuties(HttpServletRequest request, Model model) {

        int designationid = Integer.parseInt(request.getParameter("designationid"));
        List<Map> dutieslist = new ArrayList<>();

        String[] fields = {"duty"};
        String[] params = {"designationid"};
        Object[] paramValues = {designationid};

        List<Object> duties = (List<Object>) genericClassService.fetchRecord(Dutiesandresponsibilities.class, fields, "WHERE designationid=:designationid", params, paramValues);
        if (duties != null) {
            Map<String, Object> dutyy;

            for (Object a : duties) {
                dutyy = new HashMap<>();

                dutyy.put("duty", a);
                dutieslist.add(dutyy);
            }

        }
        model.addAttribute("dutieslist", dutieslist);
        return new ModelAndView("controlPanel/localSettingsPanel/scheduleOfDuties/views/dutiesLocalTable", "model", model);
    }

    @RequestMapping(value = "/saveDuties", method = RequestMethod.POST)
    public final String saveDuties(HttpServletRequest request, Model model) {
        Dutiesandresponsibilities new_configuration = new Dutiesandresponsibilities();

        String duty = request.getParameter("duty");
        Integer designationid = Integer.parseInt(request.getParameter("designationid"));
        long currStaffid = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
        Date examDate = new Date();

        String[] params = {"designationid", "duty"};
        Object[] paramsValues = {designationid, duty};
        String[] fields = {"dutyid"};
        List<Integer> configuration = (List<Integer>) genericClassService.fetchRecord(Dutiesandresponsibilities.class, fields, "WHERE designationid=:designationid AND duty=:duty", params, paramsValues);
        if (configuration != null) {

            String[] columns = {"duty", "datecreated", "addedby"};
            Object[] columnValues = {duty, new Date(), BigInteger.valueOf(currStaffid)};
            String pk = "dutyid";
            Object pkValue = configuration.get(0);
            int result = genericClassService.updateRecordSQLSchemaStyle(Dutiesandresponsibilities.class, columns, columnValues, pk, pkValue, "public");

        } else {
            try {
                new_configuration.setDesignationid(designationid);
                new_configuration.setDuty(duty);
                new_configuration.setDatecreated(examDate);
                new_configuration.setAddedby(BigInteger.valueOf(currStaffid));
                new_configuration = (Dutiesandresponsibilities) genericClassService.saveOrUpdateRecordLoadObject(new_configuration);

            } catch (Exception ex) {
                System.out.println(ex);
            }
        }
        return "refresh";
    }

    @RequestMapping(value = "/fetchNewDuty", method = RequestMethod.GET)
    public final String fetchNewDuty(HttpServletRequest request, Model model) {
        return "controlPanel/universalPanel/postsAndactivities/form/addNewDuty";
    }

    @RequestMapping(value = "/scheduleOfDutieslocal", method = RequestMethod.GET)
    public final ModelAndView scheduleOfDutieslocal(HttpServletRequest request, Model model) {

        return new ModelAndView("controlPanel/localSettingsPanel/scheduleOfDuties/scheduleOfDutiesLocalPane", "model", model);
    }

    @RequestMapping(value = "/fetchfacilityDesignationtable", method = RequestMethod.GET)
    public final String fetchfacilityDesignationtable(HttpServletRequest request, Model model) {

        Integer facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());

        List<Map> facilityPosts = new ArrayList<>();
        String[] fields = {"facilitylevelid", "facilityname", "designationid", "requiredstaff", "designationname"};
        String[] params = {"facilityid"};
        Object[] paramValues = {facilityid};
        List<Object[]> posts = (List<Object[]>) genericClassService.fetchRecord(Scheduleandpostconfigview.class, fields, "WHERE facilityid=:facilityid", params, paramValues);
        if (posts != null) {
            Map<String, Object> fMap;
            for (Object[] a : posts) {
                fMap = new HashMap<>();
                fMap.put("facilitylevelid", a[0]);
                fMap.put("facilityname", a[1]);
                fMap.put("designationid", a[2]);

                String[] paramz = {"designationid", "currentfacility"};
                Object[] paramValuez = {Integer.parseInt(a[2].toString()), facilityid};
                int staffCount = (int) genericClassService.fetchRecordCount(Staff.class, "WHERE designationid=:designationid AND currentfacility=:currentfacility", paramz, paramValuez);

                fMap.put("staffCount", staffCount);
                int pending = Integer.parseInt(a[3].toString()) - staffCount;
                fMap.put("pending", pending);
                fMap.put("requiredstaff", a[3]);
                fMap.put("designationname", a[4]);
                facilityPosts.add(fMap);
            }

        }

//            List<Map> facilityposts = new ArrayList<>();
//            String[] fieldd = {"facilitylevelid.facilitylevelid","facilityname"};
//            String[] paramd = {"facilityid"};
//            Object[] paramValuesd= {facilityid};
//            List<Object[]> facility = (List<Object[]>) genericClassService.fetchRecord(Facility.class, fieldd, "WHERE facilityid=:facilityid", paramd, paramValuesd);
//             if(facility != null){
//                Map<String,Object> fMap ;
//                    for(Object[] f: facility ){
//                        fMap = new HashMap<>();
//                        int fac = Integer.parseInt(f[0].toString());
//                        System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+fac);
//                        fMap.put("facilityname", f[1]);
//                        
//                        String[] fields = {"designationid","requiredstaff"};
//                        String[] params = {"facilitylevelid"};
//                        Object[] paramValues = {Integer.parseInt(f[0].toString())};
//                            List<Object[]> DesignationConfiguration = (List<Object[]>) genericClassService.fetchRecord(Facilitylevelconfigrations.class, fields, "WHERE facilitylevelid=:facilitylevelid", params, paramValues);
//
//                            if(DesignationConfiguration != null){
//                            
//
//                                for(Object[] a: DesignationConfiguration ){
//                                    
//                                    fMap.put("designationid", a[0]);
//                                    fMap.put("requiredstaff", a[1]);
//                                    
//                                    String[] fieldz = {"designationname"};
//                                    String[] paramz = {"designationid"};
//                                    Object[] paramValuez = {Integer.parseInt(a[0].toString())};
//                                    List<Object> designation = (List<Object>) genericClassService.fetchRecord(Designation.class, fieldz, "WHERE designationid=:designationid", paramz, paramValuez);
//                                    if(designation!= null){
//                                        for(Object b: designation ){
//                                            fMap.put("designationname", b);
//                                        }
//                                    }
//                                    
//                                    String[] paramy = {"designationid"};
//                                    Object[] paramValuey = {Integer.parseInt(a[0].toString())};
//                                    int staffCount = (int) genericClassService.fetchRecordCount(Staff.class, "WHERE designationid=:designationid", paramy, paramValuey);
//                                    fMap.put("staffCount", staffCount);
//                                }
//                            }
//                        
//                        facilityposts.add(fMap);
//                    }
        model.addAttribute("facilityPostslist", facilityPosts);

        return "controlPanel/localSettingsPanel/scheduleOfDuties/views/poststable";
    }

    @RequestMapping(value = "fetchfacilityLevelTable", method = RequestMethod.GET)
    public final ModelAndView fetchfacilityLevelTable(HttpServletRequest request, Model model) {

        List<Map> facilityLevel = new ArrayList<>();
        String[] fields = {"facilitylevelid", "facilitylevelname"};
        String[] params = {};
        Object[] paramValues = {};
        List<Object[]> levels = (List<Object[]>) genericClassService.fetchRecord(Facilitylevel.class, fields, "", params, paramValues);

        if (levels != null) {
            Map<String, Object> exam;

            for (Object[] a : levels) {
                exam = new HashMap<>();
                exam.put("facilitylevelid", a[0]);
                exam.put("facilitylevelname", a[1]);
                facilityLevel.add(exam);
            }
            model.addAttribute("facilityleveltable", facilityLevel);

        }
        return new ModelAndView("controlPanel/universalPanel/scheduleOfDuties/views/facilityleveltable", "model", model);
    }

    @RequestMapping(value = "/fetchdesignationTable", method = RequestMethod.GET)
    public final ModelAndView fetchdesignationTable(HttpServletRequest request, Model model) {

        List<Map> designationlist = new ArrayList<>();
        String[] fields = {"facilitylevelconfigrationid", "designationid", "facilitylevelid", "requiredstaff", "addedby", "datecreated", "dateupdated"};
        String[] params = {"facilitylevelid"};
        Object[] paramValues = {Integer.valueOf(request.getParameter("facilitylevelid"))};
        List<Object[]> levels = (List<Object[]>) genericClassService.fetchRecord(Facilitylevelconfigrations.class, fields, "WHERE facilitylevelid=:facilitylevelid", params, paramValues);

        if (levels != null) {
            Map<String, Object> exam;

            for (Object[] a : levels) {
                exam = new HashMap<>();
                exam.put("facilitylevelconfigrationid", a[0]);
                exam.put("designationid", a[1]);

                String[] fieldss = {"designationname"};
                String[] paramss = {"designationid"};
                Object[] paramValuess = {Integer.parseInt(a[1].toString())};
                List<Object> levelss = (List<Object>) genericClassService.fetchRecord(Designation.class, fieldss, "WHERE designationid=:designationid", paramss, paramValuess);
                exam.put("designationname", levelss.get(0));
                exam.put("facilityid", a[2]);
                exam.put("requiredstaff", a[3]);
                exam.put("addedby", a[4]);
                exam.put("datecreated", a[5]);
                designationlist.add(exam);
            }
            model.addAttribute("designationList", designationlist);

        }
        model.addAttribute("facilitylevelid", Integer.valueOf(request.getParameter("facilitylevelid")));
        return new ModelAndView("controlPanel/universalPanel/scheduleOfDuties/views/designationtable", "model", model);
    }

    @RequestMapping(value = "/fetchpoststatistics", method = RequestMethod.GET)
    public String fetchpoststatistics(HttpServletRequest request, Model model) {
        int designationid = Integer.parseInt(request.getParameter("designationid"));
        int facilitylevelid = Integer.parseInt(request.getParameter("facilitylevelid"));
        int requiredstaff = Integer.parseInt(request.getParameter("requiredstaff"));

        List<Map> postsList = new ArrayList<>();
        String[] fields = {"facilityname", "facilityid"};
        String[] params = {"designationid", "facilitylevelid"};
        Object[] paramValues = {designationid, facilitylevelid};
        List<Object[]> posts = (List<Object[]>) genericClassService.fetchRecord(Poststatisticsview.class, fields, "WHERE designationid=:designationid AND facilitylevelid=:facilitylevelid", params, paramValues);
        Map<String, Object> posted;
        if (posts != null) {

            for (Object[] a : posts) {
                int x = 0;
                posted = new HashMap<>();
                posted.put("facilityname", a[0]);
                String[] paramss = new String[]{"designationid", "facilityid"};
                Object[] paramValuess = {designationid, Integer.parseInt(a[1].toString())};
                fields = new String[]{"r.facilityname", "r.designationid", "r.designationname", " COUNT(r.staffid)", "r.facilityid"};
//                int x = genericClassService.fetchRecordCount(Poststatisticsview.class, "WHERE designationid=:designationid AND facilityid=:facilityid", paramss, paramValuess);
                List<Object[]> count = (List<Object[]>) genericClassService.fetchRecordFunction(Poststatisticsview.class, fields, "WHERE r.designationid=:designationid AND r.facilityid=:facilityid  GROUP BY r.facilityname, r.designationid, r.designationname, r.facilityid", paramss, paramValuess, 0, 0);
                if (count != null) {
                    x = Integer.parseInt(count.get(0)[3].toString());
                }
                posted.put("filledposts", x);
                postsList.add(posted);

            }
            model.addAttribute("postlist", postsList);
        } else {
            posted = new HashMap<>();
            posted.put("facilityname", "Currently No Facility with this post");
            posted.put("filledposts", 0);
            postsList.add(posted);
            model.addAttribute("postlist", postsList);

        }
        model.addAttribute("requiredstaff", requiredstaff);

        return "controlPanel/universalPanel/scheduleOfDuties/views/poststatisticstable";
    }

    @RequestMapping(value = "/fetchconfiguredesignation", method = RequestMethod.GET)
    public String fetchconfiguredesignation(HttpServletRequest request, Model model) {
        List<Map> designationlist = new ArrayList<>();
        String[] fields = {"designationid", "designationname"};
        String[] params = {};
        Object[] paramValues = {};
        List<Object[]> levels = (List<Object[]>) genericClassService.fetchRecord(Designation.class, fields, "", params, paramValues);

        if (levels != null) {
            Map<String, Object> exam;

            for (Object[] a : levels) {
                exam = new HashMap<>();
                exam.put("designationid", a[0]);
                exam.put("designationname", a[1]);

                designationlist.add(exam);
            }
            model.addAttribute("designationList", designationlist);

        }
        return "controlPanel/universalPanel/scheduleOfDuties/forms/configuredesignation";
    }

    @RequestMapping(value = "/fetchupdatedesignation", method = RequestMethod.GET)
    public String fetchupdatedesignation(HttpServletRequest request, Model model) {

        return "controlPanel/universalPanel/scheduleOfDuties/forms/updateConfigForm";
    }

    @RequestMapping(value = "/fetchupdateduty", method = RequestMethod.GET)
    public String fetchupdateduty(HttpServletRequest request, Model model) {
        String designationid = request.getParameter("designationid");
        String duty = request.getParameter("duty");
        String dutyid = request.getParameter("dutyid");

        model.addAttribute("designationid", designationid);
        model.addAttribute("duty", duty);
        model.addAttribute("dutyid", dutyid);
        return "controlPanel/universalPanel/postsAndactivities/form/updateDuty";
    }

    @RequestMapping(value = "fetchDutieslocal", method = RequestMethod.GET)
    public final String fetchDutieslocal(HttpServletRequest request, Model model) {
        int designationid = Integer.parseInt(request.getParameter("designationid"));
        List<Map> dutieslist = new ArrayList<>();

        String[] fields = {"dutyid", "duty"};
        String[] params = {"designationid"};
        Object[] paramValues = {designationid};

        List<Object[]> duties = (List<Object[]>) genericClassService.fetchRecord(Dutiesandresponsibilities.class, fields, "WHERE designationid=:designationid", params, paramValues);
        if (duties != null) {
            Map<String, Object> dutyy;

            for (Object[] a : duties) {
                dutyy = new HashMap<>();

                dutyy.put("dutyid", a[0]);
                dutyy.put("duty", a[1]);
                dutyy.put("designationid", designationid);
                dutieslist.add(dutyy);
            }

        }
        model.addAttribute("dutieslist", dutieslist);
        model.addAttribute("designationid", designationid);
        return "controlPanel/localSettingsPanel/scheduleOfDuties/views/dutiesLocalTable";
    }

    @RequestMapping(value = "/saveNewDesignationConfiguration", method = RequestMethod.GET)
    public String saveNewDesignationConfiguration(HttpServletRequest request, Model model) {

        Facilitylevelconfigrations new_configuration = new Facilitylevelconfigrations();

        Integer requiredStaff = Integer.parseInt(request.getParameter("requiredstaff"));
        Integer designationid = Integer.parseInt(request.getParameter("designationid"));
        Integer facilitylevelid = Integer.parseInt(request.getParameter("facilitylevelid"));
        long currStaffid = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");
        Date examDate = new Date();

        String[] params = {"designationid", "facilitylevelid"};
        Object[] paramsValues = {designationid, facilitylevelid};
        String[] fields = {"facilitylevelconfigrationid"};
        List<Integer> configuration = (List<Integer>) genericClassService.fetchRecord(Facilitylevelconfigrations.class, fields, "WHERE designationid=:designationid AND facilitylevelid=:facilitylevelid", params, paramsValues);
        if (configuration != null) {

            String[] columns = {"requiredstaff", "dateupdated", "updatedby"};
            Object[] columnValues = {requiredStaff, new Date(), BigInteger.valueOf(currStaffid)};
            String pk = "facilitylevelconfigrationid";
            Object pkValue = configuration.get(0);
            int result = genericClassService.updateRecordSQLSchemaStyle(Facilitylevelconfigrations.class, columns, columnValues, pk, pkValue, "public");

        } else {
            try {
                new_configuration.setDesignationid(designationid);
                new_configuration.setFacilitylevelid(facilitylevelid);
                new_configuration.setRequiredstaff(requiredStaff);
                new_configuration.setDatecreated(examDate);
                new_configuration.setAddedby(BigInteger.valueOf(currStaffid));
                new_configuration = (Facilitylevelconfigrations) genericClassService.saveOrUpdateRecordLoadObject(new_configuration);

            } catch (Exception ex) {
                System.out.println(ex);
            }
        }
        return "refresh";
    }

    @RequestMapping(value = "/deletedesignationconfig.htm", method = RequestMethod.POST)
    public @ResponseBody
    String deletedesignationconfig(HttpServletRequest request) {
        String results = "";

        List<Integer[]> object = (List<Integer[]>) genericClassService.fetchRecord(Facilitylevelconfigrations.class, new String[]{"facilitylevelconfigrationsid"}, " WHERE designationid=:designationid AND facilitylevelid=:facilitylevelid", new String[]{"designationid", "facilitylevelid"}, new Object[]{Integer.parseInt(request.getParameter("designationid")), Integer.parseInt(request.getParameter("facilitylevelid"))});
        if (object != null) {
            results = String.valueOf(object.size());
        } else {
            String[] columns = {"designationid", "facilitylevelid"};
            Object[] columnValues = {Integer.parseInt(request.getParameter("designationid")), Integer.parseInt(request.getParameter("facilitylevelid"))};
            int result = genericClassService.deleteRecordByByColumns("facilitylevelconfigrations", columns, columnValues);
            if (result != 0) {
                results = "success";
            }
        }
        return results;
    }

    @RequestMapping(value = "/deleteduty.htm", method = RequestMethod.POST)
    public @ResponseBody
    String deleteduty(HttpServletRequest request) {
        String results = "";

        String[] columns = {"designationid", "dutyid"};
        Object[] columnValues = {Integer.parseInt(request.getParameter("designationid")), Integer.parseInt(request.getParameter("dutyid"))};
        int result = genericClassService.deleteRecordByByColumns("dutiesandresponsibilities", columns, columnValues);
        if (result != 0) {
            results = "success";
        }

        return results;
    }

    @RequestMapping(value = "/updateDesignationConfiguration", method = RequestMethod.GET)
    public String updateDesignationConfiguration(HttpServletRequest request, Model model) {
        int requiredStaff = Integer.parseInt(request.getParameter("requiredstaff"));
        int designationid = Integer.parseInt(request.getParameter("designationid"));
        int facilitylevelid = Integer.parseInt(request.getParameter("facilitylevelid"));
        long currStaffid = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");

        String[] params = {"designationid", "facilitylevelid"};
        Object[] paramsValues = {designationid, facilitylevelid};
        String[] fields = {"facilitylevelconfigrationid"};
        List<Integer> configuration = (List<Integer>) genericClassService.fetchRecord(Facilitylevelconfigrations.class, fields, "WHERE designationid=:designationid AND facilitylevelid=:facilitylevelid", params, paramsValues);
        if (configuration != null) {

            String[] columns = {"requiredstaff", "dateupdated", "updatedby"};
            Object[] columnValues = {requiredStaff, new Date(), BigInteger.valueOf(currStaffid)};
            String pk = "facilitylevelconfigrationid";
            Object pkValue = configuration.get(0);
            int result = genericClassService.updateRecordSQLSchemaStyle(Facilitylevelconfigrations.class, columns, columnValues, pk, pkValue, "public");

        }
        return "refresh";
    }

    @RequestMapping(value = "/updateDuty", method = RequestMethod.GET)
    public String updateDuty(HttpServletRequest request, Model model) {
        String duty = request.getParameter("duty");
//       int designationid = Integer.parseInt(request.getParameter("designationid"));
        int dutyid = Integer.parseInt(request.getParameter("dutyid"));
        long currStaffid = (Long) request.getSession().getAttribute("sessionActiveLoginStaffid");

        String[] columns = {"duty", "dateupdated", "updatedby"};
        Object[] columnValues = {duty, new Date(), BigInteger.valueOf(currStaffid)};
        String pk = "dutyid";
        Object pkValue = dutyid;
        int result = genericClassService.updateRecordSQLSchemaStyle(Dutiesandresponsibilities.class, columns, columnValues, pk, pkValue, "public");

//        }
        return "refresh";
    }

    @RequestMapping(value = "/viewposts", method = RequestMethod.POST)
    public @ResponseBody
    String viewPosts(HttpServletRequest request, Model model, @ModelAttribute("designationcategoryid") int designationcategoryid) throws JsonProcessingException {
        //Fetching Designations

        List<Designation> post = new ArrayList<>();

        String[] paramszr = {"designationcategoryid"};
        Object[] paramsValueszr = {designationcategoryid};
        String[] fieldszr = {"designationid", "designationcategoryid", "designationname", "shortname", "description", "status"};
        String wherezr = "WHERE designationcategoryid=:designationcategoryid";
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
                post.add(dpost);
            }
            model.addAttribute("designationpost", post);
        }

        return new ObjectMapper().writeValueAsString(post);
    }

    @RequestMapping(value = "/maindesignation", method = RequestMethod.GET)
    public final ModelAndView mainDesignation(HttpServletRequest request) {
        Map<String, Object> model = new HashMap<String, Object>();

        return new ModelAndView("controlPanel/universalPanel/postsAndactivities/views/designations", "model", model);
    }

    @RequestMapping(value = "/desigantiontable", method = RequestMethod.GET)
    public final ModelAndView desigantionTable(HttpServletRequest request) {
        Map<String, Object> model = new HashMap<String, Object>();

        List<Designation> post = new ArrayList<>();

        String[] paramszrx = {};
        Object[] paramsValueszrx = {};
        String[] fieldszrx = {"designationid", "designationcategoryid", "designationname", "shortname", "description", "status"};
        String wherezrx = "";
        List<Object[]> posts = (List<Object[]>) genericClassService.fetchRecord(Designation.class, fieldszrx, wherezrx, paramszrx, paramsValueszrx);
        if (posts != null) {
            for (Object[] dp : posts) {
                Designation dpost = new Designation();
                dpost.setDesignationid((Integer) dp[0]);
                dpost.setDesignationcategoryid((Integer) dp[1]);
                dpost.setDesignationname((String) dp[2]);
                dpost.setShortname((String) dp[3]);
                dpost.setDescription((String) dp[4]);
                dpost.setStatus((Boolean) dp[5]);
                post.add(dpost);
            }
            model.put("designationpost", post);
        }
        return new ModelAndView("controlPanel/universalPanel/postsAndactivities/views/designationstable", "model", model);

    }

    @RequestMapping(value = "/viewde", method = RequestMethod.GET)
    public String viewDe(HttpServletRequest request, Model model, @ModelAttribute("facilitydomainid") int facilitydomainid) {

        Designationcategory desigsearchs = new Designationcategory();

        String[] params = {"facilitydomainid"};
        Object[] paramsValues = {facilitydomainid};
        String[] fields = {"facilitydomainid", "categoryname"};
        String where = "WHERE facilitydomainid=:facilitydomainid";

        List<Object[]> design = (List<Object[]>) genericClassService.fetchRecord(Designationcategory.class, fields, where, params, paramsValues);
        if (design != null && design.size() > 0) {
            desigsearchs.setFacilitydomainid((Integer) design.get(0)[0]);
            desigsearchs.setCategoryname((String) design.get(0)[1]);
            model.addAttribute("bios", desigsearchs);
        }
        return "controlPanel/universalPanel/postsAndactivities/form/updatepost";
    }

    @RequestMapping(value = "/trials", method = RequestMethod.GET)
    public String trials(HttpServletRequest request, Model model, @ModelAttribute("facilitydomainid") int facilitydomainid) {

        Designationcategory desigsearchs = new Designationcategory();

        String[] params = {"facilitydomainid"};
        Object[] paramsValues = {facilitydomainid};
        String[] fields = {"facilitydomainid", "categoryname"};
        String where = "WHERE facilitydomainid=:facilitydomainid";

        List<Object[]> design = (List<Object[]>) genericClassService.fetchRecord(Designationcategory.class, fields, where, params, paramsValues);
        if (design != null && design.size() > 0) {
            desigsearchs.setFacilitydomainid((Integer) design.get(0)[0]);
            desigsearchs.setCategoryname((String) design.get(0)[1]);
            model.addAttribute("bios", desigsearchs);
        }
        return "controlPanel/universalPanel/postsAndactivities/form/adddesignation";
    }

    @RequestMapping(value = "/searchdesignation", method = RequestMethod.GET)
    public ModelAndView searchDesignation(HttpServletRequest request, @ModelAttribute("designationcategoryid") String dcId) {
        Map<String, Object> model = new HashMap<String, Object>();

        List<Designationcategory> DesignationList = new ArrayList<>();
        String[] paramsfacilitydesig = {};
        Object[] paramsValuesfacilitydesig = {};
        String[] fieldsfacilitydesig = {"designationcategoryid", "categoryname", "facilitydomainid"};
        String wherefacilitydesig = "";
        List<Object[]> facilityDesignation = (List<Object[]>) genericClassService.fetchRecord(Designationcategory.class, fieldsfacilitydesig, wherefacilitydesig, paramsfacilitydesig, paramsValuesfacilitydesig);
        Designationcategory fDomain;
        if (facilityDesignation != null) {
            for (Object[] domn : facilityDesignation) {
                fDomain = new Designationcategory();
                fDomain.setDesignationcategoryid((Integer) domn[0]);
                fDomain.setCategoryname((String) domn[1]);
                fDomain.setFacilitydomainid((Integer) domn[2]);
                DesignationList.add(fDomain);
            }
            model.put("DesignationList", DesignationList);

        }

        int designationcategoryid = Integer.parseInt(dcId.trim());
        System.out.println("===============================================" + designationcategoryid);

        return new ModelAndView("controlPanel/universalPanel/postsAndactivities/views/searchdesignations", "model", model);
    }

    @RequestMapping(value = "/saveDesignations.htm", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView saveDesignations(HttpServletRequest request) {
        Map<String, Object> model = new HashMap<String, Object>();

        try {
            //saving designation
            Designationcategory dcategory = new Designationcategory();

            String categoryname = request.getParameter("categoryname");
            String facilitydomainid = request.getParameter("facilitydomainid");
            String description = request.getParameter("description");

            dcategory.setCategoryname(categoryname);
            dcategory.setFacilitydomainid(Integer.parseInt(facilitydomainid));
            dcategory.setDescription(description);
            dcategory.setUniversaldeletestatus("NOTDELETED");
            dcategory.setDeletestatus("NOTDELETED");
            dcategory.setDisabled(true);

            Object save = genericClassService.saveOrUpdateRecordLoadObject(dcategory);

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return new ModelAndView("controlPanel/universalPanel/postsAndactivities/views/designations", "model", model);

    }

    @RequestMapping(value = "/saveUpdateDesignations.htm")
    public @ResponseBody
    String saveUpdateDesignations(HttpServletRequest request) {

        try {

            String categoryname = request.getParameter("categoryname");
            String description = request.getParameter("description");
            int facilitydomainid = Integer.parseInt(request.getParameter("facilitydomainid"));
            int designationcategoryid = Integer.parseInt(request.getParameter("designationcategoryid"));

            String[] columns = {"facilitydomainid", "categoryname", "description", "designationcategoryid"};
            Object[] columnValues = {facilitydomainid, categoryname, description, designationcategoryid};
            String pk = "designationcategoryid";
            Object pkValue = designationcategoryid;
            genericClassService.updateRecordSQLSchemaStyle(Designationcategory.class, columns, columnValues, pk, pkValue, "public");
            return "";

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "/savePosts.htm", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView savePosts(HttpServletRequest request) {
        Map<String, Object> model = new HashMap<String, Object>();

        try {
            //saving posts
            Designation post = new Designation();

            String designationname = request.getParameter("designationname");
            String designationcategoryid = request.getParameter("designationcategoryid");
            String description = request.getParameter("description");

            post.setDesignationname(designationname);
            post.setDesignationcategoryid(Integer.parseInt(designationcategoryid));
            post.setDescription(description);
            post.setUniversaltransferstatus("ASSIGNED");
            post.setTransferstatus("ALLOCATED");

            Object save = genericClassService.saveOrUpdateRecordLoadObject(post);

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return new ModelAndView("controlPanel/universalPanel/postsAndactivities/views/designations", "model", model);

    }

    @RequestMapping(value = "/saveUpdatePosts.htm")
    public @ResponseBody
    String saveUpdatePosts(Model model, HttpServletRequest request) {

        String designationname = request.getParameter("designationname");
        String description = request.getParameter("description");
        int designationid = Integer.parseInt(request.getParameter("designationid"));
        int designationcategoryid = Integer.parseInt(request.getParameter("designationcategoryid"));

        String[] columns = {"designationid", "designationname", "description", "designationcategoryid"};
        Object[] columnValues = {designationid, designationname, description, designationcategoryid};
        String pk = "designationid";
        Object pkValue = designationid;
        genericClassService.updateRecordSQLSchemaStyle(Designation.class, columns, columnValues, pk, pkValue, "public");
        return "";
    }

    @RequestMapping(value = "/deleteDesignationCategory")
    public @ResponseBody
    String deleteDesignationcategory(HttpServletRequest request, Model model) {
        String results = "";

        List<Integer[]> object = (List<Integer[]>) genericClassService.fetchRecord(Designation.class, new String[]{"designationid"}, " WHERE r.designationcategoryid=:designationcategoryid", new String[]{"designationcategoryid"}, new Object[]{Integer.parseInt(request.getParameter("designationcategoryid"))});
        if (object != null) {
            results = String.valueOf(object.size());
        } else {
            String[] columns = {"designationcategoryid"};
            Object[] columnValues = {Integer.parseInt(request.getParameter("designationcategoryid"))};
            int result = genericClassService.deleteRecordByByColumns("designationcategory", columns, columnValues);
            if (result != 0) {
                results = "success";
            }
        }

        return results;
    }

    @RequestMapping(value = "/deleteDesignation")
    public @ResponseBody
    String deleteDesignation(HttpServletRequest request, Model model) {
        String results = "";
        List<Integer[]> object = (List<Integer[]>) genericClassService.fetchRecord(Searchstaff.class, new String[]{"staffid"}, " WHERE r.designationid=:designationid", new String[]{"designationid"}, new Object[]{Integer.parseInt(request.getParameter("designationid"))});
        if (object != null) {
            results = String.valueOf(object.size());
        } else {
            String[] columns = {"designationid"};
            Object[] columnValues = {Integer.parseInt(request.getParameter("designationid"))};
            int result = genericClassService.deleteRecordByByColumns("designation", columns, columnValues);
            if (result != 0) {
                results = "success";
            }
        }

//             String[] columns = {"designationid"};
//               Object[] columnValues = {Integer.parseInt(request.getParameter("designationid"))};
//               int result = genericClassService.deleteRecordByByColumns("designation", columns, columnValues);
//               if (result != 0) {
//                   results = "success";
//               }
        return results;
    }

//    @RequestMapping("/manageDesigCatDiscard")
//    @SuppressWarnings("CallToThreadDumpStack")
//    public String manageDesigCatDiscard(HttpServletRequest request, Model model) {
//
//        try {
//            int designationcategoryid = Integer.parseInt(request.getParameter("id"));
//
//            String[] params = {"designationcategoryid"};
//            Object[] paramValues = {designationcategoryid};
//            String[] regionFields = {"designationcategoryid", "categoryname"};
//            List<Object[]> desigcategoryArrList = (List<Object[]>) genericClassService.fetchRecord(Designationcategory.class, regionFields, " WHERE r.designationcategoryid!=:designationcategoryid", params, paramValues);
//            if (desigcategoryArrList != null) {
//                model.addAttribute("designationcategoryArrList", desigcategoryArrList);
//            }
//            String[] fields = {"designationid", "designationname", "designationcategoryid.categoryname"};
//            List<Object[]> designationArrList = (List<Object[]>) genericClassService.fetchRecord(Designation.class, fields, "WHERE r.designationcategoryid=:Id ORDER BY r.designationname ASC", new String[]{"Id"}, new Object[]{designationcategoryid});
//            model.addAttribute("designationsList", designationArrList);
//            if (designationArrList != null) {
//                model.addAttribute("size", designationArrList.size());
//            }
//
//            return "controlPanel/universalPanel/postsAndactivities/form/transferDesigAttachment";
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        model.addAttribute("success", "<span class='text6'>Contact System Administrator :: Page Not Found!</span>");
//        return "response";
//    }
    @RequestMapping("/deletedesignationcategorylist")
    public String deletedesignationcategorylist(HttpServletRequest request, Model model) throws JsonProcessingException {
        List<Designationcategory> category = new ArrayList<>();

        List<Designationcategory> DesignationList = new ArrayList<>();
        String[] paramsfacilitydesig = {"designationcategoryid"};
        Object[] paramsValuesfacilitydesig = {Integer.parseInt(request.getParameter("designationcategoryid"))};
        String[] fieldsfacilitydesig = {"designationcategoryid", "categoryname"};
        List<Object[]> facilityDesignation = (List<Object[]>) genericClassService.fetchRecord(Designationcategory.class, fieldsfacilitydesig, " WHERE r.designationcategoryid !=:designationcategoryid", paramsfacilitydesig, paramsValuesfacilitydesig);
        Designationcategory fDomain;
        if (facilityDesignation != null) {
            for (Object[] domn : facilityDesignation) {
                fDomain = new Designationcategory();
                fDomain.setDesignationcategoryid((Integer) domn[0]);
                fDomain.setCategoryname((String) domn[1]);
                DesignationList.add(fDomain);
            }
            model.addAttribute("DesignationLists", DesignationList);

        }

        List<Map> desigcategoryz = new ArrayList<>();
        String[] params = {"designationcategoryid"};
        Object[] paramValues = {Integer.parseInt(request.getParameter("designationcategoryid"))};
        String[] regionFields = {"designationid", "designationname"};
        List<Object[]> desigcategoryArrList = (List<Object[]>) genericClassService.fetchRecord(Designation.class, regionFields, " WHERE r.designationcategoryid =:designationcategoryid", params, paramValues);
        if (desigcategoryArrList != null) {
            Map<String, Object> desigcategoryRow;
            for (Object[] desigcategoryArr : desigcategoryArrList) {
                desigcategoryRow = new HashMap<>();
                desigcategoryRow.put("designationid", desigcategoryArr[0]);
                desigcategoryRow.put("designationname", desigcategoryArr[1]);
                desigcategoryz.add(desigcategoryRow);
            }
        }
        model.addAttribute("desigcategory", desigcategoryz);

        model.addAttribute("jsondesignations", new ObjectMapper().writeValueAsString(desigcategoryz));
        return "controlPanel/universalPanel/postsAndactivities/form/discardDesigCat";
    }

    @RequestMapping(value = "/transferdesignations", method = RequestMethod.POST)
    public @ResponseBody
    String TransferDesignations(HttpServletRequest request, @ModelAttribute("designationsvalues") String designationtransferall, @ModelAttribute("designationcatid") int designationcategoryid) {
        String results = "";
        try {
            ObjectMapper mapper = new ObjectMapper();
//            List<Map> transferdesigs = (ArrayList<Map>) mapper.readValue(designationtransferall, List.class);
            List<String> transferdesigs = (ArrayList<String>) mapper.readValue(designationtransferall, List.class);

            for (String x : transferdesigs) {

                int designationid = Integer.parseInt(x);

                String[] columnslev = {"designationcategoryid"};
                Object[] columnValueslev = {designationcategoryid};
                String levelPrimaryKey = "designationid";
                Object levelPkValue = designationid;

                String[] columnslevS = {"designationcategoryid"};
                Object[] columnValueslevS = {designationcategoryid};
//                String levelPrimaryKeyS = "systemroleid";
//                Object levelPkValueS = Long.parseLong(request.getParameter("systemroleid"));
                Object updatelimit = genericClassService.updateRecordSQLSchemaStyle(Designation.class, columnslev, columnValueslev, levelPrimaryKey, levelPkValue, "public");
//                Object updatedlimit = genericClassService.updateRecordSQLSchemaStyle(Systemrole.class, columnslevS, columnValueslevS, levelPrimaryKeyS, levelPkValueS, "public");

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

    @RequestMapping(value = "/checkdesignationcategoryname.htm")
    public @ResponseBody
    String checkDesignationCategoryName(HttpServletRequest request) {
        int facilitydomainid = Integer.parseInt(request.getParameter("facilitydomainid"));
        String results = "";

        String[] params = {"facilitydomainid", "value"};
        Object[] paramsValues = {facilitydomainid, request.getParameter("categoryname").trim().toLowerCase()};
        String[] fields = {"categoryname"};
        String where = "WHERE facilitydomainid=:facilitydomainid AND  (LOWER(categoryname) =:value) ORDER BY categoryname";
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
    String checkdesignationname(HttpServletRequest request) throws IOException {
//        int designationcategoryid = Integer.parseInt(request.getParameter("designationcategoryid"));
        String results = "";
        Map<String, Object> data = new HashMap<>();
//        String[] params = {"designationcategoryid", "value"};
        String[] params = {"value"};
//        Object[] paramsValues = {designationid, request.getParameter("designationname").trim().toLowerCase()};
        Object[] paramsValues = {request.getParameter("designationname").trim().toLowerCase()};
        String[] fields = {"designationname", "designationcategoryid"};
        //String where = "WHERE designationcategoryid=:designationcategoryid AND  (LOWER(designationname) =:value) ORDER BY designationname";
        String where = "WHERE LOWER(TRIM(designationname))=:value ORDER BY designationname";

        List<Object[]> classficationList = (List<Object[]>) genericClassService.fetchRecord(Designation.class, fields, where, params, paramsValues);
        if (classficationList != null) {

            String[] params1 = {"designationcategoryid"};
            Object[] paramsValues1 = {Integer.parseInt(classficationList.get(0)[1].toString())};
            String[] fields1 = {"categoryname"};
            String where1 = "WHERE designationcategoryid=:designationcategoryid";
            List<Object> categories = (List<Object>) genericClassService.fetchRecord(Designationcategory.class, fields1, where1, params1, paramsValues1);
            if (categories != null) {
                data.put("category", categories.get(0));
            } else {
                data.put("category", "");
            }
            data.put("error", "existing");
//         ccc   results = "existing";
        } else {
            data.put("error", "notexisting");
            data.put("category", "");
//            results = "notexisting";
        }
        results = new ObjectMapper().writeValueAsString(data);
        return results;
    }

    @RequestMapping(value = "/getStaffToTransfer.htm", method = RequestMethod.GET)
    public String getStaffToTransfer(Model model, HttpServletRequest request) {

        List<Map> stafflists = new ArrayList<>();
        List<Map> facilityunits = new ArrayList<>();
        String facilityidsession = request.getSession().getAttribute("sessionActiveLoginFacility").toString();

        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            Integer facilityUnit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
            String[] params = {"facilityunitid", "active"};
            Object[] paramsValues = {facilityUnit, true};
            String[] fields = {"staffid"};
            String where = "WHERE facilityunitid=:facilityunitid AND active=:active";
            List<Long> staff = (List<Long>) genericClassService.fetchRecord(Stafffacilityunit.class, fields, where, params, paramsValues);
            if (staff != null) {
                Map<String, Object> userrow;
                for (Long staffid : staff) {
                    userrow = new HashMap<>();
                    String[] params2 = {"staffid"};
                    Object[] paramsValues2 = {BigInteger.valueOf(staffid)};
                    String[] fields2 = {"staffid", "staffno", "firstname", "lastname", "personid", "othernames", "designationname"};
                    String where2 = "WHERE staffid=:staffid";
                    List<Object[]> staffDetails = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields2, where2, params2, paramsValues2);
                    if (staffDetails != null) {
                        userrow.put("staffid", (BigInteger) staffDetails.get(0)[0]);
                        userrow.put("staffno", (String) staffDetails.get(0)[1]);
                        userrow.put("firstname", (String) staffDetails.get(0)[2]);
                        userrow.put("lastname", (String) staffDetails.get(0)[3]);
                        userrow.put("personid", (BigInteger) staffDetails.get(0)[4]);
                        userrow.put("othernames", (String) staffDetails.get(0)[5]);
                        userrow.put("designationname", (String) staffDetails.get(0)[6]);
                    }
                    stafflists.add(userrow);
                }
            }
        }
        model.addAttribute("stafflists", stafflists);
        model.addAttribute("facilityunits", facilityunits);
        return "controlPanel/universalPanel/postsAndactivities/form/transferStaff";

    }

    @RequestMapping(value = "/transferStaffD", method = RequestMethod.POST)
    public @ResponseBody
    String transferStaffD(HttpServletRequest request, @ModelAttribute("staffsvalues") String stafftransferall, @ModelAttribute("designid") int designationid) {
        String results = "";
        try {
            ObjectMapper mapper = new ObjectMapper();
            List<Map> transferstaffs = (ArrayList<Map>) mapper.readValue(stafftransferall, List.class);

            for (Map x : transferstaffs) {
                String firstname = String.valueOf(x.get("firstname"));
                String lastname = String.valueOf(x.get("lastname"));
                int staffid = (int) x.get("staffid");

                String[] columnslev = {"designationid"};
                Object[] columnValueslev = {designationid};
                String levelPrimaryKey = "staffid";
                Object levelPkValue = staffid;

                String[] columnslevS = {"designationid"};
                Object[] columnValueslevS = {designationid};
//                String levelPrimaryKeyS = "systemroleid";
//                Object levelPkValueS = Long.parseLong(request.getParameter("systemroleid"));
                Object updatelimit = genericClassService.updateRecordSQLSchemaStyle(Searchstaff.class, columnslev, columnValueslev, levelPrimaryKey, levelPkValue, "public");
//                Object updatedlimit = genericClassService.updateRecordSQLSchemaStyle(Systemrole.class, columnslevS, columnValueslevS, levelPrimaryKeyS, levelPkValueS, "public");

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

    @RequestMapping(value = "/postshifting", method = RequestMethod.GET)
    public @ResponseBody
    String shiftpost(HttpServletRequest request, Model model) {
        try {
            int designationid = Integer.parseInt(request.getParameter("designationid"));
            int designationcategoryid = Integer.parseInt(request.getParameter("designationcategoryid"));

            String[] columns = {"designationcategoryid"};
            Object[] columnValues = {designationcategoryid};
            String pk = "designationid";
            Object pkValue = designationid;
            genericClassService.updateRecordSQLSchemaStyle(Designation.class, columns, columnValues, pk, pkValue, "public");

        } catch (Exception e) {
            System.out.println(e);
        }
        return "";
    }

    private static String capitalize_first_leter(String str) {
        StringBuilder result = new StringBuilder();
        String words[] = str.split("\\ ");
        for (int i = 0; i < words.length; i++) {
            if (words[i].length() != 0) {
                result.append(Character.toUpperCase(words[i].charAt(0))).append(words[i].substring(1).toLowerCase()).append(" ");
                if (words[i].contains("(")) {
                    for (int r = 0; (r < result.length() && (r + 1 < result.length())); r++) {
                        if (result.charAt(r) == '(') {
                            result.replace((r + 1), (r + 2), String.valueOf(Character.toUpperCase(result.charAt((r + 1)))));
                        }
                    }
                }
            }
        }

        return result.toString();
    }

    private static String capitalize(String str) {
        StringBuilder result = new StringBuilder(str.length());
        String words[] = str.split("\\ ");
        return str.toUpperCase();
    }

        @RequestMapping(value = "/searchInposts", method = RequestMethod.GET)
  
      public @ResponseBody
    String searchInposts(HttpServletRequest request) throws IOException {
        String results1 = "";
        Map<String, Object> data = new HashMap<>();
        String[] params = {"designationname"};
        Object[] paramsValues = {request.getParameter("designationname").trim().toLowerCase()};
        String[] fields = {"designationname", "designationcategoryid"};
        String where = "WHERE LOWER(TRIM(designationname))=:designationname";

        List<Object[]> classficationList1 = (List<Object[]>) genericClassService.fetchRecord(Designation.class, fields, where, params, paramsValues);
        if (classficationList1 != null) {

            String[] params2 = {"designationcategoryid"};
            Object[] paramsValues2 = {Integer.parseInt(classficationList1.get(0)[1].toString())};
            String[] fields2 = {"categoryname"};
            String where2 = "WHERE designationcategoryid=:designationcategoryid";
            List<Object> categories1 = (List<Object>) genericClassService.fetchRecord(Designationcategory.class, fields2, where2, params2, paramsValues2);
            if (categories1 != null) {
                data.put("category", categories1.get(0));
            } else {
                data.put("category", "");
            }
            data.put("error", "existing");
        } else {
            data.put("error", "notexisting");
            data.put("category", "");
        }
        results1 = new ObjectMapper().writeValueAsString(data);
        return results1;
    }
    
   
    

    @RequestMapping(value = "/searchInpostspane", method = RequestMethod.GET)
    public String seanposts(HttpServletRequest request, Model model) throws IOException {
        
        return "controlPanel/universalPanel/postsAndactivities/form/searchposts";

    }

}
