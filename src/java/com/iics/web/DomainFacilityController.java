/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.iics.domain.*;
import com.iics.domain.Location;
import com.iics.service.GenericClassService;
import java.security.Principal;
import java.text.BreakIterator;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
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
 * @author samuelwam
 */
@Controller
public class DomainFacilityController {
    
    public static String sys_info = null;
    protected static Log logger = LogFactory.getLog("controller");
    @Autowired
    GenericClassService genericClassService;
    
    /**
     *
     * @param principal
     * @return
     */
    @RequestMapping("/domainFacSetting.htm")
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView domainFacSetting(Principal principal, HttpServletRequest request,
            @RequestParam("act") String activity, @RequestParam("i") long id, @RequestParam("d") long id2,
            @RequestParam("b") String strVal, @RequestParam("c") String strVal2,
            @RequestParam("ofst") int offset, @RequestParam("maxR") int maxResults,
            @RequestParam("sStr") String searchPhrase) {
        if (principal == null) {
            return new ModelAndView("refresh");
        }
        Map<String, Object> model = new HashMap<String, Object>();
        model.put("onErrorReturnURL", "ajaxSubmitData('domainFacSetting.htm', 'myTabContent', 'act=a&i=0&b=a&c=" + strVal2 + "&d=0&ofst=1&maxR=100&sStr=', 'GET');");
        try {
            model.put("act", activity);
            model.put("b", strVal);
            model.put("i", id);
            model.put("c", strVal2);
            model.put("d", id2);
            model.put("ofst", offset);
            model.put("maxR", maxResults);
            model.put("sStr", searchPhrase);

            request.getSession().setAttribute("sessPagingOffSet", offset);
            request.getSession().setAttribute("sessPagingMaxResults", maxResults);
            request.getSession().setAttribute("vsearch", searchPhrase);

            String[] fields = {"organisationid", "organisationname", "organisationcode", "description", "active", "dateadded", "person1.personname", "hasbranch", "hasdepts", "phonecontact", "emailaddress", "website"};

            List<Facility> facList = new ArrayList<Facility>();
            List<Object[]> facListArr = new ArrayList<Object[]>();
            
            if (activity.equals("a")) {
                request.getSession().setAttribute("sessTabActivity", activity);
                String[] params2 = {};
                Object[] paramsValues2 = {};
                String[] levelFields = {"facilitylevelid", "facilitylevelname", "shortname", "facilitydomain"};
                String phrase="health";
                List<Object[]> levelListArr = (List<Object[]>) genericClassService.fetchRecord(Facilitylevel.class, levelFields, "WHERE r.facilitydomain IN (SELECT d.facilitydomainid FROM Facilitydomain d WHERE LOWER(d.domainname) LIKE '" + phrase + "%') ORDER BY r.facilitylevelname ASC", params2, paramsValues2);
                int levelid=Integer.parseInt(id2+"");
                int domainId=0;
                if (levelListArr != null) {
                    logger.info("levelListArr ::::::::: "+levelListArr.size());
                    model.put("levelSize", levelListArr.size());
                    if(levelid==0){
                        levelid=(Integer) levelListArr.get(0)[0];
                        domainId=(Integer) levelListArr.get(0)[3];
                    }
                }          
                
                Facilitydomain domain = new Facilitydomain(domainId);
                String[] domainPar = {"dId"};
                Object[] domainparVals = {domainId};
                List<Object[]> domainObjArr = (List<Object[]>) genericClassService.fetchRecord(Facilitydomain.class, new String[]{"facilitydomainid","domainname"}, "WHERE r.facilitydomainid=:dId", domainPar, domainparVals);
//                logger.info("domainObjArr :::::: "+domainObjArr);
                if (domainObjArr != null) {
                    for (Object[] obj : domainObjArr) {
                        domain.setDomainname((String) obj[1]);
                    }
                }
                model.put("levels", levelListArr);
                model.put("domainRef", domain);
                
                String[] ownerFields = {"facilityownerid", "ownername"};
                List<Object[]> ownerListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityowner.class, ownerFields, "ORDER BY r.ownername ASC", new String[]{}, new Object[]{});
                if (ownerListArr != null) {
                    model.put("ownerListArr", ownerListArr);
                }
                
                model.put("facilityType", "Organisation Set Up");
                return new ModelAndView("controlPanel/universalPanel/facility/FacilityRegistration/forms/setUpFacility", "model", model);
            }
            if (activity.equals("a2")) {
                request.getSession().setAttribute("sessTabActivity", activity);
                if (strVal.equals("a")) {
                    Facilitydomain domain = new Facilitydomain();
                    String phrase = "health";
                    String[] domainPar = {};
                    Object[] domainparVals = {};
                    List<Object[]> domainObjArr = (List<Object[]>) genericClassService.fetchRecord(Facilitydomain.class, new String[]{"facilitydomainid", "domainname"}, "WHERE LOWER(r.domainname) LIKE '" + phrase + "%'", domainPar, domainparVals);
//                logger.info("domainObjArr :::::: "+domainObjArr);
                    if (domainObjArr != null) {
                        for (Object[] obj : domainObjArr) {
                            domain.setFacilitydomainid((Integer) obj[0]);
                            domain.setDomainname((String) obj[1]);
                        }
                    }
                    model.put("domainRef", domain);
                    model.put("facilityType", "Facility Search");
                    return new ModelAndView("controlPanel/universalPanel/facility/FacilityRegistration/forms/searchMain", "model", model);
                }
                if (strVal.equals("b")) {
                    Facilitydomain domain = new Facilitydomain();
                    String[] domainPar = {"Id"};
                    Object[] domainparVals = {id};
                    List<Object[]> domainObjArr = (List<Object[]>) genericClassService.fetchRecord(Facilitydomain.class, new String[]{"facilitydomainid", "domainname"}, "WHERE r.facilitydomainid=:Id", domainPar, domainparVals);
//                logger.info("domainObjArr :::::: "+domainObjArr);
                    if (domainObjArr != null) {
                        for (Object[] obj : domainObjArr) {
                            domain.setFacilitydomainid((Integer) obj[0]);
                            domain.setDomainname((String) obj[1]);
                        }
                    }
                    
                    int countFacilitySet = genericClassService.fetchRecordCount(Facility.class, "WHERE r.facilitylevelid.facilitydomain=:Id2", new String[]{"Id2"}, new Object[]{id});
                    List<Facilitylevel> facLvlList = new ArrayList<Facilitylevel>();
                    List<Object[]> levelFacListArr = (List<Object[]>) genericClassService.fetchRecord(Facilitylevel.class, new String[]{"facilitylevelid", "facilitylevelname"}, "WHERE r.facilitydomain=:Id2 ORDER BY r.facilitylevelname ASC", new String[]{"Id2"}, new Object[]{domain.getFacilitydomainid()});
                    if (levelFacListArr != null) {
                        for (Object[] obj : levelFacListArr) {
                            Facilitylevel fl = new Facilitylevel((Integer) obj[0]);
                            fl.setFacilitylevelname((String) obj[1]);
                            int countLvlFacSet = genericClassService.fetchRecordCount(Facility.class, "WHERE r.facilitylevelid.facilitylevelid=:Id", new String[]{"Id"}, new Object[]{fl.getFacilitylevelid()});
                            fl.setCount(countLvlFacSet);
                            facLvlList.add(fl);
                        }
                    }
                    model.put("domainRef", domain);
                    model.put("count", countFacilitySet);
                    model.put("facLvlList", facLvlList);
                    model.put("facilityType", "Facility Search");
                    return new ModelAndView("controlPanel/universalPanel/facility/FacilityRegistration/forms/searchSummary", "model", model);
                }
                
            }
            if (activity.equals("a3")) {
                long addedby=2;
                //Temporary Code To Update Facility Table With Village ID Using Existing Data In Location
                List<Object[]> facLocationListArr = (List<Object[]>) genericClassService.fetchRecord(Location.class, new String[]{"facilityid.facilityid", "villageid.villageid"}, "WHERE r.facilityid.facilityid IN (SELECT f.facilityid.facilityid FROM Location f WHERE f.facilityid.village IS NULL)", new String[]{}, new Object[]{});
                if (facLocationListArr != null) {
                    for (Object[] obj : facLocationListArr) {
                        genericClassService.updateRecordSQLStyle(Facility.class, new String[]{"villageid", "addedby", "dateadded", "active"}, new Object[]{(Integer) obj[1], addedby, new Date(), false}, "facilityid", (Integer) obj[0]);
                    }
                }
                List<Object[]> searchListArr = (List<Object[]>) genericClassService.fetchRecord(Facility.class, new String[]{"facilityid"}, "WHERE r.village IS NULL", new String[]{}, new Object[]{});
                if (searchListArr != null) {
                    for (Object obj : searchListArr) {
                        genericClassService.updateRecordSQLStyle(Facility.class, new String[]{"addedby", "dateadded", "active"}, new Object[]{addedby, new Date(), false}, "facilityid", (Integer) obj);
                    }
                }
            }
            if (activity.equals("b")) {
                if(strVal.equals("a")){
                    int countFacilitySet = genericClassService.fetchRecordCount(Facility.class, "WHERE r.facilitylevelid.facilitydomain=:Id2", new String[]{"Id2"}, new Object[]{id});
                    model.put("count", countFacilitySet);
                    model.put("title", "In All Facility Levels");
                    request.getSession().setAttribute("SessionSearchFacilityAct", "All");
                    request.getSession().setAttribute("SessionSearchFacilityActVal", null);
                }
                if (strVal.equals("b")) {
                    int countFacilitySet = genericClassService.fetchRecordCount(Facility.class, "WHERE r.facilitylevelid.facilitylevelid=:Id", new String[]{"Id"}, new Object[]{id});
                    model.put("count", countFacilitySet);
                    
                    Facilitylevel flevel = new Facilitylevel();
                    List<Object[]> levelFacListArr = (List<Object[]>) genericClassService.fetchRecord(Facilitylevel.class, new String[]{"facilitylevelid", "facilitylevelname"}, "WHERE r.facilitylevelid=:Id", new String[]{"Id"}, new Object[]{id});
                    if (levelFacListArr != null) {
                        for (Object[] obj : levelFacListArr) {
                            flevel = new Facilitylevel((Integer) obj[0]);
                            flevel.setFacilitylevelname((String) obj[1]);
                        }
                    }
                    model.put("title", "Under "+flevel.getFacilitylevelname());
                    request.getSession().setAttribute("SessionSearchFacilityAct", "Level");
                    request.getSession().setAttribute("SessionSearchFacilityActVal", flevel);
                }
                return new ModelAndView("controlPanel/universalPanel/facility/FacilityRegistration/forms/searchFacility", "model", model);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        model.put("success", "<span class='text6'>Contact System Administrator :: Page Not Found!</span>");
        return new ModelAndView("response", "model", model);
    }
    
    /**
     *
     * @param principal
     * @return
     */
    @RequestMapping("/entityDescSetting.htm")
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView entityDescSetting(Principal principal, HttpServletRequest request,
            @RequestParam("act") String activity, @RequestParam("i") long id, @RequestParam("d") long id2,
            @RequestParam("b") String strVal, @RequestParam("c") String strVal2,
            @RequestParam("ofst") int offset, @RequestParam("maxR") int maxResults,
            @RequestParam("sStr") String searchPhrase) {
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
            model.put("ofst", offset);
            model.put("maxR", maxResults);
            model.put("sStr", searchPhrase);

//            long orgId = Long.parseLong(request.getSession().getAttribute("sessionActiveLoginOrg").toString());
            
            request.getSession().setAttribute("sessPagingOffSet", offset);
            request.getSession().setAttribute("sessPagingMaxResults", maxResults);
            request.getSession().setAttribute("vsearch", searchPhrase);

            String[] fields = {"descriptionid", "description", "active", "dateadded", "person.firstname", "person.lastname", "options"};

            List<Entitydescription> descList = new ArrayList<Entitydescription>();
            List<Object[]> descListArr = new ArrayList<Object[]>();
                        
            if (activity.equals("a")) {
                int levelid = Integer.parseInt(id2 + "");
                int domainId = 0;
                List<Object[]> levelListArr = new ArrayList<Object[]>();
                Facilitydomain domain = new Facilitydomain();
                Facilitylevel level = new Facilitylevel();
                String[] levelFields = {"facilitylevelid", "facilitylevelname", "shortname", "facilitydomain"};
                
                if (request.getSession().getAttribute("sessSetDescLevelSelected") == null) {
                    String[] params2 = {};
                    Object[] paramsValues2 = {};
                    
                    String phrase = "health";
                    levelListArr = (List<Object[]>) genericClassService.fetchRecord(Facilitylevel.class, levelFields, "WHERE r.facilitydomain IN (SELECT d.facilitydomainid FROM Facilitydomain d WHERE LOWER(d.domainname) LIKE '" + phrase + "%') ORDER BY r.facilitylevelname ASC", params2, paramsValues2);
                    if (levelListArr != null) {
                        logger.info("levelListArr ::::::::: " + levelListArr.size());
                        model.put("levelSize", levelListArr.size());
                        if (levelid == 0) {
                            levelid = (Integer) levelListArr.get(0)[0];
                            domainId = (Integer) levelListArr.get(0)[3];
                        }
                    }
                    request.getSession().setAttribute("sessSetDescLevelArrList", levelListArr);
                    
                    domain = new Facilitydomain(domainId);
                    String[] domainPar = {"dId"};
                    Object[] domainparVals = {domainId};
                    List<Object[]> domainObjArr = (List<Object[]>) genericClassService.fetchRecord(Facilitydomain.class, new String[]{"facilitydomainid","domainname"}, "WHERE r.facilitydomainid=:dId", domainPar, domainparVals);
    //                logger.info("domainObjArr :::::: "+domainObjArr);
                    if (domainObjArr != null) {
                        for (Object[] obj : domainObjArr) {
                            domain.setDomainname((String) obj[1]);
                        }
                    }
                    request.getSession().setAttribute("sessSetDescLevelDomainObj", domain);
                    
                    level = new Facilitylevel(levelid);
                    String[] params3 = {"lvlId"};
                    Object[] paramsValues3 = {levelid};
                    List<Object[]> levelObjArr = (List<Object[]>) genericClassService.fetchRecord(Facilitylevel.class, levelFields, "WHERE r.facilitylevelid=:lvlId", params3, paramsValues3);
    //                logger.info("levelObjArr :::::: "+levelObjArr);
                    if (levelObjArr != null) {
                        for (Object[] obj : levelObjArr) {
                            level.setFacilitylevelname((String) obj[1]);
                            level.setShortname((String) obj[2]);
                        }
                    }
                    request.getSession().setAttribute("sessSetDescLevelObj", level);
                }else {
                    if (levelid == 0) {
                        levelid = Integer.parseInt(request.getSession().getAttribute("sessSetDescLevelSelected").toString());
//                        level = (Facilitylevel) request.getSession().getAttribute("sessSetDescLevelObj");
                    }
                    level = new Facilitylevel(levelid);
                    String[] params3 = {"lvlId"};
                    Object[] paramsValues3 = {levelid};
                    List<Object[]> levelObjArr = (List<Object[]>) genericClassService.fetchRecord(Facilitylevel.class, levelFields, "WHERE r.facilitylevelid=:lvlId", params3, paramsValues3);
                    //                logger.info("levelObjArr :::::: "+levelObjArr);
                    if (levelObjArr != null) {
                        for (Object[] obj : levelObjArr) {
                            level.setFacilitylevelname((String) obj[1]);
                            level.setShortname((String) obj[2]);
                        }
                    }
                    levelListArr = (List<Object[]>) request.getSession().getAttribute("sessSetDescLevelArrList");
                    domain = (Facilitydomain) request.getSession().getAttribute("sessSetDescLevelDomainObj");
                }
                request.getSession().setAttribute("sessSetDescLevelSelected", levelid);
                                
                String[] params = {"Id2"};
                Object[] paramsValues = {levelid};
                if (maxResults == 0) {
                    descListArr = (List<Object[]>) genericClassService.fetchRecord(Entitydescription.class, fields, "WHERE r.facilitylevel.facilitylevelid=:Id2 ORDER BY r.description ASC", params, paramsValues);
                } else {
                    int countRecordSet = 0;
                    countRecordSet = genericClassService.fetchRecordCount(Entitydescription.class, "WHERE r.facilitylevel.facilitylevelid=:Id2", params, paramsValues);
                    offset = ((offset - 1) * maxResults) + 1;
                    model.put("offset2", offset);
                    if (offset > 0) {
                        offset -= 1;
                    }
                    if (countRecordSet > maxResults) {
                        model.put("paginate", true);
                        descListArr = (List<Object[]>) genericClassService.fetchRecordPaging(Entitydescription.class, fields, "WHERE r.facilitylevel.facilitylevelid=:Id2 ORDER BY r.description ASC", params, paramsValues, offset, maxResults);
                    } else {
                        model.put("paginate", false);
                        descListArr = (List<Object[]>) genericClassService.fetchRecord(Entitydescription.class, fields, "WHERE r.facilitylevel.facilitylevelid=:Id2 ORDER BY r.description ASC", params, paramsValues);
                    }
                    model.put("count", countRecordSet);
                    int totalPage = (countRecordSet + maxResults - 1) / maxResults;
                    model.put("totalPage", totalPage);
                }
                model.put("descListArr", descListArr);
                if (descListArr != null) {
                    for (Object[] obj : descListArr) {
                        Entitydescription desc = new Entitydescription((Integer) obj[0]);
                        desc.setDescription((String) obj[1]);
                        desc.setActive((Boolean) obj[2]);
                        desc.setDateadded((Date) obj[3]);
                        Person person = new Person();
                        person.setFirstname((String) obj[4]);
                        person.setLastname((String) obj[5]);
                        desc.setPerson(person);
                        int totalChildUnits = genericClassService.fetchRecordCount(Entityleveldescription.class, "WHERE r.entitydescription.descriptionid=:descId", new String[]{"descId"}, new Object[]{(Integer) obj[0]});
                        desc.setLevels(totalChildUnits);
                        String options=(String)obj[6];
                        if(options!=null && !options.isEmpty()){
                            options = options.replace("[","");
                            options = options.replace("]","");
                            options = options.replace(" ","");
                        }
                        desc.setOptions(options);
                        descList.add(desc);
                    }
                    model.put("size", descList.size());
                }
                model.put("descList", descList);
                
                model.put("levels", levelListArr);
                model.put("levelRef", level);
                model.put("domainRef", domain);

                model.put("facilityType", "Health Facility Set Up Descriptions");
                return new ModelAndView("controlPanel/universalPanel/facility/FacilityLevelSetting/EntityDesc/views/entityDescHome", "model", model);
            }
            if (activity.equals("b")) {
                int domainId=Integer.parseInt(id2+"");
                int levelid=Integer.parseInt(id+"");
                request.getSession().setAttribute("sessSetDescLevelSelected", levelid);
                String[] levelFields = {"facilitylevelid", "facilitylevelname", "shortname", "facilitydomain"};
//                
//                String[] params2 = {"domainId"};
//                Object[] paramsValues2 = {id2};
//                String[] levelFields = {"facilitylevelid", "facilitylevelname", "shortname", "facilitydomain"};
//                List<Object[]> levelListArr = (List<Object[]>) genericClassService.fetchRecord(Facilitylevel.class, levelFields, "WHERE r.facilitydomain=:domainId ORDER BY r.facilitylevelname ASC", params2, paramsValues2);
//                if (levelListArr != null) {
//                    logger.info("levelListArr ::::::::: "+levelListArr.size());
//                    model.put("levelSize", levelListArr.size());
//                }          
                
//                Facilitydomain domain = new Facilitydomain(domainId);
//                String[] domainPar = {"dId"};
//                Object[] domainparVals = {domainId};
//                List<Object[]> domainObjArr = (List<Object[]>) genericClassService.fetchRecord(Facilitydomain.class, new String[]{"facilitydomainid","domainname"}, "WHERE r.facilitydomainid=:dId", domainPar, domainparVals);
////                logger.info("domainObjArr :::::: "+domainObjArr);
//                if (domainObjArr != null) {
//                    for (Object[] obj : domainObjArr) {
//                        domain.setDomainname((String) obj[1]);
//                    }
//                }
                List<Object[]> levelListArr = (List<Object[]>) request.getSession().getAttribute("sessSetDescLevelArrList");
                Facilitydomain domain = (Facilitydomain) request.getSession().getAttribute("sessSetDescLevelDomainObj");
                
                Facilitylevel level = new Facilitylevel(levelid);
                String[] params3 = {"lvlId"};
                Object[] paramsValues3 = {levelid};
                List<Object[]> levelObjArr = (List<Object[]>) genericClassService.fetchRecord(Facilitylevel.class, levelFields, "WHERE r.facilitylevelid=:lvlId", params3, paramsValues3);
//                logger.info("levelObjArr :::::: "+levelObjArr);
                if (levelObjArr != null) {
                    for (Object[] obj : levelObjArr) {
                        level.setFacilitylevelname((String) obj[1]);
                        level.setShortname((String) obj[2]);
                    }
                }
                
                String[] params = {"Id2"};
                Object[] paramsValues = {levelid};
                if (maxResults == 0) {
                    descListArr = (List<Object[]>) genericClassService.fetchRecord(Entitydescription.class, fields, "WHERE r.facilitylevel.facilitylevelid=:Id2 ORDER BY r.description ASC", params, paramsValues);
                } else {
                    int countRecordSet = 0;
                    countRecordSet = genericClassService.fetchRecordCount(Entitydescription.class, "WHERE r.facilitylevel.facilitylevelid=:Id2", params, paramsValues);
                    offset = ((offset - 1) * maxResults) + 1;
                    model.put("offset2", offset);
                    if (offset > 0) {
                        offset -= 1;
                    }
                    if (countRecordSet > maxResults) {
                        model.put("paginate", true);
                        descListArr = (List<Object[]>) genericClassService.fetchRecordPaging(Entitydescription.class, fields, "WHERE r.facilitylevel.facilitylevelid=:Id2 ORDER BY r.description ASC", params, paramsValues, offset, maxResults);
                    } else {
                        model.put("paginate", false);
                        descListArr = (List<Object[]>) genericClassService.fetchRecord(Entitydescription.class, fields, "WHERE r.facilitylevel.facilitylevelid=:Id2 ORDER BY r.description ASC", params, paramsValues);
                    }
                    model.put("count", countRecordSet);
                    int totalPage = (countRecordSet + maxResults - 1) / maxResults;
                    model.put("totalPage", totalPage);
                }
                model.put("descListArr", descListArr);
                if (descListArr != null) {
                    for (Object[] obj : descListArr) {
                        Entitydescription desc = new Entitydescription((Integer) obj[0]);
                        desc.setDescription((String) obj[1]);
                        desc.setActive((Boolean) obj[2]);
                        desc.setDateadded((Date) obj[3]);
                        Person person = new Person();
                        person.setFirstname((String) obj[4]);
                        person.setLastname((String) obj[5]);
                        desc.setPerson(person);
                        int totalChildUnits = genericClassService.fetchRecordCount(Entityleveldescription.class, "WHERE r.entitydescription.descriptionid=:descId", new String[]{"descId"}, new Object[]{(Integer) obj[0]});
                        desc.setLevels(totalChildUnits);
                        descList.add(desc);
                    }
                    model.put("size", descList.size());
                }
                model.put("descList", descList);                
                model.put("levels", levelListArr);
                model.put("levelRef", level);
                model.put("domainRef", domain);

                model.put("facilityType", "Health Facility Set Up Descriptions");
                return new ModelAndView("controlPanel/universalPanel/facility/FacilityLevelSetting/EntityDesc/views/entityDescHome", "model", model);
            }
            if (activity.equals("c") || activity.equals("d")) {
                model.put("facilityType", "Health Facility Set Up Descriptions");
                
                int levelid=Integer.parseInt(id2+"");
                Facilitylevel level = new Facilitylevel(levelid);
                String[] params3 = {"lvlId"};
                Object[] paramsValues3 = {levelid};
                List<Object[]> levelObjArr = (List<Object[]>) genericClassService.fetchRecord(Facilitylevel.class, new String[]{"facilitylevelid", "facilitylevelname", "shortname"}, "WHERE r.facilitylevelid=:lvlId", params3, paramsValues3);
                if (levelObjArr != null) {
                    for (Object[] obj : levelObjArr) {
                        level.setFacilitylevelname((String) obj[1]);
                        level.setShortname((String) obj[2]);
                    }
                }
                model.put("levelRef", level);
                               
                descListArr = (List<Object[]>) genericClassService.fetchRecord(Entitydescription.class, new String[]{"description"}, "WHERE r.facilitylevel.facilitylevelid=:Id2 ORDER BY r.description ASC", new String[]{"Id2"}, new Object[] {levelid});
                model.put("descListArr", descListArr);
                
                if (activity.equals("d")) {
                    String[] params = {"Id"};
                    Object[] paramsValues = {id};
                    descListArr = (List<Object[]>) genericClassService.fetchRecord(Entitydescription.class, fields, "WHERE r.descriptionid=:Id", params, paramsValues);
                    if (descListArr != null) {
                        model.put("descObjArr", descListArr.get(0));
                    }
                }
                return new ModelAndView("controlPanel/universalPanel/facility/FacilityLevelSetting/EntityDesc/forms/formDesc", "model", model);
            }
            if (activity.equals("e")) {
                Entitydescription desc = new Entitydescription();
                model.put("facilityType", "Health Facility Set Up Descriptions");
                String[] params = {"Id"};
                Object[] paramsValues = {id};
                descListArr = (List<Object[]>) genericClassService.fetchRecord(Entitydescription.class, fields, "WHERE r.descriptionid=:Id", params, paramsValues);
                if (descListArr != null) {
                    for (Object[] obj : descListArr) {
                        desc = new Entitydescription((Integer) obj[0]);
                        desc.setDescription((String) obj[1]);
                        desc.setActive((Boolean) obj[2]);
                        desc.setDateadded((Date) obj[3]);
                        Person person = new Person();
                        person.setFirstname((String) obj[4]);
                        person.setLastname((String) obj[5]);
                        desc.setPerson(person);
                        int totalChildUnits = genericClassService.fetchRecordCount(Entityleveldescription.class, "WHERE r.entitydescription.descriptionid=:descId", new String[]{"descId"}, new Object[]{(Integer) obj[0]});
                        desc.setLevels(totalChildUnits);
                        
                        String[] field2 = {"dateupdated", "person1.firstname", "person1.lastname"};
                        List<Object[]> descListArr2 = (List<Object[]>) genericClassService.fetchRecord(Entitydescription.class, field2, "WHERE r.descriptionid=:Id", params, paramsValues);
                        if (descListArr2 != null) {
                            for (Object[] obj2 : descListArr2) {
                                desc.setDateupdated((Date) obj2[0]);
                                Person updatedBy = new Person();
                                updatedBy.setFirstname((String) obj2[1]);
                                updatedBy.setLastname((String) obj2[2]);
                                desc.setPerson1(updatedBy);
                            }
                        }
                    }
                    model.put("descObj", desc);
                }
                return new ModelAndView("controlPanel/universalPanel/facility/FacilityLevelSetting/EntityDesc/views/viewEntityDesc", "model", model);
            }
            
            if (activity.equals("f")) {
                int levelid=Integer.parseInt(id2+"");
                
                String[] params = {"Id2"};
                Object[] paramsValues = {levelid};
                
                String[] levelFields = {"facilitylevelid", "facilitylevelname"};
                List<Object[]> levelListArr = (List<Object[]>) genericClassService.fetchRecord(Facilitylevel.class, levelFields, "WHERE r.facilitylevelid=:Id2", params, paramsValues);
                if (levelListArr != null) {
                    model.put("levelObjArr", levelListArr.get(0));
                }
                
                descListArr = (List<Object[]>) genericClassService.fetchRecord(Entitydescription.class, fields, "WHERE r.facilitylevel.facilitylevelid=:Id2 ORDER BY r.description ASC", params, paramsValues);
                model.put("descListArr", descListArr);
                if (descListArr != null) {
                    for (Object[] obj : descListArr) {
                        Entitydescription desc = new Entitydescription((Integer) obj[0]);
                        desc.setDescription((String) obj[1]);
                        String options = (String) obj[6];
                        if (options != null && !options.isEmpty()) {
                            options = options.replace("[", "");
                            options = options.replace("]", "");
                            options = options.replace(" ", "");
                        }
                        desc.setOptions(options);
                        descList.add(desc);
                    }
                    model.put("size", descList.size());
                }
                model.put("descList", descList);
                
                String[] ownerFields = {"facilityownerid", "ownername"};
                List<Object[]> ownerListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityowner.class, ownerFields, "ORDER BY r.ownername ASC", new String[]{}, new Object[]{});
                if (ownerListArr != null) {
                    model.put("ownerListArr", ownerListArr);
                }
                
                List<Object[]> regionArr = (List<Object[]>) genericClassService.fetchRecord(Region.class, new String[]{"regionid", "regionname"}, "", new String[]{}, new Object[]{});
                if (regionArr != null) {
                    model.put("regionSize", regionArr.size());
                }
                model.put("regions", regionArr);

                model.put("facilityType", "Health Facility Set Up Descriptions"); 
                return new ModelAndView("controlPanel/universalPanel/facility/FacilityRegistration/forms/setDescList", "model", model);
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
        @RequestMapping(value = "/regEntityDesc.htm", method = RequestMethod.GET)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView regEntityDesc(HttpServletRequest request, Principal principal) {
        logger.info("Received Request To Add Entity Description");
        Map<String, Object> model = new HashMap<String, Object>();
        Entitydescription descObj = new Entitydescription();
        boolean updateActivity = false;
        try {
            if (principal == null) {
                return new ModelAndView("refresh");
            }
            String activity = request.getParameter("act");
            String description = request.getParameter("b");
            int levelid=Integer.parseInt(request.getParameter("i"));
            
            model.put("activity", activity);
            model.put("desc", description);
            model.put("id", levelid);


            List<Entitydescription> existingList = new ArrayList<Entitydescription>();
            long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
            descObj.setDescription(description);
            descObj.setActive(true);
            descObj.setDateadded(new Date());
            descObj.setPerson(new Person(pid));
            descObj.setFacilitylevel(new Facilitylevel(levelid));

            if (activity.equals("a")) {
                String[] param2 = {"name","levelId"};
                Object[] paramsValue2 = {description.toLowerCase(),levelid};
                String[] field2 = {"descriptionid", "description", "active", "dateadded", "person.firstname", "person.lastname"};
                List<Object[]> existingOrgList = (List<Object[]>) genericClassService.fetchRecord(Entitydescription.class, field2, "WHERE LOWER(r.description)=:name AND r.facilitylevel.facilitylevelid=:levelId", param2, paramsValue2);
                if (existingOrgList != null) {
                    model.put("resp", false);
                    model.put("respMessage", "Already Assigned");
                    model.put("mainActivity", "Health Facility Set Up Descriptions");

                    return new ModelAndView("controlPanel/universalPanel/facility/FacilityLevelSetting/EntityDesc/forms/response", "model", model);
                }

                genericClassService.saveOrUpdateRecordLoadObject(descObj);
                
                List<Object[]> savedList = (List<Object[]>) genericClassService.fetchRecord(Entitydescription.class, field2, "WHERE r.descriptionid=:Id", new String[]{"Id"}, new Object[]{descObj.getDescriptionid()});
                if (savedList != null) {
                    model.put("resp", true);
                    model.put("respMessage", "Successfully Assigned");
                }else{
                    model.put("resp", false);
                    model.put("respMessage", "FAILED!!");
                }
                
            } else {
                genericClassService.deleteRecordByByColumns(Entitydescription.class, new String[]{"description","facilitylevelid"}, new Object[]{description,levelid});
                //Checking for successful deletion
                if (genericClassService.fetchRecord(Entitydescription.class, new String[]{"descriptionid"}, "WHERE r.facilitylevel.facilitylevelid=:Id AND r.description=:desc", new String[]{"Id","desc"}, new Object[]{levelid,description}) == null) {
                    logger.info("Response :Deleted:: ");
                    model.put("resp", false);
                    model.put("respMessage", "Successfully Deleted");
                }else{
                    model.put("resp", true);
                    model.put("respMessage", "FAILED!!");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.put("resp", false);
            model.put("respMessage", "ERROR OCCURED!");
        }
        
        return new ModelAndView("controlPanel/universalPanel/facility/FacilityLevelSetting/EntityDesc/forms/response", "model", model);
    }
    
    /**
     *
     * @param request
     * @param principal
     * @return
     */
        @RequestMapping(value = "/regEntityDesc_Catchment.htm", method = RequestMethod.GET)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView regEntityDesc_Catchment(HttpServletRequest request, Principal principal) {
        logger.info("Received Request To Add Entity Description");
        Map<String, Object> model = new HashMap<String, Object>();
        Entitydescription descObj = new Entitydescription();
        boolean updateActivity = false;
        try {
            if (principal == null) {
                return new ModelAndView("refresh");
            }
            String activity = request.getParameter("act");
            String description = request.getParameter("b");
            int levelid=Integer.parseInt(request.getParameter("i"));
            boolean national = Boolean.parseBoolean(request.getParameter("n"));
            boolean regional = Boolean.parseBoolean(request.getParameter("r"));
            boolean district = Boolean.parseBoolean(request.getParameter("d"));
            boolean county = Boolean.parseBoolean(request.getParameter("c"));
            boolean subcounty = Boolean.parseBoolean(request.getParameter("sc"));
            boolean parish = Boolean.parseBoolean(request.getParameter("p"));
            
            model.put("activity", activity);
            model.put("desc", description);
            model.put("id", levelid);

            List<String> list = new ArrayList<String>();
            if(national==true){list.add("National"); logger.info("Add national:"+national);}
            if(regional==true){list.add("Regional"); logger.info("Add regional:"+regional);}
            if(district==true){list.add("District"); logger.info("Add district:"+district);}
            if(county==true){list.add("County"); logger.info("Add county:"+county);}
            if(subcounty==true){list.add("Sub-County"); logger.info("Add subcounty:"+subcounty);}
            if(parish==true){list.add("Parish"); logger.info("Add parish:"+parish);}

            List<Entitydescription> existingList = new ArrayList<Entitydescription>();
            long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
            descObj.setDescription(description);
            descObj.setActive(true);
            descObj.setDateadded(new Date());
            descObj.setPerson(new Person(pid));
            descObj.setFacilitylevel(new Facilitylevel(levelid));
            descObj.setOptions(""+list);

            if (activity.equals("a")) {
                String[] param2 = {"name","levelId"};
                Object[] paramsValue2 = {description.toLowerCase(),levelid};
                String[] field2 = {"descriptionid", "description", "active", "dateadded", "person.firstname", "person.lastname"};
                List<Object[]> existingOrgList = (List<Object[]>) genericClassService.fetchRecord(Entitydescription.class, field2, "WHERE LOWER(r.description)=:name AND r.facilitylevel.facilitylevelid=:levelId", param2, paramsValue2);
                if (existingOrgList != null) {
                    model.put("resp", false);
                    model.put("respMessage", "Already Assigned");
                    model.put("mainActivity", "Health Facility Set Up Descriptions");

                    return new ModelAndView("controlPanel/universalPanel/facility/FacilityLevelSetting/EntityDesc/forms/response", "model", model);
                }

                genericClassService.saveOrUpdateRecordLoadObject(descObj);
                
                List<Object[]> savedList = (List<Object[]>) genericClassService.fetchRecord(Entitydescription.class, field2, "WHERE r.descriptionid=:Id", new String[]{"Id"}, new Object[]{descObj.getDescriptionid()});
                if (savedList != null) {
                    model.put("resp", true);
                    model.put("respMessage", "Successfully Assigned");
                }else{
                    model.put("resp", false);
                    model.put("respMessage", "FAILED!!");
                }
                
            } else {
                genericClassService.deleteRecordByByColumns(Entitydescription.class, new String[]{"description","facilitylevelid"}, new Object[]{description,levelid});
                //Checking for successful deletion
                if (genericClassService.fetchRecord(Entitydescription.class, new String[]{"descriptionid"}, "WHERE r.facilitylevel.facilitylevelid=:Id AND r.description=:desc", new String[]{"Id","desc"}, new Object[]{levelid,description}) == null) {
                    logger.info("Response :Deleted:: ");
                    model.put("resp", true);
                    model.put("respMessage", "Successfully Deleted");
                }else{
                    model.put("resp", false);
                    model.put("respMessage", "FAILED!!");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.put("resp", false);
            model.put("respMessage", "ERROR OCCURED!");
        }
        
        return new ModelAndView("controlPanel/universalPanel/facility/FacilityLevelSetting/EntityDesc/forms/response", "model", model);
    }
    
    
    /**
     *
     * @param request
     * @param principal
     * @return
     */
    @RequestMapping(value = "/regEntityDescLevels.htm", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView regEntityDescLevels(HttpServletRequest request, Principal principal) {
        logger.info("Received request to add facility levels");
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            if (principal == null) {
                return new ModelAndView("refresh");
            }
            model.put("act", request.getParameter("act"));
            model.put("b", request.getParameter("b"));
            model.put("i", request.getParameter("i"));
            model.put("a", request.getParameter("a"));
            
//            long id = Long.parseLong(request.getParameter("cref"));
            
            List<Entityleveldescription> levelList = new ArrayList<Entityleveldescription>();
            List<Entityleveldescription> customList = new ArrayList<Entityleveldescription>();

            int descriptionid = Integer.parseInt(request.getParameter("descId"));
            Entitydescription descObj = new Entitydescription(descriptionid);
            String[] param2 = {"Id"};
            Object[] paramsValue2 = {descriptionid};
            String[] field2 = {"descriptionid", "description"};
            List<Object[]> existingDesc = (List<Object[]>) genericClassService.fetchRecord(Entitydescription.class, field2, "WHERE r.descriptionid=:Id", param2, paramsValue2);
            if (existingDesc != null) {
                for (Object[] obj : existingDesc) {
                        descObj.setDescription((String) obj[1]);
                }
            }
            model.put("descObj", descObj);
            
            int count = Integer.parseInt(request.getParameter("itemSize"));
            if (count > 0) {
                logger.info("item Count......... " + count + ">0");
                for (int i = 1; i <= count; i++) {
                    if (request.getParameter("level"+i) != null) {
                        int levelid = Integer.parseInt(request.getParameter("level"+i));
                        Entityleveldescription level = new Entityleveldescription();
                        level.setEntitydescription(descObj);
                        level.setFacilitylevel(new Facilitylevel(levelid));
                        level.setDateadded(new Date());
                        level.setStatus(true);
                        levelList.add(level);
                    }
                }
            } else {
                model.put("resp", false);
                model.put("errorMessage", "No Record Submitted");
                model.put("mainActivity", "Health Facility Type");
                return new ModelAndView("controlPanel/universalPanel/facility/FacilityLevelSetting/EntityDesc/views/addLevelsResponse", "model", model);
            }
            for (Entityleveldescription level : levelList) {
                
                String[] fields = {"entitylevelid", "entitydescription.description", "facilitylevel.facilitylevelname", "dateadded", "status"};

                if (genericClassService.fetchRecord(Entityleveldescription.class, fields, "WHERE r.entitydescription.descriptionid=:descId AND r.facilitylevel.facilitylevelid=:levelId", new String[]{"descId","levelId"}, new Object[]{level.getEntitydescription().getDescriptionid(),level.getFacilitylevel().getFacilitylevelid()}) == null) {
                    //Non Existent
                    genericClassService.saveOrUpdateRecordLoadObject(level);
                    String[] params = {"Id"};
                    Object[] paramsValues = {level.getEntitylevelid()};
                    //Checking for successful addition
                    if (genericClassService.fetchRecord(Entityleveldescription.class, fields, "WHERE r.entitylevelid=:Id", params, paramsValues) != null) {
                        logger.info("Response :Added:: ");
                        level.setDescription("Successfully Added");
                        level.setStatus(true);
                    } else {
                        logger.info("Response :Not Added:!!: ");
                        level.setDescription("Not Saved");
                        level.setStatus(false);
                    }
                } else {
                    level.setDescription("Exists");
                    level.setStatus(false);

                }
                customList.add(level);
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
        model.put("mainActivity", "Facility Level");
        return new ModelAndView("controlPanel/universalPanel/facility/FacilityLevelSetting/EntityDesc/views/addLevelsResponse", "model", model);
    }
    
    
    
    /**
     *
     * @param request
     * @param principal
     * @return
     */
    @RequestMapping(value = "/deleteEntityDesc.htm", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView deleteEntityDesc(HttpServletRequest request, Principal principal) {
        logger.info("Received request to delete description");
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            if (principal == null) {
                return new ModelAndView("refresh");
            }
            model.put("act", request.getParameter("act"));
            model.put("b", request.getParameter("b"));
            model.put("i", request.getParameter("i"));
            model.put("a", request.getParameter("a"));
            
            List<Long> ids = new ArrayList<Long>();
            List<Entityleveldescription> customList = new ArrayList<Entityleveldescription>();

            int count = Integer.parseInt(request.getParameter("itemSize"));
            if (count > 0) {
                logger.info("item Count......... " + count + ">0");
                for (int i = 1; i <= count; i++) {
                    if (request.getParameter("selectObj" + i) != null) {
                        long id = Long.parseLong(request.getParameter("selectObj" + i));
                        ids.add(id);
                    }
                }
            } else {
                model.put("resp", false);
                model.put("errorMessage", "No Record Submitted");
                model.put("mainActivity", "Facility Registration Descriptions");
                return new ModelAndView("controlPanel/universalPanel/facility/FacilityLevelSetting/EntityDesc/views/deleteResponse", "model", model);
            }
            for (Long id : ids) {
                String[] params = {"Id"};
                Object[] paramsValues = {id};
                String[] fields = {"entitylevelid", "entitydescription.description", "facilitylevel.facilitylevelname", "dateadded", "status"};
                List<Object[]> catArrList = (List<Object[]>) genericClassService.fetchRecord(Entityleveldescription.class, fields, "WHERE r.entitylevelid=:Id", params, paramsValues);
                if(catArrList!=null){
                    int success = 0;
                    genericClassService.deleteRecordByByColumns(Entityleveldescription.class, new String[]{"entitylevelid"}, new Object[]{id});
                    //Checking for successful deletion
                    if (genericClassService.fetchRecord(Entityleveldescription.class, fields, "WHERE r.entitylevelid=:Id", params, paramsValues)==null) {
                        logger.info("Response :Deleted:: ");
                        Entityleveldescription catObj = new Entityleveldescription((Long) catArrList.get(0)[0]);
                        Entitydescription descObj = new Entitydescription();
                        descObj.setDescription((String) catArrList.get(0)[1]);
                        catObj.setEntitydescription(descObj);
                        Facilitylevel levelObj = new Facilitylevel();
                        levelObj.setFacilitylevelname((String) catArrList.get(0)[2]);
                        catObj.setFacilitylevel(levelObj);
                        catObj.setDescription("N/A");
                        catObj.setStatus(true);
                        customList.add(catObj);
                    } else {
                        Entityleveldescription catObj = new Entityleveldescription((Long) catArrList.get(0)[0]);
                        Entitydescription descObj = new Entitydescription();
                        descObj.setDescription((String) catArrList.get(0)[1]);
                        catObj.setEntitydescription(descObj);
                        Facilitylevel levelObj = new Facilitylevel();
                        levelObj.setFacilitylevelname((String) catArrList.get(0)[2]);
                        catObj.setFacilitylevel(levelObj);
                        catObj.setStatus(false);
                        catObj.setDescription("Record In Use");                       
                        customList.add(catObj);
                    }
                }
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
        model.put("mainActivity", "Facility Registration Descriptions");
        return new ModelAndView("controlPanel/universalPanel/facility/FacilityLevelSetting/EntityDesc/views/deleteResponse", "model", model);
    }
    
    
    /**
     *
     * @param principal
     * @return
     */
    @RequestMapping("/orgFacilitySettings.htm")
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView orgFacilitySettings(Principal principal, HttpServletRequest request,
            @RequestParam("act") String activity, @RequestParam("i") long id, @RequestParam("d") long id2,
            @RequestParam("b") String strVal, @RequestParam("c") String strVal2,
            @RequestParam("ofst") int offset, @RequestParam("maxR") int maxResults,
            @RequestParam("sStr") String searchPhrase) {
        if (principal == null) {
            return new ModelAndView("refresh");
        }
        Map<String, Object> model = new HashMap<String, Object>();
        model.put("onErrorReturnURL", "ajaxSubmitData('orgFacilitySetting.htm', 'workPane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');");
        try {
            model.put("act", activity);
            model.put("b", strVal);
            model.put("i", id);
            model.put("c", strVal2);
            model.put("d", id2);
            model.put("ofst", offset);
            model.put("maxR", maxResults);
            model.put("sStr", searchPhrase);

            request.getSession().setAttribute("sessPagingOffSet", offset);
            request.getSession().setAttribute("sessPagingMaxResults", maxResults);
            request.getSession().setAttribute("vsearch", searchPhrase);

            String[] fields = {"facilityid", "facilityname", "facilitycode", "shortname", "location", "description", "active", "dateadded", "person2.firstname", "person2.lastname", "facilitylevelid.facilitylevelname", "facilitylevelid.shortname"};
            
            List<Facility> facilityList = new ArrayList<Facility>();
            List<Object[]> assetsListArr = new ArrayList<Object[]>();
            if (activity.equals("a")) {
                id = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
                
                String[] params = {"facId"};
                Object[] paramsValues = {id};
                                
                if (maxResults == 0) {
                    assetsListArr = (List<Object[]>) genericClassService.fetchRecord(Facility.class, fields, "WHERE r.facilityid=:facId ORDER BY r.facilityname ASC", params, paramsValues);
                } else {
                    int countRecordSet = 0;
                    countRecordSet = genericClassService.fetchRecordCount(Facility.class, "WHERE r.facilityid=:facId", params, paramsValues);
                    offset = ((offset - 1) * maxResults) + 1;
                    model.put("offset2", offset);
                    if (offset > 0) {
                        offset -= 1;
                    }
                    if (countRecordSet > maxResults) {
                        model.put("paginate", true);
                        assetsListArr = (List<Object[]>) genericClassService.fetchRecordPaging(Facility.class, fields, "WHERE r.facilityid=:facId ORDER BY r.facilityname ASC", params, paramsValues, offset, maxResults);
                    } else {
                        model.put("paginate", false);
                        assetsListArr = (List<Object[]>) genericClassService.fetchRecord(Facility.class, fields, "WHERE r.facilityid=:facId ORDER BY r.facilityname ASC", params, paramsValues);
                    }
                    model.put("count", countRecordSet);
                    int totalPage = (countRecordSet + maxResults - 1) / maxResults;
                    model.put("totalPage", totalPage);
                }
                model.put("assetsList", assetsListArr);
                if (assetsListArr != null) {
                    for (Object[] obj : assetsListArr) {
                        //{"facilityid", "facilityname", "facilitycode", "district.districtid", "district.districtname", "location", "description", "active", "dateadded", "person1.personname"};
                        Facility f = new Facility((Integer) obj[0]);
                        f.setFacilityname((String) obj[1]);
                        f.setFacilitycode((String) obj[2]);
                        f.setShortname((String) obj[3]);
//                        Village village = new Village();
//                        Parish p = new Parish();
//                        Subcounty sc = new Subcounty();
//                        County c = new County();
//                        District d = new District((Integer) obj[4]);
//                        d.setDistrictname((String) obj[5]);
//                        c.setDistrictid(d);
//                        sc.setCountyid(c);
//                        p.setSubcountyid(sc);
//                        village.setParishid(p);
//                        f.setVillage(village);
                        f.setLocation((String) obj[4]);
                        f.setDescription((String) obj[5]);
                        f.setActive((Boolean) obj[6]);
                        f.setDateadded((Date) obj[7]);
                        Person person = new Person();
                        person.setFirstname((String) obj[8]);
                        person.setLastname((String) obj[9]);
                        f.setPerson2(person);
                        facilityList.add(f);
                    }
                    model.put("size", facilityList.size());
                }
                model.put("facilityList", facilityList);
                model.put("facilityType", "Facility"); 
                return new ModelAndView("controlPanel/universalPanel/facility/FacilityRegistration/facilityRegHome", "model", model);
            }
            if (activity.equals("b") || activity.equals("c") || activity.equals("c1") || activity.equals("c2")) {
                
                model.put("facilityType", "Facility");  
                if (activity.equals("b")) {
                    
                }
                if (activity.equals("c")) {
                    String[] params2 = {};
                    Object[] paramsValues2 = {};
                    String[] levelFields = {"facilitylevelid", "facilitylevelname", "shortname"};
                    String phrase="health";
                    List<Object[]> levelListArr = (List<Object[]>) genericClassService.fetchRecord(Facilitylevel.class, levelFields, "WHERE r.facilitydomain IN (SELECT d.facilitydomainid FROM Facilitydomain d WHERE LOWER(d.domainname) LIKE '" + phrase + "%') ORDER BY r.facilitylevelname ASC", params2, paramsValues2);
                    if (levelListArr != null) {
                        logger.info("levelListArr ::::::::: "+levelListArr.size());
                        model.put("levelSize", levelListArr.size());
                    } 
                    model.put("levels", levelListArr);
                }
                if (activity.equals("c") || activity.equals("c1") || activity.equals("c2")) {
                    Facility fac = new Facility();
                    String[] field1 = {"facilityid", "facilityname", "facilitycode", "shortname", "location", "description", "active", "dateadded", "person2.firstname","person2.lastname", "facilitylevelid.facilitylevelid", "facilitylevelid.facilitylevelname", 
                    "facilityfunder", "hasdepartments", "phonecontact", "emailaddress", "postaddress", "facilitylogourl"};
                    String[] villField = {"village.villageid", "village.villagename", "village.parishid.parishid", "village.parishid.parishname", "village.parishid.subcountyid.subcountyid","village.parishid.subcountyid.subcountyname", 
                        "village.parishid.subcountyid.countyid.countyid", "village.parishid.subcountyid.countyid.countyname", "village.parishid.subcountyid.countyid.districtid.districtid", "village.parishid.subcountyid.countyid.districtid.districtname", 
                        "village.parishid.subcountyid.countyid.districtid.regionid.regionid", "village.parishid.subcountyid.countyid.districtid.regionid.regionname"};

                    String[] params = {"Id"};
                    Object[] paramsValues = {id};
                    assetsListArr = (List<Object[]>) genericClassService.fetchRecord(Facility.class, field1, "WHERE r.facilityid=:Id", params, paramsValues);
                    if (assetsListArr != null) {
                        for (Object[] obj : assetsListArr) {
                            //"facilityid", "facilityname", "facilitycode", "shortname", "location", "description", "active", "dateadded", "person2.firstname","person2.lastname", "facilitylevel.facilitylevelid", "facilitylevel.facilitylevelname",
                            fac.setFacilityid((Integer)obj[0]);
                            fac.setFacilityname((String)obj[1]);
                            fac.setFacilitycode((String)obj[2]);
                            fac.setShortname((String) obj[3]);
                            fac.setLocation((String)obj[4]);
                            fac.setDescription((String)obj[5]);
                            fac.setActive((Boolean)obj[6]);
                            fac.setDateadded((Date)obj[7]);
                            Person person2 = new Person();
                            person2.setFirstname((String)obj[8]);
                            person2.setLastname((String)obj[9]);
                            fac.setPerson2(person2);
                            Facilitylevel fl = new Facilitylevel((Integer)obj[10]);
                            fl.setFacilitylevelname((String)obj[11]);
                            fac.setFacilitylevelid(fl);
                            fac.setFacilityfunder((String)obj[12]);
                            fac.setHasdepartments((Boolean) obj[13]);
                            if(activity.equals("c")){
                                String phone=(String) obj[14];
                                String phoneContact1="";
                                String phoneContact2="";
                                if(phone!=null && !phone.isEmpty()){
                                    List<String> optionsList = Arrays.asList(phone.split(";"));
                                    if(!optionsList.isEmpty()){
                                        for (String opt : optionsList) {
                                            if(phoneContact1.equals("")){
                                                phoneContact1=opt;
                                            }else{
                                                phoneContact2=opt;
                                            }
                                        }
                                    }
                                }
                                fac.setPhonecontact(phoneContact1.trim());
                                fac.setPhonecontact2(phoneContact2.trim());
                            }
                            else{
                                fac.setPhonecontact((String) obj[14]);
                            }
                            fac.setEmailaddress((String)obj[15]);
                            fac.setPostaddress((String)obj[16]);
                            fac.setFacilitylogourl((String)obj[17]);
//                            "village.villagename", "village.parish.parishname", "village.parish.subcounty.subcountyname", "village.parish.subcounty.county.countyname", "village.parish.subcounty.county.district.districtname", "village.parish.subcounty.county.district.region.regionname"};
                            List<Object[]> facList2Arr = (List<Object[]>) genericClassService.fetchRecord(Facility.class, villField, "WHERE r.facilityid=:Id", new String[]{"Id"}, new Object[]{fac.getFacilityid()});
                            if (facList2Arr != null) {
                                for (Object[] obj2 : facList2Arr) {
                                    Village v = new Village((Integer) obj2[0]);
                                    v.setVillagename((String) obj2[1]);
                                    Parish p = new Parish((Integer) obj2[2]);
                                    p.setParishname((String) obj2[3]);
                                    Subcounty sc = new Subcounty((Integer) obj2[4]);
                                    sc.setSubcountyname((String) obj2[5]);
                                    County c = new County((Integer) obj2[6]);
                                    c.setCountyname((String) obj2[7]);
                                    District d = new District((Integer) obj2[8]);
                                    d.setDistrictname((String) obj2[9]);
                                    Region r = new Region((Integer) obj2[10]);
                                    r.setRegionname((String) obj2[11]);
                                    d.setRegionid(r);
                                    c.setDistrictid(d);
                                    sc.setCountyid(c);
                                    p.setSubcountyid(sc);
                                    v.setParishid(p);
                                    fac.setVillage(v);
                                }
                            }
                            List<Object[]> facList3Arr = (List<Object[]>) genericClassService.fetchRecord(Facility.class, new String[]{"facilityownerid.facilityownerid","facilityownerid.ownername"}, "WHERE r.facilityid=:Id", new String[]{"Id"}, new Object[]{fac.getFacilityid()});
                            if (facList3Arr != null) {
                                for (Object[] obj2 : facList3Arr) {
                                    Facilityowner owner = new Facilityowner((Integer) obj2[0]);
                                    owner.setOwnername((String) obj2[1]);
                                    fac.setFacilityownerid(owner);
                                }
                            }
                            
                            String[] field3 = {"person.firstname", "person.lastname", "dateupdated"};
                            String[] param3 = {"Id"};
                            Object[] paramsValue3 = {fac.getFacilityid()};
                            List<Object[]> facListArr3 = (List<Object[]>) genericClassService.fetchRecord(Facility.class, field3, "WHERE r.facilityid=:Id", param3, paramsValue3);
                            if (facListArr3 != null) {
                                for (Object[] obj3 : facListArr3) {
                                    Person p2 = new Person();
                                    p2.setFirstname((String)obj3[0]);
                                    p2.setLastname((String)obj3[1]);
                                    fac.setPerson(p2);
                                    fac.setDateupdated((Date) obj3[2]);
                                }
                            }
                            String[] field4 = {"person1.firstname", "person1.lastname", "dateapproved"};
                            String[] param4 = {"Id"};
                            Object[] paramsValue4 = {fac.getFacilityid()};
                            List<Object[]> facListArr4 = (List<Object[]>) genericClassService.fetchRecord(Facility.class, field4, "WHERE r.facilityid=:Id", param4, paramsValue4);
                            if (facListArr4 != null) {
                                for (Object[] obj4 : facListArr4) {
                                    Person p3 = new Person();
                                    p3.setFirstname((String)obj4[0]);
                                    p3.setLastname((String)obj4[1]);
                                    fac.setPerson1(p3);
                                    fac.setDateapproved((Date) obj4[2]);
                                }
                            }
                        }
                        logger.info("Status--------------------"+fac.getActive());
                        model.put("facObj", fac);
                    }
                    List<Facilitypolicy> policyList = new ArrayList<Facilitypolicy>();
                    List<Facilitypolicy> policyList2 = new ArrayList<Facilitypolicy>();
                    List<Object[]> assignedPolicyListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityassignedpolicy.class, new String[]{"facilitypolicy.policyid","facilitypolicy.policyname","facilitypolicyoptions.optionsid","facilitypolicyoptions.name","facilitypolicy.category"}, "WHERE r.facility.facilityid=:Id ORDER BY r.facilitypolicy.policyname, r.facilitypolicyoptions.name ASC", new String[]{"Id"}, new Object[]{fac.getFacilityid()});
                    if (assignedPolicyListArr != null) {
                        for (Object[] obj : assignedPolicyListArr) {
                            Facilitypolicy policy = new Facilitypolicy((Long)obj[0]);
                            policy.setPolicyname((String)obj[1]);
                            policy.setCategory((String)obj[4]);
                            if(!policyList.contains(policy)){
                                policyList.add(policy);
                            }
                        }
                        for (Facilitypolicy policyObj : policyList) {
                            List<Facilitypolicyoptions> optionsList = new ArrayList<Facilitypolicyoptions>();
                            for (Object[] obj : assignedPolicyListArr) {
                                if(policyObj.getPolicyid()==(Long)obj[0]){
                                    Facilitypolicyoptions option = new Facilitypolicyoptions((Long)obj[2]);
                                    option.setName((String)obj[3]);
                                    optionsList.add(option);
                                }
                            }
                            policyObj.setFacilitypolicyoptionsList(optionsList);
                            policyList2.add(policyObj);
                        }
                    }
                    if (policyList2 != null) {
                        model.put("size", policyList2.size());
                    }
                    model.put("policyList", policyList2);
                    if (activity.equals("c1")) {
                        model.put("formActivity", "a");
                        if(request.getSession().getAttribute("sessReturnSearchedFacilityUrl")!=null){
                            model.put("returnURL", request.getSession().getAttribute("sessReturnSearchedFacilityUrl").toString());
                        }
                        return new ModelAndView("controlPanel/universalPanel/facility/FacilityRegistration/views/viewFacilityDetail", "model", model);
                    }
                    logger.info("Activity ::activity.equals(c2)::: "+(activity.equals("c2"))+"==="+activity);
                    if (activity.equals("c2")) {
                        return new ModelAndView("controlPanel/universalPanel/facility/FacilityRegistration/forms/viewFacilityDetails", "model", model);
                    }
                }
                String[] ownerFields = {"facilityownerid", "ownername"};
                List<Object[]> ownerListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityowner.class, ownerFields, "ORDER BY r.ownername ASC", new String[]{}, new Object[]{});
                if (ownerListArr != null) {
                    model.put("ownerListArr", ownerListArr);
                }
                model.put("returnURL", request.getSession().getAttribute("sessReturnSearchedFacilityUrl").toString());
                return new ModelAndView("controlPanel/universalPanel/facility/FacilityRegistration/forms/formFacilityReg", "model", model);
            }
            if (activity.equals("d")) {
                List<Object[]> districtArr = (List<Object[]>) genericClassService.fetchRecord(District.class, new String[]{"districtid", "districtname"}, "WHERE r.region.regionid=:Id", new String[]{"Id"}, new Object[]{id});
                if (districtArr != null) {
                    model.put("districtSize", districtArr.size());
                }
                model.put("formActivity", "AssetReg-District");
                model.put("districts", districtArr);
                return new ModelAndView("controlPanel/universalPanel/facility/FacilityRegistration/forms/locations", "model", model);
            }
            if (activity.equals("e")) { 
                //Update Policies
                String[] policyFields = {"policyid", "policyname", "description", "datatype", "options", "status", "limited", "dateadded", "person.firstname", "person.lastname", "category"};

                List<Facilitypolicy> facOptionList = new ArrayList<Facilitypolicy>();
                List<Object[]> facObjArr = (List<Object[]>) genericClassService.fetchRecord(Facility.class, new String[]{"facilityid","facilityname","facilitylevelid.facilitylevelname"}, "WHERE r.facilityid=:Id", new String[]{"Id"}, new Object[]{id});
                if(facObjArr!=null){
                    model.put("facObjArr", facObjArr.get(0));
                }
                List<Object> assignedPolicyListArr = (List<Object>) genericClassService.fetchRecord(Facilityassignedpolicy.class, new String[]{"facilitypolicyoptions.optionsid"}, "WHERE r.facility.facilityid=:fId", new String[]{"fId"}, new Object[]{id});
                List<Long> assignedIds = new ArrayList<Long>();
                if(assignedPolicyListArr!=null){
                    for (Object obj : assignedPolicyListArr) {
                        assignedIds.add((Long)obj);
                    }
                }
                
                String[] params = {};
                Object[] paramsValues = {};
                List<Object[]> policyListArr = (List<Object[]>) genericClassService.fetchRecord(Facilitypolicy.class, policyFields, "ORDER BY r.category, r.policyname ASC", params, paramsValues);
                if (policyListArr != null) {
                    for (Object[] obj : policyListArr) {
                        Facilitypolicy policy = new Facilitypolicy((Long) obj[0]);
                        policy.setPolicyname((String) obj[1]);
                        policy.setDatatype((String) obj[3]);
                        policy.setCategory((String) obj[10]);
                        String optionsHtml = "";
                        String str = (String) obj[4];
                        String[] params2 = {"Id"};
                        Object[] paramsValues2 = {(Long) obj[0]};
                        List<Object[]> policyOptListArr = (List<Object[]>) genericClassService.fetchRecord(Facilitypolicyoptions.class, new String[]{"optionsid","name"}, "WHERE r.facilitypolicy.policyid=:Id ORDER BY r.name ASC", params2, paramsValues2);
                        if (policyOptListArr != null) {
                            List<Facilitypolicyoptions> optionList = new ArrayList<Facilitypolicyoptions>();
                            for (Object[] opt : policyOptListArr) {
                                Facilitypolicyoptions fpoObj = new Facilitypolicyoptions((Long) opt[0]);
                                fpoObj.setName((String) opt[1]);
                                if(assignedIds.contains((Long) opt[0])){
                                    fpoObj.setActive(true);
                                    policy.setStatus(true);
                                }else{
                                    fpoObj.setActive(false);
                                }
                                optionList.add(fpoObj);
                                optionsHtml += "<li>" + opt + "</li>";
                            }
                            policy.setFacilitypolicyoptionsList(optionList);
                        }
                        policy.setOptions("<ol>" + optionsHtml + "</ol>");
                        facOptionList.add(policy);
                    }
                    logger.info("policyListArr ::::::::: " + policyListArr.size());
                    model.put("size", policyListArr.size());
                }
                model.put("policyList", facOptionList);
                //model.put("policyList", policyListArr);
                model.put("facilityType", "Facility Policy Set Up");
                model.put("returnURL", request.getSession().getAttribute("sessReturnSearchedFacilityUrl").toString());
                return new ModelAndView("controlPanel/universalPanel/facility/FacilityRegistration/forms/updateFacilityPolicy", "model", model);
            }
            if (activity.equals("f")) {
                long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
                boolean state= Boolean.parseBoolean(strVal);
                genericClassService.updateRecordSQLStyle(Facility.class, new String[]{"active","approvedby", "dateapproved"}, new Object[]{state, pid, new Date()}, "facilityid", id);
                if(state==true){
                    model.put("resp", true);
                    model.put("successMessage", "Successfully Approved Facility");
                }else{
                    model.put("resp", true);
                    model.put("successMessage", "Successfully Deactivated Facility");
                }
                model.put("mainActivity", "Facility");
                return orgFacilitySettings(principal, request, "c1", id, id2, strVal, strVal2, offset, maxResults, searchPhrase);
            }
            if (activity.equals("g")) {
                model.put("orgId", id2);
                List<Facility> customList = new ArrayList<Facility>();
                String[] params = {"Id"};
                Object[] paramsValues = {id};
                List<Object[]> facArrList = (List<Object[]>) genericClassService.fetchRecord(Facility.class, fields, "WHERE r.facilityid=:Id", params, paramsValues);

                if (facArrList != null) {
                    int success = 0;
                    genericClassService.deleteRecordByByColumns(Facility.class, new String[]{"facilityid"}, new Object[]{id});
                    //Checking for successful deletion
                    if (genericClassService.fetchRecord(Facility.class, fields, "WHERE r.facilityid=:Id", params, paramsValues) == null) {
                        logger.info("Response :Deleted:: ");
                        Facility facObj = new Facility((Integer) facArrList.get(0)[0]);
                        facObj.setFacilitycode((String) facArrList.get(0)[2]);
                        facObj.setFacilityname((String) facArrList.get(0)[1]);
                        facObj.setDescription("N/A");
                        facObj.setActive(true);
                        customList.add(facObj);
                    } else {
                        Facility facObj = new Facility((Integer) facArrList.get(0)[0]);
                        facObj.setFacilitycode((String) facArrList.get(0)[2]);
                        facObj.setFacilityname((String) facArrList.get(0)[1]);
                        facObj.setActive(false);

                        List<Integer[]> object = (List<Integer[]>) genericClassService.fetchRecord(Facilityunit.class, new String[]{"facilityunitid"}, " WHERE r.facility.facilityid=:facID", new String[]{"facID"}, new Object[]{id});
                        if (object != null) {
                            logger.info("Facility Units Attached ::: " + object.size() + " For Id: " + id);
                            String str = "";
                            if (object.size() == 1) {
                                str = "1 Facility Unit Attached";
                            } else {
                                str = object.size() + " Facility Units Attached";
                            }
                            facObj.setDescription(str);
                        } else {
                            facObj.setDescription("N/A");
                        }
                        customList.add(facObj);
                    }
                } else {
                    model.put("resp", false);
                    model.put("errorMessage", "Error! Contact Admin");
                }
                model.put("customList", customList);
                if (customList != null) {
                    model.put("size", customList.size());
                }
                model.put("mainActivity", "Facility");
                return new ModelAndView("controlPanel/universalPanel/facility/FacilityRegistration/views/deleteResponse", "model", model);
            }
            if (activity.equals("h")) { 
                List<Object[]> facListArr = (List<Object[]>) genericClassService.fetchRecord(Facility.class, fields, "WHERE r.facilityid=:Id", new String[]{"Id"},  new Object[]{id});
                model.put("assetsList", facListArr);
                if (facListArr != null) { 
                    for (Object[] obj : facListArr) {
                        //{"facilityid", "facilityname", "facilitycode", "district.districtid", "district.districtname", "location", "description", "active", "dateadded", "person1.personname"};
                        Facility f = new Facility((Integer) obj[0]);
                        f.setFacilityname((String) obj[1]);
                        f.setFacilitycode((String) obj[2]);
                        f.setShortname((String) obj[3]);
//                        Village village = new Village();
//                        Parish p = new Parish();
//                        Subcounty sc = new Subcounty();
//                        County c = new County();
//                        District d = new District((Integer) obj[4]);
//                        d.setDistrictname((String) obj[5]);
//                        c.setDistrictid(d);
//                        sc.setCountyid(c);
//                        p.setSubcountyid(sc);
//                        village.setParishid(p);
//                        f.setVillage(village);
                        f.setLocation((String) obj[4]);
                        f.setDescription((String) obj[5]);
                        f.setActive((Boolean) obj[6]);
                        f.setDateadded((Date) obj[7]);
                        Person person = new Person();
                        person.setFirstname((String) obj[8]);
                        person.setLastname((String) obj[9]);
                        f.setPerson2(person);
                        Facilitylevel level = new Facilitylevel();
                        level.setFacilitylevelname((String) obj[10]);
                        level.setShortname((String) obj[11]);
                        f.setFacilitylevelid(level);
                        facilityList.add(f);
                    }
                    model.put("size", facilityList.size());
                }
                boolean showLevel=false;
                if(request.getSession().getAttribute("SessionSearchFacilityActVal")==null){
                    showLevel=true;
                }
                model.put("showLevel", showLevel);
                model.put("facilityList", facilityList);
                model.put("facilityType", "Facility");
                request.getSession().setAttribute("sessReturnSearchedFacilityUrl", "ajaxSubmitData('orgFacilitySettings.htm', 'response', 'act="+activity+"&i="+id+"&b="+strVal+"&c="+strVal2+"&d="+id2+"&ofst="+offset+"&maxR="+maxResults+"&sStr="+searchPhrase+"', 'GET');");
                return new ModelAndView("controlPanel/universalPanel/facility/FacilityRegistration/views/searchedFacility", "model", model);
                        
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        model.put("success", "<span class='text6'>Contact System Administrator :: Page Not Found!</span>");
        return new ModelAndView("response", "model", model);
    }
    
    @RequestMapping(value = "/quickSearchFaciliy.htm", method = RequestMethod.POST)
    public @ResponseBody
    String quickSearchFaciliy(HttpServletRequest request, Model model, @ModelAttribute("sVal") String searchValue) {
        
        logger.info("searchValue ::::: "+searchValue);
        List<Facility> facilityList = new ArrayList();
        List<Object[]> foundFacs = new ArrayList<>();
        
        String[] fields = {"facilityid", "facilityname", "facilitycode", "facilityfunder", "facilitylevelid.facilitylevelname"};
        String where = "";
        if(request.getSession().getAttribute("SessionSearchFacilityActVal")==null){
            String[] params = {};
            Object[] paramsValues = {};
            where = "WHERE LOWER(r.facilityname) LIKE '" + searchValue.toLowerCase() + "%' ORDER BY r.facilityname ASC";
            foundFacs = (List<Object[]>) genericClassService.fetchRecord(Facility.class, fields, where, params, paramsValues);
        }else{
            Facilitylevel levelObj = (Facilitylevel) request.getSession().getAttribute("SessionSearchFacilityActVal");
            String[] params = {"Id"};
            Object[] paramsValues = {levelObj.getFacilitylevelid()};
            where = "WHERE LOWER(r.facilityname) LIKE '" + searchValue.toLowerCase() + "%' AND r.facilitylevelid.facilitylevelid=:Id ORDER BY r.facilityname ASC";
            foundFacs = (List<Object[]>) genericClassService.fetchRecord(Facility.class, fields, where, params, paramsValues);
        }
        if (foundFacs != null) {
            for (Object[] obj : foundFacs) {
                Facility f = new Facility();
                f.setFacilityid((Integer) obj[0]);
                f.setFacilityname((String) obj[1]);
                f.setFacilitycode((String) obj[2]);
                f.setFacilityfunder((String) obj[3]);
                Facilitylevel fl = new Facilitylevel();
                fl.setFacilitylevelname((String)obj[4]);
                f.setFacilitylevelid(fl);
                facilityList.add(f);
            }
        }
        DomainFacilityController parser = new DomainFacilityController(); 
        return parser.facilityToJSON(facilityList);
    }
    
    @RequestMapping(value = "/quickSearchFaciliy2.htm", method = RequestMethod.POST)
    public @ResponseBody
    String quickSearchFaciliy2(HttpServletRequest request, Model model, @ModelAttribute("sVal") String searchValue) {
        
        logger.info("searchValue ::::: "+searchValue);
        List<Facility> facilityList = new ArrayList();
        String[] params = {};
        Object[] paramsValues = {};
        String[] fields = {"facilityid", "facilityname", "facilitycode", "facilityfunder", "facilitylevelid.facilitylevelname"};
        String where = "WHERE r.facility IS NULL AND LOWER(r.facilityname) LIKE '" + searchValue.toLowerCase() + "%' ORDER BY r.facilityname ASC";
        List<Object[]> found = (List<Object[]>) genericClassService.fetchRecord(Facility.class, fields, where, params, paramsValues);

        if (found != null) {
            for (Object[] obj : found) {
                Facility f = new Facility();
                f.setFacilityid((Integer) obj[0]);
                f.setFacilityname((String) obj[1]);
                f.setFacilitycode((String) obj[2]);
                f.setFacilityfunder((String) obj[3]);
                Facilitylevel fl = new Facilitylevel();
                fl.setFacilitylevelname((String)obj[4]);
                f.setFacilitylevelid(fl);
                facilityList.add(f);
            }
        }
        DomainFacilityController parser = new DomainFacilityController();
        return parser.facilityToJSON(facilityList);
    }
    
    /**
     *
     * @param principal
     * @return
     */
    @RequestMapping("/getSearchedFacility.htm")
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView getSearchedFacility(Principal principal, HttpServletRequest request,
            @RequestParam("act") String activity, @RequestParam("i") long id, @RequestParam("d") long id2,
            @RequestParam("b") String strVal, @RequestParam("c") String strVal2,
            @RequestParam("ofst") int offset, @RequestParam("maxR") int maxResults,
            @RequestParam("sStr") String searchPhrase) {
        if (principal == null) {
            return new ModelAndView("refresh");
        }
        Map<String, Object> model = new HashMap<String, Object>();
        model.put("onErrorReturnURL", "ajaxSubmitData('getSearchedFacility.htm', 'summaryPane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');");
        try {
            model.put("act", activity);
            model.put("b", strVal);
            model.put("i", id);
            model.put("c", strVal2);
            model.put("d", id2);
            model.put("ofst", offset);
            model.put("maxR", maxResults);
            model.put("sStr", searchPhrase);

            request.getSession().setAttribute("sessPagingOffSet", offset);
            request.getSession().setAttribute("sessPagingMaxResults", maxResults);
            request.getSession().setAttribute("vsearch", searchPhrase);

            String[] fields = {"facilityid", "facilityname", "facilitycode", "shortname", "active"};
            String[] villField = {"village.villagename", "village.parishid.parishname", "village.parishid.subcountyid.subcountyname", "village.parishid.subcountyid.countyid.countyname", "village.parishid.subcountyid.countyid.districtid.districtname", "village.parishid.subcountyid.countyid.districtid.regionid.regionname"};

            List<Facility> facilityList = new ArrayList<Facility>();
            String where = "";
            String whereLocation = "";
                if (activity.equals("b") || activity.equals("j")) {whereLocation="WHERE r.facilityid=:Id";}
                if (activity.equals("c")){whereLocation = "WHERE r.village.parishid.subcountyid.countyid.districtid.regionid.regionid=:Id";}
                if (activity.equals("d")){whereLocation = "WHERE r.village.parishid.subcountyid.countyid.districtid.districtid=:Id";}
                if (activity.equals("e")){whereLocation = "WHERE r.village.parishid.subcountyid.countyid.countyid=:Id";}
                if (activity.equals("f")){whereLocation = "WHERE r.village.parishid.subcountyid.subcountyid=:Id";}
                if (activity.equals("g")){whereLocation = "WHERE r.village.parishid.parishid=:Id";}
                if (activity.equals("h")){whereLocation = "WHERE r.village.villageid=:Id";}
            
            where = whereLocation + " ORDER BY r.facilityname ASC";    
            
            List<Object[]> facListArr = new ArrayList<Object[]>();
            String[] params = {"Id"};
            Object[] paramsValues = {id};

            if (maxResults == 0) {
                facListArr = (List<Object[]>) genericClassService.fetchRecord(Facility.class, fields, where, params, paramsValues);
            } else {
                int countRecordSet = 0;
                countRecordSet = genericClassService.fetchRecordCount(Facility.class, whereLocation, params, paramsValues);
                offset = ((offset - 1) * maxResults) + 1;
                model.put("offset2", offset);
                if (offset > 0) {
                    offset -= 1;
                }
                if (countRecordSet > maxResults) {
                    model.put("paginate", true);
                    facListArr = (List<Object[]>) genericClassService.fetchRecordPaging(Facility.class, fields, where, params, paramsValues, offset, maxResults);
                } else {
                    model.put("paginate", false);
                    facListArr = (List<Object[]>) genericClassService.fetchRecord(Facility.class, fields, where, params, paramsValues);
                }
                
                model.put("count", countRecordSet);
                int totalPage = (countRecordSet + maxResults - 1) / maxResults;
                model.put("totalPage", totalPage);
            }
            
            if (facListArr != null) { 
                    for (Object[] obj : facListArr) {
                        //{"facilityid", "facilityname", "facilitycode", "district.districtid", "district.districtname", "location", "description", "active", "dateadded", "person1.personname"};
                        Facility f = new Facility((Integer) obj[0]);
                        f.setFacilityname((String) obj[1]);
                        f.setFacilitycode((String) obj[2]);
                        f.setShortname((String) obj[3]);
                        f.setActive((Boolean) obj[4]);
                        List<Object[]> facLevel2Arr = (List<Object[]>) genericClassService.fetchRecord(Facility.class, new String[]{"facilitylevelid.facilitylevelid", "facilitylevelid.facilitylevelname", "facilitylevelid.shortname"}, "WHERE r.facilityid=:Id", new String[]{"Id"}, new Object[]{f.getFacilityid()});
                        if (facLevel2Arr != null) {
                            for (Object[] obj2 : facLevel2Arr) {
                                Facilitylevel l = new Facilitylevel((Integer) obj2[0]);
                                l.setFacilitylevelname((String) obj2[1]);
                                l.setShortname((String) obj2[2]);
                                f.setFacilitylevelid(l);
                            }
                        }
                        if (activity.equals("b") || activity.equals("j")) {
                        List<Object[]> facList2Arr = (List<Object[]>) genericClassService.fetchRecord(Facility.class, villField, "WHERE r.facilityid=:Id", new String[]{"Id"}, new Object[]{f.getFacilityid()});
                            if (facList2Arr != null) {
                                for (Object[] obj2 : facList2Arr) {
                                    Village v = new Village();
                                    v.setVillagename((String) obj2[0]);
                                    Parish p = new Parish();
                                    p.setParishname((String) obj2[1]);
                                    Subcounty sc = new Subcounty();
                                    sc.setSubcountyname((String) obj2[2]);
                                    County c = new County();
                                    c.setCountyname((String) obj2[3]);
                                    District d = new District();
                                    d.setDistrictname((String) obj2[4]);
                                    Region r = new Region();
                                    r.setRegionname((String) obj2[5]);
                                    d.setRegionid(r);
                                    c.setDistrictid(d);
                                    sc.setCountyid(c);
                                    p.setSubcountyid(sc);
                                    v.setParishid(p);
                                    f.setVillage(v);
                                }
                            }
                        }
                        
                        facilityList.add(f);
                    }
                    model.put("size", facilityList.size());
                }
                
                model.put("facilityList", facilityList);
                model.put("facilityType", "Facility");
                request.getSession().setAttribute("sessReturnSearchedFacilityUrl", "ajaxSubmitData('getSearchedFacility.htm', 'summaryPane', 'act="+activity+"&i="+id+"&b="+strVal+"&c="+strVal2+"&d="+id2+"&ofst="+offset+"&maxR="+maxResults+"&sStr="+searchPhrase+"', 'GET');");
                return new ModelAndView("controlPanel/universalPanel/facility/FacilityRegistration/views/searchedFacility2", "model", model);
                        
            
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        model.put("success", "<span class='text6'>Contact System Administrator :: Page Not Found!</span>");
        return new ModelAndView("response", "model", model);
    }
            
    @RequestMapping(value = "/quickSearchFaciliyByTerm.htm", method = RequestMethod.POST)
    public @ResponseBody
    String quickSearchFaciliyByTerm(HttpServletRequest request, Model model, @ModelAttribute("sTerm") String searchTerm, @ModelAttribute("sVal") String searchValue) {
        
        logger.info("searchTerm ::::: "+searchTerm+" searchValue ::::: "+searchValue);
        List<Facility> facilityList = new ArrayList();
        List<Region> regionList = new ArrayList();
        List<District> districtList = new ArrayList();
        List<County> countyList = new ArrayList();
        List<Subcounty> subCountyList = new ArrayList();
        List<Parish> parishList = new ArrayList();
        List<Village> villageList = new ArrayList();
        
        List<Object[]> foundObjs = new ArrayList<>();
        
        if (searchTerm.equals("b")) {
            String[] fields = {"facilityid", "facilityname", "facilitycode", "facilityownerid.ownername", "facilitylevelid.facilitylevelname"};
            String where = "";
                String[] params = {};
                Object[] paramsValues = {};
                where = "WHERE LOWER(r.facilityname) LIKE '" + searchValue.toLowerCase() + "%' ORDER BY r.facilityname ASC";
                foundObjs = (List<Object[]>) genericClassService.fetchRecord(Facility.class, fields, where, params, paramsValues);
            
            if (foundObjs != null) {
                for (Object[] obj : foundObjs) {
                    Facility f = new Facility();
                    f.setFacilityid((Integer) obj[0]);
                    f.setFacilityname((String) obj[1]);
                    f.setFacilitycode((String) obj[2]);
                    Facilityowner owner = new Facilityowner();
                    owner.setOwnername((String) obj[3]);
                    f.setFacilityownerid(owner);
                    Facilitylevel fl = new Facilitylevel();
                    fl.setFacilitylevelname((String) obj[4]);
                    f.setFacilitylevelid(fl);
                    facilityList.add(f);
                }
            }
            DomainFacilityController parser = new DomainFacilityController();
            return parser.facilityToJSON(facilityList);
        }
        if (searchTerm.equals("c")) {
            String[] fields = {"regionid", "regionname"};
            String where = "";
                String[] params = {};
                Object[] paramsValues = {};
                where = "WHERE LOWER(r.regionname) LIKE '" + searchValue.toLowerCase() + "%' ORDER BY r.regionname ASC";
                foundObjs = (List<Object[]>) genericClassService.fetchRecord(Region.class, fields, where, params, paramsValues);
             
            if (foundObjs != null) {
                for (Object[] obj : foundObjs) {
                    Region r = new Region();
                    r.setRegionid((Integer) obj[0]);
                    r.setRegionname((String) obj[1]);
                    regionList.add(r);
                }
            }
            DomainFacilityController parser = new DomainFacilityController();
            return parser.regionToJSON(regionList);
        }
        if (searchTerm.equals("d")) {
            String[] fields = {"districtid", "districtname","regionid.regionid", "regionid.regionname"};
            String where = "";
                String[] params = {};
                Object[] paramsValues = {};
                where = "WHERE LOWER(r.districtname) LIKE '" + searchValue.toLowerCase() + "%' ORDER BY r.districtname ASC";
                foundObjs = (List<Object[]>) genericClassService.fetchRecord(District.class, fields, where, params, paramsValues);
             
            if (foundObjs != null) {
                for (Object[] obj : foundObjs) {
                    District d = new District();
                    d.setDistrictid((Integer) obj[0]);
                    d.setDistrictname((String) obj[1]);
                    Region r = new Region();
                    r.setRegionid((Integer) obj[2]);
                    r.setRegionname((String) obj[3]);
                    d.setRegionid(r);
                    districtList.add(d);
                }
            }
            DomainFacilityController parser = new DomainFacilityController();
            return parser.districtToJSON(districtList);
        }
        if (searchTerm.equals("e")) {
            String[] fields = {"countyid", "countyname","districtid.districtid", "districtid.districtname","districtid.regionid.regionid", "districtid.regionid.regionname"};
            String where = "";
                String[] params = {};
                Object[] paramsValues = {};
                where = "WHERE LOWER(r.countyname) LIKE '" + searchValue.toLowerCase() + "%' ORDER BY r.countyname ASC";
                foundObjs = (List<Object[]>) genericClassService.fetchRecord(County.class, fields, where, params, paramsValues);
             
            if (foundObjs != null) {
                for (Object[] obj : foundObjs) {
                    County c = new County();
                    c.setCountyid((Integer) obj[0]);
                    c.setCountyname((String) obj[1]);
                    District d = new District();
                    d.setDistrictid((Integer) obj[2]);
                    d.setDistrictname((String) obj[3]);
                    Region r = new Region();
                    r.setRegionid((Integer) obj[4]);
                    r.setRegionname((String) obj[5]);
                    d.setRegionid(r);
                    c.setDistrictid(d);
                    countyList.add(c);
                }
            }
            DomainFacilityController parser = new DomainFacilityController();
            return parser.countyToJSON(countyList);
        }
        if (searchTerm.equals("f")) {
            String[] fields = {"subcountyid", "subcountyname", "countyid.countyid", "countyid.countyname", "countyid.districtid.districtid", "countyid.districtid.districtname","countyid.districtid.regionid.regionid", "countyid.districtid.regionid.regionname"};
            String where = "";
                String[] params = {};
                Object[] paramsValues = {};
                where = "WHERE LOWER(r.subcountyname) LIKE '" + searchValue.toLowerCase() + "%' ORDER BY r.subcountyname ASC";
                foundObjs = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, fields, where, params, paramsValues);
             
            if (foundObjs != null) {
                for (Object[] obj : foundObjs) {
                    Subcounty sc = new Subcounty();
                    sc.setSubcountyid((Integer) obj[0]);
                    sc.setSubcountyname((String) obj[1]);
                    County c = new County();
                    c.setCountyid((Integer) obj[2]);
                    c.setCountyname((String) obj[3]);
                    District d = new District();
                    d.setDistrictid((Integer) obj[4]);
                    d.setDistrictname((String) obj[5]);
                    Region r = new Region();
                    r.setRegionid((Integer) obj[6]);
                    r.setRegionname((String) obj[7]);
                    d.setRegionid(r);
                    c.setDistrictid(d);
                    sc.setCountyid(c);
                    subCountyList.add(sc);
                }
            }
            DomainFacilityController parser = new DomainFacilityController();
            return parser.subcountyToJSON(subCountyList);
        }
        
        if (searchTerm.equals("g")) {
            String[] fields = {"parishid", "parishname", "subcountyid.subcountyid", "subcountyid.subcountyname", "subcountyid.countyid.countyid", "subcountyid.countyid.countyname", "subcountyid.countyid.districtid.districtid", "subcountyid.countyid.districtid.districtname","subcountyid.countyid.districtid.regionid.regionid", "subcountyid.countyid.districtid.regionid.regionname"};
            String where = "";
                String[] params = {};
                Object[] paramsValues = {};
                where = "WHERE LOWER(r.parishname) LIKE '" + searchValue.toLowerCase() + "%' ORDER BY r.parishname ASC";
                foundObjs = (List<Object[]>) genericClassService.fetchRecord(Parish.class, fields, where, params, paramsValues);
             
            if (foundObjs != null) {
                for (Object[] obj : foundObjs) {
                    Parish p = new Parish();
                    p.setParishid((Integer) obj[0]);
                    p.setParishname((String) obj[1]);
                    Subcounty sc = new Subcounty();
                    sc.setSubcountyid((Integer) obj[2]);
                    sc.setSubcountyname((String) obj[3]);
                    County c = new County();
                    c.setCountyid((Integer) obj[4]);
                    c.setCountyname((String) obj[5]);
                    District d = new District();
                    d.setDistrictid((Integer) obj[6]);
                    d.setDistrictname((String) obj[7]);
                    Region r = new Region();
                    r.setRegionid((Integer) obj[8]);
                    r.setRegionname((String) obj[9]);
                    d.setRegionid(r);
                    c.setDistrictid(d);
                    sc.setCountyid(c);
                    p.setSubcountyid(sc);
                    parishList.add(p);
                }
            }
            DomainFacilityController parser = new DomainFacilityController();
            return parser.parishToJSON(parishList);
        }
        if (searchTerm.equals("h")) {
            String[] fields = {"villageid", "villagename", "parishid.parishid", "parishid.parishname", "parishid.subcountyid.subcountyid", "parishid.subcountyid.subcountyname", "parishid.subcountyid.countyid.countyid", "parishid.subcountyid.countyid.countyname", "parishid.subcountyid.countyid.districtid.districtid", "parishid.subcountyid.countyid.districtid.districtname","parishid.subcountyid.countyid.districtid.regionid.regionid", "parishid.subcountyid.countyid.districtid.regionid.regionname"};
            String where = "";
                String[] params = {};
                Object[] paramsValues = {};
                where = "WHERE LOWER(r.villagename) LIKE '" + searchValue.toLowerCase() + "%' ORDER BY r.villagename ASC";
                foundObjs = (List<Object[]>) genericClassService.fetchRecord(Village.class, fields, where, params, paramsValues);
             
            if (foundObjs != null) {
                for (Object[] obj : foundObjs) {
                    Village v = new Village();
                    v.setVillageid((Integer) obj[0]);
                    v.setVillagename((String) obj[1]);
                    Parish p = new Parish();
                    p.setParishid((Integer) obj[2]);
                    p.setParishname((String) obj[3]);
                    Subcounty sc = new Subcounty();
                    sc.setSubcountyid((Integer) obj[4]);
                    sc.setSubcountyname((String) obj[5]);
                    County c = new County();
                    c.setCountyid((Integer) obj[6]);
                    c.setCountyname((String) obj[7]);
                    District d = new District();
                    d.setDistrictid((Integer) obj[8]);
                    d.setDistrictname((String) obj[9]);
                    Region r = new Region();
                    r.setRegionid((Integer) obj[10]);
                    r.setRegionname((String) obj[11]);
                    d.setRegionid(r);
                    c.setDistrictid(d);
                    sc.setCountyid(c);
                    p.setSubcountyid(sc);
                    v.setParishid(p);
                    villageList.add(v);
                }
            }
            DomainFacilityController parser = new DomainFacilityController();
            return parser.villageToJSON(villageList);
        }
        if (searchTerm.equals("j")) {
            String[] params = {"value"};
            Object[] paramsValues = {searchValue.trim().toLowerCase() + "%"};
            String[] fields = {"facilityid", "facilityname", "facilitycode", "facilitylevelname"};
            String where = "WHERE (LOWER(facilityname) LIKE :value OR LOWER(facilitycode) LIKE :value OR LOWER(facilitylevelname) LIKE :value OR LOWER(shortname) LIKE :value OR LOWER(villagename) LIKE :value OR LOWER(parishname) LIKE :value OR LOWER(subcountyname) LIKE :value OR LOWER(countyname) LIKE :value OR LOWER(emailaddress) LIKE :value OR LOWER(phonecontact) LIKE :value OR LOWER(phonecontact2) LIKE :value OR LOWER(postaddress) LIKE :value) ORDER BY facilityname";
            List<Object[]> facilityArrList = (List<Object[]>) genericClassService.fetchRecord(Searchfacility.class, fields, where, params, paramsValues);
            if (facilityArrList != null) {
                for (Object[] obj : facilityArrList) {
                    Facility f = new Facility();
                    f.setFacilityid((Integer) obj[0]);
                    f.setFacilityname((String) obj[1]);
                    f.setFacilitycode((String) obj[2]);
                    Facilitylevel fl = new Facilitylevel();
                    fl.setFacilitylevelname((String) obj[3]);
                    f.setFacilitylevelid(fl);
                    facilityList.add(f);
                }
            }
            DomainFacilityController parser = new DomainFacilityController();
            return parser.quickFacilityToJSON(facilityList);
        }
        
        DomainFacilityController parser = new DomainFacilityController();
        return parser.facilityToJSON(facilityList);
    }
    
    public String facilityToJSON(List<Facility> list) {
        String response = "[";
        int size = list.size();
        if (size > 0) {
            for (int x = 0; x < size - 1; x++) {
                String funder=list.get(x).getFacilityownerid().getOwnername();
                if(funder==null || funder.isEmpty()){
                    funder="Not Set!";
                }
                response += "{\"id\":\"" + list.get(x).getFacilityid()+ "\",\"name\":\"" + list.get(x).getFacilityname()+ "\",\"code\":\"" + list.get(x).getFacilitycode()+ "\",\"funder\":\"" +funder+ "\",\"level\":\"" +list.get(x).getFacilitylevelid().getFacilitylevelname()+ "\"},";
            }
            String funder=list.get(size - 1).getFacilityownerid().getOwnername();
            if(funder==null || funder.isEmpty()){
                funder="Not Set!";
            }
            response += "{\"id\":\"" + list.get(size - 1).getFacilityid() + "\",\"name\":\"" + list.get(size - 1).getFacilityname() + "\",\"code\":\"" + list.get(size - 1).getFacilitycode()+ "\",\"funder\":\"" + funder+ "\",\"level\":\"" + list.get(size - 1).getFacilitylevelid().getFacilitylevelname()+ "\"}";
        }
        response += "]";
        logger.info("Response ::::: response:"+response);
        return response;
    }
    public String quickFacilityToJSON(List<Facility> list) {
        String response = "[";
        int size = list.size();
        if (size > 0) {
            for (int x = 0; x < size - 1; x++) {
                response += "{\"id\":\"" + list.get(x).getFacilityid()+ "\",\"name\":\"" + list.get(x).getFacilityname()+ "\",\"code\":\"" + list.get(x).getFacilitycode()+ "\",\"level\":\"" +list.get(x).getFacilitylevelid().getFacilitylevelname()+ "\"},";
            }
            response += "{\"id\":\"" + list.get(size - 1).getFacilityid() + "\",\"name\":\"" + list.get(size - 1).getFacilityname() + "\",\"code\":\"" + list.get(size - 1).getFacilitycode()+ "\",\"level\":\"" + list.get(size - 1).getFacilitylevelid().getFacilitylevelname()+ "\"}";
        }
        response += "]";
        logger.info("Response ::::: response:"+response);
        return response;
    }
    public String regionToJSON(List<Region> list) {
        String response = "[";
        int size = list.size();
        if (size > 0) {
            for (int x = 0; x < size - 1; x++) {
                response += "{\"id\":\"" + list.get(x).getRegionid()+ "\",\"name\":\"" + list.get(x).getRegionname()+ "\"},";
            }
            response += "{\"id\":\"" + list.get(size - 1).getRegionid() + "\",\"name\":\"" + list.get(size - 1).getRegionname() + "\"}";
        }
        response += "]";
        logger.info("Response ::::: Region:"+response);
        return response;
    }
    
    public String districtToJSON(List<District> list) {
        String response = "[";
        int size = list.size();
        if (size > 0) {
            for (int x = 0; x < size - 1; x++) {
                response += "{\"id\":\"" + list.get(x).getDistrictid()+ "\",\"name\":\"" + list.get(x).getDistrictname()+ "\",\"region\":\"" + list.get(x).getRegionid().getRegionname()+ "\"},";
            }
            response += "{\"id\":\"" + list.get(size - 1).getDistrictid() + "\",\"name\":\"" + list.get(size - 1).getDistrictname() + "\",\"region\":\"" + list.get(size - 1).getRegionid().getRegionname()+ "\"}";
        }
        response += "]";
        logger.info("Response ::::: District:"+response);
        return response;
    }
    
    public String countyToJSON(List<County> list) {
        String response = "[";
        int size = list.size();
        if (size > 0) {
            for (int x = 0; x < size - 1; x++) {
                response += "{\"id\":\"" + list.get(x).getCountyid()+ "\",\"name\":\"" + list.get(x).getCountyname()+ "\",\"district\":\"" + list.get(x).getDistrictid().getDistrictname()+ "\",\"region\":\"" + list.get(x).getDistrictid().getRegionid().getRegionname()+ "\"},";
            }
            response += "{\"id\":\"" + list.get(size - 1).getCountyid() + "\",\"name\":\"" + list.get(size - 1).getCountyname() + "\",\"district\":\"" + list.get(size - 1).getDistrictid().getDistrictname()+ "\",\"region\":\"" + list.get(size - 1).getDistrictid().getRegionid().getRegionname()+ "\"}";
        }
        response += "]";
        logger.info("Response ::::: County:"+response);
        return response;
    }
    
    public String subcountyToJSON(List<Subcounty> list) {
        String response = "[";
        int size = list.size();
        if (size > 0) {
            for (int x = 0; x < size - 1; x++) {
                response += "{\"id\":\"" + list.get(x).getSubcountyid()+ "\",\"name\":\"" + list.get(x).getSubcountyname()+ "\",\"county\":\"" + list.get(x).getCountyid().getCountyname()+ "\",\"district\":\"" + list.get(x).getCountyid().getDistrictid().getDistrictname()+ "\",\"region\":\"" + list.get(x).getCountyid().getDistrictid().getRegionid().getRegionname()+ "\"},";
            }
            response += "{\"id\":\"" + list.get(size - 1).getSubcountyid() + "\",\"name\":\"" + list.get(size - 1).getSubcountyname() + "\",\"county\":\"" + list.get(size - 1).getCountyid().getCountyname()+ "\",\"district\":\"" + list.get(size - 1).getCountyid().getDistrictid().getDistrictname()+ "\",\"region\":\"" + list.get(size - 1).getCountyid().getDistrictid().getRegionid().getRegionname()+ "\"}";
        }
        response += "]";
        logger.info("Response ::::: Sub-County:"+response);
        return response;
    }
    
    public String parishToJSON(List<Parish> list) {
        String response = "[";
        int size = list.size();
        if (size > 0) {
            for (int x = 0; x < size - 1; x++) {
                response += "{\"id\":\"" + list.get(x).getParishid()+ "\",\"name\":\"" + list.get(x).getParishname()+ "\",\"subcounty\":\"" + list.get(x).getSubcountyid().getSubcountyname()+ "\",\"county\":\"" + list.get(x).getSubcountyid().getCountyid().getCountyname()+ "\",\"district\":\"" + list.get(x).getSubcountyid().getCountyid().getDistrictid().getDistrictname()+ "\",\"region\":\"" + list.get(x).getSubcountyid().getCountyid().getDistrictid().getRegionid().getRegionname()+ "\"},";
            }
            response += "{\"id\":\"" + list.get(size - 1).getParishid() + "\",\"name\":\"" + list.get(size - 1).getParishname() + "\",\"subcounty\":\"" + list.get(size - 1).getSubcountyid().getSubcountyname()+ "\",\"county\":\"" + list.get(size - 1).getSubcountyid().getCountyid().getCountyname()+ "\",\"district\":\"" + list.get(size - 1).getSubcountyid().getCountyid().getDistrictid().getDistrictname()+ "\",\"region\":\"" + list.get(size - 1).getSubcountyid().getCountyid().getDistrictid().getRegionid().getRegionname()+ "\"}";
        }
        response += "]";
        logger.info("Response ::::: Parish:"+response);
        return response;
    }
    
    public String villageToJSON(List<Village> list) {
        String response = "[";
        int size = list.size();
        if (size > 0) {
            for (int x = 0; x < size - 1; x++) {
                response += "{\"id\":\"" + list.get(x).getVillageid()+ "\",\"name\":\"" + list.get(x).getVillagename()+ "\",\"parish\":\"" + list.get(x).getParishid().getParishname()+ "\",\"subcounty\":\"" + list.get(x).getParishid().getSubcountyid().getSubcountyname()+ "\",\"county\":\"" + list.get(x).getParishid().getSubcountyid().getCountyid().getCountyname()+ "\",\"district\":\"" + list.get(x).getParishid().getSubcountyid().getCountyid().getDistrictid().getDistrictname()+ "\",\"region\":\"" + list.get(x).getParishid().getSubcountyid().getCountyid().getDistrictid().getRegionid().getRegionname()+ "\"},";
            }
            response += "{\"id\":\"" + list.get(size - 1).getVillageid() + "\",\"name\":\"" + list.get(size - 1).getVillagename() + "\",\"parish\":\"" + list.get(size - 1).getParishid().getParishname()+ "\",\"subcounty\":\"" + list.get(size - 1).getParishid().getSubcountyid().getSubcountyname()+ "\",\"county\":\"" + list.get(size - 1).getParishid().getSubcountyid().getCountyid().getCountyname()+ "\",\"district\":\"" + list.get(size - 1).getParishid().getSubcountyid().getCountyid().getDistrictid().getDistrictname()+ "\",\"region\":\"" + list.get(size - 1).getParishid().getSubcountyid().getCountyid().getDistrictid().getRegionid().getRegionname()+ "\"}";
        }
        response += "]";
        logger.info("Response ::::: Village:"+response);
        return response;
    }

    /**
     *
     * @param principal
     * @return
     */
    @RequestMapping("/locationsLoader.htm")
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView locationsLoader(Principal principal, HttpServletRequest request,
            @RequestParam("act") String activity, @RequestParam("i") long id, @RequestParam("d") long id2,
            @RequestParam("b") String strVal, @RequestParam("c") String strVal2,
            @RequestParam("ofst") int offset, @RequestParam("maxR") int maxResults,
            @RequestParam("sStr") String searchPhrase) {
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
            model.put("ofst", offset);
            model.put("maxR", maxResults);
            model.put("sStr", searchPhrase);
            
            request.getSession().setAttribute("sessPagingOffSet", offset);
            request.getSession().setAttribute("sessPagingMaxResults", maxResults);
            request.getSession().setAttribute("vsearch", searchPhrase);
            
            logger.info("Selected Activity ::::::: "+activity+" strVal :::::: "+strVal);
            String tabAct=request.getSession().getAttribute("sessTabActivity").toString();
            if (activity.equals("a")) {
                List<Object[]> districtArr = new ArrayList<>();
                if (tabAct.equals("a")) {
                    districtArr = (List<Object[]>) genericClassService.fetchRecord(District.class, new String[]{"districtid", "districtname"}, "WHERE r.regionid.regionid=:Id", new String[]{"Id"}, new Object[]{id});
                }
                if (tabAct.equals("a2")) {
                    String where="";
                    if(request.getSession().getAttribute("SessionSearchFacilityActVal")==null){
                        where="WHERE r.districtid IN (SELECT l.village.parishid.subcountyid.countyid.districtid.districtid FROM Facility l WHERE l.village.parishid.subcountyid.countyid.districtid.regionid.regionid=:Id)";
                        districtArr = (List<Object[]>) genericClassService.fetchRecord(District.class, new String[]{"districtid", "districtname"}, where+" ORDER BY r.districtname ASC", new String[]{"Id"}, new Object[]{id});
                    }else{
                        Facilitylevel levelObj = (Facilitylevel) request.getSession().getAttribute("SessionSearchFacilityActVal");
                        String[] params = {"Id","locId"};
                        Object[] paramsValues = {levelObj.getFacilitylevelid(),id};
                        where="WHERE r.districtid IN (SELECT l.village.parishid.subcountyid.countyid.districtid.districtid FROM Facility l WHERE l.village.parishid.subcountyid.countyid.districtid.regionid.regionid=:locId AND l.facilitylevelid.facilitylevelid=:Id)";
                        districtArr = (List<Object[]>) genericClassService.fetchRecord(District.class, new String[]{"districtid", "districtname"}, where+" ORDER BY r.districtname ASC", params, paramsValues);
                    }
                }
                if (districtArr != null) {
                    model.put("districtSize", districtArr.size());
                }
                model.put("formActivity", "AssetReg-District");
                model.put("districts", districtArr);
            }
            if (activity.equals("b")) {
                List<Object[]> countyArr = new ArrayList<>();
                if (tabAct.equals("a")) {
                    countyArr = (List<Object[]>) genericClassService.fetchRecord(County.class, new String[]{"countyid", "countyname"}, "WHERE r.districtid.districtid=:Id", new String[]{"Id"}, new Object[]{id});
                }
                if (tabAct.equals("a2")) {
                    String where="";
                    if(request.getSession().getAttribute("SessionSearchFacilityActVal")==null){
                        where="WHERE r.countyid IN (SELECT l.village.parishid.subcountyid.countyid.countyid FROM Facility l WHERE l.village.parishid.subcountyid.countyid.districtid.districtid=:Id)";
                        countyArr = (List<Object[]>) genericClassService.fetchRecord(County.class, new String[]{"countyid", "countyname"}, where+" ORDER BY r.countyname ASC", new String[]{"Id"}, new Object[]{id});
                    }else{
                        Facilitylevel levelObj = (Facilitylevel) request.getSession().getAttribute("SessionSearchFacilityActVal");
                        String[] params = {"Id","locId"};
                        Object[] paramsValues = {levelObj.getFacilitylevelid(),id};
                        where="WHERE r.countyid IN (SELECT l.village.parishid.subcountyid.countyid.countyid FROM Facility l WHERE l.village.parishid.subcountyid.countyid.districtid.districtid=:locId AND l.facilitylevelid.facilitylevelid=:Id)";
                        countyArr = (List<Object[]>) genericClassService.fetchRecord(County.class, new String[]{"countyid", "countyname"}, where+" ORDER BY r.countyname ASC", params, paramsValues);
                    }
                }
                if (countyArr != null) {
                    model.put("countySize", countyArr.size());
                }
                model.put("formActivity", "AssetReg-County");
                model.put("countys", countyArr);
            }
            if (activity.equals("c")) {
                List<Object[]> subCtyArr = new ArrayList<>();
                if (tabAct.equals("a")) {
                    subCtyArr = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, new String[]{"subcountyid", "subcountyname"}, "WHERE r.countyid.countyid=:Id", new String[]{"Id"}, new Object[]{id});
                }
                if (tabAct.equals("a2")) {
                    String where="";
                    if(request.getSession().getAttribute("SessionSearchFacilityActVal")==null){
                        where="WHERE r.subcountyid IN (SELECT l.village.parishid.subcountyid.subcountyid FROM Facility l WHERE l.village.parishid.subcountyid.countyid.countyid=:Id)";
                        subCtyArr = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, new String[]{"subcountyid", "subcountyname"}, where+" ORDER BY r.subcountyname ASC", new String[]{"Id"}, new Object[]{id});
                    }else{
                        Facilitylevel levelObj = (Facilitylevel) request.getSession().getAttribute("SessionSearchFacilityActVal");
                        String[] params = {"Id","locId"};
                        Object[] paramsValues = {levelObj.getFacilitylevelid(),id};
                        where="WHERE r.subcountyid IN (SELECT l.village.parishid.subcountyid.subcountyid FROM Facility l WHERE l.village.parishid.subcountyid.countyid.countyid=:locId AND l.facilitylevelid.facilitylevelid=:Id)";
                        subCtyArr = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, new String[]{"subcountyid", "subcountyname"}, where+" ORDER BY r.subcountyname ASC", params, paramsValues);
                    }
                }
                if (subCtyArr != null) {
                    model.put("subcountySize", subCtyArr.size());
                }
                model.put("formActivity", "AssetReg-SubCounty");
                model.put("subcountys", subCtyArr);
            }
            if (activity.equals("d")) {
                List<Object[]> parishArr = new ArrayList<>();
                if (tabAct.equals("a")) {
                    parishArr = (List<Object[]>) genericClassService.fetchRecord(Parish.class, new String[]{"parishid", "parishname"}, "WHERE r.subcountyid.subcountyid=:Id", new String[]{"Id"}, new Object[]{id});
                }
                if (tabAct.equals("a2")) {
                    String where="";
                    if(request.getSession().getAttribute("SessionSearchFacilityActVal")==null){
                        where="WHERE r.parishid IN (SELECT l.village.parishid.parishid FROM Facility l WHERE l.village.parishid.subcountyid.subcountyid=:Id)";
                        parishArr = (List<Object[]>) genericClassService.fetchRecord(Parish.class, new String[]{"parishid", "parishname"}, where+" ORDER BY r.parishname ASC", new String[]{"Id"}, new Object[]{id});
                    }else{
                        Facilitylevel levelObj = (Facilitylevel) request.getSession().getAttribute("SessionSearchFacilityActVal");
                        String[] params = {"Id","locId"};
                        Object[] paramsValues = {levelObj.getFacilitylevelid(),id};
                        where="WHERE r.parishid IN (SELECT l.village.parishid.parishid FROM Facility l WHERE l.village.parishid.subcountyid.subcountyid=:locId AND l.facilitylevelid.facilitylevelid=:Id)";
                        parishArr = (List<Object[]>) genericClassService.fetchRecord(Parish.class, new String[]{"parishid", "parishname"}, where+" ORDER BY r.parishname ASC", params, paramsValues);
                    }
                }
                if (parishArr != null) {
                    model.put("parishSize", parishArr.size());
                }
                model.put("formActivity", "AssetReg-Parish");
                model.put("parish", parishArr);
            }
            if (activity.equals("e")) {
                List<Object[]> villagesArr = new ArrayList<>();
                if (tabAct.equals("a")) {
                    villagesArr = (List<Object[]>) genericClassService.fetchRecord(Village.class, new String[]{"villageid", "villagename"}, "WHERE r.parishid.parishid=:Id ORDER BY r.villagename ASC", new String[]{"Id"}, new Object[]{id});
                }
                if (tabAct.equals("a2")) {
                    String where="";
                    if(request.getSession().getAttribute("SessionSearchFacilityActVal")==null){
                        where="WHERE r.villageid IN (SELECT l.village.villageid FROM Facility l WHERE l.village.parishid.parishid=:Id)";
                        villagesArr = (List<Object[]>) genericClassService.fetchRecord(Village.class, new String[]{"villageid", "villagename"}, where+" ORDER BY r.villagename ASC", new String[]{"Id"}, new Object[]{id});
                    }else{
                        Facilitylevel levelObj = (Facilitylevel) request.getSession().getAttribute("SessionSearchFacilityActVal");
                        String[] params = {"Id","locId"};
                        Object[] paramsValues = {levelObj.getFacilitylevelid(),id};
                        where="WHERE r.villageid IN (SELECT l.village.villageid FROM Facility l WHERE l.village.parishid.parishid=:locId AND l.facilitylevelid.facilitylevelid=:Id)";
                        villagesArr = (List<Object[]>) genericClassService.fetchRecord(Village.class, new String[]{"villageid", "villagename"}, where+" ORDER BY r.villagename ASC", params, paramsValues);
                    }
                }
                if (villagesArr != null) {
                    model.put("villageSize", villagesArr.size());
                }
                model.put("formActivity", "AssetReg-Village");
                model.put("villages", villagesArr);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        model.put("success", "<span class='text6'>Contact System Administrator :: Page Not Found!</span>");
        return new ModelAndView("controlPanel/universalPanel/facility/FacilityRegistration/forms/locations", "model", model);
    }

    /**
     *
     * @param request
     * @param principal
     * @return
     */
    @RequestMapping(value = "/registerFacility.htm", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView registerFacility(HttpServletRequest request, Principal principal) {
        logger.info("Received Request To Add Facility");
        Map<String, Object> model = new HashMap<String, Object>();
        Facility facility = new Facility();
        try {
            if (principal == null) {
                return new ModelAndView("refresh");
            }
            int facilityid = 0;
            boolean updateActivity = false;
            if (request.getParameter("cref") != null && !request.getParameter("cref").isEmpty()) {
                facilityid = Integer.parseInt(request.getParameter("cref"));
                updateActivity = true;
            }

            int facilitylevelid = Integer.parseInt(request.getParameter("level"));
            String fname = request.getParameter("facilityname");
            String sname = request.getParameter("shortname");
            String facilitycode = request.getParameter("facilitycode");
            String owner = request.getParameter("owner");
            String village = request.getParameter("village");
            String location = request.getParameter("location");
            String description = request.getParameter("description");
            String telContact = request.getParameter("telContact");
            String telContact2 = request.getParameter("telContact2");
            String emailContact = request.getParameter("emailContact");
            String website = request.getParameter("website");
            String postaddress = request.getParameter("postaddress");
            boolean hasdept = Boolean.parseBoolean(request.getParameter("hasDept"));
            boolean isActive = Boolean.parseBoolean(request.getParameter("status"));
            String facilitylogourl = "";
            if(request.getSession().getAttribute("sessionRefAttachedImageRef")!=null){
                facilitylogourl = request.getSession().getAttribute("sessionRefAttachedImageRef").toString();
            }
            if(telContact2!=null && !telContact2.isEmpty() && telContact2!=""){
                telContact+="; "+telContact2;
            }
            
            String facilityname = "";
            BreakIterator wordBreaker = BreakIterator.getWordInstance();
            String str = fname.trim();
            wordBreaker.setText(str);
            int end = 0;
            for (int start = wordBreaker.first();
                    (end = wordBreaker.next()) != BreakIterator.DONE; start = end) {
                String word = str.substring(start, end);
                String joined_word = word.substring(0, 1).toUpperCase() + word.substring(1).toLowerCase();
                if (end != 0) {
                    facilityname += joined_word;
                }
            }
            
            logger.info("updateActivity ::: " + updateActivity);

            if(facilitycode==null || facilitycode.isEmpty()){
                Calendar calendar = Calendar.getInstance(TimeZone.getDefault());
                int year = calendar.get(Calendar.YEAR);
                int countRecordSet = genericClassService.fetchRecordCount(Facility.class, "", new String[]{}, new Object[]{});
                String dummycode = "IICS/"+year+"/HF"+(countRecordSet+1);
                facilitycode=dummycode;
                logger.info("Generated Facility Code " + dummycode);
            }
            Facilitylevel facilitylevel = new Facilitylevel();
            String[] params = {"levelId"};
            Object[] paramsValues = {facilitylevelid};
            String[] fields = {"facilitylevelid", "shortname", "facilitylevelname", "description"};
            List<Object[]> levelList = (List<Object[]>) genericClassService.fetchRecord(Facilitylevel.class, fields, "WHERE r.facilitylevelid=:levelId", params, paramsValues);
            if (levelList != null) {
                for (Object[] obj : levelList) {
                    facilitylevel.setFacilitylevelid((Integer) obj[0]);
                    facilitylevel.setShortname((String) obj[1]);
                    facilitylevel.setFacilitylevelname((String) obj[2]);
                    facilitylevel.setDescription((String) obj[3]);
                }
            }
            
            String[] param2 = {"name", "code"};
            Object[] paramsValue2 = {facilityname, facilitycode};
            String[] field2 = {"facilityid", "facilityname", "facilitycode", "description"};
            List<Object[]> existingFacilityList = (List<Object[]>) genericClassService.fetchRecord(Facility.class, field2, "WHERE r.facilityname=:name AND r.facilitycode=:code", param2, paramsValue2);
            if (existingFacilityList != null) {
                boolean exist = false;
                List<Facility> existingList = new ArrayList<Facility>();
                for (Object[] obj : existingFacilityList) {
                    Facility facObj = new Facility((Integer) obj[0]);
                    facObj.setFacilityname((String) obj[1]);
                    facObj.setFacilitycode((String) obj[2]);
                    facObj.setDescription((String) obj[3]);
                    
                    existingList.add(facObj);
                    exist = true;
                    if ((int) facilityid == (Integer) obj[0]) {
                        exist = false;
                    }
                }
                model.put("resp", false);
                model.put("errorMessage", "Already Existing Facility");
                model.put("facilityList", existingList);
                if (exist == true) {
                    model.put("mainActivity", "Facility");
                    return new ModelAndView("controlPanel/universalPanel/facility/FacilityRegistration/views/response", "model", model);
                }
            }

            List<Facility> existingList = new ArrayList<Facility>();
            long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
            facility.setFacilityname(facilityname);
            facility.setShortname(sname);
            facility.setFacilitycode(facilitycode);
            facility.setFacilitylevelid(facilitylevel);
            if (owner != null && !owner.isEmpty() && !owner.equals("0")) {
                facility.setFacilityownerid(new Facilityowner(Integer.parseInt(owner)));
            }
            if (village != null && !village.isEmpty() && !village.equals("0")) {
                facility.setVillage(new Village(Integer.parseInt(village)));
            }
            facility.setLocation(location);
            facility.setDescription(description);
            facility.setPhonecontact(telContact);
            facility.setEmailaddress(emailContact);
            facility.setWebsite(website);
            facility.setPostaddress(postaddress);
            facility.setFacilitylogourl(facilitylogourl);
            facility.setHasdepartments(hasdept);
            facility.setStatus("PENDING");
            
            if (updateActivity == false) {
                facility.setActive(isActive);
                facility.setDateadded(new Date());
                facility.setPerson2(new Person(pid));
            } else {
                facility.setActive(isActive);
                facility.setFacilityid(facilityid);
                facility.setDateupdated(new Date());
                facility.setPerson(new Person(pid));
            }

            if (updateActivity == false) {
                genericClassService.saveOrUpdateRecordLoadObject(facility);
                List<Object[]> addedFacObjArr = (List<Object[]>) genericClassService.fetchRecord(Facility.class, new String[]{"facilityid"}, "WHERE r.facilityid=:Id", new String[]{"Id"}, new Object[]{facility.getFacilityid()});
                if (addedFacObjArr != null && !addedFacObjArr.isEmpty()) {

                    Facility fac = new Facility();
                    String[] field1 = {"facilityid", "facilityname", "facilitycode", "shortname", "location", "description", "active", "dateadded", "person2.firstname", "person2.lastname", "facilitylevelid.facilitylevelid", "facilitylevelid.facilitylevelname",
                        "hasdepartments", "phonecontact", "emailaddress", "postaddress", "facilitylogourl","facilityownerid.facilityownerid","facilityownerid.ownername"};
                    String[] villField = {"village.villagename", "village.parishid.parishname", "village.parishid.subcountyid.subcountyname", "village.parishid.subcountyid.countyid.countyname", "village.parishid.subcountyid.countyid.districtid.districtname", "village.parishid.subcountyid.countyid.districtid.regionid.regionname"};

                    List<Object[]> facListArr = (List<Object[]>) genericClassService.fetchRecord(Facility.class, field1, "WHERE r.facilityid=:Id", new String[]{"Id"}, new Object[]{facility.getFacilityid()});
                    if (facListArr != null) {
                        for (Object[] obj : facListArr) {
                            //"facilityid", "facilityname", "facilitycode", "shortname", "location", "description", "active", "dateadded", "person2.firstname","person2.lastname", "facilitylevel.facilitylevelid", "facilitylevel.facilitylevelname",
                            fac.setFacilityid((Integer) obj[0]);
                            fac.setFacilityname((String) obj[1]);
                            fac.setFacilitycode((String) obj[2]);
                            fac.setShortname((String) obj[3]);
                            fac.setLocation((String) obj[4]);
                            fac.setDescription((String) obj[5]);
                            fac.setActive((Boolean) obj[6]);
                            fac.setDateadded((Date) obj[7]);
                            Person person2 = new Person();
                            person2.setFirstname((String) obj[8]);
                            person2.setLastname((String) obj[9]);
                            fac.setPerson2(person2);
                            Facilitylevel fl = new Facilitylevel((Integer) obj[10]);
                            fl.setFacilitylevelname((String) obj[11]);
                            fac.setFacilitylevelid(fl);
//
                            fac.setHasdepartments((Boolean) obj[12]);
                            String phone=(String) obj[13];
                            fac.setPhonecontact(phone);
                            fac.setEmailaddress((String) obj[14]);
                            fac.setPostaddress((String) obj[15]);
                            fac.setFacilitylogourl((String) obj[16]);
                            
                            Facilityowner ownerObj = new Facilityowner();
                            ownerObj.setFacilityownerid((Integer) obj[17]);
                            ownerObj.setOwnername((String) obj[18]);
                            fac.setFacilityownerid(ownerObj);
                            
//                            "village.villagename", "village.parish.parishname", "village.parish.subcounty.subcountyname", "village.parish.subcounty.county.countyname", "village.parish.subcounty.county.district.districtname", "village.parish.subcounty.county.district.region.regionname"};
                            List<Object[]> facList2Arr = (List<Object[]>) genericClassService.fetchRecord(Facility.class, villField, "WHERE r.facilityid=:Id", new String[]{"Id"}, new Object[]{facility.getFacilityid()});
                            if (facList2Arr != null) {
                                for (Object[] obj2 : facList2Arr) {
                                    Village v = new Village();
                                    v.setVillagename((String) obj2[0]);
                                    Parish p = new Parish();
                                    p.setParishname((String) obj2[1]);
                                    Subcounty sc = new Subcounty();
                                    sc.setSubcountyname((String) obj2[2]);
                                    County c = new County();
                                    c.setCountyname((String) obj2[3]);
                                    District d = new District();
                                    d.setDistrictname((String) obj2[4]);
                                    Region r = new Region();
                                    r.setRegionname((String) obj2[5]);
                                    d.setRegionid(r);
                                    c.setDistrictid(d);
                                    sc.setCountyid(c);
                                    p.setSubcountyid(sc);
                                    v.setParishid(p);
                                    fac.setVillage(v);
                                }
                            }

                            String[] field3 = {"person.firstname", "person.lastname", "dateupdated"};
                            String[] param3 = {"Id"};
                            Object[] paramsValue3 = {fac.getFacilityid()};
                            List<Object[]> facListArr3 = (List<Object[]>) genericClassService.fetchRecord(Facility.class, field3, "WHERE r.facilityid=:Id", param3, paramsValue3);
                            if (facListArr3 != null) {
                                for (Object[] obj3 : facListArr3) {
                                    Person p2 = new Person();
                                    p2.setFirstname((String) obj3[0]);
                                    p2.setLastname((String) obj3[1]);
                                    fac.setPerson(p2);
                                    fac.setDateupdated((Date) obj3[1]);
                                }
                            }
                            String[] field4 = {"person1.firstname", "person1.lastname", "dateapproved"};
                            String[] param4 = {"Id"};
                            Object[] paramsValue4 = {fac.getFacilityid()};
                            List<Object[]> facListArr4 = (List<Object[]>) genericClassService.fetchRecord(Facility.class, field4, "WHERE r.facilityid=:Id", param4, paramsValue4);
                            if (facListArr4 != null) {
                                for (Object[] obj4 : facListArr4) {
                                    Person p3 = new Person();
                                    p3.setFirstname((String) obj4[0]);
                                    p3.setLastname((String) obj4[1]);
                                    fac.setPerson1(p3);
                                    fac.setDateapproved((Date) obj4[1]);
                                }
                            }
                        }
                        model.put("facObj", fac);
                        // Create A Default Unit
                        Facilityunit unitObj = new Facilityunit();
                        unitObj.setFacilityid(fac.getFacilityid());
                        unitObj.setFacilityunitname("I.C.T");
                        unitObj.setShortname("I.C.T");
                        unitObj.setDescription(description);
                        unitObj.setActive(true);
                        unitObj.setService(true);
                        unitObj.setLocation("");
                        unitObj.setTelephone("");
                        unitObj.setDateadded(new Date());
                        unitObj.setPerson(new Person(pid));
                        genericClassService.saveOrUpdateRecordLoadObject(unitObj);
                        List<Object[]> addedUnitObjArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, new String[]{"facilityunitid"}, "WHERE r.facilityid=:Id AND r.facilityunitid=:unitId", new String[]{"Id","unitId"}, new Object[]{fac.getFacilityid(),unitObj.getFacilityunitid()});
                        if (addedUnitObjArr != null && !addedUnitObjArr.isEmpty()) {
                            model.put("resp", true);
                            model.put("successMessage", "Successfully Added New Facility");    
                        }else{
                            genericClassService.deleteRecordByByColumns(Facility.class, new String[]{"facilityid"}, new Object[]{fac.getFacilityid()});
                            model.put("resp", false);
                            model.put("successMessage", "Error: Failed To Save New Facility!");
                        }
                    }
                } else {
                    model.put("resp", false);
                    model.put("successMessage", "Error: Failed To Save New Facility!");
                }
                model.put("addPolicy", true);
                return new ModelAndView("controlPanel/universalPanel/facility/FacilityRegistration/forms/viewFacilityDetail", "model", model);
 
            } else {
                genericClassService.updateRecordSQLStyle(Facility.class, new String[]{"facilityname", "shortname", "facilitycode", "villageid",
                            "location", "description", "phonecontact", "emailaddress", "website", "postaddress", "facilitylogourl", "hasdepartments", "facilitylevelid", "updateby", "dateupdated","active"},
                        new Object[]{facilityname, sname, facilitycode, facility.getVillage().getVillageid(), location, description, telContact, emailContact, website, postaddress, facilitylogourl, hasdept, facilitylevelid, pid, new Date(),isActive}, "facilityid", (long) facilityid);

                model.put("resp", true);
                model.put("facilityid", facilityid);
                model.put("updated", true);
                model.put("successMessage", "Successfully Update Facility");
                
            }
            existingList.add(facility);
            model.put("facilityList", existingList);

        } catch (Exception e) {
            e.printStackTrace();
            model.put("resp", false);
            model.put("successMessage", "Action Unsuccessfull!. If Error Persists Contact Systems Admin");
        }
        model.put("activity", "add");
        model.put("mainActivity", "Facility");
        return new ModelAndView("controlPanel/universalPanel/facility/FacilityRegistration/views/response", "model", model);
    }

    /**
     *
     * @param request
     * @param principal
     * @return
     */
    @RequestMapping(value = "/deleteFacility.htm", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView deleteFacility(HttpServletRequest request, Principal principal) {
        logger.info("Received request to delete facility");
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            if (principal == null) {
                return new ModelAndView("refresh");
            }
            model.put("act", request.getParameter("act"));
            model.put("b", request.getParameter("b"));
            model.put("i", request.getParameter("i"));
            model.put("a", request.getParameter("a"));
            long orgId = Long.parseLong(request.getParameter("forg"));
            model.put("orgId", orgId);
            
            List<Long> ids = new ArrayList<Long>();
            List<Facility> customList = new ArrayList<Facility>();

            int count = Integer.parseInt(request.getParameter("itemSize"));
            if (count > 0) {
                logger.info("item Count......... " + count + ">0");
                for (int i = 1; i <= count; i++) {
                    if (request.getParameter("selectObj" + i) != null) {
                        long id = Long.parseLong(request.getParameter("selectObj" + i));
                        ids.add(id);
                    }
                }
            } else {
                model.put("resp", false);
                model.put("errorMessage", "No Record Submitted");
                model.put("mainActivity", "Facility");
                return new ModelAndView("controlPanel/universalPanel/facility/FacilityRegistration/views/deleteResponse", "model", model);
            }
            for (Long id : ids) {
                String[] params = {"Id"};
                Object[] paramsValues = {id};
                String[] fields = {"facilityid", "facilitycode", "facilityname", "description", "active", "dateadded", "person2.personname"};
                List<Object[]> facArrList = (List<Object[]>) genericClassService.fetchRecord(Facility.class, fields, "WHERE r.facilityid=:Id", params, paramsValues);
                
                if(facArrList!=null){
                    int success = 0;
                    genericClassService.deleteRecordByByColumns(Facility.class, new String[]{"facilityid"}, new Object[]{id});
                    //Checking for successful deletion
                    if (genericClassService.fetchRecord(Facility.class, fields, "WHERE r.facilityid=:Id", params, paramsValues)==null) {
                        logger.info("Response :Deleted:: ");
                        Facility facObj = new Facility((Integer) facArrList.get(0)[0]);
                        facObj.setFacilitycode((String) facArrList.get(0)[1]);
                        facObj.setFacilityname((String) facArrList.get(0)[2]);
                        facObj.setDescription("N/A");
                        facObj.setActive(true);
                        customList.add(facObj);
                    } else {
                        Facility facObj = new Facility((Integer) facArrList.get(0)[0]);
                        facObj.setFacilitycode((String) facArrList.get(0)[1]);
                        facObj.setFacilityname((String) facArrList.get(0)[2]);
                        facObj.setActive(false);
                        
                        List<Integer[]> object = (List<Integer[]>) genericClassService.fetchRecord(Facilityunit.class, new String[]{"facilityunitid"}, " WHERE r.facility.facilityid=:facID", new String[]{"facID"}, new Object[]{id});
                        if (object != null) {
                            logger.info("Facility Units Attached ::: " + object.size() + " For Id: " + id);
                            String str = "";
                            if (object.size() == 1) {
                                str = "1 Facility Unit Attached";
                            } else {
                                str = object.size() + " Facility Units Attached";
                            }
                            facObj.setDescription(str);
                        } else {
                            facObj.setDescription("N/A");
                        }
                        customList.add(facObj);
                    }
                }else{
                    model.put("resp", false);
                    model.put("errorMessage", "Error! Contact Admin");
                }
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
        return new ModelAndView("controlPanel/universalPanel/facility/FacilityRegistration/views/deleteResponse", "model", model);
    }
    
    
    /**
     *
     * @param principal
     * @return
     */
    @RequestMapping("/facilitySearchByTerm.htm")
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView facilitySearchByTerm(Principal principal, HttpServletRequest request,
            @RequestParam("act") String activity, @RequestParam("i") long id, @RequestParam("d") long id2,
            @RequestParam("b") String strVal, @RequestParam("c") String strVal2,
            @RequestParam("ofst") int offset, @RequestParam("maxR") int maxResults,
            @RequestParam("sStr") String searchPhrase) {
        if (principal == null) {
            return new ModelAndView("refresh");
        }
        Map<String, Object> model = new HashMap<String, Object>();
        model.put("onErrorReturnURL", "ajaxSubmitData('domainFacSetting.htm', 'myTabContent', 'act=a&i=0&b=a&c=" + strVal2 + "&d=0&ofst=1&maxR=100&sStr=', 'GET');");
        try {
            model.put("act", activity);
            model.put("b", strVal);
            model.put("i", id);
            model.put("c", strVal2);
            model.put("d", id2);
            model.put("ofst", offset);
            model.put("maxR", maxResults);
            model.put("sStr", searchPhrase);

            request.getSession().setAttribute("sessPagingOffSet", offset);
            request.getSession().setAttribute("sessPagingMaxResults", maxResults);
            request.getSession().setAttribute("vsearch", searchPhrase);
            
            List<Facility> facilityList = new ArrayList<Facility>();
            String[] fields = {"facilityid", "facilityname", "facilitycode", "shortname", "location", "description", "active", "dateadded", "person2.firstname", "person2.lastname", "facilitylevelid.facilitylevelname", "facilitylevelid.shortname"};
            
                        
            if (activity.equals("a") || activity.equals("b") || activity.equals("c") || activity.equals("d") || activity.equals("e") || activity.equals("f")) { 
                List<Object[]> getRegions =new ArrayList<Object[]>();
                String where="";
                if(request.getSession().getAttribute("SessionSearchFacilityActVal")==null){
                    where="WHERE r.regionid IN (SELECT l.village.parishid.subcountyid.countyid.districtid.regionid.regionid FROM Facility l WHERE l.village IS NOT NULL)";
                    getRegions = (List<Object[]>) genericClassService.fetchRecord(Region.class, new String[]{"regionid", "regionname"}, where+" ORDER BY r.regionname ASC", new String[]{}, new Object[]{});
                }else{
                    Facilitylevel levelObj = (Facilitylevel) request.getSession().getAttribute("SessionSearchFacilityActVal");
                    String[] params = {"Id"};
                    Object[] paramsValues = {levelObj.getFacilitylevelid()};
                    where="WHERE r.regionid IN (SELECT l.village.parishid.subcountyid.countyid.districtid.regionid.regionid FROM Facility l WHERE l.village IS NOT NULL AND l.facilitylevelid.facilitylevelid=:Id)";
                    getRegions = (List<Object[]>) genericClassService.fetchRecord(Region.class, new String[]{"regionid", "regionname"}, where+" ORDER BY r.regionname ASC", params, paramsValues);
                }
//                List<Object[]> getRegions = (List<Object[]>) genericClassService.fetchRecord(Region.class, new String[]{"regionid", "regionname"}, "ORDER BY r.regionname ASC", new String[]{}, new Object[]{});
                if (getRegions != null) {
                    model.put("regionSize", getRegions.size());
                }
                model.put("b", activity);
                model.put("formActivity", "FacilitySearch");
                model.put("regions", getRegions);
                return new ModelAndView("controlPanel/universalPanel/facility/FacilityRegistration/forms/locations", "model", model);
            }
            
            if (activity.equals("g")) { 
                List<Object[]> facListArr = new ArrayList<Object[]>();
                String where = "";
                if(request.getSession().getAttribute("SessionSearchFacilityActVal")==null){
                    String[] params = {};
                    Object[] paramsValues = {};
                    where = "ORDER BY r.facilityname ASC";
                    if (maxResults == 0) {
                        facListArr = (List<Object[]>) genericClassService.fetchRecord(Facility.class, fields, where, params, paramsValues);
                    } else {
                        int countRecordSet = 0;
                        countRecordSet = genericClassService.fetchRecordCount(Facility.class, "", params, paramsValues);
                        offset = ((offset - 1) * maxResults) + 1;
                        model.put("offset2", offset);
                        if (offset > 0) {
                            offset -= 1;
                        }
                        if (countRecordSet > maxResults) {
                            model.put("paginate", true);
                            facListArr = (List<Object[]>) genericClassService.fetchRecordPaging(Facility.class, fields, where, params, paramsValues, offset, maxResults);
                        } else {
                            model.put("paginate", false);
                            facListArr = (List<Object[]>) genericClassService.fetchRecord(Facility.class, fields, where, params, paramsValues);
                        }
                        model.put("count", countRecordSet);
                        int totalPage = (countRecordSet + maxResults - 1) / maxResults;
                        model.put("totalPage", totalPage);
                    }
                }else{
                    Facilitylevel levelObj = (Facilitylevel) request.getSession().getAttribute("SessionSearchFacilityActVal");
                    String[] params = {"Id"};
                    Object[] paramsValues = {levelObj.getFacilitylevelid()};
                    where = "WHERE r.facilitylevelid.facilitylevelid=:Id ORDER BY r.facilityname ASC";
//                    facListArr = (List<Object[]>) genericClassService.fetchRecord(Facility.class, fields, where, params, paramsValues);
                    if (maxResults == 0) {
                        facListArr = (List<Object[]>) genericClassService.fetchRecord(Facility.class, fields, where, params, paramsValues);
                    } else {
                        int countRecordSet = 0;
                        countRecordSet = genericClassService.fetchRecordCount(Facility.class, "WHERE r.facilitylevelid.facilitylevelid=:Id", params, paramsValues);
                        offset = ((offset - 1) * maxResults) + 1;
                        model.put("offset2", offset);
                        if (offset > 0) {
                            offset -= 1;
                        }
                        if (countRecordSet > maxResults) {
                            model.put("paginate", true);
                            facListArr = (List<Object[]>) genericClassService.fetchRecordPaging(Facility.class, fields, where, params, paramsValues, offset, maxResults);
                        } else {
                            model.put("paginate", false);
                            facListArr = (List<Object[]>) genericClassService.fetchRecord(Facility.class, fields, where, params, paramsValues);
                        }
                        model.put("count", countRecordSet);
                        int totalPage = (countRecordSet + maxResults - 1) / maxResults;
                        model.put("totalPage", totalPage);
                    }
                }
                if (facListArr != null) {
                    for (Object[] obj : facListArr) {
                        //{"facilityid", "facilityname", "facilitycode", "district.districtid", "district.districtname", "location", "description", "active", "dateadded", "person1.personname"};
                        Facility f = new Facility((Integer) obj[0]);
                        f.setFacilityname((String) obj[1]);
                        f.setFacilitycode((String) obj[2]);
                        f.setShortname((String) obj[3]);
                        
//                        Village village = new Village();
//                        Parish p = new Parish();
//                        Subcounty sc = new Subcounty();
//                        County c = new County();
//                        District d = new District((Integer) obj[4]);
//                        d.setDistrictname((String) obj[5]);
//                        c.setDistrictid(d);
//                        sc.setCountyid(c);
//                        p.setSubcountyid(sc);
//                        village.setParishid(p);
//                        f.setVillage(village);
                        f.setLocation((String) obj[4]);
                        f.setDescription((String) obj[5]);
                        f.setActive((Boolean) obj[6]);
                        f.setDateadded((Date) obj[7]);
                        Person person = new Person();
                        person.setFirstname((String) obj[8]);
                        person.setLastname((String) obj[9]);
                        f.setPerson2(person);
                        Facilitylevel level = new Facilitylevel();
                        level.setFacilitylevelname((String) obj[10]);
                        level.setShortname((String) obj[11]);
                        f.setFacilitylevelid(level);
                        facilityList.add(f);
                    }
                    model.put("size", facilityList.size());
                }
                boolean showLevel=false;
                if(request.getSession().getAttribute("SessionSearchFacilityActVal")==null){
                    showLevel=true;
                }
                model.put("showLevel", showLevel);
                model.put("facilityList", facilityList);
                model.put("facilityType", "Facility");
                request.getSession().setAttribute("sessReturnSearchedFacilityUrl", "ajaxSubmitData('facilitySearchByTerm.htm', 'response', 'act="+activity+"&i="+id+"&b="+strVal+"&c="+strVal2+"&d="+id2+"&ofst="+offset+"&maxR="+maxResults+"&sStr="+searchPhrase+"', 'GET');");
                return new ModelAndView("controlPanel/universalPanel/facility/FacilityRegistration/views/searchedFacility", "model", model);
            }
            
            if (activity.equals("a1") || activity.equals("b1") || activity.equals("c1") || activity.equals("d1") || activity.equals("e1") || activity.equals("f1")) { 
                logger.info("Here 1");
                List<Object[]> facListArr = new ArrayList<Object[]>();
                String where = "";
                String whereLocation = "";
                
                Facilitydomain domain = new Facilitydomain();
                String phrase = "health";
                String[] domainPar = {};
                Object[] domainparVals = {};
                List<Object[]> domainObjArr = (List<Object[]>) genericClassService.fetchRecord(Facilitydomain.class, new String[]{"facilitydomainid", "domainname"}, "WHERE LOWER(r.domainname) LIKE '" + phrase + "%'", domainPar, domainparVals);
                if (domainObjArr != null) {
                    for (Object[] obj : domainObjArr) {
                        domain.setFacilitydomainid((Integer) obj[0]);
                        domain.setDomainname((String) obj[1]);
                    }
                }
                logger.info("Here 2");
                if (activity.equals("a1")){whereLocation = "WHERE r.village.parishid.subcountyid.countyid.districtid.regionid.regionid=:locId AND r.facilitylevelid.facilitydomain=:domain";}
                if (activity.equals("b1")){whereLocation = "WHERE r.village.parishid.subcountyid.countyid.districtid.districtid=:locId AND r.facilitylevelid.facilitydomain=:domain";}
                if (activity.equals("c1")){whereLocation = "WHERE r.village.parishid.subcountyid.countyid.countyid=:locId AND r.facilitylevelid.facilitydomain=:domain";}
                if (activity.equals("d1")){whereLocation = "WHERE r.village.parishid.subcountyid.subcountyid=:locId AND r.facilitylevelid.facilitydomain=:domain";}
                if (activity.equals("e1")){whereLocation = "WHERE r.village.parishid.parishid=:locId AND r.facilitylevelid.facilitydomain=:domain";}
                if (activity.equals("f1")){whereLocation = "WHERE r.village.villageid=:locId AND r.facilitylevelid.facilitydomain=:domain";}
                logger.info("Here 3");
                if(request.getSession().getAttribute("SessionSearchFacilityActVal")==null){
                    logger.info("Here Null Session 1");
                    String[] params = {"locId","domain"};
                    Object[] paramsValues = {id,domain.getFacilitydomainid()};
                    where = whereLocation+" ORDER BY r.facilityname ASC";
                    if (maxResults == 0) {
                        facListArr = (List<Object[]>) genericClassService.fetchRecord(Facility.class, fields, where, params, paramsValues);
                    } else {
                        int countRecordSet = 0;
                        countRecordSet = genericClassService.fetchRecordCount(Facility.class, whereLocation, params, paramsValues);
                        offset = ((offset - 1) * maxResults) + 1;
                        model.put("offset2", offset);
                        if (offset > 0) {
                            offset -= 1;
                        }
                        if (countRecordSet > maxResults) {
                            model.put("paginate", true);
                            facListArr = (List<Object[]>) genericClassService.fetchRecordPaging(Facility.class, fields, where, params, paramsValues, offset, maxResults);
                        } else {
                            model.put("paginate", false);
                            facListArr = (List<Object[]>) genericClassService.fetchRecord(Facility.class, fields, where, params, paramsValues);
                        }
                        model.put("count", countRecordSet);
                        int totalPage = (countRecordSet + maxResults - 1) / maxResults;
                        model.put("totalPage", totalPage);
                    }
                }else{
                    logger.info("Here Not Null Session 1");
                    Facilitylevel levelObj = (Facilitylevel) request.getSession().getAttribute("SessionSearchFacilityActVal");
                    String[] params = {"Id","locId","domain"};
                    Object[] paramsValues = {levelObj.getFacilitylevelid(),id,domain.getFacilitydomainid()};
                    where = whereLocation+" AND r.facilitylevelid.facilitylevelid=:Id ORDER BY r.facilityname ASC";
                    String countWhere = whereLocation+" AND r.facilitylevelid.facilitylevelid=:Id";
//                    facListArr = (List<Object[]>) genericClassService.fetchRecord(Facility.class, fields, where, params, paramsValues);
                    if (maxResults == 0) {
                        facListArr = (List<Object[]>) genericClassService.fetchRecord(Facility.class, fields, where, params, paramsValues);
                    } else {
                        int countRecordSet = 0;
                        countRecordSet = genericClassService.fetchRecordCount(Facility.class, countWhere, params, paramsValues);
                        offset = ((offset - 1) * maxResults) + 1;
                        model.put("offset2", offset);
                        if (offset > 0) {
                            offset -= 1;
                        }
                        if (countRecordSet > maxResults) {
                            model.put("paginate", true);
                            facListArr = (List<Object[]>) genericClassService.fetchRecordPaging(Facility.class, fields, where, params, paramsValues, offset, maxResults);
                        } else {
                            model.put("paginate", false);
                            facListArr = (List<Object[]>) genericClassService.fetchRecord(Facility.class, fields, where, params, paramsValues);
                        }
                        model.put("count", countRecordSet);
                        int totalPage = (countRecordSet + maxResults - 1) / maxResults;
                        model.put("totalPage", totalPage);
                    }
                }
                if (facListArr != null) {
                    for (Object[] obj : facListArr) {
                        //{"facilityid", "facilityname", "facilitycode", "district.districtid", "district.districtname", "location", "description", "active", "dateadded", "person1.personname"};
                        Facility f = new Facility((Integer) obj[0]);
                        f.setFacilityname((String) obj[1]);
                        f.setFacilitycode((String) obj[2]);
                        f.setShortname((String) obj[3]);
//                        Village village = new Village();
//                        Parish p = new Parish();
//                        Subcounty sc = new Subcounty();
//                        County c = new County();
//                        District d = new District((Integer) obj[4]);
//                        d.setDistrictname((String) obj[5]);
//                        c.setDistrictid(d);
//                        sc.setCountyid(c);
//                        p.setSubcountyid(sc);
//                        village.setParishid(p);
//                        f.setVillage(village);
                        f.setLocation((String) obj[4]);
                        f.setDescription((String) obj[5]);
                        f.setActive((Boolean) obj[6]);
                        f.setDateadded((Date) obj[7]);
                        Person person = new Person();
                        person.setFirstname((String) obj[8]);
                        person.setLastname((String) obj[9]);
                        f.setPerson2(person);
                        Facilitylevel level = new Facilitylevel();
                        level.setFacilitylevelname((String) obj[10]);
                        level.setShortname((String) obj[11]);
                        f.setFacilitylevelid(level);
                        facilityList.add(f);
                    }
                    model.put("size", facilityList.size());
                }
                logger.info("xxxxx---xxxxx ::: xxx");
                boolean showLevel=false;
                if(request.getSession().getAttribute("SessionSearchFacilityActVal")==null){
                    showLevel=true;
                }
                model.put("showLevel", showLevel);
                model.put("facilityList", facilityList);
                model.put("facilityType", "Facility");
                request.getSession().setAttribute("sessReturnSearchedFacilityUrl", "ajaxSubmitData('facilitySearchByTerm.htm', 'response', 'act="+activity+"&i="+id+"&b="+strVal+"&c="+strVal2+"&d="+id2+"&ofst="+offset+"&maxR="+maxResults+"&sStr="+searchPhrase+"', 'GET');");
                return new ModelAndView("controlPanel/universalPanel/facility/FacilityRegistration/views/searchedFacility", "model", model);
            }
            
            
        } catch (Exception e) {
            e.printStackTrace();
            model.put("resp", false);
            model.put("errorMessage", "Action Unsuccessfull!. If Error Persists Contact Systems Admin");
        }
        model.put("mainActivity", "Facility");
        request.getSession().setAttribute("sessReturnSearchedFacilityUrl", "ajaxSubmitData('facilitySearchByTerm.htm', 'response', 'act="+activity+"&i="+id+"&b="+strVal+"&c="+strVal2+"&d="+id2+"&ofst="+offset+"&maxR="+maxResults+"&sStr="+searchPhrase+"', 'GET');");
        return new ModelAndView("controlPanel/universalPanel/facility/FacilityRegistration/views/searchedFacility", "model", model);
    }
    
    public List<Object[]> getLocations(String activity, long id) {
        List<Object[]> listArr = new ArrayList<Object[]>();
        if (activity.equals("a")) {
            listArr = (List<Object[]>) genericClassService.fetchRecord(Region.class, new String[]{"regionid", "regionname"}, "ORDER BY r.regionname ASC", new String[]{}, new Object[]{});
        }
        if (activity.equals("b")) {
            listArr = (List<Object[]>) genericClassService.fetchRecord(District.class, new String[]{"districtid", "districtname"}, "WHERE r.regionid.regionid=:Id", new String[]{"Id"}, new Object[]{id});
        }
        if (activity.equals("c")) {
            listArr = (List<Object[]>) genericClassService.fetchRecord(County.class, new String[]{"countyid", "countyname"}, "WHERE r.districtid.districtid=:Id", new String[]{"Id"}, new Object[]{id});
        }
        if (activity.equals("d")) {
            listArr = (List<Object[]>) genericClassService.fetchRecord(Subcounty.class, new String[]{"subcountyid", "subcountyname"}, "WHERE r.countyid.countyid=:Id", new String[]{"Id"}, new Object[]{id});
        }
        if (activity.equals("e")) {
            listArr = (List<Object[]>) genericClassService.fetchRecord(Parish.class, new String[]{"parishid", "parishname"}, "WHERE r.subcountyid.subcountyid=:Id", new String[]{"Id"}, new Object[]{id});
        }
        if (activity.equals("f")) {
            listArr = (List<Object[]>) genericClassService.fetchRecord(Village.class, new String[]{"villageid", "villagename"}, "WHERE r.parishid.parishid=:Id ORDER BY r.villagename ASC", new String[]{"Id"}, new Object[]{id});
        }
        return listArr;
    }
    /**
     *
     * @param principal
     * @return
     */
    @RequestMapping("/facilityRegCheck.htm")
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView facilityRegCheck(Principal principal, HttpServletRequest request,
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
            
            boolean exists=true;
            int countRecordSet=0;
            if (activity.equals("a")) {
                if (strVal2.equals("a")) {
                    countRecordSet = genericClassService.fetchRecordCount(Facility.class, "WHERE LOWER(r.facilitycode)=:code", new String[]{"code"}, new Object[]{strVal.toLowerCase()});
                }
                if (strVal2.equals("b")) {
                    countRecordSet = genericClassService.fetchRecordCount(Facility.class, "WHERE LOWER(r.facilitycode)=:code AND r.facilityid!=:Id", new String[]{"code","Id"}, new Object[]{strVal.toLowerCase(),id});
                }
                if(countRecordSet>0){
                    exists=false;
                }
                model.put("codeResp", exists);
            }
            if (activity.equals("b")) {
                if (strVal2.equals("a")) {
                    countRecordSet = genericClassService.fetchRecordCount(Facility.class, "WHERE LOWER(r.facilityname)=:name", new String[]{"name"}, new Object[]{strVal.toLowerCase()});
                }
                if (strVal2.equals("b")) {
                    countRecordSet = genericClassService.fetchRecordCount(Facility.class, "WHERE LOWER(r.facilityname)=:name AND r.facilityid!=:Id", new String[]{"name","Id"}, new Object[]{strVal.toLowerCase(),id});
                }
                if(countRecordSet>0){
                    exists=false;
                }
                model.put("nameResp", exists);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            model.put("resp", false);
            model.put("errorMessage", "Action Unsuccessfull!. If Error Persists Contact Systems Admin");
        }
        model.put("mainActivity", "Duplicate Validation");
        return new ModelAndView("controlPanel/universalPanel/facility/FacilityRegistration/forms/checkInputResp", "model", model);
    }

    /**
     *
     * @param principal
     * @return
     */
    @RequestMapping("/entityPolicySetting.htm")
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView entityPolicySetting(Principal principal, HttpServletRequest request,
            @RequestParam("act") String activity, @RequestParam("i") long id, @RequestParam("d") long id2,
            @RequestParam("b") String strVal, @RequestParam("c") String strVal2,
            @RequestParam("ofst") int offset, @RequestParam("maxR") int maxResults,
            @RequestParam("sStr") String searchPhrase) {
        if (principal == null) {
            return new ModelAndView("refresh");
        }
        Map<String, Object> model = new HashMap<String, Object>();
        model.put("onErrorReturnURL", "ajaxSubmitData('facilityPolicySetting.htm', 'myTabContent', 'act=a&i=0&b=a&c=" + strVal2 + "&d=0&ofst=1&maxR=100&sStr=', 'GET');");
        try {
            model.put("act", activity);
            model.put("b", strVal);
            model.put("i", id);
            model.put("c", strVal2);
            model.put("d", id2);
            model.put("ofst", offset);
            model.put("maxR", maxResults);
            model.put("sStr", searchPhrase);

            request.getSession().setAttribute("sessPagingOffSet", offset);
            request.getSession().setAttribute("sessPagingMaxResults", maxResults);
            request.getSession().setAttribute("vsearch", searchPhrase);

            String[] fields = {"policyid", "policyname", "description", "datatype", "options", "status", "limited", "dateadded", "person.firstname", "person.lastname", "category"};

            List<Facilitypolicy> facOptionList = new ArrayList<Facilitypolicy>();
            
            if (activity.equals("a")) {
                String[] params = {};
                Object[] paramsValues = {};
                List<Object[]> policyListArr = (List<Object[]>) genericClassService.fetchRecord(Facilitypolicy.class, fields, "ORDER BY r.category, r.policyname ASC", params, paramsValues);
                if (policyListArr != null) {
                    for (Object[] obj : policyListArr) {
                        Facilitypolicy policy = new Facilitypolicy((Long)obj[0]);
                        policy.setPolicyname((String)obj[1]);
                        policy.setDescription((String)obj[2]);
                        policy.setDatatype((String)obj[3]);
                        String optionsHtml="";
                        String str=(String)obj[4];
                        String[] params2 = {"Id"};
                        Object[] paramsValues2 = {(Long)obj[0]};
                        List<Object[]> policyOptListArr = (List<Object[]>) genericClassService.fetchRecord(Facilitypolicyoptions.class, new String[]{"name"}, "WHERE r.facilitypolicy.policyid=:Id ORDER BY r.name ASC", params2, paramsValues2);
                        if(policyOptListArr!=null){
                            for (Object opt : policyOptListArr) {
                                optionsHtml+="<li>"+opt+"</li>";
                            }
                        }
//                        List<String> optionsList = Arrays.asList(str.split(":"));
//                        if(!optionsList.isEmpty()){
//                            for (String opt : optionsList) {
//                                optionsHtml+="<li>"+opt+"</li>";
//                            }
//                        }
                        policy.setOptions("<ol>"+optionsHtml+"</ol>");
                        policy.setOptions2((String)obj[4]);
                        policy.setStatus((Boolean)obj[5]);
                        policy.setLimited((Boolean)obj[6]);
                        policy.setDateadded((Date)obj[7]);
                        Person p = new Person();
                        p.setFirstname((String)obj[8]);
                        p.setLastname((String)obj[9]);
                        policy.setPerson(p);
                        policy.setCategory((String)obj[10]);
                        facOptionList.add(policy);
                    }
                    logger.info("policyListArr ::::::::: "+policyListArr.size());
                    model.put("size", policyListArr.size());
                }
                model.put("policyList", facOptionList);
                //model.put("policyList", policyListArr);
                model.put("facilityType", "Facility Policy Set Up");
                return new ModelAndView("controlPanel/universalPanel/facility/FacilityPolicy/policyMain", "model", model);
            }
            if (activity.equals("b")) {
                String[] params = {"Id"};
                Object[] paramsValues = {id};
                Facilitypolicy policy = new Facilitypolicy(id);
                List<String> optionsList = new ArrayList<String>();
                List<Object[]> policyListArr = (List<Object[]>) genericClassService.fetchRecord(Facilitypolicy.class, fields, "WHERE r.policyid=:Id", params, paramsValues);
                if (policyListArr != null) {
                    for (Object[] obj : policyListArr) {
                        policy.setPolicyname((String)obj[1]);
                        policy.setDescription((String)obj[2]);
                        policy.setDatatype((String)obj[3]);
                        String optionsHtml="";
                        String str=(String)obj[4];
                        String[] params2 = {"Id"};
                        Object[] paramsValues2 = {(Long)obj[0]};
                        List<Object[]> policyOptListArr = (List<Object[]>) genericClassService.fetchRecord(Facilitypolicyoptions.class, new String[]{"optionsid","name"}, "WHERE r.facilitypolicy.policyid=:Id ORDER BY r.name ASC", params2, paramsValues2);
                        if(policyOptListArr!=null){
                            List<Facilitypolicyoptions> optionList = new ArrayList<Facilitypolicyoptions>();
                            for (Object[] opt : policyOptListArr) {
                                Facilitypolicyoptions fpoObj = new Facilitypolicyoptions((Long)opt[0]);
                                fpoObj.setName((String)opt[1]);
                                optionList.add(fpoObj);
                                optionsHtml+="<li>"+opt+"</li>";
                            }
                            policy.setFacilitypolicyoptionsList(optionList);
                        }
//                        optionsList = Arrays.asList(str.split(":"));
//                        if(!optionsList.isEmpty()){
//                            for (String opt : optionsList) {
//                                optionsHtml+="<li>"+opt+"</li>";
//                            }
//                        }
                        policy.setOptions("<ol>"+optionsHtml+"</ol>");
                        policy.setStatus((Boolean)obj[5]);
                        policy.setLimited((Boolean)obj[6]);
                        policy.setDateadded((Date)obj[7]);
                        Person p = new Person();
                        p.setFirstname((String)obj[8]);
                        p.setLastname((String)obj[9]);
                        policy.setPerson(p);
                        policy.setCategory((String)obj[10]);
                    }
                    logger.info("policyListArr ::::::::: "+policyListArr.size());
                }
                model.put("policyObj", policy);
                model.put("policyOptions", optionsList);
                model.put("facilityType", "Update Facility Policy");
                return new ModelAndView("controlPanel/universalPanel/facility/FacilityPolicy/forms/setUpPolicy", "model", model);
            }
            if (activity.equals("c")) {
                genericClassService.deleteRecordByByColumns(Facilitypolicyoptions.class, new String[]{"policyid"}, new Object[]{id});
                genericClassService.deleteRecordByByColumns(Facilitypolicy.class, new String[]{"policyid"}, new Object[]{id});
                //Checking for successful deletion
                if (genericClassService.fetchRecord(Facilitypolicy.class, new String[]{"policyid"}, "WHERE r.policyid=:Id ", new String[]{"Id"}, new Object[]{id}) == null) {
                    logger.info("Response :Deleted:: ");
                    model.put("resp", false);
                    model.put("respMessage", "Successfully Deleted");
                }else{
                    model.put("resp", true);
                    model.put("respMessage", "FAILED!!");
                }
                return new ModelAndView("controlPanel/universalPanel/facility/FacilityPolicy/forms/deleteResponse", "model", model);
            }
            if (activity.equals("d")) {
                List<Object[]> facObjArr = (List<Object[]>) genericClassService.fetchRecord(Facility.class, new String[]{"facilityid","facilityname","facilitylevelid.facilitylevelname"}, "WHERE r.facilityid=:Id", new String[]{"Id"}, new Object[]{id});
                if(facObjArr!=null){
                    model.put("facObjArr", facObjArr.get(0));
                }
                
                String[] params = {};
                Object[] paramsValues = {};
                List<Object[]> policyListArr = (List<Object[]>) genericClassService.fetchRecord(Facilitypolicy.class, fields, "ORDER BY r.category, r.policyname ASC", params, paramsValues);
                if (policyListArr != null) {
                    for (Object[] obj : policyListArr) {
                        Facilitypolicy policy = new Facilitypolicy((Long) obj[0]);
                        policy.setPolicyname((String) obj[1]);
                        policy.setDatatype((String) obj[3]);
                        policy.setCategory((String)obj[10]);
                        String optionsHtml = "";
                        String str = (String) obj[4];
                        String[] params2 = {"Id"};
                        Object[] paramsValues2 = {(Long) obj[0]};
                        List<Object[]> policyOptListArr = (List<Object[]>) genericClassService.fetchRecord(Facilitypolicyoptions.class, new String[]{"optionsid","name"}, "WHERE r.facilitypolicy.policyid=:Id ORDER BY r.name ASC", params2, paramsValues2);
                        if (policyOptListArr != null) {
                            List<Facilitypolicyoptions> optionList = new ArrayList<Facilitypolicyoptions>();
                            for (Object[] opt : policyOptListArr) {
                                Facilitypolicyoptions fpoObj = new Facilitypolicyoptions((Long) opt[0]);
                                fpoObj.setName((String) opt[1]);
                                optionList.add(fpoObj);
                                optionsHtml += "<li>" + opt + "</li>";
                            }
                            policy.setFacilitypolicyoptionsList(optionList);
                        }
                        policy.setOptions("<ol>" + optionsHtml + "</ol>");
                        facOptionList.add(policy);
                    }
                    logger.info("policyListArr ::::::::: " + policyListArr.size());
                    model.put("size", policyListArr.size());
                }
                model.put("policyList", facOptionList);
                //model.put("policyList", policyListArr);
                model.put("facilityType", "Facility Policy Set Up");
                return new ModelAndView("controlPanel/universalPanel/facility/FacilityRegistration/forms/addFacilityPolicy", "model", model);
            }
            
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        model.put("success", "<span class='text6'>Contact System Administrator :: Page Not Found!</span>");
        return new ModelAndView("response", "model", model);
    }
    
     @RequestMapping(value = "/registerFacPolicy", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView registerFacPolicy(HttpServletRequest request, Principal principal) {
        logger.info("Received request to get from form for reg policy");
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }
            
            int count = Integer.parseInt(request.getParameter("itemSize"));
            String activity = request.getParameter("activity");
            List<Facilitypolicy> addPolicyList = new ArrayList<Facilitypolicy>();
            List<Facilitypolicy> existingPolicyList = new ArrayList<Facilitypolicy>();
            List<Facilitypolicy> addedPolicyList = new ArrayList<Facilitypolicy>();
            List<Facilitypolicy> failedPolicyList = new ArrayList<Facilitypolicy>();
            model.put("activity", activity);
            long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
            
            if (count > 0) {
                logger.info("item Count......... " + count + ">0");
                for (int i = 1; i <= count; i++) {
                    if (request.getParameter("pName" + i) != null) {
                        logger.info("Posted Policy...... " + request.getParameter("pName" + i));
                        String pCat = request.getParameter("pCat" + i);
                        String pName = request.getParameter("pName" + i);
                        String policyDataType = request.getParameter("dType" + i);
                        String description = request.getParameter("pDesc" + i);
                        int options = Integer.parseInt(request.getParameter("pOptionsCount" + i));
                        String optArrInString = request.getParameter("pOptions" + i);
                        
                        String policyName ="";
                        BreakIterator wordBreaker = BreakIterator.getWordInstance();
                        String str = pName.trim();
                        wordBreaker.setText(str);
                        int end = 0;
                        for (int start = wordBreaker.first();
                                (end = wordBreaker.next()) != BreakIterator.DONE; start = end) {
                            String word = str.substring(start, end);
                            String joined_word = word.substring(0, 1).toUpperCase() + word.substring(1).toLowerCase();
                            if (end != 0) {
                                policyName += joined_word;
                            }
                        }

                        Facilitypolicy policy = new Facilitypolicy();
                        //Check Existing Policy
                        int countExistingPolicy = genericClassService.fetchRecordCount(Facilitypolicy.class, "WHERE LOWER(r.category)=:cat AND LOWER(r.policyname)=:name", new String[]{"cat","name"}, new Object[]{pCat.toLowerCase(),policyName.toLowerCase()});
                        if(countExistingPolicy>0){
                            policy.setCategory(pCat);
                            policy.setPolicyname(policyName);
                            policy.setDatatype(policyDataType);
                            policy.setDescription(description);
                            policy.setOptions(optArrInString);
                            
                            existingPolicyList.add(policy);
                        }else{
                            policy.setCategory(pCat);
                            policy.setPolicyname(policyName);
                            policy.setDatatype(policyDataType);
                            policy.setDescription(description);
                            policy.setOptions(optArrInString);
                            policy.setLimited(true);
                            policy.setStatus(true);
                            policy.setDateadded(new Date());
                            policy.setPerson(new Person(pid));
                            
                            addPolicyList.add(policy);
                        }
                    }
                }
                if(addPolicyList!=null && !addPolicyList.isEmpty()){
                    for (Facilitypolicy facilitypolicy : addPolicyList) {
                        genericClassService.saveOrUpdateRecordLoadObject(facilitypolicy);
                        int addedPolicy = genericClassService.fetchRecordCount(Facilitypolicy.class, "WHERE policyid=:pId", new String[]{"pId"}, new Object[]{facilitypolicy.getPolicyid()});
                        if(addedPolicy>0){
                            addedPolicyList.add(facilitypolicy);
                             List<String> optionsList = new ArrayList<String>();
                            optionsList = Arrays.asList(facilitypolicy.getOptions().split(":"));
                            if (!optionsList.isEmpty()) {
                                for (String opt : optionsList) {
                                    Facilitypolicyoptions fpo = new Facilitypolicyoptions();
                                    fpo.setName(opt);
                                    fpo.setActive(true);
                                    fpo.setDateadded(new Date());
                                    fpo.setPerson1(new Person(pid));
                                    fpo.setFacilitypolicy(facilitypolicy);
                                    int existingPolicyOption = genericClassService.fetchRecordCount(Facilitypolicyoptions.class, "WHERE LOWER(r.name)=:name AND r.facilitypolicy.policyid=:Id", new String[]{"Id","name"}, new Object[]{facilitypolicy.getPolicyid(),opt.toLowerCase()});
                                    if(existingPolicyOption==0){
                                        genericClassService.saveOrUpdateRecordLoadObject(fpo);
                                    }
                                }
                            }
                        }else{
                            failedPolicyList.add(facilitypolicy);
                        }
                    }
                    model.put("addedPolicyList", addedPolicyList);
                    if(addedPolicyList!=null && !addedPolicyList.isEmpty()){
                        model.put("mainActivity", "AddFacilityPolicy");
                        model.put("resp", true);
                        if(addedPolicyList.size()==1){
                            model.put("successMessage", "Successfully Saved "+addedPolicyList.size()+" Policy");
                        }else{
                            model.put("successMessage", "Successfully Saved "+addedPolicyList.size()+" Policies");
                        }
                    }else{
                        model.put("resp", false);
                        model.put("errorMessage", "Saving New Policy Failed!");
                    }
                    model.put("failedPolicyList", failedPolicyList);
                }else{
                    model.put("resp", false);
                    model.put("errorMessage", "No Valid Policies To Be Added!");
                }
                logger.info("savePolicy......... " + addPolicyList.size() + " activity........... "+activity);
                
            }else{
                model.put("resp", false);
                model.put("errorMessage", "No Policies Added!");
            }
            
            return new ModelAndView("controlPanel/universalPanel/facility/FacilityPolicy/views/saveResponse", "model", model);
            
        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("controlPanel/universalPanel/facility/FacilityPolicy/views/saveResponse", "model", model);
        }
        
    }
    
    @RequestMapping(value = "/updateFacPolicy", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView updateFacPolicy(HttpServletRequest request, Principal principal) {
        logger.info("Received request to update policy");
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }
            String[] fields = {"policyid", "policyname", "description", "datatype", "options", "status", "limited", "dateadded", "person.firstname", "person.lastname", "category"};
            
            int count = Integer.parseInt(request.getParameter("optionSize"));
            String activity = request.getParameter("activity");
            List<Facilitypolicy> addPolicyList = new ArrayList<Facilitypolicy>();
            List<Facilitypolicy> existingPolicyList = new ArrayList<Facilitypolicy>();
            List<Facilitypolicy> addedPolicyList = new ArrayList<Facilitypolicy>();
            List<Facilitypolicy> failedPolicyList = new ArrayList<Facilitypolicy>();
            model.put("activity", activity);
            long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
            
            long policyId = Long.parseLong(request.getParameter("policy"));
            String category = request.getParameter("pcategory");
            String policyName = request.getParameter("policyname");
            String policyDataType = request.getParameter("pdatatype");
            String description = request.getParameter("description");
            String optArrInString = "";
            List<Facilitypolicyoptions> updatePolicyOpList = new ArrayList<Facilitypolicyoptions>();
            List<Facilitypolicyoptions> addPolicyOpList = new ArrayList<Facilitypolicyoptions>();
            if (count > 0) {
                logger.info("Option Count......... " + count + ">0");
                for (int i = 1; i <= count; i++) {
                    if (request.getParameter("pOptionId" + i) != null && !request.getParameter("pOptionId" + i).isEmpty()) {
                        logger.info("Posted Policy Option....i."+i+". " + request.getParameter("pOption" + i));
                        Facilitypolicyoptions fOpt = new Facilitypolicyoptions();
                        long id = Long.parseLong(request.getParameter("pOptionId" + i));
                        String name = request.getParameter("pOption" + i);
                        fOpt.setOptionsid(id);
                        fOpt.setName(name);
                        updatePolicyOpList.add(fOpt);
                    }else{
                        if (request.getParameter("pOption" + i) != null) {
                            Facilitypolicyoptions fOpt = new Facilitypolicyoptions();
                            String name = request.getParameter("pOption" + i);
                            fOpt.setName(name);
                            addPolicyOpList.add(fOpt);
                        }
                    }
                }
            }
            logger.info("Update optArrInString."+optArrInString);
            genericClassService.updateRecordSQLStyle(Facilitypolicy.class, new String[]{"category", "policyname", "datatype", "description", "updatedby", "dateupdated"}, new Object[]{category, policyName, policyDataType, description, pid, new Date()}, "policyid", policyId);
            if(updatePolicyOpList!=null && !updatePolicyOpList.isEmpty()){
                for (Facilitypolicyoptions policyoptions : updatePolicyOpList) {
                    genericClassService.updateRecordSQLStyle(Facilitypolicyoptions.class, new String[]{"name", "updatedby", "dateupdated"}, new Object[]{policyoptions.getName(), pid, new Date()}, "optionsid", policyoptions.getOptionsid());
                }
            }
            if(addPolicyOpList!=null && !addPolicyOpList.isEmpty()){
                for (Facilitypolicyoptions policyoptions : addPolicyOpList) {
                    policyoptions.setDateadded(new Date());
                    policyoptions.setPerson1(new Person(pid));
                    policyoptions.setFacilitypolicy(new Facilitypolicy(policyId));
                    genericClassService.saveOrUpdateRecordLoadObject(policyoptions);
                }
            }
            String[] params = {"Id"};
            Object[] paramsValues = {policyId};
            Facilitypolicy policy = new Facilitypolicy(policyId);
            List<String> optionsList = new ArrayList<String>();
            List<Object[]> policyListArr = (List<Object[]>) genericClassService.fetchRecord(Facilitypolicy.class, fields, "WHERE r.policyid=:Id", params, paramsValues);
            if (policyListArr != null) {
                for (Object[] obj : policyListArr) {
                    policy.setPolicyname((String) obj[1]);
                    policy.setDescription((String) obj[2]);
                    policy.setDatatype((String) obj[3]);
                    String optionsHtml = "";
                    String str = (String) obj[4];
//                    optionsList = Arrays.asList(str.split(":"));
//                    if (!optionsList.isEmpty()) {
//                        for (String opt : optionsList) {
//                            optionsHtml += "<li>" + opt + "</li>";
//                        }
//                    }
                    String[] params2 = {"Id"};
                    Object[] paramsValues2 = {(Long) obj[0]};
                    List<Object[]> policyOptListArr = (List<Object[]>) genericClassService.fetchRecord(Facilitypolicyoptions.class, new String[]{"optionsid", "name"}, "WHERE r.facilitypolicy.policyid=:Id ORDER BY r.name ASC", params2, paramsValues2);
                    if (policyOptListArr != null) {
                        List<Facilitypolicyoptions> optionList = new ArrayList<Facilitypolicyoptions>();
                        for (Object[] opt : policyOptListArr) {
                            Facilitypolicyoptions fpoObj = new Facilitypolicyoptions((Long) opt[0]);
                            fpoObj.setName((String) opt[1]);
                            optionList.add(fpoObj);
                            optionsHtml += "<li>" + opt + "</li>";
                        }
                        policy.setFacilitypolicyoptionsList(optionList);
                    }
                    policy.setOptions("<ol>" + optionsHtml + "</ol>");
                    policy.setStatus((Boolean) obj[5]);
                    policy.setLimited((Boolean) obj[6]);
                    policy.setDateadded((Date) obj[7]);
                    Person p = new Person();
                    p.setFirstname((String) obj[8]);
                    p.setLastname((String) obj[9]);
                    policy.setPerson(p);
                    policy.setCategory((String) obj[10]);
                    addedPolicyList.add(policy);
                }
                logger.info("policyListArr ::::::::: " + policyListArr.size());

                model.put("policyObj", policy);
                model.put("policyOptions", optionsList);
            }
            model.put("addedPolicyList", addedPolicyList);
            if (addedPolicyList != null && !addedPolicyList.isEmpty()) {
                model.put("mainActivity", "AddFacilityPolicy");
                model.put("resp", true);
                if (addedPolicyList.size() == 1) {
                    model.put("successMessage", "Successfully Updated " + policy.getPolicyname() + " Policy");
                } else {
                    model.put("successMessage", "Successfully Updated " + policy.getPolicyname() + " Policies");
                }
            } else {
                model.put("resp", false);
                model.put("errorMessage", "Updating Policy Failed!");
            }
            logger.info("savePolicy......... " + addPolicyList.size() + " activity........... " + activity);
            model.put("mainActivity", "AddFacilityPolicy");
            return new ModelAndView("controlPanel/universalPanel/facility/FacilityPolicy/views/saveResponse", "model", model);

        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("controlPanel/universalPanel/facility/FacilityPolicy/views/saveResponse", "model", model);
        }

    }
    
    
    @RequestMapping(value = "/registerFacilityPolicy.htm", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView registerFacilityPolicy(HttpServletRequest request, Principal principal) {
        logger.info("Received request to add policy options");
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }
            
            int count = Integer.parseInt(request.getParameter("itemSize"));
            String activity = request.getParameter("activity");
            List<Facilitypolicy> addPolicyList = new ArrayList<Facilitypolicy>();
            model.put("activity", activity);
            long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
            int facilityid = Integer.parseInt(request.getParameter("dfac"));
            model.put("facilityid", facilityid);
            boolean savedPolicy=false;
            if (count > 0) {
                logger.info("item Count......... " + count + ">0");
                for (int i = 1; i <= count; i++) {
                    if (request.getParameter("policyIdChk" + i)!=null && request.getParameter("policyIdChk" + i).equals("true")) {
                        logger.info("Posted Policy ID...... " + request.getParameter("policyId" + i));
                        long policyId = Long.parseLong(request.getParameter("policyId" + i));
                        Facilitypolicy policyObj = new Facilitypolicy(policyId);
                        List<Object[]> policyArrObj = (List<Object[]>) genericClassService.fetchRecord(Facilitypolicy.class, new String[]{"policyid","policyname","datatype"}, "WHERE r.policyid=:pId", new String[]{"pId"}, new Object[]{policyId});
                        if (policyArrObj != null) {
                            for (Object[] obj : policyArrObj) {
                                policyObj.setPolicyname((String)obj[1]);
                                policyObj.setDatatype((String)obj[2]);
                            }
                        }
                        String datatype="";
                        if (policyArrObj != null) {
                            List<Facilityassignedpolicy> addPolicyOptionList = new ArrayList<Facilityassignedpolicy>();
                            datatype=policyObj.getDatatype();
                            logger.info("ADDING "+datatype+" ATTRIBUTES");
                            if(datatype.equals("Multiple Option")){
                                List<Long> updatedAssignedList = new ArrayList<Long>();
                                List<Object> allreadyAssignedPolicyArrObj = (List<Object>) genericClassService.fetchRecord(Facilityassignedpolicy.class, new String[]{"assignedpolicyid"}, "WHERE r.facilitypolicyoptions.facilitypolicy.policyid=:pId AND r.facility.facilityid=:fId", new String[]{"pId","fId"}, new Object[]{policyId,facilityid});
                                int countPolicyOptions = genericClassService.fetchRecordCount(Facilitypolicyoptions.class, "WHERE r.facilitypolicy.policyid=:pId", new String[]{"pId"}, new Object[]{policyId});
                                if(countPolicyOptions>0 && datatype.equals("Multiple Option")){
                                    for (int x = 1; x <= countPolicyOptions; x++) {
                                        logger.info("Getting Multiple Option Values sIZE:"+countPolicyOptions);
                                        if(request.getParameter("policyOpt"+i+""+x)!=null){
                                            long policyOptionId = Long.parseLong(request.getParameter("policyOpt"+i+""+x));
                                            Facilityassignedpolicy assignedPolicy = new Facilityassignedpolicy();
                                            assignedPolicy.setFacilitypolicyoptions(new Facilitypolicyoptions(policyOptionId));
                                            assignedPolicy.setFacility(new Facility(facilityid));
                                            assignedPolicy.setFacilitypolicy(policyObj);
                                            assignedPolicy.setDateadded(new Date());
                                            assignedPolicy.setPerson(new Person(pid));
                                            
//                                            List<Object> assignedPolicyArrObj = (List<Object>) genericClassService.fetchRecord(Facilityassignedpolicy.class, new String[]{"assignedpolicyid"}, "WHERE r.facilitypolicyoptions.facilitypolicy.policyid=:pId AND r.facility.facilityid=:fId", new String[]{"pId","fId"}, new Object[]{policyId,facilityid});
                                            List<Object> assignedPolicyArrObj = (List<Object>) genericClassService.fetchRecord(Facilityassignedpolicy.class, new String[]{"assignedpolicyid"}, "WHERE r.facilitypolicyoptions.optionsid=:pOptId AND r.facility.facilityid=:fId", new String[]{"pOptId","fId"}, new Object[]{policyOptionId,facilityid});
                                            if (assignedPolicyArrObj != null) {
                                                //Updated With New Value
                                                    long assignedOptionId = (Long)assignedPolicyArrObj.get(0);
                                                    updatedAssignedList.add(assignedOptionId);
                                                    genericClassService.updateRecordSQLStyle(Facilityassignedpolicy.class, new String[]{"optionsid", "updatedby", "dateupdated"}, new Object[]{policyOptionId, pid, new Date()}, "assignedpolicyid", assignedOptionId);
                                                    savedPolicy = true;
                                            }else{
                                                    genericClassService.saveOrUpdateRecordLoadObject(assignedPolicy);
                                                    int addedPolicy = genericClassService.fetchRecordCount(Facilityassignedpolicy.class, "WHERE assignedpolicyid=:aPId", new String[]{"aPId"}, new Object[]{assignedPolicy.getAssignedpolicyid()});
                                                    if(addedPolicy>0){
                                                        addPolicyOptionList.add(assignedPolicy);
                                                        savedPolicy=true;
                                                    }
                                            }
                                        }
                                    }
                                }
                                //Check For Unchecked Multiple Options
                                List<Long> allAssignedOptionsList = new ArrayList<Long>();
                                if(allreadyAssignedPolicyArrObj!=null){
                                    for (Object object : allreadyAssignedPolicyArrObj) {
                                        allAssignedOptionsList.add((Long)object);
                                    }
                                    if(updatedAssignedList!=null && !updatedAssignedList.isEmpty()){
                                        for (Long long1 : allAssignedOptionsList) {
                                            if(!updatedAssignedList.contains(long1)){
                                                //Discard Option Not Selected
                                                genericClassService.deleteRecordByByColumns(Facilityassignedpolicy.class, new String[]{"assignedpolicyid"}, new Object[]{long1});
                                            }
                                        }
                                    }
                                }
                                
                            }
                            if(datatype.equals("Single Option")) {
                                if (request.getParameter("policyOpt" + i) != null) {
                                    long policyOptionId = Long.parseLong(request.getParameter("policyOpt"+i));
                                    Facilityassignedpolicy assignedPolicy = new Facilityassignedpolicy();
                                    assignedPolicy.setFacilitypolicyoptions(new Facilitypolicyoptions(policyOptionId));
                                    assignedPolicy.setFacility(new Facility(facilityid));
                                    assignedPolicy.setFacilitypolicy(policyObj);
                                    assignedPolicy.setDateadded(new Date());
                                    assignedPolicy.setPerson(new Person(pid));

                                    List<Object> assignedPolicyArrObj = (List<Object>) genericClassService.fetchRecord(Facilityassignedpolicy.class, new String[]{"assignedpolicyid"}, "WHERE r.facilitypolicyoptions.facilitypolicy.policyid=:pId AND r.facility.facilityid=:fId", new String[]{"pId","fId"}, new Object[]{policyId,facilityid});
                                    if (assignedPolicyArrObj != null) {
                                        //Updated With New Value
                                            long assignedOptionId = (Long)assignedPolicyArrObj.get(0);
                                            genericClassService.updateRecordSQLStyle(Facilityassignedpolicy.class, new String[]{"optionsid", "updatedby", "dateupdated"}, new Object[]{policyOptionId, pid, new Date()}, "assignedpolicyid", assignedOptionId);
                                            savedPolicy = true;
                                    }else{
                                        //Save New Policy
                                        genericClassService.saveOrUpdateRecordLoadObject(assignedPolicy);
                                        int addedPolicy = genericClassService.fetchRecordCount(Facilityassignedpolicy.class, "WHERE assignedpolicyid=:aPId", new String[]{"aPId"}, new Object[]{assignedPolicy.getAssignedpolicyid()});
                                        if (addedPolicy > 0) {
                                            addPolicyOptionList.add(assignedPolicy);
                                            savedPolicy = true;
                                        }
                                    }
                                }
                            }
                            policyObj.setFacilityassignedpolicys(addPolicyOptionList);
                        }
                        addPolicyList.add(policyObj);
                    }
                }
            }else{
                model.put("resp", false);
                model.put("respMessage", "Error: No Policies Selected!");
            }
            if(savedPolicy==true){
                model.put("mainActivity", "AddFacilityPolicy");
                model.put("addPolicyList", addPolicyList);
                model.put("resp", true);
                if(activity.equals("Add")){
                    model.put("respMessage", "Policies Successfully Added!");
                }else{
                    model.put("respMessage", "Policies Successfully Updated!");
                }
            }
            else{
                model.put("resp", false);
                model.put("respMessage", "No Policies Added!");
            }
            model.put("activity", activity);
            return new ModelAndView("controlPanel/universalPanel/facility/FacilityRegistration/views/savePolicyResponse", "model", model);
            //return orgFacilitySettings(principal, request, "c1", facilityid, 0, activity, activity, 0, 0, "");
            
        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("controlPanel/universalPanel/facility/FacilityPolicy/views/saveResponse", "model", model);
        }
    }
    
    
    @RequestMapping(value = "/deleteAssignedFacPolicy.htm")
    public @ResponseBody
    String deleteAssignedFacPolicy(HttpServletRequest request, Model model) {
        String results = "";
        int facilityid=Integer.parseInt(request.getParameter("fId"));
        long policyid=Long.parseLong(request.getParameter("Id"));
        
        List<Object> assignedPolicyArrList = (List<Object>) genericClassService.fetchRecord(Facilityassignedpolicy.class, new String[]{"assignedpolicyid"}, "WHERE r.facilitypolicy.policyid=:Id AND r.facility.facilityid=:fId", new String[]{"Id", "fId"}, new Object[]{policyid, facilityid});
        if(assignedPolicyArrList!=null){
            for (Object objects : assignedPolicyArrList) {
                genericClassService.deleteRecordByByColumns(Facilityassignedpolicy.class, new String[]{"assignedpolicyid"}, new Object[]{(Long)objects});
            }
        }
        //Checking for successful deletion
        if (genericClassService.fetchRecord(Facilityassignedpolicy.class, new String[]{"assignedpolicyid"}, "WHERE r.facilitypolicy.policyid=:Id AND r.facility.facilityid=:fId", new String[]{"Id", "fId"}, new Object[]{policyid, facilityid}) == null) {
            results="success";
        } else {
            results="failed";
        }
        return results;
    }
    
    @RequestMapping(value = "/deleteSelectedFacility.htm")
    public @ResponseBody
    String deleteSelectedFacility(HttpServletRequest request, Model model) {
        String results = "";
        int facilityid = Integer.parseInt(request.getParameter("fId"));
        String[] fields = {"facilityid", "facilityname", "facilitycode"};

        String[] params = {"Id"};
        Object[] paramsValues = {facilityid};
        List<Object[]> facArrList = (List<Object[]>) genericClassService.fetchRecord(Facility.class, fields, "WHERE r.facilityid=:Id", params, paramsValues);
        if (facArrList != null) {
            int success = 0;
            genericClassService.deleteRecordByByColumns(Facility.class, new String[]{"facilityid"}, new Object[]{facilityid});
            //Checking for successful deletion
            if (genericClassService.fetchRecord(Facility.class, fields, "WHERE r.facilityid=:Id", params, paramsValues) == null) {
                logger.info("Response :Deleted:: ");
                results = "success";
            } else {
                String str = "";
                List<Object> assignedPolicyArrList = (List<Object>) genericClassService.fetchRecord(Facilityassignedpolicy.class, new String[]{"facilitypolicy.policyid"}, "WHERE r.facility.facilityid=:fId", new String[]{"fId"}, new Object[]{facilityid});
                if(assignedPolicyArrList!=null){
                    if (assignedPolicyArrList.size() == 1) {
                        str += "1 Facility Policy Attached";
                    } else {
                        str += assignedPolicyArrList.size() + " Facility Policies Attached";
                    }
                }
                List<Integer[]> object = (List<Integer[]>) genericClassService.fetchRecord(Facilityunit.class, new String[]{"facilityunitid"}, " WHERE r.facilityid=:facID", new String[]{"facID"}, new Object[]{facilityid});
                if (object != null) {
                    logger.info("Facility Units Attached ::: " + object.size() + " For Id: " + facilityid);
                    if (object.size() == 1) {
                        str += "1 Facility Unit Attached";
                    } else {
                        str += object.size() + " Facility Units Attached";
                    }
                }
                if(str.isEmpty()){
                    results = "Facility Has Attachments!";
                }else{
                    results = str;
                }
            }
        } else {
            results = "Error! Contact Admin";
        }

        return results;
    }
    
}