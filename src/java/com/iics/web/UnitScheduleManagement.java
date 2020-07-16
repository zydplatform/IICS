/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iics.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iics.controlpanel.Facilityschedule;
import com.iics.controlpanel.Facilityunitschedule;
import com.iics.controlpanel.Facilityunitsupplier;
import com.iics.controlpanel.Facilityunitsupplierschedule;
import com.iics.controlpanel.Schedule;
import com.iics.domain.Facilityunit;
import com.iics.service.GenericClassService;
import java.io.IOException;
import java.math.BigInteger;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author RESEARCH
 */
@Controller
@RequestMapping("/unitschedulemanagement")
public class UnitScheduleManagement {

    @Autowired
    GenericClassService genericClassService;
    DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");

    @RequestMapping(value = "/unitschedulemanagementhome.htm", method = RequestMethod.GET)
    public String UnitScheduleManagementHome(Model model, HttpServletRequest request) {
        List<Map> facilityscheduleslist = new ArrayList<>();

        List<String> days = Arrays.asList("MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATURDAY", "SUNDAY");

        Set<Integer> unitscheduledays = new HashSet<>();
        String[] params2 = {"facilityunitid"};
        Object[] paramsValues2 = {request.getSession().getAttribute("sessionActiveLoginFacilityUnit")};
        String[] fields2 = {"scheduleid"};
        List<Integer> facilityunitschedules = (List<Integer>) genericClassService.fetchRecord(Facilityunitschedule.class, fields2, "WHERE facilityunitid=:facilityunitid", params2, paramsValues2);
        if (facilityunitschedules != null) {
            for (Integer facilityunitschedule : facilityunitschedules) {
                unitscheduledays.add(facilityunitschedule);
            }
        }

        String[] params1 = {};
        Object[] paramsValues1 = {};
        String[] fields1 = {"scheduleid", "scheduledayname", "abbreviation"};
        List<Object[]> workingdays = (List<Object[]>) genericClassService.fetchRecord(Schedule.class, fields1, "", params1, paramsValues1);
        if (workingdays == null) {
            for (String day : days) {
                Schedule workday1 = new Schedule();
                workday1.setAbbreviation(day.substring(0, 3));
                workday1.setAddedby((Long) request.getSession().getAttribute("person_id"));
                workday1.setDateadded(new Date());
                workday1.setScheduledayname(day);
                genericClassService.saveOrUpdateRecordLoadObject(workday1);
            }
            String[] params = {};
            Object[] paramsValues = {};
            String[] fields = {"scheduleid", "scheduledayname", "abbreviation"};
            List<Object[]> facilityschedules = (List<Object[]>) genericClassService.fetchRecord(Schedule.class, fields, "", params, paramsValues);
            if (facilityschedules != null) {
                Map<String, Object> facilityschedulesRow;
                for (Object[] facilityschedule : facilityschedules) {
                    facilityschedulesRow = new HashMap<>();
                    if (!unitscheduledays.isEmpty() && unitscheduledays.contains((Integer) facilityschedule[0])) {
                        facilityschedulesRow.put("assigned", true);
                    } else {
                        facilityschedulesRow.put("assigned", false);
                    }
                    facilityschedulesRow.put("scheduleid", facilityschedule[0]);
                    facilityschedulesRow.put("scheduledayname", facilityschedule[1]);
                    facilityschedulesRow.put("abbreviation", facilityschedule[2]);
                    facilityscheduleslist.add(facilityschedulesRow);
                }
            }

        } else {
            Map<String, Object> facilityschedulesRow;
            for (Object[] facilityschedule : workingdays) {
                facilityschedulesRow = new HashMap<>();

                if (!unitscheduledays.isEmpty() && unitscheduledays.contains((Integer) facilityschedule[0])) {
                    facilityschedulesRow.put("assigned", true);
                } else {
                    facilityschedulesRow.put("assigned", false);
                }
                facilityschedulesRow.put("scheduleid", facilityschedule[0]);
                facilityschedulesRow.put("scheduledayname", facilityschedule[1]);
                facilityschedulesRow.put("abbreviation", facilityschedule[2]);
                facilityscheduleslist.add(facilityschedulesRow);
            }
        }
        model.addAttribute("facilityunitschedules", facilityscheduleslist);
        return "controlPanel/localSettingsPanel/supplierAndStores/unitSchedule/unitschedulemanagementhome";
    }

    @RequestMapping(value = "/checkedoruncheckedschedule.htm")
    public @ResponseBody
    String checkedoruncheckedschedule(HttpServletRequest request) {
        String response = "";
        if ("checked".equals(request.getParameter("type"))) {
            Facilityunitschedule facilityunitschedule = new Facilityunitschedule();
            facilityunitschedule.setScheduleid(Integer.parseInt(request.getParameter("scheduleid")));
            facilityunitschedule.setFacilityunitid(BigInteger.valueOf(Long.parseLong(String.valueOf((Integer) request.getSession().getAttribute("sessionActiveLoginFacilityUnit")))));
            genericClassService.saveOrUpdateRecordLoadObject(facilityunitschedule);
        } else {
            String[] params = {"scheduleid", "facilityunitid"};
            Object[] paramsValues = {Integer.parseInt(request.getParameter("scheduleid")), request.getSession().getAttribute("sessionActiveLoginFacilityUnit")};
            String[] fields = {"facilityunitscheduleid"};
            List<Long> facilityunitscheduleid = (List<Long>) genericClassService.fetchRecord(Facilityunitschedule.class, fields, "WHERE scheduleid=:scheduleid AND facilityunitid=:facilityunitid", params, paramsValues);
            if (facilityunitscheduleid != null) {
                
                String[] columns = {"facilityunitscheduleid"};
                Object[] columnValues = {facilityunitscheduleid.get(0)};
                int result = genericClassService.deleteRecordByByColumns("controlpanel.facilityunitschedule", columns, columnValues);
                if (result != 0) {
                }
            }
        }
        return response;
    }
}
