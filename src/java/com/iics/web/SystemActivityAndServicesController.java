/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.iics.antenatal.Program;
import com.iics.domain.*;
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
 * @author samuelwam <samuelwam@gmail.com>
 */
@Controller
@RequestMapping("/systemActivity")
public class SystemActivityAndServicesController {
    
    public static String sys_info = null;
    protected static Log logger = LogFactory.getLog("controller");
    @Autowired
    GenericClassService genericClassService;
    
    /**
     *
     * @param principal
     * @return
     */
    @RequestMapping("/activityManagement.htm")
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView activityManagement(Principal principal, HttpServletRequest request,
            @RequestParam("act") String activity, @RequestParam("i") long id, @RequestParam("d") long id2,
            @RequestParam("b") String strVal, @RequestParam("c") String strVal2,
            @RequestParam("ofst") int offset, @RequestParam("maxR") int maxResults,
            @RequestParam("sStr") String searchPhrase) {
        if (principal == null) {
            return new ModelAndView("refresh");
        }
        Map<String, Object> model = new HashMap<String, Object>();
        model.put("onErrorReturnURL", "ajaxSubmitData('activityManagement.htm', 'workpane', 'act=a&i=0&b=a&c=c&d=0&ofst=1&maxR=100&sStr=', 'GET');");
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

            String[] activityFields = {"activityid", "activityname", "description", "activitykey", "active", "released", "dateadded", "person.firstname", "person.lastname"};

            List<Systemactivity> activityList = new ArrayList<Systemactivity>();
            List<Object[]> activityListArr = new ArrayList<Object[]>();

            if (activity.equals("a")) {
                String[] params = {};
                Object[] paramsValues = {};
                List<Object[]> actListArr = (List<Object[]>) genericClassService.fetchRecord(Systemactivity.class, activityFields, "ORDER BY r.activityname ASC", params, paramsValues);
                if (actListArr != null) {
                    logger.info("actListArr ::::::::: " + actListArr.size());
                    model.put("size", actListArr.size());
                    for (Object[] objects : actListArr) {
                        Systemactivity s = new Systemactivity((Integer) objects[0]);
                        s.setActivityname((String) objects[1]);
                        s.setDescription((String) objects[2]);
                        s.setActive((Boolean) objects[4]);
                        s.setDateadded((Date) objects[6]);
                        int countAssigned = genericClassService.fetchRecordCount(Systemactivityservice.class, "WHERE r.systemactivity.activityid=:Id", new String[]{"Id"}, new Object[]{s.getActivityid()});
                        s.setUnits(countAssigned);
                        activityList.add(s);
                    }
                }
                model.put("activityList", activityList);
                model.put("facilityType", "System Activity Set Up");

                return new ModelAndView("controlPanel/universalPanel/facility/SystemActivity/activityMain", "model", model);
            }
            
            if (activity.equals("b")) {
                String[] params = {"Id"};
                Object[] paramsValues = {id};
                List<Object[]> actListArr = (List<Object[]>) genericClassService.fetchRecord(Systemactivity.class, activityFields, "WHERE r.activityid=:Id ORDER BY r.activityname ASC", params, paramsValues);
                if (actListArr != null) {
                    model.put("activityObj", actListArr.get(0));
                }

                model.put("facilityType", "System Activity Details");

                return new ModelAndView("controlPanel/universalPanel/facility/SystemActivity/forms/activity", "model", model);
            }
            if (activity.equals("c")) {
                String[] params = {"Id"};
                Object[] paramsValues = {id};
                List<Object[]> actListArr = (List<Object[]>) genericClassService.fetchRecord(Systemactivity.class, activityFields, "WHERE r.activityid=:Id ORDER BY r.activityname ASC", params, paramsValues);
                if (actListArr != null) {
                    genericClassService.deleteRecordByByColumns(Systemactivity.class, new String[]{"activityid"}, new Object[]{id});
                    model.put("activityObj", actListArr.get(0));
                    List<Object[]> actListArr2 = (List<Object[]>) genericClassService.fetchRecord(Systemactivity.class, activityFields, "WHERE r.activityid=:Id ORDER BY r.activityname ASC", params, paramsValues);
                    if (actListArr2 == null) {
                        model.put("resp", true);
                        model.put("successMessage", "Successfully Deleted " + actListArr.get(0)[1] + " System Activity");
                    } else {
                        model.put("resp", false);
                        model.put("errorMessage", "Activity Not Deleted! Check Attachments");
                    }
                } else {
                    model.put("resp", false);
                    model.put("errorMessage", "System Activity Not Found!");
                }

                model.put("mainActivity", "Delete");

                return new ModelAndView("controlPanel/universalPanel/facility/SystemActivity/views/saveResponse", "model", model);
            }
            if (activity.equals("d")) {
                int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
                String[] params = {"state"};
                Object[] paramsValues = {true};
                List<Object[]> actListArr = (List<Object[]>) genericClassService.fetchRecord(Systemactivity.class, activityFields, "WHERE r.released=:state AND r.active=:state ORDER BY r.activityname ASC", params, paramsValues);
                if (actListArr != null) {
                    logger.info("actListArr ::::::::: " + actListArr.size());
                    model.put("size", actListArr.size());
                    for (Object[] objects : actListArr) {
                        Systemactivity s = new Systemactivity((Integer) objects[0]);
                        s.setActivityname((String) objects[1]);
                        s.setDescription((String) objects[2]);
                        int countAssigned = genericClassService.fetchRecordCount(Systemactivityservice.class, "WHERE r.systemactivity.activityid=:Id", new String[]{"Id"}, new Object[]{s.getActivityid()});
                        s.setUnits(countAssigned);
                        activityList.add(s);
                    }
                }
                model.put("activityList", activityList);
                model.put("facilityType", "System Activity Set Up");

                return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/Services/serviceMain", "model", model);
            }
            if (activity.equals("e")) {
                String[] params = {"Id"};
                Object[] paramsValues = {id};
                List<Object[]> actListArr = (List<Object[]>) genericClassService.fetchRecord(Systemactivity.class, new String[]{"activityid", "activityname"}, "WHERE r.activityid=:Id", params, paramsValues);
                if (actListArr != null) {
                    model.put("activityObj", actListArr.get(0));
                }
                List<Object[]> servListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityservices.class, new String[]{"serviceid", "servicename", "description"}, "WHERE r.serviceid NOT IN (SELECT s.facilityservices.serviceid FROM Systemactivityservice s) ORDER BY r.servicename", new String[]{},  new Object[]{});
                model.put("servListArr", servListArr);
                if(servListArr!=null){
                    model.put("size", servListArr.size());
                }

                return new ModelAndView("controlPanel/universalPanel/facility/SystemActivity/views/addServices", "model", model);
            }
            if (activity.equals("f")) {
                int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());

                String[] params = {"Id"};
                Object[] paramsValues = {id};
                List<Object[]> actListArr = (List<Object[]>) genericClassService.fetchRecord(Systemactivity.class, new String[]{"activityid", "activityname"}, "WHERE r.activityid=:Id", params, paramsValues);
                if (actListArr != null) {
                    model.put("activityObj", actListArr.get(0));
                }

                List<Systemactivityservice> unitServiceList = new ArrayList<Systemactivityservice>();
                List<Object[]> serviceArrListArr = (List<Object[]>) genericClassService.fetchRecord(Systemactivityservice.class, new String[]{"activityserviceid", "facilityservices.serviceid", "facilityservices.servicename", "status"}, "WHERE r.systemactivity.activityid=:Id ORDER BY r.facilityservices.servicename ASC", new String[]{"Id"}, new Object[]{id});

                if (serviceArrListArr != null) {
                    logger.info("serviceArrListArr :::::: " + serviceArrListArr.size());
                    for (Object[] obj : serviceArrListArr) {
                        Systemactivityservice unitService = new Systemactivityservice((Integer) obj[0]);
                        Facilityservices unit = new Facilityservices((Integer) obj[1]);
                        unit.setServicename((String) obj[2]);
                        unitService.setFacilityservices(unit);
                        unitService.setStatus((Boolean) obj[3]);
                        unitServiceList.add(unitService);
                    }
                    model.put("size", serviceArrListArr.size());
                }
                model.put("unitServiceList", unitServiceList);
                return new ModelAndView("controlPanel/universalPanel/facility/SystemActivity/views/assignedServices", "model", model);
            }
            if (activity.equals("g")) {
                boolean state = Boolean.parseBoolean(strVal);
                long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());

                genericClassService.updateRecordSQLStyle(Systemactivityservice.class, new String[]{"status", "updatedby", "dateupdated"}, new Object[]{state, pid, new Date()}, "facilityunitserviceid", id);
                logger.info("Return view for :::: Activity:f Unit Service:" + id);
                return activityManagement(principal, request, "f", id2, id2, strVal, strVal2, offset, maxResults, searchPhrase);
            }
            return new ModelAndView("controlPanel/universalPanel/facility/SystemActivity/forms/response", "model", model);

        } catch (Exception e) {
            e.printStackTrace();
        }
        model.put("success", "<span class='text6'>Contact System Administrator :: Page Not Found!</span>");
        return new ModelAndView("response", "model", model);
    }

    @RequestMapping(value = "/registerSystemActivity.htm", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView registerSystemActivity(HttpServletRequest request, Principal principal) {
        logger.info("Received request to get from form for system activity");
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }
 
            int count = Integer.parseInt(request.getParameter("itemSize"));
            String activity = request.getParameter("activity");
            List<Systemactivity> addActivityList = new ArrayList<Systemactivity>();
            List<Systemactivity> existingActivityList = new ArrayList<Systemactivity>();
            List<Systemactivity> addedActivityList = new ArrayList<Systemactivity>();
            List<Systemactivity> failedActivityList = new ArrayList<Systemactivity>();
            model.put("activity", activity);
            long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());

            if (count > 0) {
                logger.info("item Count......... " + count + ">0");
                for (int i = 1; i <= count; i++) {
                    if (request.getParameter("aName" + i) != null) {
                        logger.info("Posted Activity...... " + request.getParameter("aName" + i));
                        String aName = request.getParameter("aName" + i);
                        String description = request.getParameter("aDesc" + i);
                        String activityKey = request.getParameter("aKey" + i);

                        String activityName = "";
                        BreakIterator wordBreaker = BreakIterator.getWordInstance();
                        String str = aName.trim();
                        wordBreaker.setText(str);
                        int end = 0;
                        for (int start = wordBreaker.first();
                                (end = wordBreaker.next()) != BreakIterator.DONE; start = end) {
                            String word = str.substring(start, end);
                            String joined_word = word.substring(0, 1).toUpperCase() + word.substring(1).toLowerCase();
                            if (end != 0) {
                                activityName += joined_word;
                            }
                        }

                        Systemactivity sysActivity = new Systemactivity();
                        //Check Existing System Activity
                        int countExistingService = genericClassService.fetchRecordCount(Systemactivity.class, "WHERE LOWER(r.activityname)=:name", new String[]{"name"}, new Object[]{activityName.toLowerCase()});
                        if (countExistingService > 0) {
                            sysActivity.setActivityname(activityName);
                            sysActivity.setActivitykey(activityKey);
                            sysActivity.setDescription(description);
                            existingActivityList.add(sysActivity);
                        } else {
                            sysActivity.setActivityname(activityName);
                            sysActivity.setActivitykey(activityKey);
                            sysActivity.setDescription(description);
                            sysActivity.setActive(true);
                            sysActivity.setReleased(false);
                            sysActivity.setDateadded(new Date());
                            sysActivity.setPerson(new Person(pid));
                            addActivityList.add(sysActivity);
                        }
                    }
                }
                if (addActivityList != null && !addActivityList.isEmpty()) {
                    for (Systemactivity systemactivity : addActivityList) {
                        genericClassService.saveOrUpdateRecordLoadObject(systemactivity);
                        int addedService = genericClassService.fetchRecordCount(Systemactivity.class, "WHERE r.activityid=:aId", new String[]{"aId"}, new Object[]{systemactivity.getActivityid()});
                        if (addedService > 0) {
                            addedActivityList.add(systemactivity);
                        } else {
                            failedActivityList.add(systemactivity);
                        }
                    }
                    model.put("addedActivityList", addedActivityList);
                    if (addedActivityList != null && !addedActivityList.isEmpty()) {
                        model.put("mainActivity", "AddSystemActivity");
                        model.put("resp", true);
                        if (addedActivityList.size() == 1) {
                            model.put("successMessage", "Successfully Saved " + addedActivityList.size() + " System Activity");
                        } else {
                            model.put("successMessage", "Successfully Saved " + addedActivityList.size() + " System Activity");
                        }
                    } else {
                        model.put("resp", false);
                        model.put("errorMessage", "Saving New System Activity Failed!");
                    }
                    model.put("failedActivityList", failedActivityList);
                } else {
                    model.put("resp", false);
                    model.put("errorMessage", "No Valid Activities To Be Added!");
                }
                logger.info("saveActivity......... " + addActivityList.size() + " activity........... " + activity);
            } else {
                model.put("resp", false);
                model.put("errorMessage", "No Activity Added!");
            }

            return new ModelAndView("controlPanel/universalPanel/facility/SystemActivity/views/saveResponse", "model", model);

        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("controlPanel/universalPanel/facility/SystemActivity/views/saveResponse", "model", model);
        }
    }

    @RequestMapping(value = "/updateSystemActivity.htm", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView updateSystemActivity(HttpServletRequest request, Principal principal) {
        logger.info("Received request to get from form for update system activity");
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }

            String activity = request.getParameter("activity");
            String service = request.getParameter("activityname");
            String description = request.getParameter("description");
            boolean status = Boolean.parseBoolean(request.getParameter("status"));
            boolean release = Boolean.parseBoolean(request.getParameter("release"));

            long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
            long activityId = Long.parseLong(request.getParameter("activityId"));

            genericClassService.updateRecordSQLStyle(Systemactivity.class, new String[]{"description", "active", "released", "updatedby", "dateupdated"}, new Object[]{description, status, release, pid, new Date()}, "activityid", activityId);
            model.put("successMessage", "Successfully Updated System Activity: " + service + "");
            model.put("resp", true);
            model.put("mainActivity", "Update");
            return new ModelAndView("controlPanel/universalPanel/facility/SystemActivity/views/saveResponse", "model", model);

        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("controlPanel/universalPanel/facility/SystemActivity/views/saveResponse", "model", model);
        }

    }
    
    
    /**
     *
     * @param request
     * @param principal
     * @return
     */
    @RequestMapping(value = "/assignFacilityService.htm", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView assignFacilityService(HttpServletRequest request, Principal principal) {
        logger.info("Received request to assign service");
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }
            long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
            List<Integer> ids = new ArrayList<Integer>();
            List<Facilityservices> addedList = new ArrayList<Facilityservices>();
            List<Facilityservices> failedList = new ArrayList<Facilityservices>();
            int activityId = Integer.parseInt(request.getParameter("activityId"));
            int count = Integer.parseInt(request.getParameter("itemSize"));
            String activity = request.getParameter("act");
            if (count > 0) {
                logger.info("item Count......... " + count + ">0");
                for (int i = 1; i <= count; i++) {
                    if (request.getParameter("selectObj" + i) != null) {
                        logger.info("Posted ID...... " + request.getParameter("selectObj" + i));
                        int id = Integer.parseInt(request.getParameter("selectObj" + i));
                        ids.add(id);
                    }
                }
            } else {
                model.put("resp", false);
                model.put("successmessage", "No Record Submitted");
                return new ModelAndView("controlPanel/universalPanel/facility/SystemActivity/views/saveServiceResponse", "model", model);
            }
            int added = 0;
            int unDeleted = 0;
            for (Integer id : ids) {
                if (activity.equals("a")) {
                    Systemactivityservice service = new Systemactivityservice();
                    service.setSystemactivity(new Systemactivity(activityId));
                    service.setFacilityservices(new Facilityservices(id));
                    service.setDateadded(new Date());
                    service.setStatus(true);
                    service.setPerson(new Person(pid));

                    genericClassService.saveOrUpdateRecordLoadObject(service);
                    int addedService = 0;
                    List<Object[]> serviceListArr = (List<Object[]>) genericClassService.fetchRecord(Systemactivityservice.class, new String[]{"facilityservices.serviceid", "facilityservices.servicename"}, "WHERE r.activityserviceid=:Id", new String[]{"Id"}, new Object[]{service.getActivityserviceid()});
                    if (serviceListArr != null) {
                        addedService = serviceListArr.size();
                        for (Object[] obj : serviceListArr) {
                            Facilityservices unit = new Facilityservices(id);
                            unit.setServicename((String) obj[1]);
                            addedList.add(unit);
                        }
                    } else {
                        List<Object[]> unitListArr = (List<Object[]>) genericClassService.fetchRecord(Systemactivityservice.class, new String[]{"serviceid", "servicename"}, "WHERE r.serviceid=:Id ORDER BY r.servicename ASC", new String[]{"Id"}, new Object[]{id});
                        if (unitListArr != null) {
                            for (Object[] obj : unitListArr) {
                                Facilityservices unit = new Facilityservices(id);
                                unit.setServicename((String) obj[1]);
                                failedList.add(unit);
                            }
                        }
                    }
                    if (addedService > 0) {
                        added += 1;
                    }
                }
                if (activity.equals("b")) {
                    String[] params = {"Id"};
                    Object[] paramsValues = {id};
                    List<Object[]> servListArr = (List<Object[]>) genericClassService.fetchRecord(Systemactivityservice.class, new String[]{"facilityservices.serviceid", "facilityservices.servicename"}, "WHERE r.activityserviceid=:Id", params, paramsValues);
                    if (servListArr != null) {
                        model.put("serviceObj", servListArr.get(0));
                    }

                    Systemactivityservice service = new Systemactivityservice(id);
                    Facilityservices unit = new Facilityservices();
                    List<Object[]> serviceListArr = (List<Object[]>) genericClassService.fetchRecord(Systemactivityservice.class, new String[]{"activityserviceid", "facilityservices.serviceid", "facilityservices.servicename"}, "WHERE r.activityserviceid=:Id", new String[]{"Id"}, new Object[]{id});
                    if (serviceListArr != null) {
                        for (Object[] obj : serviceListArr) {
                            unit = new Facilityservices((Integer) obj[1]);
                            unit.setServicename((String) obj[2]);
                            service.setFacilityservices(unit);
                        }
                    }
                    genericClassService.deleteRecordByByColumns(Systemactivityservice.class, new String[]{"activityserviceid"}, new Object[]{id});
                    int checkDelete = genericClassService.fetchRecordCount(Systemactivityservice.class, "WHERE r.activityserviceid=:sId", new String[]{"sId"}, new Object[]{id});
                    logger.info("Delete Response For Id:" + id + " ===== checkDelete:" + checkDelete);
                    if (checkDelete == 0) {
                        logger.info("Deleted Record Id:" + id);
                        service.setStatus(true);
                        unit.setActive(Boolean.TRUE);
                        addedList.add(unit);
                    } else {
                        logger.info("Failed to Delete Record Id:" + id);
                        unDeleted += 1;
                        service.setStatus(false);
                        unit.setActive(false);
                        failedList.add(unit);
                    }
                }
            }
            String activeType = "";
            if (activity.equals("a")) {
                activeType = "System Activity Service";
                if (added > 0) {
                    model.put("resp", true);
                    model.put("successMessage", added + " " + activeType + "(s) Successfully Added");
                } else {
                    model.put("resp", false);
                    model.put("errorMessage", "Assignment Was Not Successful!");
                }
                model.put("mainActivity", "AssignService");
            }
            if (activity.equals("b")) {
                activeType = "Facility Unit";
                if (unDeleted == 0) {
                    model.put("resp", true);
                    model.put("successMessage", addedList.size() + " Service(s) Successfully De-Assigned");
                } else {
                    model.put("resp", false);
                    model.put("errorMessage", "De-Assignment Was Not Successful! " + unDeleted + " Service(s) Not Successfully De-Assigned");
                }
                model.put("mainActivity", "De-AssignService");
            }

            model.put("addedList", addedList);
            model.put("failedList", failedList);

        } catch (Exception e) {
            e.printStackTrace();
            model.put("resp", false);
            model.put("errorMessage", "Action Unsuccessfull!. If Error Persists Contact IICS Team");
        }

        return new ModelAndView("controlPanel/universalPanel/facility/SystemActivity/views/saveServiceResponse", "model", model);
    }
    //------------------------Facility Programs--------------------------
    /**
     *
     * @param principal
     * @return
     */
    @RequestMapping("/programManagement.htm")
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView programManagement(Principal principal, HttpServletRequest request,
            @RequestParam("act") String activity, @RequestParam("i") long id, @RequestParam("d") long id2,
            @RequestParam("b") String strVal, @RequestParam("c") String strVal2,
            @RequestParam("ofst") int offset, @RequestParam("maxR") int maxResults,
            @RequestParam("sStr") String searchPhrase) {
        if (principal == null) {
            return new ModelAndView("refresh");
        }
        Map<String, Object> model = new HashMap<String, Object>();
        model.put("onErrorReturnURL", "ajaxSubmitData('programManagement.htm', 'workpane', 'act=a&i=0&b=a&c=c&d=0&ofst=1&maxR=100&sStr=', 'GET');");
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

            String[] progFields = {"programid", "programname", "programkey"};

            List<Program> programList = new ArrayList<Program>();
            List<Object[]> programListArr = new ArrayList<Object[]>();

            if (activity.equals("a")) {
                List<String> checkList = new ArrayList<String>();
                String[] params = {};
                Object[] paramsValues = {};
                List<Object[]> progListArr = (List<Object[]>) genericClassService.fetchRecord(Program.class, progFields, "ORDER BY r.programname ASC", params, paramsValues);
                if (progListArr != null) {
                    for (Object[] objects : progListArr) {
                        checkList.add(((String) objects[1]).toLowerCase());
                    }
                    logger.info("progListArr ::::::::: " + progListArr.size());
                    model.put("size", progListArr.size());
                }
                model.put("programList", progListArr);
                model.put("facilityType", "Facility Program Set Up");
                model.put("checkList", checkList);

                return new ModelAndView("controlPanel/universalPanel/facility/Programs/programMain", "model", model);
            }
            if (activity.equals("a2")) {
                List<String> checkList = new ArrayList<String>();
                String[] params = {};
                Object[] paramsValues = {};
                List<Object[]> progListArr = (List<Object[]>) genericClassService.fetchRecord(Program.class, progFields, "ORDER BY r.programname ASC", params, paramsValues);
                if (progListArr != null) {
                    for (Object[] objects : progListArr) {
                        checkList.add(((String) objects[1]).toLowerCase());
                    }
                    logger.info("progListArr ::::::::: " + progListArr.size());
                    model.put("size", progListArr.size());
                }
                model.put("programList", progListArr);
                model.put("facilityType", "Facility Programs Set Up");
                model.put("checkList", checkList);

                return new ModelAndView("controlPanel/universalPanel/facility/Programs/views/programs", "model", model);
            }
            if (activity.equals("b")) {
                String[] params = {"Id"};
                Object[] paramsValues = {id};
                List<Object[]> servListArr = (List<Object[]>) genericClassService.fetchRecord(Program.class, progFields, "WHERE r.programid=:Id", params, paramsValues);
                if (servListArr != null) {
                    model.put("programObj", servListArr.get(0));
                }

                model.put("facilityType", "Facility Program Details");

                return new ModelAndView("controlPanel/universalPanel/facility/Programs/forms/program", "model", model);
            }
            if (activity.equals("c")) {
                String[] params = {"Id"};
                Object[] paramsValues = {id};
                List<Object[]> progListArr = (List<Object[]>) genericClassService.fetchRecord(Program.class, progFields, "WHERE r.programid=:Id", params, paramsValues);
                if (progListArr != null) {
                    genericClassService.deleteRecordBySchemaByColumns(Program.class, new String[]{"programid"}, new Object[]{id},"antenatal");
                    model.put("programObj", progListArr.get(0));
                    List<Object[]> progListArr2 = (List<Object[]>) genericClassService.fetchRecord(Program.class, progFields, "WHERE r.programid=:Id", params, paramsValues);
                    if (progListArr2 == null) {
                        model.put("resp", true);
                        model.put("successMessage", "Successfully Deleted " + progListArr.get(0)[1] + " Facility Program");
                    } else {
                        model.put("resp", false);
                        model.put("errorMessage", "Program Not Deleted! Check Attachments");
                    }
                } else {
                    model.put("resp", false);
                    model.put("errorMessage", "Program Not Found!");
                }

                model.put("mainActivity", "Delete");

                return new ModelAndView("controlPanel/universalPanel/facility/Programs/views/saveResponse", "model", model);
            }
            
            return new ModelAndView("controlPanel/universalPanel/Facility/Programs/forms/response", "model", model);

        } catch (Exception e) {
            e.printStackTrace();
        }
        model.put("success", "<span class='text6'>Contact System Administrator :: Page Not Found!</span>");
        return new ModelAndView("response", "model", model);
    }

    @RequestMapping(value = "/registerFacProgram.htm", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView registerFacProgram(HttpServletRequest request, Principal principal) {
        logger.info("Received request to get from form for reg facility program");
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }

            int count = Integer.parseInt(request.getParameter("itemSize"));
            String activity = request.getParameter("activity");
            List<Program> addProgramList = new ArrayList<Program>();
            List<Program> existingProgramList = new ArrayList<Program>();
            List<Program> addedProgramList = new ArrayList<Program>();
            List<Program> failedProgramList = new ArrayList<Program>();
            model.put("activity", activity);
            System.out.println("---test--");
            long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());

            if (count > 0) {
                logger.info("item Count......... " + count + ">0");
                for (int i = 1; i <= count; i++) {
                    if (request.getParameter("pName" + i) != null) {
                        logger.info("Posted Program...... " + request.getParameter("pName" + i));
                        String pName = request.getParameter("pName" + i);
                        String programKey = request.getParameter("pKey" + i);

                        String programName = "";
                        BreakIterator wordBreaker = BreakIterator.getWordInstance();
                        String str = pName.trim();
                        wordBreaker.setText(str);
                        int end = 0;
                        for (int start = wordBreaker.first();
                                (end = wordBreaker.next()) != BreakIterator.DONE; start = end) {
                            String word = str.substring(start, end);
                            String joined_word = word.substring(0, 1).toUpperCase() + word.substring(1).toLowerCase();
                            if (end != 0) {
                                programName += joined_word;
                            }
                        }

                        Program program = new Program();
                        //Check Existing Policy
                        int countExistingProgram = genericClassService.fetchRecordCount(Program.class, "WHERE LOWER(r.programname)=:name", new String[]{"name"}, new Object[]{programName.toLowerCase()});
                        if (countExistingProgram > 0) {
                            program.setProgramname(programName);
                            program.setProgramkey(programKey);
                            existingProgramList.add(program);
                        } else {
                            program.setProgramname(programName);
                            program.setProgramkey(programKey);
                            addProgramList.add(program);
                        }
                    }
                }
                if (addProgramList != null && !addProgramList.isEmpty()) {
                    for (Program facilityprogram : addProgramList) {
                        genericClassService.saveOrUpdateRecordLoadObject(facilityprogram);
                        int addedService = genericClassService.fetchRecordCount(Program.class, "WHERE programid=:pId", new String[]{"pId"}, new Object[]{facilityprogram.getProgramid()});
                        if (addedService > 0) {
                            addedProgramList.add(facilityprogram);
                        } else {
                            failedProgramList.add(facilityprogram);
                        }
                    }
                    model.put("addedProgramList", addedProgramList);
                    if (addedProgramList != null && !addedProgramList.isEmpty()) {
                        model.put("mainActivity", "AddProgram");
                        model.put("resp", true);
                        if (addedProgramList.size() == 1) {
                            model.put("successMessage", "Successfully Saved " + addedProgramList.size() + " Facility Program");
                        } else {
                            model.put("successMessage", "Successfully Saved " + addedProgramList.size() + " Facility Program");
                        }
                    } else {
                        model.put("resp", false);
                        model.put("errorMessage", "Saving New Facility Program Failed!");
                    }
                    model.put("failedProgramList", failedProgramList);
                } else {
                    model.put("resp", false);
                    model.put("errorMessage", "No Valid Programs To Be Added!");
                }
                logger.info("saveProgram......... " + addProgramList.size() + " activity........... " + activity);

            } else {
                model.put("resp", false);
                model.put("errorMessage", "No Programs Added!");
            }

            return new ModelAndView("controlPanel/universalPanel/facility/Programs/views/saveResponse", "model", model);

        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("controlPanel/universalPanel/facility/Services/views/saveResponse", "model", model);
        }
    }

    @RequestMapping(value = "/updateFacilityProgram.htm", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView updateFacilityProgram(HttpServletRequest request, Principal principal) {
        logger.info("Received request to get from form for update facility service");
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }

            String activity = request.getParameter("activity");
            String program = request.getParameter("programname");
            String description = request.getParameter("desc");

            long programId = Long.parseLong(request.getParameter("programId"));

            genericClassService.updateRecordSQLStyle(Program.class, new String[]{"description"}, new Object[]{description}, "programid", programId);
            model.put("successMessage", "Successfully Updated Facility Program: " + program + "");
            model.put("resp", true);
            model.put("mainActivity", "Update");
            return new ModelAndView("controlPanel/universalPanel/facility/Programs/views/saveResponse", "model", model);

        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("controlPanel/universalPanel/facility/Programs/views/saveResponse", "model", model);
        }

    }
    
}
    
