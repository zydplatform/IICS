/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.dashboard.Itemstatistics;
import com.iics.dashboard.Timeontaskview;
import com.iics.domain.Designation;
import com.iics.domain.Facilityservices;
import com.iics.domain.Facilityunit;
import com.iics.domain.Facilityunitservice;
import com.iics.domain.Searchstaff;
import com.iics.patient.Patientstartisticsview;
import com.iics.patient.Servicequeue;
import com.iics.service.GenericClassService;
import com.iics.store.Itempackage;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;
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
 * @author IICS
 */
@Controller
@RequestMapping("/dashboard")
public class Dashboard {

    @Autowired
    GenericClassService genericClassService;
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat fmt = new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat hrs = new SimpleDateFormat("hh:mm a");
    SimpleDateFormat formatterWithTime = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
    SimpleDateFormat formatterWithTime2 = new SimpleDateFormat("dd-MM-yyyy HH:mm");
    private final SimpleDateFormat formatterwithtime3 = new SimpleDateFormat("yyyy-MM-dd hh:mm aa");
    private final Date serverDate = new Date();
    private final SimpleDateFormat year = new SimpleDateFormat("yyyy");
    
    @RequestMapping(value = "/loadDashboardMenu", method = RequestMethod.GET)
    public String loadDashboardMenu(Model model) {
        return "dashboardAndReports/dashboardMenu";
    }

    @RequestMapping(value = "/loadStaffActiviiesMenu", method = RequestMethod.GET)
    public String loadStaffActiviiesMenu(Model model) {
        return "dashboardAndReports/staffActivities/staffActivitiesMenu";
    }

    @RequestMapping(value = "/loadStaffPerformancePane", method = RequestMethod.GET)
    public String loadStaffPerformancePane(HttpServletRequest request, Model model) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            List<Map> facilityUnits = new ArrayList<>();
            Integer facilityid = (Integer) request.getSession().getAttribute("sessionActiveLoginFacility");

            String[] params = {"servicekey"};
            Object[] paramsValues = {"key_consultation"};
            String[] fields = {"serviceid"};
            List<Object> consultationKey = (List<Object>) genericClassService.fetchRecord(Facilityservices.class, fields, "WHERE servicekey=:servicekey", params, paramsValues);
            if (consultationKey != null) {
                String[] params2 = {"facilityid"};
                Object[] paramsValues2 = {facilityid};
                String[] fields2 = {"facilityunitid", "facilityunitname"};
                String where2 = "WHERE facilityid=:facilityid ORDER BY facilityunitname";
                List<Object[]> units = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields2, where2, params2, paramsValues2);
                if (units != null) {
                    Map<String, Object> zone;
                    for (Object[] object : units) {
                        String[] params3 = {"serviceid", "facilityunit"};
                        Object[] paramValues3 = {consultationKey.get(0), object[0]};
                        String where3 = "WHERE serviceid=:serviceid AND facilityunitid=:facilityunit";
                        int serviceCount = genericClassService.fetchRecordCount(Facilityunitservice.class, where3, params3, paramValues3);
                        if (serviceCount > 0) {
                            zone = new HashMap<>();
                            zone.put("id", object[0]);
                            zone.put("name", object[1]);
                            facilityUnits.add(zone);
                        }
                    }
                }
            }
            model.addAttribute("units", facilityUnits);
            model.addAttribute("serverdate", formatterwithtime3.format(serverDate));
            return "dashboardAndReports/staffActivities/clinicPerformance/staffPerformancePane";
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchPatientStaffPerformance", method = RequestMethod.POST)
    public String fetchPatientStaffPerformance(HttpServletRequest request, Model model, @ModelAttribute("unit") Integer unit, @ModelAttribute("start") String start, @ModelAttribute("end") String end) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            Integer serviced = 0;
            Integer canceled = 0;
            Integer unattended = 0;
            Map<String, Object> summary = new HashMap<>();
            List<Map> staffPerformancePlot = new ArrayList<>();
            List<Map> staffPerformanceList = new ArrayList<>();
            Date startDate, endDate;
            int totalHoursOnTask = 0;
            int totalMinutesOnTask = 0;
            BigDecimal unitServiceId = BigDecimal.ZERO;
            try {
                startDate = fmt.parse(start);
                endDate = fmt.parse(end);
                String[] params = {"servicekey"};
                Object[] paramsValues = {"key_consultation"};
                String[] fields = {"serviceid"};
                String where = "WHERE servicekey=:servicekey";
                List<Integer> serviceid = (List<Integer>) genericClassService.fetchRecord(Facilityservices.class, fields, where, params, paramsValues);
                if (serviceid != null) {
                    String[] params2 = {"serviceid", "facilityunitid"};
                    Object[] paramValues2 = {serviceid, unit};
                    String[] fields2 = {"facilityunitserviceid"};
                    String where2 = "WHERE serviceid=:serviceid AND facilityunitid=:facilityunitid";
                    List<Long> unitService = (List<Long>) genericClassService.fetchRecord(Facilityunitservice.class, fields2, where2, params2, paramValues2);
                    if (unitService != null) {
                        unitServiceId = BigDecimal.valueOf(Double.parseDouble(unitService.get(0).toString()));
                        String[] params3 = {"unitserviceid", "serviced", "canceled", "start", "end"};
                        Object[] paramsValues3 = {unitService.get(0), true, false, startDate, endDate};
                        String where3 = "WHERE unitserviceid=:unitserviceid AND serviced=:serviced AND canceled=:canceled AND DATE(timein)>=:start AND DATE(timein)<=:end";
                        serviced = genericClassService.fetchRecordCount(Servicequeue.class, where3, params3, paramsValues3);

                        String[] params4 = {"unitserviceid", "serviced", "canceled", "start", "end"};
                        Object[] paramsValues4 = {unitService.get(0), true, true, startDate, endDate};
                        String where4 = "WHERE unitserviceid=:unitserviceid AND serviced=:serviced AND canceled=:canceled AND DATE(timein)>=:start AND DATE(timein)<=:end";
                        canceled = genericClassService.fetchRecordCount(Servicequeue.class, where4, params4, paramsValues4);

//                        String[] params5 = {"unitserviceid", "serviced", "canceled", "start", "end"};
//                        Object[] paramsValues5 = {unitService.get(0), false, false, startDate, endDate};
//                        String where5 = "WHERE unitserviceid=:unitserviceid AND serviced=:serviced AND canceled=:canceled AND DATE(timein)>=:start AND DATE(timein)<=:end";
                        String[] params5 = {"unitserviceid", "serviced", "canceled", "ispopped", "start", "end"};
                        Object[] paramsValues5 = {unitService.get(0), false, false, false, startDate, endDate};
                        String where5 = "WHERE unitserviceid=:unitserviceid AND serviced=:serviced AND canceled=:canceled AND ispopped=:ispopped AND DATE(timein)>=:start AND DATE(timein)<=:end";
                        unattended = genericClassService.fetchRecordCount(Servicequeue.class, where5, params5, paramsValues5);

                        String[] params6 = {"unitserviceid", "serviced", "canceled", "start", "end"};
                        Object[] paramValues6 = {unitService.get(0), true, false, startDate, endDate};
//                        String[] fields6 = {"r.servicedby", "COUNT(r.servicequeueid)"};
                        String[] fields6 = {"r.servicedby", "COUNT(r.servicequeueid)", "MIN(r.timeout)", "MAX(r.timeout)"};
//                        String where6 = "WHERE r.unitserviceid=:unitserviceid AND r.serviced=:serviced AND r.canceled=:canceled AND DATE(r.timein)>=:start AND DATE(r.timein)<=:end GROUP BY r.servicedby";
                        String where6 = "WHERE r.unitserviceid=:unitserviceid AND r.serviced=:serviced AND r.canceled=:canceled AND DATE(r.timein)>=:start AND DATE(r.timein)<=:end GROUP BY r.servicedby ORDER BY COUNT(r.servicequeueid) DESC";
                        List<Object[]> staffPerformance = (List<Object[]>) genericClassService.fetchRecordFunction(Servicequeue.class, fields6, where6, params6, paramValues6, 0, 0);
                        if (staffPerformance != null) {
                            Map<String, Object> staff;
                            for (Object[] stf : staffPerformance) {
                                staff = new HashMap<>();
                                staff.put("patients", stf[1]);

                                String[] params7 = {"staffid"};
                                Object[] paramsValues7 = {stf[0]};
                                String[] fields7 = {"firstname", "othernames", "lastname", "staffno"};
                                String where7 = "WHERE staffid=:staffid";
                                List<Object[]> staffDetails = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields7, where7, params7, paramsValues7);
                                if (staffDetails != null) {
                                    String init;
                                    String names;
                                    if (staffDetails.get(0)[1] != null) {
                                        if (((String) staffDetails.get(0)[1]).length() > 0) {
                                            init = ((String) staffDetails.get(0)[0]).charAt(0) + "." + ((String) staffDetails.get(0)[1]).charAt(0) + "." + ((String) staffDetails.get(0)[2]).charAt(0);
                                        } else {
                                            init = ((String) staffDetails.get(0)[0]).charAt(0) + ". " + ((String) staffDetails.get(0)[2]).charAt(0);
                                        }
                                        names = ((String) staffDetails.get(0)[0]) + " " + ((String) staffDetails.get(0)[1]) + " " + staffDetails.get(0)[2];
                                    } else {
                                        init = ((String) staffDetails.get(0)[0]).charAt(0) + ". " + ((String) staffDetails.get(0)[2]).charAt(0);
                                        names = ((String) staffDetails.get(0)[0]) + " " + staffDetails.get(0)[2];
                                    }
                                    staff.put("user", init);
                                    staffPerformancePlot.add(staff);

                                    staff.put("stno", staffDetails.get(0)[3]);
                                    staff.put("names", names);
                                    //
                                    totalHoursOnTask = 0;
                                    totalMinutesOnTask = 0;
                                    fields = new String[]{"servicedby", "date", "starttime", "endtime"};
                                    params = new String[]{"servicedby", "startdate", "enddate", "unitserviceid"};
                                    paramsValues = new Object[]{BigInteger.valueOf(Long.parseLong(stf[0].toString())), startDate, endDate, unitServiceId};
                                    where = "WHERE servicedby=:servicedby AND unitserviceid=:unitserviceid AND DATE(date) BETWEEN SYMMETRIC :startdate AND :enddate";
                                    List<Object[]> staffTimeOnTaskList = (List<Object[]>) genericClassService.fetchRecord(Timeontaskview.class, fields, where, params, paramsValues);
                                    if (staffTimeOnTaskList != null) {
                                        for (Object[] timeOnTask : staffTimeOnTaskList) {
                                            Map<String, Object> timeOnTaskData = getTimeDifference(((Date) timeOnTask[2]), ((Date) timeOnTask[3]));
                                            totalHoursOnTask += Integer.parseInt(timeOnTaskData.get("hours").toString());
                                            totalMinutesOnTask += Integer.parseInt(timeOnTaskData.get("minutes").toString());
                                        }
                                    }
                                    if(totalMinutesOnTask > 60){
                                        DecimalFormat decimalFormat = new DecimalFormat("#.00");
                                        String minutes = decimalFormat.format((totalMinutesOnTask / 60.0));
                                        int tempMinutes = Integer.parseInt(String.valueOf(Math.round(Float.parseFloat(minutes.substring((minutes.indexOf(".")))) * 60)));
                                        int tempHours = Integer.parseInt(minutes.substring(0, (minutes.indexOf("."))));
                                        totalHoursOnTask += tempHours;
                                        totalMinutesOnTask = tempMinutes;
                                    }
                                    staff.put("timeontask", String.format("%s Hour(s) : %s Minute(s)", totalHoursOnTask, totalMinutesOnTask));
                                    //
                                    staffPerformanceList.add(staff);
                                }
                            }
                        }
                    }
                }

                summary.put("serviced", serviced);
                summary.put("canceled", canceled);
                summary.put("unattended", unattended);

                String plots = new ObjectMapper().writeValueAsString(staffPerformancePlot);

                model.addAttribute("plots", plots);
                model.addAttribute("summary", summary);
                model.addAttribute("performance", staffPerformanceList);
                return "dashboardAndReports/staffActivities/clinicPerformance/range/performanceSummary";
            } catch (ParseException e) {
                return "dashboardAndReports/staffActivities/clinicPerformance/range/dateError";
            } catch (JsonProcessingException ex) {
                return "dashboardAndReports/staffActivities/clinicPerformance/range/noPatients";
            }
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/fetchDailyStaffPerformance", method = RequestMethod.POST)
    public String fetchDailyStaffPerformance(HttpServletRequest request, Model model, @ModelAttribute("unit") Integer unit, @ModelAttribute("date") String date) {
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") != null) {
            Integer serviced = 0;
            Integer canceled = 0;
            Integer unattended = 0;
            Map<String, Object> summary = new HashMap<>();
            List<Map> staffPerformancePlot = new ArrayList<>();
            List<Map> staffPerformanceList = new ArrayList<>();
            Date reprotDate;

            try {
                reprotDate = fmt.parse(date);
                String[] params = {"servicekey"};
                Object[] paramsValues = {"key_consultation"};
                String[] fields = {"serviceid"};
                String where = "WHERE servicekey=:servicekey";
                List<Integer> serviceid = (List<Integer>) genericClassService.fetchRecord(Facilityservices.class, fields, where, params, paramsValues);
                if (serviceid != null) {
                    String[] params2 = {"serviceid", "facilityunitid"};
                    Object[] paramValues2 = {serviceid, unit};
                    String[] fields2 = {"facilityunitserviceid"};
                    String where2 = "WHERE serviceid=:serviceid AND facilityunitid=:facilityunitid";
                    List<Long> unitService = (List<Long>) genericClassService.fetchRecord(Facilityunitservice.class, fields2, where2, params2, paramValues2);
                    if (unitService != null) {
                        String[] params3 = {"unitserviceid", "serviced", "canceled", "reportDate"};
                        Object[] paramsValues3 = {unitService.get(0), true, false, reprotDate};
                        String where3 = "WHERE unitserviceid=:unitserviceid AND serviced=:serviced AND canceled=:canceled AND DATE(timein)=:reportDate";
                        serviced = genericClassService.fetchRecordCount(Servicequeue.class, where3, params3, paramsValues3);

                        String[] params4 = {"unitserviceid", "serviced", "canceled", "reportDate"};
                        Object[] paramsValues4 = {unitService.get(0), true, true, reprotDate};
                        String where4 = "WHERE unitserviceid=:unitserviceid AND serviced=:serviced AND canceled=:canceled AND DATE(timein)=:reportDate";
                        canceled = genericClassService.fetchRecordCount(Servicequeue.class, where4, params4, paramsValues4);

//                        String[] params5 = {"unitserviceid", "serviced", "canceled", "reportDate"};
//                        Object[] paramsValues5 = {unitService.get(0), false, false, reprotDate};
//                        String where5 = "WHERE unitserviceid=:unitserviceid AND serviced=:serviced AND canceled=:canceled AND DATE(timein)=:reportDate";
                        String[] params5 = {"unitserviceid", "serviced", "canceled", "ispopped", "reportDate"};
                        Object[] paramsValues5 = {unitService.get(0), false, false, false, reprotDate};
                        String where5 = "WHERE unitserviceid=:unitserviceid AND serviced=:serviced AND canceled=:canceled AND ispopped=:ispopped AND DATE(timein)=:reportDate";
                        unattended = genericClassService.fetchRecordCount(Servicequeue.class, where5, params5, paramsValues5);

                        String[] params6 = {"unitserviceid", "serviced", "canceled", "reportDate"};
                        Object[] paramValues6 = {unitService.get(0), true, false, reprotDate};
                        String[] fields6 = {"r.servicedby", "COUNT(r.servicequeueid)", "MIN(r.timeout)", "MAX(r.timeout)"};
                        String where6 = "WHERE r.unitserviceid=:unitserviceid AND r.serviced=:serviced AND r.canceled=:canceled AND DATE(r.timein)=:reportDate GROUP BY r.servicedby ORDER BY COUNT(r.servicequeueid) DESC";
                        List<Object[]> staffPerformance = (List<Object[]>) genericClassService.fetchRecordFunction(Servicequeue.class, fields6, where6, params6, paramValues6, 0, 0);
                        if (staffPerformance != null) {
                            Map<String, Object> staff;
                            for (Object[] stf : staffPerformance) {
                                staff = new HashMap<>();
                                staff.put("patients", stf[1]);

                                String[] params7 = {"staffid"};
                                Object[] paramsValues7 = {stf[0]};
                                String[] fields7 = {"firstname", "othernames", "lastname", "staffno", "designationid"};
                                String where7 = "WHERE staffid=:staffid";
                                List<Object[]> staffDetails = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields7, where7, params7, paramsValues7);
                                if (staffDetails != null) {
                                    String init;
                                    String names;
                                    if (staffDetails.get(0)[1] != null) {
                                        if (((String) staffDetails.get(0)[1]).length() > 0) {
                                            init = ((String) staffDetails.get(0)[0]).charAt(0) + "." + ((String) staffDetails.get(0)[1]).charAt(0) + "." + ((String) staffDetails.get(0)[2]).charAt(0);
                                        } else {
                                            init = ((String) staffDetails.get(0)[0]).charAt(0) + ". " + ((String) staffDetails.get(0)[2]).charAt(0);
                                        }
                                        names = ((String) staffDetails.get(0)[0]) + " " + ((String) staffDetails.get(0)[1]) + " " + staffDetails.get(0)[2];
                                    } else {
                                        init = ((String) staffDetails.get(0)[0]).charAt(0) + ". " + ((String) staffDetails.get(0)[2]).charAt(0);
                                        names = ((String) staffDetails.get(0)[0]) + " " + staffDetails.get(0)[2];
                                    }
                                    staff.put("user", init);
                                    staffPerformancePlot.add(staff);

                                    staff.put("names", names);
                                    staff.put("stno", staffDetails.get(0)[3]);
                                    // Add Designation
                                    String designation = (((List<String>) genericClassService.fetchRecord(Designation.class, new String[]{"designationname"}, "WHERE designationid=:designationid", new String[]{"designationid"}, new Object[]{staffDetails.get(0)[4]})).get(0));
                                    staff.put("designation", designation);
                                    staffPerformanceList.add(staff);
                                }
                                staff.put("first", hrs.format((Date) stf[2]));
                                staff.put("last", hrs.format((Date) stf[3]));
                                Map<String, Object> timeOnTaskData = getTimeDifference(((Date) stf[2]), ((Date) stf[3]));
                                String timeOnTask = String.format("%s Hour(s) : %s Minute(s)", timeOnTaskData.get("hours").toString(), timeOnTaskData.get("minutes").toString());
                                staff.put("timeontask", timeOnTask);
                                staff.put("rate", (((Date) stf[3]).getTime() - ((Date) stf[2]).getTime()) / (1000 * 60 * Integer.parseInt(stf[1].toString())));
                            }
                        }
                    }
                }

                summary.put("serviced", serviced);
                summary.put("canceled", canceled);
                summary.put("unattended", unattended);

                String plots = new ObjectMapper().writeValueAsString(staffPerformancePlot);

                model.addAttribute("dailyPlots", plots);
                model.addAttribute("dailySummary", summary);
                model.addAttribute("dailyPerformance", staffPerformanceList);
                return "doctorConsultations/performance/performanceSummary";
            } catch (ParseException e) {
                return "dashboardAndReports/staffActivities/clinicPerformance/dateError";
            } catch (JsonProcessingException ex) {
                return "dashboardAndReports/staffActivities/clinicPerformance/noPatients";
            }
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/facilitypatientstatistics", method = RequestMethod.GET)
    public ModelAndView facilityPatientStatistics(HttpServletRequest request) {
        Map<String, Object> model = new HashMap<String, Object>();
        if (request.getSession().getAttribute("sessionActiveLoginFacility") == null) {
            return new ModelAndView("refresh");
        }
        try {
            Integer facilityId = (Integer) request.getSession().getAttribute("sessionActiveLoginFacility");
            List<Map> facilityUnitsList = new ArrayList<>();
            Integer facilityUnit = (Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit");
            //Get Units
            String[] params = {"facilityid", "administrative"};
            Object[] paramsValues = {facilityId, false};

            String[] fields = {"facilityunitid", "facilityunitname"};
            String where = "WHERE facilityid=:facilityid AND administrative=:administrative";
            List<Object[]> objFacilityUnits = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields, where, params, paramsValues);
            if (objFacilityUnits != null) {
                Map<String, Object> unitMap;
                for (Object[] units : objFacilityUnits) {
                    unitMap = new HashMap<>();
                    unitMap.put("id", units[0]);
                    unitMap.put("name", units[1]);
                    Boolean selected = (Long.parseLong(units[0].toString()) == Long.parseLong(facilityUnit.toString())) ? Boolean.TRUE : Boolean.FALSE;
                    unitMap.put("selected", selected);
                    facilityUnitsList.add(unitMap);
                }
            }
            model.put("facilityUnitsList", facilityUnitsList);
            model.put("serverdate", formatterwithtime3.format(serverDate));
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return new ModelAndView("dashboardAndReports/patientStatistics/patientStatisticsMain", model);
    }

    @RequestMapping(value = "/viewfacilityPatientStatistics", method = RequestMethod.GET)
    public ModelAndView viewFacilityPatientStatistics(HttpServletRequest request) {
        if (request.getSession().getAttribute("sessionActiveLoginFacility") == null) {
            return new ModelAndView("refresh");
        }
        Map<String, Object> model = new HashMap<>();
        SimpleDateFormat df = new SimpleDateFormat("yyyy");
        try {
            Date reportDate = new Date();
            Integer facilityId = (Integer) request.getSession().getAttribute("sessionActiveLoginFacility");

            int totalPatientVisit = 0;
            int totalPatientVisitBelow29Days = 0;
            int totalPatientVisit29DaysTo4Yrs = 0;
            int totalPatientVisit5YrsTo59Yrs = 0;
            int totalPatientVisit60AndAbove = 0;

            int totalPatientsMale = 0;
            int totalPatientsFemale = 0;

            int totalFemaleNew = 0;
            int totalFemaleOld = 0;

            int totalMaleNew = 0;
            int totalMaleOld = 0;

            int totalPatientsNew = 0;
            int totalPatientsOld = 0;

            int zeroTo28DaysNew = 0;
            int zeroTo28DaysOld = 0;

            int zeroTo28DaysNewFemale = 0;
            int zeroTo28DaysNewMale = 0;
            int zeroTo28DaysOldMale = 0;
            int zeroTo28DaysOldFemale = 0;

            int days29To4YrsNew = 0;
            int days29To4YrsOld = 0;

            int days29To4YrsNewFemale = 0;
            int days29To4YrsNewMale = 0;
            int days29To4YrsOldMale = 0;
            int days29To4YrsOldFemale = 0;

            int yrs5TO59New = 0;
            int yrs5TO59Old = 0;
            int yrs5TO59NewFemale = 0;
            int yrs5TO59NewMale = 0;
            int yrs5TO59OldMale = 0;
            int yrs5TO59OldFemale = 0;

            int yrs60AndAboveNew = 0;
            int yrs60AndAboveOld = 0;
            int yrs60AndAboveNewFemale = 0;
            int yrs60AndAboveNewMale = 0;
            int yrs60AndAboveOldMale = 0;
            int yrs60AndAboveOldFemale = 0;

            String[] params = {"facilityid", "dateadded"};
            Object[] paramsValues = {facilityId, reportDate};
//            String where = "WHERE facilityid=:facilityid AND dateadded=:dateadded";
//            Object[] paramsValues = {facilityId, fmt.format(reportDate)};
//            String where = "WHERE facilityid=:facilityid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded";
            String where = "WHERE facilityid=:facilityid AND DATE(dateadded)=:dateadded";
            totalPatientVisit = genericClassService.fetchRecordCount(Patientstartisticsview.class, where, params, paramsValues);

            params = new String[]{"facilityid", "dateadded", "visittype"};
            paramsValues = new Object[]{facilityId, reportDate, "NEWVISIT"};
//            where = "WHERE facilityid=:facilityid AND dateadded=:dateadded AND visittype=:visittype";
//            paramsValues = new Object[]{facilityId, fmt.format(reportDate), "NEWVISIT"};
//            where = "WHERE facilityid=:facilityid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded AND visittype=:visittype";
            where = "WHERE facilityid=:facilityid AND DATE(dateadded)=:dateadded AND visittype=:visittype";
            totalPatientsNew = genericClassService.fetchRecordCount(Patientstartisticsview.class, where, params, paramsValues);

            params = new String[]{"facilityid", "dateadded", "visittype"};
            paramsValues = new Object[]{facilityId, reportDate, "REVISIT"};
//            where = "WHERE facilityid=:facilityid AND dateadded=:dateadded AND visittype=:visittype";
//            paramsValues = new Object[]{facilityId, fmt.format(reportDate), "REVISIT"};
//            where = "WHERE facilityid=:facilityid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded AND visittype=:visittype";
            where = "WHERE facilityid=:facilityid AND DATE(dateadded)=:dateadded AND visittype=:visittype";
            totalPatientsOld = genericClassService.fetchRecordCount(Patientstartisticsview.class, where, params, paramsValues);

            params = new String[]{"facilityid", "dateadded"};
            paramsValues = new Object[]{facilityId, reportDate};
//            paramsValues = new Object[]{facilityId, fmt.format(reportDate)};
            String[] fields = {"patientvisitid", "gender", "visittype"};
//            List<Object[]> objpatientgender = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields, "WHERE facilityid=:facilityid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded", params, paramsValues);
            List<Object[]> objpatientgender = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields, "WHERE facilityid=:facilityid AND DATE(dateadded)=:dateadded", params, paramsValues);
            if (objpatientgender != null) {
                for (Object[] patienttotgender : objpatientgender) {
                    if ("Female".toLowerCase().equals(((String) patienttotgender[1]).toLowerCase())) {
                        if ("NEWVISIT".toUpperCase().equals(((String) patienttotgender[2]).toUpperCase())) {
                            totalFemaleNew += 1;
                        } else {
                            totalFemaleOld += 1;
                        }
                        totalPatientsFemale += 1;
                    }
                    if ("Male".toUpperCase().equals(((String) patienttotgender[1]).toUpperCase())) {
                        if ("NEWVISIT".toLowerCase().equals(((String) patienttotgender[2]).toLowerCase())) {
                            totalMaleNew += 1;
                        } else {
                            totalMaleOld += 1;
                        }
                        totalPatientsMale += 1;
                    }
                }
            }

            params = new String[]{"facilityid", "dateadded"};
            paramsValues = new Object[]{facilityId, reportDate};
//            paramsValues = new Object[]{facilityId, fmt.format(reportDate)};
            fields = new String[]{"patientvisitid", "dob", "visittype", "gender"};
//            List<Object[]> objpatienttotage = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields, "WHERE facilityid=:facilityid AND to_char(dateadded, 'dd-MM-yyyy')=:dateadded", params, paramsValues);
            List<Object[]> objpatienttotage = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields, "WHERE facilityid=:facilityid AND DATE(dateadded)=:dateadded", params, paramsValues);
            if (objpatienttotage != null) {
                for (Object[] patienttotage : objpatienttotage) {

                    int year = Integer.parseInt(df.format((Date) patienttotage[1]));
                    int currentyear = Integer.parseInt(df.format(new Date()));
                    Long estimatedAgeInDays = getDays(new Date(), ((Date) patienttotage[1]));
                    int estimatedAgeInYears = currentyear - year;
                    if ((estimatedAgeInDays <= 28 && estimatedAgeInYears == 0)) {
                        if ("NEWVISIT".toUpperCase().equals(((String) patienttotage[2]).toUpperCase())) {
                            if ("Male".toLowerCase().equals(((String) patienttotage[3]).toLowerCase())) {
                                zeroTo28DaysNewMale += 1;
                            } else {
                                zeroTo28DaysNewFemale += 1;
                            }
                            zeroTo28DaysNew += 1;
                        } else {
                            if ("Male".toUpperCase().equals(((String) patienttotage[3]).toUpperCase())) {
                                zeroTo28DaysOldMale += 1;
                            } else {
                                zeroTo28DaysOldFemale += 1;
                            }
                            zeroTo28DaysOld += 1;
                        }
                        totalPatientVisitBelow29Days += 1;
                    } else if (estimatedAgeInDays >= 29 && estimatedAgeInYears <= 4) {
                        if ("NEWVISIT".toLowerCase().equals(((String) patienttotage[2]).toLowerCase())) {
                            if ("Male".toUpperCase().equals(((String) patienttotage[3]).toUpperCase())) {
                                days29To4YrsNewMale += 1;
                            } else {
                                days29To4YrsNewFemale += 1;
                            }
                            days29To4YrsNew += 1;
                        } else {
                            if ("Male".toLowerCase().equals(((String) patienttotage[3]).toLowerCase())) {
                                days29To4YrsOldMale += 1;
                            } else {
                                days29To4YrsOldFemale += 1;
                            }
                            days29To4YrsOld += 1;
                        }
                        totalPatientVisit29DaysTo4Yrs += 1;
                    } else if (estimatedAgeInYears >= 5 && estimatedAgeInYears <= 59) {
                        if ("NEWVISIT".toUpperCase().equals(((String) patienttotage[2]).toUpperCase())) {
                            if ("Male".toLowerCase().equals(((String) patienttotage[3]).toLowerCase())) {
                                yrs5TO59NewMale += 1;
                            } else {
                                yrs5TO59NewFemale += 1;
                            }
                            yrs5TO59New += 1;
                        } else {
                            if ("Male".toUpperCase().equals(((String) patienttotage[3]).toUpperCase())) {
                                yrs5TO59OldMale += 1;
                            } else {
                                yrs5TO59OldFemale += 1;
                            }
                            yrs5TO59Old += 1;
                        }
                        totalPatientVisit5YrsTo59Yrs += 1;
                    } else if (estimatedAgeInYears >= 60) {
                        if ("NEWVISIT".equals((String) patienttotage[2])) {
                            if ("Male".equals((String) patienttotage[3])) {
                                yrs60AndAboveNewMale += 1;
                            } else {
                                yrs60AndAboveNewFemale += 1;
                            }
                            yrs60AndAboveNew += 1;
                        } else {
                            if ("Male".equals((String) patienttotage[3])) {
                                yrs60AndAboveOldMale += 1;
                            } else {
                                yrs60AndAboveOldFemale += 1;
                            }
                            yrs60AndAboveOld += 1;
                        }
                        totalPatientVisit60AndAbove += 1;
                    }
                }
            }

            model.put("totalpatientsFemale", totalPatientsFemale);
            model.put("totalpatientsMale", totalPatientsMale);
            model.put("totalpatientvisit", totalPatientVisit);
            model.put("totalPatientVisitBelow29Days", totalPatientVisitBelow29Days);
            model.put("totalPatientVisit29DaysTo4Yrs", totalPatientVisit29DaysTo4Yrs);
            model.put("totalPatientVisit5YrsTo59Yrs", totalPatientVisit5YrsTo59Yrs);
            model.put("totalPatientVisit60AndAbove", totalPatientVisit60AndAbove);

            model.put("totalFemaleNew", totalFemaleNew);
            model.put("totalFemaleOld", totalFemaleOld);
            model.put("totalMaleNew", totalMaleNew);
            model.put("totalMaleOld", totalMaleOld);

            model.put("totalPatientsNew", totalPatientsNew);
            model.put("totalPatientsOld", totalPatientsOld);

            model.put("zeroTo28DaysNew", zeroTo28DaysNew);
            model.put("zeroTo28DaysOld", zeroTo28DaysOld);

            model.put("zeroTo28DaysNewFemale", zeroTo28DaysNewFemale);
            model.put("zeroTo28DaysNewMale", zeroTo28DaysNewMale);
            model.put("zeroTo28DaysOldFemale", zeroTo28DaysOldFemale);
            model.put("zeroTo28DaysOldMale", zeroTo28DaysOldMale);

            model.put("days29To4YrsNew", days29To4YrsNew);
            model.put("days29To4YrsOld", days29To4YrsOld);

            model.put("days29To4YrsNewFemale", days29To4YrsNewFemale);
            model.put("days29To4YrsNewMale", days29To4YrsNewMale);
            model.put("days29To4YrsOldFemale", days29To4YrsOldFemale);
            model.put("days29To4YrsOldMale", days29To4YrsOldMale);

            model.put("yrs5TO59New", yrs5TO59New);
            model.put("yrs5TO59Old", yrs5TO59Old);

            model.put("yrs5TO59NewFemale", yrs5TO59NewFemale);
            model.put("yrs5TO59NewMale", yrs5TO59NewMale);
            model.put("yrs5TO59OldFemale", yrs5TO59OldFemale);
            model.put("yrs5TO59OldMale", yrs5TO59OldMale);

            model.put("yrs60AndAboveNew", yrs60AndAboveNew);
            model.put("yrs60AndAboveOld", yrs60AndAboveOld);

            model.put("yrs60AndAboveNewFemale", yrs60AndAboveNewFemale);
            model.put("yrs60AndAboveNewMale", yrs60AndAboveNewMale);
            model.put("yrs60AndAboveOldFemale", yrs60AndAboveOldFemale);
            model.put("yrs60AndAboveOldMale", yrs60AndAboveOldMale);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return new ModelAndView("dashboardAndReports/patientStatistics/views/statistics", model);
    }

    @RequestMapping(value = "/viewpatientsstatisticsrangebyfacility", method = RequestMethod.GET)
    public String viewPatientsStatisticsRangeByFacility(HttpServletRequest request, Model model,
            @ModelAttribute("startDate") String sDate, @ModelAttribute("endDate") String eDate) throws ParseException {
        if (request.getSession().getAttribute("sessionActiveLoginFacility") != null) {
            try {
                SimpleDateFormat df = new SimpleDateFormat("yyyy");
                Date startDate = fmt.parse(sDate);
                Date endDate = fmt.parse(eDate);
                Integer facilityId = (Integer) request.getSession().getAttribute("sessionActiveLoginFacility");

                int totalPatientVisit = 0;
                int totalPatientVisitBelow29Days = 0;
                int totalPatientVisit29DaysTo4Yrs = 0;
                int totalPatientVisit5YrsTo59Yrs = 0;
                int totalPatientVisit60AndAbove = 0;

                int totalPatientsMale = 0;
                int totalPatientsFemale = 0;

                int totalFemaleNew = 0;
                int totalFemaleOld = 0;

                int totalMaleNew = 0;
                int totalMaleOld = 0;

                int totalPatientsNew = 0;
                int totalPatientsOld = 0;

                int zeroTo28DaysNew = 0;
                int zeroTo28DaysOld = 0;

                int zeroTo28DaysNewFemale = 0;
                int zeroTo28DaysNewMale = 0;
                int zeroTo28DaysOldMale = 0;
                int zeroTo28DaysOldFemale = 0;

                int days29To4YrsNew = 0;
                int days29To4YrsOld = 0;

                int days29To4YrsNewFemale = 0;
                int days29To4YrsNewMale = 0;
                int days29To4YrsOldMale = 0;
                int days29To4YrsOldFemale = 0;

                int yrs5TO59New = 0;
                int yrs5TO59Old = 0;
                int yrs5TO59NewFemale = 0;
                int yrs5TO59NewMale = 0;
                int yrs5TO59OldMale = 0;
                int yrs5TO59OldFemale = 0;

                int yrs60AndAboveNew = 0;
                int yrs60AndAboveOld = 0;
                int yrs60AndAboveNewFemale = 0;
                int yrs60AndAboveNewMale = 0;
                int yrs60AndAboveOldMale = 0;
                int yrs60AndAboveOldFemale = 0;

                String[] params = {"facilityid", "dateaddedstart", "dateaddedend"};
//                Object[] paramsValues = {facilityId, startDate, endDate};
//                String where = "WHERE facilityid=:facilityid AND dateadded BETWEEN SYMMETRIC :dateaddedstart AND :dateaddedend";
//                Object[] paramsValues = {facilityId, startDate, endDate};
//                String where = "WHERE facilityid=:facilityid AND dateadded BETWEEN SYMMETRIC :dateaddedstart AND :dateaddedend";
                Object[] paramsValues = {facilityId, formatter.parse(formatter.format(startDate)), formatter.parse(formatter.format(endDate))};
                String where = "WHERE facilityid=:facilityid AND DATE(dateadded) BETWEEN SYMMETRIC :dateaddedstart AND :dateaddedend";
                totalPatientVisit = genericClassService.fetchRecordCount(Patientstartisticsview.class, where, params, paramsValues);

                params = new String[]{"facilityid", "dateaddedstart", "dateaddedend", "visittype"};
//                paramsValues = new Object[] {facilityId, startDate, endDate, "NEWVISIT"};
//                where = "WHERE facilityid=:facilityid AND dateadded BETWEEN SYMMETRIC :dateaddedstart AND :dateaddedend AND visittype=:visittype";
                paramsValues = new Object[]{facilityId, formatter.parse(formatter.format(startDate)), formatter.parse(formatter.format(endDate)), "NEWVISIT"};
                where = "WHERE facilityid=:facilityid AND DATE(dateadded) BETWEEN SYMMETRIC :dateaddedstart AND :dateaddedend AND visittype=:visittype";
                totalPatientsNew = genericClassService.fetchRecordCount(Patientstartisticsview.class, where, params, paramsValues);

                params = new String[]{"facilityid", "dateaddedstart", "dateaddedend", "visittype"};
//                paramsValues = new Object[] {facilityId, startDate, endDate, "REVISIT"};
//                where = "WHERE facilityid=:facilityid AND dateadded BETWEEN SYMMETRIC :dateaddedstart AND :dateaddedend AND visittype=:visittype";
                paramsValues = new Object[]{facilityId, formatter.parse(formatter.format(startDate)), formatter.parse(formatter.format(endDate)), "REVISIT"};
                where = "WHERE facilityid=:facilityid AND DATE(dateadded) BETWEEN SYMMETRIC :dateaddedstart AND :dateaddedend AND visittype=:visittype";
                totalPatientsOld = genericClassService.fetchRecordCount(Patientstartisticsview.class, where, params, paramsValues);

                params = new String[]{"facilityid", "dateaddedstart", "dateaddedend"};
//                paramsValues = new Object[] {facilityId, startDate, endDate};
                paramsValues = new Object[]{facilityId, formatter.parse(formatter.format(startDate)), formatter.parse(formatter.format(endDate))};
                String[] fields = {"patientvisitid", "gender", "visittype"};
                List<Object[]> objpatientgender = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields, "WHERE facilityid=:facilityid AND DATE(dateadded) BETWEEN SYMMETRIC :dateaddedstart AND :dateaddedend", params, paramsValues);
                if (objpatientgender != null) {
                    for (Object[] patienttotgender : objpatientgender) {
                        if ("Female".toLowerCase().equals(((String) patienttotgender[1]).toLowerCase())) {
                            if ("NEWVISIT".toUpperCase().equals(((String) patienttotgender[2]).toUpperCase())) {
                                totalFemaleNew += 1;
                            } else {
                                totalFemaleOld += 1;
                            }
                            totalPatientsFemale += 1;
                        }
                        if ("Male".toUpperCase().equals(((String) patienttotgender[1]).toUpperCase())) {
                            if ("NEWVISIT".toLowerCase().equals(((String) patienttotgender[2]).toLowerCase())) {
                                totalMaleNew += 1;
                            } else {
                                totalMaleOld += 1;
                            }
                            totalPatientsMale += 1;
                        }
                    }
                }

                params = new String[]{"facilityid", "dateaddedstart", "dateaddedend"};
//                paramsValues = new Object [] {facilityId, startDate, endDate};
                paramsValues = new Object[]{facilityId, formatter.parse(formatter.format(startDate)), formatter.parse(formatter.format(endDate))};
                fields = new String[]{"patientvisitid", "dob", "visittype", "gender"};
                List<Object[]> objpatienttotage = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields, "WHERE facilityid=:facilityid AND DATE(dateadded) BETWEEN SYMMETRIC :dateaddedstart AND :dateaddedend", params, paramsValues);
                if (objpatienttotage != null) {
                    for (Object[] patienttotage : objpatienttotage) {

                        int year = Integer.parseInt(df.format((Date) patienttotage[1]));
                        int currentyear = Integer.parseInt(df.format(new Date()));
                        Long estimatedAgeInDays = getDays(new Date(), ((Date) patienttotage[1]));
                        int estimatedAgeInYears = currentyear - year;
                        if ((estimatedAgeInDays <= 28 && estimatedAgeInYears == 0)) {
                            if ("NEWVISIT".toUpperCase().equals(((String) patienttotage[2]).toUpperCase())) {
                                if ("Male".toLowerCase().equals(((String) patienttotage[3]).toLowerCase())) {
                                    zeroTo28DaysNewMale += 1;
                                } else {
                                    zeroTo28DaysNewFemale += 1;
                                }
                                zeroTo28DaysNew += 1;
                            } else {
                                if ("Male".toUpperCase().equals(((String) patienttotage[3]).toUpperCase())) {
                                    zeroTo28DaysOldMale += 1;
                                } else {
                                    zeroTo28DaysOldFemale += 1;
                                }
                                zeroTo28DaysOld += 1;
                            }
                            totalPatientVisitBelow29Days += 1;
                        } else if (estimatedAgeInDays >= 29 && estimatedAgeInYears <= 4) {
                            if ("NEWVISIT".toLowerCase().equals(((String) patienttotage[2]).toLowerCase())) {
                                if ("Male".toUpperCase().equals(((String) patienttotage[3]).toUpperCase())) {
                                    days29To4YrsNewMale += 1;
                                } else {
                                    days29To4YrsNewFemale += 1;
                                }
                                days29To4YrsNew += 1;
                            } else {
                                if ("Male".toLowerCase().equals(((String) patienttotage[3]).toLowerCase())) {
                                    days29To4YrsOldMale += 1;
                                } else {
                                    days29To4YrsOldFemale += 1;
                                }
                                days29To4YrsOld += 1;
                            }
                            totalPatientVisit29DaysTo4Yrs += 1;
                        } else if (estimatedAgeInYears >= 5 && estimatedAgeInYears <= 59) {
                            if ("NEWVISIT".toUpperCase().equals(((String) patienttotage[2]).toUpperCase())) {
                                if ("Male".toLowerCase().equals(((String) patienttotage[3]).toLowerCase())) {
                                    yrs5TO59NewMale += 1;
                                } else {
                                    yrs5TO59NewFemale += 1;
                                }
                                yrs5TO59New += 1;
                            } else {
                                if ("Male".toUpperCase().equals(((String) patienttotage[3]).toUpperCase())) {
                                    yrs5TO59OldMale += 1;
                                } else {
                                    yrs5TO59OldFemale += 1;
                                }
                                yrs5TO59Old += 1;
                            }
                            totalPatientVisit5YrsTo59Yrs += 1;
                        } else if (estimatedAgeInYears >= 60) {
                            if ("NEWVISIT".equals((String) patienttotage[2])) {
                                if ("Male".equals((String) patienttotage[3])) {
                                    yrs60AndAboveNewMale += 1;
                                } else {
                                    yrs60AndAboveNewFemale += 1;
                                }
                                yrs60AndAboveNew += 1;
                            } else {
                                if ("Male".equals((String) patienttotage[3])) {
                                    yrs60AndAboveOldMale += 1;
                                } else {
                                    yrs60AndAboveOldFemale += 1;
                                }
                                yrs60AndAboveOld += 1;
                            }
                            totalPatientVisit60AndAbove += 1;
                        }
                    }
                }

                model.addAttribute("totalpatientsFemale", totalPatientsFemale);
                model.addAttribute("totalpatientsMale", totalPatientsMale);
                model.addAttribute("totalpatientvisit", totalPatientVisit);
                model.addAttribute("totalPatientVisitBelow29Days", totalPatientVisitBelow29Days);
                model.addAttribute("totalPatientVisit29DaysTo4Yrs", totalPatientVisit29DaysTo4Yrs);
                model.addAttribute("totalPatientVisit5YrsTo59Yrs", totalPatientVisit5YrsTo59Yrs);
                model.addAttribute("totalPatientVisit60AndAbove", totalPatientVisit60AndAbove);

                model.addAttribute("totalFemaleNew", totalFemaleNew);
                model.addAttribute("totalFemaleOld", totalFemaleOld);
                model.addAttribute("totalMaleNew", totalMaleNew);
                model.addAttribute("totalMaleOld", totalMaleOld);

                model.addAttribute("totalPatientsNew", totalPatientsNew);
                model.addAttribute("totalPatientsOld", totalPatientsOld);

                model.addAttribute("zeroTo28DaysNew", zeroTo28DaysNew);
                model.addAttribute("zeroTo28DaysOld", zeroTo28DaysOld);

                model.addAttribute("zeroTo28DaysNewFemale", zeroTo28DaysNewFemale);
                model.addAttribute("zeroTo28DaysNewMale", zeroTo28DaysNewMale);
                model.addAttribute("zeroTo28DaysOldFemale", zeroTo28DaysOldFemale);
                model.addAttribute("zeroTo28DaysOldMale", zeroTo28DaysOldMale);

                model.addAttribute("days29To4YrsNew", days29To4YrsNew);
                model.addAttribute("days29To4YrsOld", days29To4YrsOld);

                model.addAttribute("days29To4YrsNewFemale", days29To4YrsNewFemale);
                model.addAttribute("days29To4YrsNewMale", days29To4YrsNewMale);
                model.addAttribute("days29To4YrsOldFemale", days29To4YrsOldFemale);
                model.addAttribute("days29To4YrsOldMale", days29To4YrsOldMale);

                model.addAttribute("yrs5TO59New", yrs5TO59New);
                model.addAttribute("yrs5TO59Old", yrs5TO59Old);

                model.addAttribute("yrs5TO59NewFemale", yrs5TO59NewFemale);
                model.addAttribute("yrs5TO59NewMale", yrs5TO59NewMale);
                model.addAttribute("yrs5TO59OldFemale", yrs5TO59OldFemale);
                model.addAttribute("yrs5TO59OldMale", yrs5TO59OldMale);

                model.addAttribute("yrs60AndAboveNew", yrs60AndAboveNew);
                model.addAttribute("yrs60AndAboveOld", yrs60AndAboveOld);

                model.addAttribute("yrs60AndAboveNewFemale", yrs60AndAboveNewFemale);
                model.addAttribute("yrs60AndAboveNewMale", yrs60AndAboveNewMale);
                model.addAttribute("yrs60AndAboveOldFemale", yrs60AndAboveOldFemale);
                model.addAttribute("yrs60AndAboveOldMale", yrs60AndAboveOldMale);
                return "patientsManagement/patientFacilityRegister/startics";
            } catch (Exception e) {
                e.printStackTrace();
                return "patientsManagement/unitRegister/dateError";
            }
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/viewpatientsstatisticsrangebyunit", method = RequestMethod.GET)
    public String viewPatientsStatisticsRangeByUnit(HttpServletRequest request, Model model,
            @ModelAttribute("startDate") String sDate, @ModelAttribute("endDate") String eDate,
            @ModelAttribute("unitid") String unitId) throws ParseException {
        if (request.getSession().getAttribute("sessionActiveLoginFacility") != null) {

            try {
                SimpleDateFormat df = new SimpleDateFormat("yyyy");
                Date startDate = fmt.parse(sDate);
                Date endDate = fmt.parse(eDate);
                Integer facilityId = (Integer) request.getSession().getAttribute("sessionActiveLoginFacility");
                Long facilityunitid = Long.parseLong(unitId);

                int totalPatientVisit = 0;
                int totalPatientVisitBelow29Days = 0;
                int totalPatientVisit29DaysTo4Yrs = 0;
                int totalPatientVisit5YrsTo59Yrs = 0;
                int totalPatientVisit60AndAbove = 0;

                int totalPatientsMale = 0;
                int totalPatientsFemale = 0;

                int totalFemaleNew = 0;
                int totalFemaleOld = 0;

                int totalMaleNew = 0;
                int totalMaleOld = 0;

                int totalPatientsNew = 0;
                int totalPatientsOld = 0;

                int zeroTo28DaysNew = 0;
                int zeroTo28DaysOld = 0;

                int zeroTo28DaysNewFemale = 0;
                int zeroTo28DaysNewMale = 0;
                int zeroTo28DaysOldMale = 0;
                int zeroTo28DaysOldFemale = 0;

                int days29To4YrsNew = 0;
                int days29To4YrsOld = 0;

                int days29To4YrsNewFemale = 0;
                int days29To4YrsNewMale = 0;
                int days29To4YrsOldMale = 0;
                int days29To4YrsOldFemale = 0;

                int yrs5TO59New = 0;
                int yrs5TO59Old = 0;
                int yrs5TO59NewFemale = 0;
                int yrs5TO59NewMale = 0;
                int yrs5TO59OldMale = 0;
                int yrs5TO59OldFemale = 0;

                int yrs60AndAboveNew = 0;
                int yrs60AndAboveOld = 0;
                int yrs60AndAboveNewFemale = 0;
                int yrs60AndAboveNewMale = 0;
                int yrs60AndAboveOldMale = 0;
                int yrs60AndAboveOldFemale = 0;

                String[] params = {"facilityid", "facilityunitid", "dateaddedstart", "dateaddedend"};
//                Object[] paramsValues = {facilityId, facilityunitid, startDate, endDate};
                Object[] paramsValues = {facilityId, facilityunitid, formatter.parse(formatter.format(startDate)), formatter.parse(formatter.format(endDate))};
                String where = "WHERE facilityid=:facilityid AND facilityunitid=:facilityunitid AND DATE(dateadded) BETWEEN SYMMETRIC :dateaddedstart AND :dateaddedend";
                totalPatientVisit = genericClassService.fetchRecordCount(Patientstartisticsview.class, where, params, paramsValues);

                params = new String[]{"facilityid", "facilityunitid", "dateaddedstart", "dateaddedend", "visittype"};
//                paramsValues = new Object[] {facilityId, facilityunitid, startDate, endDate, "NEWVISIT"};
                paramsValues = new Object[]{facilityId, facilityunitid, formatter.parse(formatter.format(startDate)), formatter.parse(formatter.format(endDate)), "NEWVISIT"};
                where = "WHERE facilityid=:facilityid AND facilityunitid=:facilityunitid AND DATE(dateadded) BETWEEN SYMMETRIC :dateaddedstart AND :dateaddedend AND visittype=:visittype";
                totalPatientsNew = genericClassService.fetchRecordCount(Patientstartisticsview.class, where, params, paramsValues);

                params = new String[]{"facilityid", "facilityunitid", "dateaddedstart", "dateaddedend", "visittype"};
//                paramsValues = new Object[] {facilityId, facilityunitid, startDate, endDate, "REVISIT"};
                paramsValues = new Object[]{facilityId, facilityunitid, formatter.parse(formatter.format(startDate)), formatter.parse(formatter.format(endDate)), "REVISIT"};
                where = "WHERE facilityid=:facilityid AND facilityunitid=:facilityunitid AND DATE(dateadded) BETWEEN SYMMETRIC :dateaddedstart AND :dateaddedend AND visittype=:visittype";
                totalPatientsOld = genericClassService.fetchRecordCount(Patientstartisticsview.class, where, params, paramsValues);

                params = new String[]{"facilityid", "facilityunitid", "dateaddedstart", "dateaddedend"};
//                paramsValues = new Object[] {facilityId, facilityunitid, startDate, endDate};
                paramsValues = new Object[]{facilityId, facilityunitid, formatter.parse(formatter.format(startDate)), formatter.parse(formatter.format(endDate))};
                String[] fields = {"patientvisitid", "gender", "visittype"};
                List<Object[]> objpatientgender = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields, "WHERE facilityid=:facilityid AND facilityunitid=:facilityunitid AND DATE(dateadded) BETWEEN SYMMETRIC :dateaddedstart AND :dateaddedend", params, paramsValues);
                if (objpatientgender != null) {
                    for (Object[] patienttotgender : objpatientgender) {
                        if ("Female".toLowerCase().equals(((String) patienttotgender[1]).toLowerCase())) {
                            if ("NEWVISIT".toUpperCase().equals(((String) patienttotgender[2]).toUpperCase())) {
                                totalFemaleNew += 1;
                            } else {
                                totalFemaleOld += 1;
                            }
                            totalPatientsFemale += 1;
                        }
                        if ("Male".toUpperCase().equals(((String) patienttotgender[1]).toUpperCase())) {
                            if ("NEWVISIT".toLowerCase().equals(((String) patienttotgender[2]).toLowerCase())) {
                                totalMaleNew += 1;
                            } else {
                                totalMaleOld += 1;
                            }
                            totalPatientsMale += 1;
                        }
                    }
                }

                params = new String[]{"facilityid", "facilityunitid", "dateaddedstart", "dateaddedend"};
//                paramsValues = new Object[] {facilityId, facilityunitid, startDate, endDate};
                paramsValues = new Object[]{facilityId, facilityunitid, formatter.parse(formatter.format(startDate)), formatter.parse(formatter.format(endDate))};
                fields = new String[]{"patientvisitid", "dob", "visittype", "gender"};
                List<Object[]> objpatienttotage = (List<Object[]>) genericClassService.fetchRecord(Patientstartisticsview.class, fields, "WHERE facilityid=:facilityid AND facilityunitid=:facilityunitid AND DATE(dateadded) BETWEEN SYMMETRIC :dateaddedstart AND :dateaddedend", params, paramsValues);
                if (objpatienttotage != null) {
                    for (Object[] patienttotage : objpatienttotage) {

                        int year = Integer.parseInt(df.format((Date) patienttotage[1]));
                        int currentyear = Integer.parseInt(df.format(new Date()));
                        Long estimatedAgeInDays = getDays(new Date(), ((Date) patienttotage[1]));
                        int estimatedAgeInYears = currentyear - year;
                        if ((estimatedAgeInDays <= 28 && estimatedAgeInYears == 0)) {
                            if ("NEWVISIT".toUpperCase().equals(((String) patienttotage[2]).toUpperCase())) {
                                if ("Male".toLowerCase().equals(((String) patienttotage[3]).toLowerCase())) {
                                    zeroTo28DaysNewMale += 1;
                                } else {
                                    zeroTo28DaysNewFemale += 1;
                                }
                                zeroTo28DaysNew += 1;
                            } else {
                                if ("Male".toUpperCase().equals(((String) patienttotage[3]).toUpperCase())) {
                                    zeroTo28DaysOldMale += 1;
                                } else {
                                    zeroTo28DaysOldFemale += 1;
                                }
                                zeroTo28DaysOld += 1;
                            }
                            totalPatientVisitBelow29Days += 1;
                        } else if (estimatedAgeInDays >= 29 && estimatedAgeInYears <= 4) {
                            if ("NEWVISIT".toLowerCase().equals(((String) patienttotage[2]).toLowerCase())) {
                                if ("Male".toUpperCase().equals(((String) patienttotage[3]).toUpperCase())) {
                                    days29To4YrsNewMale += 1;
                                } else {
                                    days29To4YrsNewFemale += 1;
                                }
                                days29To4YrsNew += 1;
                            } else {
                                if ("Male".toLowerCase().equals(((String) patienttotage[3]).toLowerCase())) {
                                    days29To4YrsOldMale += 1;
                                } else {
                                    days29To4YrsOldFemale += 1;
                                }
                                days29To4YrsOld += 1;
                            }
                            totalPatientVisit29DaysTo4Yrs += 1;
                        } else if (estimatedAgeInYears >= 5 && estimatedAgeInYears <= 59) {
                            if ("NEWVISIT".toUpperCase().equals(((String) patienttotage[2]).toUpperCase())) {
                                if ("Male".toLowerCase().equals(((String) patienttotage[3]).toLowerCase())) {
                                    yrs5TO59NewMale += 1;
                                } else {
                                    yrs5TO59NewFemale += 1;
                                }
                                yrs5TO59New += 1;
                            } else {
                                if ("Male".toUpperCase().equals(((String) patienttotage[3]).toUpperCase())) {
                                    yrs5TO59OldMale += 1;
                                } else {
                                    yrs5TO59OldFemale += 1;
                                }
                                yrs5TO59Old += 1;
                            }
                            totalPatientVisit5YrsTo59Yrs += 1;
                        } else if (estimatedAgeInYears >= 60) {
                            if ("NEWVISIT".equals((String) patienttotage[2])) {
                                if ("Male".equals((String) patienttotage[3])) {
                                    yrs60AndAboveNewMale += 1;
                                } else {
                                    yrs60AndAboveNewFemale += 1;
                                }
                                yrs60AndAboveNew += 1;
                            } else {
                                if ("Male".equals((String) patienttotage[3])) {
                                    yrs60AndAboveOldMale += 1;
                                } else {
                                    yrs60AndAboveOldFemale += 1;
                                }
                                yrs60AndAboveOld += 1;
                            }
                            totalPatientVisit60AndAbove += 1;
                        }
                    }
                }

                model.addAttribute("totalpatientsFemale", totalPatientsFemale);
                model.addAttribute("totalpatientsMale", totalPatientsMale);
                model.addAttribute("totalpatientvisit", totalPatientVisit);
                model.addAttribute("totalPatientVisitBelow29Days", totalPatientVisitBelow29Days);
                model.addAttribute("totalPatientVisit29DaysTo4Yrs", totalPatientVisit29DaysTo4Yrs);
                model.addAttribute("totalPatientVisit5YrsTo59Yrs", totalPatientVisit5YrsTo59Yrs);
                model.addAttribute("totalPatientVisit60AndAbove", totalPatientVisit60AndAbove);

                model.addAttribute("totalFemaleNew", totalFemaleNew);
                model.addAttribute("totalFemaleOld", totalFemaleOld);
                model.addAttribute("totalMaleNew", totalMaleNew);
                model.addAttribute("totalMaleOld", totalMaleOld);

                model.addAttribute("totalPatientsNew", totalPatientsNew);
                model.addAttribute("totalPatientsOld", totalPatientsOld);

                model.addAttribute("zeroTo28DaysNew", zeroTo28DaysNew);
                model.addAttribute("zeroTo28DaysOld", zeroTo28DaysOld);

                model.addAttribute("zeroTo28DaysNewFemale", zeroTo28DaysNewFemale);
                model.addAttribute("zeroTo28DaysNewMale", zeroTo28DaysNewMale);
                model.addAttribute("zeroTo28DaysOldFemale", zeroTo28DaysOldFemale);
                model.addAttribute("zeroTo28DaysOldMale", zeroTo28DaysOldMale);

                model.addAttribute("days29To4YrsNew", days29To4YrsNew);
                model.addAttribute("days29To4YrsOld", days29To4YrsOld);

                model.addAttribute("days29To4YrsNewFemale", days29To4YrsNewFemale);
                model.addAttribute("days29To4YrsNewMale", days29To4YrsNewMale);
                model.addAttribute("days29To4YrsOldFemale", days29To4YrsOldFemale);
                model.addAttribute("days29To4YrsOldMale", days29To4YrsOldMale);

                model.addAttribute("yrs5TO59New", yrs5TO59New);
                model.addAttribute("yrs5TO59Old", yrs5TO59Old);

                model.addAttribute("yrs5TO59NewFemale", yrs5TO59NewFemale);
                model.addAttribute("yrs5TO59NewMale", yrs5TO59NewMale);
                model.addAttribute("yrs5TO59OldFemale", yrs5TO59OldFemale);
                model.addAttribute("yrs5TO59OldMale", yrs5TO59OldMale);

                model.addAttribute("yrs60AndAboveNew", yrs60AndAboveNew);
                model.addAttribute("yrs60AndAboveOld", yrs60AndAboveOld);

                model.addAttribute("yrs60AndAboveNewFemale", yrs60AndAboveNewFemale);
                model.addAttribute("yrs60AndAboveNewMale", yrs60AndAboveNewMale);
                model.addAttribute("yrs60AndAboveOldFemale", yrs60AndAboveOldFemale);
                model.addAttribute("yrs60AndAboveOldMale", yrs60AndAboveOldMale);
                return "patientsManagement/patientFacilityRegister/startics";
            } catch (Exception e) {
                return "patientsManagement/unitRegister/dateError";
            }
        } else {
            return "refresh";
        }
    }

    @RequestMapping(value = "/patientattendance", method = RequestMethod.GET)
    public ModelAndView patientAttendance(HttpServletRequest request) {
        if (request.getSession().getAttribute("sessionActiveLoginFacility") == null) {
            return new ModelAndView("refresh");
        }
        return new ModelAndView("dashboardAndReports/staffActivities/patientAttendance/patientAttendance");
    }

    @RequestMapping(value = "/patientattendancerange", method = RequestMethod.POST)
    public ModelAndView patientAttendanceRange(HttpServletRequest request,
            @ModelAttribute("startdate") String startDate,
            @ModelAttribute("enddate") String endDate) {
        Map<String, Object> model = new HashMap<>();
        try {
            if (request.getSession().getAttribute("sessionActiveLoginFacility") == null) {
                return new ModelAndView("refresh");
            }
            model.put("serverdate", formatterwithtime3.format(serverDate));
        } catch (Exception e) {
            System.out.println(e);
        }
        return new ModelAndView("dashboardAndReports/staffActivities/patientAttendance/", model);
    }

    @RequestMapping(value = "/patientattendancenorange", method = RequestMethod.POST)
    public ModelAndView patientAttendanceNoRange(HttpServletRequest request,
            @ModelAttribute("date") String date) {
        Map<String, Object> model = new HashMap<>();
        try {
            if (request.getSession().getAttribute("sessionActiveLoginFacility") == null) {
                String[] params = {""};
                return new ModelAndView("refresh");
            }
            model.put("serverdate", formatterwithtime3.format(serverDate));
        } catch (Exception e) {
            System.out.println(e);
        }
        return new ModelAndView("dashboardAndReports/staffActivities/patientAttendance/", model);
    }
    @RequestMapping(value = "/itemstatisticshome", method = RequestMethod.GET)
    public ModelAndView itemStatsHome(HttpServletRequest request) {
        final Map<String, Object> model = new HashMap<>();
        final List<Map<String, Object>> items = new ArrayList<>();
        try {
            String[] params = {};
            Object[] paramsValues = {};
            String where = "";
            String[] fields = {"itempackageid", "packagename"};
            List<Object[]> itemsPackages = (List<Object[]>) genericClassService.fetchRecord(Itempackage.class, fields, where, params, paramsValues);
            if (itemsPackages != null) {
                itemsPackages.forEach((itemPackage) -> {
                    Map<String, Object> item = new HashMap<>();
                    item.put("itemid", itemPackage[0]);
                    item.put("itemname", itemPackage[1]);
                    items.add(item);
                });
            }
            model.put("items", items);
            model.put("serverdate", formatterwithtime3.format(serverDate));
            model.put("serveryear", year.format(serverDate));
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return new ModelAndView("dashboardAndReports/inventory/views/itemstatisticshome", model);
    }
    @RequestMapping(value = "/recieveditemstatistics", method = RequestMethod.GET)
    public @ResponseBody
    String recievedItemStatistics(HttpServletRequest request) {
        String result = "";
        try {
            final Map<String, Object> results = new HashMap<>();
            final List<Map<String, Object>> statistics = new ArrayList<>();
            final long facilityId = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
            final int startYear = Integer.parseInt(request.getParameter("startyear"));
            final int endYear = Integer.parseInt(request.getParameter("endyear"));
            final String[] months = {"", "Jan", "Feb", "Mar", "Apr", "May",
                "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
            final List<Map<String, Object>> items = new ObjectMapper().readValue(request.getParameter("items"), List.class);
            final Map<String, Object> labels = new HashMap<>();
            final StringBuilder facilityUnitIds = new StringBuilder();

            items.forEach((item) -> {
                labels.put(item.get("itemid") + "in", item.get("itemname"));
            });

            String[] params = {"facilityid"};
            Object[] paramsValues = {facilityId};
            String[] fields = {"facilityunitid"};
            String where = "WHERE facilityid=:facilityid";
            List<Long> facilityUnits = (List<Long>) genericClassService.fetchRecord(Facilityunit.class, fields, where, params, paramsValues);
            if (facilityUnits != null) {
                facilityUnits.forEach((facilityUnitId) -> {
                    facilityUnitIds.append(facilityUnitId).append(",");
                });
                String unitIds = facilityUnitIds.deleteCharAt((facilityUnitIds.length() - 1)).toString();
                for (int month = 1; month < months.length; month++) {
                    final Map<String, Object> item = new HashMap<>();
                    item.put("month", months[month]);
                    for (Map<String, Object> i : items) {
                        String id = i.get("itemid").toString();
                        String[] lambdaParams = new String[]{"logtype", "statmonth", "startyear", "endyear", "itemid"};
                        Object[] lambdaParamsValues = new Object[]{"IN", month, startYear, endYear, BigInteger.valueOf(Long.parseLong(id))};
                        String[] lambdaFields = new String[]{"r.itemid", "SUM(r.quantity)", "r.statmonth", "r.logtype"};
                        String lambdaWhere = String.format("WHERE r.itemid=:itemid AND r.logtype=:logtype AND r.statmonth=:statmonth AND statyear BETWEEN :startyear AND :endyear AND r.facilityunitid IN(%s) GROUP BY r.itemid, r.statmonth, r.logtype ORDER BY r.itemid", unitIds);
                        List<Object[]> inStats = (List<Object[]>) genericClassService.fetchRecordFunction(Itemstatistics.class, lambdaFields, lambdaWhere, lambdaParams, lambdaParamsValues, 0, 0);

                        if (inStats != null) {
                            inStats.forEach((inStat) -> {
                                item.put(id + "in", Integer.parseInt(inStat[1].toString()));
                            });
                        } else {
                            item.put(id + "in", 0);
                        }
                    }
                    statistics.add(item);
                }
            }
            results.put("statistics", statistics);
            results.put("labels", labels);
            result = new ObjectMapper().writeValueAsString(results);
        } catch (NumberFormatException e) {
            System.out.println(e);
        } catch (JsonProcessingException e) {
            System.out.println(e);
        } catch (IOException e) {
            System.out.println(e);
        } catch (Exception e) {
            System.out.println(e);
        }
        return result;
    }

    @RequestMapping(value = "/issueditemstatistics", method = RequestMethod.GET)
    public @ResponseBody
    String issuedItemStatistics(HttpServletRequest request) {
        String result = "";
        try {
            final Map<String, Object> results = new HashMap<>();
            final List<Map<String, Object>> statistics = new ArrayList<>();
            final long facilityId = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
            final int startYear = Integer.parseInt(request.getParameter("startyear"));
            final int endYear = Integer.parseInt(request.getParameter("endyear"));
            final String[] months = {"", "Jan", "Feb", "Mar", "Apr", "May",
                "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
            final List<Map<String, Object>> items = new ObjectMapper().readValue(request.getParameter("items"), List.class);
            final Map<String, Object> labels = new HashMap<>();
            final StringBuilder facilityUnitIds = new StringBuilder();

            items.forEach((item) -> {
                labels.put(item.get("itemid") + "out", item.get("itemname"));
            });

            String[] params = {"facilityid"};
            Object[] paramsValues = {facilityId};
            String[] fields = {"facilityunitid"};
            String where = "WHERE facilityid=:facilityid";
            List<Long> facilityUnits = (List<Long>) genericClassService.fetchRecord(Facilityunit.class, fields, where, params, paramsValues);
            if (facilityUnits != null) {
                facilityUnits.forEach((facilityUnitId) -> {
                    facilityUnitIds.append(facilityUnitId).append(",");
                });
                String unitIds = facilityUnitIds.deleteCharAt((facilityUnitIds.length() - 1)).toString();
                for (int month = 1; month < months.length; month++) {
                    final Map<String, Object> item = new HashMap<>();
                    item.put("month", months[month]);
                    for (Map<String, Object> i : items) {
                        String id = i.get("itemid").toString();
                        String[] lambdaParams = new String[]{"logtype", "statmonth", "startyear", "endyear", "itemid"};
                        Object[] lambdaParamsValues = new Object[]{"DISP", month, startYear, endYear, BigInteger.valueOf(Long.parseLong(id))};
                        String[] lambdaFields = new String[]{"r.itemid", "SUM(r.quantity)", "r.statmonth", "r.logtype"};
                        String lambdaWhere = String.format("WHERE r.itemid=:itemid AND r.logtype=:logtype AND r.statmonth=:statmonth AND statyear BETWEEN :startyear AND :endyear AND r.facilityunitid IN(%s) GROUP BY r.itemid, r.statmonth, r.logtype ORDER BY r.itemid", unitIds);
                        List<Object[]> outStats = (List<Object[]>) genericClassService.fetchRecordFunction(Itemstatistics.class, lambdaFields, lambdaWhere, lambdaParams, lambdaParamsValues, 0, 0);

                        if (outStats != null) {
                            outStats.forEach((inStat) -> {
                                item.put(id + "out", Integer.parseInt(inStat[1].toString()));
                            });
                        } else {
                            item.put(id + "out", 0);
                        }
                    }
                    statistics.add(item);
                }
            }
            results.put("statistics", statistics);
            results.put("labels", labels);
            result = new ObjectMapper().writeValueAsString(results);
        } catch (NumberFormatException e) {
            System.out.println(e);
        } catch (JsonProcessingException e) {
            System.out.println(e);
        } catch (IOException e) {
            System.out.println(e);
        } catch (Exception e) {
            System.out.println(e);
        }
        return result;
    }
    @RequestMapping(value = "/itemstatisticstable", method = RequestMethod.GET)
    public ModelAndView itemStatisticsTable(HttpServletRequest request) {
        final Map<String, Object> model = new HashMap<>();
        final List<Map<String, Object>> itemStatistics = new ArrayList<>();
        try {
            final long facilityId = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
            final List<Map<String, Object>> items = new ObjectMapper().readValue(request.getParameter("items"), List.class);
            final int startYear = Integer.parseInt(request.getParameter("startyear"));
            final int endYear = Integer.parseInt(request.getParameter("endyear"));
            final StringBuilder facilityUnitIds = new StringBuilder();
            String[] params = {"facilityid"};
            Object[] paramsValues = {facilityId};
            String[] fields = {"facilityunitid"};
            String where = "WHERE facilityid=:facilityid";
            List<Long> facilityUnits = (List<Long>) genericClassService.fetchRecord(Facilityunit.class, fields, where, params, paramsValues);
            if (facilityUnits != null) {
                facilityUnits.forEach((facilityUnitId) -> {
                    facilityUnitIds.append(facilityUnitId).append(",");
                });
                String unitIds = facilityUnitIds.deleteCharAt((facilityUnitIds.length() - 1)).toString();
                for (Map<String, Object> i : items) {
                    Map<String, Object> item = new HashMap<>();
                    String id = i.get("itemid").toString();
                    String itemName = i.get("itemname").toString();
                    item.put("itemname", itemName);
                    item.put("itemid", id);
                    params = new String[]{"logtype", "startyear", "endyear", "itemid"};
                    paramsValues = new Object[]{"IN", startYear, endYear, BigInteger.valueOf(Long.parseLong(id))};
                    fields = new String[]{"r.itemid", "SUM(r.quantity)", "r.packagename", "r.logtype"};
                    where = String.format("WHERE r.itemid=:itemid AND r.logtype=:logtype AND statyear BETWEEN :startyear AND :endyear AND r.facilityunitid IN(%s) GROUP BY r.itemid, r.packagename, r.logtype ORDER BY r.packagename", unitIds);
                    List<Object[]> inStats = (List<Object[]>) genericClassService.fetchRecordFunction(Itemstatistics.class, fields, where, params, paramsValues, 0, 0);
                    if (inStats != null) {
                        Object[] stat = inStats.get(0);
//                            item.put("itemname", stat[2]);
                        if (stat[3].toString().trim().equalsIgnoreCase("IN")) {
                            item.put("quantityreceived", stat[1]);
                        }
                    } else {
                        item.put("quantityreceived", 0);
                    }
                    params = new String[]{"logtype", "startyear", "endyear", "itemid"};
                    paramsValues = new Object[]{"DISP", startYear, endYear, BigInteger.valueOf(Long.parseLong(id))};
                    fields = new String[]{"r.itemid", "SUM(r.quantity)", "r.packagename", "r.logtype"};
                    where = String.format("WHERE r.itemid=:itemid AND r.logtype=:logtype AND statyear BETWEEN :startyear AND :endyear AND r.facilityunitid IN(%s) GROUP BY r.itemid, r.packagename, r.logtype ORDER BY r.packagename", unitIds);
                    List<Object[]> outStats = (List<Object[]>) genericClassService.fetchRecordFunction(Itemstatistics.class, fields, where, params, paramsValues, 0, 0);
                    if (outStats != null) {
                        Object[] stat = outStats.get(0);
//                        item.put("itemname", stat[2]);
                        item.put("quantityissued", stat[1]);
                    } else {
                        item.put("quantityissued", 0);
                    }
                    itemStatistics.add(item);
                }
            }
            model.put("items", itemStatistics);
        } catch (Exception ex) {
            System.out.println(ex);
        }
        return new ModelAndView("dashboardAndReports/inventory/views/itemstatistics", model);
    }
    @RequestMapping(value = "/itemstatisticsdetails", method = RequestMethod.GET)
    public ModelAndView itemStatisticsDetails(HttpServletRequest request) {
        final Map<String, Object> model = new HashMap<>();
        final List<Map<String, Object>> items = new ArrayList<>();
        try {
            final long facilityId = Integer.parseInt(request.getSession().getAttribute("sessionActiveLoginFacility").toString());
            final long itemId = Long.parseLong(request.getParameter("itemid"));
            String[] params = {"facilityid"};
            Object[] paramsValues = {facilityId};
            String[] fields = {"facilityunitid", "facilityunitname"};
            String where = "WHERE facilityid=:facilityid";
            List<Object []> facilityUnits = (List<Object []>) genericClassService.fetchRecord(Facilityunit.class, fields, where, params, paramsValues);
            if (facilityUnits != null) {
                for (Object[] facilityUnit : facilityUnits) {
                    long facilityUnitId = Long.parseLong(facilityUnit[0].toString());
                    String facilityUnitName = facilityUnit[1].toString();
                    fields = new String[]{"logtype", "itemid", "packagename", "quantity", "facilityunitid"};
                    params = new String[]{"itemid"};
                    paramsValues = new Object[]{BigInteger.valueOf(itemId)};
                    where = String.format("WHERE itemid=:itemid AND facilityunitid IN(%s)", facilityUnitId);
                    List<Object[]> itemStats = (List<Object[]>) genericClassService.fetchRecord(Itemstatistics.class, fields, where, params, paramsValues);
                    if (itemStats != null) {
                        Map<String, Object> item = new HashMap<>();
                        item.put("facilityunitname", facilityUnitName);                        
                        item.put("quantityreceived", 0);
                        item.put("quantityissued", 0);
                        itemStats.forEach((itemStat) -> {
                            String logType = itemStat[0].toString().trim();
                            item.put("itemid", itemStat[1]);
                            item.put("itemname", itemStat[2]);
                            if (logType.equalsIgnoreCase("IN")) {
                                item.put("quantityreceived", itemStat[3]);
                            } else if (logType.equalsIgnoreCase("DISP")) {
                                item.put("quantityissued", itemStat[3]);
                            }
                        });
                        items.add(item);
                    }
                }
            }
            model.put("items", items);
        } catch (NumberFormatException e) {
            System.out.println(e);
        } catch (Exception e) {
            System.out.println(e);
        }
        return new ModelAndView("dashboardAndReports/inventory/views/itemdetails", model);
    }
    public Long getDays(Date start, Date end)
            throws ParseException {
        long diffInMillies = Math.abs(end.getTime() - start.getTime());
        long diff = TimeUnit.DAYS.convert(diffInMillies, TimeUnit.MILLISECONDS);
        return diff;
    }

    private Map<String, Object> getTimeDifference(Date fromDate, Date toDate) {
        Map<String, Object> result = new HashMap<>();
        try {
            SimpleDateFormat formatMinutes = new SimpleDateFormat("mm");
            SimpleDateFormat formatHours = new SimpleDateFormat("HH");

            int fromHours = Integer.parseInt(formatHours.format(fromDate)) + 12;
            int toHours = Integer.parseInt(formatHours.format(toDate)) + 12;
            
            int fromMinutes = Integer.parseInt(formatMinutes.format(fromDate));
            // Added 6 minutes to cater for the lost minutes after popping, but before servicing the patient.
            int toMinutes = Integer.parseInt(formatMinutes.format(toDate)) + 6;

            if (fromMinutes > toMinutes) {
                toHours -= 1;
                toMinutes += 60;
            }
            int minutes = toMinutes - fromMinutes;
            int hours = toHours - fromHours;
            hours = (hours >= 0) ? hours : 0;
            minutes = (minutes >= 0) ? minutes : 0;
            result.put("hours", hours);
            result.put("minutes", minutes);
        } catch (NumberFormatException e) {
            System.out.println(e);
        } catch (Exception e) {
            System.out.println(e);
        }
        return result;
    }
}
