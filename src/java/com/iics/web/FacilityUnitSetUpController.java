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
import java.util.Calendar;
import java.util.Collections;
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
public class FacilityUnitSetUpController {
    public static String sys_info = null;
    protected static Log logger = LogFactory.getLog("controller");
    @Autowired
    GenericClassService genericClassService;
    
    
     /**
     *
     * @param principal
     * @return
     */
    @RequestMapping("/facilityUnitSetUp.htm")
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView facilityUnitSetUp(Principal principal, HttpServletRequest request,
            @RequestParam("act") String activity, @RequestParam("i") long id, @RequestParam("d") long id2,
            @RequestParam("b") String strVal, @RequestParam("c") String strVal2,
            @RequestParam("ofst") int offset, @RequestParam("maxR") int maxResults,
            @RequestParam("sStr") String searchPhrase) {
        if (principal == null) {
            return new ModelAndView("refresh");
        }
        Map<String, Object> model = new HashMap<String, Object>();
        model.put("onErrorReturnURL", "ajaxSubmitData('facilityUnitSetUp.htm', 'workpane', 'act=a&i=0&b=a&c=a&d=0&ofst=1&maxR=100&sStr=', 'GET');");
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
            int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
            String[] fields = {"structureid", "hierachylabel", "description", "active", "position", "dateadded", "facility.facilityid", "facility.facilityname", "person.firstname", "person.lastname", "service"};

            List<Facilitystructure> hyrchList = new ArrayList<Facilitystructure>();
            List<Object[]> structureListArr = new ArrayList<Object[]>();
            
            if (activity.equals("a")) {
                String[] param1 = {"Id"};
                Object[] paramsValue1 = {facilityid};
                String[] facFields = {"facilityid", "facilityname", "facilitycode", "facilitylevelid.facilitylevelname"};
                List<Object[]> facArrList = (List<Object[]>) genericClassService.fetchRecord(Facility.class, facFields, "WHERE r.facilityid=:Id", param1, paramsValue1);
                Facility facObj = new Facility();
                if (facArrList != null) {
                    facObj = new Facility((Integer) facArrList.get(0)[0]);
                    facObj.setFacilityname((String) facArrList.get(0)[1]);
                    facObj.setFacilitycode((String) facArrList.get(0)[2]);
                    Facilitylevel levelObj = new Facilitylevel();
                    levelObj.setFacilitylevelname((String) facArrList.get(0)[3]);
                    facObj.setFacilitylevelid(levelObj);
                }
                model.put("facObj", facObj);

                String[] params = {"facId"};
                Object[] paramsValues = {facilityid};
                structureListArr = (List<Object[]>) genericClassService.fetchRecord(Facilitystructure.class, fields, "WHERE r.facility.facilityid=:facId AND r.facilitystructure IS NULL ORDER BY r.position, r.hierachylabel ASC", new String[]{"facId"}, new Object[]{facilityid});
                model.put("structureListArr", structureListArr);
                if (structureListArr != null && !structureListArr.isEmpty()) {
                    for (Object[] obj : structureListArr) {
                        Facilitystructure hyrch = new Facilitystructure((Long) obj[0]);
                        hyrch.setHierachylabel((String) obj[1]);
                        hyrch.setDescription((String) obj[2]);
                        hyrch.setActive((Boolean) obj[3]);
                        hyrch.setPosition((Integer) obj[4]);
                        hyrch.setDateadded((Date) obj[5]);
                        Facility fac = new Facility((Integer) obj[6]);
                        fac.setFacilityname((String) obj[7]);
                        Person person = new Person();
                        person.setFirstname((String) obj[8]);
                        person.setLastname((String) obj[9]);
                        hyrch.setPerson(person);
                        List<Facilitystructure> hyrchChildList = getParentChildElements("a", hyrch, hyrch.getStructureid(), facilityid);
                        int size=0;
//                        logger.info("XXXXXX---::::"+hyrchChildList.size());
                        if(hyrchChildList!=null){
                            hyrch.setFacilitystructureList(hyrchChildList);
                            size=hyrchChildList.size();
                        }
                        hyrch.setUnits(size);
                        hyrchList.add(hyrch);
                    }
                    model.put("size", hyrchList.size());
                }
                model.put("structureList", hyrchList);
                model.put("facilityType", "Hierarchy");
                return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/unitSetUpTab", "model", model);
            }
            if (activity.equals("b")) {
                String[] param1 = {"Id"};
                Object[] paramsValue1 = {facilityid};
                String[] facFields = {"facilityid", "facilityname", "facilitycode", "facilitylevelid.facilitylevelname"};
                List<Object[]> facArrList = (List<Object[]>) genericClassService.fetchRecord(Facility.class, facFields, "WHERE r.facilityid=:Id", param1, paramsValue1);
                Facility facObj = new Facility();
                if (facArrList != null) {
                    facObj = new Facility((Integer) facArrList.get(0)[0]);
                    facObj.setFacilityname((String) facArrList.get(0)[1]);
                    facObj.setFacilitycode((String) facArrList.get(0)[2]);
                    Facilitylevel levelObj = new Facilitylevel();
                    levelObj.setFacilitylevelname((String) facArrList.get(0)[3]);
                    facObj.setFacilitylevelid(levelObj);
                }
                model.put("facObj", facObj);

                String[] params = {"facId"};
                Object[] paramsValues = {facilityid};
                structureListArr = (List<Object[]>) genericClassService.fetchRecord(Facilitystructure.class, fields, "WHERE r.facility.facilityid=:facId AND r.facilitystructure IS NULL ORDER BY r.position, r.hierachylabel ASC", new String[]{"facId"}, new Object[]{facilityid});
                model.put("structureListArr", structureListArr);
                if (structureListArr != null && !structureListArr.isEmpty()) {
                    for (Object[] obj : structureListArr) {
                        Facilitystructure hyrch = new Facilitystructure((Long) obj[0]);
                        hyrch.setHierachylabel((String) obj[1]);
                        hyrch.setDescription((String) obj[2]);
                        hyrch.setActive((Boolean) obj[3]);
                        hyrch.setPosition((Integer) obj[4]);
                        hyrch.setDateadded((Date) obj[5]);
                        Facility fac = new Facility((Integer) obj[6]);
                        fac.setFacilityname((String) obj[7]);
                        Person person = new Person();
                        person.setFirstname((String) obj[8]);
                        person.setLastname((String) obj[9]);
                        hyrch.setPerson(person);
                        hyrch.setService((Boolean) obj[10]);
                        int totalNodeNames = 0;
                        if(hyrch.getService()==false){
                            totalNodeNames = genericClassService.fetchRecordCount(Facilityunithierachy.class, "WHERE r.facilitystructure.structureid=:Id AND r.facility.facilityid=:facId", new String[]{"Id","facId"}, new Object[]{(Long) obj[0],facilityid});
                        }else{
                            totalNodeNames = genericClassService.fetchRecordCount(Facilityunit.class, "WHERE r.facilitystructure.structureid=:Id AND r.facilityid=:facId", new String[]{"Id","facId"}, new Object[]{(Long) obj[0],facilityid});
                        }
                        hyrch.setItems(totalNodeNames);
                        List<Facilitystructure> hyrchChildList = getParentChildElements("a", hyrch, hyrch.getStructureid(), facilityid);
                        int size=0;
//                        logger.info("XXXXXX---::::"+hyrchChildList.size());
                        if(hyrchChildList!=null){
                            hyrch.setFacilitystructureList(hyrchChildList);
                            size=hyrchChildList.size();
                        }
                        hyrch.setUnits(size);
                        hyrchList.add(hyrch);
                    }
                    model.put("size", hyrchList.size());
                }
                model.put("structureList", hyrchList);
                
                int totalUnStructuredUnits = genericClassService.fetchRecordCount(Facilityunit.class, "WHERE r.facilitystructure.structureid IS NULL AND r.facilityid=:facId", new String[]{"facId"}, new Object[]{facilityid});
                model.put("totalUnStructuredUnitObj", totalUnStructuredUnits);
                
                model.put("facilityType", "Facility Unit Set Up");
                return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/forms/manageFacilityUnit", "model", model);
            }
            if (activity.equals("c")) {
                //sessFacilityStructureId
                if (request.getSession().getAttribute("sessFacilityStructureId") != null) {
                    long structureid = Long.parseLong(request.getSession().getAttribute("sessFacilityStructureId").toString());
                    Facilitystructure hyrchObj = new Facilitystructure();
                    String[] hyrchFields = {"structureid", "hierachylabel", "service"};
                    String[] params = {"Id"};
                    Object[] paramsValues = {structureid};
                    List<Object[]> hyrchListArr = (List<Object[]>) genericClassService.fetchRecord(Facilitystructure.class, fields, "WHERE r.facilitystructure.structureid=:Id", params, paramsValues);
                    if (hyrchListArr != null) {
                        for (Object[] obj : hyrchListArr) {
                            hyrchObj.setStructureid((Long) obj[0]);
                            hyrchObj.setHierachylabel((String) obj[1]);
                        }
                        model.put("hyrchObj", hyrchObj);
                    }
                }
                
                return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/forms/addMoreUnits", "model", model);
            }
            
            } catch (Exception e) {
            e.printStackTrace();
        }
        model.put("success", "<span class='text6'>Contact System Administrator :: Page Not Found!</span>");
        return new ModelAndView("response", "model", model);
    }
    
    public List<Facilityunithierachy> getChildParentdElements(String activity, long unit, int facilityid) {
        List<Facilityunithierachy> hyrchList = new ArrayList<Facilityunithierachy>();
        String[] fields = {"facilityunithierachy.facilityunitid", "facilityunithierachy.facilityunitname", "facilityunithierachy.facilitystructure.structureid", "facilityunithierachy.facilitystructure.hierachylabel", "facilityunithierachy.facilitystructure.service"};
        List<Object[]> levelListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunithierachy.class, fields, "WHERE r.facilityunitid=:Id", new String[]{"Id"}, new Object[]{unit});
        if (levelListArr != null && !levelListArr.isEmpty()) {
            for (Object[] obj : levelListArr) {
                Facilityunithierachy level = new Facilityunithierachy((Long) obj[0]);
                level.setFacilityunitname((String) obj[1]);
                Facilitystructure structure = new Facilitystructure((Long) obj[2]);
                structure.setHierachylabel((String) obj[3]);
                structure.setService((Boolean) obj[4]);
                level.setFacilitystructure(structure);
                if(!hyrchList.contains(level)){
                    hyrchList.add(level);
                }
                logger.info("Added Level:"+(String) obj[3]+" Name:"+(String) obj[1]);
                List<Facilityunithierachy> parentLevels = getChildParentdElements(activity, (Long) obj[0], facilityid);
                if(parentLevels!=null && !parentLevels.isEmpty()){
                    for (Facilityunithierachy parentLevel : parentLevels) {
                       if(!hyrchList.contains(parentLevel)){
                            hyrchList.add(parentLevel);
                        }
                    }
                }
            }
        }
        return hyrchList;
    }
    
    public List<Facilitystructure> getParentChildElements(String activity, Facilitystructure structure, long structureid, int facilityid) {
        List<Facilitystructure> hyrchList = new ArrayList<Facilitystructure>();
        String[] fields = {"structureid", "hierachylabel","service"};
        String[] params = {"Id"};
        Object[] paramsValues = {structureid};
        List<Object[]> hyrchListArr = (List<Object[]>) genericClassService.fetchRecord(Facilitystructure.class, fields, "WHERE r.facilitystructure.structureid=:Id", params, paramsValues);
        if (hyrchListArr != null) {
            for (Object[] obj : hyrchListArr) {
                Facilitystructure hyrch = new Facilitystructure((Long) obj[0]);
                hyrch.setHierachylabel((String) obj[1]);
                List<Facilitystructure> hyrchChildList = getParentChildElements("a", hyrch, hyrch.getStructureid(), facilityid);
                int size=0;
                if(hyrchChildList!=null){
                    hyrch.setFacilitystructureList(hyrchChildList);
                    size=hyrchChildList.size();
                }
                hyrch.setUnits(size);
                hyrch.setService((Boolean) obj[2]);
                int totalNodeNames = 0;
                if (hyrch.getService() == false) {
                    totalNodeNames = genericClassService.fetchRecordCount(Facilityunithierachy.class, "WHERE r.facilitystructure.structureid=:Id AND r.facility.facilityid=:facId", new String[]{"Id","facId"}, new Object[]{(Long) obj[0],facilityid});
                } else {
                    totalNodeNames = genericClassService.fetchRecordCount(Facilityunit.class, "WHERE r.facilitystructure.structureid=:Id AND r.facilityid=:facId", new String[]{"Id","facId"}, new Object[]{(Long) obj[0],facilityid});
                }
//                int totalNodeNames = genericClassService.fetchRecordCount(Facilityunit.class, "WHERE r.facilitystructure.structureid=:Id AND r.facilityid=:facId", new String[]{"Id","facId"}, new Object[]{(Long) obj[0],facilityid});
                hyrch.setItems(totalNodeNames);
                hyrchList.add(hyrch);
            }
        }
        return hyrchList;
    }
    public List<Facilityunit> getUnitChildElements(String activity, Facilityunit unitObj, long facilityunitid, int facilityid) {
        List<Facilityunit> unitList = new ArrayList<Facilityunit>();

        List<Object[]> unitListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, new String[]{"facilityunitid", "facilityunitname", "facilitystructure.structureid", "facilitystructure.hierachylabel"}, "WHERE r.facilityid=:facId AND r.facilityunit.facilityunitid=:unitId ORDER BY r.facilityunitname ASC", new String[]{"facId", "unitId"}, new Object[]{facilityid, facilityunitid});
        if (unitListArr != null && !unitListArr.isEmpty()) {
            for (Object[] obj : unitListArr) {
                Facilityunit unit = new Facilityunit((Long) obj[0]);
                unit.setFacilityunitname((String) obj[1]);
                Facilitystructure hyrch = new Facilitystructure((Long) obj[2]);
                hyrch.setHierachylabel((String) obj[3]);
                unit.setFacilitystructure(hyrch);

//                List<Facilityunit> unitChildList = getUnitChildElements("a", unit, unit.getFacilityunitid(), facilityid);
                int size = 0;
//                if (unitChildList != null) {
//                    unit.setFacilityunitList(unitChildList);
//                    size = unitChildList.size();
//                }
                unit.setSubunits(size);
                unitList.add(unit);
            }
        }
        return unitList;
    }
    
    /**
     *
     * @param principal
     * @return
     */
    @RequestMapping("/facHierarchySetting.htm")
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView facHierarchySetting(Principal principal, HttpServletRequest request,
            @RequestParam("act") String activity, @RequestParam("i") long id, @RequestParam("d") long id2,
            @RequestParam("b") String strVal, @RequestParam("c") String strVal2,
            @RequestParam("ofst") int offset, @RequestParam("maxR") int maxResults,
            @RequestParam("sStr") String searchPhrase) {
        if (principal == null) {
            return new ModelAndView("login");
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
            int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
            
            String[] fields = {"structureid", "hierachylabel", "description", "active", "position", "dateadded", "person.firstname", "person.lastname", "facility.facilityid", "facility.facilityname", "service"};
            
            String[] param1 = {"Id"};
            Object[] paramsValue1 = {facilityid};
            String[] facFields = {"facilityid", "facilityname", "facilitycode"};
            List<Object[]> facArrList = (List<Object[]>) genericClassService.fetchRecord(Facility.class, facFields, "WHERE r.facilityid=:Id", param1, paramsValue1);
            Facility facObj = new Facility();
            if (facArrList != null) {
                facObj = new Facility((Integer) facArrList.get(0)[0]);
                facObj.setFacilityname((String) facArrList.get(0)[1]);
                facObj.setFacilitycode((String) facArrList.get(0)[2]);
            }
            model.put("facObj", facObj);

            
            List<Facilitystructure> hyrchList = new ArrayList<Facilitystructure>();
            List<Object[]> hyrchListArr = new ArrayList<Object[]>();
            
            if (activity.equals("b") || activity.equals("c")) {
                model.put("facilityType", "Hierarchy/Level Name");
                if (activity.equals("c")) {
                    String[] params = {"Id"};
                    Object[] paramsValues = {id};
                    hyrchListArr = (List<Object[]>) genericClassService.fetchRecord(Facilitystructure.class, fields, "WHERE r.structureid=:Id", params, paramsValues);
                    if (hyrchListArr != null) {
                        model.put("hyrchObjArr", hyrchListArr.get(0));
                    }
                }
                return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/forms/formFacLevel", "model", model);
            }
            if (activity.equals("d")) {
                Facilitystructure hyrch = new Facilitystructure();
                model.put("facilityType", "Facilitystructure");
                String[] params = {"Id"};
                Object[] paramsValues = {id};
                hyrchListArr = (List<Object[]>) genericClassService.fetchRecord(Facilitystructure.class, fields, "WHERE r.structureid=:Id", params, paramsValues);
                if (hyrchListArr != null) {
                    for (Object[] obj : hyrchListArr) {
                        hyrch = new Facilitystructure((Long) obj[0]);
                        hyrch.setHierachylabel((String) obj[1]);
                        hyrch.setDescription((String) obj[2]);
                        hyrch.setActive((Boolean) obj[3]);
                        hyrch.setPosition((Integer) obj[4]);
                        hyrch.setDateadded((Date) obj[5]);
                        Person person = new Person();
                        person.setFirstname((String) obj[6]);
                        person.setLastname((String) obj[7]);
                        hyrch.setPerson(person);
                        hyrch.setService((Boolean) obj[10]);
                        
                        int chkParent = genericClassService.fetchRecordCount(Facilitystructure.class, "WHERE r.structureid=:Id AND r.facilitystructure IS NULL", new String[]{"Id"}, new Object[]{(Long) obj[0]});
                        boolean isParent=false;
                        if(chkParent>0){
                            isParent=true;
                        }
                        hyrch.setIsparent(isParent);
                        
                        String[] field2 = {"dateupdated", "person1.firstname", "person1.lastname"};
                        List<Object[]> orgsListArr2 = (List<Object[]>) genericClassService.fetchRecord(Facilitystructure.class, field2, "WHERE r.structureid=:Id", params, paramsValues);
                        if (orgsListArr2 != null) {
                            for (Object[] obj2 : orgsListArr2) {
                                hyrch.setDateupdated((Date) obj2[0]);
                                Person updatedBy = new Person();
                                updatedBy.setFirstname((String) obj2[1]);
                                updatedBy.setLastname((String) obj2[2]);
                                hyrch.setPerson1(updatedBy);
                            }
                        }
                    }
                    model.put("hyrchObj", hyrch);
                }
                return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/views/viewHyrchDetails", "model", model);
            }
            if (activity.equals("f")) {
                boolean deletedObjState=false;
                String[] params = {"Id"};
                Object[] paramsValues = {id};
                Facilitystructure delObj = new Facilitystructure(id);
                hyrchListArr = (List<Object[]>) genericClassService.fetchRecord(Facilitystructure.class, fields, "WHERE r.structureid=:Id", params, paramsValues);
                if (hyrchListArr != null) {
                    for (Object[] obj : hyrchListArr) {
                        delObj.setHierachylabel((String) obj[1]);
                    }
                }
                List<Facilitystructure> customList = new ArrayList<Facilitystructure>();
                genericClassService.deleteRecordByByColumns(Facilitystructure.class, new String[]{"structureid"}, new Object[]{id});
                //Checking for successful deletion
                if (genericClassService.fetchRecord(Facilitystructure.class, fields, "WHERE r.structureid=:Id", params, paramsValues) == null) {
                    logger.info("Response :Deleted:: ");
                    delObj.setDescription("Node Successfully Deleted");
                    delObj.setActive(true);
                    customList.add(delObj);
                    deletedObjState=true;
                } else {
                    List<Object[]> hyrchChildListArr = (List<Object[]>) genericClassService.fetchRecord(Facilitystructure.class, fields, "WHERE r.facilitystructure.structureid=:Id", params, paramsValues);
                    if (hyrchChildListArr != null) {
                        for (Object[] obj : hyrchChildListArr) {
                            Facilitystructure hyrch = new Facilitystructure((Long) obj[0]);
                            hyrch.setHierachylabel((String) obj[1]);
                            int totalChildUnits = genericClassService.fetchRecordCount(Facilitystructure.class, "WHERE r.facilitystructure.structureid=:Id", new String[]{"Id"}, new Object[]{(Long) obj[0]});
                            hyrch.setUnits(totalChildUnits);
                            hyrch.setActive(false);
                            delObj.setDescription("Node Not Deleted");
                            customList.add(hyrch);
                        }
                    }
                }
                if (customList!= null && !customList.isEmpty()) {
                    model.put("size", customList.size());
                }
                
                model.put("deletedObjState", deletedObjState);
                model.put("hyrchObj", delObj);
                model.put("structureList", customList);
                model.put("mainActivity", "Discard Nodes");
                return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/views/response", "model", model);
            }
            if (activity.equals("g")) {
                model.put("facilityType", "Hierarchy/Level");
                String[] params = {"Id"};
                Object[] paramsValues = {id};
                hyrchListArr = (List<Object[]>) genericClassService.fetchRecord(Facilitystructure.class, fields, "WHERE r.structureid=:Id", params, paramsValues);
                if (hyrchListArr != null) {
                    model.put("hyrchObjArr", hyrchListArr.get(0));
                }

                return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/forms/addChildNode", "model", model);
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
    @RequestMapping(value = "/registerFacLevel.htm", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView registerFacLevel(HttpServletRequest request, Principal principal) {
        logger.info("Received Request To Add Facility Level");
        Map<String, Object> model = new HashMap<String, Object>();
        Facilitystructure facHrchy = new Facilitystructure();
        boolean updateActivity = false;
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }
            long facHrchyId = 0;
            if (request.getParameter("cref") != null && !request.getParameter("cref").isEmpty()) {
                facHrchyId = Integer.parseInt(request.getParameter("cref"));
                updateActivity = true;
            }
            int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
            String lvlname = request.getParameter("lvlname");
            String description = request.getParameter("description");
            int position = Integer.parseInt(request.getParameter("pos"));
            boolean status = Boolean.parseBoolean(request.getParameter("status"));
            boolean service = Boolean.parseBoolean(request.getParameter("services"));
            
            String levelname = "";
            BreakIterator wordBreaker = BreakIterator.getWordInstance();
            String str = lvlname.trim();
            wordBreaker.setText(str);
            int end = 0;
            for (int start = wordBreaker.first();
                    (end = wordBreaker.next()) != BreakIterator.DONE; start = end) {
                String word = str.substring(start, end);
                String joined_word = word.substring(0, 1).toUpperCase() + word.substring(1).toLowerCase();
                if (end != 0) {
                    levelname += joined_word;
                }
            }            
            logger.info("updateActivity ::: " + updateActivity+" service::"+service);
            
            if(service==true && updateActivity==true){
                int subUnits = genericClassService.fetchRecordCount(Facilityunithierachy.class, "WHERE r.facilitystructure.structureid=:hyrchId AND r.facility.facilityid=:facId", new String[]{"hyrchId", "facId"}, new Object[]{facHrchyId, facilityid});
                logger.info("Service Level Structure subUnits:"+subUnits);
                if(subUnits>0){
                    model.put("resp", false);
                    model.put("errorMessage", "Already Facility Structure Node Already Has Attachment. Discard To Enable Service Level Structure");
                    return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/views/response", "model", model);
                }            
            }
            
            String[] param2 = {"name","facId"};
            Object[] paramsValue2 = {levelname,facilityid};
            String[] field2 = {"structureid", "hierachylabel", "description", "active", "dateadded", "person.firstname", "person.lastname"};
            List<Object[]> existingOrgList = (List<Object[]>) genericClassService.fetchRecord(Facilitystructure.class, field2, "WHERE r.hierachylabel=:name AND r.facility.facilityid=:facId", param2, paramsValue2);
            if (existingOrgList != null) {
                boolean exist = false;
                List<Facilitystructure> existingList = new ArrayList<Facilitystructure>();
                for (Object[] obj : existingOrgList) {
                    Facilitystructure hyrch = new Facilitystructure((Long) obj[0]);
                        hyrch.setHierachylabel((String) obj[1]);
                        hyrch.setDescription((String) obj[2]);
                        hyrch.setActive((Boolean) obj[3]);
                        hyrch.setDateadded((Date) obj[4]);
                        Person person = new Person();
                        person.setFirstname((String) obj[5]);
                        person.setLastname((String) obj[5]);
                        hyrch.setPerson(person);
                    existingList.add(hyrch);
                    exist = true;
                    if (facHrchyId == (Long) obj[0]) {
                        exist = false;
                    }
                }
                model.put("resp", false);
                model.put("errorMessage", "Already Existing Facility Structure Node");
                model.put("facilityList", existingList);
                if (exist == true) {
                    model.put("mainActivity", "Hierarchy");
                    return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/views/response", "model", model);
                }
            }

            List<Facilitystructure> existingList = new ArrayList<Facilitystructure>();
            long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
            facHrchy.setFacility(new Facility(facilityid));
            facHrchy.setHierachylabel(levelname);
            facHrchy.setDescription(description);
            facHrchy.setPosition(position);
            facHrchy.setActive(status);
            facHrchy.setService(service);
            
            if (updateActivity == false) {
                facHrchy.setDateadded(new Date());
                facHrchy.setPerson(new Person(pid));
            } else {
                facHrchy.setStructureid(facHrchyId);
                facHrchy.setDateupdated(new Date());
                facHrchy.setPerson1(new Person(pid));
            }

            if (updateActivity == false) {
                genericClassService.saveOrUpdateRecordLoadObject(facHrchy);
                if (genericClassService.fetchRecord(Facilitystructure.class, new String[]{"structureid"}, "WHERE r.structureid=:Id", new String[]{"Id"}, new Object[]{facHrchy.getStructureid()}) != null) {
                    model.put("resp", true);
                    model.put("successMessage", "Successfully Added New Organisation Structure Node");
                } else {
                    model.put("resp", false);
                    model.put("errorMessage", "Organisation Structure Node Not Added");
                }
                
            } else {
                genericClassService.updateRecordSQLStyle(Facilitystructure.class, new String[]{"hierachylabel", "active", "service", "description", "updatedby", "dateupdated"},
                        new Object[]{levelname, status, service, description, pid, new Date()}, "structureid", facHrchyId);
                model.put("resp", true);
                model.put("successMessage", "Successfully Update Organisation Structure Node");
            }
            existingList.add(facHrchy);
            model.put("hyrchList", existingList);

        } catch (Exception e) {
            e.printStackTrace();
            model.put("resp", false);
            model.put("errorMessage", "Action Unsuccessfull!. If Error Persists Contact Systems Admin");
        }
        if (updateActivity == false) {
            model.put("activity", "add");
        }else{
            model.put("activity", "update");
        }
        model.put("mainActivity", "Hierarchy");
        return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/views/response", "model", model);
    }
    
    /**
     *
     * @param request
     * @param principal
     * @return
     */
    @RequestMapping(value = "/registerOrgLevelNode.htm", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView registerOrgLevelNode(HttpServletRequest request, Principal principal) {
        logger.info("Received Request To Add Org Level Node");
        Map<String, Object> model = new HashMap<String, Object>();
        Facilitystructure facHrchy = new Facilitystructure();
        boolean updateActivity = false;
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }
            long facHrchyId = 0;
            if (request.getParameter("cref") != null && !request.getParameter("cref").isEmpty()) {
                facHrchyId = Integer.parseInt(request.getParameter("cref"));
                updateActivity = true;
            }
            int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
            String lvlname = request.getParameter("lvlname");
            String description = request.getParameter("description");
            int position = Integer.parseInt(request.getParameter("pos"));
            boolean status = Boolean.parseBoolean(request.getParameter("status"));
            boolean services = Boolean.parseBoolean(request.getParameter("services"));

            String levelname = "";
            BreakIterator wordBreaker = BreakIterator.getWordInstance();
            String str = lvlname.trim();
            wordBreaker.setText(str);
            int end = 0;
            for (int start = wordBreaker.first();
                    (end = wordBreaker.next()) != BreakIterator.DONE; start = end) {
                String word = str.substring(start, end);
                String joined_word = word.substring(0, 1).toUpperCase() + word.substring(1).toLowerCase();
                if (end != 0) {
                    levelname += joined_word;
                }
            }
            logger.info("updateActivity ::: " + updateActivity);

            String[] param2 = {"name", "Id"};
            Object[] paramsValue2 = {levelname, facHrchyId};
            String[] field2 = {"structureid", "hierachylabel", "description", "active", "dateadded", "person.firstname", "person.lastname", "service"};
            List<Object[]> existingOrgList = (List<Object[]>) genericClassService.fetchRecord(Facilitystructure.class, field2, "WHERE r.hierachylabel=:name AND r.facilitystructure.structureid=:Id", param2, paramsValue2);
            if (existingOrgList != null) {
                boolean exist = false;
                List<Facilitystructure> existingList = new ArrayList<Facilitystructure>();
                for (Object[] obj : existingOrgList) {
                    Facilitystructure hyrch = new Facilitystructure((Long) obj[0]);
                    hyrch.setHierachylabel((String) obj[1]);
                    hyrch.setDescription((String) obj[2]);
                    hyrch.setActive((Boolean) obj[3]);
                    hyrch.setDateadded((Date) obj[4]);
                    Person person = new Person();
                    person.setFirstname((String) obj[5]);
                    person.setLastname((String) obj[6]);
                    hyrch.setPerson(person);
                    hyrch.setService((Boolean) obj[7]);
                    existingList.add(hyrch);
                    exist = true;
                    if (facHrchyId == (Long) obj[0]) {
                        exist = false;
                    }
                }
                model.put("resp", false);
                model.put("errorMessage", "Already Existing Organisation Structure Node");
                model.put("facilityList", existingList);
                if (exist == true) {
                    model.put("mainActivity", "Hierarchy");
                    return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/views/response", "model", model);
                }
            }

            List<Facilitystructure> existingList = new ArrayList<Facilitystructure>();
            long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
            facHrchy.setFacility(new Facility(facilityid));
            facHrchy.setFacilitystructure(new Facilitystructure(facHrchyId));
            facHrchy.setHierachylabel(levelname);
            facHrchy.setDescription(description);
            facHrchy.setPosition(position);
            facHrchy.setActive(status);
            facHrchy.setService(services);
            facHrchy.setDateadded(new Date());
            facHrchy.setPerson(new Person(pid));

            genericClassService.saveOrUpdateRecordLoadObject(facHrchy);
            if (genericClassService.fetchRecord(Facilitystructure.class, new String[]{"structureid"}, "WHERE r.structureid=:Id", new String[]{"Id"}, new Object[]{facHrchy.getStructureid()}) != null) {
                model.put("resp", true);
                model.put("successMessage", "Successfully Added New Facility Structure Node");
            } else {
                model.put("resp", false);
                model.put("errorMessage", "Facility Structure Node Not Added");
            }

            existingList.add(facHrchy);
            model.put("hyrchList", existingList);

        } catch (Exception e) {
            e.printStackTrace();
            model.put("resp", false);
            model.put("errorMessage", "Action Unsuccessfull!. If Error Persists Contact Systems Admin");
        }
        if (updateActivity == false) {
            model.put("activity", "add");
        } else {
            model.put("activity", "update");
        }
        model.put("mainActivity", "Hierarchy");
        return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/views/response", "model", model);
    }
    
    
    /**
     *
     * @param principal
     * @return
     */
    @RequestMapping("/facilityUnitSetting.htm")
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView facilityUnitSetting(Principal principal, HttpServletRequest request,
            @RequestParam("act") String activity, @RequestParam("i") long id, @RequestParam("d") long id2,
            @RequestParam("b") String strVal, @RequestParam("c") String strVal2,
            @RequestParam("ofst") int offset, @RequestParam("maxR") int maxResults,
            @RequestParam("sStr") String searchPhrase) {
        if (principal == null) {
            return new ModelAndView("login");
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
            int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());

            String[] unitFields = {"facilityunitid", "facilityunitname", "shortname", "description", "active", "facilitystructure.structureid"};
            String[] structureFields = {"structureid", "hierachylabel", "description", "active", "service"};
            
            String[] param1 = {"Id"};
            Object[] paramsValue1 = {facilityid};
            String[] facFields = {"facilityid", "facilityname", "facilitycode"};
            List<Object[]> facArrList = (List<Object[]>) genericClassService.fetchRecord(Facility.class, facFields, "WHERE r.facilityid=:Id", param1, paramsValue1);
            Facility facObj = new Facility();
            if (facArrList != null) {
                facObj = new Facility((Integer) facArrList.get(0)[0]);
                facObj.setFacilityname((String) facArrList.get(0)[1]);
                facObj.setFacilitycode((String) facArrList.get(0)[2]);
            }
            model.put("facObj", facObj);

            List<Object[]> hyrchListArr = new ArrayList<Object[]>();
            List<Facilityunit> facilityUnitList = new ArrayList<Facilityunit>();
            List<Facilityunithierachy> hierachyUnitList = new ArrayList<Facilityunithierachy>();
            List<Object[]> unitListArr = new ArrayList<Object[]>();
            
            if (activity.equals("a")) {
                //Call Form To Add A Unit
                //******Determine Parent Layers and Objects********
                String[] labelSelects;
                Facilitystructure hyrch = new Facilitystructure();
                String[] params = {"Id", "facId"};
                Object[] paramsValues = {id,facilityid};
                hyrchListArr = (List<Object[]>) genericClassService.fetchRecord(Facilitystructure.class, structureFields, "WHERE r.structureid=:Id AND r.facility.facilityid=:facId", params, paramsValues);
                if (hyrchListArr != null) {
                    for (Object[] obj : hyrchListArr) {
                        hyrch = new Facilitystructure((Long) obj[0]);
                        hyrch.setHierachylabel((String) obj[1]);
                        hyrch.setDescription((String) obj[2]);
                        hyrch.setService((Boolean) obj[4]);
                    }
                    model.put("hyrchObj", hyrch);
                    
                    if(hyrch.getService()==false){
                        Facilitystructure hyrchSelect = new Facilitystructure();
                        String[] params2 = {"Id", "state", "structureId"};
                        Object[] paramsValues2 = {facilityid, true, id};
                        List<Object[]> hyrchArrList = (List<Object[]>) genericClassService.fetchRecord(Facilityunithierachy.class, new String[]{"facilityunithierachy.facilityunitid", "facilityunithierachy.facilityunitname", "facilityunithierachy.facilitystructure.structureid", "facilityunithierachy.facilitystructure.hierachylabel", "facilityunithierachy.facilitystructure.service"}, "WHERE r.facilitystructure.structureid=:structureId AND r.facility.facilityid=:Id AND r.active=:state", params2, paramsValues2);
                        if (hyrchArrList != null) {
                            for (Object[] unitObj : hyrchArrList) {
                                Facilityunithierachy unit = new Facilityunithierachy((Long) unitObj[0]);
                                unit.setFacilityunitname((String) unitObj[1]);
                                logger.info("Level Name :::: "+(String) unitObj[1]+" Structure ::: "+(Long) unitObj[2]);
                                hyrchSelect = new Facilitystructure((Long) unitObj[2]);
                                hyrchSelect.setHierachylabel((String) unitObj[3]);
                                hyrchSelect.setService((Boolean) unitObj[4]);
                                unit.setFacilitystructure(hyrchSelect);
                                hierachyUnitList.add(unit);
                            }
                            hyrchArrList = (List<Object[]>) genericClassService.fetchRecord(Facilityunithierachy.class, new String[]{"facilityunitid", "facilityunitname", "facilitystructure.structureid", "facilitystructure.hierachylabel", "facilitystructure.service"}, "WHERE r.facilitystructure.structureid=:structureId AND r.facility.facilityid=:Id AND r.active=:state", new String[]{"Id", "state", "structureId"}, new Object[]{facilityid, true, hyrchSelect.getStructureid()});
                            if (hyrchArrList != null) {
                                for (Object[] unitObj : hyrchArrList) {
                                    Facilityunithierachy unit = new Facilityunithierachy((Long) unitObj[0]);
                                    unit.setFacilityunitname((String) unitObj[1]);
                                    logger.info("Level Name :::: "+(String) unitObj[1]);
                                    hyrchSelect = new Facilitystructure((Long) unitObj[2]);
                                    hyrchSelect.setHierachylabel((String) unitObj[3]);
                                    hyrchSelect.setService((Boolean) unitObj[4]);
                                    unit.setFacilitystructure(hyrchSelect);
                                    if(!hierachyUnitList.contains(unit)){
                                        hierachyUnitList.add(unit);
                                    }
                                }
                            }
                            model.put("levelHyrchObj", hyrchSelect);
                        }
                    }
                    else{
                        Facilitystructure hyrchSelect = new Facilitystructure();
                        String[] params2 = {"Id", "state"};
                        Object[] paramsValues2 = {facilityid, true};
                        List<Object[]> hyrchArrList = (List<Object[]>) genericClassService.fetchRecord(Facilityunithierachy.class, new String[]{"facilityunitid", "facilityunitname", "facilitystructure.structureid", "facilitystructure.hierachylabel", "facilitystructure.service"}, "WHERE r.facilityunithierachy.facilityunitid IS NULL AND r.facility.facilityid=:Id AND r.active=:state", params2, paramsValues2);
                        if (hyrchArrList != null) {
                            for (Object[] unitObj : hyrchArrList) {
                                Facilityunithierachy unit = new Facilityunithierachy((Long) unitObj[0]);
                                unit.setFacilityunitname((String) unitObj[1]);
                                logger.info("Level Name :::: "+(String) unitObj[1]+" Structure ::: "+(Long) unitObj[2]);
                                hyrchSelect = new Facilitystructure((Long) unitObj[2]);
                                hyrchSelect.setHierachylabel((String) unitObj[3]);
                                hyrchSelect.setService((Boolean) unitObj[4]);
                                unit.setFacilitystructure(hyrchSelect);
                                hierachyUnitList.add(unit);
                            }
                            model.put("levelHyrchObj", hyrchSelect);
                        }
                    }
                    model.put("serviceLevelObj", hyrch.getService()); 
                }
                
                model.put("hyrchList", hierachyUnitList); 
                model.put("formActivity", "Add"); 
                model.put("returnURL", request.getSession().getAttribute("sessReturnSelectedFacilityUnitUrl").toString());
                return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/forms/formAddUnit", "model", model);
            }
            
            if (activity.equals("b") || activity.equals("c")) {
                facilityUnitList = new ArrayList<Facilityunit>();
                boolean isUnitObj=false;
                boolean isAttachedUnit=false;
                
                Facilitystructure hyrch = new Facilitystructure();
                String[] params = {"Id", "facId"};
                if(id2!=0){
                    Object[] paramsValues = {id2,facilityid};
                    hyrchListArr = (List<Object[]>) genericClassService.fetchRecord(Facilitystructure.class, structureFields, "WHERE r.structureid=:Id AND r.facility.facilityid=:facId", params, paramsValues);
                    logger.info("hyrchListArr ::::::::::::::::::::::: "+hyrchListArr);
                    if (hyrchListArr != null) {
                        for (Object[] obj : hyrchListArr) {
                            hyrch = new Facilitystructure((Long) obj[0]);
                            hyrch.setHierachylabel((String) obj[1]);
                            hyrch.setDescription((String) obj[2]);
                            hyrch.setService((Boolean) obj[4]);
                        }
                    }
                    if(hyrch!=null && hyrch.getService()!=null && hyrch.getService()==true){
                        isUnitObj=true;
                    }
                    model.put("hyrchObj", hyrch);
                }else{
                    isUnitObj=true;
                }
                
               logger.info("isUnitObj ----------------------------------------- ::::"+isUnitObj);
                if (isUnitObj == true) {
                    Facilityunit unit = new Facilityunit(id);
                    String[] unitFields2 = {"facilityunitid", "facilityunitname", "shortname", "description", "active", "location", "telephone", "service"};
                    unitListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, unitFields2, "WHERE r.facilityunitid=:Id AND r.facilityid=:facId", new String[]{"Id", "facId"}, new Object[]{id, facilityid});
                    if (unitListArr != null) {
                        for (Object[] unitObj : unitListArr) {
                            unit.setFacilityunitname((String) unitObj[1]);
                            unit.setShortname((String) unitObj[2]);
                            unit.setDescription((String) unitObj[3]);
                            unit.setActive((Boolean) unitObj[4]);
                            unit.setLocation((String) unitObj[5]);
                            unit.setTelephone((String) unitObj[6]);
                            unit.setService((Boolean) unitObj[7]);
                            int subUnits = 0;//genericClassService.fetchRecordCount(Facilityunit.class, "WHERE r.facilityunit.facilityunitid=:unitId AND r.facilityid=:facId", new String[]{"unitId", "facId"}, new Object[]{(Long) unitObj[0], facilityid});
                            unit.setSubunits(subUnits);
                            List<Object[]> unitHyrchListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, new String[]{"facilitystructure.structureid", "facilitystructure.hierachylabel"}, "WHERE r.facilityunitid=:Id AND r.facilityid=:facId", new String[]{"Id", "facId"}, new Object[]{id, facilityid});
                            if (unitHyrchListArr != null) {
                                Facilitystructure hyrch2 = new Facilitystructure();
                                for (Object[] obj : unitHyrchListArr) {
                                    hyrch2 = new Facilitystructure((Long) obj[0]);
                                    hyrch2.setHierachylabel((String) obj[1]);
                                }
                                unit.setFacilitystructure(hyrch2);
                            }
                            List<Object[]> unitAddDateArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, new String[]{"dateadded", "person.firstname", "person.lastname"}, "WHERE r.facilityunitid=:Id AND r.facilityid=:facId", new String[]{"Id", "facId"}, new Object[]{id, facilityid});
                            if (unitAddDateArr != null) {
                                for (Object[] obj : unitAddDateArr) {
                                    unit.setDateadded((Date) obj[0]);
                                    Person addedBy = new Person();
                                    addedBy.setFirstname((String) obj[1]);
                                    addedBy.setLastname((String) obj[2]);
                                    unit.setPerson(addedBy);
                                }
                            }
                            List<Object[]> unitUpdateDateArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, new String[]{"dateupdated", "person1.firstname", "person1.lastname"}, "WHERE r.facilityunitid=:Id AND r.facilityid=:facId", new String[]{"Id", "facId"}, new Object[]{id, facilityid});
                            if (unitUpdateDateArr != null) {
                                for (Object[] obj : unitUpdateDateArr) {
                                    unit.setDateupdated((Date) obj[0]);
                                    Person updatedBy = new Person();
                                    updatedBy.setFirstname((String) obj[1]);
                                    updatedBy.setLastname((String) obj[2]);
                                    unit.setPerson1(updatedBy);
                                }
                            }
//                        facilityUnitList.add(unit);
                        }
                    }
                    //Get Parent Hierarchies
                    List<Facilityunithierachy> hyrchList = new ArrayList<Facilityunithierachy>();
                    String[] fields = {"facilityunithierachy.facilityunitid", "facilityunithierachy.facilityunitname", "facilityunithierachy.facilitystructure.structureid", "facilityunithierachy.facilitystructure.hierachylabel", "facilityunithierachy.facilitystructure.service"};
                    List<Object[]> levelListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields, "WHERE r.facilityunitid=:Id AND r.facilityid=:fId", new String[]{"Id", "fId"}, new Object[]{unit, facilityid});
                    if (levelListArr != null && !levelListArr.isEmpty()) {
                        for (Object[] obj : levelListArr) {
                            Facilityunithierachy level = new Facilityunithierachy((Long) obj[0]);
                            level.setFacilityunitname((String) obj[1]);
                            Facilitystructure structure = new Facilitystructure((Long) obj[2]);
                            structure.setHierachylabel((String) obj[3]);
                            structure.setService((Boolean) obj[4]);
                            level.setFacilitystructure(structure);
                            if(!hyrchList.contains(level)){
                                hyrchList.add(level);
                            }
                            logger.info("Added Level:"+(String) obj[3]+" Name:"+(String) obj[1]);

                            List<Facilityunithierachy> parentLevels = getChildParentdElements(activity, (Long) obj[0], facilityid);
                            if (parentLevels != null && !parentLevels.isEmpty()) {
                                for (Facilityunithierachy parentLevel : parentLevels) {
                                    if(!hyrchList.contains(parentLevel)){
                                        hyrchList.add(parentLevel);
                                    }
                                }
                            }
                        }
                    }
                    if(hyrchList!=null && !hyrchList.isEmpty()){
                        logger.info("hyrchList Size:::"+hyrchList.size());
                        Collections.reverse(hyrchList);
                        for (Facilityunithierachy parentLevel : hyrchList) {
                            logger.info("Label:::"+parentLevel.getFacilitystructure().getHierachylabel()+" ---- Name:::"+parentLevel.getFacilityunitname());
                        }
                    }
                    model.put("hyrchList", hyrchList);        
                    model.put("unitObj", unit);
                }
                if (isUnitObj == false) {
                    Facilityunithierachy unit = new Facilityunithierachy(id);
                    String[] unitFields2 = {"facilityunitid", "facilityunitname", "shortname", "description", "active", "location", "telephone", "service"};
                    unitListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunithierachy.class, unitFields2, "WHERE r.facilityunitid=:Id AND r.facility.facilityid=:facId", new String[]{"Id", "facId"}, new Object[]{id, facilityid});
                    if (unitListArr != null) {
                        for (Object[] unitObj : unitListArr) {
                            unit.setFacilityunitname((String) unitObj[1]);
                            unit.setShortname((String) unitObj[2]);
                            unit.setDescription((String) unitObj[3]);
                            unit.setActive((Boolean) unitObj[4]);
                            unit.setLocation((String) unitObj[5]);
                            unit.setTelephone((String) unitObj[6]);
                            unit.setService((Boolean) unitObj[7]);
                            int subUnits = genericClassService.fetchRecordCount(Facilityunithierachy.class, "WHERE r.facilityunithierachy.facilityunitid=:unitId AND r.facility.facilityid=:facId", new String[]{"unitId", "facId"}, new Object[]{(Long) unitObj[0], facilityid});
                            if(subUnits==0){
                                subUnits = genericClassService.fetchRecordCount(Facilityunit.class, "WHERE r.facilityunithierachy.facilityunitid=:unitId AND r.facilityid=:facId", new String[]{"unitId", "facId"}, new Object[]{(Long) unitObj[0], facilityid});
                                if(subUnits>0){
                                    isAttachedUnit=true;
                                }
                            }
                            unit.setSubunits(subUnits);
                            List<Object[]> unitHyrchListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunithierachy.class, new String[]{"facilitystructure.structureid", "facilitystructure.hierachylabel"}, "WHERE r.facilityunitid=:Id AND r.facility.facilityid=:facId", new String[]{"Id", "facId"}, new Object[]{id, facilityid});
                            if (unitHyrchListArr != null) {
                                Facilitystructure hyrch2 = new Facilitystructure();
                                for (Object[] obj : unitHyrchListArr) {
                                    hyrch2 = new Facilitystructure((Long) obj[0]);
                                    hyrch2.setHierachylabel((String) obj[1]);
                                }
                                unit.setFacilitystructure(hyrch2);
                            }
                            List<Object[]> unitAddDateArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunithierachy.class, new String[]{"dateadded", "person.firstname", "person.lastname"}, "WHERE r.facilityunitid=:Id AND r.facility.facilityid=:facId", new String[]{"Id", "facId"}, new Object[]{id, facilityid});
                            if (unitAddDateArr != null) {
                                for (Object[] obj : unitAddDateArr) {
                                    unit.setDateadded((Date) obj[0]);
                                    Person addedBy = new Person();
                                    addedBy.setFirstname((String) obj[1]);
                                    addedBy.setLastname((String) obj[2]);
                                    unit.setPerson(addedBy);
                                }
                            }
                            List<Object[]> unitUpdateDateArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunithierachy.class, new String[]{"dateupdated", "person1.firstname", "person1.lastname"}, "WHERE r.facilityunitid=:Id AND r.facility.facilityid=:facId", new String[]{"Id", "facId"}, new Object[]{id, facilityid});
                            if (unitUpdateDateArr != null) {
                                for (Object[] obj : unitUpdateDateArr) {
                                    unit.setDateadded((Date) obj[0]);
                                    Person updatedBy = new Person();
                                    updatedBy.setFirstname((String) obj[1]);
                                    updatedBy.setLastname((String) obj[2]);
                                    unit.setPerson1(updatedBy);
                                }
                            }
//                        facilityUnitList.add(unit);
                        }
                    }
                    
                        List<Facilityunithierachy> hyrchList = new ArrayList<Facilityunithierachy>();
                        if (unit.getFacilitystructure() != null) {
                            List<Facilityunithierachy> parentLevels = getChildParentdElements(activity, unit.getFacilitystructure().getStructureid(), facilityid);
                            if (parentLevels != null && !parentLevels.isEmpty()) {
                                for (Facilityunithierachy parentLevel : parentLevels) {
                                    hyrchList.add(parentLevel);
                                }
                            }
                            Collections.reverse(hyrchList);
                        }
                        model.put("hyrchList", hyrchList);
                    
                    model.put("unitObj", unit);
                }
                
                List<Object[]> unitLevelsArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunithierachy.class, new String[]{"facilityunitid", "facilityunitname", "facilitystructure.structureid", "facilitystructure.hierachylabel"}, "WHERE r.facility.facilityid=:facId AND r.facilityunithierachy.facilityunitid IS NULL", new String[]{"facId"}, new Object[]{facilityid});
                model.put("unitLevelsArr", unitLevelsArr);
                model.put("viewForm", true);
                model.put("isUnitObj", isUnitObj);
                model.put("isAttachedUnit", isAttachedUnit);
                model.put("formActivity", "Update"); 
                model.put("returnURL", request.getSession().getAttribute("sessReturnSelectedFacilityUnitUrl").toString());
                return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/forms/formAddUnit", "model", model);
            }
            if (activity.equals("d")) {
                boolean isAttachedUnit=false;
                request.getSession().setAttribute("sessReturnSelectedFacilityUnitUrl", "ajaxSubmitData('facilityUnitSetting.htm', 'addnew-pane', 'act="+activity+"&i="+id+"&b="+strVal+"&c="+strVal2+"&d="+id2+"&ofst="+offset+"&maxR="+maxResults+"&sStr="+searchPhrase+"', 'GET');");
                Facilitystructure hyrch = new Facilitystructure();
                model.put("facilityType", "Facilitystructure");
                String[] params = {"Id"};
                Object[] paramsValues = {id};
                hyrchListArr = (List<Object[]>) genericClassService.fetchRecord(Facilitystructure.class, structureFields, "WHERE r.structureid=:Id", params, paramsValues);
                if (hyrchListArr != null) { 
                    for (Object[] obj : hyrchListArr) {
                        hyrch = new Facilitystructure((Long) obj[0]);
                        hyrch.setHierachylabel((String) obj[1]);
                        hyrch.setDescription((String) obj[2]);
                        hyrch.setService((Boolean) obj[4]);
                        
                        int chkParent = genericClassService.fetchRecordCount(Facilitystructure.class, "WHERE r.structureid=:Id AND r.facilitystructure IS NULL", new String[]{"Id"}, new Object[]{(Long) obj[0]});
                        boolean isParent = false;
                        if (chkParent > 0) {
                            isParent = true;
                        }
                        hyrch.setIsparent(isParent);
                        
                        if(hyrch.getService()==true){
                            unitListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, unitFields, "WHERE r.facilitystructure.structureid=:Id AND r.facilityid=:facId ORDER BY r.facilityunitname ASC", new String[]{"Id","facId"}, new Object[]{(Long) obj[0],facilityid});
                            if (unitListArr != null) {
                                for (Object[] unitObj : unitListArr) {
                                    Facilityunit unit = new Facilityunit((Long)unitObj[0]);
                                    unit.setFacilityunitname((String)unitObj[1]);
                                    unit.setShortname((String)unitObj[2]);
                                    unit.setDescription((String)unitObj[3]);
                                    unit.setActive((Boolean)unitObj[4]);
                                    int subUnits = 0; //genericClassService.fetchRecordCount(Facilityunit.class, "WHERE r.facilityunit.facilityunitid=:unitId AND r.facilityid=:facId", new String[]{"unitId","facId"}, new Object[]{(Long) unitObj[0],facilityid});
                                    unit.setSubunits(subUnits);
                                    facilityUnitList.add(unit);
                                }
                            }
                            model.put("hyrchObjType", "Unit");
                            hyrch.setFacilityunitList(facilityUnitList);
                        }
                        if(hyrch.getService()==false){
                            unitListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunithierachy.class, unitFields, "WHERE r.facilitystructure.structureid=:Id AND r.facility.facilityid=:facId ORDER BY r.facilityunitname ASC", new String[]{"Id","facId"}, new Object[]{(Long) obj[0],facilityid});
                            if (unitListArr != null) {
                                for (Object[] unitObj : unitListArr) {
                                    Facilityunithierachy unit = new Facilityunithierachy((Long)unitObj[0]);
                                    unit.setFacilityunitname((String)unitObj[1]);
                                    unit.setShortname((String)unitObj[2]);
                                    unit.setDescription((String)unitObj[3]);
                                    unit.setActive((Boolean)unitObj[4]);
                                    int subUnits = genericClassService.fetchRecordCount(Facilityunithierachy.class, "WHERE r.facilityunithierachy.facilityunitid=:unitId AND r.facility.facilityid=:facId", new String[]{"unitId","facId"}, new Object[]{(Long) unitObj[0],facilityid});
                                    if(subUnits==0){
                                        subUnits = genericClassService.fetchRecordCount(Facilityunit.class, "WHERE r.facilityunithierachy.facilityunitid=:unitId AND r.facilityid=:facId", new String[]{"unitId", "facId"}, new Object[]{(Long) unitObj[0], facilityid});
                                        if(subUnits>0){
                                            isAttachedUnit=true;
                                        }
                                    }
                                    unit.setSubunits(subUnits);
                                    hierachyUnitList.add(unit);
                                }
                            }
                            model.put("hyrchObjType", "Level");
                            hyrch.setFacilityunithierachyList(hierachyUnitList);
                        }
                    }
                    model.put("hyrchObj", hyrch);
                    //Select Mode
                    request.getSession().setAttribute("sessViewUnitsLevel", hyrch);
                    
                }
                model.put("isAttachedUnit", isAttachedUnit);
                return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/views/viewHyrchUnitDetails", "model", model);
            }
            if (activity.equals("e")) {
                request.getSession().setAttribute("sessReturnSelectedFacilityUnitUrl", "ajaxSubmitData('facilityUnitSetting.htm', 'addnew-pane', 'act="+activity+"&i="+id+"&b="+strVal+"&c="+strVal2+"&d="+id2+"&ofst="+offset+"&maxR="+maxResults+"&sStr="+searchPhrase+"', 'GET');");
                unitListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, unitFields, "WHERE r.facilitystructure IS NULL AND r.facilityid=:facId ORDER BY r.facilityunitname ASC", new String[]{"facId"}, new Object[]{facilityid});
                if (unitListArr != null) {
                    for (Object[] unitObj : unitListArr) {
                        Facilityunit unit = new Facilityunit((Long) unitObj[0]);
                        unit.setFacilityunitname((String) unitObj[1]);
                        unit.setShortname((String) unitObj[2]);
                        unit.setDescription((String) unitObj[3]);
                        unit.setActive((Boolean) unitObj[4]);
                        int subUnits = 0;//genericClassService.fetchRecordCount(Facilityunit.class, "WHERE r.facilityunit.facilityunitid=:unitId AND r.facilityid=:facId", new String[]{"unitId", "facId"}, new Object[]{(Long) unitObj[0], facilityid});
                        unit.setSubunits(subUnits);
                        facilityUnitList.add(unit);
                    }
                     model.put("size", facilityUnitList.size());
                }
                model.put("facilityUnitList", facilityUnitList);
                
                return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/views/viewUnitDetails", "model", model);
            }
            if (activity.equals("f")) {
                if(strVal2.equals("true")) {
                    genericClassService.deleteRecordByByColumns(Facilityunit.class, new String[]{"facilityunitid", "facilityid"}, new Object[]{id, facilityid});
                    //Checking for successful deletion
                    if (genericClassService.fetchRecord(Facilityunit.class, new String[]{"facilityunitid"}, "WHERE r.facilityunitid=:Id AND r.facilityid=:facId", new String[]{"Id", "facId"}, new Object[]{id, facilityid}) == null) {
                        logger.info("Response :Deleted:: ");
                        model.put("resp", true);
                        model.put("successMessage", "Successfully Deleted");
                    } else {
                        Facilityunit unit = new Facilityunit(id);
                        unitListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, unitFields, "WHERE r.facilityunitid=:Id AND r.facilityid=:facId", new String[]{"Id", "facId"}, new Object[]{id, facilityid});
                        if (unitListArr != null) {
                            for (Object[] unitObj : unitListArr) {
                                unit.setFacilityunitname((String) unitObj[1]);
                                int subUnits = genericClassService.fetchRecordCount(Facilityunit.class, "WHERE r.facilityunit.facilityunitid=:unitId AND r.facilityid=:facId", new String[]{"unitId", "facId"}, new Object[]{(Long) unitObj[0], facilityid});
                                if (subUnits > 0) {
                                    unit.setActive(true);
                                }
                                unit.setSubunits(subUnits);
                            }
                        }
                        model.put("unitObj", unit);
                        model.put("resp", false);
                        model.put("errorMessage", "Facility Unit Not Deleted!!");
                    }
                }else {
                    genericClassService.deleteRecordByByColumns(Facilityunithierachy.class, new String[]{"facilityunitid", "facilityid"}, new Object[]{id, facilityid});
                    //Checking for successful deletion
                    if (genericClassService.fetchRecord(Facilityunithierachy.class, new String[]{"facilityunitid"}, "WHERE r.facilityunitid=:Id AND r.facilityid=:facId", new String[]{"Id", "facId"}, new Object[]{id, facilityid}) == null) {
                        logger.info("Response :Deleted:: ");
                        model.put("resp", true);
                        model.put("successMessage", "Successfully Deleted");
                    } else {
                        Facilityunit unit = new Facilityunit(id);
                        unitListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunithierachy.class, unitFields, "WHERE r.facilityunitid=:Id AND r.facilityid=:facId", new String[]{"Id", "facId"}, new Object[]{id, facilityid});
                        if (unitListArr != null) {
                            for (Object[] unitObj : unitListArr) {
                                unit.setFacilityunitname((String) unitObj[1]);
                                int subUnits = genericClassService.fetchRecordCount(Facilityunithierachy.class, "WHERE r.facilityunit.facilityunitid=:unitId AND r.facilityid=:facId", new String[]{"unitId", "facId"}, new Object[]{(Long) unitObj[0], facilityid});
                                if (subUnits > 0) {
                                    unit.setActive(true);
                                }
                                unit.setSubunits(subUnits);
                            }
                        }
                        model.put("unitObj", unit);
                        model.put("resp", false);
                        model.put("errorMessage", "Facility Unit Not Deleted!!");
                    }
                }
                
                model.put("mainActivity", "Discard Units");
               return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/views/response", "model", model); 
            }
            if (activity.equals("g")) {
                request.getSession().setAttribute("sessReturnSelectedFacilityUnitUrl", "ajaxSubmitData('facilityUnitSetting.htm', 'addnew-pane', 'act="+activity+"&i="+id+"&b="+strVal+"&c="+strVal2+"&d="+id2+"&ofst="+offset+"&maxR="+maxResults+"&sStr="+searchPhrase+"', 'GET');");
                unitListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, unitFields, "WHERE r.facilityunitid=:unitId AND r.facilityid=:facId ORDER BY r.facilityunitname ASC", new String[]{"facId","unitId"}, new Object[]{facilityid,id});
                if (unitListArr != null) {
                    for (Object[] unitObj : unitListArr) {
                        Facilityunit unit = new Facilityunit((Long) unitObj[0]);
                        unit.setFacilityunitname((String) unitObj[1]);
                        unit.setShortname((String) unitObj[2]);
                        unit.setDescription((String) unitObj[3]);
                        unit.setActive((Boolean) unitObj[4]);
                        int subUnits = genericClassService.fetchRecordCount(Facilityunit.class, "WHERE r.facilityunit.facilityunitid=:unitId AND r.facilityid=:facId", new String[]{"unitId", "facId"}, new Object[]{(Long) unitObj[0], facilityid});
                        unit.setSubunits(subUnits);
                        facilityUnitList.add(unit);
                    }
                     model.put("size", facilityUnitList.size());
                }
                model.put("facilityUnitList", facilityUnitList);
                
                return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/views/viewUnitDetails", "model", model);
            }
            if (activity.equals("h")) {
                boolean isAttachedUnit=Boolean.parseBoolean(strVal);
                
                    Facilityunithierachy unit = new Facilityunithierachy(id);
                    unitListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunithierachy.class, new String[]{"facilityunitid", "facilityunitname", "facilitystructure.structureid", "facilitystructure.hierachylabel"}, "WHERE r.facilityunitid=:Id AND r.facility.facilityid=:facId", new String[]{"Id", "facId"}, new Object[]{id, facilityid});
                    if (unitListArr != null) {
                        for (Object[] unitObj : unitListArr) {
                            unit.setFacilityunitname((String) unitObj[1]);
                            Facilitystructure hyrch = new Facilitystructure((Long) unitObj[2]);
                            hyrch.setHierachylabel((String) unitObj[3]);
                            unit.setFacilitystructure(hyrch);
                        }
                    }
                    model.put("unitObj", unit);
                
                List<Object[]> transferArrList = (List<Object[]>) genericClassService.fetchRecord(Facilityunithierachy.class, new String[]{"facilityunitid", "facilityunitname", "facilitystructure.structureid", "facilitystructure.hierachylabel"}, 
                        "WHERE (r.facilityunitid!=:Id OR (r.facilityunithierachy IS NOT NULL AND r.facilityunithierachy.facilityunitid!=:Id)) AND r.facility.facilityid=:facId AND r.facilitystructure.facilitystructure IS NULL", new String[]{"Id", "facId"}, new Object[]{id, facilityid});
                model.put("transferArrList", transferArrList);
                
                int unitSize=0;
                    List<Facilityunithierachy> unitHychList = new ArrayList<Facilityunithierachy>();
                    String[] hychFields = {"facilityunitid", "facilityunitname", "facilitystructure.structureid", "facilitystructure.hierachylabel"};
                    List<Object[]> unitHychArrList = (List<Object[]>) genericClassService.fetchRecord(Facilityunithierachy.class, hychFields, "WHERE r.facilityunithierachy.facilityunitid=:Id AND r.facility.facilityid=:facId", new String[]{"Id", "facId"}, new Object[]{id, facilityid});
                    if (unitHychArrList != null) {
                        model.put("size", unitHychArrList.size());
                        unitSize=unitHychArrList.size();
                        if(unitSize>0){
                            model.put("unitHychArrList", unitHychArrList);
                        }
                    }
                    if(unitSize==0){
                        List<Facilityunit> unitList = new ArrayList<Facilityunit>();
                        String[] unitFields2 = {"facilityunitid", "facilityunitname", "facilitystructure.structureid", "facilitystructure.hierachylabel"};
                        List<Object[]> unitArrList = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, unitFields2, "WHERE r.facilityunithierachy.facilityunitid=:Id AND r.facilityid=:facId", new String[]{"Id", "facId"}, new Object[]{id, facilityid});
                        if (unitArrList != null) {
                            isAttachedUnit=true;
                            model.put("size", unitArrList.size());
                        }
                        model.put("unitHychArrList", unitArrList);
                    }
                
                model.put("isAttachedUnit", isAttachedUnit);
                model.put("returnURL", request.getSession().getAttribute("sessReturnSelectedFacilityUnitUrl").toString());
                return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/forms/formTransferUnit", "model", model);
            }
            if (activity.equals("i")) {
                //Transfer Units Under ID
                unitListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, new String[]{"facilityunitid", "facilityunitname"}, "WHERE r.facilityunit.facilityunitid=:Id", new String[]{"Id"}, new Object[]{id2});
                if (unitListArr != null) {
                    for (Object[] obj : unitListArr) {
                        genericClassService.updateRecordSQLStyle(Facilityunit.class, new String[]{"parentid"},
                        new Object[]{id}, "facilityunitid", (Long)obj[0]);
                    }
                }
                int chkChildrenAttached = genericClassService.fetchRecordCount(Facilityunit.class, "WHERE r.facilityunit.facilityunitid=:Id", new String[]{"Id"}, new Object[]{id2});
                if(chkChildrenAttached>0){
                    model.put("resp", false);
                    model.put("errorMessage", "Transfer Of Children Units Failed!");
                }else{
                    model.put("resp", true);
                    model.put("successMessage", "Successfully Transfered Attached Units!");
                }
                model.put("mainActivity", "Transfer Unit");
                return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/views/unitResponse", "model", model);
            }
            if (activity.equals("j")) {
                List<Object[]> facUnitArrList = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, new String[]{"facilityunitid", "facilityunitname"}, "WHERE r.facilityunitid=:Id", new String[]{"Id"}, new Object[]{id});
                Facilityunit facUnitObj = new Facilityunit();
                if (facUnitArrList != null) {
                    facUnitObj = new Facilityunit((Long) facUnitArrList.get(0)[0]);
                    facUnitObj.setFacilityunitname((String) facUnitArrList.get(0)[1]);
                }
                model.put("facUnitObj", facUnitObj);
                List<Facilityunit> unitList = new ArrayList<>();
                unitListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, new String[]{"facilityunitid", "facilityunitname", "facilitystructure.structureid", "facilitystructure.hierachylabel"}, "WHERE r.facilityid=:facId AND r.facilityunitid=:unitId ORDER BY r.facilityunitname ASC", new String[]{"facId","unitId"}, new Object[]{facilityid,id});
                model.put("unitListArr", unitListArr);
                if (unitListArr != null && !unitListArr.isEmpty()) {
                    for (Object[] obj : unitListArr) {
                        Facilityunit unit = new Facilityunit((Long) obj[0]);
                        unit.setFacilityunitname((String) obj[1]);
                        Facilitystructure hyrch = new Facilitystructure((Long) obj[2]);
                        hyrch.setHierachylabel((String) obj[3]);
                        unit.setFacilitystructure(hyrch);
                        
//                        List<Facilityunit> unitChildList = getUnitChildElements("a", unit, unit.getFacilityunitid(), facilityid);
                        int size=0;
//                        if(unitChildList!=null){
//                            unit.setFacilityunitList(unitChildList);
//                            size=unitChildList.size();
//                        }
                        unit.setSubunits(size);
                        unitList.add(unit);
                    }
                    model.put("size", unitList.size());
                }
                model.put("unitList", unitList);
                model.put("facilityType", "Unit Chart");
                return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/forms/unitChart", "model", model);
            }
            if (activity.equals("k")) {
                Facilitystructure hyrchSelect = new Facilitystructure();
                String[] params2 = {"Id", "state", "levelId"};
                        Object[] paramsValues2 = {facilityid, true, id};
                        List<Object[]> hyrchArrList = (List<Object[]>) genericClassService.fetchRecord(Facilityunithierachy.class, new String[]{"facilityunitid", "facilityunitname", "facilitystructure.structureid", "facilitystructure.hierachylabel", "facilitystructure.service"}, "WHERE r.facilityunithierachy.facilityunitid IS NULL AND r.facility.facilityid=:Id AND r.active=:state AND r.facilitystructure.structureid!=:levelId", params2, paramsValues2);
                        if (hyrchArrList != null) {
                            for (Object[] unitObj : hyrchArrList) {
                                Facilityunithierachy unit = new Facilityunithierachy((Long) unitObj[0]);
                                unit.setFacilityunitname((String) unitObj[1]);
                                logger.info("Level Name :::: "+(String) unitObj[1]+" Structure ::: "+(Long) unitObj[2]);
                                hyrchSelect = new Facilitystructure((Long) unitObj[2]);
                                hyrchSelect.setHierachylabel((String) unitObj[3]);
                                hyrchSelect.setService((Boolean) unitObj[4]);
                                unit.setFacilitystructure(hyrchSelect);
                                hierachyUnitList.add(unit);
                            }
                            model.put("levelHyrchObj", hyrchSelect);
                        }
                    model.put("serviceLevelObj", hyrchSelect.getService()); 
                    
                    Facilitystructure selectedHyrch = (Facilitystructure) request.getSession().getAttribute("sessViewUnitsLevel");
                    logger.info("Selected Hierarchy :::::: " + selectedHyrch.getHierachylabel());
                    List<Object[]> checkNextLevel = (List<Object[]>) genericClassService.fetchRecord(Facilitystructure.class, structureFields, "WHERE r.facilitystructure.structureid=:Id AND r.facility.facilityid=:facId", new String[]{"Id", "facId"}, new Object[]{selectedHyrch.getStructureid(), facilityid});
                    if (checkNextLevel != null) {
                        logger.info("Next Hierarchy :::::: " + (String) checkNextLevel.get(0)[1]);
                        long nextId = (Long) checkNextLevel.get(0)[0];
                        if (nextId == selectedHyrch.getStructureid()) {
                            model.put("returnUnits", true);
                        }else{
                            model.put("returnUnits", false);
                        }
                    }else{
                        model.put("returnUnits", true);
                    }
                
                
                model.put("hyrchList", hierachyUnitList); 
                model.put("formActivity", "UnitSelectByStructure");
                logger.info("Return Page Here :::: structureLoader");
                return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/forms/structureLoader", "model", model);
            }
            if (activity.equals("m")) {
                //Call Form To Update A Unit
                boolean hasStructure=false;
                Facilityunit funitObj = new Facilityunit(id);
                String[] unitFields2 = {"facilityunitid", "facilityunitname", "service"};
                unitListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, unitFields2, "WHERE r.facilityunitid=:Id AND r.facilityid=:facId", new String[]{"Id", "facId"}, new Object[]{id, facilityid});
                if (unitListArr != null) {
                    for (Object[] unit : unitListArr) {
                        funitObj.setFacilityunitname((String) unit[1]);
                        funitObj.setShortname((String) unit[1]);
                        funitObj.setService((Boolean) unit[2]);
                        List<Object[]> unitHyrchListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, new String[]{"facilitystructure.structureid", "facilitystructure.hierachylabel"}, "WHERE r.facilityunitid=:Id AND r.facilityid=:facId", new String[]{"Id", "facId"}, new Object[]{id, facilityid});
                        if (unitHyrchListArr != null && !unitHyrchListArr.isEmpty()) {
                            Facilitystructure hyrch2 = new Facilitystructure();
                            for (Object[] obj : unitHyrchListArr) {
                                hyrch2 = new Facilitystructure((Long) obj[0]);
                                hyrch2.setHierachylabel((String) obj[1]);
                                hasStructure=true;
                            }
                            funitObj.setFacilitystructure(hyrch2);
                        }
                    }
                }
                
                //******Determine Parent Layers and Objects********
                if(hasStructure==true){
                    Facilitystructure hyrch = new Facilitystructure();
                    String[] params = {"Id", "facId"};
                    Object[] paramsValues = {funitObj.getFacilitystructure().getStructureid(),facilityid};
                    hyrchListArr = (List<Object[]>) genericClassService.fetchRecord(Facilitystructure.class, structureFields, "WHERE r.structureid=:Id AND r.facility.facilityid=:facId", params, paramsValues);
                    if (hyrchListArr != null) {
                        for (Object[] obj : hyrchListArr) {
                            hyrch = new Facilitystructure((Long) obj[0]);
                            hyrch.setHierachylabel((String) obj[1]);
                            hyrch.setDescription((String) obj[2]);
                            hyrch.setService((Boolean) obj[4]);
                        }
                        model.put("hyrchObj", hyrch);

                        if(hyrch.getService()==false){
                            Facilitystructure hyrchSelect = new Facilitystructure();
                            String[] params2 = {"Id", "state", "structureId"};
                            Object[] paramsValues2 = {facilityid, true, id};
                            List<Object[]> hyrchArrList = (List<Object[]>) genericClassService.fetchRecord(Facilityunithierachy.class, new String[]{"facilityunithierachy.facilityunitid", "facilityunithierachy.facilityunitname", "facilityunithierachy.facilitystructure.structureid", "facilityunithierachy.facilitystructure.hierachylabel", "facilityunithierachy.facilitystructure.service"}, "WHERE r.facilitystructure.structureid=:structureId AND r.facility.facilityid=:Id AND r.active=:state", params2, paramsValues2);
                            if (hyrchArrList != null) {
                                for (Object[] unitObj : hyrchArrList) {
                                    Facilityunithierachy unit = new Facilityunithierachy((Long) unitObj[0]);
                                    unit.setFacilityunitname((String) unitObj[1]);
                                    logger.info("Level Name :::: "+(String) unitObj[1]+" Structure ::: "+(Long) unitObj[2]);
                                    hyrchSelect = new Facilitystructure((Long) unitObj[2]);
                                    hyrchSelect.setHierachylabel((String) unitObj[3]);
                                    hyrchSelect.setService((Boolean) unitObj[4]);
                                    unit.setFacilitystructure(hyrchSelect);
                                    hierachyUnitList.add(unit);
                                }
                                hyrchArrList = (List<Object[]>) genericClassService.fetchRecord(Facilityunithierachy.class, new String[]{"facilityunitid", "facilityunitname", "facilitystructure.structureid", "facilitystructure.hierachylabel", "facilitystructure.service"}, "WHERE r.facilitystructure.structureid=:structureId AND r.facility.facilityid=:Id AND r.active=:state", new String[]{"Id", "state", "structureId"}, new Object[]{facilityid, true, hyrchSelect.getStructureid()});
                                if (hyrchArrList != null) {
                                    for (Object[] unitObj : hyrchArrList) {
                                        Facilityunithierachy unit = new Facilityunithierachy((Long) unitObj[0]);
                                        unit.setFacilityunitname((String) unitObj[1]);
                                        logger.info("Level Name :::: "+(String) unitObj[1]);
                                        hyrchSelect = new Facilitystructure((Long) unitObj[2]);
                                        hyrchSelect.setHierachylabel((String) unitObj[3]);
                                        hyrchSelect.setService((Boolean) unitObj[4]);
                                        unit.setFacilitystructure(hyrchSelect);
                                        if(!hierachyUnitList.contains(unit)){
                                            hierachyUnitList.add(unit);
                                        }
                                    }
                                }
                                model.put("levelHyrchObj", hyrchSelect);
                            }
                        }
                        else{
                            Facilitystructure hyrchSelect = new Facilitystructure();
                            String[] params2 = {"Id", "state"};
                            Object[] paramsValues2 = {facilityid, true};
                            List<Object[]> hyrchArrList = (List<Object[]>) genericClassService.fetchRecord(Facilityunithierachy.class, new String[]{"facilityunitid", "facilityunitname", "facilitystructure.structureid", "facilitystructure.hierachylabel", "facilitystructure.service"}, "WHERE r.facilityunithierachy.facilityunitid IS NULL AND r.facility.facilityid=:Id AND r.active=:state", params2, paramsValues2);
                            if (hyrchArrList != null) {
                                for (Object[] unitObj : hyrchArrList) {
                                    Facilityunithierachy unit = new Facilityunithierachy((Long) unitObj[0]);
                                    unit.setFacilityunitname((String) unitObj[1]);
                                    logger.info("Level Name :::: "+(String) unitObj[1]+" Structure ::: "+(Long) unitObj[2]);
                                    hyrchSelect = new Facilitystructure((Long) unitObj[2]);
                                    hyrchSelect.setHierachylabel((String) unitObj[3]);
                                    hyrchSelect.setService((Boolean) unitObj[4]);
                                    unit.setFacilitystructure(hyrchSelect);
                                    hierachyUnitList.add(unit);
                                }
                                model.put("levelHyrchObj", hyrchSelect);
                            }
                        }
                        model.put("serviceLevelObj", hyrch.getService()); 
                    }
                }else{
                    String[] params = {"Id","state"};
                    Object[] paramsValues = {facilityid,true};
                    List<Object[]> hyrchsListArr = (List<Object[]>) genericClassService.fetchRecord(Facilitystructure.class, new String[]{"structureid","hierachylabel"}, "WHERE r.facility.facilityid=:Id AND r.service=:state", params, paramsValues);
                    model.put("structureListArr", hyrchsListArr); 
                    
                    //Expected To Be Reached By Only Units
                    Facilitystructure hyrchSelect = new Facilitystructure();
                    String[] params2 = {"Id", "state"};
                    Object[] paramsValues2 = {facilityid, true};
                    List<Object[]> hyrchArrList = (List<Object[]>) genericClassService.fetchRecord(Facilityunithierachy.class, new String[]{"facilityunitid", "facilityunitname", "facilitystructure.structureid", "facilitystructure.hierachylabel", "facilitystructure.service"}, "WHERE r.facilityunithierachy.facilityunitid IS NULL AND r.facility.facilityid=:Id AND r.active=:state", params2, paramsValues2);
                    if (hyrchArrList != null) {
                        for (Object[] unitObj : hyrchArrList) {
                            Facilityunithierachy unit = new Facilityunithierachy((Long) unitObj[0]);
                            unit.setFacilityunitname((String) unitObj[1]);
                            logger.info("Level Name :::: " + (String) unitObj[1] + " Structure ::: " + (Long) unitObj[2]);
                            hyrchSelect = new Facilitystructure((Long) unitObj[2]);
                            hyrchSelect.setHierachylabel((String) unitObj[3]);
                            hyrchSelect.setService((Boolean) unitObj[4]);
                            unit.setFacilitystructure(hyrchSelect);
                            hierachyUnitList.add(unit);
                        }
                        model.put("levelHyrchObj", hyrchSelect);
                    }
                    model.put("unstructuredUnits", true);
                    model.put("serviceLevelObj", true); 
                }
                
                model.put("unitObj", funitObj); 
                model.put("hyrchList", hierachyUnitList); 
                model.put("formActivity", "UpdateStructure"); 
                model.put("returnURL", request.getSession().getAttribute("sessReturnSelectedFacilityUnitUrl").toString());
                return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/forms/updateUnitStructure", "model", model);
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
    @RequestMapping("/facilityUnitUpdate.htm")
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView facilityUnitUpdate(Principal principal, HttpServletRequest request,
            @RequestParam("act") String activity, @RequestParam("i") long id, @RequestParam("d") long id2,
            @RequestParam("b") String strVal, @RequestParam("c") String strVal2,
            @RequestParam("ofst") int offset, @RequestParam("maxR") int maxResults,
            @RequestParam("sStr") String searchPhrase) {
        if (principal == null) {
            return new ModelAndView("login");
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
    @RequestMapping(value = "/registerFacUnitHierachy.htm", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView registerFacUnitHierachy(HttpServletRequest request, Principal principal) {
        logger.info("Received Request To Add Facility Unit Hierarchy");
        Map<String, Object> model = new HashMap<String, Object>();
        Facilityunithierachy unitObj = new Facilityunithierachy();
        boolean updateActivity = false;
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }
            long unitId = 0;
            if (request.getParameter("cref") != null && !request.getParameter("cref").isEmpty()) {
                unitId = Long.parseLong(request.getParameter("cref"));
                updateActivity = true;
            }
            long parentId = 0;
            if (request.getParameter("parentId") != null && !request.getParameter("parentId").isEmpty()) {
                parentId = Long.parseLong(request.getParameter("parentId"));
            }
            long facilityStructureid = 0;
            if (request.getParameter("hyrchId") != null && !request.getParameter("hyrchId").isEmpty()) {
                facilityStructureid = Long.parseLong(request.getParameter("hyrchId"));
            }
            //long facilityStructureid = Long.parseLong(request.getParameter("hyrchId"));
            int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
            String unitname = request.getParameter("facilityunitname");
            String shortname = request.getParameter("shortname");
            String description = request.getParameter("description");
            String telContact = request.getParameter("telContact");
            String location = request.getParameter("location");
            boolean status = Boolean.parseBoolean(request.getParameter("status"));
            boolean service = Boolean.parseBoolean(request.getParameter("service"));
            
            String facilityunitname = "";
            if(updateActivity==false){
                BreakIterator wordBreaker = BreakIterator.getWordInstance();
                String str = unitname.trim();
                wordBreaker.setText(str);
                int end = 0;
                for (int start = wordBreaker.first();
                        (end = wordBreaker.next()) != BreakIterator.DONE; start = end) {
                    String word = str.substring(start, end);
                    String joined_word = word.substring(0, 1).toUpperCase() + word.substring(1).toLowerCase();
                    if (end != 0) {
                        facilityunitname += joined_word;
                    }
                }       
            }else{
                facilityunitname=unitname;
            }
            logger.info("updateActivity ::: " + updateActivity);
            

            String[] param2 = {"name","facId"};
            Object[] paramsValue2 = {facilityunitname.toLowerCase(),facilityid};
            String[] field2 = {"facilityunitid", "facilityunitname", "description", "active"};
            List<Object[]> existingUnitList = (List<Object[]>) genericClassService.fetchRecord(Facilityunithierachy.class, field2, "WHERE LOWER(r.facilityunitname)=:name AND r.facility.facilityid=:facId", param2, paramsValue2);
            if (existingUnitList != null) {
                boolean exist = false;
                List<Facilityunithierachy> existingList = new ArrayList<Facilityunithierachy>();
                for (Object[] obj : existingUnitList) {
                    Facilityunithierachy unit = new Facilityunithierachy((Long) obj[0]);
                        unit.setFacilityunitname((String) obj[1]);
                        unit.setDescription((String) obj[2]);
                        unit.setActive((Boolean) obj[3]);
                    existingList.add(unit);
                    exist = true;
                    if (unitId == (Long) obj[0]) {
                        exist = false;
                    }
                }
                model.put("resp", false);
                model.put("errorMessage", "Already Existing Facility Unit Level");
                model.put("facilityUnitList", existingList);
                if (exist == true) {
                    model.put("mainActivity", "Facility Unit-2");
                    return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/views/unitResponse", "model", model);
                }
            }

            List<Facilityunithierachy> existingList = new ArrayList<Facilityunithierachy>();
            long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
            unitObj.setFacility(new Facility(facilityid));
            unitObj.setFacilityunitname(facilityunitname);
            unitObj.setShortname(shortname);
            unitObj.setDescription(description);
            unitObj.setActive(status);
            unitObj.setService(service);
            unitObj.setLocation(location);
            unitObj.setTelephone(telContact);
            if(facilityStructureid!=0){
                unitObj.setFacilitystructure(new Facilitystructure(facilityStructureid));
            }
            if(parentId!=0){
                unitObj.setMainfacilityunit(parentId);
                unitObj.setFacilityunithierachy(new Facilityunithierachy(parentId));
            }
            unitObj.setDateadded(new Date());
            unitObj.setPerson(new Person(pid));

            if (updateActivity == false) {
                genericClassService.saveOrUpdateRecordLoadObject(unitObj);
                List<Object[]> addedUnitList =(List<Object[]>) genericClassService.fetchRecord(Facilityunithierachy.class, new String[]{"facilityunitid"}, "WHERE r.facilityunitid=:Id", new String[]{"Id"}, new Object[]{unitObj.getFacilityunitid()});
                if (addedUnitList!= null && !addedUnitList.isEmpty()) {
                    model.put("resp", true);
                    model.put("successMessage", "Successfully Added New Facility Unit Level");
                } else {
                    model.put("resp", false);
                    model.put("errorMessage", "Facility Unit Level Not Added");
                }
                
            } else {
                    genericClassService.updateRecordSQLStyle(Facilityunithierachy.class, new String[]{"facilityunitname", "shortname", "description", "location", "telephone", "active", "service", "updatedby", "dateupdated"},
                        new Object[]{facilityunitname, shortname, description, location, telContact, status, service, pid, new Date()}, "facilityunitid", unitId);
                if(parentId!=0){
                    genericClassService.updateRecordSQLStyle(Facilityunithierachy.class, new String[]{"parentid"},
                        new Object[]{parentId}, "facilityunitid", unitId);
                }
                if(facilityStructureid!=0){
                    genericClassService.updateRecordSQLStyle(Facilityunithierachy.class, new String[]{"structureid"},
                        new Object[]{facilityStructureid}, "facilityunitid", unitId);
                }
                model.put("resp", true);
                model.put("successMessage", "Successfully Updated Facility Unit");
            }
            existingList.add(unitObj);
            model.put("hyrchList", existingList);

        } catch (Exception e) {
            e.printStackTrace();
            model.put("resp", false);
            model.put("errorMessage", "Action Unsuccessfull!. If Error Persists Contact Systems Admin");
        }
        if (updateActivity == false) {
            model.put("activity", "add");
        }else{
            model.put("activity", "update");
        }
        model.put("mainActivity", "Facility Unit");
        return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/views/unitResponse", "model", model);
    }
    
    
    
    /**
     *
     * @param request
     * @param principal
     * @return
     */
    @RequestMapping(value = "/registerFacilityUnit.htm", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView registerFacilityUnit(HttpServletRequest request, Principal principal) {
        logger.info("Received Request To Add Facility Unit");
        Map<String, Object> model = new HashMap<String, Object>();
        Facilityunit unitObj = new Facilityunit();
        boolean updateActivity = false;
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }
            long unitId = 0;
            if (request.getParameter("cref") != null && !request.getParameter("cref").isEmpty()) {
                unitId = Long.parseLong(request.getParameter("cref"));
                updateActivity = true;
            }
            long parentId = 0;
            if (request.getParameter("parentId") != null && !request.getParameter("parentId").isEmpty()) {
                parentId = Long.parseLong(request.getParameter("parentId"));
            }
            long facilityStructureid = 0;
            Facilitystructure hyrchObj = new Facilitystructure();
            if (request.getParameter("hyrchId") != null && !request.getParameter("hyrchId").isEmpty()) {
                facilityStructureid = Long.parseLong(request.getParameter("hyrchId"));
                request.getSession().setAttribute("sessFacilityStructureId", facilityStructureid);
                String[] hyrchFields = {"structureid", "hierachylabel", "service"};
                String[] params = {"Id"};
                Object[] paramsValues = {facilityStructureid};
                List<Object[]> hyrchListArr = (List<Object[]>) genericClassService.fetchRecord(Facilitystructure.class, hyrchFields, "WHERE r.facilitystructure.structureid=:Id", params, paramsValues);
                if (hyrchListArr != null) {
                    for (Object[] obj : hyrchListArr) {
                        hyrchObj.setStructureid((Long) obj[0]);
                        hyrchObj.setHierachylabel((String) obj[1]);
                    }
                    model.put("hyrchObj", hyrchObj);
                }
            }
            //long facilityStructureid = Long.parseLong(request.getParameter("hyrchId"));
            int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
            String unitname = request.getParameter("facilityunitname");
            String shortname = request.getParameter("shortname");
            String description = request.getParameter("description");
            String telContact = request.getParameter("telContact");
            String location = request.getParameter("location");
            boolean status = Boolean.parseBoolean(request.getParameter("status"));
            boolean service = Boolean.parseBoolean(request.getParameter("service"));
            
            String facilityunitname = "";
            if(updateActivity==false){
                BreakIterator wordBreaker = BreakIterator.getWordInstance();
                String str = unitname.trim();
                wordBreaker.setText(str);
                int end = 0;
                for (int start = wordBreaker.first();
                        (end = wordBreaker.next()) != BreakIterator.DONE; start = end) {
                    String word = str.substring(start, end);
                    String joined_word = word.substring(0, 1).toUpperCase() + word.substring(1).toLowerCase();
                    if (end != 0) {
                        facilityunitname += joined_word;
                    }
                }       
            }else{
                facilityunitname=unitname;
            }
            logger.info("updateActivity ::: " + updateActivity);
            

            String[] param2 = {"name","facId"};
            Object[] paramsValue2 = {facilityunitname.toLowerCase(),facilityid};
            String[] field2 = {"facilityunitid", "facilityunitname", "description", "active"};
            List<Object[]> existingUnitList = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, field2, "WHERE LOWER(r.facilityunitname)=:name AND r.facilityid=:facId", param2, paramsValue2);
            if (existingUnitList != null) {
                boolean exist = false;
                List<Facilityunit> existingList = new ArrayList<Facilityunit>();
                for (Object[] obj : existingUnitList) {
                    Facilityunit unit = new Facilityunit((Long) obj[0]);
                        unit.setFacilityunitname((String) obj[1]);
                        unit.setDescription((String) obj[2]);
                        unit.setActive((Boolean) obj[3]);
                    existingList.add(unit);
                    exist = true;
                    if (unitId == (Long) obj[0]) {
                        exist = false;
                    }
                }
                model.put("resp", false);
                model.put("errorMessage", "Already Existing Facility Unit");
                model.put("facilityUnitList", existingList);
                if (exist == true) {
                    model.put("mainActivity", "Facility Unit");
                    return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/views/unitResponse", "model", model);
                }
            }

            List<Facilityunit> existingList = new ArrayList<Facilityunit>();
            long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
            unitObj.setFacilityid(facilityid);
            unitObj.setFacilityunitname(facilityunitname);
            unitObj.setShortname(shortname);
            unitObj.setDescription(description);
            unitObj.setActive(status);
            unitObj.setService(service);
            unitObj.setLocation(location);
            unitObj.setTelephone(telContact);
            if(facilityStructureid!=0){
                unitObj.setFacilitystructure(new Facilitystructure(facilityStructureid));
            }
            if(parentId!=0){
                unitObj.setMainfacilityunit(parentId);
                unitObj.setFacilityunithierachy(new Facilityunithierachy(parentId));
            }
            unitObj.setDateadded(new Date());
            unitObj.setPerson(new Person(pid));

            if (updateActivity == false) {
                genericClassService.saveOrUpdateRecordLoadObject(unitObj);
                List<Object[]> addedUnitList =(List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, new String[]{"facilityunitid"}, "WHERE r.facilityunitid=:Id", new String[]{"Id"}, new Object[]{unitObj.getFacilityunitid()});
                if (addedUnitList!= null && !addedUnitList.isEmpty()) {
                    model.put("resp", true);
                    model.put("successMessage", "Successfully Added New Facility Unit");
                    model.put("addMoreUnits", true);
                } else {
                    model.put("resp", false);
                    model.put("errorMessage", "Facility Unit Not Added");
                }
                
            } else {
                    genericClassService.updateRecordSQLStyle(Facilityunit.class, new String[]{"facilityunitname", "shortname", "description", "location", "telephone", "active", "service", "updatedby", "dateupdated"},
                        new Object[]{facilityunitname, shortname, description, location, telContact, status, service, pid, new Date()}, "facilityunitid", unitId);
                if(parentId!=0){
                    genericClassService.updateRecordSQLStyle(Facilityunit.class, new String[]{"parentid"},
                        new Object[]{parentId}, "facilityunitid", unitId);
                }
                if(facilityStructureid!=0){
                    genericClassService.updateRecordSQLStyle(Facilityunit.class, new String[]{"structureid"},
                        new Object[]{facilityStructureid}, "facilityunitid", unitId);
                }
                model.put("resp", true);
                model.put("successMessage", "Successfully Updated Facility Unit");
            }
            existingList.add(unitObj);
            model.put("hyrchList", existingList);

        } catch (Exception e) {
            e.printStackTrace();
            model.put("resp", false);
            model.put("errorMessage", "Action Unsuccessfull!. If Error Persists Contact Systems Admin");
        }
        if (updateActivity == false) {
            model.put("activity", "add");
        }else{
            model.put("activity", "update");
        }
        model.put("mainActivity", "Facility Unit");
        return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/views/unitResponse", "model", model);
    }
    
    
    /**
     *
     * @param request
     * @param principal
     * @return
     */
    @RequestMapping(value = "/structureFacilityUnit.htm", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView structureFacilityUnit(HttpServletRequest request, Principal principal) {
        logger.info("Received Request To Struture Facility Unit");
        Map<String, Object> model = new HashMap<String, Object>();
        Facilityunit unitObj = new Facilityunit();
        boolean updateActivity = false;
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }
            long unitId = 0;
            if (request.getParameter("cref") != null && !request.getParameter("cref").isEmpty()) {
                unitId = Long.parseLong(request.getParameter("cref"));
                updateActivity = true;
            }
            long parentId = 0;
            if (request.getParameter("parentId") != null && !request.getParameter("parentId").isEmpty()) {
                parentId = Long.parseLong(request.getParameter("parentId"));
            }
            long facilityStructureid = 0;
            if (request.getParameter("hyrchId") != null && !request.getParameter("hyrchId").isEmpty()) {
                facilityStructureid = Long.parseLong(request.getParameter("hyrchId"));
            }
            //long facilityStructureid = Long.parseLong(request.getParameter("hyrchId"));
            int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
            boolean service = true;
            if(request.getParameter("service")!=null){
                service = Boolean.parseBoolean(request.getParameter("service"));
            }
            if(service==true){
                logger.info("Unit:"+unitId+" Fac:"+facilityid);
                List<Object[]> unitArrObj = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, new String[]{"facilityunitid","facilityunitname"}, "WHERE r.facilityunitid=:unitId AND r.facilityid=:facId", new String[]{"unitId","facId"}, new Object[]{unitId,facilityid});
                if (unitArrObj.get(0) != null) {
                    String facilityunitname= (String)unitArrObj.get(0)[1];
                    String[] param2 = {"name","facId"};
                    Object[] paramsValue2 = {facilityunitname.toLowerCase(),facilityid};
                    String[] field2 = {"facilityunitid", "facilityunitname"};
                    List<Object[]> existingUnitList = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, field2, "WHERE LOWER(r.facilityunitname)=:name AND r.facilityid=:facId", param2, paramsValue2);
                    if (existingUnitList != null) {
                        boolean exist = false;
                        List<Facilityunit> existingList = new ArrayList<Facilityunit>();
                        for (Object[] obj : existingUnitList) {
                            Facilityunit unit = new Facilityunit((Long) obj[0]);
                                unit.setFacilityunitname((String) obj[1]);
                            existingList.add(unit);
                            exist = true;
                            if (unitId == (Long) obj[0]) {
                                exist = false;
                            }
                        }
                        model.put("resp", false);
                        model.put("errorMessage", "Already Existing Facility Unit");
                        model.put("facilityUnitList", existingList);
                        if (exist == true) {
                            model.put("mainActivity", "Facility Unit");
                            return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/views/unitResponse", "model", model);
                        }
                    }
                }
                
                if(parentId!=0){
                    genericClassService.updateRecordSQLStyle(Facilityunit.class, new String[]{"parentid"},
                        new Object[]{parentId}, "facilityunitid", unitId);
                }
                if(facilityStructureid!=0){
                    genericClassService.updateRecordSQLStyle(Facilityunit.class, new String[]{"structureid"},
                        new Object[]{facilityStructureid}, "facilityunitid", unitId);
                }
                model.put("resp", true);
                model.put("successMessage", "Successfully Updated Facility Unit");
            }
            

        } catch (Exception e) {
            e.printStackTrace();
            model.put("resp", false);
            model.put("errorMessage", "Action Unsuccessfull!. If Error Persists Contact Systems Admin");
        }
        if (updateActivity == false) {
            model.put("activity", "add");
        }else{
            model.put("activity", "update");
        }
        model.put("mainActivity", "Facility Unit");
        return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/views/unitResponse", "model", model);
    }
    
    
     /**
     *
     * @param principal
     * @return
     */
    @RequestMapping("/facStructureLoader.htm")
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView facStructureLoader(Principal principal, HttpServletRequest request,
            @RequestParam("act") String activity, @RequestParam("i") long id, @RequestParam("d") long id2, @RequestParam("e") long id3,
            @RequestParam("b") String strVal, @RequestParam("c") String strVal2) {
        if (principal == null) {
            return new ModelAndView("login");
        }
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            model.put("act", activity);
            model.put("b", strVal);
            model.put("i", id);
            model.put("c", strVal2);
            model.put("d", id2);
            model.put("e", id3);
            model.put("ofst", 1);
            model.put("maxR", 100);

            
            int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());

            String[] unitFields = {"facilityunitid", "facilityunitname", "facilitystructure.structureid", "facilitystructure.hierachylabel"};
            String[] structureFields = {"structureid", "hierachylabel", "description", "active", "service"};
            
            List<Object[]> hyrchListArr = new ArrayList<Object[]>();
            List<Facilityunithierachy> facilityUnitList = new ArrayList<Facilityunithierachy>();
            List<Object[]> unitListArr = new ArrayList<Object[]>();
            
            if (activity.equals("a")) {
                List<Long> unpermittedList = new ArrayList<Long>();
                logger.info("id3 :::: "+id3);
                hyrchListArr = (List<Object[]>) genericClassService.fetchRecord(Facilitystructure.class, new String[]{"facilitystructure.structureid"}, "WHERE r.structureid=:Id", new String[]{"Id"}, new Object[]{id3});
                if (hyrchListArr != null && !hyrchListArr.isEmpty()) {
                    for (Object obj : hyrchListArr) {
                        if (obj!=null){
                            List<Object[]> hyrchChildListArr = (List<Object[]>) genericClassService.fetchRecord(Facilitystructure.class, new String[]{"structureid"}, "WHERE r.facilitystructure.structureid=:Id", new String[]{"Id"}, new Object[]{(Long) obj});
                            if (hyrchChildListArr != null) {
                                for (Object obj2 : hyrchChildListArr) {
                                    unpermittedList.add((Long) obj2);
                                }
                            }
                        }
                    }
                }
                unitListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunithierachy.class, unitFields, "WHERE r.facilityunithierachy.facilityunitid=:Id AND r.facility.facilityid=:facId AND r.active=:state ORDER BY r.facilityunitname ASC", new String[]{"facId","Id","state"}, new Object[]{facilityid,id,true});
                if (unitListArr != null) {
                    for (Object[] unitObj : unitListArr) {
                        Facilityunithierachy unit = new Facilityunithierachy((Long) unitObj[0]);
                        unit.setFacilityunitname((String) unitObj[1]);
                        logger.info("Level Name ::::::------------------::ID:"+(Long) unitObj[0]+"::: "+(String) unitObj[1]);
                        Facilitystructure structure = new Facilitystructure((Long) unitObj[2]);
                        structure.setHierachylabel((String) unitObj[3]);
                        unit.setFacilitystructure(structure);
                        if(!unpermittedList.contains((Long) unitObj[2])){
                            facilityUnitList.add(unit);
                        }
                    }
                     model.put("size", facilityUnitList.size());
                }
                
                model.put("unitList", facilityUnitList);
                model.put("formActivity", "UnitStructure");
                model.put("d", id2+1);
                
                return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/forms/structureLoader", "model", model);
            }
            if (activity.equals("b")) {
                boolean isUnit=Boolean.parseBoolean(strVal2);
                Facilitystructure structureObj = new Facilitystructure();
                unitListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunithierachy.class, new String[]{"facilityunitid", "facilityunitname"}, "WHERE r.facilityunithierachy.facilityunitid=:Id AND r.facility.facilityid=:facId AND r.active=:state AND r.facilitystructure.structureid!=:sId ORDER BY r.facilityunitname ASC", new String[]{"facId","Id","state","sId"}, new Object[]{facilityid,id,true,id3});
                if (unitListArr != null) {
                    for (Object[] unitObj : unitListArr) {
                        Facilityunithierachy unit = new Facilityunithierachy((Long) unitObj[0]);
                        unit.setFacilityunitname((String) unitObj[1]);
                        structureObj = new Facilitystructure((Long) unitObj[2]);
                        structureObj.setHierachylabel((String) unitObj[3]);
                        unit.setFacilitystructure(structureObj);
                        facilityUnitList.add(unit);
                    }
                }
                model.put("d", id2+1);
                model.put("facilityUnitList", facilityUnitList);
                model.put("formActivity", "UnitTransfer");
                return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/forms/structureLoader", "model", model);
            }
            if (activity.equals("c")) {
                boolean isUnit=Boolean.parseBoolean(strVal2);
                Facilitystructure structureObj = new Facilitystructure();
                unitListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunithierachy.class, new String[]{"facilityunitid", "facilityunitname", "facilitystructure.structureid", "facilitystructure.hierachylabel"}, "WHERE r.facilityunithierachy.facilityunitid=:Id AND r.facility.facilityid=:facId AND r.active=:state ORDER BY r.facilityunitname ASC", new String[]{"facId","Id","state"}, new Object[]{facilityid,id,true});
                if (unitListArr != null) {
                    for (Object[] unitObj : unitListArr) {
                        Facilityunithierachy unit = new Facilityunithierachy((Long) unitObj[0]);
                        unit.setFacilityunitname((String) unitObj[1]);
                        structureObj = new Facilitystructure((Long) unitObj[2]);
                        structureObj.setHierachylabel((String) unitObj[3]);
                        unit.setFacilitystructure(structureObj);
                        facilityUnitList.add(unit);
                    }
                }else{
                    boolean isParent = false;
                    List<Object[]> unitArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunithierachy.class, new String[]{"facilitystructure.structureid", "facilitystructure.hierachylabel"}, "WHERE r.facilityunitid=:Id AND r.facility.facilityid=:facId AND r.active=:state", new String[]{"facId","Id","state"}, new Object[]{facilityid,id,true});
                    if (unitArr != null) {
                        int chkParent = genericClassService.fetchRecordCount(Facilitystructure.class, "WHERE r.facilitystructure.structureid=:Id AND r.facilitystructure.service=:state AND r.facility.facilityid=:fId AND r.active=:state", new String[]{"Id","fId","state"}, new Object[]{(Long)unitArr.get(0)[0],facilityid,true});
                        if (chkParent > 0) {
                            isParent = true; 
                        }
                    }
                    model.put("isParentObj", isParent);
                }
                model.put("d", id2+1);
                model.put("facilityUnitList", facilityUnitList);
                model.put("formActivity", "UnitRegistration");
                return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/forms/structureLoader", "model", model);
            }
            if (activity.equals("d")) {
                List<Facilityunithierachy> hierachyUnitList = new ArrayList<Facilityunithierachy>();
//                logger.info("strVal2.equals(false) ::::: "+strVal2.equals(false));
                if(strVal2.equals("false")){
                    Facilitystructure structureObj = new Facilitystructure();
                    unitListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunithierachy.class, new String[]{"facilityunitid", "facilityunitname", "facilitystructure.structureid", "facilitystructure.hierachylabel"}, "WHERE r.facilityunithierachy.facilityunitid=:Id AND r.facility.facilityid=:facId AND r.active=:state ORDER BY r.facilityunitname ASC", new String[]{"facId","Id","state"}, new Object[]{facilityid,id,true});
                    if (unitListArr != null) {
                        for (Object[] unitObj : unitListArr) {
                            Facilityunithierachy unit = new Facilityunithierachy((Long) unitObj[0]);
                            unit.setFacilityunitname((String) unitObj[1]);
                            structureObj = new Facilitystructure((Long) unitObj[2]);
                            structureObj.setHierachylabel((String) unitObj[3]);
                            unit.setFacilitystructure(structureObj);
                            facilityUnitList.add(unit);
                        }
                        model.put("levelHyrchObj", structureObj);
                        Facilitystructure selectedHyrch = (Facilitystructure) request.getSession().getAttribute("sessViewUnitsLevel");
                        logger.info("Selected Hierarchy :::::: " + selectedHyrch.getHierachylabel());
                        List<Object[]> checkNextLevel = (List<Object[]>) genericClassService.fetchRecord(Facilitystructure.class, structureFields, "WHERE r.facilitystructure.structureid=:Id AND r.facility.facilityid=:facId", new String[]{"Id", "facId"}, new Object[]{structureObj.getStructureid(), facilityid});
                        if (checkNextLevel != null) {
                            logger.info("Next Hierarchy :::::: " + (String) checkNextLevel.get(0)[1]);
                            long nextId = (Long) checkNextLevel.get(0)[0];
                            if (nextId == selectedHyrch.getStructureid()) {
                                model.put("returnUnits", true);
                            }
                        }
                    }else{
                        boolean isParent = false;
                        List<Object[]> unitArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunithierachy.class, new String[]{"facilitystructure.structureid", "facilitystructure.hierachylabel"}, "WHERE r.facilityunitid=:Id AND r.facility.facilityid=:facId AND r.active=:state", new String[]{"facId","Id","state"}, new Object[]{facilityid,id,true});
                        if (unitArr != null) {
                            int chkParent = genericClassService.fetchRecordCount(Facilitystructure.class, "WHERE r.facilitystructure.structureid=:Id AND r.facilitystructure.service=:state AND r.facility.facilityid=:fId AND r.active=:state", new String[]{"Id","fId","state"}, new Object[]{(Long)unitArr.get(0)[0],facilityid,true});
                            if (chkParent > 0) {
                                isParent = true; 
                            }
                        }
                        model.put("isParentObj", isParent);
                    }
                    
                    model.put("d", id2+1);
                    model.put("facilityUnitList", facilityUnitList);
                    model.put("formActivity", "UnitSelection");
                    return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/forms/structureLoader", "model", model);
                }else{
                    boolean isAttachedUnit = false;
                    Facilitystructure hyrch = new Facilitystructure();
                    List<Object[]> unitArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunithierachy.class, new String[]{"facilityunitid", "facilityunitname", "facilitystructure.structureid", "facilitystructure.hierachylabel"}, "WHERE r.facilityunitid=:Id AND r.facility.facilityid=:facId", new String[]{"facId", "Id"}, new Object[]{facilityid, id});
                    if (unitArr != null) {
                        model.put("unitObj", unitArr.get(0));

                        long strucId = (Long) unitArr.get(0)[2];
                        String[] params = {"Id"};
                        Object[] paramsValues = {strucId};
                        hyrchListArr = (List<Object[]>) genericClassService.fetchRecord(Facilitystructure.class, structureFields, "WHERE r.facilitystructure.structureid=:Id", params, paramsValues);
                        if (hyrchListArr != null) {
                            for (Object[] obj : hyrchListArr) {
                                hyrch = new Facilitystructure((Long) obj[0]);
                                hyrch.setHierachylabel((String) obj[1]);
                                hyrch.setDescription((String) obj[2]);
                                hyrch.setService((Boolean) obj[4]);
                            }
                            
                            if (hyrch.getService() == true) {
                                List<Facilityunit> facilityUnitList2 = new ArrayList<Facilityunit>();
                                unitListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, new String[]{"facilityunitid", "facilityunitname", "shortname", "description", "active", "facilitystructure.structureid"}, "WHERE r.facilityunithierachy.facilityunitid=:Id AND r.facilityid=:facId ORDER BY r.facilityunitname ASC", new String[]{"Id", "facId"}, new Object[]{id, facilityid});
                                if (unitListArr != null) {
                                    for (Object[] unitObj : unitListArr) {
                                        Facilityunit unit = new Facilityunit((Long) unitObj[0]);
                                        unit.setFacilityunitname((String) unitObj[1]);
                                        unit.setShortname((String) unitObj[2]);
                                        unit.setDescription((String) unitObj[3]);
                                        unit.setActive((Boolean) unitObj[4]);
                                        int subUnits = 0; //genericClassService.fetchRecordCount(Facilityunit.class, "WHERE r.facilityunit.facilityunitid=:unitId AND r.facilityid=:facId", new String[]{"unitId","facId"}, new Object[]{(Long) unitObj[0],facilityid});
                                        unit.setSubunits(subUnits);
                                        facilityUnitList2.add(unit);
                                    }
                                }
                                model.put("hyrchObjType", "Unit");
                                hyrch.setFacilityunitList(facilityUnitList2);
                            }
                            if (hyrch.getService() == false) {
                                unitListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunithierachy.class, new String[]{"facilityunitid", "facilityunitname", "shortname", "description", "active", "facilitystructure.structureid"}, "WHERE r.facilityunithierachy.facilityunitid=:Id AND r.facility.facilityid=:facId ORDER BY r.facilityunitname ASC", new String[]{"Id", "facId"}, new Object[]{id, facilityid});
                                if (unitListArr != null) {
                                    for (Object[] unitObj : unitListArr) {
                                        Facilityunithierachy unit = new Facilityunithierachy((Long) unitObj[0]);
                                        unit.setFacilityunitname((String) unitObj[1]);
                                        unit.setShortname((String) unitObj[2]);
                                        unit.setDescription((String) unitObj[3]);
                                        unit.setActive((Boolean) unitObj[4]);
                                        int subUnits = genericClassService.fetchRecordCount(Facilityunithierachy.class, "WHERE r.facilityunithierachy.facilityunitid=:unitId AND r.facility.facilityid=:facId", new String[]{"unitId", "facId"}, new Object[]{(Long) unitObj[0], facilityid});
                                        if (subUnits == 0) {
                                            subUnits = genericClassService.fetchRecordCount(Facilityunit.class, "WHERE r.facilityunithierachy.facilityunitid=:unitId AND r.facilityid=:facId", new String[]{"unitId", "facId"}, new Object[]{(Long) unitObj[0], facilityid});
                                            if (subUnits > 0) {
                                                isAttachedUnit = true;
                                            }
                                        }
                                        unit.setSubunits(subUnits);
                                        hierachyUnitList.add(unit);
                                    }
                                }
                                model.put("hyrchObjType", "Level");
                                hyrch.setFacilityunithierachyList(hierachyUnitList);
                            }
                        }
                    }
                    model.put("hyrchObj", hyrch);
                    model.put("isAttachedUnit", isAttachedUnit);
                    return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/views/viewNodeUnitDetails", "model", model);
                }
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
    @RequestMapping("/checkExistingRecord.htm")
    @SuppressWarnings("CallToThreadDumpStack")
    public String checkExistingRecord(Principal principal, HttpServletRequest request,
            @RequestParam("act") String activity, @RequestParam("i") long id, @RequestParam("b") String strVal, @RequestParam("sStr") String strVal2) {

        Map<String, Object> model = new HashMap<String, Object>();
        try {
            model.put("act", activity);
            model.put("b", strVal);
            model.put("i", id);
            model.put("sStr", strVal2);
            
            int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());

            if (activity.equals("a")) {
                int subUnits = genericClassService.fetchRecordCount(Facilityunit.class, "WHERE r.facilityunitname=:unitName AND r.facilityid=:facId", new String[]{"unitName", "facId"}, new Object[]{strVal2, facilityid});
                if (subUnits == 0) {
                    return "true";
                }else{
                    return "false";
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        model.put("success", "<span class='text6'>Contact System Administrator :: Page Not Found!</span>");
        return "";
    }
    
     @RequestMapping(value = "/registerUnitsList.htm", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView registerUnitsList(HttpServletRequest request, Principal principal) {
        logger.info("Received request to get from form for reg more units");
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }
            
            int count = Integer.parseInt(request.getParameter("itemSize"));
            String activity = request.getParameter("activity");
            List<Facilityunit> addUnitList = new ArrayList<Facilityunit>();
            List<Facilityunit> existingUnitList = new ArrayList<Facilityunit>();
            List<Facilityunit> addedUnitList = new ArrayList<Facilityunit>();
            List<Facilityunit> failedUnitList = new ArrayList<Facilityunit>();
            model.put("activity", activity);
            long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
            int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
            if (count > 0) {
                logger.info("item Count......... " + count + ">0");
                for (int i = 1; i <= count; i++) {
                    if (request.getParameter("uUnitName" + i) != null) {
                        logger.info("Posted Unit...... " + request.getParameter("uUnitName" + i));
                        String uUnitName = request.getParameter("uUnitName" + i);
                        String shortname = request.getParameter("uShortName" + i);
                        String description = request.getParameter("uDesc" + i);
                        
                        String unitName ="";
                        BreakIterator wordBreaker = BreakIterator.getWordInstance();
                        String str = uUnitName.trim();
                        wordBreaker.setText(str);
                        int end = 0;
                        for (int start = wordBreaker.first();
                                (end = wordBreaker.next()) != BreakIterator.DONE; start = end) {
                            String word = str.substring(start, end);
                            String joined_word = word.substring(0, 1).toUpperCase() + word.substring(1).toLowerCase();
                            if (end != 0) {
                                unitName += joined_word;
                            }
                        }

                        Facilityunit unit = new Facilityunit();
                        //Check Existing Policy
                        int countExistingUnit = genericClassService.fetchRecordCount(Facilityunit.class, "WHERE LOWER(r.facilityunitname)=:name AND r.facilityid=:Id", new String[]{"Id","name"}, new Object[]{facilityid,unitName.toLowerCase()});
                        if(countExistingUnit>0){
                            unit.setFacilityunitname(unitName);
                            unit.setShortname(shortname);
                            unit.setDescription(description);
                            
                            existingUnitList.add(unit);
                        }else{
                            unit.setFacilityunitname(unitName);
                            unit.setShortname(shortname);
                            unit.setDescription(description);
                            unit.setActive(true);
                            unit.setService(true);
                            unit.setDateadded(new Date());
                            unit.setPerson(new Person(pid));
                            unit.setFacilityid(facilityid);
                            if (request.getSession().getAttribute("sessFacilityStructureId") != null) {
                                long structureid = Long.parseLong(request.getSession().getAttribute("sessFacilityStructureId").toString());
                                unit.setFacilitystructure(new Facilitystructure(structureid));
                            }
                            
                            addUnitList.add(unit);
                        }
                    }
                }
                if(addUnitList!=null && !addUnitList.isEmpty()){
                    for (Facilityunit facilityunit : addUnitList) {
                        genericClassService.saveOrUpdateRecordLoadObject(facilityunit);
                        int addedUnit = genericClassService.fetchRecordCount(Facilityunit.class, "WHERE facilityunitid=:uId", new String[]{"uId"}, new Object[]{facilityunit.getFacilityunitid()});
                        if(addedUnit>0){
                            addedUnitList.add(facilityunit);
                        }else{
                            failedUnitList.add(facilityunit);
                        }
                    }
                    model.put("addedUnitList", addedUnitList);
                    if(addedUnitList!=null && !addedUnitList.isEmpty()){
                        model.put("mainActivity", "AddFacilityUnit");
                        model.put("resp", true);
                        if(addedUnitList.size()==1){
                            model.put("successMessage", "Successfully Saved "+addedUnitList.size()+" Unit");
                        }else{
                            model.put("successMessage", "Successfully Saved "+addedUnitList.size()+" Units");
                        }
                    }else{
                        model.put("resp", false);
                        model.put("errorMessage", "Saving New Unit Failed!");
                    }
                    model.put("failedUnitList", failedUnitList);
                }else{
                    model.put("resp", false);
                    model.put("errorMessage", "No Valid Units To Be Added!");
                }
                logger.info("savePolicy......... " + addUnitList.size() + " activity........... "+activity);
                
            }else{
                model.put("resp", false);
                model.put("errorMessage", "No Units Added!");
            }
            
            return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/views/saveResponse", "model", model);
            
        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/views/saveResponse", "model", model);
        }
        
    }
    
    @RequestMapping(value = "/quickSearchFaciliyUnitByTerm.htm", method = RequestMethod.POST)
    public @ResponseBody
    String quickSearchFaciliyUnitByTerm(HttpServletRequest request, Model model, @ModelAttribute("sTerm") String searchTerm, @ModelAttribute("sVal") String searchValue) {
        
        logger.info("searchTerm ::::: "+searchTerm+" searchValue ::::: "+searchValue);
        List<Facilityunit> facilityUnitList = new ArrayList();
        List<Object[]> foundObjs = new ArrayList<>();
        
        if (searchTerm.equals("a")) {
            int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
            String[] fields = {"facilityunitid", "facilityunitname"};
            String where = "";
                String[] params = {"fId"};
                Object[] paramsValues = {facilityid};
                where = "WHERE r.facilityid=:fId AND LOWER(r.facilityunitname) LIKE '" + searchValue.toLowerCase() + "%' ORDER BY r.facilityunitname ASC";
                foundObjs = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields, where, params, paramsValues);
            
            if (foundObjs != null) {
                for (Object[] obj : foundObjs) {
                    Facilityunit fu = new Facilityunit();
                    fu.setFacilityunitid((Long) obj[0]);
                    fu.setFacilityunitname((String) obj[1]);
                    facilityUnitList.add(fu);
                }
            }
        }
        
        FacilityUnitSetUpController parser = new FacilityUnitSetUpController();
        return parser.facilityUnitToJSON(facilityUnitList);
    }
    
    public String facilityUnitToJSON(List<Facilityunit> list) {
        String response = "[";
        int size = list.size();
        if (size > 0) {
            for (int x = 0; x < size - 1; x++) {
                response += "{\"id\":\"" + list.get(x).getFacilityunitid()+ "\",\"name\":\"" + list.get(x).getFacilityunitname()+ "\"},";
            }
            response += "{\"id\":\"" + list.get(size - 1).getFacilityunitid() + "\",\"name\":\"" + list.get(size - 1).getFacilityunitname() + "\"}";
        }
        response += "]";
        logger.info("Response ::::: response:"+response);
        return response;
    }
    
}
