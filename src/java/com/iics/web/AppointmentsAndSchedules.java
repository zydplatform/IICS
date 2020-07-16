/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.controlpanel.Scheduleday;
import com.iics.controlpanel.Scheduledaysession;
import com.iics.controlpanel.Schedules;
import com.iics.controlpanel.Stafffacilityunit;
import com.iics.domain.Facilityunit;
import com.iics.domain.Searchstaff;
import com.iics.domain.Staff;
import com.iics.scheduleplan.Batchstaffschedules;
import com.iics.scheduleplan.Service;
import com.iics.scheduleplan.Servicedayplan;
import com.iics.scheduleplan.Staffservice;
import org.springframework.stereotype.Controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.iics.service.GenericClassService;
import java.io.IOException;
import java.math.BigInteger;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.commons.lang.ArrayUtils;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author RESEARCH
 */
@Controller
@RequestMapping("/appointmentandSchedules")
public class AppointmentsAndSchedules {

    @Autowired
    GenericClassService genericClassService;
    private SimpleDateFormat formatterwithtime2 = new SimpleDateFormat("yyyy-MM-dd hh:mm aa");
    private Date serverDate = new Date();

    @RequestMapping(value = "/appointmentsPane", method = RequestMethod.GET)
    public final ModelAndView AppointmentsPane(HttpServletRequest request) {
        Map<String, Object> model = new HashMap<String, Object>();
        return new ModelAndView("controlPanel/localSettingsPanel/appointments/appointmentsPane", "model", model);

    }

    @RequestMapping(value = "/schedulestab", method = RequestMethod.GET)
    public String schedulestab(HttpServletRequest request, Model model) {
        activeuserschedules(request, model);
        return "controlPanel/localSettingsPanel/appointments/shedules/schedulespane";
    }

    @RequestMapping(value = "/createstaffSchedule", method = RequestMethod.GET)
    public String createstaffSchedule(HttpServletRequest request, Model model, @ModelAttribute("selectedid") int selectid) {
        String showpage = "";
        BigInteger facilityunitid = BigInteger.valueOf(Long.parseLong(String.valueOf((int) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))));
        BigInteger staffid = BigInteger.valueOf(Long.parseLong(request.getSession().getAttribute("sessionActiveLoginStaffid").toString()));
        Map<String, Object> stafffacilitydetails = new HashMap();
        List<Map> stafffacilityList = new ArrayList<>();
        Map<String, Object> stafffacilityMap = null;
        String[] params = {"facilityunitid"};
        Object[] paramsValues = {facilityunitid};
        String[] fields = {"facilityid", "facilityunitname", "shortname"};
        String where = "WHERE facilityunitid=:facilityunitid";
        List<Object[]> facilityObj = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields, where, params, paramsValues);
        switch (selectid) {
            case 1:
                if (facilityObj != null) {
                    Object[] x = facilityObj.get(0);
                    stafffacilitydetails.put("staffid", staffid);
                    stafffacilitydetails.put("StaffName", staffname(staffid));
                    stafffacilitydetails.put("facilityunitname", x[1]);
                    stafffacilitydetails.put("facilityunitshortname", x[2]);
                    stafffacilitydetails.put("scheduletype", "Staff");

                }
                model.addAttribute("staffmemberx", stafffacilitydetails);
                showpage = "controlPanel/localSettingsPanel/appointments/shedules/views/staffschedule";
                break;
            case 2:
                if (facilityObj != null) {
                    Object[] k = facilityObj.get(0);
                    String[] paramsx = {"facilityunitid", "active"};
                    Object[] paramsValuesx = {facilityunitid, Boolean.TRUE};
                    String[] fieldsx = {"staffid", "facilityunitid"};
                    String wherex = "WHERE facilityunitid=:facilityunitid AND active=:active";
                    List<Object[]> facUnitObj = (List<Object[]>) genericClassService.fetchRecord(Stafffacilityunit.class, fieldsx, wherex, paramsx, paramsValuesx);
                    if (facUnitObj != null) {
                        for (Object[] x : facUnitObj) {
                            stafffacilityMap = new HashMap();
                            stafffacilityMap.put("staffid", x[0]);
                            stafffacilityMap.put("StaffName", staffname(BigInteger.valueOf(Long.parseLong(x[0].toString()))));
                            stafffacilityList.add(stafffacilityMap);
                        }
                    }

                    stafffacilitydetails.put("facilityunitname", k[1]);
                    stafffacilitydetails.put("facilityunitshortname", k[2]);
                    stafffacilitydetails.put("scheduletype", "Staff");

                }
                model.addAttribute("stafffacilityListing", stafffacilityList);
                model.addAttribute("staffothermemberx", stafffacilitydetails);
                showpage = "controlPanel/localSettingsPanel/appointments/shedules/views/otherstaffschedule";
                break;
            case 3:
                showpage = "controlPanel/localSettingsPanel/appointments/shedules/views/servicestaffschedule";
                break;
            default:
                System.out.println("----------------***************-------------------error");
                break;
        }
        model.addAttribute("serverdate", formatterwithtime2.format(serverDate));
        return showpage;
    }

    @RequestMapping(value = "/createStaffSchedule")
    public @ResponseBody
    String createStaffSchedule(HttpServletRequest request, Model model, @ModelAttribute("weekdaySession") String weekdaySession, @ModelAttribute("weeks") String weeks, @ModelAttribute("data") String data) {
        ObjectMapper mapper = new ObjectMapper();
        BigInteger staffid = BigInteger.valueOf(Long.parseLong(request.getSession().getAttribute("sessionActiveLoginStaffid").toString()));
        String msg = "";
        try {
            Schedules staffschedule;
            Scheduleday staffscheduledays;
            Scheduledaysession staffscheduledaysession;
            List<Map> Alldata = (ArrayList<Map>) mapper.readValue(data, List.class);
            for (Map x : Alldata) {
                staffschedule = new Schedules();
                String startdate = (String) x.get("startdate");
                String enddate = (String) x.get("enddate");
                String schedulestatus = (String) x.get("schedulestat");
                long Staffid = Long.parseLong(x.get("staffid").toString());
                staffschedule.setStartdate(startdate);
                staffschedule.setEnddate(enddate);
                staffschedule.setSchedulestatus(schedulestatus);
                staffschedule.setDateadded(new Date());
                staffschedule.setAddedby(staffid);
                staffschedule.setStaffid(BigInteger.valueOf(Staffid));
                Object savedschedule = genericClassService.saveOrUpdateRecordLoadObject(staffschedule);
                if (savedschedule != null) {
                    long scheduleid = staffschedule.getSchedulesid();
                    List<String> selectedweeks = (ArrayList<String>) mapper.readValue(weeks, List.class);
                    for (String n : selectedweeks) {
                        staffscheduledays = new Scheduleday();
                        staffscheduledays.setWeekday(n);
                        staffscheduledays.setSchedulesid(new Schedules(scheduleid));
                        Object savedscheduledays = genericClassService.saveOrUpdateRecordLoadObject(staffscheduledays);
                        if (savedscheduledays != null) {
                            long scheduledayid = staffscheduledays.getScheduledayid();
                            List<Map> selectedDaysession = (ArrayList<Map>) mapper.readValue(weekdaySession, List.class);
                            for (Map m : selectedDaysession) {
                                staffscheduledaysession = new Scheduledaysession();
                                if (String.valueOf(m.get("weekday")).equals(n)) {
                                    String sessiontime = m.get("sessiontimeSet").toString();
                                    String[] sessiontimearr = sessiontime.split("-");
                                    String starttime = sessiontimearr[0];
                                    String endtime = sessiontimearr[1];
                                    staffscheduledaysession.setScheduledayid(new Scheduleday(scheduledayid));
                                    staffscheduledaysession.setStarttime(starttime);
                                    staffscheduledaysession.setEndtime(endtime);
                                    Object savedscheduledaysession = genericClassService.saveOrUpdateRecordLoadObject(staffscheduledaysession);
                                    if (savedscheduledaysession != null) {
                                        msg = "success";
                                    } else {
                                        msg = "failure";
                                    }
                                }
                            }
                        }
                    }
                }
            }

        } catch (IOException ex) {
            System.out.println(ex);
        }
        return msg;
    }

    @RequestMapping(value = "/addoreditstaffSchedule")
    public @ResponseBody
    String addoreditstaffSchedule(HttpServletRequest request, Model model) {
        String msg = "";
        ObjectMapper mapper = new ObjectMapper();
        BigInteger staffid = BigInteger.valueOf(Long.parseLong(request.getSession().getAttribute("sessionActiveLoginStaffid").toString()));
        try {
            Schedules staffschedule;
            Scheduleday staffscheduledays;
            Scheduledaysession staffscheduledaysession;
            Scheduledaysession staffscheduledaysessionx;
            long scheduleidx = Long.parseLong(request.getParameter("scheduleid"));
            if (request.getParameter("schedulesupdatedata") != null) {
                List<Map> schedulesupdate = (ArrayList<Map>) mapper.readValue(request.getParameter("schedulesupdatedata"), List.class);
                String[] columnslev = {"startdate", "enddate", "dateupdated", "updatedby", "schedulestatus"};
                Object[] columnValueslev = {schedulesupdate.get(0).get("startdate"), schedulesupdate.get(0).get("enddate"), new Date(), staffid, schedulesupdate.get(0).get("schedulestatex")};
                String levelPrimaryKey = "schedulesid";
                Object levelPkValue = scheduleidx;
                Object saved1 = genericClassService.updateRecordSQLSchemaStyle(Schedules.class, columnslev, columnValueslev, levelPrimaryKey, levelPkValue, "controlpanel");
                if (saved1 != null) {
                    msg = "success";
                } else {
                    msg = "failure";
                }
            }
            if (request.getParameter("addNewDay") != null) {
                List<Map> newScheduledays = (ArrayList<Map>) mapper.readValue(request.getParameter("addNewDay"), List.class);
                for (Map x : newScheduledays) {
                    String weekdayx = x.get("weekday").toString();
                    staffscheduledays = new Scheduleday();
                    staffscheduledays.setWeekday(weekdayx);
                    staffscheduledays.setSchedulesid(new Schedules(scheduleidx));
                    Object saved2 = genericClassService.saveOrUpdateRecordLoadObject(staffscheduledays);
                    if (saved2 != null) {
                        long scheduledayid = staffscheduledays.getScheduledayid();
                        if (request.getParameter("addNewDaysessions") != null) {
                            List<Map> newSchedulesessiondays = (ArrayList<Map>) mapper.readValue(request.getParameter("addNewDaysessions"), List.class);
                            for (Map n : newSchedulesessiondays) {
                                staffscheduledaysession = new Scheduledaysession();
                                String weekday2 = n.get("weekday").toString();
                                if (weekdayx.equals(weekday2)) {
                                    String sessiontime = n.get("sessiontimeSet").toString();
                                    String[] sessiontimearr = sessiontime.split("-");
                                    String starttime = sessiontimearr[0];
                                    String endtime = sessiontimearr[1];
                                    staffscheduledaysession.setScheduledayid(new Scheduleday(scheduledayid));
                                    staffscheduledaysession.setStarttime(starttime);
                                    staffscheduledaysession.setEndtime(endtime);
                                    Object saved3 = genericClassService.saveOrUpdateRecordLoadObject(staffscheduledaysession);
                                    if (saved3 != null) {
                                        msg = "success";
                                    } else {
                                        msg = "failure";
                                    }
                                }
                            }
                        }
                    }
                }
            }
            if (request.getParameter("addschedulesessionExist") != null) {
                List<Map> schedulesessiondaysExist = (ArrayList<Map>) mapper.readValue(request.getParameter("addschedulesessionExist"), List.class);
                for (Map k : schedulesessiondaysExist) {
                    staffscheduledaysessionx = new Scheduledaysession();
                    long scheduledayidx = Long.parseLong(k.get("scheduledayid").toString());
                    String sessiontimex = k.get("sessiontimeSet").toString();
                    String[] sessiontimearrx = sessiontimex.split("-");
                    String starttimex = sessiontimearrx[0];
                    String endtimex = sessiontimearrx[1];
                    staffscheduledaysessionx.setScheduledayid(new Scheduleday(scheduledayidx));
                    staffscheduledaysessionx.setStarttime(starttimex);
                    staffscheduledaysessionx.setEndtime(endtimex);
                    Object saved4 = genericClassService.saveOrUpdateRecordLoadObject(staffscheduledaysessionx);
                    if (saved4 != null) {
                        msg = "success";
                    } else {
                        msg = "failure";
                    }
                }
            }
        } catch (IOException ex) {
            System.out.println(ex);
        }

        return msg;
    }

    @RequestMapping(value = "/activeuserschedules", method = RequestMethod.GET)
    public String activeuserschedules(HttpServletRequest request, Model model) {
        String status = "ON";
        Map<String, Object> staffscheduleObjtestMap = null;
        List<Map> staffscheduleObjtestList = new ArrayList<>();
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        String today = sdf.format(new Date());
        Set<BigInteger> assignedstaffid = new HashSet<>();
        String[] params1 = {"schedulestatus"};
        Object[] paramsValues1 = {status};
        String[] fields1 = {"schedulesid", "staffid", "startdate", "enddate", "schedulestatus"};
        String where1 = "WHERE schedulestatus=:schedulestatus ORDER BY schedulesid DESC";
        List<Object[]> staffscheduleObj1 = (List<Object[]>) genericClassService.fetchRecord(Schedules.class, fields1, where1, params1, paramsValues1);
        if (staffscheduleObj1 != null) {
            for (Object[] t : staffscheduleObj1) {
                try {
                    Date currentToday = sdf.parse(today);
                    Date enddatex = sdf.parse(String.valueOf(t[3]));
                    if (enddatex.getTime() >= currentToday.getTime()) {
                        BigInteger staffid = BigInteger.valueOf(Long.parseLong(t[1].toString()));
                        if (!assignedstaffid.contains(staffid)) {
                            assignedstaffid.add(staffid);
                        }

                    }
                } catch (ParseException ex) {
                    System.out.println(ex);
                }
            }
        }
        for (BigInteger staffidx : assignedstaffid) {
            String[] params2 = {"staffid", "schedulestatus"};
            Object[] paramsValues2 = {staffidx, status};
            String[] fields2 = {"schedulesid", "staffid", "enddate", "schedulestatus"};
            String where2 = "WHERE staffid=:staffid AND schedulestatus=:schedulestatus ORDER BY schedulesid DESC";
            List<Object[]> staffscheduleObj2 = (List<Object[]>) genericClassService.fetchRecord(Schedules.class, fields2, where2, params2, paramsValues2);
            if (staffscheduleObj2 != null) {
                try {
                    for (Object[] v : staffscheduleObj2) {
                        Date currentToday = sdf.parse(today);
                        Date enddatex = sdf.parse(String.valueOf(v[2]));
                        if (enddatex.getTime() >= currentToday.getTime()) {
                            staffscheduleObjtestMap = new HashMap<>();
                            staffscheduleObjtestMap.put("staffid", staffidx);
                            staffscheduleObjtestMap.put("schedulestate", v[3]);
                            staffscheduleObjtestMap.put("StaffName", staffname(staffidx));
                            staffscheduleObjtestMap.put("scheduleCount", staffscheduleObj2.size());
                        }
                    }

                } catch (ParseException ex) {
                    System.out.println(ex);
                }
            }
            staffscheduleObjtestList.add(staffscheduleObjtestMap);
        }
        model.addAttribute("activeStaffList", staffscheduleObjtestList);
        return "controlPanel/localSettingsPanel/appointments/shedules/views/active/activeschedulesDisplay";
    }

    @RequestMapping(value = "/activeuserschedulelist", method = RequestMethod.GET)
    public String activeuserschedulelist(HttpServletRequest request, Model model, @ModelAttribute("staffid") BigInteger staffid) {
        String status = "ON";
        BigInteger staffidsession = BigInteger.valueOf(Long.parseLong(request.getSession().getAttribute("sessionActiveLoginStaffid").toString()));
        Map<String, Object> staffscheduleObjMap = null;
        List<Map> staffscheduleObjList = new ArrayList<>();
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        String today = sdf.format(new Date());
        String[] params = {"staffid", "schedulestatus"};
        Object[] paramsValues = {staffid, status};
        String[] fields = {"schedulesid", "staffid", "startdate", "enddate", "schedulestatus"};
        String where = "WHERE staffid=:staffid AND schedulestatus=:schedulestatus ORDER BY schedulesid DESC";
        List<Object[]> staffscheduleObj = (List<Object[]>) genericClassService.fetchRecord(Schedules.class, fields, where, params, paramsValues);
        if (staffscheduleObj != null) {
            for (Object[] x : staffscheduleObj) {
                try {
                    Date currentToday = sdf.parse(today);
                    Date enddatex = sdf.parse(String.valueOf(x[3]));
                    if (enddatex.getTime() >= currentToday.getTime()) {
                        staffscheduleObjMap = new HashMap<>();
                        staffscheduleObjMap.put("scheduleid", x[0]);
                        staffscheduleObjMap.put("staffid", x[1]);
                        staffscheduleObjMap.put("startdate", x[2]);
                        staffscheduleObjMap.put("enddate", x[3]);
                        staffscheduleObjMap.put("schedulestate", x[4]);
                        staffscheduleObjMap.put("StaffName", staffname(BigInteger.valueOf(Long.parseLong(x[1].toString()))));
                        staffscheduleObjList.add(staffscheduleObjMap);
                    }
                } catch (ParseException ex) {
                    System.out.println(ex);
                }
            }

        }
        if (String.valueOf(staffid).equals(String.valueOf(staffidsession))) {
            staffscheduleObjMap.put("managedelete", true);
        } else {
            staffscheduleObjMap.put("managedelete", false);
        }
        model.addAttribute("activeStaffScheduleMap", staffscheduleObjMap);
        model.addAttribute("activeStaffSchedules", staffscheduleObjList);
        return "controlPanel/localSettingsPanel/appointments/shedules/views/active/activeuserschedulelistz";
    }

    @RequestMapping(value = "/deleteStaffactiveSchedule")
    public @ResponseBody
    String deleteStaffactiveSchedule(HttpServletRequest request, Model model, @ModelAttribute("scheduleid") BigInteger scheduleid) {
        Set<BigInteger> assignedscheduledayIDs = new HashSet<>();
        Set<BigInteger> assignedscheduledaysessionIDs = new HashSet<>();
        String[] params = {"schedulesid"};
        Object[] paramsValues = {scheduleid};
        String[] fields = {"scheduledayid", "weekday"};
        String where = "WHERE schedulesid=:schedulesid";
        List<Object[]> scheduleDaysObj = (List<Object[]>) genericClassService.fetchRecord(Scheduleday.class, fields, where, params, paramsValues);
        if (scheduleDaysObj != null) {
            for (Object[] n : scheduleDaysObj) {
                BigInteger scheduledayid = BigInteger.valueOf(Long.parseLong(String.valueOf(n[0])));
                assignedscheduledayIDs.add(scheduledayid);
            }
        }

        for (BigInteger h : assignedscheduledayIDs) {
            String[] params2 = {"scheduledayid"};
            Object[] paramsValues2 = {h};
            String[] fields2 = {"scheduledaysessionid", "starttime"};
            String where2 = "WHERE scheduledayid=:scheduledayid";
            List<Object[]> DaysessionObj = (List<Object[]>) genericClassService.fetchRecord(Scheduledaysession.class, fields2, where2, params2, paramsValues2);
            if (DaysessionObj != null) {
                for (Object[] k : DaysessionObj) {
                    BigInteger scheduledaysessionid = BigInteger.valueOf(Long.parseLong(String.valueOf(k[0])));
                    assignedscheduledaysessionIDs.add(scheduledaysessionid);
                }
            }
        }
        String msg = "";
        ObjectMapper mapper = new ObjectMapper();
        try {

            List<Integer> selectedDaysession = (ArrayList<Integer>) mapper.readValue(mapper.writeValueAsString(assignedscheduledaysessionIDs), List.class);
            for (Integer n : selectedDaysession) {
                String[] columns2 = {"scheduledaysessionid"};
                Object[] columnValues2 = {n};
                genericClassService.deleteRecordByByColumns("controlpanel.scheduledaysession", columns2, columnValues2);
            }
            List<Integer> selectedDay = (ArrayList<Integer>) mapper.readValue(mapper.writeValueAsString(assignedscheduledayIDs), List.class);
            for (Integer v : selectedDay) {
                String[] columns2 = {"scheduledayid"};
                Object[] columnValues2 = {v};
                genericClassService.deleteRecordByByColumns("controlpanel.scheduleday", columns2, columnValues2);
            }
            String[] columns1 = {"schedulesid"};
            Object[] columnValues1 = {scheduleid};
            Object res = genericClassService.deleteRecordByByColumns("controlpanel.schedules", columns1, columnValues1);
            if (res != null) {
                msg = "success";
            } else {
                msg = "failure";
            }
        } catch (IOException ex) {
            System.out.println(ex);
        }
        return msg;
    }

    @RequestMapping(value = "/pauseduserschedules", method = RequestMethod.GET)
    public String pauseduserschedules(HttpServletRequest request, Model model) {
        String status = "Paused";
        Map<String, Object> staffscheduleObjtest2Map = null;
        List<Map> staffscheduleObjtest2List = new ArrayList<>();
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        String today = sdf.format(new Date());
        Set<BigInteger> assignedpausedstaffid = new HashSet<>();
        String[] params1 = {"schedulestatus"};
        Object[] paramsValues1 = {status};
        String[] fields1 = {"schedulesid", "staffid", "startdate", "enddate", "schedulestatus"};
        String where1 = "WHERE schedulestatus=:schedulestatus ORDER BY schedulesid DESC";
        List<Object[]> staffscheduleObj1 = (List<Object[]>) genericClassService.fetchRecord(Schedules.class, fields1, where1, params1, paramsValues1);
        if (staffscheduleObj1 != null) {
            for (Object[] t : staffscheduleObj1) {
                try {
                    Date currentToday = sdf.parse(today);
                    Date enddatex = sdf.parse(String.valueOf(t[3]));
                    if (enddatex.getTime() >= currentToday.getTime()) {
                        BigInteger staffid = BigInteger.valueOf(Long.parseLong(t[1].toString()));
                        if (assignedpausedstaffid.contains(staffid)) {
                        } else {
                            assignedpausedstaffid.add(staffid);
                        }
                    }
                } catch (ParseException ex) {
                    System.out.println(ex);
                }

            }
        }
        for (BigInteger staffidx : assignedpausedstaffid) {
            System.out.println(staffname(staffidx));
            String[] params2 = {"staffid", "schedulestatus"};
            Object[] paramsValues2 = {staffidx, status};
            String[] fields2 = {"schedulesid", "staffid", "enddate", "schedulestatus"};
            String where2 = "WHERE staffid=:staffid AND schedulestatus=:schedulestatus ORDER BY schedulesid DESC";
            List<Object[]> staffscheduleObj2 = (List<Object[]>) genericClassService.fetchRecord(Schedules.class, fields2, where2, params2, paramsValues2);
            if (staffscheduleObj2 != null) {
                try {
                    Date currentToday = sdf.parse(today);
                    Date enddatex = sdf.parse(String.valueOf(staffscheduleObj2.get(0)[2]));
                    if (enddatex.getTime() >= currentToday.getTime()) {
                        staffscheduleObjtest2Map = new HashMap<>();
                        staffscheduleObjtest2Map.put("staffid", staffidx);
                        staffscheduleObjtest2Map.put("schedulestate", staffscheduleObj2.get(0)[3]);
                        staffscheduleObjtest2Map.put("StaffName", staffname(staffidx));
                        staffscheduleObjtest2Map.put("scheduleCount", staffscheduleObj2.size());
                    }
                } catch (ParseException ex) {
                    System.out.println(ex);
                }
            }
            staffscheduleObjtest2List.add(staffscheduleObjtest2Map);
        }
        model.addAttribute("pausedStaffList", staffscheduleObjtest2List);
        return "controlPanel/localSettingsPanel/appointments/shedules/views/paused/pausedscheduleDisplay";
    }

    @RequestMapping(value = "/pauseduserschedulelist", method = RequestMethod.GET)
    public String pauseduserschedulelist(HttpServletRequest request, Model model, @ModelAttribute("staffid") BigInteger staffid) {
        String status = "Paused";
        List<Map> staffpausedscheduleObjList = null;
        Map<String, Object> staffpausedscheduleObjMap = null;
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        String today = sdf.format(new Date());
        String[] params = {"staffid", "schedulestatus"};
        Object[] paramsValues = {staffid, status};
        String[] fields = {"schedulesid", "staffid", "startdate", "enddate", "schedulestatus"};
        String where = "WHERE staffid=:staffid AND schedulestatus =:schedulestatus ORDER BY schedulesid DESC";
        List<Object[]> staffpausedscheduleObj = (List<Object[]>) genericClassService.fetchRecord(Schedules.class, fields, where, params, paramsValues);
        if (staffpausedscheduleObj != null) {
            staffpausedscheduleObjList = new ArrayList<>();
            for (Object[] x : staffpausedscheduleObj) {
                try {
                    Date currentToday = sdf.parse(today);
                    Date enddatex = sdf.parse(String.valueOf(x[3]));
                    if (enddatex.getTime() >= currentToday.getTime()) {
                        staffpausedscheduleObjMap = new HashMap<>();
                        staffpausedscheduleObjMap.put("scheduleid", x[0]);
                        staffpausedscheduleObjMap.put("staffid", x[1]);
                        staffpausedscheduleObjMap.put("startdate", x[2]);
                        staffpausedscheduleObjMap.put("enddate", x[3]);
                        staffpausedscheduleObjMap.put("schedulestate", x[4]);
                        staffpausedscheduleObjMap.put("StaffName", staffname(BigInteger.valueOf(Long.parseLong(x[1].toString()))));
                        staffpausedscheduleObjList.add(staffpausedscheduleObjMap);
                    }

                } catch (ParseException ex) {
                    System.out.println(ex);
                }
            }

        }
        model.addAttribute("pausedStaffSchedulesMap", staffpausedscheduleObjMap);
        model.addAttribute("pausedStaffSchedules", staffpausedscheduleObjList);
        return "controlPanel/localSettingsPanel/appointments/shedules/views/paused/pauseduserschedulelistz";
    }

    @RequestMapping(value = "/updateschedulestatus")
    public @ResponseBody
    String updateschedulestatus(HttpServletRequest request, Model model, @ModelAttribute("scheduleid") BigInteger scheduleid) {
        String msg = "";
        String statex = "ON";
        String[] columnslev = {"schedulestatus"};
        Object[] columnValueslev = {statex};
        String levelPrimaryKey = "schedulesid";
        Object levelPkValue = scheduleid;
        Object saved = genericClassService.updateRecordSQLSchemaStyle(Schedules.class, columnslev, columnValueslev, levelPrimaryKey, levelPkValue, "controlpanel");
        if (saved != null) {
            msg = "success";
        } else {
            msg = "fail";
        }
        return msg;
    }

    @RequestMapping(value = "/expireduserschedules", method = RequestMethod.GET)
    public String expireduserschedules(HttpServletRequest request, Model model) {
        Map<String, Object> staffscheduleObjtest3Map = null;
        List<Map> staffscheduleObjtest3List = new ArrayList<>();
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        String today = sdf.format(new Date());
        Set<BigInteger> assignedexpiredstaffid = new HashSet<>();
        String[] params1 = {};
        Object[] paramsValues1 = {};
        String[] fields1 = {"schedulesid", "staffid", "startdate", "enddate", "schedulestatus"};
        String where1 = "";
        List<Object[]> staffscheduleObj1 = (List<Object[]>) genericClassService.fetchRecord(Schedules.class, fields1, where1, params1, paramsValues1);
        if (staffscheduleObj1 != null) {
            for (Object[] t : staffscheduleObj1) {
                try {
                    Date currentToday = sdf.parse(today);
                    Date enddatex = sdf.parse(String.valueOf(t[3]));
                    if (enddatex.getTime() < currentToday.getTime()) {
                        BigInteger staffid = BigInteger.valueOf(Long.parseLong(t[1].toString()));
                        if (assignedexpiredstaffid.contains(staffid)) {
                        } else {
                            assignedexpiredstaffid.add(staffid);
                        }
                    }
                } catch (ParseException ex) {
                    System.out.println(ex);
                }

            }
        }
        for (BigInteger staffidx : assignedexpiredstaffid) {
            String[] params2 = {"staffid"};
            Object[] paramsValues2 = {staffidx};
            String[] fields2 = {"schedulesid", "staffid", "enddate", "schedulestatus"};
            String where2 = "WHERE staffid=:staffid ORDER BY schedulesid DESC";
            List<Object[]> staffscheduleObj2 = (List<Object[]>) genericClassService.fetchRecord(Schedules.class, fields2, where2, params2, paramsValues2);
            if (staffscheduleObj2 != null) {
                try {
                    for (Object[] v : staffscheduleObj2) {
                        Date currentToday = sdf.parse(today);
                        Date enddatex = sdf.parse(String.valueOf(v[2]));
                        if (enddatex.getTime() < currentToday.getTime()) {
                            staffscheduleObjtest3Map = new HashMap<>();
                            staffscheduleObjtest3Map.put("staffid", staffidx);
                            staffscheduleObjtest3Map.put("schedulestate", "Expired");
                            staffscheduleObjtest3Map.put("StaffName", staffname(staffidx));
                            staffscheduleObjtest3Map.put("scheduleCount", staffscheduleObjtest3List.size());
                        }
                    }
                } catch (ParseException ex) {
                    System.out.println(ex);
                }
            }
            staffscheduleObjtest3List.add(staffscheduleObjtest3Map);
        }
        model.addAttribute("expiredStaffList", staffscheduleObjtest3List);
        return "controlPanel/localSettingsPanel/appointments/shedules/views/expiry/expiredscheduleDisplay";
    }

    @RequestMapping(value = "/expireduserschedulelist", method = RequestMethod.GET)
    public String expireduserschedulelist(HttpServletRequest request, Model model, @ModelAttribute("staffid") BigInteger staffid) {
        BigInteger staffidsessionx = BigInteger.valueOf(Long.parseLong(request.getSession().getAttribute("sessionActiveLoginStaffid").toString()));
        List<Map> staffexpiredscheduleObjList = null;
        Map<String, Object> staffexpiredscheduleObjMap = null;
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        String today = sdf.format(new Date());
        if (String.valueOf(Long.parseLong(staffid.toString())) != null) {
            String[] params = {"staffid"};
            Object[] paramsValues = {staffid};
            String[] fields = {"schedulesid", "staffid", "startdate", "enddate"};
            String where = "WHERE staffid=:staffid ORDER BY schedulesid DESC";
            List<Object[]> staffpausedscheduleObj = (List<Object[]>) genericClassService.fetchRecord(Schedules.class, fields, where, params, paramsValues);
            if (staffpausedscheduleObj != null) {
                staffexpiredscheduleObjList = new ArrayList<>();
                for (Object[] x : staffpausedscheduleObj) {
                    try {
                        Date currentToday = sdf.parse(today);
                        Date enddatex = sdf.parse(String.valueOf(x[3]));
                        if (enddatex.getTime() < currentToday.getTime()) {
                            staffexpiredscheduleObjMap = new HashMap<>();
                            staffexpiredscheduleObjMap.put("scheduleid", x[0]);
                            staffexpiredscheduleObjMap.put("staffid", x[1]);
                            staffexpiredscheduleObjMap.put("startdate", x[2]);
                            staffexpiredscheduleObjMap.put("enddate", x[3]);
                            staffexpiredscheduleObjMap.put("schedulestate", "Expired");
                            staffexpiredscheduleObjMap.put("StaffName", staffname(BigInteger.valueOf(Long.parseLong(x[1].toString()))));
                            staffexpiredscheduleObjList.add(staffexpiredscheduleObjMap);

                        }
                    } catch (ParseException ex) {
                        System.out.println(ex);
                    }
                }

            }
            if (String.valueOf(staffid).equals(String.valueOf(staffidsessionx))) {
                //System.out.println(staffid);
                staffexpiredscheduleObjMap.put("managedelete", true);
            } else {
                staffexpiredscheduleObjMap.put("managedelete", false);
            }
            model.addAttribute("expiredStaffSchedulesMap", staffexpiredscheduleObjMap);
            model.addAttribute("expiredStaffSchedules", staffexpiredscheduleObjList);
        }

        return "controlPanel/localSettingsPanel/appointments/shedules/views/expiry/expireduserschedulelistz";
    }

    @RequestMapping(value = "/viewActiveScheduleday", method = RequestMethod.GET)
    public String viewActiveScheduleday(HttpServletRequest request, Model model, @ModelAttribute("dateSchedules") String dateSchedules, @ModelAttribute("scheduleid") BigInteger scheduleid) {
        ObjectMapper mapper = new ObjectMapper();
        List<Map> staffweekschedulesObjlist = new ArrayList<>();
        Map<String, Object> staffweekschedulesObjMap;
        Set<BigInteger> assignedStaffScheduledayid = new HashSet<>();
        try {
            List<Map> weekdays = (ArrayList<Map>) mapper.readValue(dateSchedules, List.class);
            for (Map k : weekdays) {
                String days = String.valueOf(k.get("day"));
                String scheduleDates = k.get("userdate").toString();
                String[] params = {"schedulesid"};
                Object[] paramsValues = {scheduleid};
                String[] fields = {"scheduledayid", "weekday"};
                String where = "WHERE schedulesid=:schedulesid";
                List<Object[]> weekDaysObj = (List<Object[]>) genericClassService.fetchRecord(Scheduleday.class, fields, where, params, paramsValues);
                if (weekDaysObj != null) {
                    for (Object[] n : weekDaysObj) {
                        String weekde = String.valueOf(n[1]);
                        Long scheduledayid = Long.parseLong(n[0].toString());
                        if (days.equals(weekde)) {
                            staffweekschedulesObjMap = new HashMap<>();
                            staffweekschedulesObjMap.put("scheduleDayzid", scheduledayid);
                            staffweekschedulesObjMap.put("weekday", weekde);
                            staffweekschedulesObjMap.put("scheduleDate", scheduleDates);
                            staffweekschedulesObjlist.add(staffweekschedulesObjMap);
                            BigInteger scheduledDayid = BigInteger.valueOf(scheduledayid);
                            if (!assignedStaffScheduledayid.contains(scheduledDayid)) {
                                assignedStaffScheduledayid.add(scheduledDayid);
                            }

                        }

                    }
                }
            }
        } catch (IOException ex) {
            System.out.println(ex);
        }
        List<Map> staffweekDaySessionsObjlist = new ArrayList<>();
        Map<String, Object> staffweekDaySessionsObj;
        for (BigInteger v : assignedStaffScheduledayid) {
            String[] params2 = {"scheduledayid"};
            Object[] paramsValues2 = {v};
            String[] fields2 = {"scheduledaysessionid", "starttime", "endtime"};
            String where2 = "WHERE scheduledayid=:scheduledayid";
            List<Object[]> weekDaySessionsObj = (List<Object[]>) genericClassService.fetchRecord(Scheduledaysession.class, fields2, where2, params2, paramsValues2);
            if (weekDaySessionsObj != null) {
                for (Object[] k : weekDaySessionsObj) {
                    staffweekDaySessionsObj = new HashMap<>();
                    staffweekDaySessionsObj.put("weekdaysessionid", k[0]);
                    staffweekDaySessionsObj.put("starttime", k[1]);
                    staffweekDaySessionsObj.put("endtime", k[2]);
                    staffweekDaySessionsObj.put("weekdayid", v);
                    staffweekDaySessionsObjlist.add(staffweekDaySessionsObj);
                }
            }
        }

        String jsonstaffweekDaySessionsObjlist = "";
        try {
            jsonstaffweekDaySessionsObjlist = mapper.writeValueAsString(staffweekDaySessionsObjlist);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }
        model.addAttribute("staffweeksdayscheduleslist", staffweekschedulesObjlist);
        model.addAttribute("jsonweekDaySessions", jsonstaffweekDaySessionsObjlist);
        return "controlPanel/localSettingsPanel/appointments/shedules/views/active/views/displayUserActiveScheduledDays";
    }

    @RequestMapping(value = "/showupdatingPage", method = RequestMethod.GET)
    public String showupdatingPage(HttpServletRequest request, Model model, @ModelAttribute("staffname") String staffnam, @ModelAttribute("schedulesid") BigInteger scheduleid, @ModelAttribute("staffid") BigInteger staffid, @ModelAttribute("start") String startDat, @ModelAttribute("end") String endDat, @ModelAttribute("state") String schedulestate) {
        BigInteger facilityunitid = BigInteger.valueOf(Long.parseLong(String.valueOf((int) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))));
        Map<String, Object> stafffacilitydetails = new HashMap();
        String[] params = {"facilityunitid"};
        Object[] paramsValues = {facilityunitid};
        String[] fields = {"facilityid", "facilityunitname", "shortname"};
        String where = "WHERE facilityunitid=:facilityunitid";
        List<Object[]> facilityObj = (List<Object[]>) genericClassService.fetchRecord(Facilityunit.class, fields, where, params, paramsValues);
        if (facilityObj != null) {
            Object[] x = facilityObj.get(0);
            stafffacilitydetails.put("staffid", staffid);
            stafffacilitydetails.put("StaffName", staffnam);
            stafffacilitydetails.put("facilityunitname", x[1]);
            stafffacilitydetails.put("facilityunitshortname", x[2]);
            stafffacilitydetails.put("scheduletype", "Staff");
            stafffacilitydetails.put("Startdates", startDat);
            stafffacilitydetails.put("Enddates", endDat);
            stafffacilitydetails.put("schedulestatusx", schedulestate);
        }

        //schedule COntents Details
        Map<String, Object> Staffxscheduleday;
        Map<String, Object> Staffxscheduledaysession;
        List<Map> StaffxscheduledayList = new ArrayList<>();
        List<Map> StaffxscheduledaysessionList = new ArrayList<>();
        Set<BigInteger> assignedscheduledayIDs = new HashSet<>();
        Set<BigInteger> assignedscheduledaysessionIDs = new HashSet<>();
        String[] params1 = {"schedulesid"};
        Object[] paramsValues1 = {scheduleid};
        String[] fields1 = {"scheduledayid", "weekday"};
        String where1 = "WHERE schedulesid=:schedulesid";
        List<Object[]> scheduleDaysObj = (List<Object[]>) genericClassService.fetchRecord(Scheduleday.class, fields1, where1, params1, paramsValues1);
        if (scheduleDaysObj != null) {
            for (Object[] n : scheduleDaysObj) {
                BigInteger scheduledayid = BigInteger.valueOf(Long.parseLong(String.valueOf(n[0])));
                assignedscheduledayIDs.add(scheduledayid);

                Staffxscheduleday = new HashMap();
                Staffxscheduleday.put("scheduledayid", n[0]);
                Staffxscheduleday.put("weekday", n[1]);
                Staffxscheduleday.put("schedulesid", scheduleid);
                StaffxscheduledayList.add(Staffxscheduleday);
            }
        }
        model.addAttribute("schedulesid", scheduleid);
        for (BigInteger h : assignedscheduledayIDs) {
            String[] params2 = {"scheduledayid"};
            Object[] paramsValues2 = {h};
            String[] fields2 = {"scheduledaysessionid", "starttime", "endtime"};
            String where2 = "WHERE scheduledayid=:scheduledayid";
            List<Object[]> DaysessionObj = (List<Object[]>) genericClassService.fetchRecord(Scheduledaysession.class, fields2, where2, params2, paramsValues2);
            if (DaysessionObj != null) {
                for (Object[] k : DaysessionObj) {
                    BigInteger scheduledaysessionid = BigInteger.valueOf(Long.parseLong(String.valueOf(k[0])));
                    assignedscheduledaysessionIDs.add(scheduledaysessionid);

                    Staffxscheduledaysession = new HashMap();
                    Staffxscheduledaysession.put("scheduledaysessionid", k[0]);
                    Staffxscheduledaysession.put("starttime", k[1]);
                    Staffxscheduledaysession.put("endtime", k[2]);
                    Staffxscheduledaysession.put("scheduledayid", h);
                    StaffxscheduledaysessionList.add(Staffxscheduledaysession);
                }
            }
        }
        model.addAttribute("staffmemberx", stafffacilitydetails);
        model.addAttribute("staffscheduleday", StaffxscheduledayList);
        model.addAttribute("staffschedulesession", StaffxscheduledaysessionList);
        ObjectMapper mapper = new ObjectMapper();
        String jsonStaffxscheduledayList = "";
        String jsonStaffxscheduledaysessionList = "";
        try {
            jsonStaffxscheduledayList = mapper.writeValueAsString(StaffxscheduledayList);
            jsonStaffxscheduledaysessionList = mapper.writeValueAsString(StaffxscheduledaysessionList);
        } catch (JsonProcessingException ex) {
            System.out.println(ex);
        }
        model.addAttribute("jsonstaffscheduleday", jsonStaffxscheduledayList);
        model.addAttribute("jsonstaffschedulesession", jsonStaffxscheduledaysessionList);
        model.addAttribute("serverdate", formatterwithtime2.format(serverDate));
        return "controlPanel/localSettingsPanel/appointments/shedules/views/active/views/staffScheduleEdit";
    }

    @RequestMapping(value = "/deleteDaySession")
    public @ResponseBody
    String deleteDaySession(HttpServletRequest request, Model model, @ModelAttribute("sessionidx") String sessionidx) {
        String msg = "";
        long sessionid = Long.parseLong(sessionidx);
        String[] columns = {"scheduledaysessionid"};
        Object[] columnValues = {sessionid};
        Object res = genericClassService.deleteRecordByByColumns("controlpanel.scheduledaysession", columns, columnValues);
        if (res != null) {
            msg = "success";
        } else {
            msg = "failure";
        }
        return msg;
    }

    public String staffname(BigInteger sid) {
        String names = "";
        String[] params = {"staffid"};
        Object[] paramsValues = {sid};
        String[] fields = {"staffid", "firstname", "lastname", "othernames"};
        String where = "WHERE staffid=:staffid";
        List<Object[]> staffObj = (List<Object[]>) genericClassService.fetchRecord(Searchstaff.class, fields, where, params, paramsValues);
        if (staffObj != null) {
            if (staffObj.get(0)[3] != " ") {
                names = (String) staffObj.get(0)[2] + " " + (String) staffObj.get(0)[1] + " " + (String) staffObj.get(0)[3];
            } else {
                names = (String) staffObj.get(0)[2] + " " + (String) staffObj.get(0)[1];
            }
        }
        return names;
    }

    @RequestMapping(value = "/createbatchSchedule")
    public @ResponseBody
    String createbatchSchedule(HttpServletRequest request, Model model) {
        ObjectMapper mapper = new ObjectMapper();
        String msg = "";
        if (request.getSession().getAttribute("sessionActiveLoginFacilityUnit") == null) {
            msg = "refresh";
        }
        BigInteger facilityunitid = BigInteger.valueOf(Long.parseLong(String.valueOf((int) request.getSession().getAttribute("sessionActiveLoginFacilityUnit"))));
        List<Map> stafffacilityList = new ArrayList<>();
        Map<String, Object> stafffacilityMap = null;
        boolean status = true;
        String[] params = {"facilityunitid", "active"};
        Object[] paramsValues = {facilityunitid, status};
        String[] fields = {"staffid", "facilityunitid"};
        String where = "WHERE facilityunitid=:facilityunitid AND active=:active";
        List<Object[]> facUnitObj = (List<Object[]>) genericClassService.fetchRecord(Stafffacilityunit.class, fields, where, params, paramsValues);
        if (facUnitObj != null) {
            for (Object[] x : facUnitObj) {
                stafffacilityMap = new HashMap();
                stafffacilityMap.put("staffid", x[0]);
                stafffacilityMap.put("StaffName", staffname(BigInteger.valueOf(Long.parseLong(String.valueOf(x[0])))));
                stafffacilityList.add(stafffacilityMap);
            }
        }
        model.addAttribute("staffvmember", stafffacilityMap);
        model.addAttribute("staffmembers", stafffacilityList);
        System.out.println("-----------------" + stafffacilityList);
        String input = "20181231";
        String format = "yyyyMMdd";

        SimpleDateFormat df = new SimpleDateFormat(format);
        Date date;
        try {
            date = df.parse(input);
            Calendar cal = Calendar.getInstance();
            cal.setTime(date);
            int week = cal.get(Calendar.WEEK_OF_YEAR);
            System.out.println("----------------"+week);
        } catch (ParseException ex) {
            System.out.println(ex);
        }


        return msg;
    }

    public Object[] serviceAllList(BigInteger facilityunitid) {
        List<Map> serviceObjList = new ArrayList<>();
        Map<String, Object> serviceObjMap;
        int count = 0;
        String[] params = {"facilityunitid"};
        Object[] paramsValues = {facilityunitid};
        String[] fields = {"serviceid", "servicename", "servicedayplanid", "servicedayid", "desiredstaff", "starttime", "endtime", "staffserviceid", "staffid", "workinghours"};
        String where = "WHERE facilityunitid=:facilityunitid";
        List<Object[]> serviceObj = (List<Object[]>) genericClassService.fetchRecord(Batchstaffschedules.class, fields, where, params, paramsValues);
        if (serviceObj != null) {
            count += serviceObj.size();
            for (Object[] x : serviceObj) {
                serviceObjMap = new HashMap();
                serviceObjMap.put("serviceid", x[0]);
                serviceObjMap.put("servicename", x[1]);
                serviceObjMap.put("servicedayplanid", x[2]);
                serviceObjMap.put("servicedayid", x[3]);
                serviceObjMap.put("desiredstaff", x[4]);
                serviceObjMap.put("starttime", x[5]);
                serviceObjMap.put("endtime", x[6]);
                serviceObjMap.put("staffserviceid", x[7]);
                serviceObjMap.put("staffid", x[8]);
                serviceObjMap.put("workinghours", x[9]);
                serviceObjList.add(serviceObjMap);
            }
        }
        //System.out.println("~~~~~~~~~~~~~~~~~~"+serviceObjList);
        return new Object[]{serviceObjList, count};
    }
}
