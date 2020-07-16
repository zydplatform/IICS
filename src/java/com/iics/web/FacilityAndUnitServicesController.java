/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

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
@RequestMapping("/facilityServicesManagement")
public class FacilityAndUnitServicesController {

    public static String sys_info = null;
    protected static Log logger = LogFactory.getLog("controller");
    @Autowired
    GenericClassService genericClassService;

    /**
     *
     * @param principal
     * @return
     */
    @RequestMapping("/servicesManagement.htm")
    @SuppressWarnings("CallToThreadDumpStack")
    public final ModelAndView servicesManagement(Principal principal, HttpServletRequest request,
            @RequestParam("act") String activity, @RequestParam("i") long id, @RequestParam("d") long id2,
            @RequestParam("b") String strVal, @RequestParam("c") String strVal2,
            @RequestParam("ofst") int offset, @RequestParam("maxR") int maxResults,
            @RequestParam("sStr") String searchPhrase) {
        if (principal == null) {
            return new ModelAndView("refresh");
        }
        Map<String, Object> model = new HashMap<String, Object>();
        model.put("onErrorReturnURL", "ajaxSubmitData('servicesmanagement.htm', 'workpane', 'act=a&i=0&b=a&c=c&d=0&ofst=1&maxR=100&sStr=', 'GET');");
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

            String[] servicesFields = {"serviceid", "servicename", "description", "servicekey", "active", "released", "dateadded", "person.firstname", "person.lastname"};

            List<Facilityservices> serviceList = new ArrayList<Facilityservices>();
            List<Object[]> serviceListArr = new ArrayList<Object[]>();

            if (activity.equals("a1")) {
                return new ModelAndView("controlPanel/universalPanel/facility/Services/tabs", "model", model);
            }
            if (activity.equals("a")) {
                List<String> checkList = new ArrayList<String>();
                String[] params = {};
                Object[] paramsValues = {};
                List<Object[]> servListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityservices.class, servicesFields, "ORDER BY r.servicename ASC", params, paramsValues);
                if (servListArr != null) {
                    for (Object[] objects : servListArr) {
                        checkList.add(((String) objects[1]).toLowerCase());
                    }
                    logger.info("servListArr ::::::::: " + servListArr.size());
                    model.put("size", servListArr.size());
                }
                model.put("serviceList", servListArr);
                model.put("facilityType", "Facility Services Set Up");
                model.put("checkList", checkList);

                return new ModelAndView("controlPanel/universalPanel/facility/Services/serviceMain", "model", model);
            }
            if (activity.equals("a2")) {
                List<String> checkList = new ArrayList<String>();
                String[] params = {};
                Object[] paramsValues = {};
                List<Object[]> servListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityservices.class, servicesFields, "ORDER BY r.servicename ASC", params, paramsValues);
                if (servListArr != null) {
                    for (Object[] objects : servListArr) {
                        checkList.add(((String) objects[1]).toLowerCase());
                    }
                    logger.info("servListArr ::::::::: " + servListArr.size());
                    model.put("size", servListArr.size());
                }
                model.put("serviceList", servListArr);
                model.put("facilityType", "Facility Services Set Up");
                model.put("checkList", checkList);

                return new ModelAndView("controlPanel/universalPanel/facility/Services/views/services", "model", model);
            }
            if (activity.equals("b")) {
                String[] params = {"Id"};
                Object[] paramsValues = {id};
                List<Object[]> servListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityservices.class, servicesFields, "WHERE r.serviceid=:Id ORDER BY r.servicename ASC", params, paramsValues);
                if (servListArr != null) {
                    model.put("serviceObj", servListArr.get(0));
                }

                model.put("facilityType", "Facility Service Details");

                return new ModelAndView("controlPanel/universalPanel/facility/Services/forms/service", "model", model);
            }
            if (activity.equals("c")) {
                String[] params = {"Id"};
                Object[] paramsValues = {id};
                List<Object[]> servListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityservices.class, servicesFields, "WHERE r.serviceid=:Id ORDER BY r.servicename ASC", params, paramsValues);
                if (servListArr != null) {
                    genericClassService.deleteRecordByByColumns(Facilityservices.class, new String[]{"serviceid"}, new Object[]{id});
                    model.put("serviceObj", servListArr.get(0));
                    List<Object[]> servListArr2 = (List<Object[]>) genericClassService.fetchRecord(Facilityservices.class, servicesFields, "WHERE r.serviceid=:Id ORDER BY r.servicename ASC", params, paramsValues);
                    if (servListArr2 == null) {
                        model.put("resp", true);
                        model.put("successMessage", "Successfully Deleted " + servListArr.get(0)[1] + " Facility Service");
                    } else {
                        model.put("resp", false);
                        model.put("errorMessage", "Service Not Deleted! Check Attachments");
                    }
                } else {
                    model.put("resp", false);
                    model.put("errorMessage", "Service Not Found!");
                }

                model.put("mainActivity", "Delete");

                return new ModelAndView("controlPanel/universalPanel/facility/Services/views/saveResponse", "model", model);
            }
            if (activity.equals("d")) {
                int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
                String[] params = {"state"};
                Object[] paramsValues = {true};
                List<Object[]> servListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityservices.class, servicesFields, "WHERE r.released=:state AND r.active=:state ORDER BY r.servicename ASC", params, paramsValues);
                if (servListArr != null) {
                    logger.info("servListArr ::::::::: " + servListArr.size());
                    model.put("size", servListArr.size());
                    for (Object[] objects : servListArr) {
                        Facilityservices s = new Facilityservices((Integer) objects[0]);
                        s.setServicename((String) objects[1]);
                        s.setDescription((String) objects[2]);
                        int countAssigned = genericClassService.fetchRecordCount(Facilityunitservice.class, "WHERE r.facilityservices.serviceid=:Id AND r.facilityunit.facilityid=:fId", new String[]{"Id", "fId"}, new Object[]{s.getServiceid(), facilityid});
                        s.setUnits(countAssigned);
                        serviceList.add(s);
                    }
                }
                model.put("serviceList", serviceList);
                model.put("facilityType", "Facility Services Set Up");

                return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/Services/serviceMain", "model", model);
            }
            if (activity.equals("e")) {
                int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
                String[] unitFields = {"facilityunitid", "facilityunitname", "shortname", "description", "active", "service"};
                String[] structureFields = {"structureid", "hierachylabel", "description", "active"};

                String[] params = {"Id"};
                Object[] paramsValues = {id};
                List<Object[]> servListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityservices.class, servicesFields, "WHERE r.serviceid=:Id ORDER BY r.servicename ASC", params, paramsValues);
                if (servListArr != null) {
                    model.put("serviceObj", servListArr.get(0));
                }

                List<Facilityunit> facilityUnitList = new ArrayList<Facilityunit>();
                List<Object[]> unitListArr = new ArrayList<Object[]>();
                request.getSession().setAttribute("sessReturnSelectedFacilityUnitUrl", "ajaxSubmitData('facilityServicesManagement/servicesManagement.htm', 'tabContent', 'act=a&i=" + id + "&b=" + strVal + "&c=" + strVal2 + "&d=" + id2 + "&ofst=" + offset + "&maxR=" + maxResults + "&sStr=" + searchPhrase + "', 'GET');");
                unitListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, unitFields, "WHERE r.facilityid=:facId AND r.service=:state AND r.facilityunitid NOT IN (SELECT fu.facilityunit.facilityunitid FROM Facilityunitservice fu WHERE fu.facilityservices.serviceid=:sId AND fu.facilityunit.facilityid=:facId) ORDER BY r.facilityunitname ASC", new String[]{"facId", "sId", "state"}, new Object[]{facilityid, id, true});
                if (unitListArr != null) {
                    for (Object[] unitObj : unitListArr) {
                        Facilityunit unit = new Facilityunit((Long) unitObj[0]);
                        unit.setFacilityunitname((String) unitObj[1]);
                        unit.setShortname((String) unitObj[2]);
                        unit.setDescription((String) unitObj[3]);
                        unit.setActive((Boolean) unitObj[4]);

                        facilityUnitList.add(unit);
                    }
                    model.put("size", facilityUnitList.size());
                }
                model.put("facilityUnitList", facilityUnitList);

                return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/Services/views/addUnits", "model", model);
            }
            if (activity.equals("f")) {
                int facilityid = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());

                String[] params = {"Id"};
                Object[] paramsValues = {id};
                List<Object[]> servListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityservices.class, new String[]{"serviceid", "servicename"}, "WHERE r.serviceid=:Id", params, paramsValues);
                if (servListArr != null) {
                    model.put("serviceObj", servListArr.get(0));
                }

                List<Facilityunitservice> unitServiceList = new ArrayList<Facilityunitservice>();
                List<Object[]> serviceArrListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunitservice.class, new String[]{"facilityunitserviceid", "facilityunit.facilityunitid", "facilityunit.facilityunitname", "status"}, "WHERE r.facilityservices.serviceid=:Id AND r.facilityunit.facilityid=:fId ORDER BY r.facilityunit.facilityunitname ASC", new String[]{"Id", "fId"}, new Object[]{id, facilityid});

                if (serviceArrListArr != null) {
                    logger.info("serviceArrListArr :::::: " + serviceArrListArr.size());
                    for (Object[] obj : serviceArrListArr) {
                        Facilityunitservice unitService = new Facilityunitservice((Long) obj[0]);
                        Facilityunit unit = new Facilityunit((Long) obj[1]);
                        unit.setFacilityunitname((String) obj[2]);
                        unitService.setFacilityunit(unit);
                        unitService.setStatus((Boolean) obj[3]);
                        unitServiceList.add(unitService);
                    }
                    model.put("size", serviceArrListArr.size());
                }
                model.put("unitServiceList", unitServiceList);
                return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/Services/views/assignedUnits", "model", model);
            }
            if (activity.equals("g")) {
                boolean state = Boolean.parseBoolean(strVal);
                long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
//                long unitserviceid=0;
//                String[] params = {"Id","UnitId"};
//                Object[] paramsValues = {id2,id};
//                List<Object[]> servListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunitservice.class, new String[]{"facilityunitserviceid","facilityservices.serviceid", "facilityservices.servicename"}, "WHERE r.facilityunit.facilityunitid=:UnitId AND r.facilityservices.serviceid=:Id", params, paramsValues);
//                if (servListArr != null) {
//                    model.put("serviceObj", servListArr.get(0));
//                    unitserviceid=(Long)servListArr.get(0)[0];
//                                     
//                }
                genericClassService.updateRecordSQLStyle(Facilityunitservice.class, new String[]{"status", "updatedby", "dateupdated"}, new Object[]{state, pid, new Date()}, "facilityunitserviceid", id);
                logger.info("Return view for :::: Activity:f Unit Service:" + id);
                return servicesManagement(principal, request, "f", id2, id2, strVal, strVal2, offset, maxResults, searchPhrase);
            }
            return new ModelAndView("controlPanel/universalPanel/Facility/Services/forms/response", "model", model);

        } catch (Exception e) {
            e.printStackTrace();
        }
        model.put("success", "<span class='text6'>Contact System Administrator :: Page Not Found!</span>");
        return new ModelAndView("response", "model", model);
    }

    @RequestMapping(value = "/registerFacService.htm", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView registerFacService(HttpServletRequest request, Principal principal) {
        logger.info("Received request to get from form for reg facility service");
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }

            int count = Integer.parseInt(request.getParameter("itemSize"));
            String activity = request.getParameter("activity");
            List<Facilityservices> addServiceList = new ArrayList<Facilityservices>();
            List<Facilityservices> existingServiceList = new ArrayList<Facilityservices>();
            List<Facilityservices> addedServiceList = new ArrayList<Facilityservices>();
            List<Facilityservices> failedServiceList = new ArrayList<Facilityservices>();
            model.put("activity", activity);
            long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());

            if (count > 0) {
                logger.info("item Count......... " + count + ">0");
                for (int i = 1; i <= count; i++) {
                    if (request.getParameter("sName" + i) != null) {
                        logger.info("Posted Service...... " + request.getParameter("sName" + i));
                        String sName = request.getParameter("sName" + i);
                        String description = request.getParameter("sDesc" + i);
                        String serviceKey = request.getParameter("sKey" + i);

                        String serviceName = "";
                        BreakIterator wordBreaker = BreakIterator.getWordInstance();
                        String str = sName.trim();
                        wordBreaker.setText(str);
                        int end = 0;
                        for (int start = wordBreaker.first();
                                (end = wordBreaker.next()) != BreakIterator.DONE; start = end) {
                            String word = str.substring(start, end);
                            String joined_word = word.substring(0, 1).toUpperCase() + word.substring(1).toLowerCase();
                            if (end != 0) {
                                serviceName += joined_word;
                            }
                        }

                        Facilityservices service = new Facilityservices();
                        //Check Existing Policy
                        int countExistingService = genericClassService.fetchRecordCount(Facilityservices.class, "WHERE LOWER(r.servicename)=:name", new String[]{"name"}, new Object[]{serviceName.toLowerCase()});
                        if (countExistingService > 0) {
                            service.setServicename(serviceName);
                            service.setServicekey(serviceKey);
                            service.setDescription(description);
                            existingServiceList.add(service);
                        } else {
                            service.setServicename(serviceName);
                            service.setServicekey(serviceKey);
                            service.setDescription(description);
                            service.setActive(true);
                            service.setReleased(false);
                            service.setDateadded(new Date());
                            service.setPerson(new Person(pid));
                            addServiceList.add(service);
                        }
                    }
                }
                if (addServiceList != null && !addServiceList.isEmpty()) {
                    for (Facilityservices facilityservice : addServiceList) {
                        genericClassService.saveOrUpdateRecordLoadObject(facilityservice);
                        int addedService = genericClassService.fetchRecordCount(Facilityservices.class, "WHERE serviceid=:sId", new String[]{"sId"}, new Object[]{facilityservice.getServiceid()});
                        if (addedService > 0) {
                            addedServiceList.add(facilityservice);
                        } else {
                            failedServiceList.add(facilityservice);
                        }
                    }
                    model.put("addedServiceList", addedServiceList);
                    if (addedServiceList != null && !addedServiceList.isEmpty()) {
                        model.put("mainActivity", "AddFacilityService");
                        model.put("resp", true);
                        if (addedServiceList.size() == 1) {
                            model.put("successMessage", "Successfully Saved " + addedServiceList.size() + " Facility Service");
                        } else {
                            model.put("successMessage", "Successfully Saved " + addedServiceList.size() + " Facility Services");
                        }
                    } else {
                        model.put("resp", false);
                        model.put("errorMessage", "Saving New Facility Service Failed!");
                    }
                    model.put("failedServiceList", failedServiceList);
                } else {
                    model.put("resp", false);
                    model.put("errorMessage", "No Valid Services To Be Added!");
                }
                logger.info("savePolicy......... " + addServiceList.size() + " activity........... " + activity);

            } else {
                model.put("resp", false);
                model.put("errorMessage", "No Services Added!");
            }

            return new ModelAndView("controlPanel/universalPanel/facility/Services/views/saveResponse", "model", model);

        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("controlPanel/universalPanel/facility/Services/views/saveResponse", "model", model);
        }

    }

    @RequestMapping(value = "/updateFacilityService.htm", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView updateFacilityService(HttpServletRequest request, Principal principal) {
        logger.info("Received request to get from form for update facility service");
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }

            String activity = request.getParameter("activity");
            String service = request.getParameter("servicename");
            String description = request.getParameter("description");
            boolean status = Boolean.parseBoolean(request.getParameter("status"));
            boolean release = Boolean.parseBoolean(request.getParameter("release"));

            long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
            long serviceId = Long.parseLong(request.getParameter("serviceId"));

            genericClassService.updateRecordSQLStyle(Facilityservices.class, new String[]{"description", "active", "released", "updatedby", "dateupdated"}, new Object[]{description, status, release, pid, new Date()}, "serviceid", serviceId);
            model.put("successMessage", "Successfully Updated Facility Service: " + service + "");
            model.put("resp", true);
            model.put("mainActivity", "Update");
            return new ModelAndView("controlPanel/universalPanel/facility/Services/views/saveResponse", "model", model);

        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("controlPanel/universalPanel/facility/Services/views/saveResponse", "model", model);
        }

    }

    /**
     *
     * @param request
     * @param principal
     * @return
     */
    @RequestMapping(value = "/assignFacilityUnitService.htm", method = RequestMethod.POST)
    @SuppressWarnings("CallToThreadDumpStack")
    public ModelAndView assignFacilityUnitService(HttpServletRequest request, Principal principal) {
        logger.info("Received request to assign service");
        Map<String, Object> model = new HashMap<String, Object>();
        try {
            if (principal == null) {
                return new ModelAndView("login");
            }
            long pid = Long.parseLong(request.getSession().getAttribute("person_id").toString());
            List<Long> ids = new ArrayList<Long>();
            List<Facilityunit> addedList = new ArrayList<Facilityunit>();
            List<Facilityunit> failedList = new ArrayList<Facilityunit>();
            int serviceId = Integer.parseInt(request.getParameter("service"));
            int count = Integer.parseInt(request.getParameter("itemSize"));
            String activity = request.getParameter("act");
            if (count > 0) {
                logger.info("item Count......... " + count + ">0");
                for (int i = 1; i <= count; i++) {
                    if (request.getParameter("selectObj" + i) != null) {
                        logger.info("Posted ID...... " + request.getParameter("selectObj" + i));
                        long id = Long.parseLong(request.getParameter("selectObj" + i));
                        ids.add(id);
                    }
                }
            } else {
                model.put("resp", false);
                model.put("successmessage", "No Record Submitted");
                return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/Services/views/saveResponse", "model", model);
            }
            int added = 0;
            int unDeleted = 0;
            for (Long id : ids) {
                if (activity.equals("a")) {
                    Facilityunitservice service = new Facilityunitservice();
                    service.setFacilityunit(new Facilityunit(id));
                    service.setFacilityservices(new Facilityservices(serviceId));
                    service.setDateadded(new Date());
                    service.setStatus(true);
                    service.setPerson(new Person(pid));

                    genericClassService.saveOrUpdateRecordLoadObject(service);
                    int addedService = 0;
                    List<Object[]> serviceListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunitservice.class, new String[]{"facilityunit.facilityunitid", "facilityunit.facilityunitname"}, "WHERE r.facilityunitserviceid=:Id", new String[]{"Id"}, new Object[]{service.getFacilityunitserviceid()});
                    if (serviceListArr != null) {
                        addedService = serviceListArr.size();
                        for (Object[] obj : serviceListArr) {
                            Facilityunit unit = new Facilityunit(id);
                            unit.setFacilityunitname((String) obj[1]);
                            addedList.add(unit);
                        }
                    } else {
                        List<Object[]> unitListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, new String[]{"facilityunitid", "facilityunitname"}, "WHERE r.facilityunitid=:Id ORDER BY r.facilityunitname ASC", new String[]{"Id"}, new Object[]{id});
                        if (unitListArr != null) {
                            for (Object[] obj : unitListArr) {
                                Facilityunit unit = new Facilityunit(id);
                                unit.setFacilityunitname((String) obj[1]);
                                failedList.add(unit);
                            }
                        }
                    }
                    //genericClassService.fetchRecordCount(Facilityunitservice.class, "WHERE r.facilityunitserviceid=:sId", new String[]{"sId"}, new Object[]{service.getFacilityunitserviceid()});
                    if (addedService > 0) {
                        added += 1;
                    }
                }
                if (activity.equals("b")) {
                    String[] params = {"Id"};
                    Object[] paramsValues = {id};
                    List<Object[]> servListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunitservice.class, new String[]{"facilityservices.serviceid", "facilityservices.servicename"}, "WHERE r.facilityunitserviceid=:Id", params, paramsValues);
                    if (servListArr != null) {
                        model.put("serviceObj", servListArr.get(0));
                    }

                    Facilityunitservice service = new Facilityunitservice(id);
                    Facilityunit unit = new Facilityunit();
                    List<Object[]> serviceListArr = (List<Object[]>) genericClassService.fetchRecord(Facilityunitservice.class, new String[]{"facilityunitserviceid", "facilityunit.facilityunitid", "facilityunit.facilityunitname"}, "WHERE r.facilityunitserviceid=:Id", new String[]{"Id"}, new Object[]{id});
                    if (serviceListArr != null) {
                        for (Object[] obj : serviceListArr) {
                            unit = new Facilityunit((Long) obj[1]);
                            unit.setFacilityunitname((String) obj[2]);
                            service.setFacilityunit(unit);
                        }
                    }
                    genericClassService.deleteRecordByByColumns(Facilityunitservice.class, new String[]{"facilityunitserviceid"}, new Object[]{id});
                    int checkDelete = genericClassService.fetchRecordCount(Facilityunitservice.class, "WHERE r.facilityunitserviceid=:sId", new String[]{"sId"}, new Object[]{id});
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
                activeType = "Facility Unit Service";
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
                    model.put("successMessage", addedList.size() + " Unit(s) Successfully De-Assigned");
                } else {
                    model.put("resp", false);
                    model.put("errorMessage", "De-Assignment Was Not Successful! " + unDeleted + " Unit(s) Not Successfully De-Assigned");
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

        return new ModelAndView("controlPanel/localSettingsPanel/Facility/FacilityUnit/Services/views/saveResponse", "model", model);
    }

}
